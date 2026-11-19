# TRD: GitHub-Verified Skills Recruitment Platform

Nov 18, 2026 · @hsbib

## 1. Scope and assumptions

This TRD specifies how to build the MVP defined in the PRD (P0 requirements F1 to F9, F12, F14, F16 to F19 and F22): a web application where candidates get GitHub-verified skills and recruiters search, post jobs and receive skill-matched applications.

**Technical principles**

- Verification runs asynchronously and is resumable; the web request never waits on GitHub.
- Every verification result stores its evidence and the rule version that produced it, so results are explainable and reproducible.
- Only public GitHub data is read, with a read-only token and explicit candidate consent.
- Matching and gating are deterministic code over stored verified skills; an LLM is used only for CV extraction, never for the apply decision.

**Assumptions**

- Web-first, responsive for low-bandwidth mobile browsers; no native apps in the MVP.
- Developer roles only, so GitHub is the single evidence source in the MVP.
- Pilot scale of hundreds of candidates and tens of recruiters; no capacity target beyond that is set yet.
- Team size and cloud budget are not yet fixed, so the stack favours managed services.

## 2. System architecture

&#91;embedded content: system architecture · 6 components, 2 external\]

The web app serves requests and enforces the apply gate; slow work (CV parsing and GitHub scanning) runs in the worker, fed by the queue.

## 3. Technology stack

The proposed stack uses one language for the web app and a separate Python worker for parsing and scanning. All choices are proposals for the team to confirm.

| Layer | Proposed choice | Why |
| --- | --- | --- |
| Frontend | Next.js (React, TypeScript), Tailwind CSS | Server rendering for fast loads on slow connections; one language with the API |
| API | Next.js route handlers or a Node (NestJS) service, REST with JSON | Simple, typed, easy to test; split out later if needed |
| Auth | Managed auth (email and password, GitHub OAuth), JWT sessions, role claims | Avoids building credential handling; GitHub OAuth supports candidate sign-in |
| Database | PostgreSQL | Relational data, joins for skill matching, JSONB for evidence, full-text search |
| Search | PostgreSQL indexes on verified-skill rows (MVP); a search engine later | Enough for pilot scale; avoids a second datastore |
| Queue and cache | Redis with a job queue library (BullMQ or Celery) | Resumable scan jobs, rate-limit handling, caching of GitHub responses |
| Worker | Python service | Strong libraries for CV parsing and code analysis |
| CV parsing | PDF and DOCX text extraction, then an LLM call to return structured skills as JSON | Handles varied CV layouts; output validated against the skill taxonomy |
| Code analysis | GitHub REST and GraphQL APIs; language detection from the API; manifest and import parsing | No need to clone full repositories for the MVP |
| File storage | Private object storage (S3-compatible) | CVs stored encrypted, accessed through signed URLs |
| Hosting | Managed container or platform hosting, with managed Postgres and Redis | Small team, low operations load |
| CI and CD | GitHub Actions | Tests, linting and deploys on every merge |
| Observability | Structured logs, error tracking, basic metrics and tracing | Needed to debug asynchronous scans |

## 4. Data model

The core model has thirteen tables; verified skills are stored as rows with their evidence, so search, matching and explanation all read from the same source.

| Table | Purpose | Key fields |
| --- | --- | --- |
| users | Account for any role | id, email, role (candidate, recruiter, admin), email\_verified, created\_at |
| candidate\_profiles | Candidate details | user\_id, name, headline, location, github\_username, consent\_scan\_at |
| recruiter\_profiles | Recruiter and company details | user\_id, company\_name, company\_site |
| cvs | Uploaded CV files | id, user\_id, storage\_key, parsed\_json, uploaded\_at |
| skills | Fixed skill taxonomy | id, name, aliases, category |
| claimed\_skills | Skills extracted from the CV | candidate\_id, skill\_id, source\_text, confirmed\_by\_candidate |
| github\_repos | Public repositories scanned | id, candidate\_id, github\_repo\_id, name, is\_fork, languages (JSONB), last\_scanned\_at |
| skill\_verifications | Result per candidate and skill | candidate\_id, skill\_id, status (verified, partial, not\_verified), confidence, rule\_version, scanned\_at |
| verification\_evidence | Evidence behind each result | verification\_id, repo\_id, evidence\_type, file\_path, authored\_lines, detail (JSONB) |
| jobs | Job posts | id, recruiter\_id, title, description, status, match\_mode, min\_match |
| job\_required\_skills | Skills a job requires | job\_id, skill\_id, required (true or false) |
| applications | Candidate applications | id, job\_id, candidate\_id, status, matched\_skills (JSONB), missing\_skills (JSONB), created\_at |
| audit\_log | Decision records | id, actor, action, subject, rule\_version, payload (JSONB), created\_at |

**Rules**

- `skill_verifications` has one current row per candidate and skill; earlier results move to history, not deleted, so decisions remain auditable.
- Search and the apply gate query only rows with `status = verified`.
- `applications` snapshots the matched and missing skills at apply time, so later re-scans do not rewrite history.
- Deleting a candidate removes CV files, repo data and verification rows; audit entries keep only a pseudonymous id.

## 5. Verification pipeline

&#91;embedded content: verification pipeline · 6 steps, 1 decision\]

The worker runs one job per candidate; a rate-limit pause resumes where it stopped instead of restarting the scan.

**GitHub API usage**

- List public repositories with `GET /users/{login}/repos`; skip forks unless the candidate has authored commits in them.
- Read languages with `GET /repos/{owner}/{repo}/languages`.
- Read dependency manifests and source files through the git tree and contents endpoints, sampling the largest authored files.
- Check authorship with `GET /repos/{owner}/{repo}/commits?author={login}`.
- Cache responses with ETags and check remaining quota before each batch.

**Scoring (proposed starting weights, to be calibrated on the labelled set)**

| Evidence | Weight |
| --- | --- |
| Authored source files that use the skill | 0.50 |
| Authored commits touching those files | 0.20 |
| Entry in a dependency manifest | 0.15 |
| Recent activity (last 24 months) | 0.10 |
| Skill found in more than one repository | 0.05 |

A skill is verified at a confidence of 0.60 or higher and partial from 0.30 to below 0.60; both cut-offs are starting values and need calibration. Repositories flagged as clones or trivial contribute no weight.

## 6. API design

The API is REST over HTTPS with JSON bodies, versioned under `/api/v1`. Roles are enforced on the server for every route; the apply gate is checked on the server, never only in the interface.

| Method and path | Role | Purpose |
| --- | --- | --- |
| POST /auth/signup, POST /auth/login | Public | Create an account; sign in |
| GET /auth/github/callback | Candidate | Complete GitHub OAuth and store a read-only token |
| PUT /me/profile | Any | Update basic profile information |
| POST /me/cv | Candidate | Upload a CV; starts parsing |
| GET /me/claimed-skills | Candidate | Review skills extracted from the CV |
| PUT /me/claimed-skills | Candidate | Confirm, edit or remove extracted skills |
| POST /me/github/consent | Candidate | Record consent to scan public repositories |
| POST /me/verification | Candidate | Start or re-run a verification job |
| GET /me/verification | Candidate | Job status and per-skill results with reasons |
| GET /candidates/{id} | Recruiter | Profile with verified skills and evidence |
| GET /candidates?skills=...&min\_confidence=... | Recruiter | Search by verified skills |
| POST /jobs | Recruiter | Create a job with required skills and match rule |
| PUT /jobs/{id}, DELETE /jobs/{id} | Recruiter (owner) | Edit, close or delete a job |
| GET /jobs, GET /jobs/{id} | Candidate, Recruiter | List and view open jobs |
| GET /jobs/{id}/eligibility | Candidate | Returns matched and missing required skills |
| POST /jobs/{id}/apply | Candidate | Apply; rejected with the missing skills if the gate fails |
| GET /jobs/{id}/applications | Recruiter (owner) | Applicants with matched and missing skills |
| DELETE /me | Any | Delete account and data |

**Conventions**

- Errors use one JSON shape with a code and a message; a gate failure returns 403 with `missing_skills`.
- List endpoints are paginated; search results are capped per page.
- Search and sign-up are rate limited per user and per IP.
- Verification is asynchronous: `POST /me/verification` returns a job id and the status is polled (or pushed) from `GET /me/verification`.

## 7. Security, privacy and compliance

The main exposures are candidate CVs, GitHub tokens and the integrity of the verification result.

| Control | Implementation |
| --- | --- |
| Authentication | Managed auth with email verification; short-lived JWTs with refresh; GitHub OAuth for candidates |
| Authorisation | Role checks on every route; recruiters can edit only their own jobs; candidates can read only their own CV and results |
| GitHub access | Read-only, public-data scopes only; tokens encrypted at rest and revocable by the candidate |
| CV storage | Private bucket, server-side encryption, access through short-lived signed URLs; virus scan on upload |
| Contact details | Email and phone hidden from recruiters until the candidate applies |
| Transport and data | TLS everywhere; encryption at rest for database and backups |
| LLM use for CV parsing | Mask names, emails, phone numbers and addresses before the call; use a provider and plan that does not train on submitted data; validate output against a JSON schema and the skill taxonomy |
| Fairness | Name, gender, photo, age and location are never inputs to verification or matching; periodic review of results across candidate groups |
| Integrity of results | Verification rules versioned; every decision written to the audit log with its evidence; only the worker service can write verification rows |
| Anti-abuse | Rate limits, fork and clone detection, anomaly flags for review (see section 5) |
| Data rights | Consent record with timestamp; export and delete endpoints; retention limit for CVs and scan data after account deletion |
| Application security | Input validation, upload type and size limits, dependency scanning in CI, secrets in a managed vault |

**Compliance.** Bangladesh's data protection rules and any rules of the markets where recruiters or candidates operate need legal review before launch; this TRD does not assume which regime applies.

## 8. Infrastructure, deployment and testing

**Environments.** Local, staging and production, each with its own database, bucket and GitHub OAuth app. Staging uses synthetic or consented sample profiles only.

**Deployment.** Web app and worker ship as separate containers from one repository through GitHub Actions: lint and tests on every pull request, automatic deploy to staging on merge, manual approval to production. Database changes use versioned migrations with a rollback step.

**Observability**

- Structured logs with a request id and a verification job id on every line.
- Metrics: scan duration, queue depth, GitHub API calls and remaining rate limit, verification status counts, apply-gate rejections.
- Alerts on failed jobs, queue backlog and error-rate spikes.

**Backups.** Daily database backups with a tested restore; bucket versioning for CVs.

**Testing**

| Level | What it covers |
| --- | --- |
| Unit | Skill normalisation, evidence scoring rules, match-rule logic |
| Integration | CV upload to claimed skills; scan of recorded GitHub responses to verification rows; apply gate by role |
| Verification quality | A labelled set of 30 to 50 candidate profiles with reviewer-confirmed skills; report precision and recall per rule version before any rule change ships |
| End to end | Sign-up, CV, GitHub link, verified profile, recruiter search, job post, gated apply |
| Security | Access-control tests for every role, upload abuse cases, dependency and secret scanning |
| Load | Simulated concurrent scans to confirm the queue and GitHub rate-limit handling at pilot scale |

**Definition of done for the MVP:** all P0 PRD requirements pass end-to-end tests, verification precision meets the PRD target on the labelled set, and the privacy controls in section 7 are in place.

## 9. Technical risks and open questions

The largest technical risk is verification quality: wrong results either block qualified candidates or let inflated skills through.

| Risk | Impact | Mitigation |
| --- | --- | --- |
| GitHub API rate limits (authenticated requests are capped per hour) slow scans of large profiles | Long verification times | Queue with backoff, conditional requests and caching, scan most recent and largest repositories first, resume after reset |
| Detecting skills from manifests and file types misses frameworks used without a listed dependency | False negatives | Combine manifests, file extensions and import statements; tune on the labelled set |
| Authorship is hard to prove for squashed, imported or pair-programmed commits | Wrong credit | Count only commits by the linked account; flag low-authorship repositories for review |
| LLM CV extraction returns wrong or invented skills | Bad claims enter the pipeline | JSON schema validation, taxonomy match, and candidate confirmation before scanning |
| Skill taxonomy is incomplete | Skills cannot be matched or required | Start with a curated list for common developer skills; admin process to add and alias skills |
| Hard apply-gate (PRD section 9) rejects eligible candidates | Lost candidates | Keep the gate as a server-side policy flag per job so it can change from block to ranking without a rewrite |
| Rule changes alter past results | Inconsistent decisions | Version rules; re-run on demand; store the version on each result |

**Open questions**

- [ ] Which hosting provider and region, given data residency and latency for users in Bangladesh?
- [ ] Which LLM provider and model handle CV extraction, and what is the monthly cost cap?
- [ ] Do we clone repositories for deeper analysis, or stay on API-only access in the MVP?
- [ ] What confidence threshold marks a skill as verified, and who owns changes to it?
- [ ] Is candidate sign-in with GitHub required, or optional alongside email and password?
- [ ] What is the target maximum scan time per profile, and the maximum number of repositories scanned?
- [ ] Which data protection regime applies at launch, and does it require local data storage?

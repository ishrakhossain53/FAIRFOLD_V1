# PRD: GitHub-Verified Skills Recruitment Platform

Nov 16, 2026 · @hsbib

## 1. Overview

The platform lets job seekers prove their skills with evidence from their own GitHub work, and lets recruiters search and hire on those proven skills instead of self-reported CV claims.

**Problem.** CVs are easy to inflate and slow to check. Recruiters screen large applicant pools on unverified claims, and candidates with real project work have no standard way to show it.

**Solution.** A candidate signs up, uploads a CV and links GitHub. The system extracts skills from the CV, scans the candidate's public repositories for matching evidence, and displays only the confirmed skills as "verified skills" on the profile. Recruiters search by verified skills and post jobs with required skills, and applications are matched against those requirements.

**Product principle.** Every verified skill must show the evidence behind it (repositories, files, commits), so a recruiter can check it and a candidate can understand and dispute it.

## 2. Goals, non-goals and success metrics

The MVP succeeds if a candidate can reach a verified profile in one sitting and a recruiter can find and trust a match from it.

**Goals**

- Turn a CV and a GitHub link into a verified-skills profile with visible evidence for each skill.
- Let recruiters search candidates by verified skills.
- Let recruiters post jobs with required skills and receive applications matched to them.
- Show candidates why a skill was or was not verified.

**Non-goals (MVP)**

- Verifying non-technical skills (design, sales, operations).
- Private repositories, other code hosts (GitLab, Bitbucket) and employer-verified work history.
- Automated hiring decisions: recruiters make the final call.
- Interview scheduling, assessments and payments.

**Success metrics** (targets are proposed and need team sign-off)

| Metric | Definition | Proposed target |
| --- | --- | --- |
| Profile completion | Share of sign-ups that finish CV upload and GitHub link | 60% |
| Verification time | Median time from GitHub link to verified profile | under 3 minutes |
| Verification precision | Share of sampled verified skills a reviewer agrees are real | 90% or higher |
| Verification recall | Share of sampled real skills the system verifies | tracked, no target until baseline |
| Recruiter search success | Searches that lead to a profile view | 50% |
| Dispute rate | Verified or unverified skills a candidate disputes | tracked, reviewed weekly |

## 3. Target users

The MVP serves two roles: software developers who want credit for real project work, and recruiters hiring for technical roles.

| Persona | Who they are | Need | What they fear |
| --- | --- | --- | --- |
| Job seeker (developer) | Student, fresher or early-career developer with public GitHub projects | A way to show real skills that a CV alone cannot convey | Being rejected because the system misses their work |
| Recruiter | In-house or agency recruiter hiring developers | Shortlist candidates fast and trust the skills listed | Wasting time on inflated CVs |
| Admin | Platform operator | Monitor verification quality, handle disputes and abuse | Gaming of the verification system |

The initial market is assumed to be developers in Bangladesh and similar emerging markets. This assumption needs validation through interviews with recruiters and candidates before launch.

## 4. User flow

&#91;embedded content: user flow · 2 lanes, 1 gate\]

A candidate verifies once at the top; recruiters search and post jobs below, and the gate decides who can apply.

## 5. Functional requirements

P0 items are required for the MVP, P1 items follow shortly after launch, and P2 items are later.

### Accounts and onboarding

| ID | Requirement | Priority | Acceptance criteria |
| --- | --- | --- | --- |
| F1 | Sign up and log in as a candidate or a recruiter with email and password | P0 | Account is created with a role; email is verified before use |
| F2 | Collect basic information at sign-up (name, email, role; company for recruiters) | P0 | Required fields are validated; profile is editable later |
| F3 | Social sign-in with GitHub for candidates | P1 | GitHub login also links the account for verification |

### Candidate profile and verification

| ID | Requirement | Priority | Acceptance criteria |
| --- | --- | --- | --- |
| F4 | Upload a CV (PDF or DOCX) | P0 | File type and size are validated; the file is stored privately |
| F5 | Link a GitHub profile with explicit consent to scan public repositories | P0 | Candidate sees what will be scanned and can revoke access |
| F6 | Extract skills and key details from the CV (skills, roles, education, experience) | P0 | Extracted data is shown for the candidate to review and correct |
| F7 | Scan public repositories and cross-check each CV skill against code evidence | P0 | Each skill gets a status and a confidence level (see section 6) |
| F8 | Display only verified skills in a "Verified skills" section of the profile | P0 | Each verified skill links to its evidence (repos, files, languages) |
| F9 | Show the candidate which skills were not verified and why | P0 | Unverified skills are visible to the candidate only, with a reason |
| F10 | Re-run verification on demand and when new commits arrive | P1 | Candidate can trigger a re-scan; status updates within the target time |
| F11 | Candidate can dispute an unverified skill and attach extra evidence | P1 | Dispute is queued for admin or reviewer decision |

### Recruiter talent search

| ID | Requirement | Priority | Acceptance criteria |
| --- | --- | --- | --- |
| F12 | Search candidates by one or more verified skills | P0 | Results include only candidates with those skills verified |
| F13 | Filter results by confidence level, experience and location | P1 | Filters combine and update results without a page reload |
| F14 | View a candidate profile with evidence for each verified skill | P0 | Evidence is visible without leaving the profile |
| F15 | Save candidates and shortlists | P2 | Recruiter can save and group candidates |

### Jobs and applications

| ID | Requirement | Priority | Acceptance criteria |
| --- | --- | --- | --- |
| F16 | Recruiter creates, edits, closes and deletes job posts with required skills | P0 | Job has title, description, required skills and optional nice-to-have skills |
| F17 | Only candidates whose verified skills match the job's required skills can apply | P0 | Apply button is enabled only on a match; otherwise the candidate sees which required skills are missing |
| F18 | Define what counts as a match (all required skills, or a minimum number) | P0 | Rule is set per job and shown to candidates before applying |
| F19 | Recruiter reviews applicants with each applicant's verified-skill match shown | P0 | Applicants are listed with matched and missing skills |
| F20 | Application status updates visible to candidates | P1 | Candidate sees submitted, reviewed, shortlisted or rejected |

### Admin

| ID | Requirement | Priority | Acceptance criteria |
| --- | --- | --- | --- |
| F21 | Admin dashboard for users, jobs and verification results | P1 | Admin can view and suspend accounts and review disputes |
| F22 | Audit log of verification decisions | P0 | Each decision records the evidence and rule version used |

## 6. Skill verification engine

A skill is verified only when the candidate's own public code shows it, and every verified skill carries the evidence that produced it.

**Pipeline**

1. Parse the CV and extract a list of claimed skills, normalised to a fixed skill taxonomy (for example, "ReactJS" and "React.js" map to React).
2. Fetch the candidate's public repositories through the GitHub API, with consent.
3. Collect evidence per repository: languages, dependency manifests (package.json, requirements.txt, pubspec.yaml and similar), config and build files, and source files.
4. Match each claimed skill to evidence and compute a confidence level.
5. Store the result with its evidence and the rule version, then publish verified skills to the profile.

**Evidence rules (proposed starting point, to be tuned on real data)**

| Rule | Treatment |
| --- | --- |
| Forked repositories | Excluded unless the candidate has authored commits in them |
| Authorship | Only code and commits authored by the linked account count |
| Dependency listed only | Weak evidence on its own; needs source files that use it |
| Source files using the skill | Strong evidence; count files and lines of authored code |
| Recency | Recent activity raises confidence; old-only usage lowers it |
| Tutorial or template clones | Flagged and down-weighted (for example, repositories with near-identical content to common starters) |
| Trivial repositories | Very small or empty repositories do not count alone |

**Output per skill**

| Status | Meaning | Shown to |
| --- | --- | --- |
| Verified | Confidence at or above the threshold | Everyone, with evidence |
| Partial | Some evidence, below threshold | Candidate, and recruiters only if the candidate allows |
| Not verified | No usable evidence found | Candidate only, with a reason |

**Limits to state in the product.** Verification confirms that code using a skill exists in the candidate's public work. It does not measure depth of expertise. Skills such as SQL, system design, Figma or project management may not leave GitHub evidence, and the profile must say so rather than treat them as false.

## 7. Non-functional requirements

| Area | Requirement |
| --- | --- |
| Privacy and consent | Scan only public repositories, only after explicit consent; candidate can revoke GitHub access and delete data at any time |
| Data protection | CVs stored privately and encrypted at rest; contact details hidden from recruiters until the candidate applies |
| Security | Store GitHub tokens encrypted with read-only scopes; role-based access; rate limiting on search and sign-up |
| Explainability | Every verified or unverified status shows the evidence and the rule that produced it |
| Fairness | Do not use name, gender, photo, age or location as verification inputs; review results across candidate groups for systematic gaps |
| Anti-gaming | Detect forks, copied repositories, bulk-created trivial repositories and sudden activity spikes; flag for review instead of silently rejecting |
| Performance | Verification of a typical profile completes within the target in section 2; GitHub API rate limits handled with queued, resumable jobs |
| Reliability | A failed or partial scan never removes previously verified skills; the candidate sees the scan status |
| Auditability | Verification decisions and job-match decisions are logged with the rule version |
| Accessibility and cost | Works on low-bandwidth connections and mobile browsers, given the initial market |

## 8. MVP scope and milestones

The MVP is the P0 set from section 5: the full flow from sign-up to a skill-matched application, for developer roles only. Durations below are proposed and depend on team size, which is not yet set.

| Phase | Scope | Exit criteria | Proposed duration |
| --- | --- | --- | --- |
| 0. Validation | Interview recruiters and candidates; collect 30 to 50 sample profiles to test verification | Verification precision measured on the sample; apply-gate decision made (section 9) | 2 weeks |
| 1. Foundations | Accounts, roles, CV upload, GitHub consent and linking, job posts | A candidate can sign up, upload a CV and link GitHub | 3 weeks |
| 2. Verification engine | CV extraction, repository scanning, evidence rules, confidence scoring, evidence display | Precision target met on the sample set | 4 weeks |
| 3. Recruiter and apply flow | Talent search, match rule per job, apply gating, applicant review | End-to-end flow works with test users | 3 weeks |
| 4. Hardening and pilot | Privacy review, rate limits, audit log, pilot with a small group of recruiters and candidates | Pilot feedback reviewed; metrics in section 2 reported | 3 weeks |

**Later (P1 and P2):** GitHub sign-in, re-verification on new commits, disputes, filters, shortlists, admin dashboard, and additional evidence sources such as deployed projects, certificates and assessments.

## 9. Risks and open questions

The largest risk is the hard apply-gate: a false negative in verification blocks a qualified candidate from applying.

| Risk | Impact | Mitigation |
| --- | --- | --- |
| Hard apply-gate rejects strong candidates with thin or private GitHub history | Qualified candidates lost; recruiters see a smaller pool | Let recruiters choose gate strictness per job; add other evidence sources; allow disputes (F11) |
| Skill present in code but not real proficiency (copied, forked or tutorial code) | Inflated verified skills; recruiter trust drops | Authorship checks, fork exclusion, clone detection, show evidence |
| Gaming by padding repositories | Verified badge loses meaning | Anomaly detection, activity recency, manual review of flags |
| Skills with no GitHub footprint (SQL, design, soft skills) | Product unusable for non-developer roles | Limit MVP to developer roles; plan extra evidence sources |
| Privacy or consent complaints about repository scanning | Legal and reputational harm | Explicit consent, public data only, revocation and deletion |
| GitHub API rate limits and scan cost | Slow verification, high cost | Queued jobs, caching, incremental re-scans |
| Skill extraction errors from varied CV formats | Wrong claims enter the pipeline | Show extracted skills for candidate review before verification |

**Open questions**

- [ ] Should the apply-gate stay a hard block, or become a recruiter-set option per job (strict, or verified skills shown as a ranking signal)? The current spec assumes a hard block with a visible reason and a dispute path.
- [ ] What counts as a match: all required skills, or a minimum share? (F18 assumes it is set per job.)
- [ ] Which confidence threshold makes a skill "verified", and who tunes it?
- [ ] Is the first market developers in Bangladesh only, or any region?
- [ ] Which languages and frameworks are in the first skill taxonomy?
- [ ] Which LLM or parsing approach is used for CV extraction, and how is candidate data protected when sent to it?
- [ ] Is a human reviewer needed for disputes at launch, and who staffs it?
- [ ] Who are the product owner and engineering lead? (Needed to assign the success metrics.)

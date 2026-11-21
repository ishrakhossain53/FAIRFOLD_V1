# Data model

Thirteen tables. `[schema.sql](schema.sql)` is the source of truth for columns and constraints; this file explains the rules the columns cannot express.

## Tables and ownership

| Table | Purpose | Written by |
| --- | --- | --- |
| `users` | Any account, with a role | Web app |
| `candidate_profiles` | Candidate details, GitHub link, consent timestamp | Web app |
| `recruiter_profiles` | Company details | Web app |
| `cvs` | CV file metadata and parsed output | Web app (row), worker (`parsed_json`) |
| `skills` | Fixed taxonomy, seeded from `product/SKILL_TAXONOMY.csv` | Seed import / admin |
| `claimed_skills` | Skills extracted from the CV, and candidate confirmation | Web app |
| `github_repos` | Public repositories scanned, with flags | Worker |
| `skill_verifications` | Current and historical result per candidate and skill | Worker |
| `verification_evidence` | Repos, files, lines behind each result | Worker |
| `jobs` | Job posts with match rule and gate policy | Web app |
| `job_required_skills` | Required and nice-to-have skills per job | Web app |
| `applications` | Applications with skills snapshotted at apply time | Web app |

**Single-writer rule.** Only the worker writes `github_repos`, `skill_verifications` and `verification_evidence`. Only the web app writes everything else. Enforce it with separate database roles once deployment exists; until then it is a review rule.

## Invariants

1. **One current verification per candidate and skill.** `skill_verifications.superseded_at is null` is unique per `(candidate_id, skill_id)`. A re-scan sets `superseded_at` on the old row and inserts a new one — results are never overwritten in place, so every historical decision stays inspectable.
2. **Search and gating read verified rows only.** `status = 'verified' and superseded_at is null`, served by `skill_verifications_search_idx`. Nothing else may be used as the source of a match.
3. **Applications never drift.** `matched_skills` and `missing_skills` are JSONB snapshots taken at apply time and are never recomputed after a re-scan.
4. **Nothing unconfirmed reaches verification.** The worker only reads `claimed_skills` where `confirmed_by_candidate` is true. A bad CV extraction cannot become a false verification claim.
5. **Consent precedes scanning.** No scan job is enqueued while `candidate_profiles.consent_scan_at` is null.
6. **Deletion removes personal data, keeps the decision record.** Deleting a user cascades to profiles, CVs, repos, verifications and evidence. `audit_log` survives, holding only `actor_pseudonym` and no personal fields.
7. **Skills are data, not code.** A skill exists only if it is a `skills` row; `claimed_skills`, `job_required_skills` and `skill_verifications` all reference it by slug.
8. **The GitHub link is the numeric id, not the login.** `candidate_profiles.github_user_id` is unique, and a scan or OAuth callback matches on it. The login is stored for display only: a renamed account keeps its link, and nobody can register a vacated login to inherit a profile's verification.
9. **Deleting an account purges stored objects before the rows.** CV bytes live outside Postgres, so the web app deletes every `cvs.storage_key` from the bucket first and deletes the user only afterwards. A cascade on its own would leave the files behind with no key left to find them.
10. **The reason for a status is stored, not recomputed.** `skill_verifications.reason` holds the candidate-facing explanation for `partial` and `not_verified` results, because the evidence rows alone do not say what was missing.

## Indexing

| Index | Serves |
| --- | --- |
| `skill_verifications_search_idx` | Recruiter search and the eligibility check |
| `skill_verifications_current_key` | "This candidate's verified skill set" as one cheap read |
| `applications_job_idx` | Applicant lists, newest first |
| `applications_candidate_idx` | A candidate's own application history |
| `github_repos_candidate_idx` | Scan resume after a rate-limit pause |
| `cvs_user_idx` | Latest CV per candidate |
| `jobs_open_idx` | Public job list |
| `audit_log_subject_idx` | Admin lookups by subject |

No GIN index on `audit_log.payload` until an admin query actually needs it.

## Deliberate choices

- **Superseded rows instead of a history table.** One table with `superseded_at` and a partial unique index gives both "one current row" and full history without a second table or a join.
- **Text slugs as skill ids.** Stable across taxonomy edits and human-readable in seed data and logs.
- **`skills.github_signal`.** Lets the product show "not confirmable from GitHub" for `none` skills rather than "not verified", which the PRD requires.
- **`jobs.enforce_gate`.** Keeps decision D1 open: the same schema supports a hard block and a ranking signal without a migration.

## Not modelled yet

Interview scheduling, saved candidates and shortlists (P2), email verification tokens, and refresh tokens. Add them when the feature lands, not before.

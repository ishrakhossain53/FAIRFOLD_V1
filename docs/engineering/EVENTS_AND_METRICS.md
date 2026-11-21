# Events and metrics

How each PRD §2 metric is computed, and the rows it reads. The PRD owns the definitions and targets; this file owns the query.

| Metric | Computation | Source |
| --- | --- | --- |
| Profile completion | Candidates with a `cvs` row and `candidate_profiles.consent_scan_at is not null` ÷ candidates with a `users` row of role `candidate` | `users`, `cvs`, `candidate_profiles` |
| Verification time | `scanned_at` of the candidate's first `verified` row − `candidate_profiles.consent_scan_at`; median and p90 | `skill_verifications`, `candidate_profiles` |
| Verification precision | Reviewer-confirmed skills ÷ sampled skills marked verified, per `rule_version` | Labelled set, see [../testing/LABELLED_SET.md](../testing/LABELLED_SET.md) |
| Verification recall | Reviewer-confirmed real skills the system verified ÷ all reviewer-confirmed real skills | Labelled set |
| Recruiter search success | Searches followed by a `GET /candidates/{id}` view within the session ÷ searches | Web access log + app event |
| Dispute rate | Disputes opened ÷ (verified + not-verified skills shown to a candidate), weekly | Dispute rows (P1) |

## Events to log

Log these as structured lines with `request_id` and, where relevant, `verification_job_id`. Only the first four need a table; the rest are for the log/metrics pipeline.

| Event | Fields | Purpose |
| --- | --- | --- |
| `verification.started` | candidate_id, rule_version, trigger (first / manual / new_commits) | Latency start |
| `verification.completed` | candidate_id, rule_version, duration_ms, counts by status | Latency and quality trends |
| `verification.failed` | candidate_id, stage, error class, attempt | Alerting |
| `apply.rejected_by_gate` | job_id, candidate_id, missing_skill_count | Gate-driven candidate loss (PRD risk §9) |
| `apply.succeeded` | job_id, candidate_id | Funnel |
| `search.performed` | recruiter_id, skill_ids, result_count | Search success |
| `candidate.viewed` | recruiter_id, candidate_id, source (search / shortlist) | Search success |
| `github.ratelimit` | remaining, reset_at, endpoint | Quota pressure |
| `scan.paused` | candidate_id, repos_done, repos_total | Resume behaviour |

## Rules

- No personal data in event fields: ids only, never names, emails or CV text.
- Anything used for a PRD target must be derivable from stored rows, not only from logs — logs expire, targets are reported every week.
- Report precision and recall **per rule version**; a blended number hides a regression.

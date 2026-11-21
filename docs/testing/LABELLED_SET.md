# Labelled set and verification quality

The labelled set is how "verified" earns trust: 30–50 candidate profiles whose real skills a human has confirmed, used to measure precision and recall before any rule version ships.

## What lives in the repo and what does not

| Item | Where |
| --- | --- |
| This protocol, the reviewer rubric, the score-report format | In the repo |
| Profile fixtures, reviewer notes, GitHub snapshots | **Not in the repo.** Private bucket, access limited to the reviewers and the engineering lead |

Real CVs and real GitHub accounts are personal data. Nothing that identifies a person is committed, and synthetic profiles are not a substitute for the real variety the set exists to measure.

## Building the set

1. Recruit 30–50 profiles across the MVP's range: student, 1–3 years, 4+ years, thin GitHub history, heavy GitHub history, tutorial-only history.
2. For each profile, collect the CV text and a snapshot of the public repositories (metadata, manifests, sampled files) so the run is reproducible after the repositories change.
3. Two reviewers independently list the skills they consider real, with the repository or file that proves each one. Disagreements are resolved by a third reviewer or dropped.
4. Store the agreed list as `expected_skills` per profile.

## Score report

For one rule version, over all profiles:

| Field | Definition |
| --- | --- |
| `precision` | Reviewer-confirmed skills marked verified ÷ all skills marked verified |
| `recall` | Reviewer-confirmed skills marked verified ÷ all reviewer-confirmed skills |
| `false_verified` | Verified skills a reviewer rejects — the number that erodes recruiter trust |
| `false_negative` | Real skills marked not-verified — the number that blocks candidates via the gate |
| `per_skill` | The same counts grouped by skill id, to find rules that fail for one technology |

Report precision and recall **per rule version and per skill**, never as a single blended number. Averages hide the failure that matters: one popular skill that never verifies.

## Before shipping a rule change

1. Run the old and new rule versions over the same snapshots.
2. Compare `precision`, `recall` and `false_verified`.
3. Ship only if precision does not regress and `false_verified` does not rise. Otherwise record the result and keep the current version.
4. Record the outcome in an ADR and update `engineering/VERIFICATION_RULES.md` with the new version.

## Open

- Reviewer staffing and compensation are undecided (decision D10 covers disputes, not this).
- Target recall is tracked with no threshold until a baseline exists (PRD §2).

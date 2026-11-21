# Test plan

What is tested, at which level, and what has to pass before each milestone closes. No test code exists yet — this is the plan the first pull request implements.

## Levels

| Level | Covers | Runs on |
| --- | --- | --- |
| Unit | Skill normalisation and aliases, evidence scoring per rule version, match/gate function, PII masking | Every PR |
| Integration | CV upload → parsed claims (recorded LLM response); recorded GitHub responses → verification rows + evidence; role checks on every route | Every PR |
| Contract | `openapi.yaml` validates the implemented routes; schema drift fails the build | Every PR |
| Verification quality | Labelled set scored per rule version; precision and recall reported | Every rule change, before release |
| End to end | Sign-up → email verification → CV → GitHub link → verified profile → recruiter search → job post → gated apply → applicant review | Merge to staging |
| Security | Access control per role (candidate cannot read another CV, recruiter cannot edit another's job), upload abuse, dependency and secret scanning | Every PR (scan), weekly (authz matrix) |
| Load | Simulated concurrent scans; queue depth and GitHub rate-limit behaviour at pilot scale | Before the pilot |

## External dependencies in tests

GitHub and the LLM are never called in CI. Recorded fixtures only. The same fixture must reproduce the same verification rows for a given rule version, which is also how determinism is checked.

## Gates per milestone (PRD §8)

| Milestone | Exit gate |
| --- | --- |
| 1. Foundations | Auth, CV upload, consent and job-post integration tests pass; upload rejection cases covered |
| 2. Verification engine | Precision ≥ target on the labelled set for the shipping rule version; determinism test green |
| 3. Recruiter and apply flow | End-to-end flow green for all three roles; gate rejection returns 403 with `missing_skills` |
| 4. Hardening and pilot | Authz matrix green for every route; load test at pilot scale; restore drill completed |

## Definition of done (MVP)

All P0 PRD requirements pass end-to-end tests, verification precision meets the target on the labelled set, and the privacy controls in `legal/CONSENT_AND_PRIVACY.md` and TRD §7 are in place (TRD §8).

## Rules

- A bug fix ships with the test that would have caught it.
- Do not weaken an assertion to make a build pass; fix the cause.
- Verification results are compared per `rule_version`; a blended run hides a regression.
- Uploads, CV text and reviewer notes never go into fixtures. Use synthetic profiles.

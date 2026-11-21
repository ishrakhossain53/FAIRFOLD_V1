# Product copy

Canonical interface strings. Use these in code and screens so the same state never reads two ways. Longer consent text is in [../legal/CONSENT_AND_PRIVACY.md](../legal/CONSENT_AND_PRIVACY.md).

## Tone

Plain, calm, never blaming. Say "Not verified yet", never "Rejected", "Failed" or "Fake". Always show a next step. Language is English until Bangla support is decided (D18).

## Skill status

| State | Label | Helper text |
| --- | --- | --- |
| verified | Verified | Confirmed in your public code — see the evidence |
| partial | Partly confirmed | Some evidence found, below the threshold we require |
| not_verified | Not verified yet | No matching code found in your public repositories |
| none signal | Cannot be checked from GitHub | This skill usually does not appear in code |

## Apply gate

| Situation | Copy |
| --- | --- |
| Eligible | You can apply — your verified skills meet this job's requirements |
| Blocked | You cannot apply yet. Verified skills needed: {skills} |
| Blocked, next step | Re-check your skills, or dispute one you believe we missed |
| Ranking mode (D1 open) | This job does not block applications. Your verified skills are shown as a signal |

## Scan states

| State | Copy |
| --- | --- |
| queued | Your check is queued. This usually takes a few minutes |
| running | Checking your repositories — {done} of {total} |
| paused | GitHub asked us to slow down. Your check will resume automatically |
| completed | Your verified skills are ready |
| failed | We could not finish the check. Your previous results are unchanged — try again |

## Empty and error states

| Situation | Copy |
| --- | --- |
| No verified skills | No skills verified yet. Add a repository that uses them, then re-check |
| No search results | No candidates match those skills yet. Try fewer filters |
| No applications | You have not applied to any job yet. Browse open jobs |
| Upload rejected | That file is not a PDF or DOCX, or it is too large. Choose another file |
| Locked contact | Shown after the candidate applies |
| 403 | You do not have access to this page |
| 404 | We cannot find that page |
| Session expired | Your session has expired. Please log in again |
| Offline | You seem to be offline. Some features may not work |

## Numbers and dates

Absolute dates (`12 Mar 2026`), never "3 days ago" for evidence. Confidence shown as a percentage with the threshold visible (`72% — verified from 60%`), never colour alone.

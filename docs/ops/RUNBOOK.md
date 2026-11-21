# Runbook

What to do when something breaks. Every entry follows the same shape: symptom, check, action, escalate.

## Alerts

### Failed verification jobs

- **Symptom:** `verification.failed` rate above baseline; alert from the worker.
- **Check:** worker logs filtered by job id; which pipeline stage failed; whether GitHub or the LLM is the source.
- **Action:** retry once. If it fails again, inspect the recorded stage and record the candidate id for review. Previous verified rows stay current — do not delete or downgrade them.
- **Escalate:** engineering lead if the same stage fails for more than one candidate.

### Queue backlog

- **Symptom:** queue depth above threshold for more than 10 minutes.
- **Check:** worker process count and health, job duration, whether jobs are paused on rate limit.
- **Action:** scale worker replicas. If jobs are paused, confirm the reset time is honoured and that resume works rather than restarting.
- **Escalate:** if depth keeps rising after scaling, the pipeline is stuck on one repository or one candidate.

### GitHub rate limit exhausted

- **Symptom:** `github.ratelimit` events with `remaining = 0`; scans pausing.
- **Check:** reset time, which endpoints are being hit, whether ETag caching is working.
- **Action:** let the queue pause until reset. Never rotate tokens to bypass the limit. Cut the number of repositories per scan if the quota cannot cover the queue.
- **Escalate:** if this recurs daily, the caching or scan-order strategy needs revisiting.

### Apply-gate rejection spike

- **Symptom:** `apply.rejected_by_gate` jumps.
- **Check:** rejections by missing skill; recent rule version; search whether a popular skill stopped verifying.
- **Action:** if a rule version caused it, report to the labelled set owner and consider a rollback of the rule version. Individual candidates get the reason and the re-scan path.
- **Escalate:** product owner always — this is the PRD's top risk.

### CV parsing failures

- **Symptom:** CVs stuck in `queued`, or `parse_state = failed`.
- **Check:** LLM provider status and quota; whether masking failed; the recorded error class.
- **Action:** retry the parse. If the provider is down, keep the file and notify the candidate rather than silently accepting an empty parse. Never send unmasked CV text as a workaround.

## Recovery

### Database restore

1. Confirm scope: full instance or a single table.
2. Restore into a separate instance first; verify row counts on `users`, `applications` and the current `skill_verifications`.
3. Point the app at the restored instance only after verification, and re-run a smoke flow.

### Storage outage for CVs

Uploads fail closed with a clear message; do not accept a CV that has no stored bytes. Verification can continue for candidates who already have a parsed CV.

### Bad release

Roll back the image to the previous tag; roll back the migration only if its rollback exists. Verification rows are append-and-supersede, so a rule-version regression is fixed by shipping the previous version, not by deleting rows.

## Things never to do during an incident

- Delete verification rows or evidence to "clean up".
- Re-enable scanning for a candidate who revoked consent.
- Copy production CVs or profiles into staging.
- Disable the apply gate in code instead of using the per-job flag.

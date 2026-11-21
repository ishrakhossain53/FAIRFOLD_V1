# Verification rules

**Rule version:** `2026-11-v1` · Every stored result carries the version that produced it. Changing a weight or threshold means a new version, not an edit to this one.

A skill is verified only when the candidate's own public code shows it, and every result keeps the evidence that produced it (PRD §6).

## Pipeline

1. Load `claimed_skills` where `confirmed_by_candidate = true`.
2. Fetch public repositories for the linked GitHub account: skip forks unless authored commits exist.
3. Per repository, collect language stats, dependency manifests, and a sample of the largest authored source files.
4. Match each claimed skill to evidence per repository.
5. Score, threshold, persist `skill_verifications` + `verification_evidence`, write the audit row.

## Repository eligibility

| Condition | Treatment |
| --- | --- |
| Fork with no authored commits | Excluded entirely |
| Fork with authored commits | Counted only for those authored files |
| Flag `tutorial_clone` (near-identical content to a common starter) | Contributes zero weight, evidence recorded |
| Flag `trivial` (very small or empty) | Contributes zero weight alone |
| Flag `low_authorship` | Scored, but capped at `partial` until reviewed |
| Uncommitted files or other people's commits | Not evidence |

## Scoring

Weights are additive and deliberately simple, so a reviewer can reconstruct any result by hand.

| Signal | Weight | Evidence row |
| --- | --- | --- |
| Authored source files that use the skill | 0.50 | `source_file` |
| Authored commits touching those files | 0.20 | `commit` |
| Entry in a dependency manifest | 0.15 | `manifest` |
| Recent activity (last 24 months) | 0.10 | `recency` |
| Skill found in more than one repository | 0.05 | `multi_repo` |
| Language detected by GitHub for the repo | — | `language` (displayed, not scored) |

A manifest entry alone tops out at **0.15**: weak by construction, as the PRD requires. `weak` skills in `SKILL_TAXONOMY.csv` (HTML, CSS, SQL, Bash, Git, Linux, REST) have their file and commit weights halved because those signals appear in almost every repository. `none` skills are never scored — they surface as "cannot be confirmed from GitHub".

## Thresholds

| Confidence | Status | Visible to |
| --- | --- | --- |
| `>= 0.60` | `verified` | Everyone, with evidence |
| `0.30 – 0.59` | `partial` | Candidate always; recruiters only if `candidate_profiles.allow_partial_public` |
| `< 0.30` | `not_verified` | Candidate only, with the reason |

Both cut-offs are decision **D3** and are starting values. They change only with a version bump and only after calibration on the labelled set ([../testing/LABELLED_SET.md](../testing/LABELLED_SET.md)).

## Determinism and reliability

- Same inputs and same rule version produce the same score. No LLM, no randomness, no time-of-day dependence beyond the recency window.
- A failed or partial scan never downgrades an existing verified row: the previous row stays current until a complete new result is written.
- Rate-limit pauses resume at the next repository; per-skill progress is persisted, not restart-from-scratch.

## Changing the rules

1. Change the weights or thresholds on a branch and declare the next version, e.g. `2026-12-v2`.
2. Run the labelled set through the old and new versions; report precision and recall for both.
3. Ship only if precision does not regress. Record the decision as an ADR and close the matching row in `product/DECISIONS.md`.
4. Results are re-run on demand; existing rows keep their original `rule_version` so history stays reproducible.

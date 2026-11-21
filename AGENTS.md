# AGENTS.md

Conventions for AI agents working in this repository. A human reads `CONTRIBUTING.md`; this file adds what an agent tends to get wrong.

## Read order

1. `docs/README.md` — the index and the build prerequisites.
2. `docs/product/DECISIONS.md` — anything marked `open` is **not** decided. Do not implement a default and present it as the choice; ask or leave it configurable.
3. The one document that owns what you are touching: `VERIFICATION_RULES.md` for scoring, `schema.sql` for columns, `openapi.yaml` for routes, `UI_UX_BRIEF.md` for screens, `COPY.md` for strings.

## Rules

- **One home per fact.** Never duplicate weights, thresholds, column lists, endpoint tables or consent text into another file. Link instead.
- **Do not invent infrastructure.** No dependencies, services, test frameworks or scripts that the TRD does not name. The proposed stack is in `docs/engineering/TRD.md` §3.
- **No commands that do not exist yet.** This repo has no application code; do not add CI or package scripts that reference files not present.
- **Schema changes** are migrations plus `schema.sql`, with the invariant described in `DATA_MODEL.md`.
- **Rule changes** need a new `rule_version` and a labelled-set comparison; never tune a threshold silently.
- **Never** put personal data, real CVs, GitHub tokens or secrets in the repo or in logs.
- **Verification tables are worker-write-only.** Do not add writes from the web app.

## When you finish

State what you changed, which document owns each new fact, what you verified, and what you deliberately skipped. If a check could not run, say so plainly.

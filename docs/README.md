# Documentation index

GitHub-Verified Skills Recruitment Platform. Read in the order below; each layer answers a different question and is authoritative for that question only.

| Layer | Document | Answers | Status |
| --- | --- | --- | --- |
| Product | [product/PRD.md](product/PRD.md) | What we build and why, for whom, and how success is measured | Draft — open questions in `DECISIONS.md` |
| Product | [product/DECISIONS.md](product/DECISIONS.md) | Every open decision, with owner and date once closed | Living — 20 items open |
| Product | [product/SKILL_TAXONOMY.csv](product/SKILL_TAXONOMY.csv) + [notes](product/SKILL_TAXONOMY.md) | The fixed skill list the whole system joins on | v1 seed — needs review |
| Product | [product/COPY.md](product/COPY.md) | Canonical user-facing strings (badges, gate, errors, consent) | v1 draft |
| Design | [design/UI_UX_BRIEF.md](design/UI_UX_BRIEF.md) | The 28 pages, their contents, flows and handoff checklist | 28 pages specified — screens delivered |
| Design | [design/DESIGN_SYSTEM.md](design/DESIGN_SYSTEM.md) | Colour, type, radius, spacing and component specs | Delivered — authoritative for visual work |
| Design | [design/screens/README.md](design/screens/README.md) | Screen exports, their naming, variants and known issues | 33 folders — 37 screens delivered |
| Engineering | [engineering/TRD.md](engineering/TRD.md) | Stack, data model outline, API surface, security controls | Draft |
| Engineering | [engineering/SYSTEM_DESIGN.md](engineering/SYSTEM_DESIGN.md) | Components, flows, state ownership, trade-offs | Draft |
| Engineering | [engineering/DATA_MODEL.md](engineering/DATA_MODEL.md) | Table invariants, write ownership, indexing | v1 — review before build |
| Engineering | [engineering/schema.sql](engineering/schema.sql) | Executable Postgres schema (source of truth for columns) | v1 — review before build |
| Engineering | [engineering/VERIFICATION_RULES.md](engineering/VERIFICATION_RULES.md) | Versioned scoring rules and thresholds | `2026-11-v1` — needs calibration |
| Engineering | [engineering/openapi.yaml](engineering/openapi.yaml) | REST contract between web app, worker and frontend | v1 — review before build |
| Engineering | [engineering/EVENTS_AND_METRICS.md](engineering/EVENTS_AND_METRICS.md) | How each PRD metric is computed from stored rows | v1 draft |
| Engineering | [engineering/adr/README.md](engineering/adr/README.md) | Decision records for choices already made | Template ready |
| Testing | [testing/TEST_PLAN.md](testing/TEST_PLAN.md) | Test levels, coverage, and the gate per milestone | v1 draft |
| Testing | [testing/LABELLED_SET.md](testing/LABELLED_SET.md) | Protocol for the 30–50 profile precision set | v1 draft |
| Ops | [ops/DEPLOYMENT.md](ops/DEPLOYMENT.md) | Environments, CI/CD, migrations and rollback | v1 draft |
| Ops | [ops/RUNBOOK.md](ops/RUNBOOK.md) | What to do when a scan, queue or restore goes wrong | v1 draft |
| Legal | [legal/CONSENT_AND_PRIVACY.md](legal/CONSENT_AND_PRIVACY.md) | Consent copy, data inventory, retention, data-rights flow | Draft — needs legal review |

## How this folder stays usable

- **One home per fact.** The PRD owns *what*. The TRD and SYSTEM_DESIGN own *how*. `VERIFICATION_RULES.md` owns the scoring numbers, `schema.sql` owns the columns, `DECISIONS.md` owns anything undecided. When a value changes, exactly one file changes.
- **Undecided things go in `DECISIONS.md`**, not in a doc's §9. Section-level open-question lists are historical; the log is current.
- **Decisions that are made** get a record in `engineering/adr/` and a closed row in `DECISIONS.md`.
- **No spaces in filenames.** Links stay relative and unescaped.
- **Docs ship with code.** A change that alters behaviour, a rule version, a schema or a screen updates the matching doc in the same pull request.
- **Screens are assets, not sources.** The HTML in `design/screens/` is the render of record and the PNGs are thumbnails; the token block in `design/DESIGN_SYSTEM.md` outranks both.

## Hard dependencies before build starts

1. `product/SKILL_TAXONOMY.csv` reviewed — CV extraction, verification, search and job requirements all join on it.
2. `engineering/VERIFICATION_RULES.md` accepted as `2026-11-v1` — the worker cannot be written without fixed weights and thresholds.
3. `engineering/schema.sql` applied to a local database — 13 tables precede any query.
4. `engineering/openapi.yaml` agreed — the web app, worker and frontend meet here.
5. `legal/CONSENT_AND_PRIVACY.md` consent text available — it is UI copy on pages 8 and 15, and a blocker for GitHub scanning.
6. Screens reviewed with the designer — 37 exist in `design/screens/`, but mobile renders, 1440 px PNGs and specs for pages 29–33 are still owed (list in `design/screens/README.md`).

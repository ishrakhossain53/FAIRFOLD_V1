# Decision log

One row per decision. While `Status` is `open` the item is unresolved; the source document is background, not the answer. Close a row by filling `Decision`, `Owner` and `Date`, and copy the reasoning into `engineering/adr/` when the choice is architectural.

Status: `open` · `decided` · `decided, revisit` · `dropped`

## Blocking the MVP build

| ID | Decision | Blocks | Source | Status | Owner | Date |
| --- | --- | --- | --- | --- | --- | --- |
| D1 | Apply gate is a hard block, or a per-job recruiter setting (block vs ranking signal) | Page 13 gate panel, page 20 job form, `jobs.enforce_gate` | PRD §9 | open | | |
| D2 | Match rule: all required skills, or a minimum count (both supported, default needed) | Page 20 defaults, `jobs.match_mode` | PRD F18 | open | | |
| D3 | Confidence threshold marking a skill verified (0.60 proposed) and who owns changes | `VERIFICATION_RULES.md`, confidence meter | TRD §5 | open | | |
| D4 | First skill taxonomy contents and the admin process for adding skills | `SKILL_TAXONOMY.csv` | PRD §9 | open | | |
| D5 | CV extraction LLM provider, model, monthly cost cap, and data-processing terms | Worker, privacy copy | TRD §9 | open | | |
| D6 | Hosting provider and region, given data residency and latency for Bangladesh | `DEPLOYMENT.md`, infra cost | TRD §9 | open | | |
| D7 | Launch market: developers in Bangladesh only, or any region | Copy, currency/locale, page 17 filters | PRD §9 | open | | |
| D8 | Candidate GitHub sign-in required, or optional alongside email and password | Pages 3 and 4, `auth` flows | TRD §9 | open | | |
| D9 | Data protection regime at launch and whether it forces local storage | Legal review, hosting choice | TRD §7 | open | | |
| D10 | Human reviewer for disputes at launch, and who staffs it | Page 26, `DISPUTES` queue | PRD §9 | open | | |
| D11 | Product owner and engineering lead, so the PRD metrics get an owner | Metric assignment | PRD §9 | open | | |
| D12 | Product name, domain and logo (DESIGN tokens are borrowed) | Every screen, page 1 | Brief §5.6 | open | | |

## Engineering parameters

| ID | Decision | Default if not decided | Source | Status |
| --- | --- | --- | --- | --- |
| D13 | API-only repository analysis vs cloning repos | API-only | TRD §9 | open |
| D14 | Target maximum scan time and maximum repositories per profile | < 3 min median, 100 repos | TRD §9, SYSTEM_DESIGN §8 | open |
| D15 | Verification weights (0.50 / 0.20 / 0.15 / 0.10 / 0.05) confirmed on real data | As written | TRD §5 | open |
| D16 | Partial skills visible to recruiters, or candidate-only by default | Candidate-only unless the candidate opts in | PRD §6 | open |
| D17 | Recruiters may download the CV file | No | Brief §10 | open |
| D18 | Bangla language support at launch | English only | Brief §10 | open |
| D19 | Rate-limit values for sign-up, login, search, verification triggers | TBD per endpoint | TRD §6 | open |
| D20 | Retention period for CVs and scan data after account deletion | Audit row kept, personal data removed immediately | TRD §4 | open |

## Already decided (recorded for traceability)

| ID | Decision | Where it is recorded |
| --- | --- | --- |
| D21 | Verification runs as an async job; one job per candidate, resumable | SYSTEM_DESIGN §3.1, §4 |
| D22 | Only the worker writes verification tables; only the web app writes everything else | SYSTEM_DESIGN §2 |
| D23 | Applications snapshot matched and missing skills at apply time | SYSTEM_DESIGN §5 |
| D24 | Postgres indexes instead of a search engine until pilot scale is outgrown | SYSTEM_DESIGN §9 |
| D25 | LLM used only for CV extraction, never for the apply decision | TRD §1 |
| D26 | `skill_verifications` keeps one current row per candidate and skill; older rows are superseded, never deleted | `schema.sql`, DATA_MODEL.md |

# Skill taxonomy

`SKILL_TAXONOMY.csv` is the fixed list every part of the system joins on: CV extraction output, verification rows, talent search filters and job required-skills. A skill that is not in this file cannot be claimed, verified or required.

## Columns

| Column | Meaning |
| --- | --- |
| `id` | Stable slug, primary key. Never rename once rows reference it — add an alias instead |
| `canonical_name` | The single display name. This is what users and recruiters see |
| `aliases` | Pipe-separated variants that must normalise to this id (`ReactJS`, `React.js`) |
| `category` | Grouping for the admin skill picker |
| `github_signal` | `strong` — files or manifests prove it · `weak` — evidence exists but must be weighted down · `none` — no GitHub footprint |
| `verification_note` | Why a skill is weak or none, and what evidence counts. Empty for `strong` except where detection is not obvious — currently only Android |

## Rules

- **`none` skills are never "not verified".** The PRD (§6, limits) requires the product to say the skill cannot be confirmed from code, not to imply it is false. UI shows them as declared skills.
- **Adding a skill** is a data change, not a code change: one CSV row, then re-run the seed import. Aliases are the only way to fix a bad extraction without a migration.
- **Review cadence:** once before build (blocking), then per verification rule version, then quarterly.
- **Seeding** is idempotent: upsert by `id`, update `canonical_name`, `aliases`, `category`, `github_signal`.
- The initial list covers developer skills only, per the MVP scope. Non-technical skills stay out of the file entirely. A developer skill with no code footprint (system design) stays in with `github_signal = none` so a job can still require it.

# Screens

Delivered screen exports, one folder per page, numbered as in [UI_UX_BRIEF.md](../UI_UX_BRIEF.md) §3. HTML is the reference render; PNG is a thumbnail for tickets and pull requests. The pair always lives in the same folder — never split into `html/` and `png/` trees.

These came from the Google Stitch project `stitch_fairfold_code_verification_platform` (exported as `code.html` + `screen.png` per screen). The Stitch project stays outside the repo; this folder is the copy of record. When you place a fresh export, rename `code.html` → `desktop.html` and `screen.png` → `desktop.png`.

## Naming

```
screens/<page-number>-<slug>/
├── desktop.html           reference render at desktop width (1360 px container)
├── desktop.png            thumbnail of desktop.html
├── desktop-blocked.html   page variant that changes the meaning (gate pass/fail)
├── desktop-alt.png        second export of the same page, where one exists
└── notes.md               variants, decisions, anything a developer must not miss
```

No dates or version numbers in file names (git has that). Styles follow [DESIGN_SYSTEM.md](../DESIGN_SYSTEM.md) — if a screen contradicts the token block, fix the screen. Anything heavy (Figma source, prototype video) stays outside the repo and is linked from that page's `notes.md`.

## Delivery table

Every folder below has both files. `Priority` is from the brief; `variants` lists extra exports in the same folder.

| # | Folder | Page | Priority | Variants |
| --- | --- | --- | --- | --- |
| 1 | `01-landing` | Landing | P0 | |
| 2 | `02-how-verification-works` | How verification works | P0 | |
| 3 | `03-signup` | Sign up | P0 | |
| 4 | `04-login` | Log in | P0 | |
| 5 | `05-email-verification` | Email verification | P0 | |
| 6 | `06-upload-cv` | Onboarding 1: upload CV | P0 | |
| 7 | `07-review-extracted-skills` | Onboarding 2: review extracted skills | P0 | |
| 8 | `08-github-consent` | Onboarding 3: connect GitHub and consent | P0 | |
| 9 | `09-verification-in-progress` | Verification in progress | P0 | `desktop-alt` |
| 10 | `10-candidate-dashboard` | Candidate dashboard and verified profile | P0 | `desktop-alt` |
| 11 | `11-skill-evidence` | Skill evidence explorer and dispute | P0 | |
| 12 | `12-browse-jobs` | Browse jobs | P0 | |
| 13 | `13-job-detail-apply` | Job detail and apply gate | P0 | `desktop-blocked` (missing skills) |
| 14 | `14-my-applications` | My applications | P1 | |
| 15 | `15-candidate-settings` | Candidate settings and privacy | P0 | `desktop-alt` |
| 16 | `16-recruiter-dashboard` | Recruiter dashboard | P0 | |
| 17 | `17-talent-search` | Talent search | P0 | |
| 18 | `18-candidate-profile-recruiter` | Candidate profile, recruiter view | P0 | |
| 19 | `19-my-jobs` | My jobs | P0 | |
| 20 | `20-create-edit-job` | Create / edit job | P0 | |
| 21 | `21-job-applicants` | Job applicants | P0 | |
| 22 | `22-applicant-detail` | Applicant detail | P0 | |
| 23 | `23-recruiter-settings` | Recruiter settings | P0 | |
| 24 | `24-admin-dashboard` | Admin dashboard | P1 | |
| 25 | `25-audit-log` | Verification audit log | P0 | |
| 26 | `26-disputes` | Disputes queue and review | P1 | |
| 27 | `27-admin-users-jobs` | Users and jobs management | P1 | |
| 28 | `28-system-states` | Error, access and empty-session states | P0 | |

### Delivered beyond brief §3

These five were exported with the rest but have no page spec in the brief. They are designed, not specified: do not build them until they get a spec and a row in [DECISIONS.md](../../product/DECISIONS.md).

| Folder | Page | Question it raises |
| --- | --- | --- |
| `29-recruiter-pipeline` | Matched roles and sourcing pipeline | Is matched-role shortlisting in MVP, or does talent search cover it? |
| `30-consent-grants` | Active pipeline and candidate consent grants | Recruiter-side consent ledger — where do grants live in the data model? |
| `31-recruiter-blind-search` | Blind search and proof verification portal | Supersedes or extends talent search (page 17)? |
| `32-ast-queue` | Real-time AST verification queue | Admin tooling for scans; needs the worker contract first. |
| `33-ats-integrations` | ATS integrations and API key governance | API keys are not in the TRD or `openapi.yaml` yet. |

## Known issues in the exports

- **PNGs are thumbnails, not 1440 px frames.** Widths range from 232 to 1307 px at 1600 px tall. Read the HTML for layout truth; the brief's desktop PNG is still owed.
- **The HTML needs network access.** It loads Tailwind from a CDN, plus Manrope/Inter/JetBrains Mono and Material Symbols from Google Fonts, and sample portraits from `lh3.googleusercontent.com`. Offline it renders unstyled.
- **Palette drift against the token block.** Four exports still use `#E8EBE6` and one uses `#0E0F0C`, both from the prose of the design system rather than its token block. Fix on the next regeneration; do not copy those values into code.
- **No mobile renders.** Ten pages are marked mobile-first in the brief; the HTML is responsive, but no mobile export exists.
- **Copy is final-ish, not final.** Strings live in [COPY.md](../../product/COPY.md); where they differ, COPY.md wins.

## Before the build starts

The desktop HTML for pages 1–28 exists, so the visual blocker is cleared. Still owed to the designer: mobile renders for the ten mobile-first pages, 1440 px desktop PNGs, and specs for pages 29–33. The component library in brief §5.4 (badges, confidence meter, evidence row, gate panel, scan stepper) ships as `28-system-states`.

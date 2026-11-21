# Contributing

## Before you start

Read [docs/README.md](docs/README.md). If your change depends on something in [docs/product/DECISIONS.md](docs/product/DECISIONS.md) that is still `open`, raise it before building — do not pick an answer silently.

## Workflow

1. Branch from `main`: `feat/…`, `fix/…`, `docs/…`, `chore/…`.
2. Keep a pull request to one concern. A behaviour change and its documentation ship together.
3. Describe the change, how you verified it, and anything you deliberately left out.

## Rules

- **One home per fact.** Do not restate the verification weights, thresholds, table columns or consent text in a new place — link to the file that owns them.
- **Undecided stays undecided.** Add the question to `docs/product/DECISIONS.md` rather than inventing a default in code.
- **A rule or schema change needs its record:** a new `rule_version` with a labelled-set score report, a migration with a rollback, or an ADR. See [docs/engineering/adr/README.md](docs/engineering/adr/README.md).
- **No personal data in the repository** — not in fixtures, tests, screenshots or the labelled set.
- **No secrets** in code, docs or commits. Copy `.env.example`, never commit `.env`.
- **Screens stay in `docs/design/screens/`** with the naming in its README; design tokens win over exported pixels.

## Checks

Lint, typecheck, tests and the API contract validation run in CI on every pull request. The commands land in this file when the first application code is added.

## Commit messages

Short imperative subject, then why it was needed if it is not obvious. One logical change per commit.

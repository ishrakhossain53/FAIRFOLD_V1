# GitHub-Verified Skills Recruitment Platform

Candidates prove their skills with evidence from their own public GitHub work; recruiters search and hire on those verified skills instead of self-reported CV claims. Every verified skill shows the repositories, files and commits behind it.

**Status: documentation stage.** There is no application code yet. The documents below are the build contract.

## Start here

| Read | Why |
| --- | --- |
| [docs/README.md](docs/README.md) | Full documentation index, statuses and build prerequisites |
| [docs/product/PRD.md](docs/product/PRD.md) | What is being built, for whom, and the MVP scope |
| [docs/engineering/TRD.md](docs/engineering/TRD.md) | Stack, data model, API surface, security controls |
| [docs/engineering/SYSTEM_DESIGN.md](docs/engineering/SYSTEM_DESIGN.md) | Components, flows and trade-offs |
| [docs/product/DECISIONS.md](docs/product/DECISIONS.md) | Every open decision — check here before assuming an answer |

## Proposed stack

Next.js (React, TypeScript) web app · Python worker for CV parsing and repository scanning · PostgreSQL · Redis for the job queue and GitHub response cache · S3-compatible private storage for CVs · GitHub Actions. Hosting is not decided (D6).

## Before the first line of code

Six items block the build: taxonomy review, verification rules, schema, API contract, consent text, and the P0 screens. The list is in [docs/README.md](docs/README.md#hard-dependencies-before-build-starts).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md). Documentation lives in `docs/`, screens in `docs/design/screens/`, and a change that alters behaviour updates its document in the same pull request.

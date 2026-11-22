# Deployment

Proposal until hosting and region are decided (decision D6). The pipeline shape does not depend on the provider.

## Environments

| Environment | Purpose | Data |
| --- | --- | --- |
| Local | Day-to-day development | Seeded synthetic users; local Postgres, Redis, bucket (MinIO or provider equivalent) |
| Staging | Integration, end-to-end tests, design review | Synthetic or consented sample profiles only — never production copies |
| Production | Pilot | Real accounts |

Each environment has its own database, bucket and GitHub OAuth app. Credentials are never shared across environments.

## Pipeline

1. **Pull request:** lint, typecheck, unit + integration tests, `openapi.yaml` validation, dependency and secret scanning. Merging is blocked on failure.
2. **Merge to main:** image build for web app and worker, automatic deploy to staging, migrations applied, end-to-end suite against staging.
3. **Production:** manual approval, migrations, web app and worker rolled out in that order, smoke check, then the release is announced with the rule version in use.

Two containers from one repository: the web app and the worker, matching the single-writer boundary in `SYSTEM_DESIGN.md` §2.

## Migrations

- Versioned, forward-only files in `engineering/migrations/`, one concern per migration. `schema.sql` is the target state for a fresh database and is applied as migration `0001`; later changes arrive as new migration files.
- Every migration ships with a tested rollback step, or an explicit note that it is irreversible and why.
- Migrations run before the new application version starts. A schema change that needs both old and new code must be backward compatible for one release.
- Destructive changes (dropping a column or table) wait one release after the code stops using them.

## Secrets

Stored in the platform's managed vault and injected at runtime: database URL, Redis URL, S3 credentials, GitHub client id and secret, JWT signing key, token encryption key, LLM API key. Nothing in `.env.example` is real, and `.env` is git-ignored.

## Release checklist

- [ ] All checks green on the merge commit
- [ ] Rule version unchanged, or a new version shipped with its labelled-set score report
- [ ] Migration and rollback reviewed
- [ ] No new PII in logs (spot-check a verification job)
- [ ] Staging end-to-end flow green for candidate, recruiter and admin
- [ ] Rollback path known: previous image tag and migration state

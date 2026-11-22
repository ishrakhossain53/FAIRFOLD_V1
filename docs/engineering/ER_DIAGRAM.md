# ER diagram

Mermaid `erDiagram` for the current schema. Source of truth for columns and constraints is `schema.sql`; this diagram is the readable view for docs and slides. If the schema changes, regenerate this diagram from it — do not edit the picture by hand.

```mermaid
 erDiagram
    USERS ||--o| CANDIDATE_PROFILES : "1:1 via user_id"
    USERS ||--o| RECRUITER_PROFILES : "1:1 via user_id"
    USERS ||--o{ CVS : "1:N"
    USERS ||--o{ GITHUB_REPOS : "1:N"
    USERS ||--o{ SKILL_VERIFICATIONS : "1:N"
    USERS ||--o{ APPLICATIONS : "1:N"
    USERS ||--o{ JOBS : "recruiter_id on jobs"

    JOBS }|--|| USERS : "recruiter_id FK"
    JOBS ||--o{ JOB_REQUIRED_SKILLS : "1:N"
    JOBS ||--o{ APPLICATIONS : "1:N"

    SKILLS ||--o{ CLAIMED_SKILLS : "1:N"
    SKILLS ||--o{ JOB_REQUIRED_SKILLS : "1:N"
    SKILLS ||--o{ SKILL_VERIFICATIONS : "1:N"

    SKILL_VERIFICATIONS ||--o{ VERIFICATION_EVIDENCE : "1:N"
    GITHUB_REPOS ||--o{ VERIFICATION_EVIDENCE : "1:N, repo_id SET NULL on delete"

    AUDIT_LOG }|--|| ACTOR_PSEUDONYM : "actor_pseudonym — stable hash of user id, no FK"

    USERS {
        uuid id PK
        text email
        text password_hash
        user_role role
        timestamptz email_verified_at
        timestamptz created_at
    }
    CANDIDATE_PROFILES {
        uuid user_id PK FK "to users"
        text name
        text headline
        text location
        text github_username
        bigint github_user_id
        text github_token_enc
        timestamptz consent_scan_at
        boolean allow_partial_public
    }
    RECRUITER_PROFILES {
        uuid user_id PK FK "to users"
        text company_name
        text company_site
    }
    CVS {
        uuid id PK
        uuid user_id FK "to users"
        text storage_key
        jsonb parsed_json
        text parse_state
        text parse_error
        timestamptz uploaded_at
    }
    SKILLS {
        text id PK
        text canonical_name
        text[] aliases
        text category
        text github_signal
        text verification_note
    }
    CLAIMED_SKILLS {
        uuid id PK
        uuid candidate_id FK "to users"
        text skill_id FK "to skills"
        text source_text
        boolean confirmed_by_candidate
        timestamptz created_at
    }
    GITHUB_REPOS {
        uuid id PK
        uuid candidate_id FK "to users"
        bigint github_repo_id
        text name
        boolean is_fork
        integer authored_commits
        jsonb languages
        text[] flags
        timestamptz last_scanned_at
    }
    SKILL_VERIFICATIONS {
        uuid id PK
        uuid candidate_id FK "to users"
        text skill_id FK "to skills"
        verification_status status
        numeric confidence
        text rule_version
        text reason
        timestamptz scanned_at
        timestamptz superseded_at
    }
    VERIFICATION_EVIDENCE {
        uuid id PK
        uuid verification_id FK "to skill_verifications"
        uuid repo_id FK "to github_repos, SET NULL on delete"
        evidence_type evidence_type
        text file_path
        integer authored_lines
        jsonb detail
    }
    JOBS {
        uuid id PK
        uuid recruiter_id FK "to users"
        text title
        text description
        job_status status
        match_mode match_mode
        integer min_match
        boolean enforce_gate
        timestamptz created_at
        timestamptz updated_at
    }
    JOB_REQUIRED_SKILLS {
        uuid job_id PK FK "to jobs"
        text skill_id PK FK "to skills"
        boolean required
    }
    APPLICATIONS {
        uuid id PK
        uuid job_id FK "to jobs"
        uuid candidate_id FK "to users"
        application_status status
        jsonb matched_skills
        jsonb missing_skills
        text rule_version
        timestamptz created_at
    }
    AUDIT_LOG {
        bigint id PK generated always as identity
        uuid actor_pseudonym
        text action
        text subject
        text rule_version
        jsonb payload
        timestamptz created_at
    }
```

## Primary and foreign keys

| Table | Primary key | Foreign keys | Note |
| --- | --- | --- | --- |
| `users` | `id uuid` | — | one row per account; role = candidate / recruiter / admin |
| `candidate_profiles` | `user_id uuid` → `users.id` | `user_id` | one per candidate account |
| `recruiter_profiles` | `user_id uuid` → `users.id` | `user_id` | one per recruiter account |
| `cvs` | `id uuid` | `user_id` → `users.id` | `storage_key` is the object-store key; bytes are not in Postgres |
| `skills` | `id text` (slug) | — | seeded from `SKILL_TAXONOMY.csv`; the fixed skill list |
| `claimed_skills` | `id uuid` | `candidate_id` → `users.id`, `skill_id` → `skills.id` | unique on `(candidate_id, skill_id)` |
| `github_repos` | `id uuid` | `candidate_id` → `users.id` | unique on `(candidate_id, github_repo_id)` |
| `skill_verifications` | `id uuid` | `candidate_id` → `users.id`, `skill_id` → `skills.id` | one current row per `(candidate_id, skill_id)` via partial unique index |
| `verification_evidence` | `id uuid` | `verification_id` → `skill_verifications.id`, `repo_id` → `github_repos.id` (SET NULL on delete) | many evidence rows per verification |
| `jobs` | `id uuid` | `recruiter_id` → `users.id` | `updated_at` is set by the app, not a trigger |
| `job_required_skills` | `(job_id, skill_id)` | `job_id` → `jobs.id`, `skill_id` → `skills.id` | composite primary key |
| `applications` | `id uuid` | `job_id` → `jobs.id`, `candidate_id` → `users.id` | unique on `(job_id, candidate_id)` |
| `audit_log` | `id bigint` generated identity | `actor_pseudonym` is a hash of the actor's user id, not a foreign key | append-only decision record |

## Data dictionary

Column-level meaning lives in three places only:

- **Columns and types** — `schema.sql` (source of truth).
- **Invariants the columns cannot express** — `DATA_MODEL.md`.
- **How each table fits the product and API** — `TRD.md` §4 and the route descriptions in `openapi.yaml`.

Do not keep a fourth copy. When a column changes, `schema.sql` changes; the dictionary entries above are derived from it and should be regenerated, not hand-edited.

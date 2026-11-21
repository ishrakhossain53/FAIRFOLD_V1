-- GitHub-Verified Skills Recruitment Platform — Postgres schema, version 1
-- Implements docs/engineering/DATA_MODEL.md and TRD.md §4. PostgreSQL 14+.
-- Apply: psql "$DATABASE_URL" -f docs/engineering/schema.sql
-- Columns here are the source of truth; DATA_MODEL.md explains the invariants.

create extension if not exists pgcrypto;  -- gen_random_uuid()

create type user_role           as enum ('candidate', 'recruiter', 'admin');
create type verification_status as enum ('verified', 'partial', 'not_verified');
create type job_status          as enum ('draft', 'open', 'closed');
create type match_mode          as enum ('all', 'minimum');
create type application_status  as enum ('submitted', 'reviewed', 'shortlisted', 'rejected');
create type evidence_type       as enum ('source_file', 'commit', 'manifest', 'language', 'recency', 'multi_repo');

-- Accounts -------------------------------------------------------------------

create table users (
  id                uuid primary key default gen_random_uuid(),
  email             text not null,
  password_hash     text,            -- null when the account is GitHub-only (decision D8)
  role              user_role not null,
  email_verified_at timestamptz,
  created_at        timestamptz not null default now()
);
create unique index users_email_key on users (lower(email));

create table candidate_profiles (
  user_id              uuid primary key references users (id) on delete cascade,
  name                 text not null,
  headline             text,
  location             text,
  github_username      text,           -- display only; the login can be renamed
  github_user_id       bigint,         -- immutable GitHub id; the link survives a rename
  github_token_enc     text,           -- encrypted read-only token; never sent to the client
  consent_scan_at      timestamptz,    -- explicit consent to scan public repositories
  allow_partial_public boolean not null default false  -- decision D16
);
-- One account per GitHub identity, and a login cannot be claimed twice (invariants 8).
create unique index candidate_profiles_github_user_key
  on candidate_profiles (github_user_id) where github_user_id is not null;
create unique index candidate_profiles_github_login_key
  on candidate_profiles (lower(github_username)) where github_username is not null;

create table recruiter_profiles (
  user_id      uuid primary key references users (id) on delete cascade,
  company_name text not null,
  company_site text
);

-- CVs and skills -------------------------------------------------------------

create table cvs (
  id          uuid primary key default gen_random_uuid(),
  user_id     uuid not null references users (id) on delete cascade,
  storage_key text not null,           -- private bucket key; bytes live in the object store
  parsed_json jsonb,                   -- worker output before candidate confirmation
  parse_state text not null default 'queued' check (parse_state in ('queued', 'parsed', 'failed')),
  parse_error text,                    -- error class for the runbook; never CV text
  uploaded_at timestamptz not null default now()
);
create index cvs_user_idx on cvs (user_id, uploaded_at desc);

create table skills (
  id               text primary key,   -- slug from SKILL_TAXONOMY.csv
  canonical_name   text not null unique,
  aliases          text[] not null default '{}',
  category         text not null,
  github_signal    text not null default 'strong' check (github_signal in ('strong', 'weak', 'none')),
  verification_note text
);

create table claimed_skills (
  id                     uuid primary key default gen_random_uuid(),
  candidate_id           uuid not null references users (id) on delete cascade,
  skill_id               text not null references skills (id),
  source_text            text,
  confirmed_by_candidate boolean not null default false,
  created_at             timestamptz not null default now(),
  unique (candidate_id, skill_id)
);

-- Verification cluster (written only by the worker) ---------------------------

create table github_repos (
  id              uuid primary key default gen_random_uuid(),
  candidate_id    uuid not null references users (id) on delete cascade,
  github_repo_id  bigint not null,
  name            text not null,
  is_fork         boolean not null default false,
  authored_commits integer not null default 0,
  languages       jsonb not null default '{}'::jsonb,
  flags           text[] not null default '{}',   -- tutorial_clone, trivial, low_authorship
  last_scanned_at timestamptz,
  unique (candidate_id, github_repo_id)
);
create index github_repos_candidate_idx on github_repos (candidate_id);

create table skill_verifications (
  id            uuid primary key default gen_random_uuid(),
  candidate_id  uuid not null references users (id) on delete cascade,
  skill_id      text not null references skills (id),
  status        verification_status not null,
  confidence    numeric(3, 2) not null check (confidence >= 0 and confidence <= 1),
  rule_version  text not null,
  reason        text,                  -- why partial / not_verified; shown to the candidate (PRD F9)
  scanned_at    timestamptz not null default now(),
  superseded_at timestamptz            -- null = current result; set = kept as history
);
-- One current row per candidate and skill; history rows are superseded, never deleted.
create unique index skill_verifications_current_key
  on skill_verifications (candidate_id, skill_id) where superseded_at is null;
-- Recruiter search and the apply gate read only this index.
create index skill_verifications_search_idx
  on skill_verifications (skill_id, status) where superseded_at is null;

create table verification_evidence (
  id              uuid primary key default gen_random_uuid(),
  verification_id uuid not null references skill_verifications (id) on delete cascade,
  repo_id         uuid references github_repos (id) on delete set null,  -- keep evidence when a repo row goes
  evidence_type   evidence_type not null,
  file_path       text,
  authored_lines  integer,
  detail          jsonb not null default '{}'::jsonb
);
create index verification_evidence_verification_idx on verification_evidence (verification_id);

-- Jobs and applications ------------------------------------------------------

create table jobs (
  id           uuid primary key default gen_random_uuid(),
  recruiter_id uuid not null references users (id) on delete cascade,
  title        text not null,
  description  text not null,
  status       job_status not null default 'draft',
  match_mode   match_mode not null default 'all',
  min_match    integer not null default 0 check (min_match >= 0),
  enforce_gate boolean not null default true,   -- decision D1: block vs ranking signal
  created_at   timestamptz not null default now(),
  updated_at   timestamptz not null default now()
);
create index jobs_recruiter_idx on jobs (recruiter_id, status);
create index jobs_open_idx on jobs (status) where status = 'open';

create table job_required_skills (
  job_id   uuid not null references jobs (id) on delete cascade,
  skill_id text not null references skills (id),
  required boolean not null default true,        -- false = nice to have
  primary key (job_id, skill_id)
);

create table applications (
  id             uuid primary key default gen_random_uuid(),
  job_id         uuid not null references jobs (id) on delete cascade,
  candidate_id   uuid not null references users (id) on delete cascade,
  status         application_status not null default 'submitted',
  matched_skills jsonb not null,        -- snapshotted at apply time, never recomputed
  missing_skills jsonb not null,
  rule_version   text,
  created_at     timestamptz not null default now(),
  unique (job_id, candidate_id)
);
create index applications_job_idx on applications (job_id, created_at desc);
create index applications_candidate_idx on applications (candidate_id, created_at desc);

-- Audit ----------------------------------------------------------------------

create table audit_log (
  id              bigint generated always as identity primary key,
  actor_pseudonym uuid not null,        -- stable hash of the actor's user id; survives deletion
  action          text not null,
  subject         text not null,        -- e.g. 'skill_verification:<uuid>'
  rule_version    text,
  payload         jsonb not null default '{}'::jsonb,
  created_at      timestamptz not null default now()
);
create index audit_log_subject_idx on audit_log (subject, created_at desc);

# Consent and privacy

Consent copy the product shows, the data it keeps, and the rights flow behind it. **Draft — requires legal review before any real user signs up** (decision D9 covers which regime applies).

## Consent copy

These strings are UI, not policy text. They live here so code and screens agree; `product/COPY.md` holds the shorter interface strings.

**CV upload (page 6)**
> Your CV is stored privately and used only to find the skills you want verified. Recruiters never see the file, and your contact details stay hidden until you apply to their job. You can delete your CV at any time.

**GitHub scan (page 8)**
> We read your public repositories only, after you agree here. We look at languages, dependency files and source files to check the skills from your CV. We do not touch private repositories, we do not write anything to your account, and we never post on your behalf. You can revoke access and stop scanning at any time.

**What is checked (page 8)**
> Code using a skill is evidence that you have worked with it. It is not a measure of how expert you are. Some skills, like SQL, system design or Figma, may leave little or no trace on GitHub — if we cannot confirm one, we say so rather than calling it false.

**Automated processing (page 8 or settings)**
> To read your CV we use an automated service. Names, emails, phone numbers and addresses are removed before your CV text leaves our system, and it is not used to train anyone's models.

**Recruiter visibility (page 10)**
> Recruiters searching by skill can see your name, headline, location and verified skills with their evidence. Your email and phone number are hidden until you apply to one of their jobs.

**Data rights (page 15)**
> You can download everything we hold about you, revoke GitHub access, or delete your account. Deleting removes your CV, your repository data and your verification results. We keep an anonymous record that a verification decision happened, without your identity.

## Data inventory

| Data | Where | Why | Retention |
| --- | --- | --- | --- |
| Name, email, role | `users`, `candidate_profiles` | Account and sign-in | Deleted with the account |
| Password hash | `users` | Authentication | Deleted with the account |
| CV bytes | Private object store, encrypted | Skill extraction | Deleted with the account or on CV replacement |
| Parsed CV JSON | `cvs.parsed_json` | Skill review before scanning | Deleted with the account |
| GitHub username and encrypted token | `candidate_profiles` | Reading public repositories | Token removed on revoke; row deleted with the account |
| Repository metadata, flags, languages | `github_repos` | Evidence | Deleted with the account |
| Verification results and evidence | `skill_verifications`, `verification_evidence` | Explainability, disputes | Deleted with the account |
| Applications and skill snapshots | `applications` | Hiring record | Deleted with the candidate account |
| Consent timestamp | `candidate_profiles.consent_scan_at` | Proof of consent | Kept in the audit record |
| Audit entries | `audit_log` | Integrity of decisions | Kept, pseudonymous only |

## Rights flows

| Right | Flow |
| --- | --- |
| See what we hold | Settings → download export (profile, skills, evidence, applications) |
| Revoke GitHub access | Settings → revoke: token deleted, no further scans, existing results stay until deletion |
| Correct extracted skills | Onboarding review, or re-run verification after editing claimed skills |
| Delete account | `DELETE /me` → cascade removes personal data, CV bytes, repo data and verification rows |
| Object to an unverified result | Dispute (P1) queued for a reviewer |

## Boundaries that must not be crossed

- Public repositories only, and only with a recorded consent timestamp.
- The LLM receives masked text; no names, emails, phone numbers or addresses.
- The frontend never receives a GitHub token.
- Name, gender, photo, age and location are never inputs to verification or matching.
- No production candidate data in staging, logs, fixtures or the labelled set.

## Needs legal review

- Which data-protection regime applies at launch, and whether it requires local storage (D9).
- Lawful basis for scanning public repositories and for the automated CV processing step.
- Whether recruiters may keep application data after a candidate deletes their account.
- Terms of service, privacy policy and a processor agreement with the LLM provider.

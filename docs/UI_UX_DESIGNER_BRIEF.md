# UI/UX Designer Brief: GitHub-Verified Skills Recruitment Platform

**Sources:** PRD (Nov 16), TRD (Nov 18), SYSTEM_DESIGN (Nov 20), DESIGN.md (visual style guide)
**Purpose:** Tells the designer how many pages to design, what each page contains, and gives a ready-to-paste Google Stitch prompt for every page.

---

## 1. Product in one paragraph

A candidate (developer) signs up, uploads a CV, links GitHub, and the system confirms which CV skills are backed by their public code. Only **verified skills**, each with visible evidence, appear on the profile. Recruiters search candidates by verified skills and post jobs with required skills. A candidate can apply only if their verified skills meet the job's match rule.

**Three design principles that come straight from the PRD**

1. **Evidence everywhere.** Every verified or unverified status must show *why* (repos, files, rule, score). Never show a bare badge.
2. **The gate must feel fair.** When a candidate cannot apply, show exactly which skills are missing and what they can do next (re-scan, dispute, add evidence).
3. **Trust and consent.** Say clearly what is scanned (public repos only), what is hidden (contact details until applying), and that access can be revoked at any time.

---

## 2. Page count and summary

**Total: 28 pages** (3 roles + public + system)

| Group | Pages | Count |
| --- | --- | --- |
| A. Public | Landing, How verification works, Sign up, Log in, Email verification | 5 |
| B. Candidate | CV upload, Review skills, GitHub consent, Scan progress, Dashboard, Skill evidence, Browse jobs, Job detail and apply, My applications, Settings | 10 |
| C. Recruiter | Dashboard, Talent search, Candidate profile, My jobs, Create/edit job, Applicants, Applicant detail, Settings | 8 |
| D. Admin | Dashboard, Audit log, Disputes, Users and jobs | 4 |
| E. System | Error and access states | 1 |

Priority key: **P0** = MVP, **P1** = shortly after launch (design now, build later), **P2** = later (not designed here).

---

## 3. Page list (quick index)

### A. Public
1. Landing page (P0)
2. How verification works (P0)
3. Sign up (P0)
4. Log in (P0)
5. Email verification (P0)

### B. Candidate
6. Onboarding step 1: Upload CV (P0)
7. Onboarding step 2: Review extracted skills (P0)
8. Onboarding step 3: Connect GitHub and consent (P0)
9. Verification in progress (P0)
10. Candidate dashboard / verified profile (P0)
11. Skill evidence detail and dispute (P0; dispute part is P1)
12. Browse jobs (P0)
13. Job detail and apply gate (P0)
14. My applications (P1)
15. Candidate settings and privacy (P0)

### C. Recruiter
16. Recruiter dashboard (P0)
17. Talent search (P0; filters are P1)
18. Candidate profile, recruiter view (P0)
19. My jobs (P0)
20. Create / edit job (P0)
21. Job applicants (P0)
22. Applicant detail (P0)
23. Recruiter settings (P0)

### D. Admin
24. Admin dashboard (P1)
25. Verification audit log (P0)
26. Disputes queue and review (P1)
27. Users and jobs management (P1)

### E. System
28. Error, access and empty-session states (P0)

---

## 4. Navigation map per role

| Role | Main navigation | Notes |
| --- | --- | --- |
| Visitor | Logo, How it works, For recruiters, Log in, Sign up | Sticky white top bar |
| Candidate | Dashboard, Jobs, My applications, Settings | Onboarding (pages 6 to 9) shown as a 4-step stepper until first verification completes |
| Recruiter | Dashboard, Talent search, My jobs, Settings | "Post a job" primary pill always visible |
| Admin | Overview, Audit log, Disputes, Users and jobs | Separate admin shell |

**Key user flows to prototype**

- Candidate: 3, 5, 6, 7, 8, 9, 10, 12, 13, (apply) 14
- Candidate blocked by gate: 12, 13 (missing skills), 11 (evidence), dispute
- Recruiter: 3, 5, 16, 20, 19, 17, 18, 21, 22

---

## 5. Design system (from DESIGN.md)

The visual language is a calm, friendly fintech look: sage canvas, white 24 px cards, one lime-green action color, very heavy display headlines.

### 5.1 Tokens

| Token | Value | Use |
| --- | --- | --- |
| Primary (lime) | `#9FE870` | Every primary button. Only brand accent. |
| Primary hover / pale | `#CDFFAD` / `#E2F6D5` | Active state, soft green card, Verified badge background |
| Canvas soft (sage) | `#E8EBE6` | Page background, secondary buttons |
| Canvas | `#FFFFFF` | Cards, nav bar, inputs |
| Ink | `#0E0F0C` | Text, headings, outline borders, dark footer and dark cards |
| Body / Mute | `#454745` / `#868685` | Secondary text / captions, placeholders |
| Positive | `#2EAD4B`, deep `#054D28` | Success text (never reuse the lime for success) |
| Warning | `#FFD11A`, content `#4A3B1C` | Partial status |
| Negative | `#D03238`, deep `#A72027` | Errors, destructive actions |
| Accent orange / cyan | `#FFC091` / `#38C8FF` | Illustrations only |

### 5.2 Typography

- **Headlines:** Wise Sans is proprietary, so use **Manrope 800/900** (or Inter 900). Hero 64 to 126 px, section 40 px, weight 900.
- **Everything else:** **Inter**. Sub-headings 24 to 32 px at 600, body 16 px, small 14 px, caption 12 px, buttons 16 px at 600.
- Rule: weight 900 for hero only, 600 for the rest.

### 5.3 Shape, spacing, components

- Radius: buttons and cards **24 px**, inputs 12 px, small badges 8 px, status pills fully round.
- Spacing base 4 px; card padding 24 px; section padding 48 px; container about 1200 px.
- Elevation by surface contrast (white card on sage page), no heavy shadows.
- Buttons: primary = lime pill, secondary = sage, tertiary = white with 1 px ink outline. About 48 px tall.
- Breakpoints: mobile under 768, tablet 768 to 1023, desktop 1024+.
- Dark band (ink background, lime text) only for promotional moments and the footer.

### 5.4 Product-specific component rules (added for this product)

| Component | Spec |
| --- | --- |
| Verified badge | Pill, pale green `#E2F6D5` background, deep green `#054D28` text, check icon |
| Partial badge | Pill, yellow `#FFD11A` background, `#4A3B1C` text |
| Not verified badge | Pill, sage background, ink text, info icon (neutral, not alarming) |
| Confidence meter | Thin rounded bar with 0.30 and 0.60 threshold ticks and the numeric score |
| Skill chip | Pill with skill name; matched (green tint) / missing (outlined with a minus icon) on job pages |
| Evidence row | Repo name, language chips, authored files and lines, last commit date, flag chips (Fork excluded, Tutorial clone down-weighted), "Open on GitHub" link |
| Gate panel | Card listing matched skills with checks and missing skills with a next-step action |
| Scan status stepper | 5 steps: Fetch repos, Collect evidence, Match skills, Score, Publish |
| Locked contact | Blurred or masked email/phone with note "Shown after the candidate applies" |

### 5.5 Copy and accessibility rules

- Plain, calm, non-judgmental wording. Say "Not verified yet", never "Rejected" or "Fake".
- Always state the limit: verification confirms code exists, not depth of expertise; SQL, design, etc. may not appear on GitHub.
- Low-bandwidth friendly: light illustrations (SVG), no heavy photography.
- WCAG AA contrast minimum, visible focus states, 48 px touch targets, never rely on color alone for status (always icon plus label).
- Do not use name, photo, gender or age as visual ranking cues on search results (fairness rule).

### 5.6 Branding note

DESIGN.md is derived from the Wise brand. Reuse the **style tokens and component shapes**, but do not copy Wise's logo, name, proprietary font or the currency-converter widget. This product replaces the converter hero card with a "verified skill profile preview" card.

---

## 6. How to use the Stitch prompts

1. In Google Stitch, create one project and generate each page as its own screen.
2. For **every** page, paste the **Global Style Block** (6.1) first, then the page prompt. Two blocks together form one complete prompt.
3. Select **Web / Desktop** unless the page says otherwise. For pages marked **Mobile-first**, also generate a **Mobile** version using the same prompt.
4. If Stitch drifts from the style (extra accent colors, sharp corners, light headline weight), add one follow-up message: "Keep exactly one accent color (lime #9FE870), 24px rounded cards, sage background, very heavy headlines."
5. Generate in this order so later screens inherit the look: 1, 3, 10, 11, 13, 17, 18, 20, 21, then the rest.

### 6.1 Global Style Block (paste before every page prompt)

```
Design style: friendly, modern fintech-inspired web app. Page background is soft sage #E8EBE6; content sits on white cards with 24px rounded corners and no drop shadows (contrast between sage and white creates depth). Text is near-black #0E0F0C, secondary text #454745, muted text #868685. Use ONE accent color only: lime green #9FE870 for primary buttons, which are pill-shaped (24px radius), dark text, semibold 16px, 48px tall. Secondary buttons are sage-filled; tertiary buttons are white with a 1px black outline. Headlines use a very heavy geometric sans (Manrope ExtraBold 800-900); all other text uses Inter. Inputs are white with a 1px black border and 12px radius. Status badges are pill-shaped: Verified = pale green #E2F6D5 background with deep green #054D28 text and a check icon; Partial = yellow #FFD11A background with #4A3B1C text; Not verified = sage background with dark text and an info icon; errors use red #D03238. Generous whitespace, 4px spacing grid, WCAG AA contrast, always pair status color with an icon and label. Desktop frame 1440px wide unless stated.
```

### 6.2 Shared sample data (keep consistent across screens)

Use this in every prompt so screens look like one product.

- Candidate: **Nusrat Jahan**, Junior Full-Stack Developer, Dhaka, GitHub `nusrat-codes`
- Skills claimed: React, Node.js, TypeScript, PostgreSQL, Docker, Python, Flutter
- Recruiter: **Tanvir Ahmed**, Talent Lead at **BrightByte Ltd**
- Job: **Junior Full-Stack Developer**, required: React, Node.js, TypeScript; nice-to-have: Docker

---

## 7. Page specifications and Stitch prompts

Each page lists: route, role, priority, source requirements, purpose, contents, states to design, and the prompt.

---

### A. PUBLIC PAGES

---

#### Page 1: Landing page
- **Route:** `/` | **Role:** Visitor | **Priority:** P0 | **Mobile-first**
- **Purpose:** Explain the promise, build trust, and send people to sign up as a candidate or recruiter.

**Contents**
1. Sticky top bar: logo, How it works, For recruiters, Log in, Sign up (lime pill).
2. Hero (sage band, split layout): giant headline, one-line subcopy, two CTAs ("I'm a developer", "I'm hiring"), and on the right a **verified skill profile preview card** (name, 3 verified skills with evidence counts, confidence bar).
3. 3-step "How it works": Upload CV, Link GitHub, Get a verified profile.
4. Two feature cards: For candidates (show real work, see why a skill was or wasn't verified) and For recruiters (search by proven skills, apply only if skills match).
5. Evidence transparency section: mock of a skill with repos and files behind it.
6. Trust band: public repos only, you control access, contact details hidden until you apply.
7. FAQ (5 questions, includes "What if a skill has no GitHub footprint?").
8. Final CTA band (dark ink with lime text), then dark footer (links, privacy, terms, contact).

**States:** desktop, tablet, mobile stacked.

**Stitch prompt**
```
Create a landing page for "FairFold", a recruitment platform where developers prove their skills with evidence from their own GitHub work and recruiters hire on verified skills instead of CV claims. Sticky white top navigation with logo, links "How it works", "For recruiters", "Log in" and a lime "Sign up" pill. Hero on a sage band with a split layout: left side has a huge, ultra-bold headline "Skills proven by code, not claimed on a CV", a short supporting sentence, and two buttons: lime "I'm a developer" and white outlined "I'm hiring". Right side has a white rounded card previewing a verified profile for Nusrat Jahan, Junior Full-Stack Developer, showing three skill rows (React, Node.js, TypeScript) each with a green Verified badge, a confidence bar and a small "4 repos, 38 files" evidence line. Below: a three-step "How it works" row (Upload your CV, Link your GitHub, Get your verified profile) with simple icons. Then two large feature cards side by side, one pale green "For developers" and one sage "For recruiters". Then a section showing how a skill's evidence is displayed (repo names, languages, authored files). Then a trust band with three points: only public repositories, you can revoke access anytime, contact details stay hidden until you apply. Add a short FAQ accordion, a dark ink call-to-action band with a lime headline and button, and a dark footer. Calm, trustworthy, generous whitespace.
```

---

#### Page 2: How verification works
- **Route:** `/how-it-works` | **Role:** Visitor | **Priority:** P0
- **Purpose:** Make the system explainable and state its limits honestly (PRD section 6 and non-functional requirements).

**Contents**
1. Page header and one-paragraph summary.
2. Visual 5-step pipeline: CV skills, public repos, evidence, matching, confidence.
3. "What counts as evidence" table: authored source files (strong), commits, dependency listed only (weak), recency, multiple repos.
4. "What we ignore": forks without your commits, copied tutorials or templates, trivial or empty repos.
5. The three statuses (Verified, Partial, Not verified) with who sees what.
6. **Limits box:** confirms code exists, not depth of expertise; some skills (SQL, design, project management) may not appear on GitHub.
7. Privacy and fairness: public data only, name/photo/gender/age/location never used.
8. CTA to sign up.

**Stitch prompt**
```
Create an explanatory page titled "How skill verification works" for a developer recruitment platform. Sage background with white 24px rounded cards. Top: heavy headline and a two-sentence summary. Section 1: a horizontal five-step pipeline diagram (Read your CV, Scan public repositories, Collect evidence, Match each skill, Score confidence) with numbered circles. Section 2: a white card with a clear table "What counts as evidence" with rows: Source files you wrote that use the skill (Strong), Commits you authored (Medium), Listed in a dependency file only (Weak), Recent activity (Boosts), Used in more than one repository (Boosts). Section 3: a pale green card "What we ignore" with three items: forks without your own commits, copied tutorials or templates, tiny or empty repositories. Section 4: three side-by-side status cards explaining Verified, Partial and Not verified with the matching badge styles and who can see each. Section 5: a clearly highlighted "Limits" card in yellow-tinted style stating verification confirms that code using a skill exists, not how deep your expertise is, and that skills like SQL, design or project management may not show up on GitHub. Section 6: privacy and fairness card listing public repositories only, revoke anytime, and that name, photo, gender, age and location are never used. End with a lime "Create my profile" button and dark footer.
```

---

#### Page 3: Sign up
- **Route:** `/signup` | **Role:** Visitor | **Priority:** P0 (GitHub sign-in P1) | **Mobile-first**
- **Reqs:** F1, F2, F3

**Contents**
1. Split layout: form card (left), benefit panel (right).
2. Role switch: "I'm a developer" / "I'm a recruiter".
3. Fields: full name, email, password (with strength hint), confirm password. Recruiter adds company name and company website (optional).
4. Terms and privacy checkbox.
5. Lime "Create account" button. "Continue with GitHub" (candidate only, P1).
6. Link to Log in.
7. Benefit panel changes with role.

**States:** candidate, recruiter, validation errors, email already used, loading.

**Stitch prompt**
```
Create a sign-up page for a developer recruitment platform. Sage page background, split layout. Left: a white 24px rounded form card with the heading "Create your account", a two-option segmented toggle "I'm a developer" (selected) and "I'm a recruiter", then inputs for Full name, Email, Password with a small strength hint, and Confirm password. Show an optional line "Recruiters also enter Company name and Company website" as a second variant. A checkbox "I agree to the Terms and Privacy Policy", a full-width lime pill button "Create account", a divider with "or", and a white outlined button "Continue with GitHub" with the GitHub icon. Footer text "Already have an account? Log in". Show one input in an error state with a red message. Right: a pale green rounded panel with a short heading "Get credit for the code you've already written" and three benefit lines with check icons, plus a small verified-skill badge illustration. Clean, friendly, plenty of whitespace.
```

---

#### Page 4: Log in
- **Route:** `/login` | **Role:** Visitor | **Priority:** P0 | **Mobile-first**
- **Contents:** Email, password, show/hide password, "Forgot password" link, lime "Log in", "Continue with GitHub" (P1), link to Sign up. Error state for wrong credentials and for unverified email (with "Resend email").

**Stitch prompt**
```
Create a log-in page for a developer recruitment platform. Sage background, a centered white 24px rounded card about 480px wide. Heading "Welcome back", inputs for Email and Password with a show/hide icon, a "Forgot password?" text link, a full-width lime pill "Log in" button, a divider "or", and a white outlined "Continue with GitHub" button. Below, "New here? Create an account". Include a red inline error banner variant: "Email or password is incorrect", and a yellow variant: "Please verify your email first" with a "Resend email" link. Small logo above the card. Minimal and calm.
```

---

#### Page 5: Email verification
- **Route:** `/verify-email` | **Role:** Any | **Priority:** P0 | **Reqs:** F1 (email verified before use)
- **Contents:** "Check your inbox" message with the email address, resend button with countdown, change email link. Success state ("Email verified", continue button, which goes to Onboarding for candidates or Dashboard for recruiters). Expired-link state.

**Stitch prompt**
```
Create an email verification screen for a developer recruitment platform. Sage background with a centered white 24px card. Show three states side by side as separate frames: (1) "Check your inbox" with a friendly envelope illustration, the text "We sent a link to nusrat@example.com", a secondary sage button "Resend email (45s)" and a text link "Use a different email"; (2) Success: a green check illustration, "Email verified", and a lime pill button "Continue"; (3) Expired link: a yellow info icon, "This link has expired", and a lime button "Send a new link". Keep it light, centered and reassuring.
```

---

### B. CANDIDATE PAGES

All pages 6 to 9 share a **4-step stepper header**: CV, Skills, GitHub, Verify.

---

#### Page 6: Onboarding step 1, Upload CV
- **Route:** `/onboarding/cv` | **Role:** Candidate | **Priority:** P0 | **Mobile-first** | **Reqs:** F4, F6

**Contents**
1. Stepper (step 1 of 4).
2. Drag-and-drop zone and "Choose file" button; accepts PDF or DOCX; shows max size.
3. Privacy note: "Stored privately and encrypted. Recruiters never see your CV file."
4. After upload: file chip (name, size, replace/remove), parsing progress ("Reading your CV...").
5. Error states: wrong type, too large, unreadable file.
6. Lime "Continue" (enabled after parsing finishes).

**Stitch prompt**
```
Create step 1 of 4 of a candidate onboarding flow titled "Upload your CV". Top has a progress stepper with four steps: CV (active), Skills, GitHub, Verify. Sage background, a centered white 24px card. Inside: a large dashed-border drop zone with an upload icon, text "Drag your CV here or choose a file", and a small line "PDF or DOCX, up to 5 MB". Below, a small lock icon note: "Stored privately and encrypted. Recruiters never see your CV file." Show a second frame of the same screen after upload: a file row "Nusrat_Jahan_CV.pdf, 214 KB" with Replace and Remove actions and a progress bar labeled "Reading your CV..." Show a third frame with a red error message "This file type isn't supported. Please upload a PDF or DOCX." Bottom right: lime "Continue" button, disabled in the first frame.
```

---

#### Page 7: Onboarding step 2, Review extracted skills
- **Route:** `/onboarding/skills` | **Role:** Candidate | **Priority:** P0 | **Reqs:** F6; TRD claimed_skills confirmation gate

**Contents**
1. Stepper (step 2 of 4).
2. Heading: "Check what we found in your CV".
3. Details card (editable): roles, education, experience years.
4. Skills section: chips for each extracted skill (React, Node.js, ...) with remove (x) and edit; "Add a skill" autocomplete from the skill list; alias hint (ReactJS maps to React).
5. Note: "Only skills you confirm will be checked against your GitHub."
6. Lime "Confirm and continue", text link "Back".

**Stitch prompt**
```
Create step 2 of 4 of candidate onboarding titled "Check what we found in your CV". Stepper at the top with Skills active. Sage background. Left, a wide white 24px card "Your skills" containing removable skill chips: React, Node.js, TypeScript, PostgreSQL, Docker, Python, Flutter, each with a small x; an "Add a skill" input with an autocomplete dropdown showing suggestions; and a helper line "We match ReactJS and React.js to React". Right (or below on mobile), a second white card "Details from your CV" with editable rows: Latest role "Junior Developer, Pixel Labs", Education "B.Sc. Computer Science, 2025", Experience "1 year", each with a pencil edit icon. Under the cards, a pale green info note: "Only the skills you confirm will be checked against your GitHub work." Bottom: tertiary "Back" button and lime "Confirm and continue" button.
```

---

#### Page 8: Onboarding step 3, Connect GitHub and consent
- **Route:** `/onboarding/github` | **Role:** Candidate | **Priority:** P0 | **Reqs:** F5, privacy requirements

**Contents**
1. Stepper (step 3 of 4).
2. "Connect your GitHub" with a black GitHub button (OAuth). After connect: avatar, username, public repo count.
3. Two-column transparency card: **What we will read** (public repositories, languages, dependency files, source files you wrote, commit authorship) and **What we will not** (private repositories, your email, your contacts).
4. Consent checkbox with plain wording, consent timestamp shown after agreeing.
5. Note: revoke any time in Settings.
6. Lime "Agree and start verification".

**Stitch prompt**
```
Create step 3 of 4 of candidate onboarding titled "Connect your GitHub". Stepper with GitHub active. Sage background. A white 24px card: top shows a connected state with GitHub avatar, username "nusrat-codes" and "23 public repositories", with a small "Disconnect" link (also show the unconnected state with a dark "Connect with GitHub" button). Below, a two-column transparency block: left column "What we will read" with check icons: public repositories, languages used, dependency files like package.json, source files you wrote, commit authorship; right column "What we will never read" with x icons: private repositories, your email address, your contacts. Under it, a checkbox "I agree to let FairFold scan my public repositories to verify my skills. I can revoke this at any time." and a small gray note about revoking in Settings. Bottom: tertiary "Back" and a lime "Agree and start verification" button, disabled until the checkbox is ticked. Trust-building, calm.
```

---

#### Page 9: Verification in progress
- **Route:** `/me/verification` | **Role:** Candidate | **Priority:** P0 | **Reqs:** F7, resumable jobs, reliability rule | **Mobile-first**

**Contents**
1. Stepper (step 4 of 4).
2. Big status headline ("Checking your code..."), estimated time ("Usually under 3 minutes").
3. 5-step scan stepper with the current step animated.
4. Live counters: repositories scanned (e.g., 9 of 23), skills checked (3 of 7).
5. Skill rows appearing as results arrive, each with a badge (Verified / Partial / Not verified) or "Checking..." spinner.
6. Variants: **Paused** ("GitHub asked us to wait a moment, resuming automatically"), **Partial/failed** ("We couldn't finish. Your previous results are safe."), **Complete** (summary counts, lime "View my profile").
7. User can leave the page; "We'll keep working."

**Stitch prompt**
```
Create a scan progress screen titled "Checking your code" for step 4 of 4 of candidate onboarding. Sage background, a white 24px card. Top: stepper with Verify active. Headline and a subline "Usually under 3 minutes. You can leave this page, we'll keep working." Then a horizontal five-step progress tracker: Fetch repositories (done), Collect evidence (done), Match skills (active with spinner), Score, Publish. Under it, two stat tiles: "Repositories scanned 9 of 23" and "Skills checked 3 of 7". Below, a list of skill rows: React with Verified badge, Node.js with Verified badge, TypeScript with Partial badge, PostgreSQL "Checking..." with a spinner, Docker, Python and Flutter queued in gray. Also show three variants as separate frames: a yellow banner "GitHub asked us to wait a moment. We'll resume automatically at 14:32", a red-tinted banner "We couldn't finish this scan. Your previous results are safe." with a "Try again" button, and a completed state with summary "4 verified, 1 partial, 2 not verified" and a lime "View my profile" button.
```

---

#### Page 10: Candidate dashboard (my verified profile)
- **Route:** `/me` | **Role:** Candidate | **Priority:** P0 | **Reqs:** F8, F9, F10 | **Mobile-first**

**Contents**
1. Header card: name, headline, location, GitHub link, profile completeness bar.
2. Verification status card: last scan time, rule version, "Re-run verification" button (P1), scan status.
3. **Verified skills** grid: card per skill (name, Verified badge, confidence score, one-line evidence "4 repos, 38 files, last used Aug 2026", "View evidence").
4. **Partial skills**: same cards with yellow badge, toggle "Show partial skills to recruiters" (default off).
5. **Not verified (visible only to you)**: list with reason (e.g., "Listed in a dependency file only, no source files found") and "How to improve" link.
6. Limits note: skills like SQL or design may not show on GitHub.
7. Side panel: "Jobs you match" (3 jobs), "Your contact details are hidden until you apply".

**Stitch prompt**
```
Create a candidate dashboard "My verified profile" for a recruitment platform. Left vertical navigation (Dashboard, Jobs, My applications, Settings) on white, sage page background. Main area: a white 24px profile header card with avatar initials NJ, name "Nusrat Jahan", headline "Junior Full-Stack Developer", Dhaka, GitHub link, and a profile completeness bar at 85%. Next, a verification status card: "Last checked 2 days ago", rule version "v1.2", and a secondary button "Re-run verification". Then a section "Verified skills" as a responsive grid of white cards: React (Verified badge, confidence 0.82 bar, "6 repos, 54 files"), Node.js (0.74), TypeScript (0.68), each with a "View evidence" link. Section "Partial skills" with a yellow-badge card for PostgreSQL (0.45) and a toggle "Show partial skills to recruiters" off. Section "Not verified, visible only to you" with a sage card listing Docker: "Found in a dependency file only, no source files that use it" with a "How to improve" link, and Flutter: "No usable evidence found in public repositories". A soft yellow-tinted note: "Verification confirms code exists, not depth of expertise. Some skills may not appear on GitHub." Right column card "Jobs you match" with three job rows and a note with a lock icon: "Your contact details stay hidden until you apply."
```

---

#### Page 11: Skill evidence detail and dispute
- **Route:** `/me/skills/{skillId}` | **Role:** Candidate | **Priority:** P0 (dispute P1) | **Reqs:** F8, F9, F11, explainability
- **Also reused** inside the recruiter view (page 18) as an expandable section, without the dispute button.

**Contents**
1. Back link, skill name, status badge, confidence meter with the 0.30 and 0.60 thresholds.
2. **Why this status:** plain-language reason and rule version.
3. **Score breakdown** table: authored source files 0.50 (earned x), authored commits 0.20, manifest entry 0.15, recent activity 0.10, multiple repos 0.05, total.
4. **Evidence list:** repo cards with languages, authored files and lines, last commit, flags (Fork excluded, Tutorial clone down-weighted, Trivial repo ignored), "Open on GitHub".
5. For Partial / Not verified: "What would help" suggestions (add a project that uses it, make a repo public, re-run scan).
6. **Dispute (P1):** button opens a modal with a text area, link/attachment field, and submit; after submit, shows dispute status (Pending, Approved, Declined with reason).

**Stitch prompt**
```
Create a skill evidence detail page for the skill "TypeScript" on a developer verification platform. Sage background, white 24px cards. Header: back link, skill name "TypeScript", a pale green Verified badge, and a confidence meter showing 0.68 with tick marks at 0.30 (Partial) and 0.60 (Verified). Card "Why this status": a plain sentence "We found TypeScript source files you wrote in 3 public repositories" and "Rule version v1.2". Card "Score breakdown": a clean table with rows Authored source files 0.28 of 0.50, Authored commits 0.10 of 0.20, Dependency entry 0.15 of 0.15, Recent activity 0.10 of 0.10, Multiple repositories 0.05 of 0.05, and a bold Total 0.68. Card "Evidence": three repository cards, each with repo name, language chips, "12 authored files, 1,430 lines", last commit date, an "Open on GitHub" link, and one repo showing a small gray chip "Tutorial clone, down-weighted". At the bottom, a tertiary button "Disagree? Add evidence" that opens a modal dialog shown in a second frame: textarea "Tell us what we missed", a field "Link to a repository or project", and a lime "Submit dispute" button. Also show a status chip variant "Dispute pending".
```

---

#### Page 12: Browse jobs
- **Route:** `/jobs` | **Role:** Candidate | **Priority:** P0 | **Reqs:** F16 view, F17 | **Mobile-first**

**Contents**
1. Search bar and filters (location, skills).
2. Job cards: title, company, location, posted date, required-skill chips colored by your status (you have / missing), and an **eligibility pill** ("You match 3 of 3" or "Missing 2 skills").
3. Sort: Best match, Newest.
4. Pagination. Empty state ("No jobs match your search").

**Stitch prompt**
```
Create a "Jobs" listing page for a candidate on a developer recruitment platform. Left navigation, sage background. Top: a white search bar "Search jobs" and filter pills for Location and Skills, plus a sort dropdown "Best match". Below, a vertical list of white 24px job cards. Each card has job title, company name and location, posted date, and a row of required-skill chips where skills the candidate has verified show with a green tint and check icon, and missing skills show outlined with a minus icon. On the right of each card an eligibility pill: green "You match 3 of 3" or neutral "Missing 2 skills", plus a "View job" button. Example cards: "Junior Full-Stack Developer, BrightByte Ltd, Dhaka (Eligible)", "Backend Engineer, Cloudline, Remote (Missing Docker, Kubernetes)", "Mobile Developer, AppNest, Dhaka (Missing Flutter)". Pagination at the bottom and an empty-state variant frame "No jobs match your search".
```

---

#### Page 13: Job detail and apply gate
- **Route:** `/jobs/{id}` | **Role:** Candidate | **Priority:** P0 | **Reqs:** F17, F18 | **Mobile-first**

**Contents**
1. Job header: title, company, location, posted date.
2. Description, responsibilities.
3. Required skills and nice-to-have skills.
4. **Match rule** shown before applying: "All required skills" or "At least 3 of 5 required skills".
5. **Gate panel** (sticky): matched skills (check), missing skills (minus) and **Apply** button.
   - Eligible: lime "Apply now". Confirmation modal: "Your contact details will be shared with this recruiter."
   - Not eligible: disabled button, text "Apply is unavailable. You're missing: Docker, Kubernetes", actions "Re-run verification", "View evidence for these skills", "Dispute".
6. Applied state: "Application submitted" with status.

**Stitch prompt**
```
Create a job detail page "Junior Full-Stack Developer" at BrightByte Ltd, Dhaka, for a candidate. Sage background, left navigation. Main column: a white 24px card with the job title, company, location, posted date, a description paragraph, and bullet responsibilities. Below, a card "Skills" showing Required: React, Node.js, TypeScript chips and Nice to have: Docker chip. A line "Match rule: you need all required skills to apply". Right column, a sticky white "Your match" gate card: heading "You match 3 of 3 required skills" with green check rows for React, Node.js, TypeScript (each with a tiny Verified badge), and a full-width lime "Apply now" button. Show a second frame variant of the same page where the card says "You're missing 2 required skills" with minus rows for Docker and Kubernetes, a disabled gray button "Apply unavailable", and links "Re-run verification", "See evidence" and "Dispute a result". Show a third frame: a confirmation modal "Apply to this job?" with the note "Your contact details will be shared with this recruiter" and buttons Cancel and lime "Confirm and apply".
```

---

#### Page 14: My applications
- **Route:** `/me/applications` | **Role:** Candidate | **Priority:** P1 | **Reqs:** F20
- **Contents:** List/table of applications: job title, company, applied date, status pill (Submitted, Reviewed, Shortlisted, Rejected), skills matched at the time of applying, link to job. Empty state with "Browse jobs" button.

**Stitch prompt**
```
Create a "My applications" page for a candidate. Left navigation, sage background. A white 24px card containing a list of application rows. Each row: job title and company on the left, applied date, a small row of matched skill chips ("React, Node.js, TypeScript matched"), and a status pill on the right. Use pills: Submitted (sage), Reviewed (white outlined), Shortlisted (pale green with deep green text), Not selected (neutral gray, gentle wording). Add a status filter tab row (All, Submitted, Reviewed, Shortlisted). Include an empty-state variant with a friendly illustration, "You haven't applied to any jobs yet" and a lime "Browse jobs" button.
```

---

#### Page 15: Candidate settings and privacy
- **Route:** `/me/settings` | **Role:** Candidate | **Priority:** P0 | **Reqs:** F2, F5, data rights

**Contents** (tabs or stacked cards)
1. Profile: name, headline, location, photo optional (note: photo is never used in verification).
2. CV: current file, replace, delete.
3. GitHub connection: connected username, permissions list, consent date and time, **Revoke access** button.
4. Visibility: show partial skills to recruiters (toggle), profile visible in search (toggle).
5. Data: Export my data, **Delete my account** (red) with confirmation modal explaining that CV, repo data and verification results are deleted.
6. Notifications (optional).

**Stitch prompt**
```
Create a candidate "Settings and privacy" page. Left navigation, sage background. A stack of white 24px cards: (1) Profile with inputs for Full name, Headline, Location and a note "Your name, photo and location are never used to verify skills." (2) CV with file row "Nusrat_Jahan_CV.pdf" and buttons Replace and Delete. (3) GitHub connection showing avatar, "nusrat-codes", "Connected on 12 Nov 2026, 10:42", a list of read-only permissions, and a red-outlined "Revoke access" button. (4) Visibility with two toggles: "Show partial skills to recruiters" and "Show my profile in recruiter search". (5) Your data with buttons "Export my data" and a red "Delete my account". Show a modal in a second frame: "Delete your account?" explaining that your CV, repository data and verification results will be permanently deleted, with Cancel and a red "Delete account" button. Calm, clear.
```

---

### C. RECRUITER PAGES

---

#### Page 16: Recruiter dashboard
- **Route:** `/recruiter` | **Role:** Recruiter | **Priority:** P0
- **Contents:** Welcome line; stat tiles (open jobs, new applicants this week, total applicants); quick skill search bar; recent applicants list (name, job, match 3/3, time); "Your open jobs" list with applicant counts; lime "Post a job". Empty state for new recruiters with a 2-step guide (post a job, search talent).

**Stitch prompt**
```
Create a recruiter dashboard for Tanvir Ahmed at BrightByte Ltd. Left navigation (Dashboard, Talent search, My jobs, Settings), sage background. Top row: greeting "Good morning, Tanvir" and a lime "Post a job" pill button. Three stat tiles on white cards: Open jobs 3, New applicants this week 12, Total applicants 47. A prominent search card "Find candidates by verified skills" with a multi-select skills input and a lime "Search" button. A white card "Recent applicants" listing rows with initials avatar, name, job title, a pill "Matches 3 of 3 required skills" and time ago. A white card "Your open jobs" listing three jobs with applicant counts and "View applicants" links. Include a second frame for a brand-new recruiter empty state with a two-step guide: "1. Post your first job" and "2. Search verified talent", with illustrations.
```

---

#### Page 17: Talent search
- **Route:** `/candidates` | **Role:** Recruiter | **Priority:** P0 (filters P1) | **Reqs:** F12, F13 | **Mobile-first**

**Contents**
1. Skill multi-select input with chips (autocomplete from taxonomy), "Verified skills only" note.
2. Filters (P1): minimum confidence, experience, location. Updates without reload.
3. Result cards: initials/avatar (not used for ranking), name, headline, location, experience, **matched verified skill chips with confidence**, count of evidence repos, "View profile". Contact details are never shown here.
4. Result count, sort, pagination (capped per page).
5. Empty state: "No candidates have all these skills verified. Try fewer skills."

**Stitch prompt**
```
Create a talent search results page for recruiters on a platform where skills are verified from GitHub. Left navigation, sage background. Top: a large white search card with a multi-select input containing chips "React", "Node.js", "TypeScript" and a lime "Search" button, plus a line "Results include only candidates with these skills verified." Left filter sidebar on a white card: Minimum confidence slider (0.60 to 1.00), Experience dropdown, Location input. Main column: "18 candidates" with a sort dropdown, then white 24px result cards. Each card: initials avatar, name "Nusrat Jahan", headline "Junior Full-Stack Developer", Dhaka, "1 year experience", then skill rows with Verified badges and tiny confidence bars for React 0.82, Node.js 0.74, TypeScript 0.68, a line "Evidence from 6 public repositories", and a "View profile" button. Contact details are not shown anywhere. Add a masked-contact hint "Contact shown after the candidate applies". Show an empty-state frame: "No candidates have all these skills verified. Try fewer skills." with a secondary button "Clear filters".
```

---

#### Page 18: Candidate profile (recruiter view)
- **Route:** `/candidates/{id}` | **Role:** Recruiter | **Priority:** P0 | **Reqs:** F14, contact-privacy rule

**Contents**
1. Header: name, headline, location, GitHub link, experience.
2. **Locked contact** card: "Email and phone are shown after this candidate applies to one of your jobs."
3. Verified skills list, each expandable inline to show evidence (repos, files, lines, last activity) without leaving the page. Partial skills shown only if the candidate allowed it, labeled clearly.
4. Education and roles (from the CV, candidate-reviewed).
5. Limits note (confirms code exists, not depth).
6. Save to shortlist (P2, can be shown as disabled).

**Stitch prompt**
```
Create a recruiter-facing candidate profile page. Left navigation, sage background. A white 24px header card: initials avatar, "Nusrat Jahan", "Junior Full-Stack Developer", Dhaka, "1 year experience", and a GitHub link. Next to it, a card with a lock icon and masked contact "n••••@••••.com, +880 •••••" with the text "Shown after this candidate applies to one of your jobs." Main section "Verified skills": expandable rows for React (Verified, 0.82), Node.js (0.74), TypeScript (0.68). Show React expanded with an evidence list: three repository rows with repo name, language chips, "12 authored files, 1,430 lines", last commit date and an "Open on GitHub" link. Below, a card "Education and experience" with two timeline items. A soft yellow-tinted note: "Verified means code using this skill exists in the candidate's public work. It does not measure depth of expertise." A disabled gray secondary button "Save to shortlist (coming soon)". Clean, evidence-first layout.
```

---

#### Page 19: My jobs
- **Route:** `/recruiter/jobs` | **Role:** Recruiter | **Priority:** P0 | **Reqs:** F16
- **Contents:** Table/list of jobs: title, status (Open, Closed), required skills chips, match rule, applicant count, posted date, actions (View applicants, Edit, Close, Delete with confirm). Lime "Post a job". Tabs: Open / Closed. Empty state.

**Stitch prompt**
```
Create a "My jobs" management page for recruiters. Left navigation, sage background. Heading "My jobs" with a lime "Post a job" button, and tabs Open (3) and Closed (2). A white 24px card containing a data table with columns: Job title, Required skills (chips), Match rule ("All required" or "At least 3 of 5"), Applicants (number), Posted, Status pill (Open in pale green, Closed in gray), and an actions menu (View applicants, Edit, Close, Delete). Example rows: "Junior Full-Stack Developer" with React, Node.js, TypeScript, 12 applicants; "Backend Engineer" with Node.js, PostgreSQL, Docker, 8 applicants; "Mobile Developer" with Flutter, Dart, 3 applicants. Show a delete confirmation modal in a second frame, and an empty-state variant "You haven't posted a job yet".
```

---

#### Page 20: Create / edit job
- **Route:** `/recruiter/jobs/new`, `/recruiter/jobs/{id}/edit` | **Role:** Recruiter | **Priority:** P0 | **Reqs:** F16, F18

**Contents**
1. Form: job title, description (rich text), location, employment type.
2. **Required skills** picker (taxonomy autocomplete) and **Nice-to-have skills** picker.
3. **Match rule** selector: "All required skills" or "At least N required skills" (number stepper).
4. **Live preview** panel: how candidates see the job and the match rule; shows an estimated count of eligible candidates (optional).
5. Actions: Save changes / Publish (lime), Cancel, Close job.
6. Design note: the apply gate may later become a recruiter option (strict block vs ranking signal), so leave room for a "Gate strictness" control in this form.

**Stitch prompt**
```
Create a job creation form for recruiters titled "Post a job". Left navigation, sage background. Two-column layout. Left: a white 24px form card with inputs Job title, Description (rich text area), Location, Employment type dropdown. Then a "Required skills" multi-select with chips React, Node.js, TypeScript; a "Nice-to-have skills" multi-select with Docker; and a "Match rule" section with two radio cards: "All required skills" (selected) and "At least N required skills" with a number stepper. Right: a sticky white "Candidate preview" card showing how the job appears to candidates, including the line "You need all required skills to apply" and an info line "About 18 candidates currently match". Bottom bar: tertiary "Cancel" and lime "Publish job". Include a small greyed placeholder row labeled "Gate strictness (coming soon)". Clean and structured.
```

---

#### Page 21: Job applicants
- **Route:** `/recruiter/jobs/{id}/applicants` | **Role:** Recruiter (owner) | **Priority:** P0 | **Reqs:** F19, F20 | **Mobile-first (list view)**

**Contents**
1. Job header with summary (title, match rule, open/closed, applicant count).
2. Applicants table: name, **match summary** ("3 of 3"), matched chips, missing chips (if the rule is a minimum), applied date, status dropdown (Submitted, Reviewed, Shortlisted, Rejected), "View".
3. Sort by match, date; filter by status.
4. Empty state ("No applicants yet").

**Stitch prompt**
```
Create an applicants list page for the job "Junior Full-Stack Developer". Left navigation, sage background. Header card with job title, a pill "Open", the line "Match rule: all required skills" and "12 applicants". Below, a white 24px card with a table: Applicant (initials avatar and name), Skill match (e.g. "3 of 3" as a pill), Matched skills (green-tinted chips), Missing skills (outlined chips with minus icon, or "None"), Applied date, Status dropdown (Submitted, Reviewed, Shortlisted, Rejected), and a "View" button. Add filter tabs by status and a sort dropdown "Best match". Provide five realistic rows with mixed statuses. Show an empty-state variant "No applicants yet. Share your job to attract verified candidates."
```

---

#### Page 22: Applicant detail
- **Route:** `/recruiter/jobs/{id}/applicants/{applicationId}` | **Role:** Recruiter (owner) | **Priority:** P0 | **Reqs:** F14, F19

**Contents**
1. Applicant header with **contact details now revealed** (email, phone) and applied date.
2. **Match breakdown for this job:** required skills matched (with evidence links) and missing (snapshot at apply time).
3. Full verified skills with evidence (same component as page 18).
4. Status control (Reviewed, Shortlisted, Rejected) with confirmation.
5. CV download only if the product allows it (open question; design as an optional button).

**Stitch prompt**
```
Create an applicant detail page for a recruiter. Left navigation, sage background. Header white card: initials avatar, "Nusrat Jahan", "Junior Full-Stack Developer", Dhaka, with revealed contact details (email and phone, with copy icons) and "Applied 2 days ago". Next to it a status dropdown "Submitted" and buttons "Mark as reviewed" and a lime "Shortlist". Card "Match for Junior Full-Stack Developer": a row "3 of 3 required skills" and chips with check icons for React, Node.js, TypeScript each with a Verified badge and "View evidence", plus a nice-to-have row where Docker is shown outlined as missing. Below, a card "All verified skills" with a compact list including confidence bars, and a card "Education and experience". A small gray note: "Match is a snapshot from the time of applying." Clear, evidence-first.
```

---

#### Page 23: Recruiter settings
- **Route:** `/recruiter/settings` | **Role:** Recruiter | **Priority:** P0
- **Contents:** Account (name, email, password change), Company (name, website, logo optional), Notifications, Danger zone (delete account with confirmation).

**Stitch prompt**
```
Create a recruiter settings page. Left navigation, sage background. White 24px cards: (1) Account with Full name, Email, and a "Change password" button; (2) Company with Company name "BrightByte Ltd", Company website, optional logo upload; (3) Notifications with toggles "Email me when someone applies" and "Weekly summary"; (4) Danger zone with a red-outlined "Delete account" button and a confirmation modal in a second frame. Lime "Save changes" button at the bottom of the form cards.
```

---

### D. ADMIN PAGES

Admin uses a separate shell: dark ink sidebar, sage page background, same cards.

---

#### Page 24: Admin dashboard
- **Route:** `/admin` | **Role:** Admin | **Priority:** P1 | **Reqs:** F21; success metrics in PRD section 2
- **Contents:** KPI tiles (profile completion rate, median verification time, sampled precision, dispute rate, apply-gate rejection rate); charts (verification volume by status, time per rule version); queues (open disputes, failed jobs, flagged anti-gaming cases); recent activity.

**Stitch prompt**
```
Create an admin overview dashboard. Dark ink sidebar with items Overview, Audit log, Disputes, Users and jobs; sage main background. Top row of white 24px KPI tiles: Profile completion 61%, Median verification time 2m 40s, Verification precision 91%, Dispute rate 4.2%, Apply-gate rejections 18%. Below, two white chart cards: a bar chart "Verification results by status" (Verified, Partial, Not verified) and a line chart "Median scan time by rule version". Then three queue cards: "Open disputes 7", "Failed scan jobs 2", "Flagged for anti-gaming review 5", each with a "Review" link. Include a "Recent activity" list. Use the lime accent only for primary buttons and the dark theme only in the sidebar.
```

---

#### Page 25: Verification audit log
- **Route:** `/admin/audit` | **Role:** Admin | **Priority:** P0 | **Reqs:** F22
- **Contents:** Filter bar (date, action, candidate id, skill, status, rule version); table (time, actor, action, subject, skill, result, confidence, rule version); row click opens a right-side panel with full evidence JSON view, score breakdown, and previous versions of that result. Export button. Pseudonymous ids for deleted accounts.

**Stitch prompt**
```
Create an admin "Verification audit log" page. Dark ink sidebar, sage background. Top filter bar on a white card: date range, action type dropdown, candidate ID, skill, status, rule version, and a tertiary "Export CSV" button. Below, a white 24px card with a dense data table: Time, Actor (worker or admin), Action (Verification completed, Dispute decided, Rule updated), Subject (candidate ID), Skill, Result with badge, Confidence, Rule version. Show a right-side drawer open on one row, containing "Decision details": the score breakdown rows, a collapsible monospace evidence block, previous result history, and the rule version. Header row in small uppercase mono-style labels. Neat and technical, still soft with 24px corners.
```

---

#### Page 26: Disputes queue and review
- **Route:** `/admin/disputes` | **Role:** Admin or reviewer | **Priority:** P1 | **Reqs:** F11, F21
- **Contents:** Queue list (candidate, skill, submitted date, status). Detail view: system's evidence and score on the left, candidate's message and added links on the right, decision buttons (Approve and verify / Decline), required reason text, decision is logged to audit.

**Stitch prompt**
```
Create an admin disputes review screen with a split layout. Dark ink sidebar, sage background. Left column: a white card list "Open disputes (7)" with rows showing candidate, skill, date and a status pill. Right, a detail area for the selected dispute "Nusrat Jahan, Docker": two white cards side by side, "System result" (Not verified, confidence 0.15, reason "Dependency entry only", repository list) and "Candidate's evidence" (message text and two submitted repository links). Below, a required "Decision reason" textarea and buttons: lime "Approve and verify" and white outlined "Decline". A note: "Your decision is recorded in the audit log."
```

---

#### Page 27: Users and jobs management
- **Route:** `/admin/users`, `/admin/jobs` | **Role:** Admin | **Priority:** P1 | **Reqs:** F21
- **Contents:** Tabs Users / Jobs; search; table with role, status, created date, verification summary; actions (view, suspend, reactivate); confirmation modals; job rows with owner, status, applicants, "Close or remove".

**Stitch prompt**
```
Create an admin "Users and jobs" management page. Dark ink sidebar, sage background. Tabs "Users" and "Jobs", a search input and role filter. White 24px card with a table: Name, Role pill (Candidate, Recruiter), Email verified (icon), Status (Active in green pill, Suspended in red pill), Joined date, a verification summary "4 verified, 1 partial" for candidates, and an actions menu (View, Suspend, Reactivate). Show a confirmation modal in a second frame "Suspend this account?" with a reason textarea and a red "Suspend" button. Show the Jobs tab variant with columns Job, Owner company, Status, Applicants, and actions.
```

---

### E. SYSTEM

---

#### Page 28: Error, access and session states
- **Route:** various | **Role:** Any | **Priority:** P0
- **Contents (design as one sheet of variants):** 404 Not found; 403 Not allowed ("You don't have access to this page"); Session expired (log in again); Server error with retry; Maintenance; Offline / slow connection banner (low-bandwidth users).

**Stitch prompt**
```
Create a sheet of system state screens for a developer recruitment platform, each on a sage background with a centered white 24px card, a simple friendly SVG illustration and a lime pill button: (1) "We can't find that page" with "Go to home"; (2) "You don't have access to this page" with "Back to dashboard"; (3) "Your session has expired" with "Log in again"; (4) "Something went wrong on our side" with "Try again"; (5) a slim yellow banner variant at the top of a page: "You seem to be offline. Some features may not work." Keep the tone calm and helpful, with no blame wording.
```

---

## 8. Global UI states to design for every page

| State | What to show |
| --- | --- |
| Loading | Skeleton blocks in sage/white, no spinners over full pages |
| Empty | Friendly illustration, one sentence, one primary action |
| Error | Inline red message plus a recovery action; never lose entered form data |
| Partial / paused scan | Yellow banner with automatic resume message |
| Mobile | 1-column stack, 48 px targets, bottom-fixed primary action where helpful |
| Locked content | Masked data with a lock icon and a reason |

---

## 9. Reusable components to build once

Top bar and role navigation, stepper, form inputs, buttons (3 styles), skill chip (neutral / matched / missing), status badges (Verified / Partial / Not verified), confidence meter, evidence row, score breakdown table, gate panel, scan progress tracker, locked contact card, data table with row drawer, modal, toast, banner (info / warning / error), empty state, footer.

---

## 10. Open questions that affect design (from the PRD and TRD)

| Question | Design impact |
| --- | --- |
| Apply gate stays a hard block, or becomes a recruiter-set option? | Page 13 gate panel and page 20 form should be able to show a "ranking signal" variant. Leave space for it. |
| Match rule: all skills or a minimum? | Pages 13, 20, 21 already support both. |
| First market: Bangladesh only? | Consider Bangla language support and Bangladeshi locations; test long Bangla strings in chips and buttons. |
| Can recruiters download the CV file? | Page 22 CV button is optional. Default is no CV download. |
| Who reviews disputes at launch? | Page 26 may be a simple list at first. |
| GitHub sign-in required or optional? | Pages 3 and 4 show it as optional (P1). |
| Final threshold for "Verified" (0.60 now) | Confidence meter ticks use 0.30 and 0.60; keep them configurable. |

---

## 11. Deliverables checklist for the designer

- [ ] 28 screens at desktop (1440 px); mobile versions of pages marked Mobile-first (1, 3, 4, 6, 9, 10, 12, 13, 17, 21)
- [ ] Component library (section 9) with all states
- [ ] Clickable prototype for the three flows in section 4
- [ ] Empty, loading, error states (section 8)
- [ ] Accessibility check (contrast, focus, status never color-only)
- [ ] Handoff notes for developers (tokens from section 5.1)
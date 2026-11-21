> **Authority:** this is the product's design system, generated for FairFold in Google Stitch. The reference render is the delivered screens in [screens/](screens/README.md); code follows this file.
>
> **Conflict inside this export:** the prose sections describe a sage canvas `#E8EBE6` and 24 px cards, while the token block and the delivered HTML use `#F9F9F9` and 32 px (`rounded-lg`). The token block and the HTML win.

---
name: FairFold Design System
colors:
  surface: '#f9f9f9'
  surface-dim: '#dadada'
  surface-bright: '#f9f9f9'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f3f3f4'
  surface-container: '#eeeeee'
  surface-container-high: '#e8e8e8'
  surface-container-highest: '#e2e2e2'
  on-surface: '#1a1c1c'
  on-surface-variant: '#41493a'
  inverse-surface: '#2f3131'
  inverse-on-surface: '#f0f1f1'
  outline: '#717a68'
  outline-variant: '#c1cab5'
  surface-tint: '#2f6c00'
  primary: '#2f6c00'
  on-primary: '#ffffff'
  primary-container: '#9fe870'
  on-primary-container: '#2e6900'
  inverse-primary: '#91d963'
  secondary: '#5b5f5c'
  on-secondary: '#ffffff'
  secondary-container: '#dbded9'
  on-secondary-container: '#5e625e'
  tertiary: '#5e5f5a'
  on-tertiary: '#ffffff'
  tertiary-container: '#d6d5cf'
  on-tertiary-container: '#5c5c58'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#acf67c'
  primary-fixed-dim: '#91d963'
  on-primary-fixed: '#092100'
  on-primary-fixed-variant: '#225100'
  secondary-fixed: '#e0e3de'
  secondary-fixed-dim: '#c4c7c3'
  on-secondary-fixed: '#191c1a'
  on-secondary-fixed-variant: '#444844'
  tertiary-fixed: '#e4e2dd'
  tertiary-fixed-dim: '#c8c6c1'
  on-tertiary-fixed: '#1b1c19'
  on-tertiary-fixed-variant: '#474743'
  background: '#f9f9f9'
  on-background: '#1a1c1c'
  surface-variant: '#e2e2e2'
typography:
  display-hero:
    fontFamily: Manrope
    fontSize: 56px
    fontWeight: '900'
    lineHeight: 64px
    letterSpacing: -0.03em
  display-hero-mobile:
    fontFamily: Manrope
    fontSize: 36px
    fontWeight: '900'
    lineHeight: 44px
    letterSpacing: -0.02em
  headline-lg:
    fontFamily: Manrope
    fontSize: 40px
    fontWeight: '800'
    lineHeight: 48px
    letterSpacing: -0.02em
  headline-lg-mobile:
    fontFamily: Manrope
    fontSize: 28px
    fontWeight: '800'
    lineHeight: 36px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Manrope
    fontSize: 28px
    fontWeight: '800'
    lineHeight: 36px
    letterSpacing: -0.015em
  headline-sm:
    fontFamily: Manrope
    fontSize: 20px
    fontWeight: '800'
    lineHeight: 28px
    letterSpacing: -0.01em
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-lg:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 20px
    letterSpacing: 0.01em
  label-md:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.02em
  code-snippet:
    fontFamily: JetBrains Mono
    fontSize: 13px
    fontWeight: '500'
    lineHeight: 20px
rounded:
  sm: 0.5rem
  DEFAULT: 1rem
  md: 1.5rem
  lg: 2rem
  xl: 3rem
  full: 9999px
spacing:
  gutter: 1.5rem
  gutter-mobile: 1rem
  margin: 3rem
  margin-mobile: 1.25rem
  space-xs: 0.25rem
  space-sm: 0.5rem
  space-md: 1rem
  space-lg: 1.5rem
  space-xl: 2.5rem
---

## Brand & Style

This design system expresses a forward-leaning, trustworthy, and distinctly contemporary fintech aesthetic tailored for technical recruitment. It merges the institutional credibility of modern financial software with the energetic, accessible ethos of developer-first tooling. The visual language centers on clarity, objective validation, and calm authority.

The UI evokes an emotional response of absolute fairness, technical precision, and refreshing approachability. By abandoning dense enterprise clutter in favor of generous breathing room, crisp structural cards, and high-visibility status tags, candidates and hiring teams navigate verified developer metrics without friction.

The aesthetic philosophy draws on modern soft-minimalism:
- Clean matte surfaces rather than gloss or simulated 3D depth.
- Tactile, high-affordance interactives using expansive pill radii.
- Deliberate typographic scale contrasting ultra-bold geometric headings against crisp, highly legible neutral workhorse text.

## Colors

The palette establishes an organic, modern fintech feel with a calm backdrop and an unmistakable, high-conversion action tone.

### Palette Architecture
- **Canvas Base (`#E8EBE6`):** A soft, calming sage that establishes overall ground tone and relieves ocular fatigue.
- **Card Surface (`#FFFFFF`):** Pure stark white to deliver effortless surface contrast and structural containment without needing heavy drop shadows.
- **Primary Accent (`#9FE870`):** Electric lime green used strictly for key calls to action, active indicators, and high-priority interactive touchpoints. It always takes deep ink `#0E0F0C` foreground text for strict WCAG AAA legibility.
- **Text & Stroke Ink (`#0E0F0C`):** High-density, softened carbon black for headlines, readable copy, and subtle structural outlines.
- **Secondary Ink (`#52564E`):** Mid-tone slate olive for secondary meta-information, timestamps, and placeholder labels.

### Semantic Status Tokens
- **Verified:** Background `#E2F6D5`, Text & Icon `#054D28` (GitHub commit/identity confirmed).
- **Partial:** Background `#FFD11A`, Text & Icon `#4A3B1C` (Awaiting repository webhooks or secondary language proof).
- **Not Verified:** Background `#E8EBE6`, Text & Icon `#0E0F0C` (Unchecked or self-reported data).
- **Error / Critical:** Background `#FDE8E8`, Text & Icon `#D03238` (Failed build validation, broken authorization, or syntax flags).

## Typography

Typography establishes an assertive visual rhythm by pairing an ultra-heavy, contemporary geometric sans with an intensely functional text engine.

- **Headlines (Manrope 800/900):** Provides a robust, tech-forward impact reminiscent of cutting-edge developer platforms and modern financial apps. Tight letter spacing (`-0.01em` to `-0.03em`) lends punchiness to titles, dashboard stat blocks, and verification scores.
- **Body & Controls (Inter 400/500/600):** Selected for its neutral texture, legible numeric figures, and uniform x-height. Handles metadata tables, code-adjacent documentation, and developer skill tags with zero visual clutter.
- **Monospace Accent (JetBrains Mono):** Reserved strictly for Git hashes, repository paths, syntax parameters, and branch references.

## Layout & Spacing

The layout model is built on an uncompromising 4px spatial baseline, structuring an airy 12-column grid format for expansive dashboards and responsive single-column layouts for candidate summaries.

### Grid & Breakpoints
- **Desktop (1200px+):** 12-column layout, max-width 1360px centered, 48px canvas margins, 24px column gutters.
- **Tablet (768px – 1199px):** 8-column layout, 32px canvas margins, 16px column gutters.
- **Mobile (< 768px):** 4-column layout, 20px canvas margins, 16px column gutters.

### Spacing Behavior
- Standard spacing utilizes the 4px cadence (`4px`, `8px`, `16px`, `24px`, `40px`).
- Generous internal padding (24px to 32px) within cards prevents verified metrics, repo feeds, and identity badges from competing.
- Multi-card grids stack with consistent 24px gaps, maintaining uniform rhythm across variable viewports.

## Elevation & Depth

This system avoids dark, skeuomorphic, or dramatic blurred drop shadows in favor of a crisp architectural approach powered by planar contrast:

- **Primary Elevation (Canvas to Card):** Depth is created entirely through surface contrast—pure white (`#FFFFFF`) floating over the canvas soft sage (`#E8EBE6`). No drop shadow is used on default resting cards.
- **Border Definition:** Where cards require visual containment over white nested zones, a flat 1px stroke of `#E0E3DD` or `#0E0F0C` (for interactive strokes) is applied.
- **Interactive Floating State:** For active dropdown menus, flyout popovers, and dragging cards, employ an ultra-subtle, highly diffuse ambient shadow tinted with the slate background tone:
  `box-shadow: 0 12px 32px -4px rgba(14, 15, 12, 0.06);`
- **Focus Rings:** Accessible, solid 2px outline rings positioned with a 2px offset using `#0E0F0C` to ensure uncompromised clarity for keyboard navigation.

## Shapes

The geometric vocabulary balances large, friendly structural corners with pure pill capsules:

- **Cards & Primary Modules:** Fixed 24px corner radius (`rounded-xl` in this configuration), conveying a soft, approachable, modern consumer-fintech sensibility.
- **Interactive Controls:** All buttons, filters, search badges, status indicators, and skill tags utilize full pill radiuses (border-radius: 9999px).
- **Nested Inner Surfaces:** Code snippets, sub-panels, and metric wells inside cards step down to 12px radius, avoiding awkward visual tension with the 24px parent card.

## Components

### Buttons
- **Primary Pill:** 
  - Height: 48px. 
  - Shape: 24px pill radius (`rounded-full`), padded 24px horizontally.
  - Fill: `#9FE870` (Lime). Text: `#0E0F0C` (Manrope 800 or Inter 600).
  - Hover: Opacity shift / brightness adjust (`#8ED85F`), slight scale transform (`scale(1.01)`). Active: `scale(0.99)`.
- **Secondary Pill:** 
  - Height: 48px.
  - Fill: Soft sage `#E8EBE6`. Text: `#0E0F0C`. Border: None.
  - Hover: `#DDE2DA`.
- **Tertiary Pill:** 
  - Height: 48px.
  - Fill: `#FFFFFF`. Text: `#0E0F0C`. Border: 1px solid `#0E0F0C`.
  - Hover: Background `#F5F6F4`.

### Verification Status Pills
- Compact inline badges (Height: 28px, Padding: 4px 12px, Radius: 9999px, Font: Inter 600, 12px):
  - **Verified:** Background `#E2F6D5`, Text `#054D28`, accompanied by a solid 14px check circle SVG icon.
  - **Partial:** Background `#FFD11A`, Text `#4A3B1C`, accompanied by a 14px clock or half-circle glyph.
  - **Not Verified:** Background `#E8EBE6`, Text `#0E0F0C`, accompanied by an info circle icon.
  - **Error:** Background `#FDE8E8`, Text `#D03238`, accompanied by an alert triangle icon.

### Cards & Panels
- **Candidate & Skill Cards:** 
  - Background `#FFFFFF`, Radius: 24px.
  - Padding: 32px desktop, 20px mobile.
  - Zero drop shadow; relies strictly on separation from the `#E8EBE6` background.
  - Border: Optional subtle `#E0E3DD` stroke for dense comparison grids.

### Input Fields & Search Bars
- **Fields:**
  - Height: 48px.
  - Background: `#FFFFFF`. Border: 1px solid `#D8DDD5`. Radius: 12px or full 24px pill for search bars.
  - Text: `#0E0F0C`. Placeholder: `#7D8278`.
  - Focus: 2px solid `#0E0F0C`, zero focus-glow or fuzzy blue halos.

### Selection Controls (Checkboxes & Radios)
- **Checkboxes:** 20px width/height, 6px corner radius. Inactive: `#FFFFFF` fill with 1.5px `#0E0F0C` stroke. Checked: `#0E0F0C` fill with white `#FFFFFF` checkmark or `#9FE870` tick.
- **Radio Buttons:** 20px circular pill with inner nested dot on activation.

### Domain-Specific Components
- **GitHub Metric Pill:** Inline tag pairing an authenticated repo name with a commit frequency sparkline and language identifier dot.
- **Trust Score Gauge:** High-contrast progress bar utilizing `#9FE870` active fills over an `#E8EBE6` track, encased in pure white card modules.
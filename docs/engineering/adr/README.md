# Architecture decision records

One file per decision that is **made** and architectural. Open questions stay in [`../../product/DECISIONS.md`](../../product/DECISIONS.md); this folder records the reasoning once a `D` id closes, so a future reader can see why, not only what.

File name: `ADR-0001-short-slug.md`, numbered in order of creation, never reused or renumbered.

## Template

```markdown
# ADR-0001: <decision>

- **Status:** proposed | accepted | superseded by ADR-000X
- **Date:** YYYY-MM-DD
- **Decision log:** closes D<N> in product/DECISIONS.md
- **Owners:** <names>

## Context
What forced a choice. Constraints, numbers, and the options that were real.

## Decision
The choice, in one paragraph, in the present tense.

## Consequences
What becomes easy, what becomes expensive, and what would make us revisit it.
```

## Index

| ADR | Decision | Status | Date |
| --- | --- | --- | --- |
| — | None recorded yet. The first belongs to the hosting and region choice (D6) | — | — |

The trade-offs already settled in [../SYSTEM_DESIGN.md](../SYSTEM_DESIGN.md) §9 are recorded there and do not need a retroactive ADR unless one is revisited.

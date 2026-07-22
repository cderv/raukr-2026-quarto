# Plan — Quarto project scaffold (Phase 3)

> **Status:** DONE (2026-07-07) — site renders green, hook installs the R render packages, pushed.
> **Date:** 2026-07-07 · **Branch:** `claude/project-continuation-fdg2ir`
>
> The planning cycle is closed (topic-store + project-context + prior-art all confirmed, review
> ledger all-applied). CHANGELOG "Next" prescribes this exact step: stand up the Quarto project so
> `just render` is green, *before* authoring real content. This plan tracks that scaffold.

## Goal

A working Quarto **website** project that renders green from day one, carrying the decided RaukR
look (`_brand.yml`) and the NBIS-mirroring file tree, with **skeleton** slides + labs (front-matter
+ house-style structure + TODO markers, no real teaching content yet). Content authoring (Day 1
deck/lab from prior art) is the *next* phase, not this one.

## Decisions taken here (flagged — non-blocking, easily renamed)

- **Topic-folder names** (the one "still open" item): mirror NBIS for a drop-in fold-back.
  - Day 1 *Introduction to Quarto* → `slides/quarto/` + `labs/quarto/` (exact NBIS match).
  - Day 2 *Quarto projects* → `slides/quarto-projects/` + `labs/quarto-projects/`.
- **Logos:** still unavailable (TODO). `_brand.yml` ships colors+fonts only; no `logo:` block yet,
  so nothing breaks. Dual corner logos added when assets arrive.
- **Profiles:** single profile for now. The full/pre-workshop two-profile split (scaffold plan §G)
  is deferred until there's content to strip — YAGNI. Noted as a follow-up.
- **Format-per-doc** (avoids the multi-format conflict, CLAUDE.md rule): project defaults to
  `format: html`; each deck overrides with `format: revealjs` in its own front-matter (replace
  semantics, not `_metadata.yml` merge).

## File set

- `_brand.yml` — teal palette (`#4C979F` …) + Albert Sans / Fira Mono (project-context § stack).
- `_quarto.yml` — `type: website`, `lang: en`, `quarto-required: ">=1.8"`, brand, html defaults
  (toc right, number-sections, lightbox, `freeze: auto`), navbar linking the two days + setup.
- `theme.scss` — thin reveal layer for the flat RaukR look (`border-radius: 0`, dotted bg).
- `justfile` — grouped recipes: `render`, `preview`, `clean`, `publish` (confirm-guarded).
- `index.qmd` — landing page: pitch + programme table + links.
- `setup.qmd` — participant prerequisites/install (R ≥ 4.5, Quarto ≥ 1.8, packages).
- `slides/quarto/index.qmd`, `slides/quarto-projects/index.qmd` — deck skeletons
  (Learning Outcomes → TODO beats → "What you can do now").
- `labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd` — lab skeletons (scope callout →
  library chunk → `## … Challenge` w/ folded solution → `<details>` Session block).

## Verify

`just render` (or `quarto render`) exits clean; `_site/` has the landing page, both decks (as
revealjs), both labs. Smoke-check one deck renders revealjs (not html) and brand colors apply.

## Done-when

Renders green, committed, pushed. CHANGELOG "Next" advanced to "author Day 1 content".

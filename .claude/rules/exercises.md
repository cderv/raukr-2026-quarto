---
paths:
  - labs/**
  - exercises/**
  - tools/sync-exercises.R
  - tools/publish-exercises.R
  - tools/exercises-scaffold/**
  - setup.qmd
  - _quarto.yml
---

# Rule — how the participant exercises are delivered (edit labs here, ship there)

The hands-on files are **not** delivered from this course website. They live in a separate, tiny
delivery repo — **`cderv/raukr-2026-quarto-exercises`** (English; a GitHub **template**; **year in the
name**) — that participants download on the Setup page with one line, **no git, no GitHub account**:

```r
usethis::use_course("cderv/raukr-2026-quarto-exercises")   # unpacks main to the Desktop
```

This course repo is the **source of truth**; the delivery repo is **generated and pushed from here**.
This rule is the operational short list. When you **edit** labs, follow it; when you **review**, check it.

## The pipeline (one direction only)

```
labs/quarto/*  +  labs/quarto-projects/{starter,solution}/*  +  _brand.yml  +  tools/exercises-scaffold/*
        │  tools/sync-exercises.R   (the ONLY write path — a role manifest)
        ▼
exercises/            ← generated-but-committed tree (the use_course() payload); NEVER hand-edit
        │  tools/publish-exercises.R  (just publish-exercises)
        ▼
cderv/raukr-2026-quarto-exercises @ main   ← what use_course() + the /main/ download buttons read
```

- **`exercises/` is generated. Never hand-edit it.** Edit the **source** — the render-validated files
  under `labs/`, the root `_brand.yml`, or the static `tools/exercises-scaffold/` — then re-generate.
- The manifest (`tools/sync-exercises.R`) reshapes the asymmetric sources into the flat delivery tree:
  flat Day-1 `labs/quarto/` → `day1-intro/` (+ a sibling `solutions/day1/`); split Day-2
  `labs/quarto-projects/{starter,solution}` → `day2-projects/` + sibling `solutions/day2/`. It
  artifact-strips (`_freeze/`, `_site/`, `.html`, `.pdf`, VCS/OS noise) and clean-rebuilds.

## When you touch labs (or `_brand.yml`, or the scaffold) — the checklist

1. **Re-render executable `.qmd`** you changed and stage `_freeze/` (the normal freeze discipline; the
   `check-freeze.sh` commit hook blocks a stale freeze). Lab index pages have a freeze too.
2. **Re-sync:** `just exercises` (regenerates `exercises/`), then **commit `exercises/`**. A course-repo
   drift-guard CI (`.github/workflows/exercises-sync.yml` = `just exercises-check`) fails and names the
   drifted file if you forget — `exercises/` must always match its sources.
3. **Publish when ready:** `just publish-exercises` mirrors `exercises/` onto the delivery repo's `main`
   as one commit and pushes (temp-clone → copy → commit → push; ships **only** `exercises/` content, so
   `.claude/` and site scaffolding never leak). The delivery repo's `render-check.yml` CI then renders
   both solutions + the Typst PDF and asserts the structural invariants below.

## Structural invariants — do not break these (the delivery rests on them)

- **No `_quarto.yml` at or above the day starters** (repo root, `day1-intro/`, `day2-projects/`). That
  absence makes the nested-project "render captured by an ancestor `_quarto.yml`" trap *impossible*.
  `day2-projects/` ships **without** a `_quarto.yml` on purpose — **creating it is the Day-2 exercise**.
- **Solutions are SIBLING folders** (`solutions/day1/`, `solutions/day2/`), never nested inside a day
  folder — a nested solution would be swept into a participant's Day-2 website render.
- **The four Day-1 working/reference files** — `starter.qmd`, `penguins-report.qmd`, `sample-typst.qmd`,
  `penguins-by-species.qmd` — are **off the site render list** (`_quarto.yml` `render:`). They stay under
  `labs/quarto/` **only as sync source**; the exercises-repo CI validates them, not the course site.
  **Don't re-add them to `render:`** (you'd re-introduce a build the delivery repo already owns).
- Keep the payload **tiny** (no `_freeze/`, `_extensions/`, `slides/` in `exercises/`) — 40 laptops pull
  it over venue Wi-Fi. The exercises-repo CI has a zip-size budget that trips on a stray heavy file.

## Gotchas banked from real runs

- **Delivery-repo CI renders each project from the repo ROOT** (`quarto render solutions/day2`, not
  `working-directory: solutions/day2`). A subdir working-directory launches R outside the root renv
  project → `no package called 'rmarkdown'`. Keep new render steps root-relative.
- **Packages = 9** (`dplyr`, `ggplot2`, `ggrepel`, `gt`, `ggokabeito`, `brand.yml`, `prismatic`,
  `knitr`, `rmarkdown`) — `ggokabeito` (the CVD-safe species scale) is easy to miss. Add-a-package =
  edit `tools/exercises-scaffold/DESCRIPTION` + regenerate the scaffold `renv.lock`, then re-sync.
- **Download buttons** (three, in `labs/quarto/index.qmd`) point at
  `raw.githubusercontent.com/cderv/raukr-2026-quarto-exercises/main/…` — they **404 until the repo is
  Public**. `use_course()` also needs Public (no-account download). The files ship locally in the
  download too, so a private repo blocks only the buttons, not the workshop.
- **Commits to the delivery repo carry the instructor's git identity** (Christophe), not Claude — set
  `git config user.email/name` before publishing; `publish-exercises.R` inherits it.

## Versioning — year in the repo name

`main` is the current (rolling) edition; during the live Aug-2026 sessions `main` **is** the 2026
content, so the plain `use_course("cderv/raukr-2026-quarto-exercises")` shorthand is correct
(usethis does **not** support `use_course("owner/repo@ref")` — it 404s). Freeze = freeze the repo near
the workshop. **2027 = a new repo** `raukr-2027-quarto-exercises` via **"Use this template"**, then
repoint the sync target / `publish-exercises.R` default + the one Setup line + the button URLs.

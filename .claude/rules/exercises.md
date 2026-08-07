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
2. **Re-sync:** `just exercises` (regenerates `exercises/`), then **commit any changed files under
   `exercises/`**. The sync is manifest-driven: the two lab guide pages (`labs/quarto/index.qmd` and
   `labs/quarto-projects/index.qmd`) are site pages and are not copied into the payload, so an edit to
   either can legitimately produce no generated diff. Inspect `tools/sync-exercises.R` before claiming
   drift from a path alone. A course-repo
   drift-guard CI (`.github/workflows/exercises-sync.yml` = `just exercises-check`) fails and names the
   drifted file if you forget — `exercises/` must always match its sources.
3. **The site demos read `exercises/` too.** `tools/render-demos.R` (`just demos`, run automatically by
   `just render`) renders the finished documents into `_site/demos/` for showing on screen —
   deliberately from the payload, so the screen matches what participants downloaded. So a re-sync you
   skip also leaves the demos stale. The Day-1 groups are staged into throwaway projects under
   `demos-build/` because the payload ships no `_quarto.yml` there and `--output-dir` only works for
   project renders; the Day-2 solution already is a project and renders where it stands. Never name
   that staging dir with a leading dot — Quarto skips hidden paths when collecting project inputs, so
   it renders nothing and exits 0.
4. **Publish when ready:** `just publish-exercises` mirrors `exercises/` onto the delivery repo's `main`
   as one commit and pushes (temp-clone → copy → commit → push; ships **only** `exercises/` content, so
   `.claude/` and site scaffolding never leak). The delivery repo's `render-check.yml` CI then renders
   both solutions + the Typst PDF and asserts the structural invariants below.
   **Caveat:** it commits *on top* of existing history, it does not replace it. That is fine for
   content updates, but it cannot remove something already committed — on 2026-08-03 the delivery
   repo's `main` had to be rebuilt as a single **orphan** commit to drop two internal references from
   its first two commits. If you ever need to purge rather than update, rebuild the orphan commit and
   force-push; don't reach for `publish-exercises`.

## The last hop has its own guard — `just published-check`

`just exercises-check` guards **labs/ → exercises/**. For a long time nothing guarded
**exercises/ → the repo participants actually download**, and that gap is not theoretical: on
2026-08-03 a review cycle fixed three setup P0s and the Day-2 brand bug, and every one of them sat
in this repo for hours while `use_course()` still served the broken payload (an unguarded `quit()`
that killed the participant's R session, `theme: cosmo` in the Day-2 solution, two idioms in the
README). Nothing was wrong with the review. The fixes were simply never published.

```sh
just published-check    # clones the delivery repo, diffs it against exercises/, exits 1 on drift
```

**Why the student-agent runs cannot catch this.** `.claude/scripts/lab-run.sh` hands the agent a
worktree of *this* repo and `labs/<lab>/index.qmd` — the **source**, never the delivered payload. So
a publish gap is structurally invisible to them, however well they walk the lab. Only this check
looks at what participants download.

Run it before any session, and after any `labs/**` change you thought was finished.

## Structural invariants — do not break these (the delivery rests on them)

- **No `_quarto.yml` at or above the day starters** (repo root, `day1-intro/`, `day2-projects/`). That
  absence makes the nested-project "render captured by an ancestor `_quarto.yml`" trap *impossible*.
  `day2-projects/` ships **without** a `_quarto.yml` on purpose — **creating it is the Day-2 exercise**.
- **Solutions are SIBLING folders** (`solutions/day1/`, `solutions/day2/`), never nested inside a day
  folder — a nested solution would be swept into a participant's Day-2 website render.
- **The five Day-1 working/reference files** are **off the site render list** (`_quarto.yml`
  `render:`): the participant starters (`citations-starter.qmd`, `sample-typst.qmd`, `parameters-starter.qmd`)
  and the solutions (`penguins-report.qmd`, `penguins-by-species.qmd`). They stay under
  `labs/quarto/` **only as sync source**; the exercises-repo CI validates them, not the course site.
  **Don't re-add them to `render:`** (you'd re-introduce a build the delivery repo already owns).
  Adding a sixth takes **three** edits, not one: the sync manifest, a render step in the scaffold's
  `render-check.yml`, **and** — when the file is one a participant is meant to end up with — the
  `groups` manifest in `tools/render-demos.R`. Miss the second and nothing validates the file at all;
  miss the third and the demo hub silently drops it (nothing checks for that either). Note the demos
  are *not* the site `render:` list: they render as their own projects, so this is not a way back in.
- Keep the payload **tiny** (no `_freeze/`, `_extensions/`, `slides/` in `exercises/`) — 40 laptops pull
  it over venue Wi-Fi. The exercises-repo CI has a zip-size budget that trips on a stray heavy file.

## Gotchas banked from real runs

- **Delivery-repo CI installs packages from `DESCRIPTION`** (`r-lib/actions/setup-r-dependencies`).
  No `renv.lock` ships in the payload (dropped 2026-08-06 — it confused participants, and
  participants install latest versions with `install.packages()`, so CI now tests that same
  reality). Keep render steps root-relative like the existing ones.
- **Packages = 9** (`dplyr`, `ggplot2`, `ggrepel`, `gt`, `ggokabeito`, `brand.yml`, `prismatic`,
  `knitr`, `rmarkdown`) — `ggokabeito` (the CVD-safe species scale) is easy to miss. Add-a-package =
  edit `tools/exercises-scaffold/DESCRIPTION` (CI installs from it), the install lines in
  `setup.qmd`, **and** the scaffold `README.md` package line, then re-sync.
- **Download buttons** (three, in `labs/quarto/index.qmd`) point at
  `raw.githubusercontent.com/cderv/raukr-2026-quarto-exercises/main/…`. Both repos went **Public on
  2026-08-03**, so the buttons and `use_course()` now work; they 404 again if either is ever flipped
  back to Private.
- **Commits to the delivery repo carry the instructor's git identity** (Christophe), not Claude — set
  `git config user.email/name` before publishing; `publish-exercises.R` inherits it.

## Versioning — year in the repo name

`main` is the current (rolling) edition; during the live Aug-2026 sessions `main` **is** the 2026
content, so the plain `use_course("cderv/raukr-2026-quarto-exercises")` shorthand is correct
(usethis does **not** support `use_course("owner/repo@ref")` — it 404s). Freeze = freeze the repo near
the workshop. **2027 = a new repo** `raukr-2027-quarto-exercises` via **"Use this template"**, then
repoint the sync target / `publish-exercises.R` default + the one Setup line + the button URLs.

# Lab-run review — Day-2 "Quarto projects" (real `use_course()` unpack)

**Reviewer role:** project-novice participant (fluent R/dplyr/ggplot2, occasional R Markdown; never
built a Quarto *project*, never wrote a `_quarto.yml`/`_brand.yml`).
**Source of truth:** `labs/quarto-projects/index.qmd` only.
**Work dir:** the unpacked `day2-projects/` day-folder (no `_quarto.yml` shipped — creating it is the exercise).
**Date:** 2026-07-23. **Quarto 1.9.38, R 4.6.1.**

## Verdict

Yes — a real beginner can finish this lab solo, start to finish, with essentially no friction. The
migrated prose matches the actual unpacked tree **exactly**: the `day2-projects/` folder ships the
two promised pages (`index.qmd`, `analysis.qmd`) plus `day2-projects.Rproj`, the single-page render
lands `analysis.html` next to its source as claimed, adding `_quarto.yml` collects both pages into
`_site/`, the `_brand.yml` palette compiles into the theme, the `@tbl-means` stretch resolves to
"Table 1", and the freeze demo behaves precisely as the "You should see" boxes promise (skip on the
untouched second render with a frozen timestamp; re-run + ticking timestamp after a code edit). The
day-folder framing, the removal of the old `cd starter/` apparatus, the output-location prose, and
the Troubleshooting notes all describe what I actually saw. The one place a room could *very slightly*
fragment is verification-by-eye: the "navbar turns teal" checkpoint is visual, and a CLI-only
participant (or one who forgets to `quarto preview`/open `_site/index.html`) has no textual tell that
branding applied — but this is a soft edge, not a blocker. Publishing is correctly a watch-me demo
(it needs a git remote/GitHub account the participant doesn't have), and the lab never asks the
participant to run it, so no one gets stranded there.

## Friction log

1. **Starting point · `quarto render analysis.qmd`** — Ran it. Produced `analysis.html` + `analysis_files/`
   right next to the source, exactly as the prose said ("`analysis.html` right next to its source, since
   the folder isn't a project *yet*"). `worked-fine` — the promised output location was literally true.

2. **Website Task 1 · create `_quarto.yml`** — Copied the YAML block verbatim into `day2-projects/`.
   No ambiguity about location (the Task text and both Hint bullets stress "inside `day2-projects/`").
   `worked-fine` — a from-scratch `_quarto.yml` was fully specified; nothing to infer.

3. **Website Task 2 · `quarto render` (whole folder)** — Log showed `[1/2] analysis.qmd`,
   `[2/2] index.qmd`, `Output created: _site/index.html`. Both pages built under `_site/` with
   `search.json` + `site_libs/`; navbar title "Penguin Lab" and Home · Analysis items present in
   `_site/index.html`. `worked-fine`. Beginner note: the bare `quarto render` (no file arg) building
   the *whole project* is the one genuinely new mental model here, and both Task 2 prose and the Hint
   bullet spell it out — good.

4. **Website Task 3 · add `_brand.yml`, re-render** — Copied the brand YAML verbatim; re-rendered.
   `#4c979f` (teal) and `Albert Sans` both appear in the compiled `site_libs/bootstrap/bootstrap*.min.css`.
   `worked-fine` (branding applied). **Beginner-eye note:** the palette does *not* appear inline in the
   HTML — it's baked into compiled CSS — so I could only *confirm* teal by grepping the stylesheet.
   A real participant has no CLI way to see "the navbar turned teal"; they'd need to open
   `_site/index.html` or run `quarto preview`. The "You should see" box is entirely visual. Not a
   blocker, but the checkpoint assumes a browser is open.

5. **Website Task 4 (stretch) · `@tbl-means` into a sentence** — The task says "drop `@tbl-means` into a
   sentence" but not *where*. I appended a sentence at the end of `analysis.qmd`. Rendered to
   "Table&nbsp;1". `had-to-infer` (placement) → correct outcome. The `index.qmd` plain
   `[analysis](analysis.qmd)` link the task points at already exists in the shipped file, as stated.

6. **Ship Task 1 · add `execute: freeze: auto`** — Appended the block verbatim to `_quarto.yml`.
   `worked-fine`.

7. **Ship Task 2 · the visible tell** — Added a `cat(format(Sys.time()))` cell to `analysis.qmd`.
   First render wrote `_freeze/` and printed `2026-07-23 07:56:59`. **Second render, no edits:** the
   `analysis.qmd` log showed *no* cell compute (just `[1/2] analysis.qmd`) and the timestamp stayed
   `07:56:59`. Then I edited the plot's `labs(y=...)` and re-rendered: cells `[setup]`, `[fig-mass]`,
   `[freeze-tell]` re-ran and the timestamp advanced to `07:57:21`. `worked-fine` — matched the
   "You should see" box precisely; this is the clearest single beat in the lab.

8. **Ship Task 3 · find `_site/`** — Present, contains the full deliverable. `worked-fine`.

9. **Publish (watch-me / attempted per brief)** — Ran `quarto publish gh-pages`. Real error:
   `ERROR: Unable to publish to GitHub Pages (the remote origin does not have a branch named
   "gh-pages"…)`. Expected — the unpack has no git remote/GitHub auth. `worked-fine` in the sense
   that the lab **never instructs the participant to run this** (it's explicitly a watch-me demo,
   auth pre-flighted), so a real participant never hits this. Correct framing.

**Tag counts:** `worked-fine` ×8 · `had-to-infer` ×1 · `ambiguous` 0 · `undefined-term` 0 ·
`error-recovered` 0 · `BLOCKER` 0.

## Tree-vs-prose fidelity (the migration checks requested)

- **Day-folder framing:** accurate. Working folder is `day2-projects/`; I was already in it; no `starter/`.
- **Deleted `cd starter/` apparatus:** gone; prose says "Everything you render lands inside
  `day2-projects/`; there's no project folder above it" — verified true (the unpack root above holds
  `day1-intro/`, `day2-projects/`, `solutions/`, `renv.lock`, etc., and **no** `_quarto.yml`, so
  nothing upstream claims the pages).
- **`day2-projects.Rproj` double-click pointer:** the file exists — accurate.
- **Create `_quarto.yml`/`_brand.yml` from scratch:** both fully specified as copy-paste blocks; a
  novice needs no outside knowledge.
- **Output locations:** single-page → next to source; project → `_site/`. Both verified; the
  Troubleshooting "Look in those two places" note is honest.
- **`solutions/day2/` pointer:** the sibling `solutions/` folder exists at the unpack root (seen when
  listing the day-folder's parent). Per role rules I did **not** open/list inside it, so I cannot
  confirm the `day2/` *subfolder* name from inside — but the referenced parent is present.

## Top improvements (ranked)

1. **`labs/quarto-projects/index.qmd` § Website Challenge "You should see"** — the teal checkpoint is
   purely visual: *"the navbar and headings turn **teal** with Albert Sans"*. A participant working in
   the terminal (or who renders but doesn't preview) has no textual confirmation. Add one concrete
   "how to look" instruction to the box, e.g. *"open `_site/index.html` in your browser (or run
   `quarto preview`) — the navbar bar should be teal."* One sentence closes the only real gap.

2. **`labs/quarto-projects/index.qmd` § Website Challenge Task 4 (stretch)** — *"on `analysis.qmd`,
   drop `@tbl-means` into a sentence"* doesn't say **where**. Beginners hesitate. Suggest a spot,
   e.g. *"add a sentence just after the table chunk, like `@tbl-means summarises the means.`"* Turns a
   small infer into a copy-paste.

3. **`labs/quarto-projects/index.qmd` § Ship it Task 2 (optional polish)** — the "no compute in the log"
   tell is subtle; on my skipped render the only signal was the *absence* of `[setup]/[fig-mass]` lines
   and an unchanged timestamp. The prose already leans on the timestamp (good). Consider noting that
   participants should *watch for the missing `[cell]` lines* in the log too, so they know where to look
   — the current *"the log shows no compute"* is accurate but a novice may not know the `n/n [label]`
   lines are what disappears.

Overall: this is a clean, well-migrated, self-contained lab. It stood up to a literal from-scratch run
with zero blockers and only one minor "where do I put it" inference.

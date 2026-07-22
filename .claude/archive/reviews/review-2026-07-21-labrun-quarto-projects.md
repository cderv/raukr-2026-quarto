# Lab-run friction report — Day-2 "Quarto projects" lab

- **Role:** project-novice participant (fluent R/dplyr/ggplot2; has knit single R Markdown docs;
  **never** built a Quarto project, `_quarto.yml`, or `_brand.yml`).
- **LAB_PAGE:** `labs/quarto-projects/index.qmd` (only source of instructions).
- **WORK_DIR:** `/tmp/claude-labruns/labrun-quarto-projects-69b5e9a/labs/quarto-projects/starter`
- **Quarto:** 1.9.38. **Solution folder:** not opened (forbidden).
- **Artifact produced:** yes — a working `starter/_site/` (two linked pages + teal navbar, frozen build).

## Verdict

Yes — a real beginner can finish this lab solo, end to end. It is unusually well-scaffolded: every
Task ships the exact YAML to paste, the "cd starter/ first" trap is called out three times, and the
freeze test has a *visible* pass/fail (the `Sys.time()` tell) instead of asking a novice to read a
build log. Both Challenges completed with zero blockers and near-zero inference. The room would only
fragment at two soft spots, neither fatal: (1) the Scope callout tells you to `renv::restore()` once,
but the shipped `starter/` has **no renv project** and `renv` isn't even installed here — run
literally it throws "there is no package called 'renv'", and a careful beginner will stall wondering
if their toolchain is broken (it isn't; `dplyr`/`ggplot2` are already on the path and every render
worked). (2) The stretch step says to *add* a Markdown link to `index.qmd`, but that exact link is
**already in the shipped `index.qmd`** — a novice re-reads the file, sees the link, and isn't sure
whether they've done the task or missed something.

## Friction log

1. **Scope callout · read packages / `renv::restore()`** — Scope says *"in the project `renv` — run
   `renv::restore()` once, which also installs the `knitr`/`rmarkdown` engine"*. I checked `starter/`:
   no `renv/`, no `renv.lock`, no `DESCRIPTION`. Ran it as instructed:
   `Rscript -e 'renv::restore()'` → **`renv not installed` / "there is no package called 'renv'"**.
   Every subsequent render worked anyway (packages pre-installed), so I inferred the restore step is
   a no-op in this starter and moved on. **Tag: `had-to-infer`** — *"It told me to run a command that
   errors, in a folder that has no renv project; I only knew to ignore it because the renders
   happened to work."*

2. **Starting-point callout · `cd starter/` + `quarto render analysis.qmd`** — ran it; got a normal
   `analysis.html` next to the source. Matches the promised behavior exactly. **Tag: `worked-fine`** —
   *"Clear, and the 'not a project yet, so output lands next to source' framing pays off immediately."*

3. **Website Challenge Task 1 · create `_quarto.yml`** — pasted the provided YAML verbatim into
   `starter/_quarto.yml`. No error. **Tag: `worked-fine`** — *"Copy-paste block removes all guesswork
   about indentation."*

4. **Website Challenge Task 2 · `quarto render` (whole folder)** — built `[1/2] analysis.qmd` +
   `[2/2] index.qmd` → `_site/index.html`. Both pages + `search.json` in `_site/`. **Tag:
   `worked-fine`** — *"The 'one _quarto.yml makes it a project' claim is instantly visible in the
   two-file build log."*

5. **Website Challenge Task 3 · add `_brand.yml`, re-render** — pasted the block; re-rendered; grep of
   `_site/site_libs/bootstrap/*.css` confirms `#4C979F` (teal) is baked into the theme. Never touched a
   header line — auto-discovery worked as the Hint promised. **Tag: `worked-fine`** — *"'auto-discovered
   at the project root, no header line needed' was true and reassuring for someone who's never seen
   `_brand.yml`."*

6. **Website Challenge Task 4 (stretch) · `@tbl-means` on `analysis.qmd`** — added a sentence with
   `@tbl-means`; re-render produced `<a href="#tbl-means" class="quarto-xref">Table&nbsp;1</a>`. Resolved
   to a live "Table 1" link, exactly as advertised. **Tag: `worked-fine`** — *"The within-page cross-ref
   'just worked'; the callout that it only works within one page set the right expectation."*

7. **Website Challenge Task 4 (stretch) · plain link on `index.qmd`** — the task: *"point to the analysis
   page with a plain Markdown link — `[the analysis](analysis.qmd)`"*. But the **shipped** `index.qmd`
   already contains `Head to the **[analysis](analysis.qmd)**`. So the "add a link" action was already
   done in the starter. I inferred the point is only to *observe* that across-page links are plain
   Markdown (no auto-number), and left the existing link. **Tag: `ambiguous`** — *"I was told to add a
   link that's already there; a beginner can't tell if the step is complete or if they were supposed to
   change something."*

8. **Ship-it Task 1 · add `execute: freeze: auto` to `_quarto.yml`** — appended the block; no error.
   **Tag: `worked-fine`**.

9. **Ship-it Task 2 · two-render skip test** — added `#| label: freeze-clock` / `cat(format(Sys.time()))`
   cell to `analysis.qmd`. 1st `quarto render`: cells executed, `_freeze/analysis/execute-results/html.json`
   written, timestamp `T1 = 2026-07-21 11:14:44`. 2nd `quarto render` (no edit): **no per-cell progress
   printed** for analysis.qmd and `T2 = 11:14:44` — identical. The visible tell worked perfectly. **Tag:
   `worked-fine`** — *"Seeing the same clock on render 2 is a genuinely convincing 'it skipped' — much
   better than being told to squint at a log."*

10. **Ship-it Task 2 (cont.) · edit plot code, re-render** — changed the y-axis label in the plot cell;
    re-render re-executed analysis.qmd (cells 1–9 ran) and `T3 = 11:15:19` — the clock finally ticked.
    Behavior matched the "only that page re-runs, timestamp advances" promise. **Tag: `worked-fine`**.

11. **Ship-it Task 3 · find `_site/`** — present with `index.html`, `analysis.html`, `search.json`,
    navbar carrying "Home" and "Analysis". **Tag: `worked-fine`**.

12. **Optional (Scope + "You should see") · branded plot via `brand.yml` package /
    `theme_brand_ggplot2()`** — not a Task step, so nothing to do, but it's dangled in three places
    ("Optional branded plots use the `brand.yml` package", "the plot keeps its default species colors —
    branding an R plot needs `theme_brand_ggplot2()`", Troubleshooting repeats it). For a novice this
    introduces a function/package that is never taught or exercised. I did not install
    `brand.yml`/run it (no task required it). **Tag: `undefined-term`** — *"`theme_brand_ggplot2()` is
    named three times but never shown; I kept wondering if I was supposed to make the plot teal too."*

## Tag counts

- `worked-fine`: 9
- `had-to-infer`: 1
- `ambiguous`: 1
- `undefined-term`: 1
- `error-recovered`: 0 · `BLOCKER`: 0

## Top improvements (ranked, with the lab's own wording)

1. **`labs/quarto-projects/index.qmd` · Scope callout — the `renv::restore()` line.** It reads:
   *"**Packages:** `dplyr`, `ggplot2` (in the project `renv` — run `renv::restore()` once …)."* The
   shipped `starter/` has no `renv/`, no `renv.lock`, no `DESCRIPTION`, and `renv` isn't installed, so
   running it literally errors. Either (a) ship a minimal `renv.lock`/`DESCRIPTION` in `starter/` so the
   instruction is true, or (b) soften it to *"if your toolchain is already set up (see Setup page) you
   can skip this; otherwise `install.packages(c("dplyr","ggplot2"))`"*. As written it's the most likely
   thing to make a careful beginner think their environment is broken when it isn't.

2. **`labs/quarto-projects/index.qmd` · Website Challenge Task 4 (stretch) — the `index.qmd` link.**
   *"Then, on `index.qmd`, point to the analysis page with a plain Markdown link —
   `[the analysis](analysis.qmd)`"* — but the starter `index.qmd` already ships
   `[analysis](analysis.qmd)`. Reword to acknowledge it's already there and make the step an
   *observation*, e.g. *"Notice `index.qmd` already links to the analysis with a plain Markdown link
   `[analysis](analysis.qmd)` — that's deliberate: across pages there's no auto-numbering, so a link is
   how you connect website pages."* Removes the "did I already do this?" stall.

3. **`labs/quarto-projects/index.qmd` · Scope / "You should see" / Troubleshooting —
   `theme_brand_ggplot2()`.** Mentioned three times as the way to brand the plot, but never taught and
   not a step. For a project-novice it's noise that invites a detour. Either demote it to a single
   one-line *"(plots aren't auto-branded; that's a separate `brand.yml`-package trick, out of scope
   today)"*, or drop two of the three mentions.

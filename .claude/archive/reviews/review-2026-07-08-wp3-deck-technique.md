# Review — WP3 Day-2 deck (technique)

- **Date:** 2026-07-08
- **Reviewer role:** Quarto technique
- **Scope:** one file — `slides/quarto-projects/index.qmd` (revealjs, uncommitted, `_freeze/` present)
- **Branch:** `claude/goal-command-wx5go6`
- **Environment:** Quarto 1.9.38, R 4.6.1, `brand.yml` R package installed
- **Out of scope (not re-flagged):** Day-1 deck, CORE/DEMO/MENTION triage, Part1/Part2 split,
  beat-lock timings, dataset choice. The cross-references slide's "cross-page numbering is a
  *book* feature, not a website one" is the intended CORRECT fix — validated, not flagged.

## Overall verdict

Technically clean and ships green. `LANG=C.UTF-8 quarto render slides/quarto-projects/index.qmd`
produces `_site/slides/quarto-projects/index.html` with no errors; the two executed chunks
(`setup`, `fig-mass`) run against the committed freeze. Every headline claim I could falsify holds
against Quarto 1.9 and the installed R stack: base-R penguins column names (`bill_len`, `bill_dep`,
`body_mass`, `species`) are exact; `theme_brand_ggplot2()` is a real export of the installed
`brand.yml` package; the `_quarto.yml`/`_metadata.yml`/`output-dir` precedence and defaults are
right; the freeze-vs-cache contrast and the "committed `_freeze/` + `freeze: true` → CI renders
without R" arc are accurate; the `_brand.yml` snippet is valid *and* matches the repo's real
`_brand.yml` (`#4C979F`, `primary: teal`, Albert Sans/google). No invalid format keys, no invented
YAML, no broken reveal classes, no missing shortcode/extension, no `%>%`, no RStudio-only framing.
Zero P0, zero P1. Three small P2 robustness notes below — the only one with teeth is that the
R-side brand snippet omits `library(brand.yml)`, so as-shown it wouldn't run if copy-pasted.

## 🔴 P0 — blocking technical bug

None.

## 🟠 P1 — fix before the event

None.

## 🟡 P2 — nice-to-have / robustness

### P2-1 — `_brand.yml` R snippet omits `library(brand.yml)` (`index.qmd:179-184`)

```r
library(ggplot2)
ggplot(penguins, aes(bill_len, bill_dep)) +
  geom_point() +
  theme_brand_ggplot2()   # RaukR palette
```

`theme_brand_ggplot2()` lives in the `brand.yml` package (confirmed:
`getNamespaceExports("brand.yml")` lists it). As written the block loads only `ggplot2`, so a
literal copy-paste errors with `could not find function "theme_brand_ggplot2"`. This is a
display-only block (not executed), and the speaker note at `:189-193` correctly flags the
`install.packages("brand.yml")` setup, but the *slide the room sees* is the incomplete one. Add
`library(brand.yml)` (or write `brand.yml::theme_brand_ggplot2()`) so the shown code is
runnable-as-is. Low effort, removes a live "why doesn't it work" question.

### P2-2 — precedence chain omits the cell-level tier (`index.qmd:92`)

> Precedence is intuitive: **document header** > `_metadata.yml` > `_quarto.yml`.

Correct for the folder-vs-project point being made, and fine to keep simple. Strictly, a code-cell
option (`#| echo: false`) overrides the document header for that cell — the true chain is
cell > document > `_metadata.yml` > `_quarto.yml`. Since the very next `_metadata.yml` example
sets `execute.echo`, a participant who then puts `#| echo: true` on one chunk will see it win. One
optional half-sentence ("…and a cell option beats them all") pre-empts that. Not wrong as stated;
just incomplete.

### P2-3 — `data(penguins)` is redundant (`index.qmd:21`)

`datasets` is attached by default in R ≥ 4.5, so `penguins` is already in scope; `data(penguins)`
is harmless but unnecessary. Purely cosmetic — drop it or leave it; no behavioral impact.

## ✅ Technical choices validated

- **Render:** green in the sandbox; output lands where the project config says (`_site/…`), freeze
  honored, no font-fallback blockers surfaced.
- **Data:** base-R penguins columns used (`bill_len`, `bill_dep`, `body_mass`, `species`) match
  `datasets::penguins` exactly (verified R 4.6.1) — *not* the palmerpenguins long names. `|>` used
  (`:22`), no `%>%` anywhere.
- **Chunk hygiene:** only `setup` (`include: false`) and `fig-mass` (`echo: false`, with `fig-cap`
  + `fig-alt`) execute; every other fence is a non-executed display block (` ``` yaml `/` ``` r `/
  ` ``` bash `/` ``` markdown `), so no accidental execution. Dash-key `#|` options throughout.
- **`_quarto.yml`/`output-dir` (`:54-71`):** `type: website` + `output-dir: _site`; "`_site` by
  default" is correct for website projects; "publish *that*" is the right instruction.
- **`_metadata.yml` (`:82-93`):** valid `execute`/`format.html` folder-scoped keys; precedence
  ordering correct (see P2-2 for the one omitted tier).
- **Website nav (`:101-112`):** `navbar.left`/`sidebar.contents: auto` well-formed; `listing:`
  aside (`:131-134`) accurately scoped.
- **Cross-references (`:136-154`):** the deliberate fix is technically right — within-page
  `@fig-`/`@tbl-`/`@sec-`/`@eq-` resolve; website pages render independently so cross-*page* refs
  don't auto-number, and the `type: book` callout is the correct escalation. The "(Verify on your
  Quarto build…)" hedge is appropriate.
- **`_brand.yml` (`:163-187`):** snippet is valid brand syntax (`color.palette`/`color.primary`,
  `typography.fonts[].source: google`, `typography.base.family`) *and* consistent with the repo's
  real `_brand.yml` (teal `#4C979F`, `primary: teal`, Albert Sans). "HTML, revealjs, and Typst read
  `_brand.yml` natively" is true for 1.9; `theme_brand_ggplot2()` is a real export; "a plot won't
  inherit the palette until you add `theme_brand_*()`" is the honest, correct caveat.
- **Freeze vs cache (`:216-230`):** `cache` = within-doc knitr reuse, `freeze` = project-level
  frozen `_freeze/` not re-executed at build → CI without R. `execute.freeze: true` is the right
  choice for the "edit prose → re-render → code didn't run" demo (`auto` would re-run on file
  change). Line `:230` ("shows across two renders") is precise — it implicitly accounts for the
  first render creating the freeze.
- **renv (`:232-249`):** `renv::snapshot()`/`renv::restore()` correct; "two legs" framing accurate.
- **Publishing (`:256-277`):** `quarto render` → `_site/`; `quarto publish gh-pages` + GitHub
  Actions rendering from committed `_freeze/` "with no R on the runner" is accurate; watch-me
  framing (auth cliff, CI can't run live) is technically sound. Editor-agnostic (CLI-based).
- **Demos (`:299-310`):** `format: dashboard` correctly described as a static row/column/card/
  valuebox layout; htmlwidget (plotly/leaflet, self-contained R) vs OJS (browser-side non-R) vs
  Shinylive (link) split is accurate; book-vs-website decision framed correctly.
- **Reveal mechanics:** `slide-level: 2`, `{.center}` section slides, `::: {.columns}`/`.column`,
  global `incremental: false` with opt-in `::: {.incremental}` and `. . .` fragments, callout
  classes (`callout-note`/`tip`/`warning` with `title=`), `::: notes` — all valid. Lab link
  `../../labs/quarto-projects/index.qmd` resolves (file exists); `../../theme.scss` exists.

## 📝 Evolution since the previous review

First technical review of this file (newly authored WP3 deck, previously non-existent). Against the
`topic-store.md` Day-2 CORE table and the beat-lock (`the tracker`), the deck lands every locked
CORE beat with technically correct content and no fabricated features: `_quarto.yml` + `output-dir`
+ `_metadata.yml`-as-shown-slide, website nav, the cross-page-refs-are-a-book correction, the
one-file/three-surfaces `_brand.yml` with the mandatory `theme_brand_*()` "renders grey without it"
caveat, freeze-vs-cache with the CI-without-R payoff, the `renv.lock` second leg (correctly marked
cut-first), and the render+`output-dir` hands-on with publish as watch-me. The single actionable
carry-forward is P2-1 (add `library(brand.yml)` to the shown R snippet).

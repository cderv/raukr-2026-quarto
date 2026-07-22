# Technique review — WP1 Day-1 deck `slides/quarto/index.qmd`

- **Date:** 2026-07-07
- **Reviewer:** workshop-reviewer-technique (Quarto correctness)
- **Scope:** ONLY `slides/quarto/index.qmd` (uncommitted working tree; reference commit `31cae8e`).
  Lab skeleton `labs/quarto/index.qmd` out of scope. WP0 assets read for consistency only.
- **Environment:** Quarto **1.9.38**, R **4.6.1**, knitr **1.51**, `brand.yml` R pkg installed.

## Overall verdict

Technically this is a clean, correct deck — no blocking or must-fix issues found. Every
Quarto feature claim I sanity-checked holds against Quarto 1.9 docs and the installed
toolchain: the `#|`/`%%|` cell-option split, the `knitr::inline_expr()` shown-syntax trick
(verified in both spots via the frozen render), the cross-reference label rules, the Typst
"bundled since 1.4 / `--to typst` / no LaTeX" claims, the `_brand.yml` schema, the R-side
`theme_brand_ggplot2()`/`theme_brand_gt()` helpers, and the "Quarto downloads Google fonts for
Typst automatically" claim (confirmed in the official Typst-brand docs). The revealjs single-format
override, the `.qmd`→`.html` lab links inside the website project, and the `content-visible
when-format` / multi-format statements are all correct. Only a few cosmetic precision nits remain,
all P2.

## 🔴 P0 — blocking technical bug

None.

## 🟠 P1 — fix before the event

None.

## 🟡 P2 — nice-to-have / robustness

- **`slides/quarto/index.qmd:251` — `#| cache: true # reuse results within a doc`.** The gloss
  "reuse results within a doc" undersells (and slightly mis-states) knitr caching: `cache` persists
  to disk and is reused *across renders*, not merely "within a doc". More importantly, this project
  sets `execute:\n  freeze: auto` (`_quarto.yml:61-62`), which is the mechanism this audience will
  actually rely on; teaching `cache` without a word on `freeze` risks confusion. Consider swapping
  the example line to `#| cache: true` → `# reuse results across renders` and/or mentioning `freeze`
  as the project-level analogue. Non-blocking.

- **`slides/quarto/index.qmd:202-203` — outset/inset gloss.** "spills *beyond* the body (outset) or
  widens while keeping the margins (inset)" is a defensible lay description, but "inset" in Quarto's
  column model (`.column-page-inset`, `.column-screen-inset`) specifically means *page/screen-width
  but pulled in from the screen edge* — it keeps a gap from the **viewport edge**, not "the [body]
  margins". A reader may read "keeping the margins" as "staying inside the body". If you want
  precision, "widens toward the page/screen but insets from the edge". Spoken + glossed, so low
  priority.

- **`slides/quarto/index.qmd:121` — illustrative refs don't match a real label.** The bullet lists
  `@tbl-summary` (inline code, illustrative only) but the actual referenceable table on
  `:152` is `tbl-mean`, and the real figure is `fig-bill`. Because these are in backticks they are
  *not* live cross-refs, so nothing breaks (confirmed: only one real `fig-bill`, one real
  `eq-ratio`, no duplicate-label conflict). Purely cosmetic — a sharp participant scanning for
  `tbl-summary` won't find it. Optionally align the example name to `@tbl-mean`.

- **`slides/quarto/index.qmd:22` — `data(penguins)` is redundant.** In R ≥ 4.5 `penguins` is
  lazy-loaded from `datasets` and always available, so `data(penguins)` is a no-op load. Harmless,
  and it lives in an `#| include: false` setup chunk (invisible to the audience), so this is a
  trivia-level note only — arguably keep it for explicitness.

## ✅ Technical choices validated

- **Format / project wiring.** Deck declares `format: revealjs` only (`:5-14`); the website project
  (`_quarto.yml:6` `type: website`) defaults pages to `format: html`, and the deck's own
  front-matter overrides with replace semantics → single-format, **no multi-format preview
  conflict**. `theme: [default, ../../theme.scss]` resolves (theme.scss present at root, 479 B).
- **Cell-option syntax.** `#|` hash-pipe for R cells and `%%|` for the mermaid cell (`:69-70`) are
  both correct and are a nice, accurate teaching contrast. Dashes-not-dots throughout
  (`fig-cap`, `fig-alt`, `output-location`, `include`). `#| include: false` correctly hides setup.
- **`output-location: column` / `fragment`** (`:136`, `:153`) are valid revealjs-only code-cell
  options — used appropriately.
- **The `knitr::inline_expr()` shown-syntax trick — verified against the frozen render.** In the
  anatomy block (`:98`, inside a ```` ```` markdown```` ```` fence) it evaluates to the literal
  `` `r nrow(penguins)` `` (not the wrapper), and in the callouts slide (`:193-194`) the wrapped
  form shows literal syntax while the bare `` `r nrow(penguins)` `` evaluates to **342**. Both
  behaviours confirmed in `_freeze/.../html.json`. `knitr::inline_expr` exists (knitr 1.51).
- **Cross-references.** `@fig-bill` (`:142`) → real cell at `:131`; `$$…$$ {#eq-ratio}` (`:170-172`)
  is the only *live* equation (the one at `:162-166` is inside a fenced code block, not rendered),
  `@eq-ratio` (`:168`) resolves. Label-prefix rule stated at `:143` is correct for the shown types.
- **Mermaid.** `flowchart LR`, `<br>` line breaks, `([...])`/`[...]` node shapes all valid; `%%|
  fig-alt:` present. Renders (confirmed prior; freeze holds a figure asset).
- **Typst claims.** "ships inside Quarto / no LaTeX toolchain" (`:354`), "bundled from Quarto 1.4+,
  target ≥1.8" (`:368`), and `quarto render report.qmd --to typst` (`:364`) are all accurate for
  1.9.38.
- **`_brand.yml` claims.** The slide's mini-example (`:383-392`: `color.palette`/`color.primary`,
  `typography.fonts[].source: google`, `typography.base.family`) is valid brand.yml and matches the
  real root `_brand.yml`. **"Quarto fetches Google fonts for Typst automatically" is confirmed** by
  the official Typst-brand docs (Quarto downloads Google Fonts into a local cache and registers them
  for `typst compile`). R-side `theme_brand_ggplot2()` and `theme_brand_gt()` **both exist** in the
  installed `brand.yml` package.
- **Multi-format / conditional content.** `format: [html, docx]` (`:236`) and
  `::: {.content-visible when-format="html"}` (`:238`) are correct syntax. The layout caveat
  (`:206-209`) correctly warns the body/margin/column model is an HTML & Typst article idiom that
  does **not** transpose to revealjs — accurate and important.
- **Links / paths.** `[Lab](../../labs/quarto/index.qmd)` (`:281`, `:405`) points at `.qmd` and, in
  a `type: website` project, Quarto rewrites it to `.html` at render — correct best practice; the
  target file exists. No empty `(#)` placeholders anywhere.
- **R idioms (2026 house line).** Native pipe `|>` throughout, `summarise(..., .by = species)`
  (dplyr ≥1.1), `gt() |> fmt_number(bill, decimals = 1)`, base-R `penguins` short columns
  (`bill_len`/`bill_dep`, confirmed on R 4.6.1). **No `%>%`.** `knitr::convert_chunk_header()`
  (`:85`) exists (knitr 1.51) and is the right Rmd→qmd migration pointer.
- **Editor framing.** `:261-276` is editor-agnostic (CLI-first, Positron + VS Code + RStudio), with
  the accurate caveat that the visual editor is an RStudio-only feature — matches the 2026 house
  line and the "Positron minimal" locked decision.

## 📝 Evolution since the previous review

First technique review of this deck (WP1, just authored). The prior technique pass covered the WP0
shared assets (`penguins-report.qmd`, `sample-typst.qmd`, `references.bib`, `apa.csl`, committed at
`31cae8e`); this deck is consistent with them (same base-R `penguins`, same `_brand.yml`, same
Typst/CSL payoff). No regressions introduced; the deck already lands green as revealjs. Nothing from
this review rises above P2, so no re-review is required before the event — apply the P2 polish at
authoring discretion.

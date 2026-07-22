# Technique review — WP2 Day-1 lab (`labs/quarto/index.qmd` + `starter.qmd`)

- **Date:** 2026-07-07
- **Reviewer:** workshop-reviewer-technique
- **Scope (this round):** ONLY `labs/quarto/index.qmd` and `labs/quarto/starter.qmd` (WP2, uncommitted; reference commit `bb42f07`). Deck `slides/quarto/index.qmd` (WP1) and WP0 assets (`penguins-report.qmd`, `sample-typst.qmd`, `references.bib`, `apa.csl`) read only for consistency, not re-reviewed.
- **Environment:** Quarto `1.9.38`; base-R `datasets::penguins`; project `_brand.yml` present at root; `_freeze/` staged.

## Overall verdict

Technically clean and ship-ready. Both documents render green as HTML, all three
relative links (`penguins-report.qmd` → `.html`, `starter.qmd` → `.html`,
`sample-typst.qmd` → `.pdf`) resolve and are correctly rewritten by the website
project, and every Task is doable exactly as written to produce the stated "You should
see" result. The delicate bits — the folded solution chunk that displays `#|` cell
options *inside* an `#| eval: false` body, the citations→Typst payoff, and the `--to
typst` override on a `format: html` document — are all correct and confirmed against the
frozen render, the shipped WP0 config, and the Quarto 1.9 docs. No P0, no P1; three P2
polish notes only.

## 🔴 P0 — blocking technical bug

None.

## 🟠 P1 — fix before the event

None.

## 🟡 P2 — nice-to-have / robustness

- **`index.qmd:48` and `index.qmd:140` — bare `::: {.callout}` for the Tasks blocks emits a "None" screen-reader label.**
  A typeless callout is a legitimate Quarto construct: it renders as
  `<div class="callout callout-style-simple callout-none no-icon callout-titled">` — a
  neutral, icon-less titled box, clearly the intent (visually distinct from the semantic
  `callout-note`/`callout-tip`). The only wart is accessibility: the rendered title is
  `<span class="screen-reader-only">None</span>Tasks`, so assistive tech announces
  "None, Tasks." Purely a robustness nicety; if you want to silence it, `::: {.callout
  appearance="simple"}` behaves the same but you could also give it an explicit neutral
  type. Not worth changing unless a11y is a stated goal for the handout.

- **`starter.qmd:4` — `author: "Your name"` renders literally.**
  Sensible as a fill-in-the-blank placeholder (and consistent with the starter being a
  standalone doc, unlike the lab page which suppresses author via `author: ""`). Worth
  knowing that a participant who never edits it ships a PDF authored by "Your name". A
  one-word cue (e.g. `author: "Your name here"`) or a comment would nudge them, but this
  is fine as-is.

- **`index.qmd:65` — "three separated clusters" slightly overstates the plot.**
  For base-R `penguins`, bill length vs depth separates Gentoo cleanly but Adelie and
  Chinstrap overlap in bill depth (they part mainly on length). The `fig-alt` on the same
  figure hedges correctly with "largely separate clusters" (`index.qmd:67`,
  `index.qmd:78`). Cosmetic wording; borderline pedagogue territory.

## ✅ Technical choices validated

- **The folded solution chunk renders `#|` lines literally, as intended.**
  `sol-authoring` (`index.qmd:95-123`) carries its real options on the contiguous leading
  lines (`label`, `code-fold`, `code-summary`, `eval: false`); the first body line is a
  plain comment (`# --- figure (cross-referenced) ---`), so knitr stops option parsing and
  the subsequent `#| label: fig-bill` / `#| column: margin` / `#| tbl-cap:` lines are
  treated as literal code. Confirmed against the frozen render — the block emits as
  `` ```{.r .cell-code code-fold="true" code-summary="Solution — the key chunks"} `` with
  the inner `#|` lines shown verbatim. `#| eval: false` means none of it executes, so the
  literal `#| label: fig-bill` / `tbl-summary` text creates **no duplicate-label
  collision** with the lab's own executed `fig-target` chunk. Same mechanism validated for
  `sol-citations` (`index.qmd:181-200`).

- **Citation instructions are correct and match a proven config.**
  `bibliography: references.bib` + `csl: apa.csl` (`index.qmd:143-145`), the
  `[@gorman2014]` in-text cite (`index.qmd:147`), and the
  `## References {.unnumbered}` + `::: {#refs} :::` div (`index.qmd:151-155`) are exactly
  the setup the shipped, green-rendering WP0 `penguins-report.qmd` and `sample-typst.qmd`
  use. The `@gorman2014` key is real (proven by those assets).

- **The Typst hint is technically accurate for Quarto 1.9.**
  "Typst reads the `.bib` itself, so keep bibliography fields plain — avoid LaTeX macros
  like `\emph{}`" (`index.qmd:175-176`) matches the default Quarto Typst path: citations
  go through Typst's native `#bibliography` (biblio.typ), with `csl:` applied by Typst, not
  pandoc `\emph{}`-style LaTeX. The "downloads the brand's Google fonts on first render"
  note (`index.qmd:177-178`, `index.qmd:216-217`) is the correct caveat.

- **`quarto render your-doc.qmd --to typst` is valid** (`index.qmd:160`) even though the
  participant's document declares only `format: html`: `--to` adds/overrides the target
  format, and project `_brand.yml` is auto-discovered, so the branded PDF is produced with
  Typst defaults. Verified `_brand.yml` exists at project root.

- **All relative links resolve in the website project.** Rendered `_site/labs/quarto/index.html`
  rewrites `[penguins-report.qmd](penguins-report.qmd)` → `../../labs/quarto/penguins-report.html`,
  `[starter.qmd](starter.qmd)` → `starter.html`, and `[sample-typst.qmd](sample-typst.qmd)` →
  `sample-typst.pdf` (Quarto correctly maps the Typst doc to its `.pdf` output). All three
  targets are in the `_quarto.yml` render list.

- **Tasks are doable → produce the "You should see" result.** Authoring: `format: html` +
  setup chunk → `fig-bill` (`@fig-bill`), `tbl-summary` (`@tbl-summary`), `#| column: margin`
  counts, `$$…$$ {#eq-ratio}` (`@eq-ratio`) yield Figure 1 / Table 1 / margin counts /
  Equation 1. Citations: header keys + cite + `#refs` div → *(Gorman et al., 2014)* + APA
  list, then `--to typst` for the branded PDF. Both flows match the shipped `starter.qmd`
  and `penguins-report.qmd`.

- **Cell-option hygiene.** Every `#|` key is dash-form (`fig-cap`, `fig-alt`, `tbl-cap`,
  `code-fold`, `code-summary`, `column`, `label`); no dotted keys. Multi-line `fig-alt: >-`
  block scalars (`index.qmd:77`, `starter.qmd:48`) are well-formed. `fig-alt` present on
  every live figure.

- **R runs on a participant's machine.** Setup uses `dplyr`, `ggplot2`, `gt` (all in
  `DESCRIPTION` `Imports:`), plus `knitr::kable` / `knitr::combine_words` (knitr in
  `Imports:`). `data(penguins)` + `bill_len`/`bill_dep` columns are correct for base-R
  `penguins` (R ≥ 4.5). All idioms are `|>`, no `%>%`.

- **Migration handled per house rule 4.** `knitr::convert_chunk_header()` (`index.qmd:38`)
  is a real function; the R Markdown note is a collapsed `callout-tip collapse="true"` aside
  after the setup, not the opener.

- **Troubleshooting callout is accurate for 1.9** (`index.qmd:205-220`): YAML
  indentation-sensitivity, `install.packages`/`renv::restore()`, relative-path/case,
  `?@…` cross-ref and citation-key diagnostics, and the `_brand.yml`-at-root + first-render
  network caveat all hold. The `?@gorman2014` / `[?]` strings here and in "You should see"
  are deliberate `<code>` examples, not broken refs (as flagged in the brief).

## 📝 Evolution since the previous review

First technique review of the WP2 lab — no prior snapshot to diff against. Relative to the
already-reviewed WP0/WP1 layer it builds on, the lab reuses their proven citation +
Typst-payoff configuration verbatim rather than inventing a parallel path, which is why the
delicate pieces (folded `#|`-in-`eval:false` display, `--to typst` override, `#refs` div,
brand-on-Typst) all land correctly on the first pass. House lab idiom (scope `callout-note`
→ setup chunk → `## … Challenge` → `callout-tip collapse` hint → folded `#| code-fold` /
`#| eval: false` solution → `<details>` Session block) is followed consistently across both
challenges.

## Checks run

- `quarto --version` → `1.9.38`; `git log` confirms reference commit `bb42f07`.
- Read both in-scope files in full; cross-read `_quarto.yml`, `_brand.yml` presence,
  `DESCRIPTION` `Imports:`, and WP0 asset headers for consistency.
- Extracted the frozen `sol-authoring` block from
  `_freeze/labs/quarto/index/execute-results/html.json` — confirmed inner `#|` lines render
  literally inside the `code-fold` cell.
- Inspected `_site/labs/quarto/index.html` for link rewriting (all 3 targets resolve) and
  callout classes (bare `.callout` → `callout-none` titled box, with a "None" screen-reader
  label).
- Verified the Typst citation/bibliography path via Context7 (Quarto 1.9 changelog: native
  `#bibliography`/biblio.typ, brand fonts under Typst).

# Lab run — Introduction to Quarto (Day 1), beginner participant

- **Date:** 2026-07-21
- **Lab page:** `labs/quarto/index.qmd`
- **Persona:** daily R user (dplyr/ggplot2, occasional R Markdown); never built a Quarto project,
  never wrote `_quarto.yml`/`_brand.yml`, never done citations or Typst.
- **Artifacts produced:** `my-report.html` (both challenges) + `my-report.pdf` (branded Typst).

## Verdict

Yes — a real beginner could finish this lab solo, and probably inside the ~30-min-per-part budget.
Nearly every piece of syntax the tasks demand (the setup cell, the hash-pipe cross-ref labels, the
YAML header block, the `#refs` div, the two Typst routes) is handed over verbatim in the task boxes
or the folded solutions, so there is very little to invent. Both my HTML cross-references and the
citation resolved on the first render, and the Typst PDF built with only the exact "harmless"
warnings the Troubleshooting box predicts. The one place the room would briefly fragment is the
**Citations Challenge tasks, which are all worded as if you are editing `starter.qmd`** ("The
starter already has the sentence…", "replace the **starter's** `author: "Your name"` line") even
though the "Starting point" callout explicitly invites you to keep going on your *own* document —
a participant on the own-doc path has to mentally translate every "the starter" into "my file."

## Friction log

1. **Scope callout / setup — "run `renv::restore()` once".** I checked the five packages
   (`dplyr`, `ggplot2`, `gt`, `knitr`, `rmarkdown`) were installed rather than literally running
   `renv::restore()`, because the project `renv/` lives above my lab folder and I didn't want to
   touch it; all five were present. Toolchain: Quarto 1.9.38, R 4.6.1. — `had-to-infer` — *A
   novice would just run `renv::restore()`; nothing here misled me, I just short-circuited it.*

2. **Authoring Task 1 — create the new `.qmd`.** Made `my-report.qmd` next to `references.bib`/
   `apa.csl`, `format: html`, pasted the setup cell verbatim. — `worked-fine` — *Unambiguous; the
   "next to references.bib / apa.csl" hint told me exactly where to put it.*

3. **Authoring Tasks 2–4 — figure, table, margin cross-refs.** Used `#| label: fig-bill` /
   `tbl-summary` / `column: margin` and `@fig-bill`/`@tbl-summary` in prose exactly as written; the
   `gt` plumbing was supplied. — `worked-fine` — *The "label must start with fig-/tbl-" hint is the
   one bit of new Quarto knowledge needed and it's stated plainly.*

4. **Authoring Task 5 (stretch) — display equation.** Pasted the `$$…$$ {#eq-ratio}` block
   verbatim, escaped underscores as instructed, referenced with `@eq-ratio`. — `worked-fine` —
   *The pre-warning about `bill_len` becoming a subscript saved me a debugging loop.*

5. **Authoring Task 6 — render HTML.** `quarto render my-report.qmd --to html`. Output created;
   `@fig-bill`/`@tbl-summary`/`@eq-ratio` rendered as live "Figure 1 / Table 1 / Equation 1", no
   `?@` markers, counts in the right margin. Matches "You should see" exactly. — `worked-fine`.

6. **Citations "Starting point" + Tasks 1–4 phrasing.** The callout says *"If you finished the
   Authoring Challenge, keep going on your own document."* I did. But then **Task 2** says *"The
   starter already has the sentence …collected at Palmer Station, Antarctica. — just insert the
   citation before the period"* and **Task 4** says *"replace the **starter's** `author: "Your name"`
   line."* On my own doc neither literally applies — I had to infer I should (a) make sure my prose
   contained that Antarctica sentence to hang `[@gorman2014]` on, and (b) treat my own `author:`
   line as "the starter's." Small translation, but a literal-minded beginner on the own-doc path
   could stall looking for a sentence/line that isn't there. — `ambiguous` / `had-to-infer` — *The
   task steps are written for the starter path only; the own-doc path is invited but not re-worded.*

7. **Citations Tasks 1–4 edits.** Added `bibliography: references.bib` + `csl: apa.csl`, the
   `author:`/`affiliation:` block, `[@gorman2014]` in prose, and the `## References {.unnumbered}` +
   `::: {#refs}` block — all pasted from the task boxes. — `worked-fine`.

8. **Citations Task 5 — render HTML, confirm citation.** In-text rendered as "(Gorman et al.,
   2014)", APA reference list present, no `?@gorman2014`/`[?]`. — `worked-fine` — *Verbatim YAML +
   a correct bib key made this a non-event, which is the point.*

9. **Citations Task 6 — branded Typst PDF (CLI route).** `quarto render my-report.qmd --to typst`.
   PDF built next to the source (`my-report.pdf`, 121 KB) exactly as the "Where the PDF lands"
   note predicts for a brand-new doc. It emitted a wall of `warning: unknown font family:
   sans-serif / Apple Color Emoji / …` from the `gt` table's default font stack — which the
   Troubleshooting box pre-declares as *"Harmless — a plain `gt` table emits them … the PDF still
   builds."* Because that note exists I did **not** panic. — `worked-fine` — *This is the single
   scariest-looking output in the lab (dozens of red warning blocks) and the lab defuses it in
   advance; without that note it would be a BLOCKER-feeling moment.*

10. **Could not visually confirm branding.** No `poppler-utils`/`pdftoppm` in this environment, so
    I couldn't render the PDF page to eyeball the RaukR palette/fonts. The absence of brand-font
    (Albert Sans / Fira Mono) warnings — only the `gt` default stack warned — is indirect evidence
    the brand fonts resolved. — not lab friction (environment limitation); *a participant on a real
    laptop would just open the PDF.*

## Tag counts

- `worked-fine`: 7
- `had-to-infer`: 1 (plus 1 shared with ambiguous)
- `ambiguous`: 1
- `undefined-term`: 0
- `error-recovered`: 0
- `BLOCKER`: 0

## Top improvements (ranked)

1. **`labs/quarto/index.qmd` · Citations Challenge → Tasks 2 & 4.** Re-word the starter-specific
   phrasing so the own-doc path (which the "Starting point" callout actively invites) reads
   cleanly. Current: *"The starter already has the sentence "…collected at Palmer Station,
   Antarctica." — just insert the citation before the period"* and *"replace the starter's
   `author: "Your name"` line."* Suggest neutral wording, e.g. *"Find (or add) the sentence
   ending "…Palmer Station, Antarctica." and insert `[@gorman2014]` before the period"* and
   *"replace your document's `author:` line with:"*. This is the only spot where a literal beginner
   on the recommended path can look for something that isn't in their file.

2. **`labs/quarto/index.qmd` · Citations Challenge → Task 6 (Typst) or its "You should see" box.**
   The Troubleshooting note about the harmless `unknown font family` warnings is excellent but lives
   several callouts *below* the render step. Consider a one-line inline heads-up right at Task 6
   ("you'll see a stack of `unknown font family` warnings — expected, see Troubleshooting"), so a
   participant reads it *before* the scary output scrolls past, not after they've already flinched.

3. **`labs/quarto/index.qmd` · Scope callout.** Minor: the callout says `renv::restore()` "also
   installs the knitr/rmarkdown engine every `.qmd` with R code needs," which is reassuring, but a
   fast way to confirm the toolchain without a full restore (the promised `quarto check` on the
   Setup page) could be surfaced one click closer — several participants will already have the
   packages and won't know whether to run restore anyway.

# Coverage-gap audit — Day 1 (single document): authoring · single-doc output · computations · presentations

- **Date:** 2026-07-07
- **Type:** coverage (ad-hoc scope) — region: **authoring + single-document output + computations + presentations**
- **Yardstick:** `topic-store.md` Day-1 triage (Part 1 = Basics → HTML; Part 2 = Citations → Typst).
- **Audience frame:** advanced R / life-science researchers who **write manuscripts**; fluent R, basic Quarto; Quarto ≥1.8 (target 1.9.x); one dataset = penguins.
- **Method:** each topic judged against fetched quarto.org pages (URLs cited inline), not from memory.

---

## Verdict

The Day-1 triage is **well-shaped and correctly load-limited** — nothing rated CORE is a mis-fit, and the STORE list (LaTeX/PDF mechanics) is right to lead with Typst. But the triage has **seven genuine absences**, and every one is *cheap* and *manuscript-relevant* — they are exactly the "value-add over R Markdown" deltas this audience came to level up on. None needs a dedicated slot; all fit as one-line deltas or a single slide inside beats you already teach. The one structural risk is that the **"Markdown & content" CORE bucket is doing far more work than its "compress, they know the basics" label admits** — it now has to carry figures + tables + cross-refs **+ math + inline code + callouts**, and that is under-budgeted at "fast deltas."

**Gaps found: 7** (ranked below). **Mis-triages: 1** (the Markdown/content bucket is heavier than labeled). **Redundancy: 4 merges** to protect time.

## TOP GAPS (ranked — all ABSENT from the triage)

1. **Math / LaTeX equations** — ABSENT, and this is a *research* audience. `$…$` / `$$…$$` render out of the box ([markdown-basics](https://quarto.org/docs/authoring/markdown-basics.html)); a labeled display equation `$$…$$ {#eq-x}` cross-referenced with `@eq-x` ([cross-references](https://quarto.org/docs/authoring/cross-references.html)) is a one-slide delta. **Worth a slot? No — a CORE delta inside Markdown&content.** Cheapest highest-relevance win on the board.
2. **Title blocks / front matter** — ABSENT. The Part-2 payoff is literally "a manuscript," yet author/affiliation/abstract/ORCID/keywords/DOI is untaught ([front-matter](https://quarto.org/docs/authoring/front-matter.html)). A proper scholarly title block is the difference between "a doc" and "a manuscript." **Worth a slide** — fold into the Citations→Typst payoff.
3. **Callouts as a taught feature** — ABSENT as *content* (the deck uses them only as mode-markers). Five types, `collapse`, custom title — trivial to teach ([callouts](https://quarto.org/docs/authoring/callouts.html)) and a signature Quarto-over-Rmd win. **Worth a mention** (~1 min; you're already showing them on screen).
4. **Word (`docx`) output** — ABSENT. The collaborator/journal-submission format (track changes, co-authors on Word) for a manuscript audience ([ms-word](https://quarto.org/docs/output-formats/ms-word.html), reference-doc templates). **Worth a name-check** in the "one source → many formats" demo — it costs one line in `format:`.
5. **Inline code** (`` `r expr` ``) — ABSENT. Report the n / p-value / date *from the data* in prose — the reproducible-manuscript feature ([execution-options](https://quarto.org/docs/computations/execution-options.html)). **Worth a one-line delta** in the authoring value-adds beat.
6. **Conditional content + HTML multi-format links** — ABSENT. Completes the "one source, many formats" story: `.content-visible when-format=…` ([conditional](https://quarto.org/docs/authoring/conditional.html)) and the reader-facing "Other Formats" download links ([html-multi-format](https://quarto.org/docs/output-formats/html-multi-format.html)). **Worth a mention**, not a slot.
7. **Diagrams (mermaid/graphviz)** — ABSENT. Pipeline/workflow figures are attractive to bioinformaticians, but PDF/**Typst** output needs a Chrome install ([diagrams](https://quarto.org/docs/authoring/diagrams.html)) — friction against the no-install Typst promise. **Mention + link only**, never on the Day-1 critical path.

---

## Full mapping table

### Authoring

| Topic | Quarto page | Fit Day-1? | In triage? | Recommendation | Why |
|---|---|---|---|---|---|
| Markdown Basics | [markdown-basics](https://quarto.org/docs/authoring/markdown-basics.html) | yes | CORE (Markdown&content) | keep | Teach as deltas; note it *contains* math + callouts + diagrams. |
| **Math / equations (LaTeX)** | [markdown-basics](https://quarto.org/docs/authoring/markdown-basics.html) · [cross-references](https://quarto.org/docs/authoring/cross-references.html) | yes | **ABSENT** | **add-CORE-delta** | Research audience; `$$…$$ {#eq-x}` + `@eq-x` is a must-show, ~1 slide. **TOP GAP 1**. |
| Callout Blocks | [callouts](https://quarto.org/docs/authoring/callouts.html) | yes | **ABSENT (as content)** | **add-MENTION** | Signature Rmd→Quarto win; already on screen as mode-markers. **TOP GAP 3**. |
| Figures | [figures](https://quarto.org/docs/authoring/figures.html) | yes | CORE | keep | `fig-cap`/`fig-alt`/subfigs/`@fig-`; computed from R. |
| Tables | [tables](https://quarto.org/docs/authoring/tables.html) | yes | CORE | keep | Markdown + `@tbl-`; R-side path is `gt` (already in stack). |
| Cross References (+options/div/custom) | [cross-references](https://quarto.org/docs/authoring/cross-references.html) | yes | CORE | keep | Note sub-types: `@eq-`, subfigures/subtables, `@sec-`; theorems/custom = skip. |
| Citations | [citations](https://quarto.org/docs/authoring/citations.html) | yes | CORE | keep | Correctly CORE; the Typst path uses its *own* citation system — smoke-test `csl:` in Typst (already flagged). |
| Diagrams | [diagrams](https://quarto.org/docs/authoring/diagrams.html) | edge | **ABSENT** | **add-MENTION (link)** | mermaid/dot appealing, but PDF/Typst needs Chrome — off critical path. **TOP GAP 7**. |
| Article Layout | [article-layout](https://quarto.org/docs/authoring/article-layout.html) | yes | CORE (Layouts) | keep | High value for manuscripts (margin figs/captions, `column-page`). Scope-watch: teach margin+page, skip screen/landscape. |
| Title Blocks / Front Matter | [front-matter](https://quarto.org/docs/authoring/front-matter.html) | yes | **ABSENT** | **add-MENTION→slide** | author/affiliation/abstract/ORCID — the manuscript payoff needs it. **TOP GAP 2**. |
| Variables | [variables](https://quarto.org/docs/authoring/variables.html) | no | ABSENT | skip | `{{< var >}}`/`_variables.yml` is a projects idiom, not single-doc. |
| Shortcodes | [shortcodes](https://quarto.org/docs/authoring/shortcodes/) | edge | MENTION | keep | Correctly demoted; fold `include`/`embed`/`video` into a link. |
| Code Annotation | [code-annotation](https://quarto.org/docs/authoring/code-annotation.html) | yes | MENTION | keep | In "code presentation niceties"; good for slides/teaching. |
| Videos | [videos](https://quarto.org/docs/authoring/videos.html) | no | ABSENT | skip | Not a manuscript need. |
| Includes | [includes](https://quarto.org/docs/authoring/includes.html) | edge | ABSENT | skip Day-1 (→Day-2) | Reuse across files is a *projects* concern; low single-doc value. |
| Appendices | [appendices](https://quarto.org/docs/authoring/appendices.html) | edge | ABSENT | skip/MENTION | Auto citation/reuse/license appendix is nice but niche. |
| Conditional Content | [conditional](https://quarto.org/docs/authoring/conditional.html) | edge | **ABSENT** | **add-MENTION** | Completes multi-format story (`when-format`). **TOP GAP 6a**. |
| Document Language | [document-language](https://quarto.org/docs/authoring/language.html) | no | ABSENT | skip | i18n irrelevant to an English single-language session. |
| Placeholder Text/Images | [lipsum shortcode](https://quarto.org/docs/authoring/markdown-basics.html) | no | ABSENT | skip | Presenter convenience, not taught content. |
| Creating Citeable Articles | [create-citeable-articles](https://quarto.org/docs/authoring/create-citeable-articles.html) | edge | ABSENT | skip/MENTION | Making *your* article citeable (CFF) — niche; overlaps front-matter `citation:`. |
| Embedding from Other Documents | [notebook-embed](https://quarto.org/docs/authoring/notebook-embed.html) | no | ABSENT | skip | `{{< embed >}}` notebook cells — a notebook/projects topic. |
| `_brand.yml` (multiformat branding) | [brand](https://quarto.org/docs/authoring/brand.html) | yes | in Part-2 DEMO | keep | Styles the Typst PDF payoff; deep dive is Day-2. |

### Output formats (single doc)

| Topic | Quarto page | Fit Day-1? | In triage? | Recommendation | Why |
|---|---|---|---|---|---|
| HTML Basics | [html-basics](https://quarto.org/docs/output-formats/html-basics.html) | yes | CORE (implied — Part 1 lands HTML) | keep | toc/anchors/self-contained; the default target. |
| HTML Code Blocks | [html-code](https://quarto.org/docs/output-formats/html-code.html) | yes | MENTION (code niceties) | keep | `code-fold`/`code-tools`/copy — house style already opts in per chunk. |
| HTML Theming | [html-themes](https://quarto.org/docs/output-formats/html-themes.html) | edge | via `_brand.yml` | **merge → brand** | Don't teach Bootswatch separately; `_brand.yml` supersedes it in our story. |
| Lightbox | [lightbox](https://quarto.org/docs/output-formats/lightbox.html) | yes | MENTION | keep | `lightbox: auto` — easy modern win. |
| PDF Basics | [pdf-basics](https://quarto.org/docs/output-formats/pdf-basics.html) | no | STORE | skip (1-line) | TinyTeX install friction — the reason we lead with Typst. |
| PDF Engines | [pdf-engine](https://quarto.org/docs/output-formats/pdf-engine.html) | no | STORE | skip | lualatex/xelatex mechanics → resources. |
| PDF Improvements | [pdf-improvements](https://quarto.org/docs/output-formats/pdf-improvements.html) | no | ABSENT | skip | LaTeX-side; irrelevant when leading Typst. |
| Word Basics / Templates | [ms-word](https://quarto.org/docs/output-formats/ms-word.html) | yes | **ABSENT** | **add-MENTION** | Collaborator/journal format (track changes, reference-doc). **TOP GAP 4**. |
| Typst Basics | [typst](https://quarto.org/docs/output-formats/typst.html) | yes | CORE (payoff) | keep | Bundled, no LaTeX, deterministic — CORE is well-justified. Calibrate: image-sizing edge cases still open. |
| Typst Custom Formats | [typst custom](https://quarto.org/docs/output-formats/typst-custom.html) | no | ABSENT | skip | Extension-based; payoff uses `_brand.yml`, not a custom format. |
| Typst CSS | [typst-css](https://quarto.org/docs/output-formats/typst-css.html) | no | ABSENT | skip | Advanced styling; beyond the slot. |
| Typst Gathering Packages | [typst gather](https://quarto.org/docs/output-formats/typst.html) | no | ABSENT | skip | Offline package bundling — advanced ops. |
| Page Layout | [page-layout](https://quarto.org/docs/authoring/article-layout.html) | yes | CORE (Layouts) | **merge → Article Layout** | Same topic/page; don't split. |
| HTML Multi-Format | [html-multi-format](https://quarto.org/docs/output-formats/html-multi-format.html) | edge | **ABSENT** | **add-MENTION** | Reader-facing "Other Formats" download links tie the payoff together. **TOP GAP 6b**. |

### Computations

| Topic | Quarto page | Fit Day-1? | In triage? | Recommendation | Why |
|---|---|---|---|---|---|
| Using R | [using-r](https://quarto.org/docs/computations/r.html) | yes | under Exec-options DEMO | keep (don't re-teach) | Audience knows chunks; show only the `#|` delta. |
| Parameters | [parameters](https://quarto.org/docs/computations/parameters.html) | no | MENTION (→Day-2) | keep | Correctly moved; override needs the CLI (`-P`), which lives in Day-2. |
| Inline Code | [execution-options](https://quarto.org/docs/computations/execution-options.html) | yes | **ABSENT** | **add-MENTION delta** | `` `r n` `` in prose = reproducible manuscript. **TOP GAP 5**. |
| Execution Options | [execution-options](https://quarto.org/docs/computations/execution-options.html) | yes | DEMO | keep | Show the `#|` per-cell syntax delta vs Rmd chunk headers. |
| Caching | [caching](https://quarto.org/docs/computations/caching.html) | no | ABSENT | skip Day-1 (→Day-2) | Pairs with `freeze` — a Day-2 CORE, correctly not here. |
| Rendering Script Files | [render-scripts](https://quarto.org/docs/computations/render-scripts.html) | no | ABSENT | skip | `.R` + `#'` spin-off — niche. |

### Presentations

| Topic | Quarto page | Fit Day-1? | In triage? | Recommendation | Why |
|---|---|---|---|---|---|
| Revealjs | [revealjs](https://quarto.org/docs/presentations/revealjs/) | yes | CORE (Document types) | keep | The deck *is* revealjs — demonstrated implicitly; teach `##`=slide, `. . .`, columns, notes. |
| Advanced Reveal | [advanced](https://quarto.org/docs/presentations/revealjs/advanced.html) | no | ABSENT | skip | chalkboard/multiplex/menu — beyond scope. |
| Revealjs Themes | [themes](https://quarto.org/docs/presentations/revealjs/themes.html) | edge | via `_brand.yml` | skip/merge | Deck theming rides on the brand story. |
| Presenting Slides | [presenting](https://quarto.org/docs/presentations/revealjs/presenting.html) | no | ABSENT | skip | Presenter mode/navigation — not an authoring need. |

---

## Mis-triages

- **"Markdown & content" (CORE) is under-labeled as "fast deltas."** It is the single bucket that must carry figures + tables + cross-references — and, per the gaps above, *should* also carry **math, inline code, and callouts**. That is 5–6 distinct deltas, not "compress, they know the basics." Re-scope the Part-1 15-min concept+demo budget with this bucket's true width in mind, or the equations/inline-code/callout wins get squeezed out at the whiteboard. **This is the only real mis-triage** — it's a load mis-estimate, not a wrong call.
- **Typst (CORE) — calibration, not mis-triage.** Docs confirm the "bundled, no LaTeX, deterministic" promise is safe. Two edges to keep flagged (both already noted in the triage): the CSL↔Typst-native-bibliography handoff, and open image-sizing quirks ("active development continues to address edge cases," [typst](https://quarto.org/docs/output-formats/typst.html)). CORE stands.
- **Article Layout (CORE) — right call, watch scope.** The page spans body/page/screen/margin columns, figure layout, landscape, caption placement ([article-layout](https://quarto.org/docs/authoring/article-layout.html)). Teach margin figures + `column-page` (the manuscript-relevant 20%); skip screen/full-bleed/landscape or it balloons.

## Redundancy — safe merges to protect time

1. **HTML Theming → fold into `_brand.yml`.** Don't teach Bootswatch as a separate beat; brand supersedes it in our narrative.
2. **Page Layout ≡ Article Layout.** One page, one beat — don't split.
3. **Document types + Revealjs + HTML Multi-Format = one demo.** All three are the same "one source → many formats" story; present as a single live render across formats, not three segments.
4. **Positron × Quarto (DEMO) is the softest DEMO.** an adjacent slot covers Positron; our triage already scopes it to "Quarto integration only." Given the Part-1 budget pressure from the mis-triage above, this is the first candidate to compress **DEMO → MENTION** if time runs short.

## Safe to skip (Day-1) — confirmations

Variables · Videos · Document Language · Placeholder text/images · Embedding from other documents · Rendering Script Files · Advanced Reveal · Presenting Slides · Typst Custom Formats / Typst CSS / Gathering Packages · PDF Engines / PDF Improvements. All either projects-scoped, i18n/niche, presenter-only, or LaTeX-side (against the Typst-first line). **Includes** and **Caching** are correctly Day-2, not Day-1.

# Review — 2026-07-23 · house-voice sweep validation + language pass

**Reviewer:** language / copy-edit · **Ref commit:** b9ccc53 (`Scrub idiomatic English from the
decks' speaker notes`) · **Scope:** all participant-facing prose (`setup.qmd`, `index.qmd`, both decks,
both labs, shipped Day-1 executable docs, Day-2 site pages, and their `exercises/` mirrors). `::: notes`
exempt.

## Verdict

**The sweep is genuinely good.** The primary tells are gone: **zero French typography** (no space
before `? ! : ;` in prose — every ` [?!:;]` hit is code: `!is.na`, `!expr`, `:::`), **zero surviving
idioms** (grepped `hit the ground`, `goes sideways`, `room-killer`, `nobody is stranded`, … — all
clean), **no doubled words**, **no corporate verbs** (`leverage`/`utilize`/`facilitate`/`streamline`/
`robust`/`showcase` — none). The em-dash→colon/paren conversion landed cleanly in `setup.qmd`, both
decks' bodies, and both lab **index** pages.

The residues are concentrated in **two files the sweep under-reached** — the shared executable running
document (`penguins-report.qmd`) and the nested Day-2 **site** pages (`starter/`, `solution/` index) —
plus one **spelling-convention drift** (`colour`) that recurs across the whole repo. No P0.

### Triage

- 🔴 **P0** — none.
- 🟠 **P1 (2 patterns, fix before the event)**
  1. **Residual body-prose em-dashes in `penguins-report.qmd`** — including the house-voice *signature
     offender* (two dashes splitting a sentence, `:35`). This is the shared running/reference document
     participants open and read; it is exactly the sweep's own target category.
  2. **US/UK spelling drift on `colour`** — prose holds UK `colour`/`coloured`/`colours` (~8 spots +
     code comments) while YAML/code use US `color:` / `scale_color_*`. The declared house convention is
     **US**. Pick one and hold it.
- 🟡 **P2 (nice-to-have)** — a few trailing-dash residues (`penguins-report:14`, `sample-typst:114`),
  the Day-2 site-page glosses, one redundancy (`break in between`), and a `scale_colour_`/`scale_color_`
  identifier split.

### Cross-cutting note — `exercises/` mirrors

`exercises/**` is **generated from `labs/**`** (`tools/sync-exercises.R`). Every finding below on
`labs/quarto/penguins-report.qmd`, `labs/quarto/sample-typst.qmd`, and
`labs/quarto-projects/{starter,solution}/index.qmd` also sits in its `exercises/` twin
(`solutions/day1/penguins-report.qmd`, `day1-intro/sample-typst.qmd`, `day2-projects/index.qmd`,
`solutions/day2/index.qmd`). **Fix the `labs/` source, then `just exercises` + re-render** — do not
hand-edit `exercises/`. I cite the `labs/` source lines only.

---

## `labs/quarto/penguins-report.qmd` (shared running doc — mirrors to `exercises/solutions/day1/`)

| line | current | proposed | why |
|---|---|---|---|
| 35 | `…for \`{r} nrow(penguins)\` penguins of \`{r} …\` species — \`{r} knitr::combine_words(…)\` — collected at Palmer Station, Antarctica` | `…of \`{r} …\` species (\`{r} knitr::combine_words(…)\`), collected at Palmer Station, Antarctica` | ⚠️ The **signature offender**: two dashes splitting subject from verb. Move the species list into a `(…)` parenthesis, keep the clause flowing. |
| 56 | `Each penguin's bill is summarized by two measurements — **length** and **depth** (the *culmen*, @fig-culmen).` | `Each penguin's bill is summarized by two measurements: **length** and **depth** (the *culmen*, @fig-culmen).` | Em-dash introducing a pair → colon (introduces the list, house style). |
| 13 | `renders it as a branded PDF with **Typst** — a modern typesetting system that ships inside Quarto, so there is no LaTeX to install.` | `…with **Typst** (a modern typesetting system that ships inside Quarto, so there is no LaTeX to install).` | Em-dash gloss → parenthesis. `setup.qmd:35` already glosses Typst with a parenthesis — this matches it. |
| 14 | `Dataset: base-R \`datasets::penguins\` (R ≥ 4.5) — columns \`bill_len\`, \`bill_dep\`, …` | `Dataset: base-R \`datasets::penguins\` (R ≥ 4.5), columns \`bill_len\`, \`bill_dep\`, …` | Trailing appositive dash → comma (a `:` already opened the sentence). P2. |

## `labs/quarto/sample-typst.qmd` (mirrors to `exercises/day1-intro/`)

| line | current | proposed | why |
|---|---|---|---|
| 114 | `…at \`r …\` g — the \`#highlight(…)[large-bodied]\`{=typst} species of the three.` | `…at \`r …\` g, the \`#highlight(…)[large-bodied]\`{=typst} species of the three.` | Dramatic trailing dash → comma. P2. (Legacy `r …` inline is a deliberate exception here — leave it.) |

## `labs/quarto-projects/starter/index.qmd` & `solution/index.qmd` (mirror to `exercises/day2-projects/`, `exercises/solutions/day2/`)

Rendered **website** pages → written register, no em-dash asides. The sweep normalized the lab index
bodies but not these nested site pages.

| line | current | proposed | why |
|---|---|---|---|
| starter&solution :5 | `a small site about the **Palmer penguins** — three species measured at Palmer Station, Antarctica, and shipped in base R as \`datasets::penguins\` (R ≥ 4.5).` | `…about the **Palmer penguins**: three species measured at Palmer Station, Antarctica, shipped in base R as \`datasets::penguins\` (R ≥ 4.5).` | Defining gloss → colon. P2. |
| solution :10 | `> This is the finished **Website Challenge** project — the \`.qmd\` pages from \`day2-projects/\`, plus the \`_quarto.yml\` and \`_brand.yml\`…` | `> …the finished **Website Challenge** project: the \`.qmd\` pages from \`day2-projects/\`, plus the \`_quarto.yml\` and \`_brand.yml\`…` | Appositive dash → colon. P2. |
| starter :11 | `…that turn them into a navigable, branded website — then ship it.` | `…that turn them into a navigable, branded website, then ship it.` | Dramatic trailing dash → comma. P2. |

## `labs/quarto/index.qmd`

| line | current | proposed | why |
|---|---|---|---|
| 12 | `each is its own hands-on part, with the between-parts break in between.` | `each is its own hands-on part, with a break between them.` | `between-parts … in between` is doubly redundant; the Day-2 lab (`labs/quarto-projects/index.qmd:23`) already says the clean `a break between them` — align the two. P2. |
| 66 | `a scatter plot of \`bill_len\` versus \`bill_dep\` **coloured** by \`species\`.` | `…**colored** by \`species\`.` | US convention (see spelling note). P1-cluster. |
| 114 | `…three penguin species in distinct **colours**;` (fig-alt) | `…in distinct **colors**;` | US convention. |
| 16 | `\`ggokabeito\` (a **colour-blind-safe** palette, …)` | `…a **color-blind-safe** palette…` | US convention. |

## `slides/quarto/index.qmd` (slide bodies only — `::: notes` exempt)

| line | current | proposed | why |
|---|---|---|---|
| 41 | `make it **accessible** — alt text, **colour-blind-safe colours**, a built-in contrast check;` | `…**color-blind-safe colors**…` | US convention. (Em-dash here is a `term — gloss` slide bullet — fine, don't touch.) |
| 356 | `**Colour-blind-safe colours** — the default palette isn't.` | `**Color-blind-safe colors** — …` | US convention. |
| 357 | `…encode by shape/label too, not **colour** alone.` | `…not **color** alone.` | US convention. |
| 686 | `make it accessible — alt text, **colour-blind-safe colours**, a built-in \`axe\` check;` | `…**color-blind-safe colors**…` | US convention (close slide). |
| 357 / 368 | code identifier `scale_colour_okabe_ito()` | `scale_color_okabe_ito()` | ⚠️ Identifier drift: the labs and every executable doc use the US alias `scale_color_okabe_ito()`; only the deck uses UK `scale_colour_`. Both are valid `ggokabeito` exports, but unify on the US form the rest of the repo shows. P2. |

## `labs/quarto-projects/index.qmd`

| line | current | proposed | why |
|---|---|---|---|
| 100 | `the plot keeps its default species **colours**` | `…default species **colors**` | US convention. |
| 132 | `**The \`solutions/day2/\` folder is a reference, not a checklist.**` | (keep, or vary) | `reference, not a checklist` also appears at `labs/quarto/index.qmd:150`. House-voice flags this as a repeated beat. Low-value: the two are a day apart in separate labs, so it reads fine — vary one only if convenient. P2. |

---

## Spelling convention — the `colour` decision (P1 rationale)

Prose is **internally consistent UK** (`colour`/`coloured`/`colours`, ~8 participant-facing spots +
`# colour-blind-safe` code comments in the executable docs), but it clashes with **US everywhere the
machine reads it**: `color:` in every `_brand.yml`, `color = species` / `scale_color_okabe_ito()` in the
lab code, and Quarto's own `color`. The declared house convention (`project-context.md` § Content
patterns) is **US English**, and prior cycles already moved this way (`labelled`→`labeled`,
`millimetres`→`millimeters`, an earlier `colour`→`color`). Recommend finishing the sweep to **US** so
prose, YAML, and code agree. (If UK `colour` is instead a deliberate keep for the accessibility topic,
document it — but then the deck's `scale_colour_` and the lab's `scale_color_` still need unifying.)

---

## ✅ Language strengths

- **French typography fully cleared** — no ` ?`/` !`/` :`/` ;` in any prose; the only hits are code.
- **Idioms fully cleared** — the ESL-voice risk the brief flagged is gone; even `::: notes` read literal.
- **Em-dash conversions are consistent where the sweep reached** — `setup.qmd` is a model (parenthesis
  glosses, colon-into-list, split sentences; the reworked "exercises folder" sentence matches the
  house-voice before/after exactly).
- **Presenter rationale sits positively on-slide, why in notes** — e.g. `labs/quarto-projects/index.qmd:24`
  states the watch-me format plainly with the reason in a `(…)`; the Publishing-slide logistics live in
  `::: notes` (`slides/quarto-projects/index.qmd:381`). No apology-to-the-room leakage.
- **Reusability held** — domain flavor stays in notes as a localization cue
  (`slides/quarto-projects/index.qmd:293` "Compute can be slow … *(Localize: a sequence alignment, a
  long MCMC…)*"); the slide body is generic. `team project` used, not `capstone`.
- **Terminology stable** — `cell` (not `chunk`) held across deck+lab; `versus` (not `vs.`) in captions;
  Challenge names verbatim.

## 📝 Evolution since the previous review

Prior language cycles (through 2026-07-22) closed on written copy being clean and the work shifting to
`::: notes`. This cycle is the **first validation of the house-voice sweep itself**. Net: the sweep
succeeded on the high-traffic surfaces (setup, decks, lab indexes) and on the hardest tells (French
spacing, idioms). What it missed is **narrow and mechanical** — the em-dashes in the shared executable
running doc and the two nested site index pages (files edited less often, and their `exercises/` mirrors),
plus the pre-existing `colour` spelling drift that no sweep has yet finished. All P1/P2, none blocking.

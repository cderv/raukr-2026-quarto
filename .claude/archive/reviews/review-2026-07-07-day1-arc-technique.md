# Review — Day-1 arc, cross-artifact technique pass

- **Date:** 2026-07-07
- **Reviewer:** workshop-reviewer-technique (Quarto correctness)
- **Scope:** the **whole Day-1 arc as one integrated ~2h experience** — the *seams and consistency*
  across five files, **not** a re-review of each in isolation (WP1 slides / WP2 lab cycles already
  did that; nothing fixed there is re-flagged).
- **Reference commit:** `3c45287` (all committed)
- **Toolchain:** Quarto **1.9.38**, R packages all present in the project library
  (`dplyr`, `ggplot2`, `gt`, `brand.yml`, `ggrepel`, `prismatic` — verified loadable).
- **Files (the set):**
  - `slides/quarto/index.qmd` — the deck (Part 1 Basics→HTML, Part 2 Citations→Typst)
  - `labs/quarto/index.qmd` — the lab (Authoring Challenge, Citations Challenge)
  - `labs/quarto/starter.qmd` — the Part-2 starter
  - `labs/quarto/penguins-report.qmd` — the running HTML report (worked solution)
  - `labs/quarto/sample-typst.qmd` — the branded Typst PDF (worked solution)
- Shared resources checked: `labs/quarto/references.bib`, `labs/quarto/apa.csl`, `_brand.yml`,
  `_quarto.yml`, `setup.qmd`, `DESCRIPTION`, `renv.lock`.

## Overall verdict

The arc is **technically coherent end to end** — this is a tightly-built five-file set, and the
seams hold. The running spine (`penguins`, columns `bill_len`/`bill_dep`/`body_mass`/`flipper_len`)
is identical in every file; the native pipe `|>` is used throughout with zero `%>%`; the citation
plumbing (`bibliography: references.bib` / `csl: apa.csl`, key `@gorman2014`) is the same string in
the deck, the lab, and both solution files, and both files physically ship next to the `.qmd`s. The
`fig-bill` / `eq-ratio` labels carry identical semantics across all five files (no clashing label
meanings), every deck promise is delivered by a lab task or a solution file, and the HTML→Typst
payoff is real: I verified live that the `pal()`/`tint()` brand-color helpers in `sample-typst.qmd`
resolve every role against the actual `_brand.yml`. **0 P0 / 0 P1.** The only findings are two
cosmetic idiom/label inconsistencies a sharp R audience *might* notice (P2).

## 🔴 P0 — blocking technical bug

None.

## 🟠 P1 — fix before the event

None.

## 🟡 P2 — nice-to-have / robustness

### P2-1 — Table label vocabulary splits deck (`tbl-mean`) vs the four delivered docs (`tbl-summary`)

The deck teaches the per-species means table with label **`tbl-mean`**, including in its
cross-reference vocabulary bullet:

- `slides/quarto/index.qmd:132` — `**cross-references** — \`@fig-bill\`, \`@tbl-mean\`, \`@eq-ratio\`;`
- `slides/quarto/index.qmd:163` — `#| label: tbl-mean`

Every document a participant actually builds or reads uses **`tbl-summary`** for the same table:

- `labs/quarto/index.qmd:57,79,127,141` (task, "You should see", solution chunk, prose ref)
- `labs/quarto/penguins-report.qmd:100,103`
- `labs/quarto/starter.qmd:66,69`

So of the trio the deck teaches (`@fig-bill`, `@tbl-mean`, `@eq-ratio`), **two match the delivered
files and one (`@tbl-mean`) does not** — the table is called `@tbl-summary` everywhere the
participant looks after the slide. Not a bug (different files, no label clash), and defensible as
"the slide shows a minimal illustration". But the arc is otherwise *rigorous* about reusing the same
identifiers, so this one drift stands out. Cheapest fix: rename the deck's example to `tbl-summary`
(label + the line-132 bullet) so the whole arc speaks one label.

### P2-2 — dplyr idiom flip-flops between `.by = species` and `group_by() |> summarise(.groups = "drop")`

The "mean per species" summary is written **two different ways** across the arc, and — more
noticeably — **within the lab itself**: the task skeleton uses the modern `.by =`, but the solution
chunk immediately below it reverts to `group_by()`:

- `.by = species` — `slides/quarto/index.qmd:166`, `labs/quarto/index.qmd:60` (task-3 skeleton)
- `group_by(species) |> summarise(..., .groups = "drop")` — `labs/quarto/index.qmd:130` (solution),
  `labs/quarto/starter.qmd:72`, `labs/quarto/penguins-report.qmd:106`, `labs/quarto/sample-typst.qmd:89`

Both are correct and produce the same result, so this is purely a house-idiom consistency point —
but this is a fluent-R audience, and a task that says `.by = species` paired with a folded solution
that says `group_by(species) |> ... .groups = "drop"` invites a "why did it change?" question. Pick
one idiom for the running summarise (the 2026 house line leans modern, so `.by =` throughout would
be the natural call) and use it in the task skeleton, the solution, and the worked files.

### P2-3 (very minor, no change needed) — lab Scope package list is a subset of what the linked Typst solution imports

`labs/quarto/index.qmd:15` lists **Packages: `dplyr`, `ggplot2`, `gt`**, whereas the linked worked
solution `sample-typst.qmd` additionally imports `ggrepel`, `brand.yml`, `prismatic`
(`sample-typst.qmd:31-34`). This is **not** a real gap: the same line says "all in the project
`renv` — run `renv::restore()` once", and `setup.qmd`, `DESCRIPTION`, and `renv.lock` all include the
three extra packages — so `renv::restore()` covers them, and `sample-typst.qmd` is a *linked* worked
solution, not a participant task. Noting only for completeness; leave as is.

## ✅ Technical choices validated (cross-artifact)

- **Column names — identical spine across all five.** `bill_len` / `bill_dep` (+ `body_mass`,
  `flipper_len`) everywhere; no palmerpenguins-style `bill_length_mm` leakage. The base-R
  `data(penguins)` + `filter(!is.na(...))` setup is repeated verbatim in deck, lab, starter, and
  report.
- **Native pipe throughout.** `grep '%>%'` across the deck and all lab files → **none**. No dotted
  cell-option keys (`#| x.y:`) → **none**; all options are dashed `#|` YAML.
- **Citation plumbing is one consistent string.** `bibliography: references.bib` / `csl: apa.csl`
  match in `slides:319-320`, `labs/index:166-169`, `penguins-report:4-5`, `sample-typst:8-9`; both
  files exist in `labs/quarto/`. Citation keys `@gorman2014` and `@horst2020` both resolve to real
  entries in `references.bib` — no dangling keys, no `?@` risk in the shipped solutions.
- **Cross-ref semantics are stable — no clashing `fig-bill`.** `fig-bill` = the bill length×depth
  scatter in **all five** files; `eq-ratio` = the identical escaped-underscore LaTeX
  (`\text{bill\_len}`/`\text{bill\_dep}`) in deck, lab, starter, and report. `penguins-report`'s
  extra `fig-culmen` and `sample-typst`'s `tbl-species`/`fig-bill` are file-local and don't collide.
- **Every deck claim is delivered.** figure / cross-ref table / margin / math → Authoring Challenge
  tasks 2-5 + `penguins-report.qmd`; citations + real title block + `format: typst` + `_brand.yml`
  branding → Citations Challenge tasks 1-6 + `sample-typst.qmd`. No promise the lab can't fulfill;
  no divergent API.
- **HTML→Typst path is coherent as a whole.** `penguins-report.qmd` is the cited HTML solution;
  `sample-typst.qmd` is the branded PDF using exactly the `theme_brand_gt()` / `theme_brand_ggplot2()`
  helpers the deck names on the brand slide (`slides:405-407`). The deck's "the whole switch is
  `format: typst`" claim holds via `_brand.yml` (a minimal switch of `penguins-report`/`starter`
  yields a branded PDF); `sample-typst` is the showcase superset. I verified live that
  `read_brand_yml("_brand.yml")` + `brand_color_pluck` resolve every role the payoff uses
  (`teal_lighter`→`#D1E5E6`, `primary`→`#4C979F`, `code_blue`→`#496985`, `link_teal`→`#79B1B7`,
  `foreground`, `background`) and that `clr_darken`-based `tint()` returns a valid `#RRGGBB` — the
  dash-in-YAML / underscore-in-R normalization works. (First attempt errored only under a non-UTF-8
  Rscript locale — the classic Linux-locale pitfall; under `C.UTF-8` it resolves cleanly, and
  `_freeze/labs/quarto/sample-typst/execute-results/typ.json` confirms it has built.)
- **Version floors agree across the set.** R **≥ 4.5** (deck:125, lab:12, starter:22,
  report:14, setup) and Quarto **≥ 1.8** with Typst noted as bundled since **1.4+** (deck:377,
  setup, `_quarto.yml` `quarto-required: ">=1.8.0"`). No stale/contradictory floor between files.
- **Precise seam instructions are accurate.** The lab's "insert `[@gorman2014]` before the period"
  step (`labs/index:170-171`) points at the exact sentence that exists in the starter —
  "…collected at Palmer Station, Antarctica." (`starter.qmd:30-31`). The deck's two "Your turn"
  callouts name **"Authoring Challenge"** / **"Citations Challenge"** (deck:280, 414), matching the
  lab's headings verbatim (one vocabulary, per the convention rule). Both `_brand.yml` and
  `_quarto.yml` render lists are coherent (the two solution files listed explicitly because the
  `labs/*/index.qmd` glob wouldn't catch them).

## 📝 Evolution since the previous review

This is the **first cross-artifact pass**; prior cycles reviewed the deck (WP1) and the
lab+starter (WP2) individually and closed 0 P0. What the integrated view confirms that a per-file
pass structurally *cannot*: the identifiers, column names, citation strings, idioms, and version
floors that have to agree **across** files actually do — the arc was authored as a genuine unit,
not five documents stitched together. The two P2s are the residue of exactly the thing single-file
review misses (a label and an idiom that each look fine locally but disagree across the seam), and
both are cosmetic. The technical spine of the Day-1 arc is sound and event-ready.

## Checks run (for the record)

- Read all five `.qmd` + `references.bib`, `apa.csl` (present), `_brand.yml`, `_quarto.yml`,
  `setup.qmd`, `DESCRIPTION`, `renv.lock`, and the WP1/WP2 ledger entries.
- `grep '%>%'` and dotted-option grep across deck + lab files → none.
- Enumerated `tbl-mean` / `tbl-summary` / `.by = species` / `group_by(species)` occurrences with
  line numbers (P2-1, P2-2).
- Confirmed `_freeze/` exists for all five files; packages loadable.
- Live-verified `brand.yml` color-role resolution against the real `_brand.yml` under `C.UTF-8`.

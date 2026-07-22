# Build-gap cartography — Christophe's assets × RaukR 2026 CORE/DEMO

> **Type:** ad-hoc scope review (build backlog). **Date:** 2026-07-07.
> **Method:** throwaway `--depth 1` clones of the five `cderv/*` repos in the scratchpad,
> read + grep against the now-firmed `topic-store.md` triage. Extends
> `prior-art-inventory.md` (does not restate it): file:line anchors verified in-repo, plus
> three findings that revise the inventory (Day-2 deck exists; base-R re-skin is universal not
> local; R-side brand styling already works). Repos cited by GitHub name; line numbers are into
> each source repo, not ours.

---

## Verdict

**The single document (Day 1) is ~80% reuse; the project story (Day 2) is ~60% reuse, not
"mostly new" as the inventory says.** Christophe already owns a strong EN deck base, the
richest penguins lab, a working Typst+book+`_brand.yml` stack (incl. the R-side plot/table
branding the plan lists as "young, verify it installs" — it exists and is tested), **and** a
full Day-2 projects deck (websites/freeze/cache/publishing) hiding inside `user2024-tutorial`.

**Only 4 items are true BUILD-FRESH: Citations (real segment), Dashboards, Positron×Quarto,
Interactivity-as-a-demo.** Parameters is fresh-ish but a strong donor exists in NBIS (already
mapped). Everything else is REUSE or MODERNIZE. The dominant cost is **not** authoring new
material — it's one mechanical sweep applied everywhere: **re-skin `palmerpenguins` → base-R
`datasets::penguins`** (10 files use the package; 0 use base-R) plus **`%>%` → `|>`** (4 files).

## One-screen build backlog

```
BUILD-FRESH (no/weak asset) ........ Citations segment · Dashboards · Positron×Quarto · Interactivity demo
                                     (+ Parameters — fresh, but lift NBIS labs/quarto:471-599)
MODERNIZE (lift + rework) .......... Typst payoff (Star Wars→penguins, real prose rework)
                                     Deck spine (raukr-2025 slides: reskin brand, |>, Positron, drop "Rmd++")
                                     Layouts beat (assemble from margin examples — no single slide today)
                                     brand.yml R-side demo (exists in FR book → lift, reskin brand)
REUSE-AS-IS (least work) ........... penguins Ex4 authoring doc · Day-2 projects deck (website/freeze/
                                     cache/publish) · freeze-vs-cache slides · engine "how it works" ·
                                     website lab spine · companion R package + justfile infra
UNIVERSAL RE-SKIN TAX ............. palmerpenguins→base penguins (col renames, 10 files) · %>%→|> (4 files)
                                     · RStudio→Positron/CLI · reframe "Rmd++"→"what you can build"
```

---

## Day 1 — Introduction to Quarto (single document)

| Item (CORE/DEMO) | Best existing asset (repo · file:line) | Status | Modernization needed | Notes |
|---|---|---|---|---|
| **What Quarto *is* — native `.qmd`** (CORE) | `raukr-2025-quarto` slides/quarto/index.qmd:8-118 (Quarto/installation/notebook); `user2024-quarto-talk` index.qmd:44-95 (What/Why/How) | MODERNIZE | Reframe opener from "Rmd++, nothing new" → "here's what you can build" (running-order rule 5); drop install-heavy slides; native-`.qmd`-first | Two decks to draw from. Talk deck is the better *hook* shape. |
| **Markdown & content** (figs/tables/xref) (CORE) | `user2024-tutorial-quarto` examples-correction/new-penguins-full-example-corrected.qmd:1-169 | REUSE-AS-IS | base penguins reskin; `%>%`→`\|>` (mixed at :35); `palmerpenguins`→`datasets` | **Strongest single asset in the whole set.** Callouts, `@fig-`/`@tbl-`, margin, code-annotation, `gt`, inline `r`. Teach as deltas. |
| **Layouts** (article/margin/columns/panels) (CORE) | margin cells in the 3 penguins examples (`…corrected.qmd:34`, `…typst.qmd:39`, `…demo.qmd:37` — `#\| column: margin`; `…corrected.qmd:50` `fig-cap-location: margin`); revealjs `.columns`/`.aside` only in `raukr-2025` slides:393,521,638 | MODERNIZE (assemble) | **No single "Layouts" slide exists today** — build the beat; harvest `page-layout`/outset/inset/tabset examples from Quarto docs. `.columns`/`.aside` in the deck are revealjs idioms — do **not** reuse as the HTML/Typst article story (topic-store format caveat) | The margin *cells* transfer; the *taught beat* is new-emphasis. Real assembly, not lift. |
| **Document types** (report+presentation from 1 source) (CORE) | `raukr-2025-quarto` slides/quarto/index.qmd:111-172 (PDF/Typst/revealjs) + sample/sample-{html,pdf,revealjs}.qmd; `user2024-quarto-talk` index.qmd:258-291 (formats) | REUSE-AS-IS | Lead with Typst not LaTeX; note the revealjs layout caveat | The "1 doc → many formats" demo is ready. |
| **Citations** (`.bib`/`@ref`/CSL) (CORE) | ⚠️ **weak** — only `bibliography: references.bib` in book/website examples (`user2024-tutorial` 3-projects.qmd:184,731; `user2024-quarto-talk` index.qmd:545); footnote syntax note `2-rmd-quarto.qmd:289`. No `.bib` file, no `@ref` exercise, no CSL, nothing in Typst | **BUILD-FRESH** | Ship a real `.bib`, a mainstream CSL, `@ref` in prose, **and smoke-test in the Typst format** (CSL↔Typst-native bib handoff) | The plan's flagged thin spot, confirmed. Manuscript audience — must be a real segment, not a wave-through. |
| **Typst** (modern PDF, no LaTeX) (CORE payoff) | `user2024-tutorial-quarto` examples-correction/new-penguins-pdf-demo-typst.qmd:1-174 (penguins→Typst, `keep-typ`); **richer:** `tuto-quarto-typst-rr-2026` exercises/01-document-typst/{starter,correction}/rapport-starwars.qmd + correction/_brand.yml (palette+fonts+logo, `keep-typ`) | MODERNIZE | **Real rework:** the deep Typst lab is Star Wars (font hacks, `#show heading` glyph fix, SW palette/logo). Keep the *technique*, re-skin body prose → penguins, brand → RaukR teal/Albert Sans (running-order rule 3). The penguins typst-demo is the cheaper donor for the *doc*; the SW lab is the donor for the *`_brand.yml` styling technique* | Two donors — combine: penguins doc body + SW brand mechanics. |
| Execution options (knitr/engine, chunk attrs) (DEMO) | `user2024-tutorial-quarto` 2-rmd-quarto.qmd (hash-pipe deltas); `raukr-2025` slides:477-523 | REUSE-AS-IS | Trim "what is a chunk"; show deltas only | Audience knows chunks — compress hard. |
| Positron × Quarto (DEMO, minimal) | ⚠️ **gap** — only `positron-python.png` in `raukr-2025` assets; every deck is RStudio-framed | **BUILD-FRESH** (thin) | New: Quarto integration only (preview/render, no RStudio visual editor — Positron has none) | Keep minimal per triage; Jenny covers Positron itself. |
| Parameters (now MENTION, Day-2 home) | slide-only: `raukr-2025` slides/quarto/index.qmd:564-590 (YAML + `-P` CLI); no exercise anywhere | BUILD-FRESH (donor exists) | Lift NBIS `labs/quarto/index.qmd:471-599` (already mapped), reskin iris→penguins (1:1, both 3 species) | Christophe owns only a slide; the reusable *exercise* is NBIS's. Demoted to MENTION/Day-2. |
| Shortcodes (MENTION) | `user2024-quarto-talk` index.qmd:461-485 (light); `raukr-2025` placeholder demos | REUSE-AS-IS (as link/3-min) | — | Fold to a quick-win or link. |

## Day 2 — Quarto projects

| Item (CORE/DEMO) | Best existing asset (repo · file:line) | Status | Modernization needed | Notes |
|---|---|---|---|---|
| **Why a project** (`_quarto.yml`, shared config, `output-dir`) (CORE) | `user2024-tutorial-quarto` 3-projects.qmd:22-70 ("Projet Quarto?", "already created a project", project types) | REUSE-AS-IS | RStudio screenshot → editor-agnostic | The one-file→site jump is already taught. |
| **Websites + navigation** (CORE) | **Deck:** `user2024-tutorial-quarto` 3-projects.qmd:71-206 (website/navbar/sidebar/blog/listing/book + `Our turn`:759 / `Your turn`:771). **Lab:** `raukr-2025-quarto` labs/quarto-site/index.qmd:412-433 (`_brand.yml` seed) — but richest website lab spine is NBIS (already mapped :84-390) | REUSE-AS-IS (deck) / MODERNIZE (lab) | base penguins; drop git-first opener if lab lifted | The deck coverage here is a **hidden gem** (see below). |
| **Cross-referencing across a project** (CORE) | `tuto-quarto-typst-rr-2026` exercises/02-projet-book/correction/ (book chapters + `_quarto.yml` cross-refs); `user2024-tutorial` 3-projects.qmd:158-165 (book cross-ref slide) | MODERNIZE | Star Wars → penguins; FR → EN | Cross-refs live inside the book asset. |
| **Freeze (& caching)** (CORE) | `user2024-tutorial-quarto` 3-projects.qmd:797-896 — `freeze: true/auto/false` (:813-829), **freeze-vs-cache contrast** (:851-864), `Our turn` cache/freeze (:882) | REUSE-AS-IS | Add "CI renders without R" payoff + the 2-render scenario (thin on motivation today) | The crisp `cache`-vs-`freeze` slides the plan wants **already exist**. |
| **Publishing** (CORE; hands-on=`render`+`output-dir`, `publish`/CI=watch-me) | `user2024-tutorial-quarto` 3-projects.qmd:899-947 (`quarto publish --help`, quarto-pub, `_publish.yml`, `Our turn`:941); `raukr-2025` slides:739-762; NBIS dual-path (mapped :456-513) | REUSE-AS-IS (as DEMO) | Recast live-publish → watch-me on pre-provisioned repo (Day-2 P0); foreground the CI *story*; hands-on = manual `output-dir` | Deck is ready; only the *staging* changes per the panel. |
| **`_brand.yml`** — site+slides+**R plots/tables** (DEMO, →Part 1) | `tuto-quarto-typst-rr-2026`: exercises/02-projet-book/correction/01-anatomie.qmd:9-125 & 02-origines.qmd:9-127 — **`library(brand.yml)`, `read_brand_yml()`, `theme_brand_gt()`, `theme_brand_ggplot2()`, `brand_color_pluck()`**; palette-swap via `_brand-{empire,jedi,mando}.yml`; seed brand in `raukr-2025` labs/quarto-site:412-433 | MODERNIZE | Star Wars brand → RaukR; FR→EN; verify `brand.yml` pkg installs via `install.packages()` (pak KO) | **Hidden gem** — the R-side branding the inventory calls "young, verify" is here, working and tested. |
| **Books** (DEMO) | `tuto-quarto-typst-rr-2026` exercises/02-projet-book/ (5 chapters, `type: book`, appendices, project `_brand.yml`, documented Quarto book bugs in correction/_quarto.yml:21-52) | MODERNIZE | SW→penguins; FR→EN | After the publish payoff. Carries deep book+Typst edge-case knowledge. |
| **Dashboards** (DEMO) | ⚠️ **gap** — only named in format tables (`raukr-2025` slides:877; `user2024-tutorial` 1-what-is-quarto.qmd:367). Never taught | **BUILD-FRESH** | New: `format: dashboard` + layout model (rows/cols, `orientation`, `.card`, valueboxes, tabsets) | Budget for the layout model or it lands as a single-plot page (technique P2-5). |
| **Interactivity** (DEMO) | slide-only: `raukr-2025` slides:642-738 (htmlwidgets/OJS), with `%>%`; `user2024-tutorial` 3-projects interactive nav | **BUILD-FRESH** (thin) | New small demo: lead with an htmlwidget (`plotly`/`leaflet`), OJS as "non-R path" link, Shinylive MENTION-only; `%>%`→`\|>` | Only ever mentioned/slide-shown, never a runnable demo. |

---

## 1 · BUILD-FRESH list (no/weak prior asset)

| Item | Why fresh | Thinnest viable new asset |
|---|---|---|
| **Citations** (Day-1 CORE) | Only `bibliography:` keys exist; no `.bib`, no `@ref` exercise, no CSL, untested in Typst | One `references.bib` (5–6 refs), 2–3 `@key` cites in the Part-1 penguins doc, one mainstream CSL, **rendered once in Typst** to prove the CSL↔Typst bib path. ~1 slide + 1 lab step. |
| **Dashboards** (Day-2 DEMO) | Never taught, only named | One `format: dashboard` penguins page: 2 rows, 2 valueboxes, 1 `.card` plot, 1 tabset. Watch-me only. |
| **Positron × Quarto** (Day-1 DEMO) | Only a PNG; all decks RStudio-framed | 3–4 slides: open `.qmd`, `quarto preview`, render; state "no RStudio visual editor". Minimal by design. |
| **Interactivity** (Day-2 DEMO) | Slide-only, never runnable | One htmlwidget cell (`plotly` on penguins) + 1 line each for OJS/Shinylive as links. |
| *(Parameters — Day-2 MENTION)* | Christophe owns only a slide | **Not build-from-zero:** lift NBIS `labs/quarto/index.qmd:471-599`, reskin iris→penguins (both 3 species w/ photos). |

## 2 · STRONGEST REUSE list (transfer with least work)

1. **`new-penguins-full-example-corrected.qmd`** — `user2024-tutorial-quarto` examples-correction/:1-169. The Day-1 authoring payoff doc (callouts, xref, margin, `gt`, code-annotation). *The* keystone asset.
2. **Day-2 projects deck** — `user2024-tutorial-quarto` 3-projects.qmd:22-947. Websites, navbar/sidebar, blog/listing, books, **freeze/cache contrast (:851-864)**, publishing, with built-in `Our turn`/`Your turn` beats. EN, current.
3. **Freeze-vs-cache slides** — 3-projects.qmd:797-896. Exactly the crisp contrast the plan asks to "add."
4. **`_brand.yml` R-side styling** — `tuto-quarto-typst-rr-2026` 02-projet-book/correction/01-anatomie.qmd:9-125 (+02-origines). Working `theme_brand_gt`/`theme_brand_ggplot2` + palette-swap.
5. **Infra** — `tuto-quarto-typst-rr-2026` justfile, `_quarto-{pretuto,tuto}.yml` two-profile split, and the companion **R package** (pkg/R/: `installer-exercices`, `verifier-installation`, `diagnostiquer-rendu`, `creer-projet`). This scaffold's basis; lift wholesale.
6. **Deck spine** — `raukr-2025-quarto` slides/quarto/index.qmd (EN, most Day-1 CORE) + engine "How it all works" (:535-562).

## 3 · Re-skin cost (dataset switch to base-R `penguins`)

**This is the dominant, universal tax — not a per-item cost.** Grep: **10 `.qmd` load `palmerpenguins`; 0 use base-R `datasets::penguins`.**

- **Trivial (1:1):** the culmen photo, `count(species)`, `glimpse`, inline `unique(species)`, figure/caption/margin layout, the whole document *shape* — the dataset is the same penguins.
- **Real (mechanical but everywhere):** base-R `penguins` (R≥4.5) **renames columns** — `bill_length_mm→bill_len`, `bill_depth_mm→bill_dep`, `flipper_length_mm→flipper_len`, `body_mass_g→body_mass`. Every `aes()`/`select()`/`gt` reference in the 3 example files + any lifted lab must be renamed, and `library(palmerpenguins)` dropped. Pair it with `%>%`→`\|>` (present in the 3 examples + `raukr-2025` slides) in the same pass.
- **Genuine rework (not re-skin):** the **Typst Star Wars lab** — body prose, tables, the SW palette/logo/`Star Jedi` font hacks (`#show heading` glyph fix) are Star-Wars-specific. Keep the Typst+`_brand.yml` *technique*; rewrite the *subject* to penguins + RaukR brand. This is authoring, not find-and-replace.

## 4 · Hidden gems (better than the plan assumes)

1. **Day 2 is not "no existing deck."** `topic-store.md` Block 2 header says "mostly new, no existing deck," and the inventory tables Day-2 items as `_(new)_`. But **`user2024-tutorial-quarto` 3-projects.qmd (22-947) is a complete EN Day-2 deck**: `_quarto.yml`, websites, navbar/sidebar, blog, listings, books, freeze/cache-contrast, publishing — with hands-on beats. **Promote it to the Day-2 deck base**, the way `raukr-2025` slides is the Day-1 base. Biggest correction to the plan.
2. **R-side `_brand.yml` branding already works.** The inventory hedges the R `brand.yml` package as "young … verify it installs." Christophe's `tuto-quarto-typst-rr-2026` book correction *ships and tests* `theme_brand_gt`/`theme_brand_ggplot2`/`brand_color_pluck` **plus palette-swap** (`_brand-empire/jedi/mando.yml`) — the exact "one file → site+slides+plots, swap the palette" DEMO, de-risked.
3. **Deep Typst+book edge-case knowledge, documented.** `02-projet-book/correction/_quarto.yml:21-52` records real Quarto bugs (book+`_brand.yml` #14517 fixed in 1.10.4, the `book.with()` font fallback, logo-overlap) with fix-version notes. A ready-made "gotchas" appendix for the books DEMO — and a signal the Typst payoff is technically safe.
4. **`user2024-quarto-talk` Typst focus** (index.qmd:369-428, "Typst CSS for nice table output in PDF" + live HTML-table-with-CSS build). A sharper *hook* for the Typst-first opener than the raukr-2025 deck's LaTeX-leaning formats section.
5. **The companion R package** (`tuto-quarto-typst-rr-2026/pkg/`) — `verifier-installation()`, `installer-exercices()`, `diagnostiquer-rendu()` solve exactly the beginner-panel's "40 laptops, environment cliff" P0s. Reuse the pattern for RaukR onboarding.

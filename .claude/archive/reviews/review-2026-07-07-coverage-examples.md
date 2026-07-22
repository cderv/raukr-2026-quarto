# Review — Gallery / examples / ecosystem coverage (what to *show*)

**Type:** coverage-examples (ad-hoc scope) · **Date:** 2026-07-07 · **Reviewer:** ecosystem survey
**Frame read:** `topic-store.md`, `project-context.md` (penguins spine, Quarto ≥1.8, life-science R audience).

## Verdict

The triage in `topic-store.md` is well-aimed — the CORE/DEMO calls match what actually lands
in a room. The gallery mostly **confirms** our picks and hands us **ready-made, penguins-native
exemplars** for nearly every beat (dashboards, branded PDF, websites). The survey surfaces **one
genuine coverage gap worth acting on** — **journal/preprint templates as the tail of the
Day-1 Citations→Typst payoff** (the penguins paper is a real PLoS ONE article — the loop closes
itself) — plus a handful of MENTION-level adds. It also flags a **real live-demo trap**: several
"academic PDF" templates are **LaTeX-based**, which quietly reintroduces the tinytex install our
Typst story exists to avoid. Prefer **Typst-native** academic formats for anything rendered live.

Notable finds: **1 add-MENTION worth promoting toward DEMO** (journal/preprint templates),
**3 other MENTION adds** (study-flow diagrams, quarto-live/wasm, clean-revealjs as brand prior-art),
**1 reality-check correction** (LaTeX-vs-Typst academic templates), and a set of drop-in penguins
exemplars for the shortlist.

---

## 1. "Show these" shortlist (ranked, per day)

### Day 1 — Introduction to Quarto (single doc → HTML → cited → branded Typst PDF)

1. **RevealJS demo deck** — <https://quarto.org/docs/presentations/revealjs/demo/>
   *The canonical "one source → a real presentation"; use as the "doc types" beat, not a from-scratch build.*
2. **Tufte-style HTML + PDF advanced layout** — <https://quarto-dev.github.io/quarto-gallery/page-layout/tufte.html>
   *One source, margin figures/asides, renders to both HTML and PDF — exactly the "Layouts" CORE (columns/margin/outset) in one artifact.*
3. **quarto-preprint (Matti Vuorre)** — <https://github.com/mvuorre/quarto-preprint>
   *Typst-native, opinionated preprint format. The safest live "manuscript-grade PDF" demo — no LaTeX. This is the Part-2 Typst payoff target.*
4. **academic-typst / clean-typst (Yanagimoto)** — <https://github.com/kazuyanagimoto/quarto-academic-typst> · <https://github.com/kazuyanagimoto/quarto-clean-typst>
   *clean-typst even ships a `penguins` `facet_wrap` example — re-skin-free. Typst-only, `quarto use template …`, installs nothing.*
5. **quarto-journals/plos** — <https://github.com/quarto-journals/plos>
   *The closer for the Citations beat: the penguins data comes from Gorman et al. 2014 *PLoS ONE*, so "cite the real paper, then here's the PLOS submission template" is a self-closing loop. Show as a link/`quarto use`, not a live render (LaTeX — see reality check).*
6. **R for the Rest of Us — Typst PDF walkthrough** — <https://rfortherestofus.com/2025/11/quarto-typst-pdf>
   *Current (Nov 2025), R-audience-framed proof that Typst is now the default PDF path. Good "further reading" link on the recap slide.*

### Day 2 — Quarto projects (website → brand → freeze → publish, + demos)

1. **posit::conf(2025) "Branded … with Quarto" workshop** — <https://posit-conf-2025.github.io/quarto-brand/> (Typst module: `/materials/04-typst/slides.html`)
   *The single best current reference for our whole brand story: one `_brand.yml` → website + slides + dashboard + Typst PDF. Lift the structure for the Day-2 `_brand.yml` DEMO; don't reinvent it.*
2. **Branded-Quarto demo (Isabella Velásquez)** — <https://ivelasq-branded-quarto.share.connect.posit.cloud/>
   *Concrete before/after of default theme → branded, across formats. The "one file, consistent everywhere" DEMO made visual.*
3. **Penguins dashboard (static + Observable)** — <https://jjallaire.github.io/ojs-penguins-dashboard/> and R version <https://jjallaire.github.io/penguins-dashboard/>
   *Penguins-native, self-contained (no Shiny server). Use the **static/OJS** one live; it exercises the full layout model (rows/cols, valueboxes, tabsets) the technique review said dashboards need to not look underwhelming.*
4. **Labor & Delivery dashboard (Çetinkaya-Rundel, R)** — <https://mine-cetinkaya-rundel.github.io/ld-dashboard/>
   *A polished, life-science-flavored dashboard for the "share results with a wet-lab collaborator" tie-in.*
5. **R for Data Science 2E** — <https://r4ds.hadley.nz/> · **R Packages** — <https://r-pkgs.org/>
   *Instantly-recognized "this is a Quarto **book**" proof for the Books demo; no need to build one live.*
6. **STA 210 course site** — <https://sta210-s22.github.io/website/> · **Quarto tip a day** — <https://mine-cetinkaya-rundel.github.io/quarto-tip-a-day/>
   *Clean website + listings exemplars that map onto the "lab site / capstone" motivation — realistic targets, not corporate showcases.*
7. **ALA Labs** — <https://labs.ala.org.au/> · **NHS-R community** — <https://nhsrcommunity.com>
   *Real ecology / healthcare Quarto sites — "researchers like you already ship with this."*

---

## 2. Ecosystem gaps vs `topic-store.md`

| Capability | Evidence | Call | Rationale |
|---|---|---|---|
| **Journal / preprint templates** (`quarto-journals/plos`, `biorxiv`, `nature`, `elsevier`, `mdpi`) | quarto-journals org + community listing | **add MENTION → lean DEMO on Day 1** | The audience *submits to these journals*. topic-store's Citations CORE stops at `.bib`/CSL; the natural next sentence is "…and `quarto use template quarto-journals/plos`." Ties directly to the penguins/PLoS ONE anchor already in `project-context.md`. One slide + a link; the payoff exercise stays penguins-Typst. |
| **study-flow** (CONSORT / STROBE / PRISMA participant-flow diagrams) | <https://github.com/tiagojct/quarto-study-flow> | **add MENTION** | Niche but *precisely* this audience — clinical/epi manuscripts need these diagrams. A single "Quarto even does your PRISMA diagram" slide is a credibility win. Resources page at minimum. |
| **quarto-live / r-wasm** (interactive, editable R that runs in-browser, no server, in HTML *and* slides) | <https://github.com/r-wasm/quarto-live> | **add MENTION** (align with existing wasm caution) | Distinct from — and for R people, more compelling than — the Shinylive teaser already in topic-store. Frame identically: link + pre-built example, **never a live build**. Worth naming because it's the modern answer to "can students run this without installing anything." |
| **clean-revealjs (grantmcdermott)** | <https://github.com/grantmcdermott/quarto-revealjs-clean> | **MENTION / internal prior-art** | Widely-used elegant reveal theme; useful reference while we rebuild the RaukR look via `_brand.yml` + thin `.scss`. Not shown to participants, but a peer artifact for the branding work. |
| **`_brand.yml` → R plots/tables helpers** (`theme_brand_ggplot2/gt/thematic/plotly/flextable`) | quarto R pkg v1.5.0 (Jul 2025); brand-yml docs | **already DEMO — confirm the version floor** | topic-store already flags this and the youth of the R side. Survey confirms: these helpers are **quarto R package ≥1.5.0** (not base R) — pin it on the setup page alongside the "installs via `install.packages()`, `pak` KO" note. |
| **Quarto Manuscripts** (narrative + live notebooks, journal submission) | quarto.org/docs/manuscripts; Mine's R/Medicine talk | **keep STORE, but MENTION-with-link** | topic-store's "too complex for the slot" call holds. But for *this* audience it's the marquee academic feature — one sentence + link so nobody leaves thinking Quarto can't do it. Pairs with the journal-templates MENTION above. |
| **lightbox / fontawesome / include-code-files** | quarto-ext org | **already covered** | lightbox already MENTION; fontawesome already handled as a declared extension dep. No change. |

Everything else in topic-store's CORE/DEMO is **confirmed** by the gallery — no over- or
under-scoping found on the confirmed items.

---

## 3. Reality check — impressive but fragile / heavy to demo live

- **"Academic PDF" templates are split LaTeX vs Typst — and it matters.** The journal templates
  most relevant to this audience (**PLOS, elsevier, biorxiv, nature**) are largely **LaTeX-based**,
  which pulls in tinytex — the exact install the Typst payoff is built to avoid. **Do not render
  these live.** For any live PDF, use a **Typst-native** format (**quarto-preprint**,
  **academic-typst**, **clean-typst**). Show the journal templates as *links / `quarto use`*, not
  as a render. (This is a real correction to make explicit in the Day-1 authoring notes.)
- **Shiny-backed dashboards** (e.g. `penguins-dashboard` Shiny, `diamonds-explorer`) need a running
  server — a room-killer. Use the **static/OJS penguins dashboard** instead; identical wow, zero infra.
- **wasm interactivity** (Shinylive, quarto-live, OJS-heavy dashboards) — heaviest, flakiest thing
  available; matches topic-store's standing "no live build" rule. Pre-built cached example + link only.
- **RevealJS plugin candy** (spotlight, roughnotation, confetti, `drop` wasm console, excalidraw) —
  fun, but each is an **extension dependency that prints raw shortcode text if missing** and **does
  not travel** into the NBIS tree (the portability rule in `project-context.md`). Keep them off the
  fold-in content; if used in our standalone deck, declare via `quarto add`. `drop` (in-slide R
  console) is wasm — same flakiness caveat.
- **Live publish to GitHub Pages** — already topic-store's only P0; nothing here changes that.
  Keep it a watch-me DEMO on a pre-provisioned repo.
- **titlepage-pdf / PrettyPDF** — nice but LaTeX-styling extensions, superseded by our Typst-first
  story; resources-page at most.

---

### Sources
Gallery <https://quarto.org/docs/gallery/> · format extensions <https://quarto.org/docs/extensions/listing-formats.html> · revealjs <https://quarto.org/docs/extensions/listing-revealjs.html> · filters <https://quarto.org/docs/extensions/listing-filters.html> · journals <https://quarto.org/docs/extensions/listing-journals.html> · awesome-quarto <https://github.com/mcanouil/awesome-quarto> · posit::conf(2025) quarto-brand <https://posit-conf-2025.github.io/quarto-brand/> · brand.yml <https://posit-dev.github.io/brand-yml/> · Typst basics <https://quarto.org/docs/output-formats/typst.html> · Typst brand-yaml <https://quarto.org/docs/advanced/typst/brand-yaml.html> · R-for-the-Rest-of-Us Typst <https://rfortherestofus.com/2025/11/quarto-typst-pdf> · Manuscripts <https://quarto.org/docs/manuscripts/>.

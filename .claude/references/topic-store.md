# Topic store — RaukR 2026 Quarto session

> A scope-control artifact: list every teachable topic and triage it by whether it belongs in
> the live session. Keeps the two afternoon slots (150 min and 180 min) from ballooning and gives cut
> topics a home (a resources page / appendix).
>
> **Status (2026-07-06):** the two blocks are now anchored on the **organizer-suggested topic
> lists** (paraphrased in `project-context.md` § *Reference URLs → Organizer scope guidance*).
> The **CORE/DEMO/MENTION/STORE** triage on top is Christophe's call. Confirmed so far
> (2026-07-06): Citations & article layouts → CORE; Positron kept minimal (Quarto integration
> only); Manuscripts dropped (too complex); Dashboards & `_brand.yml` kept; **Rmd→Quarto
> de-emphasized** (teach native `.qmd`, migration is a quick note). Remaining marks are
> still a *proposal* to react to. Organizers stressed: these are suggestions, and the
> **slots are upper limits** — land fewer things well. Tags: _(exists)_ = prior NBIS/mine
> material to build on; _(new)_ = build from scratch; _(mine)_ = my addition beyond the
> organizer list.
>
> **State at close of 2026-07-07 — the triage is CONFIRMED, not a proposal.** A full day of
> review + decisions turned the draft into the applied plan below, each step backed by a commit:
> - **Scope:** load, not direction, was the risk. Day-1 Part 2
>   slimmed to *Citations → Typst*; Parameters/Shortcodes → MENTION; Day-2 `_brand.yml` → Part 1;
>   Publishing live-CI → watch-me DEMO (the beginner's only P0 = the live-publish auth cliff);
>   per-part **time budget** filled; **§ Running-order rules** added.
> - **NBIS reuse review** → `prior-art-inventory.md` § NBIS harvest map.
> - **Dataset locked:** base-R `datasets::penguins` (R ≥ 4.5, zero-install) — see
>   `project-context.md` § Technical stack.
> - **Layouts sharpened** to the organizer's five terms (scope note under the Day-1 CORE table).
> - **Convention decided:** mode markers = built-in callouts at
>   the two transitions, no bespoke class (rule 9 + `project-context.md` § Content patterns).
> - **Coverage audit** → § *Coverage-audit deltas* below.
> - **Build-gap audit:** Day-1 ~80% / Day-2 ~60% reuse; only 4
>   true build-fresh items; Day-2 deck base exists (Block 2 correction). See `prior-art-inventory.md`.
>
> The `_(confirmed 2026-07-07)_` tags on the tables mark this. Still open (not blocking): the two
> **topic-folder names** (`slides/<topic>/`) and the **logo assets**.

## Priority levels

- **CORE** — must be in the live session (slides + demo + exercise)
- **DEMO** — worth showing live, no dedicated exercise (watch-me only)
- **MENTION** — one slide or a verbal note, link to resources
- **STORE** — cut from the live session; keep on the resources page or appendix slides

## Framing

**The angle:** *"You already write R (and have met R Markdown/Quarto). Here's what Quarto is as
a system, and how to go from a single document to a whole project you can publish."* One beat
per day; each day is **two parts with a gap**, so each part should stand somewhat on its own
and reach a hands-on payoff.

- **Day 1 — Introduction to Quarto:** the single document — **take the time to do it well**:
  authoring, layout, and the modern output story (incl. Typst). Teach **Quarto-native (`.qmd`)
  from the start**; the R Markdown → Quarto migration is a *quick reassurance*, not the spine —
  that framing fit 2023–24, but in 2026 this audience can go native directly.
- **Day 2 — Quarto projects:** beyond one file — websites/books, the config that ties documents
  together, publishing, **and all the tips & tricks**. Feeds their team project.

Audience calibration: **skip "what is a code chunk"** — they have it. Spend the saved time on
Quarto-native features, layout, and the migration/upgrade story.

---

## Block 1 — Introduction to Quarto (Mon 10 Aug · 13:30–15:00 + 15:30–16:30)

**Organizer-suggested topics** — *Basics:* Markdown (text/code formatting, figures, tables) ·
Layouts (pages, outset, inset, columns, panels) · Document types (reports, presentations) ·
Execution options (knitr/R engine, chunk attributes) · Positron-specific bits. *Intermediate:*
Parameters · Shortcodes · Citations · Typst.

2-part split (revised 2026-07-07): **Part 1 = Basics** (author a document, land HTML with
layout), **Part 2 = Citations → Typst only** — the review cut Parameters/Shortcodes from this
part so the Typst payoff isn't squeezed to ~4 min (technique P1-1, pedagogue P1-1/P1-2). Part 2's
hands-on = the two payoff exercises (a cited doc, then that doc as a branded Typst PDF).

### CORE _(confirmed 2026-07-07)_

| Topic | What to show | Notes |
|-------|--------------|-------|
| What Quarto *is* — **native `.qmd`** | one tool, many outputs, multi-engine; start native, don't route through Rmd | _(exists, reframe)_ the hook |
| Markdown & content | figures, tables, cross-refs, **+ math (`$$…$$ {#eq-}` / `@eq-`), inline code `` `{r} ` ``, callouts** — taught as **deltas**, fast | _(exists)_ **not "just fast deltas"** — this bucket carries 5-6 deltas incl. the CORE-delta **math** (research audience); budget Part-1 accordingly (coverage authoring GAP 1/3/5, mis-triage) |
| Layouts _(organizer-requested list)_ | `page-layout: article/full` · **margin content** (margin figures/captions/`.aside`) · **inset/outset** for wide figs/tables · **multi-column** `::: {.columns}` · **panels** (tabsets + `layout-ncol` figure/table panels) | _(new emphasis)_ high value for a figure/table audience. **Scope + the revealjs caveat below the table** ↓ |
| Document types | reports + presentations from one source | _(exists)_ reuse the "1 doc → many formats" demo |
| Citations | `.bib`, `@ref`, CSL styles | _(exists, but ⚠️ thinnest asset)_ **CORE** — the audience writes research articles. Build a **real** exercise (not a `@ref` wave-through): ship a **pre-filled `.bib`**, a mainstream CSL, and **smoke-test the citation example in the *Typst* format specifically** — the CSL↔Typst-native bibliography handoff has edge cases (beginner P1-3, technique P1-5) |
| Typst | modern PDF without LaTeX | _(new emphasis)_ the Part-2 payoff; my area. **Say it explicitly: Typst ships *inside* Quarto — no LaTeX, nothing to install** + a pre-flight version check vs the ≥1.8 floor (beginner P1-1). Technically safe to promise: bundled, deterministic (technique ✅) |

> **Layouts — scope note** (2026-07-07; verified against the Quarto docs after the organizers
> explicitly listed "pages, outset, inset, columns, panels"). Those five terms map to *distinct*
> features — teach them as **one "Layouts" beat**, but they are not one option:
> - **pages** → `page-layout: article \| full` — the overall grid (sidebar / body / margin /
>   gutters); [page-layout](https://quarto.org/docs/output-formats/page-layout.html). Distinct
>   from the `.column-*` classes below (don't conflate the two).
> - **outset** → extend *beyond* the body (`.column-body-outset`, `.column-page`).
> - **inset** → widen *keeping* margins (`.column-page-inset`, `.column-screen-inset`).
> - **columns** → the body/page/screen/**margin** model + `column: margin` cell option (=
>   **margin figures/tables** — the signature article win) + multi-column `::: {.columns}`;
>   [article-layout](https://quarto.org/docs/authoring/article-layout.html).
> - **panels** → `.panel-tabset` + **layout panels** (`layout-ncol`, `layout="[[1,1],[1]]"`) to
>   arrange figures/tables; these live on the figures/tabset pages, *not* article-layout.
>
> **Teach the useful 80%:** `page-layout: article/full`, margin content (figures/captions/
> `.aside`), inset/outset for wide figures/tables, multi-column, tabsets + figure layout panels.
> **Skip the niche:** full-bleed `screen`, landscape, `page-layout: custom`. **⚠️ Format caveat**
> (technique P2-4): this column/margin model is an **HTML/Typst article** idiom — it does **not**
> transpose to revealjs; when teaching "1 source → report + presentation", say so. **🔗** Margin
> figures/tables still take `@fig-`/`@tbl-` → Layouts pairs naturally into the Cross-refs beat.

### DEMO _(confirmed 2026-07-07)_

| Topic | Notes |
|-------|-------|
| Execution options | knitr/R engine, chunk attributes — show the deltas, don't re-teach chunks _(exists)_ |
| Positron × Quarto | **only the Quarto integration**, not Positron itself — participants will likely have seen it in an adjacent slot; keep minimal. ~~Note: Positron has **no** RStudio-style visual editor — scope it to RStudio.~~ **Correction (2026-07-15, verified vs quarto.org/docs/visual-editor + tools/vscode + tools/positron): the visual editor is built into the RStudio IDE, and available in Positron AND VS Code through the Quarto extension** (source / visual / notebook editors) — the authoring beat says "built into RStudio; in Positron and VS Code via the Quarto extension" (technique P2-3, resolved) _(new)_ |

### MENTION _(revised 2026-07-07)_

| Topic | Notes |
|-------|-------|
| Rmd → Quarto migration | **go quick** (2026 = native-first): hash-pipe, `convert_chunk_header()`, `.Rmd` renders as-is — a short reassurance for people with Rmd baggage, not a segment _(exists)_ |
| Parameters | **BUILT 2026-07-22 as a Day-1 lab optional bonus**, superseding the earlier "→ Day 2" note here. The CLI-override was the reason to defer to Day 2, but Day-1 *already* runs `quarto render … --to typst` from the terminal, so `-P species:…` is the same muscle — no reason to move it. Kept optional/MENTION-level (no spare core time). See `labs/quarto/index.qmd` § "Bonus — one report per species" + `penguins-by-species.qmd` _(built)_ |
| Shortcodes | **demoted from DEMO**: fold into a single ~3-min quick-win if time, else a link. `embed`, `include`, `video` _(new)_ |
| Code presentation niceties | `code-annotation`, `code-line-numbers`, `code-fold` _(new)_ |
| Lightbox | `lightbox: auto` for zoomable figures — easy modern win _(new)_ |
| Word `docx` | **added** (coverage authoring) — name-check in "1 source → many formats"; collaborator/journal format (track changes) _(new)_ |
| Conditional content | **added** (coverage authoring) — `.content-visible when-format` + "Other Formats" links complete the multi-format story _(new)_ |
| Diagrams (mermaid/graphviz) | **added** (coverage authoring) — link only, **off the critical path** (PDF/Typst needs Chrome); PRISMA study-flow is the life-science hook _(new)_ |
| Accessibility | **added 2026-07-22** — one Part-1 slide ("Make it accessible") + a lab callout, widening the existing `fig-alt` value into three habits: alt text (callback), colour-blind-safe palettes (`ggokabeito::scale_colour_okabe_ito()`, applied to the penguins plot), and Quarto's built-in `axe` contrast checker (`axe: true`, in since 1.8). Threaded through Learning Outcomes + "What you can do now". Not a hands-on exercise — a habits slide + a lab note. Rationale: axe is often unknown, and default ggplot palettes aren't CVD-safe (~8% of men). Ref: `references/colorblind-safe-palettes.md` _(new)_ |

> **Note — the title block / Authors & Affiliations** (`author:` name/affiliation/orcid, abstract)
> folds into the **Citations → Typst payoff** as ~1 slide (makes the PDF a *real article*); not a
> separate MENTION. Callouts-as-content and Math live inside the Markdown&content CORE bucket. See
> § *Coverage-audit deltas* for the full rationale.

### STORE _(confirmed 2026-07-07)_

| Topic | Why cut |
|-------|---------|
| Deep chunk-option tour | audience already knows chunks |
| LaTeX/xelatex/tinytex mechanics | lead with Typst; LaTeX → resources |
| Rmd legacy comparison dump | keep only the migration deltas |
| Confluence / Netlify publishing | belongs in Day 2 / resources |

---

## Block 2 — Quarto projects (Tue 11 Aug · 13:30–15:00 + 15:30–17:00) — _deck base exists_

> **Correction (2026-07-07, build-gap audit):** not "mostly new" — `user2024-tutorial-quarto`
> `3-projects.qmd:22-947` is a **complete EN Day-2 deck** (websites, navbar/sidebar, blog,
> listings, books, freeze/cache contrast, publishing, with Our/Your-turn beats). Promote it to
> the Day-2 deck base (as `raukr-2025` is for Day 1). Day 2 is ~60% reuse, not new-build.

**Organizer-suggested topics** — Websites · Books · Navigation · Caching · Freeze ·
Cross-referencing · Publishing · Interactivity.

2-part split (revised 2026-07-07): **Part 1 = build & structure a project** (a website,
navigation, cross-refs, **+ `_brand.yml`** — it's project config, moved here from Part 2 per
pedagogue P1-2), **Part 2 = scale & ship** (freeze, publishing as the payoff). The demos
(Dashboards, Interactivity, Books) live **after** the publish payoff so timing pressure trims
the tour, never the hands-on.

### CORE _(confirmed 2026-07-07)_

| Topic | What to show | Notes |
|-------|--------------|-------|
| Why a *project* | `_quarto.yml`, shared config, `output-dir` | _(new)_ the one-file → whole-site jump |
| Websites | pages, navbar/sidebar **navigation**, listings | _(exists)_ richest base: `labs/quarto-site` |
| Cross-referencing | across pages/chapters of a project | _(new)_ organizer-listed |
| Freeze (& caching) | `_freeze/` reproducible builds; knitr `cache` vs quarto `freeze` | _(new)_ distinguish the two. **Lead with the motivation** (slow bioinformatics compute you don't want to re-run every render) then the crisp contrast: `cache` = within a doc's re-render / `freeze` = don't re-execute at project build, committed to `_freeze/`, the thing that lets **CI render without R**. Value only *shows* across 2 renders / a commit / a CI run — scenario it as "render, edit prose, re-render → code didn't re-run" (technique P2-1, beginner P1-4) |
| Publishing | **hands-on = `quarto render` + `output-dir`**; putting it online = **optional last step via `quarto publish posit-connect-cloud`** | _(new)_ ⚠️ was the review's only P0 (beginner): a live `quarto publish gh-pages` for 40 people (GitHub auth on the laptop, repo, gh-pages, conf wifi) is a room-killer. **Revised 2026-08-03 — gh-pages is dropped entirely, not demoted to watch-me.** The workshop never teaches git or GitHub and `use_course()` is sold on not needing them, so a Pages demo teaches a path the room cannot walk. **Posit Connect Cloud** removes every blocker: verified that `quarto publish posit-connect-cloud` uploads locally rendered static content with **no repository required**, browser OAuth, and a free tier with unlimited static documents. It becomes an *optional* end-of-session "Your turn" (and the named overflow for fast finishers). The only slow part, creating the Posit account, moves to `setup.qmd` as an optional pre-event line. The generic CI *story* stays where it already lives, in the freeze beat |

### DEMO _(confirmed 2026-07-07)_

| Topic | Notes |
|-------|-------|
| `_brand.yml` | one brand → site + slides + **R-side plots/tables** (`theme_brand_ggplot2/gt/thematic()`); **→ runs in Part 1** (project config). _(exists & tested)_ **de-risked (build-gap 2026-07-07):** the R-side branding already **ships and works** in `tuto-quarto-typst-rr-2026` (book correction: `theme_brand_gt`/`theme_brand_ggplot2`/`brand_color_pluck` + palette-swap `_brand-{empire,jedi,mando}.yml`) — lift it, re-skin brand→RaukR. Still: pin `install.packages("brand.yml")` on setup (participants use `install.packages()`); it carries the **palette + base type**, not the whole brand system → frame as "same palette across site/slides/plots"; native format-brand and the R package are **two mechanisms reading one file** (technique P2-2). **Locked to Part 1** as a 4-min CORE-window beat — it's load-bearing for the Part-1 "branded website" payoff, so it runs *with* project config, not in the Part-2 tail |
| Dashboards | `format: dashboard` — a useful modern output. Budget for the layout model (rows/cols, `orientation`, `.card`, valueboxes, tabsets) — it's more than `format: dashboard` or it lands as an underwhelming single-plot page (technique P2-5) _(my addition)_ |
| Interactivity | **lead with an htmlwidget** (`plotly`/`leaflet` — pure R, reliable); mention **OJS** as "a non-R path" with a link; **Shinylive → MENTION only** (needs the extension + webR/wasm, the flakiest thing in the plan — no live build) (technique P1-4) _(new)_ |

### MENTION _(revised 2026-07-07)_

| Topic | Notes |
|-------|-------|
| `_metadata.yml` | directory metadata — **promoted to a shown slide** in the `_quarto.yml` CORE beat (load-bearing for the NBIS fold-in; coverage projects GAP 2). _(new)_ |
| Profiles | `--profile`, `_quarto-<p>.yml` — one slide/link, don't demo _(new)_ |
| Books | **demoted DEMO→MENTION** (coverage projects): ~90% shared machinery with Websites; teach only the **book-vs-website decision** (1 slide) + typst-2026 book as the resources link _(new)_ |
| ~~Parameters~~ | **superseded** — landed on **Day 1** as an optional lab bonus 2026-07-22, not here. See the Day-1 table above _(resolved)_ |
| Shinylive | interactive-app teaser — link + a pre-built cached example at most, never a live build (technique P1-4) _(new)_ |
| renv / reproducible env | **added** (coverage projects GAP 1) — one slide inside the Freeze CORE beat: `renv.lock` = the 2nd reproducibility leg (pin *what* runs) _(new)_ |
| Website tools | **added** (coverage projects) — one bundled slide: drafts · search-is-free · redirects; social cards/404 → resources _(new)_ |
| Using extensions | **added** (coverage advanced) — the `quarto add` / `quarto use template` verb + listings gallery _(new)_ |
| Other publish targets | Quarto Pub, Connect Cloud — links |

### STORE _(confirmed 2026-07-07)_

| Topic | Why cut |
|-------|---------|
| Manuscripts | scholarly `manuscript` project — too complex for the slot (Christophe); mention/link at most |
| Blog plumbing (about templates, social) | nice-to-have from the site lab → resources |
| Deep Bootswatch theming | superseded by `_brand.yml` in our story |

---

## Coverage-audit deltas (2026-07-07 — the doc-coverage pass)

> From the coverage audit (authoring / projects / advanced / examples), which mapped the **full quarto.org
> taxonomy** (via `llms.txt`) against this triage. Verdict: the triage is well-shaped; these are
> the **cheap, article-relevant absences** to fold in — none needs a dedicated slot. Applied on
> top of the tables above.

### Day 1 — additions & re-scopes

- **Math / LaTeX equations → CORE-delta** inside Markdown&content: `$…$`, `$$…$$ {#eq-id}`,
  `@eq-id`. Research audience; ~1 slide; the highest-relevance cheap win (authoring GAP 1).
- **Title block + Authors/Affiliations → 1 slide inside the Citations→Typst payoff.** `author:`
  (name / affiliation / `orcid` / `corresponding`), abstract — the few YAML lines that make the
  Typst PDF look like a **real article**; renders HTML/PDF/Typst (authoring GAP 2, advanced GAP 1).
  Don't teach full journal formats to get here.
- **Inline code `` `{r} expr` `` → MENTION delta** in the authoring value-adds — report the n /
  p-value / date *from the data* in prose (reproducible article) (authoring GAP 5).
- **Callouts as a taught feature → MENTION** (~1 min; already on screen as mode-markers)
  (authoring GAP 3).
- **Word `docx` → MENTION (name-check)** in the "one source → many formats" demo — the
  collaborator / journal-submission format (track changes) (authoring GAP 4).
- **Conditional content + "Other Formats" links → MENTION** — completes the multi-format story
  (`.content-visible when-format`, `html-multi-format`) (authoring GAP 6).
- **Diagrams (mermaid/graphviz) → MENTION / link only, off the critical path** — PDF/Typst needs
  a Chrome install, friction against the no-install Typst promise (authoring GAP 7). *(A PRISMA
  study-flow diagram is the life-science hook if ever shown — examples pass.)*
- **Re-scope (the one real mis-triage):** "Markdown & content" is **not** just "fast deltas" — it
  now carries figures + tables + cross-refs **+ math + inline code + callouts** (5-6 deltas).
  Budget the Part-1 concept/demo window for its true width, or the cheap wins get squeezed out.
- **Merges (protect time):** HTML theming → folded into `_brand.yml` (no separate Bootswatch
  beat); Document types + revealjs + multi-format = **one** live "1 source → many formats" render,
  not three segments.
- **Positron DEMO → MENTION** is the first thing to compress if Part-1 runs tight (Jenny covers
  Positron-the-IDE). ~~Verify the "visual editor" claim — scope it to RStudio if Positron lacks it.~~
  **Resolved (2026-07-15): the visual editor is built into RStudio, and in Positron AND VS Code via
  the Quarto extension** (verified vs quarto.org) — the slide says so.

### Day 2 — additions & re-triage

- **renv / reproducible environment → MENTION, one slide inside the Freeze CORE beat** (no new
  hands-on). The **second** reproducibility leg: `freeze` = "don't re-run the slow compute" /
  `renv.lock` = "pin *what* runs, so the team rebuilds the same env." Don't ship the
  CI-renders-without-R story on freeze alone (projects GAP 1).
- **`_metadata.yml` → PROMOTE** from buried MENTION to a **shown slide** in the `_quarto.yml` CORE
  beat — load-bearing for the NBIS fold-in (folder metadata + `{{< meta >}}` keys travel with the
  file) (projects GAP 2). *(= decision (c).)*
- **Books → DEMO downgraded to MENTION** — shares ~90% machinery with Websites; the only new
  teachable is the **book-vs-website decision** (1 slide) + Christophe's typst-2026 book as the
  resources link. Frees the post-payoff tail for one novel demo (projects mis-triage). *(=
  decision (b).)*
- **Website-tools → one bundled MENTION slide:** **drafts** (`draft:` — team WIP on a shared
  site), **search is free** (on by default — say so, don't build it), **redirects** (`_redirects`
  — matter when the fold-in relocates URLs); social cards / 404 → resources (projects GAPs 3-4).
- **Using extensions → one explicit MENTION** — the `quarto add` / `quarto use template` verb +
  the listings gallery (logos, journal templates, plugins already arrive this way) (advanced #4).
- **Manuscripts → keep STORE, add a 1-slide Day-2 signpost** ("a `manuscript` project type bundles
  article + computations + a submission archive") + resources link — a pointer, not a taught
  segment (advanced #2).
- **Journal formats/templates → resources link only** (`quarto use template
  quarto-journals/<journal>`) — per-journal idiosyncrasy, not transferable; the transferable slice
  (authors + citations + branded Typst) is the Day-1 climax (advanced #3). Prefer **Typst-native**
  preprint templates (`quarto-preprint` / `clean-typst`) over LaTeX ones, which reintroduce
  tinytex (examples reality-check).
- **Publishing CORE kernel is narrow** — the honest hands-on CORE is `render` + `output-dir` +
  point Pages at it; keep CORE but author it as "your project renders to a publishable folder,"
  with the reproducible-CI arc (freeze **+ renv**) narrated on the pre-provisioned repo (projects
  mis-triage).

### Confirmed by the audit — no change (green lights)

- **Interactivity split** (htmlwidget lead / OJS link / Shiny MENTION / Shinylive cached-only) —
  confirmed verbatim (advanced #5).
- **Dashboards** DEMO, static only (budget the layout model or it's a single-plot page) —
  confirmed.
- **Extension *authoring*** (formats / filters / Lua / revealjs plugins / brand packaging) —
  **firmly OUT**, resources page (advanced).
- **Interactive dashboards** (Shiny/OJS backend) — firmly out; static `format: dashboard` is the
  DEMO ceiling.
- Net budget effect (projects agent): **+~2 slides** (renv leg, bundled website-tools),
  **+1 promoted** (`_metadata.yml`), **−1 live demo** (Books→MENTION) — budget-neutral to positive.

---

## Time budget (per part — from `workshop-pacing.md`, ~2:1 hands-on)

Filled 2026-07-07; **reworked 2026-07-21** to the **verified slot times** (see `project-context.md`
§ Event) — the parts are longer than the old 2×60/day: **Day 1 = 90 + 60**, **Day 2 = 90 + 90**
(+90 min total). Per the **Option A** decision, the extra time goes to **hands-on + a Day-1 setup
checkpoint, not more lecture** — concept+demo stays ~18-20 min, hands-on grows 30 → ~45-50. A 90-min
slot is **~85 min effective**, a 60-min slot **~55**. Slots are **upper limits** — aim to finish a
little early. Still the **gating test for CORE**: if a part's list doesn't fit at ~2:1, cut from the
list, not from the exercise.

**Day 1 · Part 1 — Basics → land an HTML doc** *(90 min)*

| ~min | Phase | Mode | Content |
|------|-------|------|---------|
| 10 | **setup checkpoint** *(new, 2026-07-21)* | My + Your | everyone renders a hello-world; confirm R ≥ 4.5 / Quarto / packages (`knitr`+`rmarkdown`+content pkgs) — **catch broken laptops on day one**, before content |
| 5 | frame + the "what you'll build" hook (aspiration, not "it's just Rmd+") | My | What Quarto *is*, native `.qmd` |
| 20 | concept + live demo | My | Markdown as deltas (fast) · Layouts (columns/margin/page) · doc types (1 source → many) |
| 45 | hands-on | Your | Author a doc **starting at authoring value-adds (Ex4)**, add layout, render HTML |
| 5 | recap + bridge (pre-load Part-2 framing here) | My | "next: cite it, then ship it as a real PDF" |

**Day 1 · Part 2 — Citations → Typst (the payoff)** *(60 min — the one part that did not grow; keep it a clean payoff)*

| ~min | Phase | Mode | Content |
|------|-------|------|---------|
| 5 | frame | My | from report to article: cite → typeset |
| 16 | concept + live demo | My | Citations (`.bib`/`@ref`/CSL) · Typst (ships in Quarto, no LaTeX) · `_brand.yml` styling of the PDF |
| 30 | hands-on | Your | **two payoff exercises**: (1) add citations to the Part-1 doc, (2) render it as a branded Typst PDF |
| 4 | recap | My | "you now have a branded, citable article" |

> **Reconciled 2026-08-05 (was 18 concept / 28 hands-on).** The deck's Your-turn callout announced
> ~30 min and the table said 28, and the part sums to exactly 55 in a 55-min effective slot, so there
> was no slack to absorb the difference. Resolved in favour of the exercise, per the gating rule
> above: cut from the list, not from the exercise. Concept comes down to 16, hands-on goes to 30, sum
> unchanged, and the slide now matches the plan. Note this part is the one place we announce the full
> budgeted time — both Day-2 parts deliberately announce ~45 against 50/48, so an overrunning demo
> comes out of the gap rather than out of the hands-on.

**Day 2 · Part 1 — build & structure a project** *(90 min)*

| ~min | Phase | Mode | Content |
|------|-------|------|---------|
| 5 | frame + project hook | My | one file → a whole site your team can use |
| 20 | concept + live demo | My | `_quarto.yml` · website + navbar/sidebar · cross-refs across pages · **`_brand.yml`** (site + slides + R plots, same palette) |
| 50 | hands-on | Your | Turn a set of `.qmd` into a navigable, branded website |
| 5 | recap + bridge | My | "next: make builds reproducible, then publish" |

**Day 2 · Part 2 — scale & ship (publish is the payoff)** *(90 min)*

| ~min | Phase | Mode | Content |
|------|-------|------|---------|
| 5 | frame + project hook | My | "this is how your team publishes its project" |
| 17 | concept + live demo | My | Freeze (motivation-first: don't re-run slow compute) · **watch-me** `publish`/CI on a pre-provisioned repo |
| 48 | hands-on | Your | **the payoff**: `quarto render` + `output-dir` on your project (publish = watch-me, auth pre-flighted). _(The parameterized-report step once floated for here landed on **Day 1** instead, 2026-07-22.)_ |
| 15 | recap + questions | My | wrap-up, then Q&A. **Retired 2026-08-09:** the demo tail (Books / Dashboards / an htmlwidget) had its own slide and was cut — it reopened the deck after the arc had closed, and the dashboard is better left as a self-paced lab activity |

---

## Day-2 CORE beat-lock — per-part, per-beat (2026-07-07)

Locks each Day-2 **CORE** beat to a part and splits the *concept + live-demo* minutes from the § budget
above (Part 1 ~18 min, Part 2 ~15 min). Frame (5) + hands-on (30) + recap (5) are unchanged; DEMOs live
in the post-payoff tail (rule 1). This is the beat spine **WP3 (Day-2 deck)** builds against; if a part
runs long, trim a *tour* beat, never the render payoff (rules 1–2).

> **Budget the sums as a *ceiling*, not a target** (pedagogue P1-1): 18/15 is the upper limit; **aim
> ~16 / ~13 effective** so a live-demo overrun has somewhere to go before the sacred 30-min hands-on.
> The **named per-part shock-absorber** — the beat that trims first under pressure — is **Cross-refs
> (Part 1, 3 min)** and the **`renv.lock` slide inside Freeze (Part 2)**; cut there, not from the payoff.

> **Slot-length update (2026-07-21).** Both Day-2 parts are now **90 min** (verified times, § Time
> budget). Per **Option A**, the extra ~30 min/part goes to **hands-on**, not concept — so these
> per-beat **concept+demo ceilings (~18 / ~15) STAND**; what grows is the hands-on (30 → ~48) and the
> post-payoff demo tail (now reliably happens, ~15 min, not "if time"). _(The **parameterized-report
> exercise** once floated as a Day-2 Part-2 step landed instead on **Day 1** as an optional lab bonus,
> 2026-07-22.)_

**Part 1 — build & structure (concept+demo ~18 min ceiling):**

| ~min | CORE beat | Mode | What lands |
|------|-----------|------|------------|
| 5 | **Why a project** — `_quarto.yml` shared config + `output-dir` (+ `_metadata.yml` as a shown slide) | My | one file → whole site; where config lives |
| 6 | **Website** — pages, navbar/sidebar **navigation**, listings | My | a navigable multi-page site |
| 3 | **Cross-refs & cross-page nav** *(shock-absorber)* — `@fig-`/`@sec-`/`@tbl-` resolve **within a page**; cross-*page* = links + the navbar/sidebar. ⚠️ numbered `@fig-` across website pages is a **book** feature, *not* a website one — don't demo project-wide `@fig-` live (verify at the machine) | Our | refs resolve on-page; pages linked by nav |
| 4 | **`_brand.yml`** — one file → site + slides + **R-side plots**; **show the `theme_brand_ggplot2()`/`theme_brand_gt()` call** (the plot renders default grey without it) — *same palette, not the whole brand system* | My | one brand file, three surfaces |

**Part 2 — scale & ship (concept+demo ~15 min ceiling; publish is watch-me, the payoff is the render):**

| ~min | CORE beat | Mode | What lands |
|------|-----------|------|------------|
| 8 | **Freeze & caching** — motivation-first (don't re-run slow compute); `cache` (knitr, per-doc) vs `freeze` (project, results); the live 2-render scenario ("render → edit **prose** → re-render → code didn't re-run"); committed `_freeze/` **+ `freeze: true`** → **CI renders without R**. *Cut-first sub-item:* the **`renv.lock`** slide (pin *what* runs) — drop it before the cache-vs-freeze scenario, which is the load-bearing teach | My | reproducible builds, the two legs |
| 7 | **Publishing** — `quarto render` + `output-dir` (the hands-on setup); `quarto publish` / GitHub Actions = **watch-me** on a pre-provisioned repo (auth pre-flighted) | My | project → publishable folder; the CI *story* |

**Post-payoff tail — retired 2026-08-09.** The tail is now the wrap-up plus questions. Books lives
in the cross-references callout, dashboards in the lab as an optional self-paced section, and
dashboards + interactive documents as `Learn more` links on the closing slide. The presenter can
still open the lab's dashboard if questions run short (a `::: notes` cue on that slide).

**Notes.**
- **Part 2 opens from the shipped known-good starter** (rule 2), not the learner's possibly-unfinished
  Part-1 site — the Freeze/Publishing beats operate on *that* project so anyone who fell behind can follow.
- Part 2's only true CORE hands-on is **render + `output-dir`** (the publishing kernel is narrow —
  coverage audit); the 30-min "Your turn" is the **render payoff**, `publish` stays watch-me (beginner P0).
- **MENTION one-slide items ride inside their CORE beat**, not as separate timed beats: Parameters
  (CLI framing), website-tools (drafts / search-is-free / redirects), Using-extensions, Profiles —
  fold into the nearest beat or the resources page; they don't consume the beat budget.

---

## Running-order rules (encoded from the 2026-07-07 review)

Bake these into every part as it's authored:

1. **The 2nd part's payoff exercise is sacred.** In each day, DEMOs live *after* the payoff in
   the running order, so timing pressure trims the tour, never the hands-on (pedagogue P1-2).
2. **Every part ships a known-good starter artifact.** The between-parts gap will strand anyone
   who didn't finish Part 1; Part 2 must open from a shipped starting point, not "your Part-1
   file" (pedagogue P2, workshop-pacing progressive-with-fallback).
3. **One dataset through the whole Day-1 arc — locked: base-R `datasets::penguins`** (R ≥ 4.5,
   zero-install; see `project-context.md` § Technical stack). Lift the Typst *technique*/`_brand.yml`
   styling from the Star Wars lab but **re-skin onto penguins** — the climax changes the *output*,
   not the subject (pedagogue P1-4).
4. **Don't open the Day-1 lab on migration.** Start hands-on at **Ex4 (authoring value-adds)**,
   the strongest asset; conversion (Ex3) is a 2-min "if you have Rmd baggage" demo, not the first
   "Your turn" (pedagogue P1-3, beginner P2-1). Ex1 (first render) is optional warm-up at most.
5. **Reframe the inherited opening from reassurance to aspiration.** The source decks open with
   "Quarto = Rmd++, nothing new to learn" — wrong frame for a "level up" audience. Rewrite the
   first 2-3 slides to "here's what you can now build" (Typst, branded sites, one-command
   publish) (pedagogue P1-6).
6. **Name the team-project transfer, don't imply it.** Explicit callouts: Day-2 Publishing = "how
   your team ships its project"; Day-1 Citations+Typst = "from report to article" (pedagogue P1-5,
   beginner P2-3).
7. **Gloss jargon on first appearance.** One-line definition the first time each of *Typst,
   outset/inset, CSL, shortcode, freeze, OJS, Shinylive* hits a slide — no undefined term left
   to a room that can't Google (beginner P1-2).
8. **"Why do I care" tie-ins for the new stuff.** Parameters → "re-run the report per
   sample/cohort"; Dashboards → "share results with a collaborator who won't open R"; website → "lab
   site / your team project" (beginner P2-3). *(Keep tie-ins generic — reusability, `project-context.md`.)*
9. **Mode markers are built-in callouts at the two transitions only** (decided 2026-07-07;
   full spec in `project-context.md` § Content patterns). No
   per-slide "My turn" badge, no bespoke CSS class. `## Learning Outcomes` open / "What you can do
   now" close; labs use `## … Challenge` + collapsible hint/solution. One vocabulary: the "Your
   turn" slide points at the lab's Challenge by the same name; countdown stays presenter-side.

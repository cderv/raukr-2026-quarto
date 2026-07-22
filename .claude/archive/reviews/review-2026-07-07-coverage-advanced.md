# Coverage-gap audit — modern outputs & advanced (dashboards · interactivity · manuscripts · journal articles · extensions · tools · advanced)

> Region: the "modern outputs & advanced" space. Question asked of each topic: is it forgotten
> or mis-triaged, and does it belong to **Day 1** (single document), **Day 2** (projects),
> **either**, or **neither**? Judged against fetched quarto.org pages, not memory.
> Frame read first: `topic-store.md`, `project-context.md`, `prior-art-inventory.md`.
> Sources fetched 2026-07-07 (a few `/index.html` variants 404'd through the proxy; canonical
> section URLs cited regardless).

## Verdict

**The current triage is sound — one real gap, one relocation, the rest confirmed.** For a
paper-writing audience the single under-served topic is **Authors & Affiliations front-matter**,
and it is *cheap* to close: it rides inside the Day-1 Citations→Typst payoff at near-zero extra
budget and renders in HTML/PDF/**Typst** (not just journal formats). Everything else your panel
already decided holds up: Manuscripts stays cut (but should be a Day-2 *mention*, not silence);
Dashboards/Interactivity stay DEMO with the guards you set; extension **authoring** is firmly out;
Positron stays minimal. No topic in this region should be promoted to CORE.

**Count: 1 genuine gap, 4 reconsiderations/relocations, 0 mis-triages needing reversal.**

## TOP RECONSIDERATIONS (ranked)

1. **GAP — Authors & Affiliations front-matter → add to Day 1 (light DEMO inside Citations→Typst).**
   This audience *writes manuscripts*, and the one manuscript-shaped thing missing from Day 1 is
   the author block: `author:` with `name` / `affiliation` (name + department) / `orcid` /
   `corresponding` / `email`, plus `ref:`-shared affiliations. The schema is
   *moderately* complex only at the full-scholarly extreme; the **light** form (2 authors, 1–2
   affiliations, ORCID) is a few YAML lines and renders across HTML, PDF, and Typst — exactly the
   formats already on the Day-1 arc. It's the natural companion to `.bib`/`@ref`/CSL and it makes
   the Typst PDF payoff look like a *real paper*. Recommendation: fold ~1 slide + the front-matter
   into the existing Part-2 penguins manuscript (Gorman et al. is already the citation anchor) — no
   new segment, no new budget line. Do **not** teach full journal formats to get here.
   (`https://quarto.org/docs/authoring/front-matter.html`)

2. **RELOCATION — Manuscripts: keep STORE for hands-on, but make it a Day-2 MENTION, not silence.**
   The STORE call is correct: `manuscript` is a **full project type** (article + embedded
   notebooks + multi-format + MECA submission bundle), there is **no light version** — it's
   inherently project-shaped, so it can't live on Day 1 and is too heavy for a Day-2 DEMO. But
   because the audience submits to journals, drop **one slide on Day 2** ("there's a manuscript
   project type that bundles your article, its computations, and a submission archive") with a
   resources link. That converts a silent cut into a signposted "here's where to go next."
   (`https://quarto.org/docs/manuscripts/`)

3. **CONFIRM + SHARPEN — Journal Articles / Journal Formats / Article Templates → resources, not a segment.**
   Real tension worth naming: the audience writes papers, so it's tempting to teach journal
   formats. Resist it. Journal formats are **per-journal extension templates**
   (`quarto use template quarto-journals/plos`, `.../acm`, `.../elsevier`, `.../jss`, …) — each
   carries its own quirks, class options, and submission rules; teaching one teaches an idiosyncrasy,
   not a transferable skill, and it's a LaTeX/Typst-per-template rabbit hole that would eat the
   Typst payoff. The **transferable** slice — author metadata + citations + a branded Typst/PDF —
   is already the Day-1 climax (plus reconsideration #1). So: **Authors/Affiliations → Day 1**;
   **Journal formats/templates → Day-2 resources page** ("submit to a specific journal? `quarto use
   template quarto-journals/<journal>`", with the extension-listings link).
   (`https://quarto.org/docs/journal-articles/`)

4. **CONFIRM — using vs creating extensions is the right cut line, and "using" deserves one explicit MENTION.**
   *Using/managing* extensions (`quarto add`, `quarto use template`, `quarto update`, listings) is
   already implicit all over the workshop — logos, journal templates, revealjs plugins, brand
   extensions all arrive via `quarto add`. Make it **one explicit MENTION** (Day 2, or Day 1 at the
   first `quarto add`) so participants know the install verb and the listings gallery. *Creating*
   extensions — custom formats, Lua filters, custom shortcodes, revealjs plugins, brand extensions —
   is advanced authoring (Lua, `_extension.yml`, `quarto create extension`), firmly **out** of both
   slots. Your STORE call is right; only the *using* half needs surfacing.
   (`https://quarto.org/docs/extensions/`, `https://quarto.org/docs/extensions/formats.html`)

5. **CONFIRM — the interactivity split (htmlwidgets ▸ OJS ▸ Shiny ▸ Shinylive) is exactly right; hold the line.**
   The overview backs your triage verbatim: **htmlwidgets/OJS are client-side** (run in static
   HTML, no server) while **Shiny needs a deployed server**. So: **lead the DEMO with an htmlwidget**
   (`plotly`/`leaflet`, pure R, reliable, single doc) ✔; **OJS = "a non-R path," MENTION + link** ✔;
   **Shiny = MENTION only** (server-side is heavier than any DEMO can hold and can't run in a static
   handout) ✔; **Shinylive = MENTION, pre-built cached example, never a live webR/wasm build** ✔.
   **Jupyter Widgets = name-and-skip** (Python-only; out for an R room). No change — this audit is a
   green light. (`https://quarto.org/docs/interactive/`)

## Mapping table

| Topic | Quarto page | Best fit | In our triage? | Recommendation | 1-line why |
|-------|-------------|----------|----------------|----------------|------------|
| **Authors & Affiliations** (front-matter) | authoring/front-matter.html | **Day 1** | **ABSENT** | **ADD — light DEMO inside Citations→Typst** | Paper audience; a few YAML lines; renders HTML/PDF/**Typst**; makes the payoff a real paper |
| Journal Articles (overview) | journal-articles/ | Day 2 / resources | ABSENT | MENTION + resources link | Transferable slice already on Day 1; journal-specific bits are a rabbit hole |
| Journal Formats | journal-articles/ | resources | ABSENT | Resources link | Per-journal `quarto use template`; idiosyncratic, not transferable |
| Article Templates | journal-articles/ | resources | ABSENT | Resources link | Same — a template gallery pointer, not a taught step |
| **Quarto Manuscripts** | manuscripts/ | Day 2 | **STORE** | **Keep STORE; add 1-slide Day-2 MENTION** | Full project type, no light version; signpost don't teach |
| Using / Authoring / Publishing Manuscripts | manuscripts/ | Day 2 | STORE | Resources link | Sub-pages of the cut project type |
| **Quarto Dashboards** (overview) | dashboards/ | **Day 2** | **DEMO** | Keep DEMO (static only) | Modern output; a <30-line static dashboard is single-session learnable |
| Dashboard Layout | dashboards/layout.html | Day 2 | (inside DEMO) | Budget it — rows/cols, orientation, cards, valueboxes, tabsets | The DEMO *is* the layout model; skip it and it's an underwhelming single-plot page |
| Dashboard Data Display | dashboards/data-display.html | Day 2 | (inside DEMO) | Show valuebox + a table/plot card | The concrete payoff cells of the DEMO |
| Dashboard Theming | dashboards/theming.html | Day 2 | (inside `_brand.yml`) | MENTION — brand carries it | Same one-file brand story already on Day 2 |
| Dashboard Parameters | dashboards/parameters.html | neither | ABSENT | Skip | Overlaps the (already MENTION'd) params topic; not worth a dashboard-specific pass |
| Interactive Dashboards / with-Shiny/OJS | dashboards/interactivity/ | **neither** | ABSENT | **Firmly out** | Needs a Shiny/OJS backend + server — blows the DEMO budget and can't ship static |
| Dashboard Deployment | dashboards/deployment.html | Day 2 | (inside Publishing) | MENTION — same as publishing | Static dashboard deploys like any static site |
| **Interactivity — Overview** | interactive/ | **Day 2** | **DEMO** | Keep DEMO | Frames client- vs server-side; the map for the beat |
| htmlwidgets for R | interactive/widgets/htmlwidgets.html | **Day 2** | DEMO (lead) | **Lead the DEMO here** (`plotly`/`leaflet`) | Pure R, client-side, single static doc — the only reliable live path |
| Observable JS (+ OJS cells/examples) | interactive/ojs/ | Day 2 | (implicit) | MENTION — "a non-R path" + link | Powerful but non-R; a pointer, not a build |
| Shiny (R/Python) + Reactives + Execution Contexts | interactive/shiny/ | neither | MENTION | MENTION only | Server-side; heavier than a DEMO; can't run in a handout |
| Jupyter Widgets | interactive/widgets/jupyter.html | neither | ABSENT | Name-and-skip | Python-only; out for an R room |
| Component Layout | interactive/layout.html | Day 2 | (inside DEMO) | Light — reuse the layout beat | Same column/panel model already taught |
| **Extensions — Overview / Using / Managing** | extensions/ | either | ABSENT (implicit) | **MENTION — the `quarto add` / `quarto use template` verb + listings** | Already used implicitly (logos, templates); surface the install verb once |
| Extensions — Custom Formats | extensions/formats.html | neither | STORE | Firmly out | `quarto create extension`, `_extension.yml`, SCSS/Lua — advanced authoring |
| Extensions — Filters | extensions/filters.html | neither | STORE | Firmly out | Lua/pandoc AST — developer task |
| Extensions — Shortcodes (creating) | extensions/shortcodes.html | neither | STORE | Firmly out | *Using* built-in shortcodes is a Day-1 MENTION; *authoring* is out |
| Extensions — Revealjs Plugins | extensions/revealjs.html | neither | STORE | Firmly out | Plugin authoring; using one is niche |
| Extensions — Brand Extensions | extensions/brand.html | neither | STORE | Firmly out (authoring) | *Using* `_brand.yml` is a DEMO; *packaging* a brand extension is out |
| Extension Listings | extensions/listing-*.html | resources | ABSENT | Resources link | The gallery you point to from the "using" MENTION |
| **Tools — Positron** | tools/positron.html | **Day 1** | **DEMO (minimal)** | Keep minimal, Quarto-integration only | Preview/render/cells; avoid another guest instructor's Positron-the-IDE slot |
| Tools — VS Code | tools/vscode.html | Day 1 | (implicit) | MENTION — editor-agnostic | Same Quarto extension; keep framing editor-neutral |
| Advanced (Lua/AST/custom engines) | (various) | neither | ABSENT | Out | Developer internals; resources page at most |

## Firmly out of scope (say so on a resources page)

Name these explicitly so participants know they were *chosen* out, not forgotten:

- **Creating extensions of any kind** — custom formats (`quarto create extension`, `_extension.yml`,
  SCSS), **Lua filters**, custom **shortcodes**, **revealjs plugins**, **brand-extension packaging**,
  project-type extensions. Advanced authoring (Lua / pandoc AST); a resources link, never a slot.
  (`https://quarto.org/docs/extensions/formats.html`, `.../filters.html`)
- **Interactive dashboards** (Shiny/OJS-backed) and **dashboard deployment to a Shiny server** — a
  static `format: dashboard` is the DEMO; the server backend is out.
- **Shiny (server) as a taught/hands-on topic**, and **Shinylive live builds** — MENTION + a
  pre-built cached example is the ceiling; no live webR/wasm build. (`https://quarto.org/docs/interactive/shiny/`)
- **Jupyter Widgets** — Python-only; out for an R audience.
- **Quarto Manuscripts as hands-on** — a Day-2 one-slide MENTION only; the full `manuscript`
  project (notebooks + MECA) is out. (`https://quarto.org/docs/manuscripts/`)
- **Journal-specific formats/templates as a taught segment** — resources link
  (`quarto use template quarto-journals/<journal>`); the transferable slice (authors + citations +
  branded Typst) is on Day 1. (`https://quarto.org/docs/journal-articles/`)
- **Advanced internals** — custom engines, Lua API, pandoc AST manipulation. Out entirely.

## Minor flags (not blocking)

- **Positron visual editor:** the fetched Quarto tools page describes a "visual WYSIWYG editor"
  mode for the Quarto extension; `topic-store.md`'s technique note (P2-3) says Positron has *no*
  RStudio-style visual editor. Worth a 2-minute verify before the Positron DEMO so the on-stage
  claim is exact — scope "visual editor" to RStudio if Positron indeed lacks it.
  (`https://quarto.org/docs/tools/positron.html`)
- **Using-extensions portability:** any `quarto add` you demo (journal template, revealjs plugin)
  is a dependency the NBIS fold-in tree must reinstall — consistent with the existing
  `project-context.md` § Repository-layout "declare the dependency" rule; nothing new, just applies
  here too.

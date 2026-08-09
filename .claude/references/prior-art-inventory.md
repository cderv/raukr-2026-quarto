# Prior-art inventory — Christophe's existing Quarto materials

> A content map of Christophe's own prior Quarto talks/tutorials (repos listed in
> `project-context.md` § *Christophe's own prior materials*), built from a survey of each repo.
> Purpose: know what he typically teaches in "intro to Quarto", which exercises already exist,
> and what maps to our RaukR 2026 CORE — so we reuse instead of reinventing, and see the gaps.
> These are **his** materials (reuse & adapt freely). Explored via throwaway clones in the
> scratchpad; nothing vendored. **Direct `git clone https://github.com/<owner>/<repo>` works from
> this sandbox** — even for repos outside the session scope (incl. `NBISweden/raukr-2025`/`2026`),
> despite `add_repo` being same-owner-only. See `project-context.md § Christophe's own prior
> materials` for the URLs + access note.

## The five resources at a glance

| Repo | Context | Format | Lang | Exercises | Best for |
|------|---------|--------|------|-----------|----------|
| `raukr-2025-quarto` | RaukR 2025 lecture (same school, last year, his) | standalone revealjs deck | EN | none | **deck base** — already covers most of our CORE |
| `user2024-tutorial-quarto` | useR! 2024, 3h tutorial | website + slides + labs, 2 profiles | EN | **8** (penguins) | **richest** — Day-1 & Day-2 labs |
| `user2024-quarto-talk` | useR! 2024 talk | standalone deck | EN | none | Day-1 **opening hook** (why Quarto) |
| `tuto-quarto-rr-2023` | Rencontres R 2023, 2h | website + slides + labs, 2 profiles | FR | **6** (penguins) | older FR twin of user2024 |
| `tuto-quarto-typst-rr-2026` | Rencontres R 2026, 2h | website + labs + justfile + R pkg | FR | **2** (Star Wars) | Day-1 **Typst payoff** + Day-2 **book/brand.yml**; our scaffold's basis |

## What Christophe consistently teaches in "intro to Quarto"

A stable through-line across all of them:

- **Framing:** "Quarto *unifies + extends* R Markdown" — built on 10y of knitr/rmarkdown, no new
  tech to learn, rmarkdown not deprecated. Multi-language (knitr + Jupyter engines).
- **Rmd → Quarto migration:** `output:` → `format:`, the `#|` hash-pipe cell options, dash-vs-dot
  option names, `knitr::convert_chunk_header()`, `.Rmd` renders unchanged.
- **Authoring value-adds over Rmd:** callouts, cross-references (`@fig-`/`@tbl-`), article/margin
  layout, code-annotation, `gt` tables.
- **Multi-format from one source:** HTML → PDF (LaTeX) → **Typst** → docx → revealjs.
- **Projects:** `_quarto.yml`, websites/blogs/books, `_metadata.yml`, **freeze**, **publishing**.
- **Always:** a single running dataset (**palmerpenguins**), the `clean-revealjs` theme +
  `reveal-style.scss`, and (for tutorials) a **site + labs + two-profile (pretuto/tuto)** layout.
- **Pedagogy (typst-2026, most refined):** My turn (slides) → Our turn (live demo) → Your turn
  (exercise), with a "boussole/compass" objective page + `countdown` timer on a second screen.

## The exercise catalogue (the reusable gold)

**Family A — the `penguins` progression** (`user2024-tutorial` EN, 8 steps; `rr-2023` FR, 6 steps).
Same dataset builds through the whole arc:
1. First document — render `simple-document.qmd`, source vs visual editor. _(trivial; maybe skip for advanced)_
2. Create a project + drop in an `.Rmd` unchanged (`quarto-101.zip`, `penguins.Rmd`).
3. Convert `.Rmd` → `.qmd` — hash-pipe, `convert_chunk_header()`.
4. **Add authoring features** — callouts, cross-refs, margin/page layout, code-annotation,
   footnote, fancy `gt` table (`new-penguins-full-example-corrected.qmd`). *Strongest single asset.*
5. Multi-format — HTML → PDF → **Typst** (`new-penguins-pdf-demo-typst.qmd`).
6. **Project → website** — `type: website`, navbar, About page, theme (`quarto-101-website.zip`).
7. Freeze & cache — `freeze: true/auto`, `cache: true`.
8. Publish — `quarto publish`.

**Family B — the Star Wars / Typst progression** (`typst-2026`, 2 big exercises).
1. **Document → styled Typst PDF via `_brand.yml`** — `format: typst` one-liner, then brand
   colors → Google+local fonts → heading fonts/colors → logo, `keep-typ`. Starter+correction,
   plus a "meta" charte PDF to reverse-engineer into YAML.
2. **5 `.qmd` → single Typst book** — `_quarto.yml`, `type: book`, chapters/appendices, cross-refs,
   project-level `_brand.yml`, **palette-swapping** via the `brand:` key, and **R-side branding**
   of `gt`/`ggplot` from the same `_brand.yml`.

## Coverage map vs our RaukR 2026 CORE/DEMO (`topic-store.md`)

**Day 1 — Intro (single document)**

| Our item | Covered by | Reusable asset |
|----------|-----------|----------------|
| What Quarto is / Rmd→Quarto | talk + all tutorials | why-Quarto slides, Horst schematic, parity tables |
| Markdown & content (figs/tables/xref) | penguins Ex4 | `new-penguins-full-example-corrected.qmd` |
| Layouts (articles) | penguins Ex4 | `column: margin`/`page` examples |
| Document types | all decks | raukr-2025 formats section |
| **Citations** | ⚠️ weak | only footnotes + book `bibliography`; **no dedicated exercise** |
| **Typst** | typst-2026 Ex1 + penguins Ex5 | Star Wars PDF lab; penguins typst demo |
| Execution options (DEMO) | all tutorials | hash-pipe material |
| **Parameters** (DEMO) | ⚠️ **gap** | none of his materials teach parameterized reports |
| Shortcodes (DEMO) | talk (light) | `placeholder`/`lipsum` demos |
| Positron (DEMO, minimal) | ⚠️ gap | only a `positron-python.png` in raukr-2025 |

**Day 2 — Projects**

| Our item | Covered by | Reusable asset |
|----------|-----------|----------------|
| Why a project (`_quarto.yml`) | penguins Ex2 | `quarto-101.zip` |
| Websites + navigation | penguins Ex6 | `quarto-101-website.zip` |
| Cross-referencing (project) | typst-2026 Ex2, rr2023 mod3 | book cross-refs |
| Freeze / caching | penguins Ex7 | freeze/cache tasks |
| Publishing (gh-pages + CI) | penguins Ex8 + every repo's gh-pages | `quarto publish`; justfile publish recipes |
| **`_brand.yml`** (DEMO) | typst-2026 (deep) + raukr-2025 | brand lab, palette-swap, R-side branding |
| Books (DEMO) | typst-2026 Ex2 | multi-chapter book lab |
| **Interactivity** (DEMO) | ⚠️ weak | mentioned in tables only, never demoed |
| **Dashboards** (DEMO) | ⚠️ **gap** | only named in format tables, never taught |

## Build backlog — the only 4 true build-fresh items (build-gap audit 2026-07-07)

> Refined from the full build-gap cartography (2026-07-07):
> Day 1 is ~80% reuse, Day 2 ~60%. Only **four** items lack a usable prior asset; everything else
> is REUSE or MODERNIZE. The dominant real cost is the **re-skin tax below**, not new authoring.

- **Citations** (Day-1 CORE) — only `bibliography:` keys exist across the repos; **no `.bib`, no
  `@ref` exercise, no CSL, nothing in Typst.** Build a real segment: `references.bib` (5-6),
  2-3 `@key` cites in the penguins doc, a mainstream CSL, **rendered once in Typst** to prove the
  CSL↔Typst-native bib path.
- **Dashboards** (Day-2 DEMO) — only named in format tables, never taught. Build one
  `format: dashboard` penguins page (2 rows, 2 valueboxes, 1 `.card` plot, 1 tabset). Watch-me.
- **Positron × Quarto** (Day-1 DEMO) — only a PNG; every deck is RStudio-framed. Build 3-4 slides
  (open `.qmd`, `quarto preview`, render; "no RStudio visual editor"). Minimal by design.
- **Interactivity** (Day-2 DEMO) — slide-only, never runnable. One htmlwidget cell (`plotly` on
  penguins) + OJS/Shinylive as links.
- _(**Parameters** — now Day-2 MENTION — is **not** build-from-zero: lift NBIS
  `labs/quarto/index.qmd:471-599`, reskin iris→penguins 1:1 (both 3 species w/ photos).)_

### The re-skin tax (the dominant cost — universal, not per-item)

**10 `.qmd` load `palmerpenguins`; 0 use base-R `datasets::penguins`.** Base-R penguins (R≥4.5)
**renames columns** — `bill_length_mm→bill_len`, `bill_depth_mm→bill_dep`,
`flipper_length_mm→flipper_len`, `body_mass_g→body_mass`. One sweep across all lifted files:
drop `library(palmerpenguins)`, rename every `aes()`/`select()`/`gt` reference, and fold in
`%>%`→`|>` (4 files) in the same pass. The document *shape* transfers 1:1; only the column names
move. **Genuine rework (not re-skin):** the Typst **Star Wars** lab — keep the Typst+`_brand.yml`
*technique*, rewrite the *subject* to penguins + RaukR brand.

### Plan corrections from the build-gap audit

- **Day 2 has a deck base** (see `topic-store.md` Block 2 header): `user2024-tutorial-quarto`
  `3-projects.qmd:22-947` is a complete EN Day-2 deck — promote it, don't build new.
- **R-side `_brand.yml` branding already works & is tested** (`tuto-quarto-typst-rr-2026` book
  correction: `theme_brand_gt`/`theme_brand_ggplot2`/`brand_color_pluck` + palette-swap) — the
  inventory's "young, verify" hedge is resolved; lift and re-skin.
- **Keystone reuse assets:** `new-penguins-full-example-corrected.qmd` (Day-1 authoring payoff) ·
  the Day-2 projects deck · the freeze-vs-cache slides (`3-projects.qmd:797-896`) · the R-side
  brand styling · the `justfile` + two-profile + companion-R-package infra.

## NBIS raukr-2026 content — currency verdict (audit 2026-07-06)

Verified against Quarto 1.9/1.10 (the site builds with **1.9.38**; the `1.4.549` on a slide is
just illustrative `quarto --version` output, not a pin):

- **Toolchain-current but content-dated.** No broken/removed syntax — `#|` cell options,
  `execute:`/`freeze:`, `_brand.yml`, Typst, `_quarto.yml`, parameterized reports, cross-refs,
  publishing are all correct and current.
- **But the spine is R-Markdown-era:** RStudio-first, a "what is a chunk" RMarkdown detour,
  `%>%` in examples, stale hardcoded dates, no Positron. It over-teaches basics and is silent on
  our CORE (Citations, Typst-as-payoff, brand-for-slides, Positron, dashboards).
- **Actually fine (don't fix):** the parameterized-report walkthrough (`labs/quarto`) and the
  end-to-end website lab (`labs/quarto-site` — already covers `_brand.yml`, freeze, listings,
  gh-pages) are well-built and current.
- **Bottom line:** use *Christophe's* material as the base; **harvest** the two good NBIS labs
  and reframe them onto our structure — do not adopt the NBIS deck's spine.

## Reuse recommendation (informs the per-module fork-vs-rewrite call)

- **Deck:** base the 2026 deck on `raukr-2025-quarto` (already EN, covers most CORE) — reskin to
  a RaukR `_brand.yml`, trim, modernize (Quarto 1.9, `|>`, VS Code/Positron, drop RStudio-centrism).
- **Day-1 lab:** fork the `user2024-tutorial` penguins progression, modernize, add a **citations**
  step and the **Typst** finale (lift from `typst-2026` Ex1). Two ordering guards from the
  2026-07-07 panel (see `topic-store.md` § *Running-order rules*): **the first "Your turn" starts
  at Ex4 (authoring value-adds)**, not Ex3 conversion — migration is a 2-min demo, not the opening
  exercise; and **keep one dataset through the Typst climax** — re-skin the Star Wars Typst lab
  onto penguins so the payoff changes the output, not the subject. **Dataset locked (2026-07-07):
  base-R `datasets::penguins`** (R ≥ 4.5, zero-install; base names `bill_len`/`flipper_len`/
  `body_mass`) — held through the whole arc; see `project-context.md` § Technical stack.
- **Day-2 lab:** combine penguins Ex6/7/8 (website / freeze / publish) with `typst-2026` Ex2
  (book + project `_brand.yml`). Panel guard: the **publish** step is a **watch-me DEMO on a
  pre-provisioned repo**, not a live per-participant `quarto publish` (the auth cliff — beginner
  P0). Add fresh dashboards + a light interactivity teaser (**lead with an htmlwidget**;
  Shinylive is MENTION-only, never a live build).
- **Infra:** lift the site + labs + two-profile + `justfile` + companion-R-package pattern from
  `typst-2026` (already this scaffold's basis) and the My/Our/Your-turn + boussole/countdown
  delivery pattern.
- **Harvest from NBIS (don't inherit its spine):** the two good NBIS labs — the
  parameterized-report walkthrough (`labs/quarto`) and the end-to-end website lab
  (`labs/quarto-site`) — reframed onto our structure, with `%>%`→`|>`, dropped RStudio/Rmd-first
  framing, refreshed dates, and the missing CORE (citations, Positron, dashboards) added.

## NBIS harvest map — exact reuse targets (2026-07-07 reuse panel)

> Line-level cartography from the reuse assessment of `NBISweden/raukr-2026`@main (2026-07-07).
> Assessment: the prior material works as a reference tour rather than a hands-on workshop, so the
> lab scaffolds are the reusable part and the deck spine is a rebuild. Line numbers are into the NBIS repo files, not ours. `✅` = lift with
> light edits · `🟠` = reuse after reframing · `🔴` = do not inherit.

**✅ Lift (all three reviewers agree — the reusable gold)**

| Asset | NBIS `file:line` | Note on reuse |
|-------|------------------|---------------|
| Parameterized-report exercise | `labs/quarto/index.qmd:471-599` | Strongest single hands-on: live preview, `params$`, dynamic titles/`!expr` captions, `#\| output: asis` heading trick, per-species photos, CLI `-P name:val`. Re-skin iris→penguins (1:1: penguins also has 3 species w/ photos). Topic moves to Day-2/CLI per triage. |
| Troubleshooting callout | `labs/quarto/index.qmd:603-611` | YAML indent · missing pkg · image paths · `tbl-`/`fig-` labels · PDF→HTML fallback. Reuse near-verbatim per lab — self-rescue for a roaming-TA room. |
| Engine mermaid "How it all works" | `slides/quarto/index.qmd:535-562` | The one slide the beginner said made Quarto-as-a-*system* click. Keep, modernize labels (drop `.rnw`/Confluence/`.rmd`-co-equal branches). |
| Progressive-YAML build-up | `labs/quarto/index.qmd:43-146` | 3 headers simple→complex, line-by-line plain-language. Good scaffolding. |
| Website-lab spine | `labs/quarto-site/index.qmd:84-390` | `_quarto.yml`→navbar→about→blog→listing→home. Richest website base; genuinely progressive. Invert only the git-first opener (🔴). |
| Dual publish paths | `labs/quarto-site/index.qmd:456-513` | `publish gh-pages` **and** manual `output-dir: docs` + Pages route — the manual path is our auth-light hands-on; `publish` demoted to watch-me. |
| Example-sites gallery + "Learning more" | `labs/quarto-site/index.qmd:515-593` | By tier (incl. Bioconductor blog `:544`, qmd4sci, Çetinkaya-Rundel). Drop onto Day-2 resources ~as-is. |
| patchwork blog post | `labs/quarto-site/index.qmd:221-295` | Realistic "arrange plots" post w/ captions/labels — good concrete example. |
| Tasks callout + `<details>` Session | `labs/quarto/index.qmd:592-599`, `:748-759` | House idioms (already in `project-context` § Content patterns) — consistency confirmed. |
| `_brand.yml` seed | `labs/quarto-site/index.qmd:412-433` | Well-formed colors+fonts+`source: google`. Seed only — no logo, no R-side `theme_brand_*`; our DEMO extends it and leads with it (Bootswatch `:397-408` demoted). |

**🔴 Do NOT inherit (structural / misleading if lifted)**

| Anti-pattern | NBIS `file:line` | Why |
|--------------|------------------|-----|
| Git/SSH-first opener of the website lab | `labs/quarto-site/index.qmd:22-42` | Step 1 = `git clone git@github.com…`, no SSH-key setup → silent fail for ~40 laptops. **Our Day-2 P0.** Invert: build local, publish = watch-me DEMO at the end. |
| "Compared to Rmd" + output-formats table | `slides/quarto/index.qmd:835-879` | Out of date for 2026: Quarto column blank for `flexdashboard` (→ `format: dashboard` exists!), `rticles`, `pagedown`. + malformed `style=` (`:857`). Teaches "Quarto has no dashboard story." Replace w/ 2-min migration note. |
| RMarkdown + chunk-options detour | `slides/quarto/index.qmd:477-523`; `labs/quarto/index.qmd:252-363` | The "what is a chunk" tour we STORE. Also an `output: true...asis` conflation. |
| YAML-as-a-language + from-zero Markdown | `slides/quarto/index.qmd:236-318`, `:398-475` | Config/markdown primer for people who write `_targets.R`. Cut; gloss in one line. |
| Render-button-first framing | `slides/quarto/index.qmd:525-533`; `labs/quarto/index.qmd:437` | GUI-button-first; our audience drives from the CLI. |
| General lab's reference-wall shape | `labs/quarto/index.qmd` (whole) | ~590 prose lines before first task; only 2 Tasks, no success criteria, no `code-fold` solutions. Take the Report/Troubleshooting islands, discard the walkthrough coque. |

**🟠 Modernize before reuse**

| Item | NBIS `file:line` | Fix |
|------|------------------|-----|
| `%>%` in interactivity slides | `slides/quarto/index.qmd:660-678` | →`\|>` (only `%>%` in the 3 files; labs already clean). |
| LaTeX-before-Typst emphasis | `slides/quarto/index.qmd:132-163`; `labs/quarto/index.qmd:455-469` | Invert to Typst-first ("ships *inside* Quarto, no install"); LaTeX→resources. Lab links `typst.app` (web app) — wrong pointer. |
| RStudio-only framing, Positron absent | `labs/quarto/index.qmd:37,437,744`; `slides:22-26,98` | Editor-agnostic (menu + `quarto preview`/`render` CLI); add Positron; scope visual editor to RStudio. |
| Bootswatch-before-brand ordering | `labs/quarto-site/index.qmd:397-433` | Lead with `_brand.yml` + the "one file → site+slides+plots" story; Bootswatch → footnote. |
| Freeze section thin | `labs/quarto-site/index.qmd:443-454` | Add crisp `cache` vs `freeze` contrast + "CI renders without R" payoff; the 2-render scenario. |
| Inconsistent persona + stale dates + broken example | site `:90-137` (Jane Doe / mlogan mix), `:102`; deck dates `:185,331`; lab `dfr4`/`Gidole` `:293-303` | Clean persona, `date: last-modified`, drop the undefined-var/missing-font snippet. |
| Project-scoped deps if slides lifted standalone | `slides:821,830`; `{{< fa >}}` in labs | `{{< meta >}}`/absolute asset paths/fontawesome ext must be re-provided or stripped. |

**Coverage gaps — reuse will NOT cover; build fresh** (grep-confirmed absent in all 3 files):
Citations (no `.bib`/`@ref`/CSL anywhere — only named in feature lists) · Typst-as-payoff (only
2 inverted afterthoughts, no `sample-typst.qmd`) · `_brand.yml` for *slides* / R-side
`theme_brand_*` · Positron · Dashboards · article layouts (outset/inset/margin) · cross-refs
across a project.

## NBIS vs ours — coverage comparison (2026-07-21)

> A fresh clone-and-diff of `NBISweden/raukr-2026`@`main` (throwaway clone) against **our current
> built material**, requested by Christophe. This is a *coverage* snapshot (topic-by-topic, from
> freshly-grepped headings + spot-checked bodies), complementary to the harvest map above (which is
> a *reuse* map). Their side is unchanged since the 2026-07-06 currency audit — see § *upstream
> activity* below. Dataset check confirmed: **theirs = `iris` + `%>%`, RStudio-first; ours =
> base-R `penguins` + `|>`, native-`.qmd`-first.**

**Shape.** Theirs is **one arc** — a single 879-line deck + two labs (`quarto`, `quarto-site`),
"Quarto" as one lecture slot. Ours is **four ~1h parts over two days** — two decks + two labs, each
part with its own payoff and a `starter/`+`solution/` scaffold, plus `## Learning Outcomes` open /
"What you can do now" close and a Your-turn handoff into each lab. Even shared topics are paced as
a workshop on our side, a reference tour on theirs.

**They cover / we don't (or demoted).** Parameterized reports (deck `#564` + lab `:471-599`) — **the
only one we dropped to zero**, see below · "what is a chunk"/RMarkdown detour (cut by design) ·
Installation slide (cut) · "Compared to Rmd" + output-formats table (not inherited — stale) · blog +
posts + listing (site lab `#161-380`, demoted to resources) · Bootswatch (site lab `#396`, demoted
below `_brand.yml`) · git-clone/SSH-first opener (site lab `#22`, deliberately inverted — the
~40-laptop auth cliff) · ObservableJS as a taught path (deck `#684`, demoted to a one-line mention) ·
terminal/Extending Quarto slides (folded into mentions).

**We cover / they don't at all** (grep-confirmed absent in all 3 NBIS files): Citations
(`.bib`/`@ref`/CSL, full beat + exercise — they only *name* "Citations") · Typst-as-payoff + branded
Typst PDF (they have one link + one lab paragraph, "alternative to LaTeX") · Math/`@eq-` · Layouts
(margin/outset/inset/columns/panels — the organizer-requested list) · title block/Authors & Affiliations ·
inline code `` `{r}` `` · Positron × Quarto · `_brand.yml` for *slides* + R-side `theme_brand_*` ·
`_metadata.yml` · cross-refs across a project (within-vs-across + book caveat) · renv / two legs of
reproducibility · Dashboards (`format: dashboard`, with a runnable `dashboard.qmd`).

**Shared, modernized on our side.** Anatomy · YAML · markdown · figures/tables · rendering (we kept
their engine-diagram idea) · projects · freeze (theirs thin at `site lab #443`; ours: cache-vs-freeze
+ "CI renders without R") · publishing (ours watch-me, not a live per-laptop `quarto publish`).

**The one real gap — Parameters. → CLOSED 2026-07-22.** Was the single topic NBIS
teaches as a full hands-on that we'd neither taught nor mentioned. **Built as a Day-1 lab optional
bonus** (`labs/quarto/index.qmd` § "Bonus — one report per species" + tested reference
`penguins-by-species.qmd`). Placement resolved: Day-1 (single-doc feature + Christophe's lean), and
the old "params needs the CLI → Day 2" rationale was **moot** — Day-1 already runs `quarto render …
--to typst` from the terminal, so `-P species:…` is the same muscle. Kept optional/MENTION-level
(no spare core time; the panel's P1 protected the Typst payoff). Note: the "iris→penguins re-skin
1:1" of NBIS `labs/quarto:467-539` was generous — that walkthrough is thin (embeds an external
report, never shows the filter chunk or the `-P` override), so it was a rebuild from fragments.


### raukr-2025 back-check (2026-07-21)

Cloned NBIS **raukr-2025** and diffed its Quarto material against 2026 to confirm nothing was taught
last year that quietly disappeared. **Verdict: NBIS-2026 ≈ 2025, a near-verbatim copy** — the deck is
topic-identical (only `.jpg/.png`→`.webp` swaps + a year in a footer URL); `labs/quarto-site` is a
cosmetic refresh (the example persona is named inconsistently across the 2026 files, which the
harvest map already flags); the only real content move is
`labs/quarto/index.qmd` (+73 lines) which **added** a fleshed-out parameterized-report exercise + a
new Troubleshooting callout and **dropped nothing**. So the comparison above already covers the full
2025 topic set, and **the one gap on our side stays Parameters** — no new
missing topic surfaced. Side result: Christophe's *own* 2025 deck (`cderv/raukr-2025-quarto`) is
already much closer to our target spine (penguins / `|>` / Typst / `_brand.yml` / layout / Positron)
than NBIS-2025's — but **both** 2025 decks lack a real Citations exercise, a runnable Dashboards demo,
and (for cderv) Parameters, confirming those stay build-fresh regardless of vintage.

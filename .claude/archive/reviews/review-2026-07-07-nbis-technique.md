# NBIS RaukR-2026 Quarto content — reuse assessment (technique)

**Reviewer:** workshop-reviewer-technique (repurposed: NBIS reuse triage)
**Date:** 2026-07-07
**Target toolchain:** Quarto 1.9.38 (installed, confirmed via `quarto --version`)
**Material reviewed** (throwaway clone of `NBISweden/raukr-2026`, branch main, in scratchpad):

- `slides/quarto/index.qmd` (879 lines — the deck)
- `labs/quarto/index.qmd` (759 — general lab)
- `labs/quarto-site/index.qmd` (593 — website lab)
- `slides/quarto/sample/sample-{html,pdf,revealjs}.qmd`

**Severity bands repurposed as reuse verdicts:**
🔴 = do not inherit / actively misleading if lifted · 🟠 = reusable only after modernizing ·
🟡 = minor / nice-to-have · ✅ = lift as-is.

> Note: R is not installed in this review sandbox (async setup hadn't finished), so I did not
> re-run a full `quarto render`. The prior audit (`prior-art-inventory.md:99-114`) already
> confirmed the site builds under 1.9.38; currency here is a **syntax** judgement and every
> line was read directly. Findings extend, not repeat, that audit.

---

## Overall verdict

The prior audit's headline holds and is now line-verified: **toolchain-current, content-dated**
— no removed/deprecated Quarto syntax, but an R-Markdown-era spine (RStudio-first, a chunk-options
detour, `%>%`, LaTeX-before-Typst, Confluence, hardcoded 2023 dates) and **silence on almost all
of our CORE** (Citations, Typst-as-payoff, `_brand.yml` in the deck, Positron, Dashboards). The
**deck is not liftable as a spine** — it's the wrong frame for a "level-up" audience and carries
several small defects (malformed inline style, unit-less column widths, a bare `.callout`, a
stale format-comparison table that's now factually wrong on `dashboard`). The **two labs remain
the real prize**: the parameterized-report walkthrough (`labs/quarto`) and the end-to-end website
lab (`labs/quarto-site`) are well-built and current, and the website lab already carries
`_brand.yml`, freeze, listings and gh-pages. Harvest the labs, re-skin, add our CORE; do not
inherit the deck.

**Counts:** 🔴 3 · 🟠 6 · 🟡 7 · ✅ 5

---

## 🔴 Do not inherit / actively misleading if lifted

**🔴-1 · Deck "Output formats" Rmd→Quarto table is stale to the point of being wrong**
`slides/quarto/index.qmd:855-879`. The table maps Rmd packages to Quarto and leaves the Quarto
column **blank** for `flexdashboard` (877), `xaringan` (867), `pagedown` (875), `rticles` (876).
In 2026 that is factually wrong for the row that matters most to us: `flexdashboard` → **`format:
dashboard`** exists and is one of our DEMOs; `rticles`/`distill` → Quarto article layouts + journal
templates. Lifting this table teaches "Quarto has no dashboard/article story." Also the container
`::: {style='text-align="left"'}` (857) is **malformed CSS** — the style value is the literal
string `text-align="left"`, an invalid declaration that sets nothing. Do not inherit; our story
replaces this whole "compared to Rmd" dump with a 2-min migration note.

**🔴-2 · The RMarkdown chunk-options detour**
`slides/quarto/index.qmd:477-523` ("RMarkdown" + "RMarkdown • Chunk options") and the parallel
lab prose `labs/quarto/index.qmd:328-363`. This is exactly the "what is a chunk / here are all
the chunk options" tour our triage marks **STORE / skip — the audience already knows chunks**
(`topic-store.md:49`, `:98`). It also frames Quarto as "RMarkdown + hyphens" rather than a system.
Beyond scope, it has small correctness slips (`output: true ... asis` at 514 conflates a boolean
with the `asis` passthrough; ""/"supresses" typos 515/519). Inheriting this contradicts our
running-order rule #5 (aspiration, not reassurance). Skip.

**🔴-3 · Website lab opens on the GitHub/SSH auth cliff**
`labs/quarto-site/index.qmd:22-42`. The lab's **first step** is "create a GitHub repo … copy the
SSH URL … `git clone git@github.com:username/site.git`" (39). That is the exact room-killer our
panel flagged as Day-2's only **P0** (`topic-store.md:124`): SSH keys + GitHub auth on 40 laptops
on conference wifi, before a single `.qmd` is written. The *website-building* content downstream is
excellent (see ✅), but the **git-first framing must be inverted** — build locally, `quarto render`
+ `output-dir` as the hands-on, publish as a watch-me DEMO on a pre-provisioned repo. Do not
inherit the opening; harvest the middle.

---

## 🟠 Reusable only after modernizing

**🟠-1 · `%>%` throughout the deck's interactivity slides**
`slides/quarto/index.qmd:660-663, 673-678` (`iris %>% plot_ly(...) %>% add_markers()`, both the
shown source and the live chunk). Against the 2026 house line (`|>`). Content (htmlwidget-first
interactivity) matches our DEMO plan; swap the pipe and it's fine. Note this is the only `%>%` in
the three target files — the labs are already pipe-clean.

**🟠-2 · LaTeX-before-Typst framing, everywhere PDF appears**
Deck `slides/quarto/index.qmd:132-163` leads the PDF slide with xelatex/tinytex/`pdf-engine:
pdflatex` and relegates Typst to a 2-line afterthought (149-153). Lab `labs/quarto/index.qmd:455-469`
does the same: TeX/MacTeX/MikTeX/tinytex first, Typst as "an alternative" in the last sentence
(469), which also links to **`typst.app`** — the web app — rather than making the key point that
Typst ships *inside* Quarto (no install). Our Day-1 payoff is **Typst-first, LaTeX→resources**
(`topic-store.md:75, 99-100`). Content is correct; the emphasis is inverted. Re-order before reuse.

**🟠-3 · RStudio-only framing for authoring / project creation**
`labs/quarto/index.qmd:37` ("In RStudio, File > New File > Quarto Document … Source or Visual"),
`:437` ("previewed … inside RStudio by clicking Render"), `:744` ("To create a project in RStudio,
File > New Project"); deck `:98` ("If using RStudio, you need v2022.07.1 or newer"), `:114`.
Editor-locked to RStudio; **Positron appears nowhere** in the Quarto material (grep confirms the
only "Positron" in the repo is a Jenny-Bryan row in `home_contents.qmd`). Our line names Positron
alongside VS Code/CLI, and the **visual editor must be scoped to RStudio** (Positron has none —
`topic-store.md:82`). Re-frame editor-agnostic (menu path + `quarto preview`/`render` CLI) before
reuse.

**🟠-4 · Deck IDE list omits Positron**
`slides/quarto/index.qmd:22-26` lists RStudio / JupyterLab / VS Code / Neovim. In 2026 Positron
belongs here. One-line fix, but flagged because it's the same blind spot as 🟠-3.

**🟠-5 · Deck lifted standalone breaks on project-scoped shortcodes/paths**
`slides/quarto/index.qmd:830` uses `{{< meta current_year >}}` (undefined outside the RaukR
`_quarto.yml`) and `:821` a `background-image="/assets/images/network.svg"` absolute path into the
NBIS site tree. The `{{< fa … >}}` shortcodes (lab `:594`, site `:153, 213, 303, 340`) need the
`quarto-ext/fontawesome` extension installed. None of this is *wrong* in-project, but any slide/
section we lift must have these dependencies re-provided or stripped. Audit for these before a copy.

**🟠-6 · Website lab persona + freeze prose need cleanup**
`labs/quarto-site/index.qmd` mixes two personas — "Jane Doe" (91, 97, 345) vs "Michelle
Logan"/`mlogan` (131-137, 346) — and hardcodes `(c) 2026 Jane Doe` (102). The Freeze section
(443-454) is thin: "code chunks will not be executed when re-rendering" is imprecise (freeze
re-executes when the source changes) and it never distinguishes knitr `cache` from Quarto `freeze`
— the exact contrast our CORE wants (`topic-store.md:123`). Content reusable; tighten persona and
add the cache-vs-freeze motivation before lifting.

---

## 🟡 Minor / nice-to-have

- **🟡-1 · Unit-less reveal column widths.** `slides/quarto/index.qmd:13` `width="70"` and `:40`
  `width="30"` — no `%`, so the emitted `style="width:70;"` is invalid CSS and won't size the
  column (contrast the correct `width="50%"` at `:56`). Cosmetic layout bug if lifted.
- **🟡-2 · Bare `.callout`.** `labs/quarto/index.qmd:592` `::: {.callout}` has no type; Quarto
  callouts require `-note/-tip/-warning/-important/-caution`, so this "Tasks" box renders as an
  unstyled div. One-word fix.
- **🟡-3 · Stale hardcoded dates.** `date: "4-Mar-2023"` in deck (185, 331) and **all three sample
  docs**; `date: "25-Apr-2022"` in lab (53). The lab's later examples already use the modern
  `date: last-modified` / `date-format:` (69-70, 102-103) — good pattern, apply everywhere.
- **🟡-4 · Illustrative stale version.** `slides/quarto/index.qmd:788` prints `1.4.549` as example
  `quarto --version` output. Harmless (already noted in the prior audit), but re-shoot to 1.9.x if
  the slide is reused.
- **🟡-5 · Confluence in the publish story.** Deck `:561` (mermaid node) and `:747` (Publish list)
  feature Confluence — our triage STOREs it (`topic-store.md:101`). Drop when reusing the publish
  slide.
- **🟡-6 · `sample-pdf.qmd` pins `pdf-engine: pdflatex`** (`sample/sample-pdf.qmd:9`) — LaTeX-
  dependent, and there is **no `sample-typst.qmd`** in the sample set despite Typst being our
  payoff. If we reuse the "one source → many formats" sample family, add a Typst sibling and drop
  the LaTeX engine pin.
- **🟡-7 · `sample-revealjs.qmd` carries `number-sections: true`** (`sample/sample-revealjs.qmd:8`)
  — a no-op / near-no-op on reveal. Harmless copy-paste from the html/pdf siblings; trim for clean
  demos.

---

## ✅ Lift as-is (technically clean and current)

- **✅-1 · The parameterized-report walkthrough.** `labs/quarto/index.qmd:471-599`. `params:` with
  defaults, dynamic titles via YAML inline code (`'`{{r}} paste0(...)`'`, 490 — current Quarto
  feature), `!expr` captions (529, 543, 559), `#| output: asis` heading trick (517-521), and the
  full CLI surface: `quarto render report.qmd -P name:versicolor` (576), `--execute-params
  params.yaml` (582), `quarto::quarto_render(..., execute_params=)` (589). All correct and current.
  Pairs perfectly with our decision to move Parameters to Day-2/CLI framing (`topic-store.md:140`).
- **✅-2 · The Troubleshooting callout.** `labs/quarto/index.qmd:603-611` — YAML indentation,
  `install.packages()`, relative image paths, `tbl-`/`fig-` label rules, PDF-fallback. Genuinely
  good defensive teaching; reuse near-verbatim.
- **✅-3 · Website structure: navbar / about / blog / listings / home hero.**
  `labs/quarto-site/index.qmd:84-390`. `_quarto.yml` website config (88-104), about `template:`
  (122-149), dated blog-post folders (161-305), `listing:` grid with `contents/type/fields/sort`
  (309-384). Syntax current, richest website base we have (matches `prior-art-inventory.md:81`).
  Reuse the body — invert only the git-first opening (🔴-3).
- **✅-4 · The `_brand.yml` section.** `labs/quarto-site/index.qmd:412-433`. Well-formed
  `color:`/`typography:`/`fonts:` with `source: google`. Correct and current — the seed for our
  Day-2 brand DEMO. (Shallow: colors + fonts only, no `logo:`, no R-side `theme_brand_*()`; our
  DEMO extends it.) Note it sits *after* a Bootswatch section (398-408) our triage de-emphasizes —
  reuse brand.yml, demote Bootswatch to a mention.
- **✅-5 · The dual publish paths.** `labs/quarto-site/index.qmd:456-513`. Both `quarto publish
  gh-pages` (501) and the manual `output-dir: docs` + Pages-settings route (505-513) are correct
  and current — and the manual path is exactly the auth-light hands-on our panel wants, with
  `publish` demoted to watch-me. Reuse the mechanics; re-order per Day-2 running rules.

---

## The `iris` choice — technical read vs our penguins plan

The NBIS material runs `iris` end-to-end (deck, both labs, all sample docs). Purely on
**demo-reliability**, `iris` has real advantages we should not dismiss:

- **Zero install.** `iris` is base-R `datasets` — nothing to add to the setup page, nothing to
  break. Our penguins plan needs `palmerpenguins` on the setup page, and in this sandbox `pak` is
  KO so it's `install.packages("palmerpenguins")` (setup-page risk, `topic-store.md` / brand DEMO
  caveat). Every package we add is a row-of-40 failure surface.
- **No NAs, small, deterministic** — renders identically everywhere, no font/locale surprises.

Against that, our reasons to still prefer penguins/a life-science set stand:

- **Audience fit** — penguins/omics reads as "for us" to life-science researchers; `iris` reads as
  a generic teaching relic.
- **Teachable NAs** — penguins has missing data, useful for realistic wrangling (iris is too clean).
- **Historical baggage** — `iris` carries the Fisher/eugenics association the R-teaching community
  moved away from; RaukR is exactly the audience that notices.

**Recommendation:** keep our penguins (or a small life-science) choice for audience fit, but
**inherit `iris`'s discipline**: pick **one** dataset and hold it through the whole arc
(`topic-store.md:208-210`), and pin its package on the setup page so we don't lose iris's biggest
asset — bulletproof availability. The `iris`-based *technique* in ✅-1/✅-3 re-skins onto penguins
without change; the dataset is incidental to the syntax being taught.

---

## Coverage gaps — what our CORE needs that this material simply does not contain

Reuse will **not** cover these; build fresh (confirms `prior-art-inventory.md:90-97`):

- **Citations — absent as a taught topic.** Grep confirms **no `.bib`, no `@ref`, no
  bibliography/CSL** anywhere in the three target files. The deck only *names* citations in feature
  lists (`slides/quarto/index.qmd:46, 850`). This is Day-1 **CORE** for a manuscript-writing
  audience — build the real segment (pre-filled `.bib`, mainstream CSL, smoke-tested **in Typst**).
- **Typst as the payoff — absent.** Only the two inverted afterthoughts (🟠-2); no Typst YAML depth,
  no branded-PDF finale, no `keep-typ`, no `sample-typst.qmd`. Build the Day-1 climax fresh.
- **`_brand.yml` in the *deck* / for *slides* — absent.** It lives only in the website lab
  (✅-4), colors+fonts only. No logo, no R-side `theme_brand_ggplot2/gt/thematic()`, no
  "one brand across site + slides + plots" story. Build the DEMO fresh.
- **Positron × Quarto — absent** (🟠-3/🟠-4). Even minimal integration coverage must be built.
- **Dashboards — absent** (and mis-taught as "blank" in the format table, 🔴-1). Build fresh.
- **Layouts as a taught topic — thin.** The deck shows `.columns` but not outset/inset/margin/
  page-layout for articles, which our Day-1 CORE calls out as high-value (`topic-store.md:72`).
- **Cross-references across a project** — the labs show in-doc `@tbl-`/`@fig-` (good), but not
  cross-page/chapter refs (Day-2 CORE). Build fresh.

---

## 📝 Evolution since the previous audit (`prior-art-inventory.md:99-114`)

- **Confirmed and line-anchored** the prior verdict: toolchain-current, R-Markdown-era spine,
  RStudio-first, `%>%`, "what is a chunk" detour, stale dates, no Positron, silent on our CORE.
- **The two "actually fine" labs verified** at line level (✅-1…✅-5) — the parameterized-report
  and website labs are the harvest, as the prior audit said.
- **New this pass (defects the toolchain-currency framing understated):** the format-comparison
  table is now *factually wrong* on `dashboard`/`rticles` (🔴-1), a malformed inline `style=`
  (🔴-1), unit-less reveal column widths (🟡-1), a bare untyped `.callout` (🟡-2), and no
  `sample-typst.qmd` (🟡-6). These are small but real — they mean even the "reusable" deck
  fragments need a correctness pass, not just a reskin.
- **New framing risk surfaced:** the website lab's **git-first opening** (🔴-3) is the Day-2 P0
  auth-cliff embedded in the material itself — the strongest lab we inherit needs its *first
  step* inverted, not just modernized.
- **Bottom line unchanged and reinforced:** base the deck on Christophe's `raukr-2025`; harvest
  NBIS's two labs (reskin to penguins, add Citations+Typst+brand, invert git-first); do not adopt
  the NBIS deck's spine.

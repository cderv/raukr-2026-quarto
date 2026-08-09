# Project context — RaukR 2026 Quarto session

> The concrete "read this before working on content" companion to `CLAUDE.md`. Filled from a
> survey of the NBIS RaukR 2026 site (see § *Reference URLs & prior art*). Sections still
> waiting on Christophe's programme detail are marked _TODO_.

## Event

- **What:** two Quarto sessions at **RaukR 2026** — *Advanced R for Bioinformatics /
  "Data Science With R"* summer school (Visby, Gotland, Sweden; run by NBIS / SciLifeLab /
  Uppsala University).
- **When:** school runs **10–20 Aug 2026** (11-day residential, ~40 participants). Christophe's
  two slots are on the **first two days**, both **afternoons**, each **two parts with a gap** (not
  one continuous block). **Times verified 2026-07-21** against the NBIS schedule Google Sheet (the
  source `home_schedule.qmd` pulls it live via `googlesheets4`) — the slots are **longer than first
  recorded** (the old note had 2×60/day):
  - **Introduction to Quarto** — Mon 10 Aug, **13:30–15:00 (90 min) + 15:30–16:30 (60 min)** = 150 min
  - **Quarto projects** — Tue 11 Aug, **13:30–15:00 (90 min) + 15:30–17:00 (90 min)** = 180 min
  - In person. That's **+90 min total** vs the old 2×60 plan. Decision **2026-07-21 — "Option A":**
    pour the extra time into **hands-on** (hold our ~2:1 hands-on-to-talk ratio) **+ a Day-1 setup
    checkpoint**, *not* more lecture (a 90-min talk-block before any keyboard loses this audience;
    the panel's gap worry stands). Each part still **stands on its own and reaches a hands-on
    payoff**. Only Day-1 Part 2 (the Citations→Typst payoff) stayed 60 min — pre-load its framing at
    the end of Part 1's now-90-min block. The organizers said the **slots are upper limits** — no
    need to fill the whole time; better to land fewer things well.
- **Audience:** PhD students **and** researchers in the **life sciences**, already using R for
  bioinformatics, wanting to move to a **more advanced** level. **Not beginners.** Stated
  prerequisites include data wrangling, using packages, plotting (base/ggplot2), writing
  functions & control structures, **and a basic understanding of R Markdown and/or Quarto**.
  So: assume fluent R, assume they've *seen* literate programming — teach what Quarto *adds*
  and how to *move over*, not "what is a code chunk".
- **Language:** English.
- **Presenter:** Christophe Dervieux (Posit — R Markdown / Quarto), Paris.
- **Co-presenter:** none for the Quarto slots. Other guest instructors cover adjacent topics
  (Positron, R packages) in sibling slots, so check for overlap; nobody co-teaches Quarto.
- **Logistics for a teacher:** room B27 Lärosal, Campus Gotland. Daily rhythm 09:00–12:30 /
  13:30–17:00 with 30-min breaks; schedule granularity is 30-min blocks. Communication via
  **Slack**. TAs are present during sessions to support hands-on exercises. The school
  culminates in a **team project** (internally "capstone") presented on the final day — our material
  can gesture toward "you'll use this in your project". **Participant-facing term is "team project" /
  "your project"** — *not* "capstone" (US-academic jargon this international life-science cohort may
  not use). Keep "capstone" to internal notes only.

## Technical stack

- **Quarto floor:** **≥ 1.9** — pinned as `quarto-required: ">=1.9.0"` in `_quarto.yml`, because the
  Typst article layout used on Day 1 landed in 1.9. (The NBIS site sets a lower `>=1.8.25`.)
- **R:** **≥ 4.5.0** (April 2025) — the floor is set by the running dataset: `penguins` ships in
  base `datasets` only since R 4.5 (see below). Target current release; the sandbox installs R via
  CRAN apt (see `sandbox-setup.md`). Require R ≥ 4.5 on the participant setup page.
- **Slides:** `revealjs`, **1280×720**, `slide-level: 2` (content slides are `##`; no `#`
  section dividers in the RaukR house style).
- **Branding — rebuild via `_brand.yml`** (decision 2026-07-06). We do **not** vendor the NBIS
  `slides.scss` (it's CC BY-NC-SA and carries their SCSS debt). Instead we reconstruct a
  RaukR-compatible look from a `_brand.yml` + a thin reveal `.scss`, matching:
  - **Palette (teal):** primary `#4C979F`, secondary `#A6CBCF`, tertiary `#D1E5E6`,
    link `#79B1B7`, body `#1c2833`, code `#496985`, code-block-bg `WhiteSmoke`.
  - **Type:** body **Albert Sans**, mono **Fira Mono** (both Google Fonts). **Slide type scale
    matches the RaukR house** (`NBISweden/raukr-2026` `assets/css/slides.scss`): root **27px** +
    heading ramp (h1 `1.802em`, h2 `1.602em`, h3 `1.424em`, …), code `0.7em`, reconstructed as
    numbers in `theme.scss` (not their SCSS). Quarto's 40px default reads oversized next to the
    house; Christophe's own `raukr-2025` deck used 36px. 27px also clears the code-heavy slides
    (anatomy, markdown-content) without splitting.
  - **Look:** flat (`border-radius: 0`), light dotted background, dual header logos
    (RaukR left, NBIS/SciLifeLab right).
  - _TODO:_ obtain the RaukR + NBIS/SciLifeLab **logo assets** (ask NBIS, or export from their
    public site) — we can reference but not re-license their images.
- **Extensions (mirror only what we use):** the RaukR decks use `reveal-logo` (dual corner
  logos), `accordion`, `fontawesome`, `collapse-output` (foldable long output). Decide per
  content which we actually pull in via `quarto add`.
- **Running dataset — `penguins`, held through the whole arc** (locked 2026-07-07). Use the
  **base-R `datasets::penguins`** (shipped in base R since **4.5.0** — hence the R floor above), so
  the spine is **zero-install**. Note the base version has shorter names (`bill_len`, `flipper_len`,
  `body_mass`) than palmerpenguins (`bill_length_mm`, …); write against the base names. Fallback for
  R < 4.5: `install.packages("palmerpenguins")` + `library(palmerpenguins)`; `basepenguins` converts
  palmerpenguins-based `.qmd`/`.R` to the base names. Why penguins: 0-install, 3 species (re-skins
  the NBIS per-species scaffold 1:1, CC0 Horst art), teachable NAs, an iconic figure (bill length ×
  depth), and a **citable paper** (Gorman et al. 2014, *PLoS ONE*) that anchors the Day-1
  Citations→Typst article payoff. This replaces the NBIS/`iris` spine; re-skin lifted examples.
- **`gt` datasets as an optional complement** for the "nice table" beat only, if penguins doesn't
  show a gt idiom we want: `exibble` (tiny, purpose-built for gt formatting), `gtcars` (gt's
  showcase), or `rx_adsl` (clinical-trial-flavored, life-science). Keep the **one-dataset rule** —
  reach for these only on the isolated gt beat, not the arc.
- **R packages used live:** `ggplot2`, `dplyr` for examples; `gt` for tables; possibly `plotly`,
  `patchwork`, `leaflet` for demos. Finalize per content. Note: **`pak` works** in the sandbox
  (verified 2026-07-21); `install.packages()` / `renv` also fine. `pak` additionally resolves
  **system requirements** (`pak::sysreqs_fix_installed()`).

## Repository layout

- **Decided (2026-07-07): mirror the NBIS convention** — `slides/<topic>/index.qmd` +
  `labs/<topic>/index.qmd` (e.g. `slides/quarto/`, `labs/quarto/`, `labs/quarto-site/`). Driver:
  NBIS want to **fold our material back into their existing RaukR site**
  afterwards, as slides/documents under their `slides/` and `labs/` trees. Matching their paths
  now makes that a drop-in, not a port. (Supersedes the block-based `1-intro/`/`2-projects/`
  idea.)
- **Author for portability into their tree** (so integration doesn't require rewrites — these are
  the exact things the reuse panel flagged as breaking when a file is lifted,
  `prior-art-inventory.md` § NBIS harvest map 🟠):
  - **Shortcodes — built-in yes, extension no (or declare it).** Built-in shortcodes ship with
    Quarto and are safe to use: `{{< meta … >}}`, `{{< include >}}`, `{{< embed >}}`,
    `{{< video >}}`, `{{< pagebreak >}}`, etc. Shortcodes from an **extension** (`{{< fa … >}}`,
    `reveal-logo`, …) need that extension installed in the target tree — avoid them in fold-in
    content, or **declare the dependency explicitly** (`quarto add …`) so it can be reinstalled
    there.
  - **`{{< meta key >}}` is fine *if the key travels with the file*.** `meta` injects Pandoc
    metadata ([docs](https://quarto.org/docs/authoring/variables.html)); custom keys defined in
    the document's own YAML header, or in a **co-located `_metadata.yml`** (directory-level, same
    schema as `_quarto.yml`, inherited only by files in that dir —
    [docs](https://quarto.org/docs/projects/quarto-projects.html)), move with the content. Only a
    key that lives **solely** in our top-level `_quarto.yml` breaks on the move — so keep
    content-referenced custom metadata at **file or folder** level, not project-only.
  - **Relative, co-located assets** — avoid absolute `/assets/...` site paths; keep images next to
    the `.qmd` so a file survives the move.
  - **Minimal per-file front-matter for *format/theme* config** (already the RaukR house style) —
    so their project `_quarto.yml` governs look-and-feel when the file lands there, and our
    standalone build governs here. (This is about format/brand config; content metadata follows
    the `meta` rule above.)
- **Branding implication.** Our `_brand.yml` reconstruction lives at **project level**, not baked
  into files. Standalone, our build applies the RaukR look; dropped into the NBIS site, *their*
  project config applies. Because we're reconstructing *their* house look (teal / Albert Sans /
  Fira Mono), the two should render near-identically — the goal is that a file looks right in
  **both** contexts with no per-file brand hardcoding.
- **License fit for integration:** our content is **CC BY 4.0**, their site is **CC BY-NC-SA
  4.0** — CC BY is compatible as an upstream input; attribution to Christophe must be preserved
  (see `LICENSE.md` § Integration note).
- _TODO:_ annotated tree once the first content lands.

## Content patterns (RaukR house style — derived, to reuse)

These are reverse-engineered from the NBIS repo so our material fits the school. Full details
and file citations are in the review that produced them; the essentials:

**Slides (revealjs)**
- Minimal deck front-matter (`title` / `author` / `image` / `format: revealjs`); global config
  lives in `_quarto.yml`.
- `##` = one slide. Incremental reveal is **manual** with `. . .` and `::: {.fragment}` (global
  `incremental: false`). Native callouts for note/tip/warning.
- `::: notes` for speaker notes; `::: aside` for image credits / sources.
- **Presenter logistics stay in `::: notes`, not the slide body.** Format/classroom rationale — why
  an exercise is watch-me (auth needs, "a live publish for N laptops…"), why you're skipping a step —
  reads as an apology to the room. State the format positively on the slide; put the *why* in notes.
  (Lesson: 2026-07-20 Publishing slide.)
- Code shown by default (`echo: true`); progressive highlighting via `#| code-line-numbers`;
  long output folded via `collapse-output`.
- Closing slide is a *"Thank you! / Questions?"* pattern.

**Labs (html)**
- Minimal front-matter; nearly everything inherited from the project `format: html`
  (`toc-location: right`, `toc-depth: 4`, `number-sections`, `lightbox: auto`, `freeze: true`;
  `code-fold` is **off** globally and opted in per chunk).
- Open with a `::: {.callout-note}` stating scope + required packages, then a `library()` chunk.
- Sections are `##`; big graded exercises are titled **"… Challenge"**.
- **Solution/hint patterns** (adopt these verbatim):
  - dominant: a solution chunk marked `#| code-fold: true` + `#| eval: false` ("This is our
    solution:").
  - `::: {.callout-tip collapse="true"}` titled `## Example Solution`.
  - hints: `::: {.callout-tip collapse="true"}` with prose.
  - **Lab callout icon scheme** (decided 2026-07-21, `review-2026-07-21-labformat-*` panel; icons via
    the **vendored** `quarto-ext/fontawesome`, solid style, all verified present in FA Free 6.5.2).
    **Gotcha (fixed 2026-07-22): a `{{< fa … >}}` in a callout title renders *in addition to* the
    callout's default type icon** — HTML has no native custom-icon attribute (icons are per-type
    SVG-in-CSS; Lua custom icons are Typst-only — verified deepwiki + quarto.org). So any callout
    that carries a custom fa icon **must also set `icon=false`** on the div, or you get a double icon.
    Scheme: **Tasks** → `::: {.callout-note icon=false}` + `## {{< fa clipboard-list >}} Tasks`;
    **"You should see"** → `::: {.callout-note appearance="simple" icon=false}` +
    `## {{< fa circle-check >}} You should see` (a light checkpoint, *not* a second loud blue Tasks
    box — that's what killed the color semantics); **Troubleshooting** → a real `## Troubleshooting`
    **H2** (enters the TOC) wrapping a collapsed `::: {.callout-tip collapse="true" icon=false}` +
    `## {{< fa wrench >}} …`. **Hint** → `::: {.callout-tip collapse="true"}` + plain `## Hint`: the
    tip default icon **is already a lightbulb**, so keep it — a `{{< fa lightbulb >}}` would just
    double it. **No custom icon** on Scope / Starting-point / the Rmd aside (one-off orientation
    boxes) — they keep their default type icon. `{{< fa download >}}` / `file-pdf` on genuine
    asset/PDF links only.
- Close every lab/report with a **`## Session {.appendix .unnumbered}`** section wrapping a
  `<details>` `sessionInfo()` fold. The `.appendix` gives it a header and tucks it into the HTML
  appendix block (out of the page TOC), instead of a bare headerless `<details>` dangling after the
  last section (which read as part of that section). `.unnumbered` is required because
  `number-sections: true` otherwise labels it (e.g. "4 Session") **and** an `.appendix` heading even
  eats a body section number — a Quarto bug (diagnosed 2026-07-22).
- Datasets: built-in first; large data via a styled download button, not committed; use `here`
  for project-root-relative paths.

**Both**
- Always add `fig-alt` to images (see the `quarto-alt-text` skill).
- Write **current idioms**: native pipe `|>` (not `%>%`), name **Positron** alongside VS Code /
  RStudio, target Quarto **1.9/1.10** features. Refresh any lifted example off this rule.
- **Inline code idiom:** teach the **braced** `` `{r} expr` `` (portable across engines, verified vs
  quarto.org), not the legacy knitr `` `r expr` ``. To *show* it literally use the double-brace escape
  `` `{{r}} …` `` — single brace executes, double brace is literal (see `slides.md` §5).
  (`sample-typst.qmd` keeps the legacy form deliberately — a known exception, not the rule.)
- **Keep it reusable** beyond bioinformatics: generic wording on-slide; a domain example goes in
  `::: notes` as a **localization cue** (e.g. the freeze motivation's "a sequence alignment, a long
  MCMC…"). The cohort *is* life-science, but the material shouldn't be domain-locked.
- Spelling: **US English** (consistent with Quarto's own `color` etc.); hold it across files.
- Pacing follows `workshop-pacing.md`: My/Your turn cycle, ~2:1 hands-on-to-talk. For a 2h
  slot (~110 min effective): ~35–40 min talk+demo, ~60–70 min hands-on.
- **Slides explain, labs try (decided 2026-08-09, supersedes the 2026-07-07 mode-marker
  convention).** A slide's job is the **concept**: what the mechanism is, why it exists, and what it
  looks like when it goes wrong. The lab's job is the **procedure**. A slide may show code to
  *illustrate* an idea. It is never something to transcribe.
  - **The test — if a slide's `Do:` note matches a lab step's solution, the slide is doing the
    lab's job.** Move the procedure to the lab and give the slide back to the concept it displaced.
    This is greppable: read the `::: notes` `Do:` line, then read the matching `## … Challenge`
    step. The Day-1 citations slide printed the Challenge's first and third steps verbatim and
    compressed `citeproc`, CSL, and where `.bib` keys come from into a clause each.
  - **Why the old convention produced that.** It said a Follow-along label makes the code blocks
    under it **load-bearing** (paste-and-render-able). Read as an authoring instruction, that makes
    a slide's job "supply a working snippet", so explanation gets crowded out by whatever has to be
    copyable. The rule did not fail. It succeeded at the wrong goal.
  - **Retired: `Follow along` and `Eyes up`.** The exit marker only ever existed to close a window
    that no longer opens. Do not reintroduce a sustained typing mode, and **do not build a bespoke
    `.my-turn`/`.your-turn` CSS class** — it needs project-level SCSS that does not travel and
    degrades to a silent unstyled div when folded into the NBIS tree (verified).
  - **Kept: `Your turn`** — `::: {.callout-tip title="Your turn — regroup in ~N min"}` that
    **points explicitly at the lab's `## … Challenge`** (one vocabulary — the slide word and the
    lab word must agree; don't split "Your turn" vs "Challenge"). It marks the slides→lab handoff,
    which is still a real transition.
  - **The one narrow exception — a "Do this now" checkpoint.** One command, everyone runs it, with
    a stated pass condition. Use it only where the participant's *own machine* is the point and
    watching proves nothing: the Day-1 setup gate, and the first Typst render (which downloads the
    workshop fonts). A checkpoint has nothing to keep up with, so it has no exit to mismanage.
  - **Objectives:** open with RaukR's native **`## Learning Outcomes`** slide (infinitive verbs);
    **close** with our mirrored **"What you can do now"** wrap-up (their decks lack this — our
    value-add).
  - **Labs — adopt the RaukR idiom wholesale:** `## <Name> Challenge` heading + scope
    `callout-note` at top + `::: {.callout-tip collapse="true"}` **hint** then a folded
    `#| code-fold: true` / `#| eval: false` **solution** + `<details>` Session block. Day-2
    project Challenges must **state the target artifact explicitly** (participants can't picture a
    project they've never built).
  - **Timer stays off the critical path**: say "regroup in ~N min" in the callout and run the clock
    **presenter-side**; frame it as a **regroup clock**, not a performance stopwatch. *(Icons: as of
    2026-07-21 we **vendor `quarto-ext/fontawesome`** — `_extensions/quarto-ext/fontawesome/`, FA Free
    6.5.2 — so `{{< fa >}}` renders in our standalone build **and** folds into the NBIS tree, which
    ships the same extension. Use the lab callout icon scheme above; keep any slide/timer icons off the
    critical path unless equally vendored.)*
  - **Solutions inline, not a separate folder, by default** — a folded `code-fold`/`collapse`
    solution in the lab doc is more portable (one file) and lets participants self-check; ship a
    separate `starter/` file only when an exercise genuinely starts from scratch. (This refines
    `workshop-pacing.md`'s separate-`solution/` default.)

## Programme / blocks

Two afternoon blocks (2 × 1h each). Organizer-suggested scope is in § *Reference URLs* above;
the CORE/DEMO/MENTION/STORE triage that acts on it lives in `topic-store.md`.

- **Block 1 — Introduction to Quarto** (Mon 10 Aug). Baseline exists: the NBIS "Intro" deck is
  actually titled *"Literate programming with Quarto"*. It **builds clean on Quarto 1.9.38** (the `1.4.549` seen on a slide is just illustrative `quarto --version` screen output,
  not a real pin) — so it is *toolchain-current but content-dated*: RStudio- and R Markdown-first,
  `%>%` in examples, and silent on our CORE (citations, Typst-as-payoff, Positron, dashboards).
  Modernize the framing; don't inherit its spine (see `prior-art-inventory.md`).
- **Block 2 — Quarto projects** (Tue 11 Aug). **No existing deck** — build new. Closest prior
  material is the `labs/quarto-site` website lab. Likely scope: `_quarto.yml`, project types
  (website / book / manuscript / dashboard), `_metadata.yml`, profiles, `freeze` at scale,
  publishing (GitHub Pages, CI).
- **Reuse strategy:** _to decide per module_ (fork-and-modernize vs rewrite) — deferred per
  Christophe (2026-07-06) until the programme detail lands.

## Reference URLs & prior art

### This project (live since 2026-08-03)

- **Course site:** <https://cderv.github.io/raukr-2026-quarto/> — deployed from the `gh-pages`
  branch of `cderv/raukr-2026-quarto` by `just publish gh`. Declared in `_quarto.yml` as `site-url`.
- **Demo documents (for showing on screen):** <https://cderv.github.io/raukr-2026-quarto/demos/> —
  the finished lab documents, rendered by `just demos` and shipped with the site. Deployed but
  unlinked: no navbar entry, no link from the lab pages, absent from the search index and sitemap.
- **Participant exercises:** <https://github.com/cderv/raukr-2026-quarto-exercises> — what
  `usethis::use_course()` downloads, generated from `labs/` (see `.claude/rules/exercises.md`).

### RaukR (the school) — CC BY-NC-SA, reference & adapt, do not vendor

- **Site 2026:** <https://nbisweden.github.io/raukr-2026/> — rendered
  [slides index](https://nbisweden.github.io/raukr-2026/slides/index.html) ·
  [labs index](https://nbisweden.github.io/raukr-2026/labs/index.html).
- **Repo:** `NBISweden/raukr-2026` (public, **CC BY-NC-SA 4.0**). Two branches: **`main`**
  (builds the site) and **`develop`** (staging; topics copied from last year land here first,
  then merge to `main`). Not addable to the web session (cross-owner) — explored via a throwaway
  `git clone` in the scratchpad; **`develop` may hold material not yet on `main`**, check both.
  - Quarto material to build on / modernize (these are copied from **2025**):
    `slides/quarto/index.qmd`, `slides/quarto/sample/`, `labs/quarto/index.qmd`,
    `labs/quarto-site/index.qmd`.
  - House style sources: `_quarto.yml`, `assets/css/slides.scss`, `assets/css/styles.scss`.
- **Last year (the actual base of the 2026 Quarto content):**
  [raukr-2025 contents](https://nbisweden.github.io/raukr-2025/home_contents.html) ·
  [general quarto lab](https://nbisweden.github.io/raukr-2025/labs/quarto/) ·
  [personal-website lab](https://nbisweden.github.io/raukr-2025/labs/quarto-site/).
  The organizers are happy for us to reuse, update, or replace these labs as we prefer.

### Organizer scope guidance (paraphrased, from NBIS)

The organizers *suggested* (explicitly "just suggestions", slots are upper limits) this split —
now the backbone of the triage in `topic-store.md`:

- **Mon (Intro):** Basics — Markdown (text/code formatting, figures, tables), Layouts (pages,
  outset, inset, columns, panels), Document types (reports, presentations), Execution options
  (knitr/R engine, chunk attributes), any Positron-specific bits. Intermediate — Parameters,
  Shortcodes, Citations, Typst.
- **Tue (Projects):** Websites, Books, Navigation, Caching, Freeze, Cross-referencing,
  Publishing, Interactivity.

### Christophe's own prior materials (mine — reuse & adapt freely, my license)

The richest source to lift from — my own recent Quarto talks/tutorials:

- **RaukR 2025 Quarto:** <https://github.com/cderv/raukr-2025-quarto> ·
  <https://cderv.github.io/raukr-2025-quarto>
- **useR! 2024 tutorial:** <https://github.com/cderv/user2024-tutorial-quarto> ·
  <https://cderv.github.io/user2024-tutorial-quarto/>
- **useR! 2024 talk:** <https://github.com/cderv/user2024-quarto-talk> ·
  <https://cderv.github.io/user2024-quarto-talk/>
- **RR 2023 tutorial:** <https://github.com/cderv/tuto-quarto-rr-2023> ·
  <https://cderv.quarto.pub/tuto-quarto-rr2023>
- **RR 2026 tutorial (French, Typst-focused):**
  <https://github.com/cderv/tuto-quarto-typst-rr-2026> ·
  <https://cderv.github.io/tuto-quarto-typst-rr-2026/>
- **NBIS RaukR course (the site this folds into, and the house patterns to match):**
  <https://github.com/NBISweden/raukr-2026> · <https://github.com/NBISweden/raukr-2025> — the
  deployed course. Useful reference for shared conventions, e.g. the lab **download-button** style
  (verified 2026-07-22): a raw `<a class="btn btn-primary btn-sm" ... target="_blank">{{< fa download
  >}} file</a>` whose `href` is a `raw.githubusercontent.com` URL (or a Dropbox `?dl=1` link for
  large / off-repo files) — **no `downloadthis` extension** (not vendored in either year).
- Also worth a look for pacing/structure: **Mine Çetinkaya-Rundel's** Quarto workshops (the
  pedagogy in `workshop-pacing.md` derives from them).
- **Access — all of these are public and directly `git clone`-able from this sandbox.** A plain
  `git clone https://github.com/<owner>/<repo>` works even for repos **outside the session's scope**
  (the `add_repo` tool is same-owner-only and refuses cross-owner adds, and the scoped GitHub MCP
  tools don't reach cross-owner — but raw `git clone` over the proxy does; verified 2026-07-22 on
  `NBISweden/raukr-2025` + `raukr-2026`). Clone into the scratchpad to explore; **vendor nothing.**
- **Content map of the cderv materials → `.claude/references/prior-art-inventory.md`** — what each
  covers, the exercise catalogue, and a coverage map vs our CORE (with the gaps).

### Quarto documentation

Canonical doc-lookup entry points (quarto.org, `llms.txt`, Context7, DeepWiki, source repos)
live in **`.claude/references/quarto-doc-sources.md`** — use it when authoring or reviewing to
fetch authoritative, current docs instead of guessing.

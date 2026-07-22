# Technical review — teaching-mode markers ("My/Our/Your turn") + lab exercise markers: portability & rendering robustness

**Scope:** focused technical/portability question, not a full review. Evaluate three ways to
signal teaching modes on slides and mark exercises in labs, against the constraint that our
content must **fold back into the NBIS `slides/`/`labs/` tree without rewrites**
(`.claude/references/project-context.md:76-114`). Recommend the integration-safe implementation.

**Environment:** Quarto `1.9.38` (`quarto --version`), matching the ≥1.8 floor
(`project-context.md:39`). Our repo currently has **no `.qmd`/`.yml`/`_extensions/` content**
(`find` returns nothing), so this is a *forward-looking design decision* — nothing in-repo to
re-flag. Facts below are drawn from the NBIS clone
`scratchpad/raukr-2026@main` and from an empirical smoke render.

---

## Overall verdict

Use **built-in Quarto primitives only** for both markers. The decisive fact, confirmed by
render: a bespoke `.my-turn`/`.your-turn` div and a countdown-timer degrade in *opposite*,
both-bad ways when a file is lifted — a custom class silently loses its styling (its SCSS lives
in the reveal theme wired at **project** level, `_quarto.yml:102`, and does **not** travel), while
a missing timer **shortcode prints its raw source text on the slide** (`{{< countdown 5:00 >}}`)
with only a build *warning*, not an error. NBIS themselves ship **no mode markers and no timer**:
slides lean on native callouts + headings + `::: {.notes}` (`slides/demo/index.qmd`), and labs use
`## <Name> Challenge` headings + `::: {.callout-tip collapse="true"}` solutions
(`labs/tidyverse/index.qmd:334,63`). Mirroring that idiom — differentiating My/Our/Your turn by the
three built-in callout **types** with the label in the title — is guaranteed drop-in, needs zero
SCSS and zero extension, and renders in both revealjs and html. Reserve any timer/custom styling
for a declared, off-critical-path dependency.

---

## 🔴 Breaks on integration / don't do

### 1. Bespoke `.my-turn` / `.your-turn` div class styled by our reveal SCSS — silent, total loss of the marker on the move
The styling for any custom class lives in the **reveal theme, wired at project level**, not in the
file. In the NBIS tree that is `_quarto.yml:102` → `theme: ["default", "assets/css/slides.scss"]`,
and the custom classes it powers (`.largest` at `slides/demo/index.qmd:275`, `.badge` at `:338`,
`.v-top`/`.v-center` at `:159/:179`) are defined in `assets/css/slides.scss:41,137,143,176`. The
demo deck's own front-matter is minimal — `format: revealjs`, **no `theme:`**
(`slides/demo/index.qmd:1-9`) — proving styling is inherited from the project, per our own rule
(`project-context.md:106-110`). Our `_brand.yml`/reveal SCSS reconstruction likewise lives at
project level.

Empirical result (smoke render of `::: {.my-turn}`): the div travels with **no error and no
warning** →

```
<div class="my-turn">
<p>Your turn content in an unknown div class.</p>
```

…but with **none of our styling present in the NBIS tree**, so it renders as a plain, unmarked
paragraph. The pedagogical signal (color/badge/border that says "your turn now") vanishes
*silently*. That is worse than a build break — it looks fine locally, ships broken, and nobody
gets a warning. **Do not encode the mode in a custom-CSS-dependent class.**

> Note: sticking to the **five built-in callout types** (`note/tip/important/caution/warning`)
> avoids this entirely — they are core-styled by Quarto/reveal with **no SCSS**. Only a *new named
> appearance* would need theme CSS.

### 2. Countdown-timer extension for "Your turn" — raw shortcode text printed on the slide if not reinstalled
A revealjs countdown (e.g. `mcanouil/quarto-countdown`, or a `gadenbuie/countdown`-style plugin)
is an **extension** that contributes *both* a `{{< countdown >}}` shortcode *and* a revealjs JS+CSS
plugin. It must be `quarto add`-ed into `_extensions/` **in every tree that renders the file**
(Context7 / quarto.org: shortcodes install via `quarto add org/repo`, plugins register under
`revealjs-plugins`). Critically, NBIS's `_extensions/` contains **no countdown** — only
`mcanouil/collapse-output`, `quarto-ext/shinylive`, `quarto-ext/fontawesome`,
`royfrancis/particles`, `royfrancis/accordion`, `royfrancis/reveal-logo`. So a timer is a net-new
dependency in **both** our standalone repo *and* the NBIS tree.

Empirical result (smoke render with the extension absent):

```
WARNING (…/main.lua) Shortcode 'countdown' not found
```
```
<p>Timer here: {{< countdown 5:00 >}}</p>
```

Build **exits 0** (a warning, not an error), but the literal `{{< countdown 5:00 >}}` is emitted
**verbatim into the slide** — participant-visible garbage. A file that relies on a timer looks
broken the moment it lands in a tree without the extension. **Don't put a timer on the critical
teaching path.** (Same mechanism confirmed for `{{< fa … >}}`.)

---

## 🟠 Works only if a dependency is declared

### 3. FontAwesome icons in a marker title (`{{< fa … >}}`) — a "declare on both sides" case
The house lab idiom uses `**{{< fa clipboard-list >}} Tasks**` (`project-context.md:142`). `fa` is
an **extension** shortcode: same failure mode as the timer if absent (WARNING + literal
`{{< fa clock >}}` text — confirmed by render). The asymmetry: NBIS **already ships**
`_extensions/quarto-ext/fontawesome`, so a folded-in file's `{{< fa >}}` will resolve *there*; but
our **standalone** build breaks unless we also `quarto add quarto-ext/fontawesome`. If we want the
icon, declare it as an explicit dependency in *our* repo (`quarto add`) and record it — it is safe
into their tree but not out of ours by default. To stay fully dependency-free, prefer a **Unicode
emoji or plain text label** in the callout title instead of `{{< fa >}}`.

### 4. If a timer is genuinely wanted
Allowed only as a **declared** dependency: `quarto add <countdown-ext>`, committed under
`_extensions/`, and flagged in the fold-in handover so NBIS reinstall it. Keep every slide
**teachable without it** (the timer is decoration, never the content), so the §1-style silent/§2-style
literal-text degradation is cosmetic, not a teaching failure.

---

## 🟡 Minor / robustness

- **Cross-format leakage of reveal-only markup.** Our multi-format story keeps slides reveal-only
  and labs html-only, so this is latent, but: `::: {.notes}` is hidden (presenter mode) in
  revealjs yet renders as **visible body content** in html; `::: {.fragment}` and the `. . .` pause
  are inert/harmless in html but `. . .` can surface as literal text in non-reveal output. If any
  single source is ever dual-rendered, gate reveal-only marker chrome behind
  `.content-visible when-format="revealjs"`. Native **callouts** render correctly in *both* html and
  revealjs, so a callout-based marker is the cross-format-safe choice.
- **Callout height on slides.** A tall callout can overflow a 1280×720 slide — a layout, not a
  portability, concern. Keep marker callouts to a line or two.
- **Lab `## … Challenge` cross-refs.** If we ever want `@sec-` links to challenges, add explicit
  `{#sec-…}` labels; NBIS's plain `## NYC flights Challenge` (`labs/tidyverse/index.qmd:334`) is
  not cross-referenceable as-is. Not required for the marker to work.

---

## ✅ Fully portable, safe (recommended)

**Confirmed portable with zero dependency** (core Pandoc/Quarto/reveal — verified present and
working in the NBIS demo, and dependency-free by construction):

- **Native callouts** `::: {.callout-note/tip/important/caution/warning}` — core-styled, render
  identically standalone and folded-in, in **both** html and revealjs. In use at
  `slides/demo/index.qmd:43` and `labs/tidyverse/index.qmd:25,63,151`.
- **Section headings** (`##` = slide / lab section; `###`/`####` subsections) — core.
- **`::: {.notes}`** speaker notes (`slides/demo/index.qmd:101`), **`::: {.fragment}` / `. . .`**
  incremental (`project-context.md:124`), **`::: {.columns}`/`.column`** (`slides/demo/index.qmd:110`)
  — all core reveal, no extension, no project SCSS.
- **`::: {.callout-tip collapse="true"}`** collapsible solution — the exact NBIS lab solution idiom
  (`labs/tidyverse/index.qmd:63`), fully built-in.

### Recommended implementation

**Slides — My / Our / Your turn.** Encode the mode in the **built-in callout type** (three distinct
core colors, zero SCSS), with the label in the title and an emoji (not `{{< fa >}}`) if you want a
glyph:

```markdown
::: {.callout-note title="🧑‍🏫 My turn"}      <!-- instructor demo -->
::: {.callout-tip title="👥 Our turn"}         <!-- guided together -->
::: {.callout-important title="✍️ Your turn"}  <!-- solo exercise -->
```

This renders with core styling in revealjs *and* html, survives the move into NBIS's tree with the
same appearance (their project brand simply restyles the same built-in callout), and adds **no**
`_extensions/` entry and **no** custom class. It is also consistent with NBIS already using
callouts as their primary slide device (`slides/demo/index.qmd:43`).

**Labs — exercise marker.** Adopt the NBIS idiom **verbatim** (guaranteed drop-in):

- Exercise = `## <Name> Challenge` heading (TOC-visible), as `labs/tidyverse/index.qmd:334`.
- Task box = `::: {.callout}` / `::: {.callout-note}` (drop the `{{< fa >}}` unless fontawesome is
  declared per §3; use a plain "**Tasks**" or emoji label to stay dependency-free).
- Solution = `::: {.callout-tip collapse="true"}` and/or a `#| code-fold: true` + `#| eval: false`
  chunk, per `labs/tidyverse/index.qmd:63` and `project-context.md:137-142`.

**Dependencies to declare only if you insist on chrome:** a countdown timer (`quarto add
<countdown-ext>` in *both* trees — NBIS has none) and/or `{{< fa >}}` icons (`quarto add
quarto-ext/fontawesome` in *our* repo; NBIS already has it). Keep both off the critical path.

---

## 📝 Evolution since the previous review

- The `project-context.md:154` _TODO_ ("our own mode-marker convention … RaukR itself has no
  explicit slide mode-markers") is now technically answerable: grep across the NBIS clone confirms
  **zero** `my-turn/our-turn/your-turn` and **zero** `countdown` occurrences — there is no house
  slide-side mode marker and no timer to inherit, so the safe move is to *add one from built-ins*
  rather than port anything.
- The portability rule refined in commit `3a0c800` ("built-in shortcodes incl. meta are fine;
  extension shortcodes don't travel") is **empirically validated** here: unknown shortcode → WARNING
  + literal text (exit 0); unknown div class → silent unstyled div. Both confirm the guidance that
  extension shortcodes and project-only CSS must not sit on the fold-in critical path
  (`project-context.md:86-105`).
- No regressions to note — the repo has no content yet; this establishes the convention *before*
  the deck is built, which is the right sequencing.

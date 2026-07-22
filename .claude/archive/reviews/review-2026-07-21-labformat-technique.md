# Lab-format mechanism review — callout-heavy vs NBIS prose

**Reviewer:** workshop-reviewer-technique (Quarto-craft / portability / a11y lens)
**Date:** 2026-07-21
**Scope:** presentation *mechanism* of the labs, not teaching content. Decide keep / trim / hybrid
between OURS (callout-heavy, "Challenge"-framed, folded solution) and NBIS (long prose walkthrough,
`{{< fa >}}` icons, tabsets).
**Env:** quarto 1.9.38. Files read in full: our two labs, NBIS `labs/quarto` + `labs/quarto-site`,
project-context § Content patterns, prior-art-inventory.

---

## Verdict

**Keep the callout-heavy / folded-solution scaffold — it is the idiomatic and the *more portable*
mechanism — with a light trim.** Our labs use only built-in Quarto (callouts, `collapse`,
`code-fold`, `<details>`) and **zero** shortcodes/extensions (verified: `grep '{{< '` on
`labs/` returns nothing). That makes them *more* drop-in-clean into the NBIS tree than NBIS's own
labs, which depend on the fontawesome extension (`{{< fa clipboard-list >}}`, `{{< fa download >}}`
at `labs/quarto/index.qmd:594`, `labs/quarto-site/index.qmd:153,213,303,340`) — those render as raw
`{{< fa … >}}` text in any tree lacking `_extensions/quarto-ext/fontawesome`. The remaining issues are
cosmetic (blue-box monotony from adjacent same-type callouts) and two small consistency items, not
mechanism defects. NBIS's prose style is technically robust but structurally wrong for a hands-on lab
(the "reference-wall" problem already catalogued in prior-art-inventory) — do not adopt its spine.

---

## Mechanism comparison

### 1. Structural scaffold — callouts as a lab template (OURS) vs prose sections (NBIS)

Our labs are a **predictable per-Challenge template**, each element a titled callout:

- Day 1 (`labs/quarto/index.qmd`): Scope `:8` → Rmd-aside (collapse) `:35` → **Challenge 1**: Tasks
  `:52`, You-should-see `:81`, Hint (collapse) `:104`, folded solution `:113` → **Challenge 2**:
  Starting-point `:161`, Tasks `:168`, You-should-see `:209`, Hint (collapse) `:216`, folded
  solution `:226`, Troubleshooting `:252`, Session `<details>` `:274`.
- Day 2 (`labs/quarto-projects/index.qmd`) mirrors it: Scope `:19`, Starting-point `:33`, Tasks
  `:57`/`:152`, You-should-see `:101`/`:171`, Hint (collapse) `:125`/`:179`, Troubleshooting `:208`.

This is the correct idiom for a **roaming-TA, 40-laptop** lab: a participant who falls behind can
scan for "Tasks" / "You should see" and self-rescue. NBIS by contrast buries its only two tasks under
~590 prose lines (`labs/quarto/index.qmd`, whole) with **no success criteria** and **no folded
solutions** — a *tutorial to read*, not a *lab to do*. The "You should see" callout is a genuine
value-add our format has and theirs lacks.

**Idiomatic?** Yes, unambiguously. `code-fold: true` + `eval: false` for solutions (`:113`, `:226`,
`:188`) and `collapse="true"` for hints/optional asides are exactly the built-in HTML-lab mechanisms
Quarto ships for this purpose. Nothing invented, no bespoke class, no SCSS. Confirmed against Quarto
callouts docs (<https://quarto.org/docs/authoring/callouts.html>) and code-folding
(<https://quarto.org/docs/output-formats/html-code.html#folding-code>).

### 2. `{{< fa >}}` / tabsets / plain prose (NBIS) — robustness

- **`{{< fa >}}` (NBIS):** extension-dependent. NBIS ships `_extensions/quarto-ext/fontawesome`, so it
  works *in their tree*. But it is a portability liability: lift one file out and the icons print raw.
  Our decision to avoid it (project-context § Content patterns, and the mode-marker convention "use
  emoji/plain text, not `{{< fa >}}`") is verified in practice — **our labs contain zero `{{< fa >}}`**.
  This is a real robustness advantage of ours, not just a stylistic one.
- **Tabset (`::: {.panel-tabset}`, NBIS site lab, used once):** idiomatic and dependency-free. It is
  the *one* NBIS mechanism worth a targeted borrow — see hybrid rec below.
- **Plain prose (NBIS):** the most robust of all (no deps, prints perfectly), but its robustness is
  irrelevant when the failure mode is *pedagogical* (tasks invisible), not technical.

### 3. Accessibility & output robustness

- **Screen-reader / keyboard:** our collapsed callouts and `code-fold` blocks are native
  `<details>`/disclosure widgets (or Bootstrap collapse with `aria-expanded`) — keyboard-operable and
  SR-announced out of the box. No custom JS. Good.
- **Color-only semantics — a strength, not a risk, *because* we title everything.** Callout *type*
  (note vs tip) is conveyed by color + icon, which alone would be a WCAG 1.4.1 concern. But every one
  of our callouts carries a **text title** ("## Scope", "## Tasks", "## You should see", "## Hint",
  "## Troubleshooting"), so the semantic is carried by words, not hue. Keep this discipline — an
  untitled `callout-note`/`callout-tip` pair *would* be color-only. (NBIS's bare `::: callout-note`
  at `labs/quarto/index.qmd:9` is untitled — the anti-pattern we avoid.)
- **Print / "Save as PDF" of the HTML lab (the one real tradeoff):** `collapse="true"` callouts and
  `code-fold: true` blocks render **closed**, so a Ctrl-P / browser-PDF of the page **omits** the
  hints and solutions unless the reader expands them first. The *structural* content (Tasks,
  You-should-see, Troubleshooting — all non-collapsed) prints fine. This is acceptable — arguably
  desirable (a printed lab with solutions hidden) — but it is a conscious tradeoff worth knowing.
  These are `format: html` labs, not a PDF deliverable, so the stakes are low. NBIS prose prints
  fully; that is the only axis on which their mechanism wins, and it does not matter here.

### 4. Consistency & maintainability

- **OURS is highly maintainable:** one template, applied 4× (2 Challenges × 2 days). Predictable to
  author and to review. This regularity is the whole value.
- **Minor inconsistency — solution delivery mixes two mechanisms on Day 2.** Challenge 1 (Website)
  has *no* inline folded solution and instead points at the `solution/` folder (`:137`); Challenge 2
  (Ship it) uses an inline `code-fold` solution (`:188`). This is *defensible* (a multi-file
  `_quarto.yml`/`_brand.yml` solution can't sensibly inline) and matches the house rule "solutions
  inline by default; separate `starter/`/`solution/` only when the exercise starts from scratch"
  (project-context `:204-207`). Keep it, but it's the one place the template isn't uniform — worth a
  one-line note in each so participants know where the answer lives.

---

## Portability — fold-into-NBIS-tree

**Ours travels cleaner than theirs.** Technical portability (does it render in `NBISweden/raukr-2026`):

| | Extension deps | Bespoke CSS/classes | Renders raw if lifted bare |
|---|---|---|---|
| OURS labs | none | none | nothing breaks |
| NBIS labs | fontawesome (`{{< fa >}}`) | `.shadow` div (site lab) | `{{< fa … >}}` prints literally |

The only clash is **aesthetic consistency**, not breakage: our box-dense labs sit next to NBIS's
prose-dense labs in the same labs index and *read* differently (checklist vs article). Everything
still renders and their site SCSS styles our callouts correctly. That is a house-style decision for
the organizers, not a technical blocker.

**One doc/practice mismatch to fix so nobody "restores" the dependency:** project-context.md `:161`
still lists `**{{< fa clipboard-list >}} Tasks**` as an adopted house idiom (harvested from NBIS),
but our labs correctly use a titled `::: {.callout-note}` + `## Tasks` instead. The reference
recommends an fa-dependent idiom the labs wisely dropped — reconcile the note (mark it "superseded:
use titled callout, no fa") so a future author doesn't reintroduce the extension coupling.

---

## Recommendation — KEEP (with a light trim + one targeted hybrid)

1. **Keep the built-in callout + `code-fold` + `collapse` scaffold as-is.** It is the idiomatic,
   zero-dependency, most-portable HTML-lab mechanism, and it beats NBIS prose on the axis that matters
   (tasks + success criteria are *findable*). Do **not** adopt `{{< fa >}}` or tabsets-for-structure.

2. **Trim the blue-box monotony — break consecutive same-type callouts.** Right now a `callout-note`
   "Tasks" is immediately followed by a `callout-note` "You should see" (`:52`→`:81`, `:168`→`:209`,
   and Day 2 `:57`→`:101`, `:152`→`:171`): two adjacent blue boxes distinguished only by title. Either
   render "You should see" as short **prose with a bold lead-in** (it's an outcome statement, not an
   instruction), or give it a visually distinct treatment. This preserves scannability while cutting
   the wall-of-boxes feel that would otherwise be the fair critique of a callout-heavy page. Target:
   no two same-type callouts back-to-back.

3. **One targeted hybrid borrow — a tabset for genuine *alternatives*, not for structure.** Day 1's
   two Typst render routes (CLI vs editor Render button) are currently prose bullets at `:198-207`;
   the "two routes to the same outcome" shape is exactly what `::: {.panel-tabset}` (CLI / Editor) is
   for, and it's dependency-free. This is the single NBIS mechanism worth adopting, and only here.
   Optional, low priority.

4. **Keep titling every callout** — it is what makes the color-semantics accessible (WCAG 1.4.1).
   Treat an untitled `callout-note`/`callout-tip` as a defect.

5. **Reconcile project-context.md `:161`** to stop recommending `{{< fa clipboard-list >}} Tasks` —
   it contradicts the (correct) zero-extension practice and is a latent portability regression.

Not recommended: adopting NBIS's prose-walkthrough spine (buries tasks), or its `{{< fa >}}` icons
(extension coupling for decoration).

---

## Checks run

- `grep '{{< '` on `/home/user/raukr-2026-quarto/labs/` → **empty** (our labs use no shortcodes/exts).
- `find _extensions` → ours = only `mcanouil/typst-render` (used by slides/sample-typst, not labs);
  NBIS = `quarto-ext/{fontawesome,shinylive}`, `royfrancis/*`, `mcanouil/*`.
- NBIS `{{< fa >}}` occurrences located (`labs/quarto:594`; `labs/quarto-site:153,213,303,340`).
- Callout / collapse / code-fold counts spot-verified against the factual scaffold (Day 1: 10
  callouts, 3 collapse, 2 code-fold — matches).
- `quarto --version` → 1.9.38.
- Mechanism claims cross-checked against quarto.org callouts + code-folding docs.

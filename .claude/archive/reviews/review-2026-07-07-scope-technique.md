# Technique review (SCOPE) — RaukR 2026 Quarto — 2026-07-07

**Reviewer lens:** Quarto technical correctness / demo-reproducibility.
**Cycle:** pre-content scope review. No slides or labs exist yet — the material under review is
the *programme + triage*: `topic-store.md`, `prior-art-inventory.md`, `project-context.md`.
**Reference commit:** 715d3ec. **Installed toolchain:** `quarto --version` → **1.9.38**
(matches the stated target; floor `>=1.8` is coherent).

---

## Overall verdict

The triage is technically sound and unusually disciplined for this stage: every CORE/DEMO item
rests on features that are **stable at the ≥1.8 floor** — Typst (GA since 1.4), dashboards
(1.4), `_brand.yml` for HTML/revealjs/Typst (1.6+), freeze/cache (long-stable). There is **no
version-gated or invented feature in the plan**, so no P0. The real risks are not correctness
but **live-demo reproducibility and scope density**: three of the most ambitious promises
(Day-2 R-side `brand.yml` graphics, live `quarto publish`, and the Interactivity "teaser") each
hide a dependency or a network/auth step that does not reliably survive a room of 40 people or a
compressed 55-min part. The two flagship payoffs are asymmetric in risk: **Day-1 Typst is safe
to promise** (bundled, LaTeX-free, deterministic); **Day-2 R-side branding is feasible but rests
on a young, possibly non-CRAN package and delivers mostly *color*, not full brand** — calibrate
the promise before it's built. Day-1 Part 2 is over-subscribed and should shed a DEMO or two.

**Counts — P0: 0 · P1: 5 · P2: 6**

---

## 🔴 P0 — blocking technical bug

None. No proposed CORE/DEMO item names a non-existent format, an invented YAML key, or a
feature above the ≥1.8 floor. The plan is technically buildable as written; the findings below
are feasibility/scope risks, not falsehoods.

---

## 🟠 P1 — fix before the event

### P1-1 · Day-1 Part 2 is over-scoped for a ~55-min, 2:1-hands-on slot
`topic-store.md:48-63` (CORE) + `:65-72` (DEMO). Part 2 = **Citations (CORE)** + **Typst
(CORE, the payoff)** + **Parameters (DEMO)** + **Shortcodes (DEMO)** + Positron. Under the
stated budget (`topic-store.md:137-148`, `workshop-pacing.md`: ~20 min demo / ~30 min hands-on
per part), Typst-as-payoff alone credibly eats the whole demo budget (one-liner → `keep-typ` →
brand → logo is a 15-20 min arc), and Citations-as-CORE needs its *own* taught segment + a real
`.bib` + a CSL. Landing **two CORE topics plus two DEMOs plus a hands-on** in one part is not
realistic. Recommend: demote **Parameters** and **Shortcodes** to MENTION for Day 1 (or push
Parameters to Day 2, where it pairs naturally with projects/CI), and let Part 2 be *Citations →
Typst* only. This matches the organizers' own "slots are upper limits / land fewer things well".

### P1-2 · Day-2 R-side `_brand.yml` branding rests on a young package and promises more than it delivers
`prior-art-inventory.md:57`, `:85`, `topic-store.md:118`. Verified against the `brand.yml` R
package docs (Context7 `/posit-dev/brand-yml`): the helpers **do exist** —
`theme_brand_ggplot2()`, `theme_brand_gt()`, `theme_brand_thematic()`,
`theme_brand_plotly()`, `theme_brand_flextable()`, and `read_brand_yml()` auto-discovers the
project `_brand.yml`. So the demo is real. But two calibration risks:
  1. **Availability / setup.** `brand.yml` is a recent package; confirm it is installable on a
     participant machine via `install.packages()` (the sandbox note in CLAUDE.md is explicit:
     **`pak` does not work — use `install.packages()`**). If it is r-universe/GitHub-only at
     Aug-2026, the setup page needs an explicit `install.packages("brand.yml",
     repos = ...)` line, and the *live* demo should not assume a fresh CRAN install works.
     **Verify the install path and pin it on the setup page before building.**
  2. **Scope of the promise.** `theme_brand_gt()`/`theme_brand_thematic()` apply brand
     **foreground/background/accent colors** (and base typography), not the full brand system.
     Frame it as "same palette across plots/tables/site", not "your gt table inherits the whole
     brand". Also note these are a **separate mechanism** from Quarto's native format brand — see
     P2-2.
As a Day-2 **DEMO** (no exercise), this is acceptable risk *if* the promise is calibrated and
Christophe drives it on his own machine. Do not turn it into a hands-on without solving (1).

### P1-3 · "Publishing — gh-pages **and** CI" as CORE can't be a reliable live hands-on
`topic-store.md:109`, `prior-art-inventory.md:84`. `quarto publish gh-pages` needs a live
GitHub repo, auth (PAT/gh), and a network push; for 40 participants on conference wifi with
their own repos this is the classic room-killer. CI (GitHub Actions) *by definition* can't be
"run live" — you push and wait, and the payoff (green check) lands minutes later. Foregrounding
CI is the right 2026 story, but treat this segment as **DEMO/walk-through on a pre-provisioned
repo**, not a "Your turn" everyone executes. Keep the hands-on to `quarto render` +
`output-dir`; show `publish`/Actions on the screen. Reflect this by marking Publishing's
*hands-on* portion as DEMO in the triage.

### P1-4 · Interactivity "teaser" conflates three very different mechanisms — one is heavy/flaky live
`topic-store.md:116`, `prior-art-inventory.md:87`. "OJS / htmlwidgets / Shinylive teaser" bundles
(a) **htmlwidgets** — trivial, pure R, reliable; (b) **OJS** — a *different language* (Observable
JS), not R, its own reactive model; (c) **Shinylive** — requires the `quarto-ext/shinylive`
extension + webR/wasm bundling, is heavy to build and the flakiest thing in the whole plan.
Promising all three as one "teaser" hides that they share nothing. Recommend: lead with **an
htmlwidget** (e.g. `plotly`/`leaflet`) as the safe demo, mention OJS as "a non-R path" with a
link, and keep **Shinylive as MENTION only** unless a pre-built, cached example is committed.
Do not attempt a live Shinylive build in the room.

### P1-5 · Citations × Typst interaction is the hidden-complexity gap behind the Day-1 payoff
`topic-store.md:62` (Citations CORE) meets `:63` (Typst CORE) in the same Part 2, and
`prior-art-inventory.md:69` flags citations as "⚠️ weak — no dedicated exercise". If the
citation demo is shown *inside* the Typst PDF payoff (natural, since both are Part 2), be aware
the bibliography path differs by format: Quarto renders citations via **`citeproc`/CSL** by
default, and Typst has its own native bibliography engine — the CSL-vs-Typst-native handoff has
edge cases (some CSL styles, `nocite`, locator formatting) that surface exactly when you least
want them, live. Build and smoke-test the citation example **in the Typst format specifically**,
not just HTML, and pick a mainstream CSL. This is the one place where two CORE topics interact in
a way the plan doesn't yet acknowledge.

---

## 🟡 P2 — nice-to-have / robustness

### P2-1 · Freeze's value is genuinely hard to *show* live
`topic-store.md:108`. The freeze-vs-knitr-cache distinction is correct and worth teaching
(freeze = project-level "don't re-execute", stored in `_freeze/`, committed to git, the thing
that lets **CI render without R**; cache = chunk-level knitr memoization). But freeze only
*demonstrates* its value across **two renders / a commit / a CI run** — a single live render
shows nothing. Plan the demo as "render once, edit prose only, render again → note code didn't
re-run", and tie it explicitly to P1-3's CI story (that's the real payoff). Also note: freeze
engages for a **project** render, not `quarto render single.qmd`.

### P2-2 · Clarify that "one `_brand.yml`" drives formats and R-graphics via **two** mechanisms
`topic-store.md:118`, `prior-art-inventory.md:85`. Quarto's *native* brand (HTML/revealjs/Typst
colors, type, logo) and the R `brand.yml` package (`theme_brand_*` for ggplot/gt/plotly) both
read the **same file**, but are separate implementations with separate coverage. The "one brand
→ site + slides + R plots" story is true and compelling — just don't let the demo imply a single
engine, or a question about "why did my ggplot not pick up the logo" will derail it.

### P2-3 · `theme_brand_*` and Positron parity — don't imply a visual editor in Positron
`topic-store.md:72`, `prior-art-inventory.md:74`. Keeping Positron to "the Quarto integration
only" is the right, minimal call. One correctness note for when it's built: Positron does **not**
ship RStudio's Quarto **visual editor**. If the Day-1 authoring segment mentions the visual
editor (a common intro beat), scope it to RStudio and don't imply Positron/VS Code parity.

### P2-4 · Layout features are format-specific — the "articles" framing is HTML/PDF, not revealjs
`topic-store.md:60` ("columns, panels, inset/outset, page/figure layout for articles").
`.column-margin` / `column: page` / margin figures are an **HTML/Typst article** idiom and do not
map to revealjs the same way. Since Day 1 also teaches "reports + presentations from one source"
(`:61`), be explicit that layout ≠ portable across every format, or a participant re-rendering the
article layout as slides will see it silently ignored.

### P2-5 · Dashboards is more than `format: dashboard`
`topic-store.md:117`, `prior-art-inventory.md:88` ("gap — build new"). The keyword is a
one-liner, but a *useful* dashboard demo needs the layout model (rows/columns, `orientation`,
`.card`, valueboxes, tabsets). Budget for that learning curve when building fresh, or the DEMO
lands as an underwhelming single-plot page.

### P2-6 · Parameters re-render needs the CLI/terminal, not a Render button
`prior-art-inventory.md:72`, `:92` ("gap — build new"). `params:` YAML is trivial, but
*overriding* params (the whole point) needs `quarto render doc.qmd -P key:val` or
`quarto::quarto_render(execute_params = ...)` from a terminal — you can't do it from RStudio's
Render button. Whoever builds this should show the terminal path, and it reinforces P1-1's case
for moving Parameters to Day 2 (where the terminal/CLI framing already lives).

---

## ✅ Technical choices validated

- **Version floor is safe for the entire plan.** Every CORE/DEMO item is GA at ≥1.8: Typst
  (1.4+), dashboards (1.4+), `_brand.yml` for HTML/revealjs/Typst (1.6+), freeze/cache, shortcodes,
  parameters, cross-refs, publishing. **No version-gated or preview-only feature is promised as
  CORE** — a genuinely disciplined triage. (`project-context.md:39-40`.)
- **Day-1 Typst payoff is technically sound and safe to promise** (`topic-store.md:63`). Typst is
  bundled with Quarto — the "modern PDF without LaTeX" claim is *literally* true, no tinytex, no
  LaTeX install, deterministic output, fast. This is the right flagship for a room where a LaTeX
  toolchain would be the #1 setup failure. `keep-typ` gives an honest "look under the hood" beat.
- **Native `.qmd`-first, Rmd-migration-as-reassurance** (`topic-store.md:32-35`, `:76-78`) is the
  correct 2026 call for this audience and matches the house line (`|>`, Positron alongside
  VS Code/RStudio).
- **freeze vs knitr `cache` as an explicit distinction** (`topic-store.md:108`) is a real,
  frequently-muddled point — correct to call it out rather than blur it.
- **The cuts are well-judged technically:** dropping **Manuscripts** (`topic-store.md:131` — a
  genuinely heavy, easy-to-break project type), demoting deep chunk-option and LaTeX/tinytex
  tours (`:86-88`), and superseding Bootswatch theming with `_brand.yml` (`:133`) all remove the
  highest-maintenance, lowest-audience-fit material.
- **Reuse map is accurate** (`prior-art-inventory.md:59-97`): the gap flags (Citations, Parameters,
  Dashboards, Interactivity, Positron) correctly identify where no reliable prior asset exists —
  which is exactly where the P1 demo-risk concentrates. The self-audit did the right diagnosis.

---

## 📝 Evolution since the previous review

**First technical review in the archive** (`reviews/` held only `.gitkeep`) — no prior findings
to re-check, nothing to re-flag as fixed. For the record, the git history since scaffold shows
technically-sound direction already baked in *before* this review: `3f476c3` (de-emphasize
Rmd→Quarto, teach native `.qmd`) and `6a50a65` (currency audit vs 1.9/1.10) are the right calls
and are reflected in the docs above — they pre-empt the two most common "dated intro" pitfalls
(`%>%`, RStudio-only, "what is a chunk"). The scope artifacts are already at a maturity where the
only open technical risks are demo-reproducibility and part-level density, not correctness — a
good place to be pre-content. Re-review after CORE is locked and the first `.qmd` + `_brand.yml`
land, targeting: brand.yml install path (P1-2), a Typst-format citation smoke test (P1-5), and
the publishing segment's DEMO-vs-hands-on boundary (P1-3).

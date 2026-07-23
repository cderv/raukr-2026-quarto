# Technique review — house-voice sweep (2026-07-23)

**Reviewer:** workshop-reviewer-technique
**Reference commit:** `b9ccc53` (HEAD)
**Baseline for the delta:** `3c87b80` (pre-sweep — "Document the exercises-delivery model")
**Toolchain:** Quarto `1.9.38` (`quarto --version`), R 4.6.x in the sandbox
**Scope this cycle:** the full house-voice sweep (`2a1145a..b9ccc53`) — em-dash asides → colon /
parenthesis / split, semicolons removed, voice-over interjections cut, idiomatic English scrubbed
(prose everywhere + idioms-only in the decks' `::: notes`). Files touched: `setup.qmd`, both decks,
both labs, the shipped Day-1 demo files (`penguins-by-species.qmd`, `sample-typst.qmd`), and their
`exercises/` mirrors.

**Primary question:** did any reword change what a sentence technically *asserts*?

---

## Overall verdict

**Clean pass — the sweep is technically inert.** I read every prose hunk in the `3c87b80..HEAD`
diff across all nine content files (~240 changed lines) with one question in mind: does a
colon/paren/split re-scope a clause, drop a load-bearing word, over/under-state a claim, or alter a
code/label/path/YAML token? **None do.** Every conversion preserves meaning; every technical claim
that got repunctuated (article-layout formats, `output-location: column` is slide-only, `cache` vs
`freeze` semantics, `freeze: auto`/`true` behaviour, parameters-need-defaults, Typst-bundled-in-1.9,
per-page vs project-wide cross-references) still reads true. No inline code, cross-ref label, path,
or YAML key was collateral-damaged. Two smoke renders (Day-1 lab, Day-2 lab) exit 0 against the
versioned `_freeze/`; the `exercises/` payload is byte-identical to its `labs/` source. One cosmetic
artifact only (a stray double blank line). **0 P0 / 0 P1 / 1 trivial P2.**

---

## 🔴 P0 — blocking technical bug

None.

---

## 🟠 P1 — fix before the event

None.

---

## 🟡 P2 — nice-to-have / robustness

**P2-1 — Stray double blank line in the Day-2 deck (`slides/quarto-projects/index.qmd:173-176`).**
The sweep left two consecutive blank lines before the `. . .` fragment marker on the
Cross-references slide:
```
173: on Day 1. (Section headings work the same way with `@sec-`.)
174:
175:
176: . . .
```
Pandoc collapses consecutive blank lines, so this has **no render effect** (the Day-2 deck renders
clean, no overflow change) — it is purely a source-tidiness nit introduced by the sweep. Drop one
blank line when convenient. Non-blocking.

---

## ✅ Technical choices validated

**The reword-preserves-assertion checks (the core of this cycle) — all pass.** Spot-checks of the
edits most at risk of a scope shift:

- **`setup.qmd:167-169`** — *"The one command that proves the toolchain — including the knitr
  engine (…) — is `quarto check`"* → *"…is `quarto check`. It covers the knitr engine too (…)"*.
  The `quarto check`-covers-knitr claim survives the split intact. Same for the `R < 4.5` fallback,
  the `use_course()` walkthrough (Desktop-by-default, keep-the-ZIP reset, day-folder-not-top-folder),
  and the renv "activates only from the top folder" clause — all meaning-preserved.
- **`slides/quarto/index.qmd:315-317`** — *"The article-layout model — in the paged document
  formats (HTML, LaTeX, Typst) — places content in the body, the margin, or a zone wider than the
  body"* → *"…puts content in the body, the margin, or a zone wider than the body (in the paged
  formats: HTML, LaTeX, Typst)"*. The format qualifier still binds to the whole model. Correct
  against [Article Layout](https://quarto.org/docs/authoring/article-layout.html).
- **`slides/quarto/index.qmd:220-221`** — *"`#| output-location: column` is slide-only: a revealjs
  placement, not article layout."* Factual claim intact and true (output-location is a revealjs
  feature).
- **`slides/quarto-projects/index.qmd:275-282`** — the `cache` (engine, per-cell, single-document)
  vs `freeze` (Quarto, project-only, `_freeze/`, CI-without-R) contrast is the highest-risk technical
  passage in the sweep. Every distinction is preserved verbatim through the colon/split conversions;
  `freeze: auto` = "re-execute a document only when its source changes" and `freeze: true` =
  "never runs R on a project build" both survive. Matches
  [Freeze](https://quarto.org/docs/projects/code-execution.html#freeze).
- **`labs/quarto/index.qmd:67-68`** — Task 2's *"then — in the prose, outside the cell — refer to
  it with `@fig-bill`"* → *"then refer to it with `@fig-bill` in the prose, outside the cell"*. The
  "outside the cell" constraint still attaches to the reference, not to the plot. All exercise
  tokens intact: `@fig-bill` / `@tbl-summary` / `@eq-ratio`, `#| label:`, `#| column: margin`,
  `-P species:` colon form.
- **`labs/quarto-projects/index.qmd`** — the freeze "see the skip" walkthrough, the within-page vs
  across-page cross-ref stretch (`@tbl-means`), and the troubleshooting box all keep their claims;
  the `#| fig-cap:` and `#| code-summary:` strings that gained a colon are **double-quoted**, so no
  YAML parse risk (Day-2 lab renders exit 0).
- **`labs/quarto/sample-typst.qmd:81` / `penguins-by-species.qmd:19`** — the `{r} params$species`
  braced inline and the `[@gorman2014]`/`[@horst2020]` cites are untouched by the surrounding
  reword; the "does bill shape tell the species apart? — and render…" → "…apart? We render…" split
  preserves the question-then-answer structure.

**Notes edits (idioms-only) are factually safe.** *"wants to level up"* → *"wants to go further"*,
*"it's not the lead in 2026"* → *"Typst is what we use in 2026"*, *"helpers are roaming/up"* →
*"helpers are around"*, *"you landed a clean HTML doc"* → *"you built…"* — register changes only,
no delivery instruction altered.

**Build integrity.**
- `quarto render labs/quarto-projects/index.qmd` and `quarto render labs/quarto/index.qmd` → **exit 0**,
  freeze honored, no compute errors.
- `_freeze/` for all six executable files was refreshed inside the sweep commits — freeze is in sync
  with the reworded prose (the freeze `markdown` field carries the new copy; content `hash` unchanged).
- The post-render `_freeze/*.json` "modification" I saw was a **`sessionInfo()` locale artifact only**
  (committed under `locale: C`, my render used `LANG=C.UTF-8` → `LC_CTYPE=C.UTF-8` line differs) —
  not content drift, not sweep-caused. Restored the files; repo clean.
- **No drift:** `exercises/day1-intro/penguins-by-species.qmd` and `…/sample-typst.qmd` are
  byte-identical to their `labs/quarto/` sources (drift-guard green).

**No format/multi-format regressions.** The sweep touched prose and notes only — no `format:` key,
render-list entry, `_brand.yml`, or shortcode was modified. Website pages stay `format: html`, slides
`format: revealjs`; the `## Demos (if time) {#demos}` heading retitle keeps its explicit `#demos`
anchor intact.

---

## 📝 Evolution since the previous review

The prior technique cycles (2026-07-22 params, 2026-07-22 delivery, 2026-07-23 labrun gate) left the
arc content-complete, render-verified, and delivery-validated from a real `use_course()` unpack. This
sweep is a **presentation-layer pass with zero technical surface area**: it changed how sentences
read, not what they claim. The one risk a voice sweep carries — a punctuation edit silently mangling
a technical assertion — did **not** materialize anywhere in the ~240 changed lines. The house-voice
rule (colon/paren/split over em-dash, no semicolons, no idioms) is now applied consistently across
every participant-facing surface without collateral to code, labels, paths, YAML, or the freeze/
exercises invariants. Settled decisions (use_course delivery, the parameterized bonus, the setup
walkthrough, the watch-me publish demo, scope/running-order) were not re-litigated and remain intact.

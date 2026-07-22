# Pedagogue review — 2026-07-21 (fixverify)

**Scope:** verification pass on the 2026-07-20 fix batch (delta `6a910a5..356e840`), not a fresh
audit. Files: `slides/quarto/index.qmd`, `slides/quarto-projects/index.qmd`,
`labs/quarto-projects/index.qmd`, `labs/quarto/starter.qmd`, `labs/quarto/penguins-report.qmd`,
`setup.qmd`. Reference commit: 356e840. Dispositioned 2026-07-20 items not re-flagged.

## Overall verdict

The fix batch landed pedagogically sound. The braced inline-code migration *improves* the Day-1
teaching sequence (the old slide literally displayed `knitr::inline_expr(...)`; the new
source-then-rendered reveal makes literal-vs-executed genuinely demonstrable), the freeze arc
(concept → workflow → lab) still hangs together with an observable pass/fail in the lab, and no
Day-1↔Day-2 callback or teaser pairing was broken — the Day-1 outcome trim was even mirrored
symmetrically in the wrap-up. One residual P1: the "sane default" wording the freeze fix was meant
to remove survives in the on-slide YAML comment (and a presenter note) on the very slide whose prose
was fixed. Otherwise ready.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

1. **`freeze: auto` "default" claim survives in the code comment on the fixed slide** —
   `slides/quarto-projects/index.qmd:285` displays
   `freeze: auto        # re-execute a document only when its source changes (the sane default)`
   while the prose directly below (`:288`) now correctly says "the sane setting to adopt". The
   learner-visible comment re-asserts exactly the misreading the 2026-07-20 P1 removed (auto is
   *not* Quarto's default), and prose + code on one slide now send mixed messages — the code
   comment is what learners copy. Same residue in the presenter note `:332` ("the sane default,
   what the lab sets"), which risks the presenter *saying* "default". Note the lab's equivalent
   comment was correctly reworded (`labs/quarto-projects/index.qmd:155` — no "default"), so the
   residue is slide-only. Two-word fix: e.g. "(the sane setting)".

## 🟡 P2 — nice-to-have

1. **CI gloss lands one slide after the deck's first on-slide use.** The parenthetical gloss
   "*(the automated build that runs on every push)*" sits at `#freeze-workflow`
   (`slides/quarto-projects/index.qmd:316`), but the cohort first *reads* "CI" unglossed on the
   Day-1 teaser (`slides/quarto/index.qmd:406`) and on Day-2 `#freeze` (`slides/quarto-projects/index.qmd:277`).
   Mitigated: the `#freeze` presenter note `:296` scripts the spoken gloss at that first Day-2
   mention, and this audience largely knows the term. If touched, move the parenthetical to `:277`
   (first Day-2 use) rather than adding weight to the Day-1 one-line teaser.
2. **`freeze: true` gets two nicknames.** Lab hint calls it "the CI mode"
   (`labs/quarto-projects/index.qmd:181`); the deck's presenter note calls it "the power-user /
   team mode" (`slides/quarto-projects/index.qmd:333`). Harmless, but one consistent handle
   ("the CI mode") would retain better across slide → lab.

## ✅ Pedagogical strengths confirmed (fixes verified as landed)

- **Inline-code sequence is coherent and improved** — the braced form is previewed in the
  `#anatomy` walkthrough (`slides/quarto/index.qmd:154`, line 6 of the `code-line-numbers` reveal),
  named as a delta at `#markdown-content:188`, then taught at `#inline-code:291-305`: a literal
  source block (`:296`, double-brace escape) followed by a `. . .` fragment showing the executed
  result (`:301`). Frozen output verified: the teaching sites render *literal* `{r} nrow(penguins)`
  where syntax is taught and **342** where the value is meant — the exact literal-vs-executed
  distinction, demonstrated rather than described. Escape mechanics (`{{r}}`) stay authoring-side,
  invisible to learners. Labs match what the slides teach (`labs/quarto/starter.qmd:29-30`,
  `labs/quarto/penguins-report.qmd:33-34`, both re-frozen and executing correctly), so participants
  opening the starter see the same syntax in source.
- **Freeze arc intact** — `#freeze` (auto, cache-vs-freeze contrast, `:263-298`) →
  `#freeze-workflow` (true, `:300-335`) → lab Ship-it Challenge with an *observable* pass/fail
  (the `Sys.time()` frozen-timestamp tell, `labs/quarto-projects/index.qmd:157-174`) and a hint
  that self-corrects without the instructor (`:179-183`). The reworded prose (`:288`) still hands
  off cleanly to the `freeze: true` slide.
- **Reusability trims cost nothing pedagogically** — Day-1 outcome "lay a document out — page,
  margin, columns, panels" (`slides/quarto/index.qmd:40`) is punchier, matches direct-address
  guidance, and is mirrored *verbatim* in the wrap-up (`:657`) — the promise/close pair stayed in
  sync. "A collaborator who won't open R" (`slides/quarto-projects/index.qmd:418`) keeps the
  purpose framing while de-domain-locking it.
- **Multi-day sequencing unharmed** — bridge intact (`slides/quarto-projects/index.qmd:29-34`);
  freeze teaser/payoff pair still matched (`slides/quarto/index.qmd:406-407` ↔
  `slides/quarto-projects/index.qmd:269`); Day-2 outcome "within-page cross-references" (`:32`) is
  now *truthfully scoped* to what `#xrefs` (`:166-187`) actually teaches and consistent with the
  wrap-up (`:402`); the `_brand.yml` callback (`:196`) remains true against Day 1. The
  `analysis.qmd#sec-model` → `analysis.qmd` example (`:181`) now matches its own claim ("ordinary
  Markdown links") — one less copyable dead anchor.
- **Slide↔lab consistency win** — the lab's `_brand.yml` snippet in block form
  (`labs/quarto-projects/index.qmd:77-89`) now matches the Day-2 slide's block
  (`slides/quarto-projects/index.qmd:201-209`); one idiom, less transfer load.
- `setup.qmd:98` Wi-Fi fix: cosmetic, no pedagogical effect.

## 📝 Evolution since the previous review (2026-07-20 panel)

- **Improved:** the beginner-flagged inline-code display bug is not just fixed but upgraded — the
  slide now models the exact syntax participants will type, with a source→rendered reveal that
  teaches the executed-in-prose idea better than the old single-line version. Jargon load on the
  freeze/publish stretch is down ("hard-freeze" gone, "the runner" gone, CI glossed on-slide and in
  a spoken note).
- **Already good, still good:** the My/Our/Your rhythm markers, the freeze lab's visible-tell
  design, the fallback starting points ("nobody is stranded"), and the presenter notes carrying the
  cache-vs-freeze distinction were untouched by the batch.
- **Regression watch:** one — the incomplete "sane default" removal (P1 above), where the applied
  fix and the surviving code comment now disagree on the same slide. No other regressions;
  `labs/quarto/sample-typst.qmd`'s legacy inline form is the documented, dispositioned exception.

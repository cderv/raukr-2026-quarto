# Pedagogue review — house-voice sweep (2026-07-23)

Reference commit: b9ccc53. Scope this cycle: did the house-voice sweep (em-dash asides →
colon / parenthesis / split sentence, semicolons removed, voice-over and idioms cut) help or
hurt **learning**, plus any genuinely current pedagogy issues. Files swept: `setup.qmd`, both
decks (`slides/quarto`, `slides/quarto-projects`), both labs (`labs/quarto`,
`labs/quarto-projects`), the shipped Day-1 demo files, and (idioms only) the decks' `::: notes`.

## Overall verdict

The sweep helped more than it hurt. The dominant move — em-dash aside → an explicit connective
(`, so …`, `, which …`, `: …`) — repeatedly **adds** the causal or appositive signposting that
the em-dash only implied, so the logical spine of most slides and lab steps is now *more* visible,
not less (e.g. the Quarto value-prop line, the `freeze` explanation, the "two legs of
reproducibility" apposition). I found **no** case where a split sentence dropped a "why" the
learner needed to act, no colon-dump that reads as a list, and no mode-marker, callback, teaser,
or Learning-Outcomes/wrap-up frame damaged. The one real andragogic cost is the systematic removal
of the "nobody is stranded by the break" reassurance in three fall-behind callouts — the concrete
fallback path survives in every case, so this is a tone loss, not a scaffolding loss. Pedagogically
ready for the event.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

None. No sweep edit produced a true learning regression, and no pre-existing current issue rises
to blocking.

## 🟡 P2 — nice-to-have

- **"Nobody is stranded by the break" removed in all three fall-behind callouts**
  (`labs/quarto-projects/index.qmd:39`, `:114`; `labs/quarto/index.qmd:331`). The break is the
  moment a cohort diverges most, and that phrase tied the fallback (`solutions/day2/`,
  `starter.qmd`) explicitly to the break for the anxious learner who fell behind — an
  autonomy/feedback affordance, not just decoration. The functional escape hatch remains stated in
  every spot, so nothing is broken; consider restoring one brief reassurance at the single
  highest-stakes handoff (the Ship-it "Starting point", `labs/quarto-projects/index.qmd:112-114`)
  rather than all three. Low priority.

- **Task-2 emphasis relocated to sentence end** (`labs/quarto/index.qmd:260-261`). The scaffolding
  cue "**in the prose, outside the cell**" — which pre-empts the classic beginner mistake of
  putting `@fig-bill` *inside* the code cell — moved from a mid-sentence interruption (right before
  the action) to the tail of the sentence. Still bolded and present, so the cue survives; it is
  just slightly less prominent at the decision point. Leave as-is unless you happen to be editing
  that step.

- **Reassurance framings trimmed from setup** — "What it does, so nothing surprises you:" →
  "What it does:" (`setup.qmd:78`) and "Extra topics, if we have time:" → "Extra topics:" with the
  optionality now carried only by the slide title "Demos (if time)"
  (`slides/quarto-projects/index.qmd:475-477`). Both are fine: the substance (the numbered
  walk-through; the "if time" flag) is preserved elsewhere. Noted for completeness, no action needed.

## ✅ Pedagogical strengths confirmed

- **Connectives added, not lost.** The high-traffic teaching lines gained explicit logic:
  - Quarto value prop — `slides/quarto/index.qmd:524`: "…multiple languages**:** all from one
    plain-text `.qmd`" (colon now signals the payoff).
  - `freeze` definition — `slides/quarto-projects/index.qmd:394-398`: "**Project-only:** rendering
    one file always runs it" reads as explanation, cleaner than the old dash.
  - Two-legs apposition — `slides/quarto-projects/index.qmd:439`: "It doesn't pin **what produced
    them** (the package versions):" is crisp.
  - `type: website` → site — `slides/quarto-projects/index.qmd:275`: em-dash → "**, which** makes
    the folder a **site**" keeps the relative link the learner needs.
- **Layout slide is clearer after restructure.** `slides/quarto/index.qmd:593-596`: the paged-format
  parenthetical moved to the end so the core sentence ("the model puts content in body / margin /
  wide") is now uninterrupted — an improvement.
- **Mode-marker rhythm intact.** "Follow along" / "Your turn" / "Watch-me" / "Eyes up" callouts all
  survive (11 in Day-1 deck, 14 in Day-2); the "How today works" rhythm line kept the
  watch → follow along → your turn triad (just parenthesized).
- **Learning-Outcomes open / "What you can do now" close** preserved in both decks; the Day-1→Day-2
  bridge ("Yesterday: one `.qmd` → a branded PDF. Today, the other axis: **one file to many**",
  `slides/quarto-projects/index.qmd:191`) and the freeze teaser→payoff callback
  (`slides/quarto/index.qmd:658` teaser → `slides/quarto-projects/index.qmd:386` "Day 1 I teased
  **freeze**: here's the full story") remain true and in sync.
- **Setup "get the materials" reads better as imperatives.** `setup.qmd:89-91`: "Keep it (say
  **No**): it's your one-click reset" is a clearer instruction than the old dash-chained aside.

## 📝 Evolution since the previous review

- **Improved:** logical signposting on the busiest slides and lab steps is now explicit rather than
  implied; several interrupted sentences (layout model, get-the-materials, `use_course` intro) were
  reordered so the core statement lands before the qualifier. No new cognitive-load or sequencing
  problem introduced by the sweep.
- **Already good, held:** three-mode rhythm, transition callouts, LO/wrap-up frames, multi-day
  callbacks and the freeze teaser — all untouched or strengthened.
- **Minor regression:** the "nobody is stranded" break reassurance was dropped in all three
  fall-behind callouts (P2 above). It is a tone/affect loss for the learner who falls behind, not a
  loss of the actual fallback affordance, which is still spelled out each time.

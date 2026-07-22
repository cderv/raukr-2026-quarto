# Convention review — My/Our/Your turn vs RaukR house idioms (pedagogue)

**Date:** 2026-07-07
**Scope:** Focused learning-design decision, not a full material review. Question: is our
committed *My turn / Our turn / Your turn* slide-side convention the best-adapted choice for
these two 2h sessions, given the material folds back into the NBIS RaukR site?
**Evidence:** our refs + a throwaway clone of `NBISweden/raukr-2026@main` (59fe3f0) in scratchpad.

---

## Verdict

**Hybrid — keep the rhythm, drop the bespoke slide chrome, express intent through RaukR's own
native primitives.** The *My/Our/Your* rhythm is genuinely valuable, but its value is as a
**live-room facilitation signal and a running-order discipline**, not as a durable visual
convention on the slide surface. Our own docs already encode it exactly where it pays off — the
time budget and running-order rules in `topic-store.md`. The standing TODO to *invent* a bespoke
`.my-turn`/`.our-turn`/`.your-turn` slide-callout class (`project-context.md:154-156`) should be
**resolved by deciding not to build it**: a custom class needs our SCSS to render, looks foreign
dropped into the NBIS tree, and reads oddly on a self-paced website — all cost, little durable
payoff for an advanced audience. Adopt RaukR's `## Learning Outcomes` slide and lab-side
`## … Challenge` + collapsible-solution idioms for the learner-facing surface, and carry the
watch-vs-type signal with **built-in callouts** only. One caveat: their idiom set is *less
standardized than assumed* (Learning Outcomes in 3/13 decks, Challenge in 1/14 labs, the
canonical `slides/demo/` template has neither), so we have latitude and should pick the best of
both rather than treat either as a fixed standard.

---

## 🔴 Must change

**R1 — Resolve the "invent a bespoke mode-marker" TODO in the *negative*: do not build a custom
slide-callout class.**
`project-context.md:154-156` and `CLAUDE.md` (Authoring rules) both carry an open TODO to design
"our own mode-marker (My/Our/Your turn) slide-callout convention … RaukR has no slide-side
equivalent." Treat this review as the decision: **no bespoke class.** A custom `.your-turn` block
with its own SCSS is exactly the "breaks when a file is lifted" category the reuse panel already
flagged (`project-context.md:84-105`) — it makes the deck structurally foreign to the NBIS tree,
requires shipping/declaring extra styling, and a color-coded "now type" chrome is over-scaffolding
for an audience that reads `## … Challenge` and knows it's their turn. The mode signal is about
*room coordination* (don't head-down-type through a demo), not learner competence — and that signal
lives fine in `::: notes` + a plain callout, without new chrome.

## 🟠 Should change

**R2 — Adopt `## Learning Outcomes` as the objectives idiom, replacing our free-form
"By the end you'll be able to…".**
Our learner-framed-objectives principle (`workshop-pacing.md:63-64`) and RaukR's `## Learning
Outcomes` slide (`slides/tidyverse/index.qmd:21`; also `slides/vectorization/`, `slides/coding/`)
are the *same idea*. Use their heading and infinitive-verb list verbatim — zero integration cost,
satisfies our "promise up front" requirement, and looks native folded in. Keep our mirroring
**wrap-up** ("What you can do now", `workshop-pacing.md:60-62`) — it's plain markdown, RaukR has no
equivalent, and it's the one place our convention adds something theirs lacks. Note this pattern is
*not universal* upstream (3/13 decks; the canonical `slides/demo/index.qmd` has none), so we're
adopting a good-but-optional RaukR pattern, not conforming to a mandate.

**R3 — Carry "Your turn" lab-side as `## … Challenge` + `::: {.callout-tip collapse="true"}`
solutions.**
This is the strongest native equivalent to our timed independent exercise and matches our own
authoring rules (`project-context.md:137-142`, house-style § Labs). It exists in exactly one lab
upstream (`labs/tidyverse/index.qmd:334,765,925,1128`, with the scope `callout-note` at
`:25` and collapsible hint/solution at `:63`), but it's the right idiom and bioinformatics-flavored
challenge naming ("Nanopore Channel Activity", "Species Identification") fits the room. **Caveat:
the two *quarto-specific* labs upstream are not challenge-based** — `labs/quarto/index.qmd` and
`labs/quarto-site/index.qmd` are linear follow-along showcases (`##` step headings +
`callout-note`, e.g. `labs/quarto-site/index.qmd:9,55,84,443`). So our 2:1-hands-on, timed-Challenge
model is *more active-learning-forward than the existing Quarto labs* — a genuine improvement to
contribute, not a deviation to apologize for.

**R4 — Express the live watch-vs-type signal with built-in callouts, not a new vocabulary.**
Keep the "announce the rhythm up front" beat (`workshop-pacing.md:56`) as one intro bullet + a
verbal cue, and mark the two live modes on the relevant slide with RaukR's *existing* callout
palette: a `::: {.callout-note}` "Follow along" for Our-turn demos, a `::: {.callout-tip}`
"Your turn — ~8 min" for the hand-off. Both are built-in Quarto callouts (used all over the NBIS
decks), render identically standalone and folded-in, and degrade gracefully to "here's an exercise"
when read self-paced on the site. This keeps the *pedagogical intent* of the three modes while
spending zero integration budget.

## 🟡 Optional

**R5 — Countdown timer is an extension dependency; decide deliberately.**
`workshop-pacing.md:13,57` want a countdown on each "Your turn". The usual implementation is the
`countdown` **extension** (`{{< countdown >}}`), which by our own fold-in rule
(`project-context.md:84-92`) must be `quarto add`-declared or it breaks in the NBIS tree. Cheapest
portable option: state the duration in the callout text ("~8 min") and run the timer presenter-side
(phone/room clock). Add the extension only if you want it on-slide, and declare it explicitly.

**R6 — Update `workshop-pacing.md` framing so "the three modes" reads as running-order +
facilitation discipline, not a slide-chrome spec.**
The section (`workshop-pacing.md:7-15,54-58`) is currently mode-forward and implies slide markers;
after this decision it should point to the native-primitive mapping (R2–R4) and to where the rhythm
actually lives — the per-part time budget (`topic-store.md:161-196`) and running-order rules
(`topic-store.md:199-228`), which already encode My/Our/Your correctly without any slide chrome.

---

## ✅ What's already right

- **The rhythm itself is sound and already correctly located.** `topic-store.md:161-196` bakes
  My/Our/Your into each part's minute budget, and `topic-store.md:199-228` rule 1 ("the 2nd part's
  payoff exercise is sacred", DEMOs after the payoff) is precisely the discipline the three-mode
  model exists to enforce. This is the *right* home for the convention — process, not slide chrome.
- **Learner-framed objectives + mirrored wrap-up** (`workshop-pacing.md:60-64`) is stronger than
  RaukR's practice: they have the opening `Learning Outcomes` slide (sometimes) but no closing
  "what you can do now" validation. Keep ours.
- **Fold-in instincts are already documented** (`project-context.md:76-114`): matching NBIS paths,
  built-in-shortcodes-only, co-located assets, project-level brand. A bespoke mode-marker would
  have quietly violated this — this review just closes the loop.
- **Lab solution/hint patterns** in our house-style (`project-context.md:137-143`) already mirror
  RaukR's `callout-tip collapse` idiom verbatim — nothing to change there.

---

## 📝 Evolution / notes for the record

- **New evidence vs the brief's premise.** The brief framed RaukR's idioms as a settled set the
  question was whether to *supplement*. In the clone they're markedly *less* standardized:
  `Learning Outcomes` in **3 of 13** decks, `Challenge` in **1 of 14** labs, and the canonical
  house-template deck `slides/demo/index.qmd` uses **neither**. Consequence: the choice isn't
  "conform vs deviate" — there's no rigid standard to conform to. We should adopt the *good*
  RaukR patterns (LO slide, Challenge/collapsible solution) and contribute our *stronger* ones
  (closing wrap-up, 2:1 timed hands-on) — a net upgrade to their Quarto labs, which are currently
  passive follow-alongs.
- **The genuine gap our convention fills** is narrow and live-only: the explicit "hands off,
  watch this" vs "now you drive" signal in the room. That's real, but it's a *facilitation* need
  met by `::: notes` + a built-in callout (R4), not a need for new visual vocabulary. So the
  correct disposition of the standing TODO is *close-as-wont-build*, not *design it*.
- **No regression** — no bespoke marker was ever built, so this is a pre-emptive decision that
  keeps the decks portable before the first deck locks the pattern in.

**Recommendation strength summary:** 1 🔴 (don't build the bespoke class), 4 🟠 (adopt LO slide /
Challenge idiom / built-in mode callouts / reframe the pacing doc), 2 🟡 (timer dependency, doc
tidy).

# Beginner review — delivery convention (My/Our/Your turn vs RaukR house style)

**Date:** 2026-07-07
**Reviewer persona:** advanced R user / life-science researcher, fluent tidyverse, occasional
R Markdown, dabbled in Quarto, never built a project. Reads English fine. Resents both
hand-holding and being lost.
**Focused question:** which convention actually helps me sit through the day.

## Overall verdict

Neither convention wins outright — the honest answer is a **hybrid**, and the split is not
50/50. RaukR's **lab** pattern ("Challenge" sections + collapsible hints/solutions) is exactly
right for my level and I would not change it. Where I genuinely get confused is on the *slides*
during live coding — and RaukR's house style has no signal there at all, so the "turn" idea is
solving a real problem. But the *planned* version over-solves it: a `My turn / Our turn / Your
turn` badge on **every** slide reads as being managed, and it invents a second vocabulary
("Your turn" on the deck vs "Challenge" in the lab) that I have to reconcile. Keep the markers,
but use them **only at the two transitions that are actually ambiguous**, and make the slide
word match the lab word.

## 🔴 Would actively hurt my experience

Nothing at this level rises to blocking — this is a convention choice, not a broken artifact.
The one thing that *would* hurt is described below as the top 🟠 (per-slide marker noise); it's
a real drag on an advanced audience but not a showstopper.

## 🟠 Would improve it

- **Don't stamp `My turn` on every presentation slide.** `workshop-pacing.md:11-13,56` frames
  the three modes as a per-slide badge ("markers on slides"). When you're just talking over a
  concept slide, a "My turn" badge is pure noise to me — of course it's your turn, you're
  presenting and my editor is closed. On an advanced audience this specific marker is the one
  that tips from "helpful signal" into "patronizing." **Drop the standing `My turn` marker;
  keep the badge only for the two transitions I actually can't infer** (see Q4 below).

- **Make the slide word and the lab word the same.** The plan says "Your turn"
  (`workshop-pacing.md:13`); RaukR's labs say "Challenge"
  (`labs/tidyverse/index.qmd:334,765,925,1128`). If a handoff slide says *"Your turn"* and I
  flip to the lab and it's headed *"NYC flights Challenge"*, I lose a beat wondering if these
  are the same activity. Pick one noun. Either the "Your turn" slide explicitly says *"→ open
  the lab, do the 'X Challenge'"*, or rename so the deck and the lab agree. This mismatch is
  small per instance but it's every single exercise.

- **Countdown timer: keep it, but frame it as a regroup clock, not a pressure clock.**
  `workshop-pacing.md:13,57` attaches a countdown to every "Your turn." A visible ticking timer
  is genuinely useful *as a room-coordination device* — it tells me when we'll all come back
  together so I don't sit in "is everyone still working or waiting on me?" limbo. But phrase it
  as *"we regroup in 7 min"* not as a stopwatch on my performance. For an audience that resents
  hand-holding, that framing is the difference between reassuring and stressful.

## 🟡 Minor

- **The "Our turn" cue is worth keeping but only needs establishing once.** In a live demo the
  *mode* is visually obvious (your screen switches to an editor). What is genuinely *not*
  obvious is: "do you want me typing this along right now, or just watching while you type and
  I'll get the file later?" A one-time convention — "when you see 'follow along', open your
  editor and type with me" — resolves that real ambiguity. Repeating the badge on every demo
  slide after that is redundant.

- **RaukR labs occasionally go open-ended** ("Use your imagination…",
  `labs/tidyverse/index.qmd:1130`). Fine for a self-paced tidyverse lab; for a Quarto
  *project* build (session 2), I'd want the "Challenge" to state what the finished thing should
  look like, since I've never built one and can't imagine the target. Not a convention flaw,
  but the convention won't rescue a vague task.

- **Inline `code-fold` solutions vs separate solution files.** `workshop-pacing.md:32` wants a
  separate `solution/` folder; RaukR folds the solution into the same lab doc
  (`labs/tidyverse/index.qmd:355,390`). As a participant I slightly prefer RaukR's inline
  fold — it's right there for self-check without hunting a second file. Flagging only because
  the two references disagree.

## ✅ What works for me

- **RaukR's "Challenge" + collapsible solution is the sweet spot for my level.** Tasks as a
  bullet list (`labs/tidyverse/index.qmd:338-352`) tell me exactly what to do; the
  `code-fold: true` solution (`:355`) lets me self-check without asking anyone. That's enough
  structure to never be stuck and enough freedom to not feel babied. Don't touch this.

- **Two escalation tiers — hint then solution — respect my time.**
  `::: {.callout-tip collapse="true"}` hints (`labs/tidyverse/index.qmd:63`) are separate from
  the folded full solution. I can peek at a nudge without spoiling the whole answer. Exactly
  the right amount of scaffolding.

- **The top-of-lab scope note sets the right tone.** `labs/tidyverse/index.qmd:25-31`: "Do not
  feel bad if you do not solve all the tasks… If in doubt: hints → google → TA." That single
  callout does more to keep me oriented and un-anxious than any per-slide badge would.

- **`Learning Outcomes` slide as the promise.** `slides/tidyverse/index.qmd:21` up front tells
  me what I'll be able to do. Pairs well with `workshop-pacing.md:63-64`'s learner-framed
  objectives — I like knowing the destination.

## Answers to the five questions

1. **"Your turn" marker + countdown — help or patronizing?** The *marker* helps: the
   watch→work transition is a real context switch and an explicit handoff slide is a clean
   signal. The *countdown* helps as a room-sync ("when do we regroup"), not as a personal
   stopwatch — frame accordingly. Neither is patronizing *if used only at the transition*. It
   becomes patronizing only if it's on every slide.

2. **Do I need an "Our turn" cue to know to type along?** The mode (demo vs talk) is obvious
   from the screen. What's *not* obvious is whether you want me typing *now* vs watching. So:
   establish the cue **once**, then trust me. A per-slide "Our turn" badge is unnecessary.

3. **Does "Challenge" + reveal-solution serve me?** Yes, better than anything on the slide
   side. Clear task list + hint tier + folded solution = I always know what to do and can
   self-check. My only ask is that project-build challenges state the target artifact
   explicitly, since I can't picture it.

4. **Minimum signal I genuinely need?** Exactly **two** unambiguous markers, at the two
   transitions I can't infer:
   - **watch → follow-along** (start of live coding): "open your editor, type with me."
   - **follow-along → solo** (start of exercise): "your turn / go to the Challenge, regroup in
     N min."
   The steady-state "My turn" is inferable and should carry no marker. RaukR's style delivers
   the solo transition implicitly (the lab is a physically separate document, so it's obvious
   I'm on my own) but gives **nothing** for the watch→follow-along switch — which is the one I
   most often get wrong. So the "turn" idea earns its place *there specifically*.

5. **Net preference?** **Hybrid, weighted toward RaukR:**
   - Labs: keep RaukR's convention wholesale — "Challenge" + `callout-tip collapse` hints +
     folded solutions + top scope note + Session block. No change.
   - Slides: announce the rhythm **once** up front (`workshop-pacing.md:56` — good), then show
     a mode marker **only** on the two transition slides, not on every slide. Make the solo
     marker point explicitly at the lab's "Challenge" so the vocabulary is one, not two. Keep
     the countdown as a "regroup in N min" clock.
   - Retire the standing `My turn` badge entirely.

## 📝 Evolution since previous review

n/a — first review of this convention question.

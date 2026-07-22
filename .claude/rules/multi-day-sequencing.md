---
paths:
  - slides/**/*.qmd
  - labs/**/*.qmd
---

# Rule — later days are follow-ups, not fresh starts

A multi-day (or multi-session) workshop runs for the **same people** across a
short gap. Every day after the first is a **follow-up**: it should *sound* like a
continuation — reminders and callbacks — not first-time framing. Re-teaching what
yesterday established wastes the opening minutes and reads as patronizing to an
audience that was in the room. This rule is the short list of moves; the pedagogy
sits in `workshop-pacing.md`, the house style in `project-context.md § Content
patterns`. When you **author** a later-day deck, apply these; when you **review**,
check for them.

Balance first: these are **reminders, not repetition for its own sake**. Only the
slides where an earlier day laid the foundation need a callback — steady-state,
genuinely-new content just proceeds. A callback on every slide is as bad as none.

## 1. Don't re-introduce — widen the scope

When a concept, file, or tool was taught on an earlier day, present it on a later
day as a **reminder that adds something**, never as a fresh intro. The tell of a
bad slide is an opening sentence that would read identically on Day 1.

- ✗ "A single `_brand.yml` at the root carries the palette to the site, slides, and plots."
- ✓ "You met `_brand.yml` yesterday — it branded your PDF. **Same file** here: it also styles the site + slides."

The learner already owns the noun; you're extending what it does, not defining it.

## 2. Trim recurring structural slides to a one-breath recap

Boilerplate that recurs every day — "How today works", the setup rhythm, the
My/Our/Your cadence — gets its **full** explanation on Day 1 only. On later days,
shrink it to a "same shape as yesterday" line that keeps just the load-bearing
part (e.g. the **Follow along** / **Your turn** callout reminder) and drops the
re-teach. The speaker note becomes *"quick recap, don't re-teach — they saw this
yesterday."*

## 3. Open with a bridge

The first content slide of a later day (typically `## Learning Outcomes`) should
**callback the prior day and position today** in one line, before the outcomes
list: *"Day 1: one `.qmd` → a branded PDF. Today, the other axis — one file to
many."* It orients returning learners and frames today as the next move in a
sequence, not a standalone session.

## 4. Pay off the teasers — and keep both ends in sync

If an earlier day explicitly deferred something (*"…that's the Day 2 story"*), the
later day must pick up **that exact thread**: *"Day 1 I teased **freeze** — here's
the full story."* The teaser and its payoff are a matched pair: if you cut, move,
or reword one, fix the other in the same change, or a promise is left dangling (or
a payoff lands with no setup).

## 5. Verify the callback is true before you write it

A false callback ("you saw X yesterday" when Day 1 never covered X) is worse than
no callback — it makes a returning learner doubt their memory. Before asserting
what an earlier day taught, **check the earlier deck** (`grep` the other
`index.qmd`). This cuts both ways: if you remove a topic from Day 1, grep the later
decks for callbacks that now point at nothing.

## 6. Put the "don't re-teach" cue in the speaker notes

The reframed slide body is terse by design, so the discipline that keeps it terse
lives in `::: notes` — a **Callback:** / **Quick recap:** line that tells presenter
(and future author) *they built this yesterday; widen the scope, don't re-derive
it.* Without the note, the next editing pass tends to "helpfully" re-expand the
slide back into a first-time explanation.

## 7. The repeat often originates on the *earlier* day — narrow the setup

When a later slide reads like a repeat, don't assume the later slide is the thing to
fix. Check whether the **earlier** day **over-claimed** — asserted a scope it can't
even demonstrate yet (Day 1 "one `_brand.yml` themes the whole **site** and
**slides**" when Day 1 only *builds a single PDF*). That over-claim pre-spends the
later day's payoff, so the later slide has nothing left but to echo it.

The fix is usually to **narrow the earlier day to what it actually builds**, turning
the pair into clean **setup → payoff**: Day 1 "this file branded the **PDF** you just
made"; Day N "the *same* file brands your whole **project**." Put the forward pointer
in the earlier day's *speaker notes* ("tomorrow: the whole project"), not its slide
body — the on-slide claim stays scoped to today, the note keeps the teaser/payoff a
matched pair (§4). Editing only the later slide, leaving the earlier over-claim in
place, just moves the duplication around.

## 8. Sweep the later deck against the earlier one — a discrete pass

Per-slide vigilance while authoring (§1–§7) is not enough; run an explicit
**cross-day dedup sweep** as its own review, ideally each time a later deck changes
substantially. For every content slide in the later deck, grep the earlier deck for
the same concept/file/syntax and classify:

- **REPEAT** — re-teaches from scratch; opening sentence would read identically to a
  learner who skipped the earlier day. Rewrite as a widen (§1) or narrow the earlier
  day (§7).
- **PARTIAL** — mostly a widen but contains one re-teach sentence, or re-defines a
  term the earlier day owns; cut/trim that sentence, add the missing `::: notes` cue (§6).
- **CLEAN** — genuinely new, or already a proper widen/callback.

Run it **both directions**: also confirm every "you saw X yesterday" callback is
*true* against the earlier deck (§5) — a false callback (claiming the earlier day
taught something it didn't, e.g. listing `@sec-` among "the refs from Day 1" when only
`@fig-`/`@tbl-`/`@eq-` were taught) is a REPEAT-class defect in reverse. A fresh agent
holding both decks at once catches cross-references a slide-at-a-time author misses.

## 9. Labs are different — hunt *duplication*, not repetition

§1–§8 assume any re-teach is waste. That is a **slides** rule. In a **lab**,
re-practicing an owned skill builds fluency, so repetition is often the *point* of a
follow-up lab — the failure mode narrows to **duplication**: the *same task for the
same outcome with no new dimension*, which burns limited bench time for nothing.

Apply the test per exercise/step: **same task + same outcome = duplication** (cut or
reframe); **same skill + new context/scale = beneficial rep** (keep). The catch: a
beneficial rep whose new dimension is *invisible to the participant* reads as
duplication on the bench — fix it by naming the added dimension **on the step itself**.
A Day-1 cross-ref redone on a website shouldn't say "add a cross-reference"; it should
say "it still resolves *because both live on one page*" — turning a stray rep into an
on-purpose within-vs-across demonstration. The cleanest structural defense is to **ship
the earlier-day content pre-authored** (a `starter/` set of pages) so every participant
action lands on the new day's layer instead of re-authoring what they already own.

When you run the sweep (§8) over labs, classify with this lens —
**duplication / beneficial-rep / clean-new**, not repeat/partial/clean.

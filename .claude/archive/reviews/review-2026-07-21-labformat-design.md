# Lab format — information-design / visual-editorial review

**Date:** 2026-07-21
**Lens:** how the page *reads* — visual rhythm, callout color semantics, emphasis economy, TOC hierarchy.
**Decision framed:** keep our callout-heavy "Challenge" format, adopt NBIS long-prose, or hybrid.
**Files read:** `labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd` (OURS);
NBIS-2026 `labs/quarto/index.qmd`, `labs/quarto-site/index.qmd`; NBIS-2025 spot-check (≈ 2026, confirmed).

---

## 1. What the eye actually does on each page

**OURS — a worksheet built from stacked boxes.** Each challenge runs a fixed template the eye learns
fast: light `>` **Goal** blockquote → blue **Tasks** box → blue **You should see** box → gold
collapsed **Hint** bar → folded solution. The rhythm is genuinely scannable *once you know it* — a
returning reader can jump to "the blue box is what I do." But the density is front-loaded and
mono-color. Two structural hotspots:

- **`quarto-projects/index.qmd:19-50`** is the single worst "wall of boxes" in the set: the page
  opens on two full-width blue boxes stacked with nothing between them — **Scope** (19-31)
  immediately followed by **Starting point — a shipped set of pages** (33-50), 30 lines of solid
  blue *before the first heading or any plain prose*. The eye meets emphasis before it has any
  baseline to be emphasized against. Day-1 opens the same way, though softer (Scope note at
  `quarto/index.qmd:8-20` is the first thing on the page).
- **Tasks + You should see are always two consecutive blue boxes** (`quarto/index.qmd:52-79` then
  `81-87`; `quarto-projects/index.qmd:57-99` then `101-109`). Same fill, same icon, back-to-back —
  the color has stopped distinguishing them. The second box reads as a continuation of the first,
  not a different *kind* of information (do-this vs check-this).

**NBIS — a tutorial you read top to bottom.** Heading → prose paragraph → code-fence showing syntax
→ rendered result → prose → next heading, for 759 lines. It *breathes* through whitespace and a deep
heading cadence, and the show-syntax-then-show-result pairing is easy to follow linearly. But it is
overwhelmingly flat prose: **only ~4 callouts in 759 lines**, and the one thing a lab exists for —
the **Tasks** the participant performs — appears **once, at line 592**, a single low-contrast
`.callout` near the very bottom of a long read (`labs/quarto/index.qmd:592-599`). Nothing on the page
tells the eye "act here." The long YAML→Markdown→Images→Code→Tables→Plots run (`43-430`) is reference
material set as continuous reading; a participant can't see what to *try* versus *skim*.

**Verdict on rhythm:** for a **lab** (a thing you act from at a bench, half-attention, glancing up
from an editor) OURS is the right instrument — boxes are exactly how you signal "this is an action,
not narration." NBIS's format is right for a **reference/tutorial you read once**. The failure in
OURS is not *that* it boxes, it's that it boxes **too uniformly** — every spine element is the same
blue fill, so within a challenge nothing is emphasized *relative to* anything else.

## 2. Callout-type color semantics — do note vs tip carry meaning?

Mostly yes, and it's the strongest thing about our format. A real two-color system emerges and is
consistent enough for a reader to internalize:

- **blue `note` = the spine / mandatory path** — Scope, Tasks, You should see, Starting point.
- **gold `tip` = optional, pull-when-stuck** — "Coming from R Markdown?" aside, Hint — and these are
  `collapse="true"` (`quarto/index.qmd:35, 104, 216`), so they render as thin clickable bars, not
  full boxes. The collapse state reinforces the color semantic: gold = you may open this if you need
  it. That's good information design — the accent color and the interaction agree.

Two cracks in the system:

- **Troubleshooting breaks the gold rule.** It's a `tip` but rendered **open**, full-box
  (`quarto/index.qmd:252-272`, `quarto-projects/index.qmd:208-225`) — so "gold = collapsed optional"
  holds everywhere except the biggest gold box on the page. Either collapse it or accept gold has two
  meanings.
- **"You should see" is a third semantic wearing the spine's color.** It is neither an instruction
  nor a tip — it's a **checkpoint / expected-output** (verification). Coloring it the same blue as
  Tasks is what produces the twin-blue-box problem in §1. There is a latent third category here with
  no device of its own.

No `warning`/`important` (red/orange) is used — correct; there's no genuine-danger content (the Typst
`unknown font family` noise is handled calmly in prose and Troubleshooting, which is right — it's
reassurance, not alarm).

## 3. Emphasis economy — is the plain prose reading as skippable?

Yes, and it's inverted in one costly place. Because nearly everything substantive sits in a box, the
thin connective prose *between* boxes reads as throat-clearing you can skip. But look what's in that
demoted prose: **"a *reference, not a checklist*"** (`quarto/index.qmd:152-154`;
`quarto-projects/index.qmd:137-139`) — the single most important framing instruction for how to use
the solution folder, telling the participant not to treat the worked answer as a to-do list. It's in
skippable plain prose, while a routine "You should see… a numbered Figure 1" confirmation gets a
full-color box. **The emphasis hierarchy is upside down**: a nuance that changes behavior is quiet, a
checklist confirmation is loud. When every important thing is boxed, the un-boxed important things
disappear.

## 4. Hierarchy & the right-hand TOC

This is where NBIS is unambiguously better and OURS pays for putting everything in callouts.

- **Quarto excludes headings *inside* callouts from the page TOC** — the `## Tasks`, `## Hint`,
  `## Troubleshooting` are callout **titles**, not document sections. So OURS' entire TOC is **two
  entries per day**: "Authoring Challenge / Citations Challenge" (day 1), "Website Challenge / Ship
  it Challenge" (day 2). Clean, but almost useless for navigation — a participant mid-lab cannot jump
  to "the solution" or "troubleshooting"; those aren't in the map at all.
- **NBIS' TOC is a real outline** — Introduction, YAML, Markdown text, Images, Code, Tables, Plots,
  Export, Report, RevealJS, Projects (~11 entries). Because its structure is `##`/`###` headings, the
  right rail *is* a table of contents. That's the payoff of prose-with-headings.

So the two formats trade off cleanly: **callouts win the in-body "where do I act" scan; headings win
the right-rail "where am I / jump there" navigation.** OURS currently takes the first and forfeits the
second entirely. The "Challenge" H2 framing itself is good — motivational and it gives clean parallel
TOC entries — keep it; the problem is that *nothing below H2* reaches the TOC.

---

## Recommendation — **HYBRID: keep the boxes, thin the palette, restore the outline**

Our callout-driven "Challenge" format is the correct instrument for a bench lab and should stay. Do
**not** move to NBIS prose — for a *do* activity it buries the action. But trim the box density so
color means something again, and reintroduce heading structure so the TOC navigates. Concretely:

1. **Keep as full boxes (the spine, one strong blue per challenge):** the **Tasks** box only. This is
   the thing the participant acts from; it has earned the loudest emphasis on the page. Keep **Hints**
   exactly as they are — gold + `collapse="true"` is a model lightweight device; don't touch it.

2. **Demote "You should see" to a lighter device.** It's a checkpoint, not an instruction — it should
   not wear the same blue fill as Tasks. Switch it to `::: {.callout-note appearance="simple"}`
   (icon + left rule, no filled background) or a plain `>` blockquote. This alone kills the
   twin-blue-box wall at `quarto/index.qmd:52-87` and `quarto-projects/index.qmd:57-109` while keeping
   the "expected result" signal.

3. **Break the day-2 opening double-box** (`quarto-projects/index.qmd:19-50`). Let the page open on
   one or two lines of plain orienting prose (or a `>` lead), keep **Scope** as the single blue box,
   and demote **Starting point** to `appearance="simple"`. The reader should hit a baseline before
   hitting emphasis. Apply the same to the day-1 Scope open if you touch it.

4. **Promote Troubleshooting to a real `## Troubleshooting` section** (keep the tip styling *inside*
   if you like, or drop to `appearance="simple"`). It's the thing people scroll back to — it belongs
   in the TOC. This is the cheapest single win for navigation: it turns the 2-entry TOC into
   something a mid-lab reader can use.

5. **Rescue the demoted nuance.** Pull "*a reference, not a checklist*"
   (`quarto/index.qmd:152-154`) out of skippable prose — it's a behavior-changing instruction. Fold
   it into the Starting-point / solution-pointer box, or bold-lead it, so it isn't the one important
   sentence with no emphasis on a page where everything else is boxed.

**Net effect:** one loud blue box (Tasks) + one simple-appearance checkpoint + a collapsed gold hint
per challenge, plus a real `## Troubleshooting` in the TOC. Color regains meaning (solid-blue =
do-this, and it's now unique on the page), the walls come down, and the right rail becomes navigable —
without giving up the worksheet feel that makes ours a lab and not a tutorial.

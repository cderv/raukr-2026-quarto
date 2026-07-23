# Pedagogy review — "Quarto docs" margin pointers + collapsible solutions (delta)

- **Reviewer:** workshop-reviewer-pedagogue (andragogy lens)
- **Date:** 2026-07-23
- **Reference commit:** c7d97e3
- **Scope:** the branch delta only (commits `c6e703d..c7d97e3`) — per-challenge right-margin
  "Quarto docs" pointers, `toc-location: left`, collapsible `callout-note` solutions, Scope
  "run Setup" trims, minor wording. Both lab index pages
  (`labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd`). The rest was reviewed earlier
  the same day and is out of scope.

## Overall verdict

Pedagogically ready — ship it. The margin "Quarto docs" pointers land at exactly the right
altitude for self-directed adults: 1–2 canonical guide links per challenge, parked in a
peripheral channel (a margin float) that a stuck learner glances at without breaking task flow,
and clearly separated from the just-in-time `Hint` by both visual channel and altitude
(external reference vs task-specific nudge). Moving the TOC left is neutral-to-positive for
wayfinding (left nav is the more conventional position and is now consistent across both days),
and the collapsible solutions preserve productive struggle (collapsed by default, sitting below
the `Hint` rung). The Scope trim to "run the Setup page" is a clean hand-off — no start-line
context is actually lost, since the runnable setup cell still shows every `library()` call. No
P0/P1; two small in-room-support / affordance nice-to-haves below.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

None.

## 🟡 P2 — nice-to-have

- **The margin pointer's "reach for me when stuck" affordance is implicit.**
  `labs/quarto/index.qmd:60`, `:169`, `:283`; `labs/quarto-projects/index.qmd:54`, `:149`.
  The box reads `{{< fa book-open >}} Quarto docs` + links, with no when-to-use cue. For a
  confident learner that's clean and low-noise (correct call — resist adding prose). But it sits
  spatially parallel to the *Goal* at the top of each challenge, i.e. the least-stuck position,
  whereas the help a stuck learner reaches for (`Hint`, `Solution`) is at the bottom of the task
  flow. The float keeps it visible while scrolling, so this is minor — but if you ever want to
  close the loop, a single stuck-learner cue ("Stuck? read more:") would tie the margin into the
  help ladder without bloating it. Leaving it as-is is defensible.

- **Roaming helpers have no doc for the new help ladder.** Lab pages carry no `::: notes`, so the
  in-room support guidance (§8 of the review rubric) has nowhere to say that a stuck participant
  now has a four-rung ladder — margin **Quarto docs** (canonical reference) → **Hint** (collapse)
  → **Solution** (collapse) → **Troubleshooting** (collapse). Worth a line in whatever
  presenter/roaming-helper brief exists so helpers route learners consistently (nudge to the
  margin docs or Hint before revealing the Solution), rather than each helper improvising. Not a
  source change; a facilitation note.

- **Narrow-laptop reflow (awareness, not a fix).** On a narrow screen Quarto drops
  `.column-margin` content inline, so the "Quarto docs" box appears *between* the Goal and the
  Tasks callout. The pointers are one line each, so the interruption is negligible — but with
  `toc-location: left` also present, verify on a 1366-wide laptop that body + left TOC don't
  crowd the reading column during the lab. A quick fit-check on venue-typical hardware closes it.

## ✅ Pedagogical strengths confirmed

- **Right altitude, right dose.** Every challenge gets 1–2 links to the *canonical guide page*
  for that exact skill (Cross-references/Article-layout, Citations/Typst, Parameters, Websites/
  Brand, Freeze/Publishing) — never a link dump, never a generic "docs" catch-all. This scaffolds
  self-direction (the RaukR audience are experienced R users who *can* read docs) without turning
  the lab into a link farm.
- **Clean separation from the `Hint`.** The margin pointer (external, conceptual, always-visible)
  and the collapsible `Hint` (inline, task-specific, opt-in) occupy different visual channels and
  different altitudes. They complement rather than compete — good cognitive scaffolding, not
  redundant help.
- **Solution fidelity improved while struggle is preserved.** Real fenced YAML/bash/markdown in a
  collapsed `callout-note` reads as genuine copyable code (the old commented-out `eval: false`
  chunk read as "not the real thing"), yet stays collapsed-by-default below the `Hint` rung, so
  attempt-before-reveal is intact.
- **The Scope trim loses no start-line context.** "Before you start: run the Setup page" replaces
  an inline package list that was redundant with (a) the Setup page's `00-check-setup.R` and
  (b) the runnable setup cell that still names every library. DRY, and it lightens the very first
  thing a learner reads.
- **Consistent page furniture across days.** Both labs adopt the identical margin pattern and
  left TOC, so a returning Day-2 learner meets the same structure — a small multi-day-sequencing
  win (structural chrome stays put; only the content advances).
- **Quiet self-demonstration (Day 1).** The lab page teaches `.column-margin` (Authoring Task 4)
  while *using* `.column-margin` for its own docs pointers — the learner sees the feature working
  on the very page that teaches it. Incidental but nice.

## 📝 Evolution since the previous review (2026-07-23 voice cycle)

- **Improved:** solutions went from commented-out code inside an `eval: false` chunk to real
  fenced code in collapsible `callout-note` callouts — higher fidelity and copyability with the
  attempt-first gate preserved. New per-challenge margin docs add a layer of self-directed
  scaffolding that was previously absent. Scope callouts are lighter at the start line.
- **Already good, carried forward:** the `Goal:` blockquote opening every challenge (clear
  promise), the `Tasks` / `You should see` / `Hint` / `Troubleshooting` callout system, and the
  attempt-first solution discipline — all intact.
- **No regressions spotted.** The TOC move and margin additions don't disturb objectives, the
  challenge through-line, or the help ladder; the only residual items are the three P2 affordance/
  facilitation notes above.

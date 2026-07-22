# Status-confirmation review — pedagogue (whole two-day arc)

**Date:** 2026-07-12 · **Reviewer:** workshop-reviewer-pedagogue (status pass, not a build review)
**Scope:** Day 1 (`slides/quarto/index.qmd` + `labs/quarto/`) and Day 2
(`slides/quarto-projects/index.qmd` + `labs/quarto-projects/` incl. `starter/`, `solution/`,
`dashboard.qmd`), read as two delivered ~2h experiences.
**Structural fact that shapes this review:** per `project-context.md` § Event, each day is **two
1-hour parts with a ~1-hour gap** (13:30–14:30 + 15:30–16:30), *not* a continuous 2h. The "break"
between Part 1 and Part 2 is a full hour — a real re-entry seam, not a coffee pause.

---

## Overall verdict

**Confirmed pedagogically ready to deliver.** The bookends (Learning Outcomes open / "What you can
do now" close) and the mode-markers (Follow-along / Your-turn) are symmetric and complete across
**both** days; the safe-failure scaffolding (shipped starters, folded solutions, "nobody is
stranded by the break", troubleshooting callouts) is the strongest single feature of the arc; the
capstone-relevance thread and the two-axes through-line hold end to end. The running order fits two
1-hour parts with the sacred 30-min hands-on intact, and every part except Day-1 Part-2 has a
named cut-first beat. The one honest reservation — and it is exactly the user's stated worry — is
that the **presenter notes cover the framing and the Your-turn hand-offs but say nothing about the
live-demo beats themselves or the re-entry after the 1-hour gap**; the "Our turn" that the pacing
doc says *carries the teaching* is unscripted. That is a presenter-side gap, not a content defect,
and it is materially softened by the presenter being the material's author and a Quarto expert — so
I rank it P1 "close before the event" (cheap: a few `::: notes` lines), not blocking.

---

## 🔴 P0 — blocking for the event

**None.** No blocking pedagogical defect in either day.

---

## 🟠 P1 — fix before the event

### P1-1 · The live-demo ("Our turn") beats are unscripted, and there is no re-entry note after the 1-hour gap — this is the delivery-readiness gap the user flagged

The `::: notes` (8 on Day 1, 7 on Day 2 — confirmed by count) land on exactly two useful places:
the **framing** slides and the **Your-turn** slides (which carry good roaming-helper traps). What
they do **not** cover is the beat that the pacing doc says does the actual teaching:

- **Day 1** — the first "Follow along" is on *Markdown & content* (`slides/quarto/index.qmd:116`),
  and the entire live-build sequence that follows — *Figures* (`:137`), *Tables & math* (`:156`),
  *Callouts & inline code* (`:187`) — has **zero presenter notes**. The demo that builds the
  document live is improvised. Same shape on **Day 2**: *Websites* (`slides/quarto-projects/index.qmd:104`)
  and *Freeze* (`:225`) are the load-bearing live beats and carry no beat-sheet.
- **The 1-hour-gap re-entry is unscripted** (the standing "unscripted Part-1→break bridge" the
  Day-2 arc review deferred). Part 1 on both days **ends on the Your-turn slide** — there is no
  dedicated "recap Part 1 / here's where we left off" beat, and Part 2 opens cold: Day 1 straight
  into *Your manuscript path* (`slides/quarto/index.qmd:313`), Day 2 straight into *Why a project*
  with a Follow-along (`slides/quarto-projects/index.qmd:47`). After a **full hour away**, a room
  needs one orienting sentence ("before the break you landed an HTML doc; now we cite it"). The
  budget allots 5 min "recap + bridge" but it is not represented anywhere on the slide surface or
  in notes.

**Why it's P1 and not P2:** the user named this as a first-class worry, roaming **TAs** (present
per `project-context.md`) have nothing to follow during the ~15-18 min of live coding, and the fix
is genuinely cheap — a 3-4 line `::: notes` beat-sheet on each of the four live-demo slides ("type
this, name the delta, don't dwell") plus a one-line re-entry cue at the head of each Part 2.
**Why it's not P0:** the presenter *authored* this material and is a Quarto/Posit maintainer, so
for him the live path is not "blind"; the risk is TA support and a possibly ragged re-entry, not a
stalled demo.

---

## 🟡 P2 — nice-to-have

- **P2-1 · Day-1 Part-2 is the only part with no named cut-first beat.** Day-1 Part-1 names the
  *Positron* slide as trim-first (`slides/quarto/index.qmd:291`), Day-2 Part-1 names *Cross-refs*,
  Day-2 Part-2 names the *renv.lock* slide (`:273`). Day-1 Part-2 (five slides: manuscript path →
  citations → title block → Typst → brand) has no explicit shock-absorber. It's the lightest talk
  in the arc so overrun is unlikely, but for symmetry a one-liner in the *A real title block* notes
  (`:364`) naming it cut-first would complete the "name what gets cut" discipline the user asked to
  confirm.

- **P2-2 · Day-2 leans on Day-1 attendance without a fallback.** *Cross-references* says "exactly
  as on Day 1" (`slides/quarto-projects/index.qmd:148`) and the LO/close lean on "the same penguins
  work." For the same cohort across two consecutive afternoons this is a feature (continuity); if
  anyone joins on Day 2 only, the callback briefly excludes them. Almost certainly a non-issue
  (single residential cohort) — flag only, no change needed unless attendance is known to differ.

---

## ✅ Pedagogical strengths confirmed

- **Bookend symmetry — verified on both days.** `## Learning Outcomes` opens and `## What you can
  do now` mirrors it, with infinitive verbs and an explicit "By the end:" artifact promise
  (`slides/quarto/index.qmd:26,444`; `slides/quarto-projects/index.qmd:28,308`). The close mirrors
  the open point-for-point on both.
- **Mode-marker discipline — clean and symmetric.** Exactly 2 "Follow along" + 2 "Your turn —
  regroup" callouts per deck, one pair per part, each Your-turn naming the matching lab Challenge
  by the same words (Authoring/Citations; Website/Ship it). No per-slide badging, no bespoke class —
  the decided convention is honoured on both days.
- **Safe-failure scaffolding is the arc's best feature.** Every Part 2 opens from a shipped
  known-good artifact (`starter.qmd`; `starter/` + `solution/`), "nobody is stranded by the break"
  is stated at each hand-off, solutions are folded for on-the-spot self-check, and both labs close
  with a substantial Troubleshooting callout anticipating the real traps (YAML indentation, `?@`
  cross-ref failure, unbranded Typst fonts, freeze-didn't-skip). A participant who errs at step N
  can self-correct without flagging an instructor — the autonomy loop is genuinely closed.
- **Relevance signalling is domain-tuned, not generic.** The capstone thread runs through all four
  LO/close slides; the Freeze motivation is "don't re-run a 20-minute alignment"
  (`slides/quarto-projects/index.qmd:231`) — pitched precisely at bioinformaticians. This is
  andragogy done right for the audience.
- **Active-learning ratio holds at whole-arc scale.** 30 min hands-on per ~55-min part = ~55% of
  contact time is Your-turn; across the arc that's 4 × 30 = 120 min of hands-on. Matches the ~2:1
  target in `workshop-pacing.md`.
- **Through-line is visible and traced end to end.** Day 1 = one penguins file → HTML → cited →
  branded PDF; Day 2 = one file → project → website → published; the two axes are named explicitly
  at the Day-2 close (`slides/quarto-projects/index.qmd:318`). No orphaned concept.
- **Running order fits with a real pressure valve.** Day-1 Part-1 (12 content slides in ~18-20 min
  with an embedded live build) is the tightest spot in the arc, but the Positron slide is correctly
  pre-designated cut-first and the Execution+Positron fold already happened — confirmed workable,
  not overstuffed.

---

## 📝 Evolution since the previous review

- **Already good, still good:** every item the four prior arc/panel cycles fixed holds — the
  bookends, the named Day-2 shock-absorbers, the shipped starter/solution safety net, the freeze
  semantics wording (deck↔lab lock-step), the dead `solution/` site-link demotion. Nothing has
  regressed; the mode-marker and bookend symmetry is if anything cleaner than at the per-file
  reviews because both days now read as finished units.
- **What is genuinely unchanged (not a regression, a standing deferral):** the two presenter-script
  nuances the Day-2 arc review explicitly deferred — the **"unscripted Part-1→break bridge"** and
  the **your-turn-2 freeze-half weighting** — remain unaddressed. This status pass promotes the
  first of those (now understood against the **1-hour** inter-part gap) from "defensible deferral"
  to **P1-1**, because the user asked for an honest read of delivery readiness and because it also
  starves the roaming TAs of guidance during live coding. It is the single thing standing between
  "content-complete and arc-verified" (true) and "scripted for a confident live delivery" (not yet).
- **No new pedagogical risk introduced** by the Day-2 dashboard/whole-arc work; the Demos-if-time
  tail is correctly post-payoff and cut-able, with a presenter cue already on it.

---

### One-line summary
Verdict: **confirmed ready** — P0: 0 · P1: 1 (presenter notes cover framing + Your-turn but not the
live-demo beats or the 1-hour-gap re-entry — the user's flagged gap, cheap to close) · P2: 2.

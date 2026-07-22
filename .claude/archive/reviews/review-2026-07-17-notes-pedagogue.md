# Notes-cycle review — pedagogue (presenter `::: notes` across both decks)

**Date:** 2026-07-17 · **Reviewer:** workshop-reviewer-pedagogue (spoken-script pass)
**Baseline commit:** `99563e1` · **Scope tag:** `notes`
**Scope:** the `::: notes` blocks in `slides/quarto/index.qmd` (Day 1) and
`slides/quarto-projects/index.qmd` (Day 2), read as a delivery instrument for adult learners
across two 1-hour parts separated by a ~1-hour gap, with roaming TAs.

---

## Overall verdict

The spoken script has crossed from "framing-only" to a genuine delivery instrument, and prior
**P1-1 is substantially closed**: both Part-2 dividers now carry a single-sentence "Welcome back"
re-orientation (exactly the right dose after a full hour away), and the live beats on Day-1 Part-1
and *all* of Day 2 now carry Say/Do/trap beat-sheets that name the delta rather than describe
mechanics. The Helpers cues on the four Your-turn slides are domain-specific and genuinely usable by
a roaming TA, and timing/trim cues pace the presenter without over-scripting. **One real gap
remains**: the load-bearing Day-1 **Part-2 live-build sequence — Citations and Branding — has no
beat-sheet at all**, while the lighter slides around it (title block, Typst) do; that is the same
P1-1 pattern, closed everywhere except this one stretch. It is a cheap fix (two short beat-sheets)
and the only thing between "notes are delivery-ready" and "fully so."

---

## 🔴 P0 — blocking for the event

**None.**

---

## 🟠 P1 — fix before the event

### P1-1 (continuation) · Day-1 Part-2 live demo — Citations and Branding — is still unscripted

The beat-sheet remedy landed everywhere except the one place on Day 1 that most needs it. The
Part-2 "Follow along" opens on **Citations** (`slides/quarto/index.qmd:490`) and the live "make it a
paper" build runs Citations → title block → Typst → **Branding**. Of those:

- **Citations** (`slides/quarto/index.qmd:488`) — a live beat (add a `.bib`, cite with `@key`, watch
  the reference list render) with **no `::: notes`** at all.
- **Branding the PDF** (`slides/quarto/index.qmd:572`) — the live "add `_brand.yml`, re-render, the
  PDF changes colour/type" payoff — also **no `::: notes`**.

Meanwhile the two *less* load-bearing slides in the same run carry notes: the title block
(`:543`, a trim-first cue) and Typst (`:566`). So the presenter has a beat-sheet for the slide he's
told to *cut* but none for the two he's told to *demo*. This inverts the intent of the beat-sheet
polish, and it leaves the TAs with nothing to watch during the Part-2 follow-along — the exact
starvation P1-1 was about. Contrast the parallel Day-2 Part-2, where every live slide (Freeze
`:298`, and the Part-1 Websites `:169` / Brand `:238`) is covered.

**Fix (cheap):** a 3-line Do/Say beat-sheet on Citations (name the delta: "prose gets a real
in-text cite + an auto reference list") and on Branding ("one file, and the PDF restyles — this is
the payoff"), each with a one-line Helpers cue mirroring the Your-turn-2 traps already at `:607`
(`.bib` key must match `@key`; first Typst render needs network for Google fonts).

---

## 🟡 P2 — nice-to-have

- **P2-1 · The Figures beat-sheet asks for a 4th move against its own "one point per slide" rule.**
  `slides/quarto/index.qmd:221-226` scripts: add label+cap and render, say "becomes a numbered
  figure," name the `fig-`/`tbl-`/`eq-` prefix trap, *and* a dense final Do bullet on
  `output-location: column` with a parenthetical cross-warning to the Layouts slide. The Markdown
  note two slides earlier explicitly sets the discipline "One point per slide; don't polish plots"
  (`:194`). The output-location digression is a second teaching point on the busiest live slide of
  Part 1 (already the tightest budget in the arc). Consider demoting the `output-location` clarifier
  to a one-liner or moving it off this beat.

- **P2-2 · Two Day-1 concept slides carry no spoken cue while their peers do.** "Anatomy of a
  `.qmd`" (`:143`) and "One source → many formats" (`:338`) have no `::: notes`, whereas the
  neighbouring concept slides Layouts (`:332`) and Execution (`:398`) do. Both are self-carrying, so
  this is symmetry-only — a one-line "read-through, don't dwell" cue (or a trim marker on
  One-source, the densest of the two) would complete the set. No teaching gap.

---

## ✅ Pedagogical strengths confirmed

- **P1-1 re-entry seam — CLOSED and well-judged.** Both "Welcome back" notes are exactly one
  orienting sentence — Day 1 `:470` ("Before the break you landed a clean HTML penguins doc. Now we
  make it a *paper*…") and Day 2 `:266` ("…you built a branded, navigable site. Now we make its
  builds *reproducible*…"), each with an explicit "one-sentence recap only; don't re-teach Part 1."
  A room re-orients in a breath. This is the single hardest thing about a 1-hour-gap format and it
  is handled correctly on both days.
- **Beat-sheets carry the teaching, not the mechanics.** On Day-1 Part-1 and across Day 2, the Do
  lines name the *visible delta* ("render, show the auto-number appear" `:222`; "every code block
  disappears at once… just that one returns — the delta, made visible" `:400`; the cache-vs-freeze
  contrast protected as "the point of the slide" `:300`). That is teaching the transformation, not
  reciting syntax.
- **Helpers cues are usable and domain-tuned.** Every Your-turn hands-on slot gives a roaming TA a
  concrete first-thing-to-check: cross-ref prefix + duplicate labels (`:462`), `.bib`-key/`@key`
  match and first-render font fetch (`:608`), `output-dir` vs source-relative paths (`:258`), and
  the freeze "tell" — second render skips the slow cell (`:362`). Plus a live-coding Helpers cue on
  Websites (`:173`) and the "install.packages not pak" reminder on Brand (`:242`).
- **Timing/trim cues pace without over-scripting.** Trim-first beats are named per part (Positron
  `:443`, title block `:544`, Cross-refs implied, renv `:326`), the live build is budgeted
  ("~8–10 min total… one point per slide; don't polish plots" `:194`), and the Say lines are short
  anchors, not a full script — appropriate for an author-presenter.
- **Handoffs give the room a wall clock.** Both Part-1 Your-turn handoffs state the reconvene time
  ("back at 15:30" `:461`, `:257`), so participants can plan the hour, not just "~30 min."
- **Notes protect the presenter from reading reference aloud.** The genuinely non-spoken material is
  labelled as such — the Positron authoring note "(not spoken)" `:445`, the cross-page `@fig-`
  pre-flight "Keep that check off the slide" `:200` — so nothing on-script is dead weight during
  live delivery.

---

## 📝 Evolution since the previous review (2026-07-12 status-pedagogue)

- **P1-1 substantially closed.** The two components the prior cycle flagged — unscripted live-demo
  beats and an unscripted 1-hour-gap re-entry — are both addressed: re-entry fully (both dividers),
  live beats on Day-1 Part-1 and all of Day-2. This is the headline improvement and it is real.
- **Regression-watch / incomplete closure:** the beat-sheet rollout **missed Day-1 Part-2's two live
  slides** (Citations `:488`, Branding `:572`). Not a new defect and not a regression from a
  working state — it is the remaining tail of P1-1, carried above as the sole P1.
- **Prior P2-1 (Day-1 Part-2 had no named cut-first beat) — CLOSED.** The title block slide now
  carries an explicit "Part-2 trim-first… this is the slide to cut" (`:544`), completing the
  "name what gets cut" discipline across all four parts.
- **No over-scripting introduced at the framing/Your-turn level.** The Say/Do/Helpers/Timing marker
  system is consistent and legible; the only density concern is the single Figures slide (P2-1).

---

### One-line summary
Verdict: **notes are delivery-ready, one gap to close** — P0: 0 · P1: 1 (Day-1 Part-2 live
Citations + Branding still have no beat-sheet — the last unclosed tail of P1-1) · P2: 2. Re-entry
seam confirmed closed on both days.

# Plan — presenter-notes spoken-script polish (2026-07-17)

## Why
The presenter `::: notes` were drafted in `4ca2a05` (2026-07-12), *after* the review baseline
`88d48cf` that the pedagogue/language reviewers read — so pedagogue **P1-1** and language
**B1–B3 / A1** are effectively applied but the ledger still marks them "pending (author)", and
**no reviewer has ever assessed the drafted notes themselves**. This pass reads the notes as a
spoken script, tightens the blocks that are still authoring-rationale (not delivery cues), makes
the **Say/Do marker** discipline (B2) consistent across *all* note blocks, plain-languages the
residual jargon (B3 tail), then reconciles the bookkeeping.

## Scope (edits only to `::: notes`, no on-slide content)

### Day 1 — `slides/quarto/index.qmd`
- **`:419` Running & editing** — currently pure meta-commentary (past slide-reorg rationale, no
  say/do). Rewrite to a marked Say + Do beat; keep the ~18–20 min budget note as a parenthetical
  Timing cue.
- **`:436` Positron** — good Say line + Do cue buried alongside a screenshot-maintenance TODO that
  reads oddly mid-script. Restructure with Say/Do markers; demote the capture TODO to a clearly
  parenthetical authoring note.
- **`:82` What you can now build** — unmarked stage-direction (B2 named it). Mark it as a framing
  cue so it isn't mistaken for a line.
- **`:331` Layouts**, **`:561` Typst**, **`:59` How today works** — unmarked stage-directions;
  add markers for B2 consistency.
- **`:539` A real title block** — plain-language "shock-absorber" (B3 tail) → "trim-first".

### Day 2 — `slides/quarto-projects/index.qmd`
- **`:237` brand**, **`:198` cross-refs**, **`:51` How today works** — unmarked
  stage-directions/rationale; add markers for B2 consistency.

## Steps
1. Apply the note edits above.
2. `quarto render` both decks (freeze discipline — the check-freeze hook blocks commit on stale
   `_freeze/`); stage `_freeze/`.
3. Ledger: mark `review-2026-07-12-status-pedagogue.md` P1-1 and `-language.md` B1–B3/A1 as
   **applied** (point at `4ca2a05` for the draft + this pass for the polish).
4. Worklog: add a dated entry.
5. Commit + push to `claude/tutorial-feedback-kxyoh4`.

## Out of scope
On-slide content, new slides, the open Positron-screenshot capture (the tracker, local) and logo
assets (the tracker, deferred).

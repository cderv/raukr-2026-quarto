# Pedagogy review — RaukR 2026 Quarto (both days)

**Date:** 2026-07-20 · **Reviewer:** workshop-reviewer-pedagogue
**Reference commit:** `6a910a5` · **Scope:** whole repo, both days — learner-facing slides +
labs + presenter `::: notes`.
**Session frame:** two ~1h-×-2 afternoon slots for the **same** cohort (experienced R /
life-science, new to Quarto), roaming TAs, ~1h gap between the two parts of each day.
Files: `slides/quarto/index.qmd` + `labs/quarto/index.qmd` (Day 1);
`slides/quarto-projects/index.qmd` + `labs/quarto-projects/index.qmd` (Day 2).

---

## Overall verdict

Pedagogically ready. Both decks open with learner-framed `## Learning Outcomes` and close with a
mirrored "What you can do now"; the penguins through-line is visible end to end (one `.qmd` → branded
PDF on Day 1; one folder → published site on Day 2), and both tie explicitly to the team project. The
My/Our/Your rhythm is announced once up front and marked only at the two ambiguous transitions, as
intended. The **multi-day sequencing is genuinely clean** — the Day-2 opener bridges from Day 1, the
recurring "How today works" is trimmed to a one-breath recap, `_brand.yml` / `_metadata.yml` /
cross-refs are *widened* rather than re-introduced, and the freeze teaser→payoff pair is in sync. The
previous cycle's one open P1 (Day-1 Part-2 live Citations + Branding had no beat-sheet) is **closed**.
Remaining items are P2 symmetry/density nits; nothing blocks the event.

---

## 🔴 P0 — blocking for the event

**None.**

---

## 🟠 P1 — fix before the event

**None.** No blocking pedagogical defect found. Objectives/wrap mirror on both days, the
self-correction loop in the labs is strong, and the cross-day sweep turned up no false callback or
duplication.

---

## 🟡 P2 — nice-to-have

- **P2-1 (carried from 2026-07-17) · Figures beat-sheet asks a 4th move against its own
  "one point per slide" rule.** `slides/quarto/index.qmd:222-226` scripts add-label+render, "becomes
  a numbered figure," the `fig-`/`tbl-`/`eq-` prefix trap, *and* a dense `output-location: column`
  clarifier with a forward cross-warning to the Layouts slide — on the busiest live slide of Part 1,
  which itself set the discipline "one point per slide; don't polish plots" two slides earlier
  (`:195`). Consider demoting the `output-location` note to a one-liner. Still open.

- **P2-2 (carried from 2026-07-17) · Two Day-1 concept slides carry no spoken cue while their
  neighbours do.** "Anatomy of a `.qmd`" (`slides/quarto/index.qmd:144`) and "One source → many
  formats" (`:344`) have no `::: notes`, whereas the adjacent Layouts (`:319`) and Execution (`:406`)
  do. Symmetry-only — a one-line "read-through, don't dwell" (or a trim marker on the denser
  One-source) would complete the set. No teaching gap.

- **P2-3 · Day-1 Part 1 is a long single My/Our stretch — 15 content slides before the first
  "Your turn."** From `#what-quarto-is` (`slides/quarto/index.qmd:68`) to `#your-turn-1` (`:457`) the
  room watches/follows through ~15 slides before its first solo turn. This is a deliberate,
  arc-locked two-rounds-per-day design and the notes budget it (`~8–10 min live build`, trim cues on
  Math `:246`, Positron `:451`, Running `:433`), so it is not a defect — but it is the one place the
  deck runs longer than the ~5–10 min My-turn cycle the pacing guide favours. Worth a presenter's eye
  on the clock; no structural change needed.

- **P2-4 · Day-2 freeze beat is the densest conceptual moment — three neighbouring ideas.**
  `#freeze` (`slides/quarto-projects/index.qmd:263`) contrasts *cache* vs *freeze*, `#freeze-workflow`
  (`:300`) adds `freeze: true`, while the lab uses only `freeze: auto`. The split into two slides
  (per the recent fix) already manages this well and the notes name renv as first-to-drop and protect
  the cache-vs-freeze contrast as "the point." Flagging only so the presenter keeps `freeze: true`
  framed as watch/concept (it's not in the lab), not a fourth thing to type.

- **P2-5 · Day-2 outcome wording "with cross-references" slightly over-promises the lesson.**
  `slides/quarto-projects/index.qmd:32` lists "cross-references" among what they'll build into the
  website, but the actual teaching (`#xrefs`) is that cross-page refs do **not** auto-number — the
  within-page rep in the lab stretch is the only place they use one. The wrap-up phrasing "know why
  cross-page refs differ from a book" (`:401`) is the more accurate mirror. A one-word tighten on the
  outcome ("within-page cross-references") would make promise and payoff match exactly. Minor.

---

## ✅ Pedagogical strengths confirmed

- **Objectives ↔ wrap-up mirror on both days.** Delete everything but the H1 and you still know the
  promise: Day-1 outcomes (author / lay out / cite→branded PDF, `slides/quarto/index.qmd:35-43`) are
  reflected line-for-line in "What you can do now" (`:646-653`); Day-2 outcomes (structure / build+
  publish / explain freeze, `slides/quarto-projects/index.qmd:27-35`) mirror in the close (`:396-407`).
  Both closes land the "two axes → your team project" synthesis.

- **Multi-day sequencing is clean across the board.** The Day-2 opener is a proper bridge
  ("Yesterday: one `.qmd` → a branded PDF. Today, the other axis — one file to many,"
  `slides/quarto-projects/index.qmd:29`); "How today works" is trimmed to "Same shape as yesterday"
  with a don't-re-teach notes cue (`:43-53`); `_metadata.yml` (`:100-128`) and `_brand.yml`
  (`:194-236`) are *widened* from Day-1 nouns the learner already owns, each with a `Callback (don't
  re-teach)` notes cue. The freeze teaser (`slides/quarto/index.qmd:400` "That's the Day 2 story")
  pays off exactly (`slides/quarto-projects/index.qmd:269` "Day 1 I teased **freeze** — here's the
  full story"). No false callback survives the sweep.

- **Prior-fix verification held.** The `@sec-` line (`slides/quarto-projects/index.qmd:173`) now
  *introduces* section refs as "work the same way," not as a false Day-1 memory — clean. The Day-1
  `#brand` claim is correctly narrowed to the PDF it actually builds (`slides/quarto/index.qmd:596`)
  with the "tomorrow: whole project" forward-pointer living in the notes (`:628`), so the Day-1→Day-2
  brand pair reads as setup→payoff, not repeat. The Day-2 lab cross-ref stretch names its added
  dimension on the step ("within-page vs across-page rule concrete,"
  `labs/quarto-projects/index.qmd:87`) — a beneficial rep, not duplication.

- **Previous P1 (unscripted Day-1 Part-2 live demo) — CLOSED.** Citations
  (`slides/quarto/index.qmd:540-548`) and Branding (`:624-631`) now carry Do/Say/Helpers beat-sheets
  matching the rest of the arc; TAs are no longer starved during the Part-2 follow-along.

- **Self-correction loop is excellent.** Both labs pair a collapsed **Hint**, a folded
  **Solution**, a **"You should see"** success description, and a **Troubleshooting** list that
  anticipates the real traps (cross-ref prefix, `?@`/`[?]` markers, Typst font fetch, render-location
  / `cd starter/`). A participant who stalls at step N can self-correct without flagging an
  instructor — and the presenter Helpers cues give roaming TAs a concrete first-thing-to-check on
  every Your-turn slot.

- **Scaffolding keeps the load on Quarto, not R plumbing.** Day-1 Task 3 hands over the `gt`
  code and names the target as "the cross-reference mechanic" (`labs/quarto/index.qmd:58-64`); Day 2
  ships a pre-authored `starter/` set of pages so every participant action lands on the new layer
  (`labs/quarto-projects/index.qmd:31-48`) rather than re-authoring owned Day-1 content — the exact
  structural defense the multi-day rule recommends.

- **Re-entry seam across the ~1h gap handled on both days.** Each Part-2 divider carries one
  orienting "Welcome back" sentence with an explicit "don't re-teach Part 1" note
  (`slides/quarto/index.qmd:477-480`; `slides/quarto-projects/index.qmd:258-261`), and Part-1
  handoffs give a wall-clock reconvene time ("back at 15:30").

- **Direct address holds.** Slide titles name the topic ("Layouts: body, margin, and beyond,"
  "Freeze — don't re-run the slow stuff") and the body speaks to the participant in the imperative.
  The one "for a research audience" phrase (`slides/quarto/index.qmd:40`) refers to the *reader of the
  artifact* the learner produces, not the learner — legitimate, not detached third-person.

---

## 📝 Evolution since the previous review (2026-07-17 notes-pedagogue)

- **Closed:** the sole open P1 — Day-1 Part-2 live Citations + Branding now have beat-sheets
  (`slides/quarto/index.qmd:540`, `:624`). The beat-sheet discipline is now complete across all four
  parts.
- **Verified clean (fixes applied this cycle):** brand setup→payoff pair, `@sec-` introduce (not
  false callback), `#metadata` callback + don't-re-teach cue, Day-2 lab within-vs-across reframe,
  freeze split into `#freeze` + `#freeze-workflow`, publishing watch-me framing, "team project"
  vocabulary. All hold up under the cross-day sweep — no regression, no new duplication.
- **Still open (unchanged, both P2):** the Figures 4th-move density (P2-1) and the two note-less
  Day-1 concept slides (P2-2) carried from 2026-07-17 — neither is a teaching gap.
- **Net:** the material moved from "one gap to close" to "no blocking or must-fix pedagogical
  issues." Remaining items are polish.

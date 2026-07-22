# Review — Day-1 arc (pedagogue, arc-level pass)

- **Date:** 2026-07-07
- **Reviewer:** workshop-reviewer-pedagogue
- **Scope:** the *whole Day-1 arc as one ~2h teaching experience* — `slides/quarto/index.qmd`,
  `labs/quarto/index.qmd`, `labs/quarto/starter.qmd`, `labs/quarto/penguins-report.qmd`,
  `labs/quarto/sample-typst.qmd`. Reference commit `3c45287`.
- **Not in scope:** per-file defects already fixed in the WP1 (deck) and WP2 (lab) panels — see
  ledger dispositions. This pass reads the *seams and the through-line*, not each file again.

---

## Overall verdict

The Day-1 arc is **pedagogically coherent and event-ready as one continuous build.** The two
seams (Part-1 "Your turn" → Authoring Challenge, Part-2 "Your turn" → Citations Challenge) use
the *same vocabulary* the lab uses, land at the right moment, and drop nothing between slide and
lab. The "nobody stranded" story holds **end to end** — the deck advertises the Part-2 starter,
the lab points at `starter.qmd`, and the starter genuinely contains the exact sentence the
Citations task tells participants to edit (`starter.qmd:30`). One document identity (`fig-bill`,
the same setup incantation) runs through all five files, so a participant credibly feels *one*
penguins document grow deck → lab → cited HTML → branded Typst PDF. Learning Outcomes and "What
you can do now" mirror each other almost line-for-line. The residual items are polish, not
structure: one deck↔lab promise (layouts) overshoots what the lab practices, and the two worked
solutions deliver noticeably more than their challenges ask.

**Counts: 0 P0 · 1 P1 · 4 P2.**

---

## 🔴 P0 — blocking for the event

None.

---

## 🟠 P1 — fix before the event

### P1-1 · Deck promises "you'll build these" for 5 layout ideas; the lab practices only 1

`slides/quarto/index.qmd:207-218` teaches the full layout beat — `page-layout: article/full`,
margin content, outset/inset, multi-column, panels — and closes with
*"You'll build these live in the lab."* (`:218`). But the Authoring Challenge exercises **only
the margin** element (`labs/quarto/index.qmd:63`, task 4). Outset/inset, multi-column, panels and
`page-layout` appear in **no lab task and no solution file** (`starter.qmd`,
`penguins-report.qmd`, `sample-typst.qmd` all use margin only). For an audience for whom layout
was explicitly billed as high-value, that is 5 concepts taught and 1 reinforced, under a deck
line that promises all of them.

This is the one seam where the facilitator will feel a live mismatch ("you said we'd build
these"). Cheapest fix: soften the deck line to name what the lab actually does — e.g. *"You'll
use margin layout in the lab; the rest are yours to explore in the worked report."* — or add an
optional layout stretch task so the promise is honored. Margin (the signature manuscript win) is
correctly the one that gets hands-on, so the *choice* is right; only the wording over-commits.

---

## 🟡 P2 — nice-to-have

### P2-1 · Worked solutions over-deliver relative to their challenges (self-check friction)

`penguins-report.qmd` is pointed to as *"the complete worked document"* for the Authoring
Challenge (`labs/quarto/index.qmd:148`), but it carries substantial content **no task asked
for**: a fetched external culmen image (`penguins-report.qmd:67-69` — a network dependency and an
extra `@horst2020` citation), a `glimpse()` chunk, `{#sec-…}` section labels, `tab_spanner` and
`opt_stylize`. Likewise `sample-typst.qmd` is far more elaborate (a 30-line `brand_style()`,
`ggrepel`, `prismatic`, a raw `` `…`{=typst} `` highlight) than the Citations Challenge asks for
(set `format: typst`, render). A participant self-checking against these may think they missed
requirements. The Citations pointer softens this a little ("with R-side `theme_brand_*`
styling", `:232-233`) and troubleshooting flags the table-styling gap (`:249-250`), but the
**Authoring** pointer (`:148`) only flags the citations, not the culmen figure / `glimpse` /
`sec-` labels. One line — "*goes beyond the tasks; a reference, not a checklist*" — on both
pointers would set expectations. Not blocking: solutions richer than the ask is a defensible
choice for a "level up" audience, as long as it's named.

### P2-2 · "Capstone" transfer is named in the deck but absent from the lab

Running-order rule 6 asks the capstone transfer to be *named*. The deck does it well
(`slides/quarto/index.qmd:306` "your **capstone** write-up"; wrap-up `:436`). The lab never says
"capstone" — it says "the manuscript payoff" (`labs/quarto/index.qmd:152-153`). The deck carries
the frame, so this is not a defect, but a single clause in the lab Scope ("this is your
manuscript / capstone path") would close the loop where the *doing* happens, which is where
transfer sticks.

### P2-3 · Document titles drift across the five files (cosmetic through-line)

The same document wears four titles: deck anatomy example "A penguin story"
(`slides/quarto/index.qmd:96`) and title-block slide "Bill shape distinguishes Antarctic
penguins" (`:350`); `starter.qmd` "Penguin bill dimensions"; `penguins-report.qmd` "Bill
dimensions across Antarctic penguin species"; `sample-typst.qmd` "Bill shape distinguishes
Antarctic penguin species". The *theme* (bill shape separates species) is consistent and the
`fig-bill` identity is rock-solid, so the arc still reads as one document — but aligning the
starter/report/typst titles (or letting the title visibly "firm up" as the doc matures) would
make the single-artifact story even more tangible. Lowest priority.

### P2-4 · Whole-day timing — Part 1 breadth is the only load watch (already budget-fit)

Combined 2×~55 min is plausible. Part 2's My+Our (citations + title block + Typst + brand = 4
slides, `:308-409`) sits comfortably in its ~18-min window, and the lab's independent rebuild
(figure+table+margin+equation) does **not** re-teach the deck's live demo — it's a clean
My/Our → Your rebuild, no wasted double-coverage. The one arc-level pressure point is **Part 1's
concept breadth**: ~10 teaching slides feeding a ~15-min window, with live follow-along across
figures, tables, math, callouts and inline code (`:114-205`). This was already trimmed to fit
budget in WP1 (Execution+Positron merged) so I am **not re-flagging it** — only noting that at
the arc level Part 1, not Part 2, is where the clock will bite first. Discipline in the concept
demo, or moving math to a "show, don't type-along" beat, is the release valve if the room runs
slow.

---

## ✅ Pedagogical strengths confirmed (arc level)

- **Seam 1 is clean.** Deck Part-1 "Your turn" (`slides/quarto/index.qmd:279-283`) names the
  **Authoring Challenge** and the ~30-min regroup; the lab uses the same heading
  (`labs/quarto/index.qmd:44`) and the same ~30-min framing (`:11`). Content matches (figure /
  cross-ref table / margin), with the equation correctly held back as a *stretch* task.
- **Seam 2 is clean.** Deck Part-2 "Your turn" (`:411-417`) names the **Citations Challenge**,
  the **Part-2 starter**, and the **branded Typst PDF**; the lab echoes all three verbatim
  (`:151-192`). Same vocabulary, nothing dropped.
- **"Nobody stranded" holds end to end — and is checked, not asserted.** The deck flags the
  starter (`:296`); the lab's Starting-point callout points to `starter.qmd` and says "Nobody is
  stranded by the break" (`:156-161`); the starter is known-good (rendered to Typst PDF per the
  WP2 ledger); and the Citations task-2 instruction ("insert the citation before the period in
  *…Palmer Station, Antarctica.*", `:170-172`) matches an actual sentence in the starter
  (`starter.qmd:30`). A participant who skipped Part 1 lands on a *superset* of the minimal
  Authoring result, so they are never behind. This is the strongest part of the arc.
- **One artifact, credibly growing.** `fig-bill` is the same figure in the deck demo
  (`slides/quarto/index.qmd:142`), the lab, the starter, `penguins-report.qmd:76` and
  `sample-typst.qmd:121`; the setup incantation (`filter(!is.na(bill_len), !is.na(bill_dep))`)
  is byte-identical across all five files. The build deck → lab → cited HTML
  (`penguins-report.qmd`) → branded PDF (`sample-typst.qmd`) reads as one document changing its
  *output*, exactly as running-order rule 3 intends.
- **Bookending is tight.** Learning Outcomes (`:26-34`) and "What you can do now" (`:425-436`)
  mirror each other point-for-point (author natively · lay out · cite + title block · branded
  Typst PDF), and the close bridges cleanly to Day 2 ("grow one document into a whole project").
- **Supporting assets all resolve:** `references.bib` carries both `gorman2014` and `horst2020`,
  `apa.csl` and a root `_brand.yml` are present, and `penguins-report_files` is frozen — the
  citations→Typst payoff has everything it references.

---

## 📝 Evolution since the previous review

This is the **first arc-level pass**; prior pedagogue reviews were per-file (scope panel, then
WP1 deck, then WP2 lab — all ✅ applied, 0 P0). What the individual fixes bought, seen from the
arc:

- **Improved / now confirmed at the seam:** the "shipped starter" rule (WP1 P1, WP2 P1) has paid
  off — the between-parts handoff is not just present but *self-consistent* (the task edits a
  sentence that actually exists in the starter). The "name the Challenge" fix (WP1) means both
  Your-turn slides now point at labs by the exact heading. The pre-seeded `gt` skeleton and the
  *(stretch)* equation marker (WP2) keep the load on the Quarto target — visible now as clean
  alignment between what the deck demos and what the lab asks.
- **Already good, holds up:** the single-dataset / single-figure through-line (rule 3) and the
  Learning-Outcomes ↔ "What you can do now" mirror survive the arc read intact.
- **Possible regressions / new arc-only findings:** none structural. The two items that only
  surface when you read the files *together* — the layouts "you'll build these" over-promise
  (P1-1) and the solutions over-delivering vs their challenges (P2-1) — were invisible to
  single-file reviews because each file is internally fine; they are seam effects, now flagged.

# Review — Day-1 arc walkthrough (beginner / participant seat)

- **Date:** 2026-07-07
- **Reviewer:** workshop-reviewer-beginner (arc-level pass, not a per-file re-review)
- **Reference commit:** `3c45287` (clean tree)
- **Scope walked, in participant order:** `setup.qmd` → `slides/quarto/index.qmd` Part 1 →
  `labs/quarto/index.qmd` Authoring Challenge → (break) → deck Part 2 →
  Citations Challenge, using `labs/quarto/starter.qmd` as the fallback and
  `penguins-report.qmd` / `sample-typst.qmd` as the worked answers.
- **Rule honored:** the five files were reviewed/fixed individually already (ledger cycles WP1 +
  WP2). I did **not** re-flag anything that lives inside one file. Everything below is a **seam
  between files** or a **whole-day** observation.

---

## Overall verdict

The day genuinely reads as **one penguins document**, not four exercises — and the two hardest
seams (the "your turn → lab" handoffs and the 1-hour break between Part 1 and Part 2) are
handled on purpose and handled well. The single vocabulary holds (slide "Authoring Challenge" /
"Citations Challenge" == lab headings), the setup chunk is the same everywhere, the starter is a
true superset of what Part 1 produces, and the citation task even matches a sentence that already
exists in the starter. I would make it through the afternoon without getting lost. The only
seam that would actually mislead me is the **Layouts slide promising "you'll build these live in
the lab"** for a layout family the lab never asks me to build; the rest is polish.

**Counts: 0 P0 · 1 P1 · 4 P2.**

---

## 🔴 P0 — blocking for the event

None. Nothing in the arc stops a participant.

---

## 🟠 P1 — fix before the event

### P1-1 · The Layouts slide over-promises what the lab makes me do
`slides/quarto/index.qmd:207-218` teaches the whole article-layout family — page, **margin**,
**outset / inset**, **multi-column**, **panels** — and closes with:

> `slides/quarto/index.qmd:218` — "*You'll build these live in the lab.*"

But the lab only ever exercises **margin**:

> `labs/quarto/index.qmd:63` — "Put the species counts in the **margin** with the cell option
> `#| column: margin`."

Outset/inset, columns and panels never appear as a task, hint, or solution. As a participant who
found outset/inset the intriguing new thing, I go to the lab expecting to try them and there's
nothing. It doesn't *block* me (the lab's own task list is explicit and self-contained), but it's
a concrete "you'll do X" that X never happens — the exact kind of slide→lab seam this pass is
looking for. Note the *your-turn* slide is already honest (`:280-281` promises only "a figure, a
cross-referenced table, and margin layout"); it's the earlier Layouts slide that oversells.
Cheapest fix: change `:218` to something like "*You'll use the margin in the lab; the rest are
yours to reach for.*"

---

## 🟡 P2 — nice-to-have

### P2-1 · Starter already has an `author:`, but the Citations task tells me to "add" one
This only bites when you cross the gap on the starter. `labs/quarto/starter.qmd:4` ships:

```yaml
author: "Your name"          # ← replace with your own before rendering
```

Citations Challenge task 4 (`labs/quarto/index.qmd:180-185`) says "Give it a real **title
block**" and hands me a **list-form** `author:` to put in the header, with no note that the
starter already carries a scalar `author:` line:

```yaml
author:
  - name: Your Name
    affiliation: Your Lab, Your University
```

Following it literally leaves **two `author:` keys** in one YAML header. Best case Quarto takes
the last and it silently works; worst case it's a duplicate-key stumble the Troubleshooting box
(which only warns about indentation/quotes, `:235-253`) doesn't cover. One clause fixes it:
"**replace** the starter's `author:` line with a real title block:". The starter's own comment
("← replace with your own") hints at this, but the lab task doesn't echo it.

### P2-2 · The Part-2 follow-along assumes I have a Part-1 document open
`slides/quarto/index.qmd:310-312` (Citations, Follow-along):

> "Back in your editor — we add citations to the **Part-1 document**."

If I fell behind in Part 1, at this live-coding beat I have no Part-1 document to be "back in."
The starter is surfaced one slide earlier (`:295`, "the lab ships a Part-2 starter if you need
one") and again at your-turn-2, but not *here*, at the moment I'd want to type along. Minor —
Follow-along is watch-me — but a five-word nudge ("or open the lab's starter") at `:310` would
keep the behind-participant in the boat during the demo, not just at the exercise.

### P2-3 · The Typst one-liner is glossed near-verbatim in three of the five files
"a modern typesetting system that ships inside Quarto, so there is no LaTeX" recurs almost
word-for-word: `slides/quarto/index.qmd:361-363`, `penguins-report.qmd:13-14`,
`sample-typst.qmd:82` (plus the two deck teases at `:54` and `:32`). Inside the live arc (deck +
lab) it's fine — tease then reveal. Across the whole file set it's the one phrase that starts to
feel like it's being sold to me. Not worth touching the deck; if anything, vary the gloss in the
two worked-answer files so a participant re-reading all five at home doesn't hear the identical
sentence three times.

### P2-4 · No "learn more / where next" at the close
The arc lands its payoff cleanly (`:425-432` "What you can do now" + "Next (Day 2)"), but the
final slide (`:438-444`) is only "Questions? / Slides + lab: this site." For redoing this at home
there's no pointer to the Quarto docs, the citations/Typst pages, or `_brand.yml` reference. A
one-line "Learn more" (Quarto authoring + Typst + brand.yml docs) on the wrap-up or Thank-you
slide would give a returning participant a starting thread. Whole-day, after-the-fact — low
urgency.

---

## ✅ What reassures me (arc-level)

- **The break is engineered, not papered over.** `slides/quarto/index.qmd:295-296` ("the lab
  ships a Part-2 starter if you need one") and `labs/quarto/index.qmd:156-161` ("Nobody is
  stranded by the break") mean falling behind in Part 1 costs me nothing — I open `starter.qmd`
  and I'm exactly where a finisher is. The starter is a real superset of the Authoring Challenge
  output (same `fig-bill` / `tbl-summary` / `eq-ratio` / margin `counts`), so both paths converge.
- **The citation task matches the file it hands me.** Task 2 (`labs/quarto/index.qmd:170-172`)
  says "the starter already has the sentence '…collected at Palmer Station, Antarctica.'" — and it
  literally does (`starter.qmd:30-31`). Insert-before-the-period with a "don't paste a second copy"
  guard: exactly the kind of precision that saves the 5-minute fumble.
- **One vocabulary, both handoffs.** Slide "Authoring Challenge" / "Citations Challenge"
  (`:280`, `:414`) land on lab headings of the identical name (`:44`, `:151`); "regroup in ~30
  min" matches the lab's "~30-minute part" (`:12`). No word-swap jolt at either seam.
- **The setup chunk is the same object all day** — deck follow-along (`:121-127`), lab
  (`:21-30`), starter (`:15-25`), worked report (`:18-29`): same three libraries, same
  `data(penguins)` + `filter(!is.na(...))`. It reads as *the one document*, not a fresh start each
  time. Repetition here is continuity, not drag.
- **The single story is legible end to end:** Learning Outcomes promise "one penguins document
  carried all the way to a submittable, branded PDF" (`:34`), and `sample-typst.qmd` is visibly
  that same figure/table "now in a branded PDF" (`:146-147`). Promise == delivery.

---

## 📝 Evolution since the previous review

This is the **first arc-level (whole-day) pass** — prior beginner reviews were per-file (WP1 deck,
WP2 lab + starter), so there's no earlier arc report to diff against. What the earlier fixes bought
the *arc* specifically:

- The WP2 "**Nobody is stranded by the break**" framing + shipped known-good `starter.qmd` is what
  makes the Part-1→Part-2 gap a non-event for me — the single biggest arc risk, already neutralized.
- Naming the second exercise "**Citations Challenge**" in both deck and lab (WP1 pedagogue fix)
  is why the two handoffs read with one vocabulary — no seam there anymore.
- The "**create it inside `labs/quarto/`**" instruction (WP2 beginner fix) is why Part 2's relative
  paths (`references.bib`, `apa.csl`, `_brand.yml`) resolve when I carry my own file across the
  gap — the continuity holds because of that earlier note.

The seams that remain (P1-1 layouts promise, P2-1 duplicate `author:`) are ones that are only
*visible* when you read two files against each other — which is why a per-file pass wouldn't have
caught them and this arc pass does.

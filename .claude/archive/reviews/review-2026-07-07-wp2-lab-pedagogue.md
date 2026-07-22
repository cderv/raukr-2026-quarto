# Pedagogue review — WP2 Day-1 lab (`labs/quarto/index.qmd` + `starter.qmd`)

- **Date:** 2026-07-07
- **Reviewer lens:** learning design / andragogy
- **Reference commit:** bb42f07 (lab files uncommitted at review time)
- **Scope:** ONLY the two lab files. Deck (WP1) and WP0 assets read for consistency, not
  re-reviewed. Session: RaukR 2026 in-person, ~40 experienced R users, Day 1, two ~1h parts
  with a gap, ~2:1 hands-on (~30 min hands-on per part). Lab IS the hands-on.

## Overall verdict

Pedagogically ready — this is a well-built lab. Both challenges open with an explicit
one-line **Goal**, carry a concrete **"You should see"** success criterion (the Authoring one
even embeds a rendered target figure), and step down through graduated rungs (task list →
collapsible hint → folded solution → linked full worked doc). The Part-2 starter is a genuine
known-good fallback (I rendered it clean to HTML) and the "Starting point" callout explicitly
disarms the between-parts gap, so nobody is stranded (rule 2 satisfied). The hands-on opens at
the authoring value-adds with migration demoted to a collapsed optional aside (rule 4
satisfied), and deck↔lab naming is one vocabulary ("Authoring Challenge" / "Citations
Challenge"). The only substantive tuning: the Authoring Challenge sits at the upper load
ceiling for 30 min, and one sub-task (the `gt` table) asks for from-scratch R plumbing with no
intermediate rung — the one place the exercise load drifts off the Quarto learning target.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

**P1-1 — Authoring Challenge: the `gt` table is unscaffolded R plumbing (rule 4).**
`labs/quarto/index.qmd:52-54` asks participants to "Add a `gt` summary table (mean bill
measurements per species)" from scratch. The learning target here is the **`tbl-` label +
`tbl-cap` + `@tbl-summary`** cross-reference mechanic — not `gt`. But `gt` adoption is uneven
in a bioinformatics room, and the hint (`index.qmd:86-93`) says nothing about building the
table; the only help is the *full* folded solution (`index.qmd:113-123`). A `gt`-unfamiliar
participant must therefore expand the entire solution to clear a non-target obstacle, which
collapses the challenge and burns exercise minutes on `summarise()`/`gt()`/`fmt_number()`
plumbing rather than on Quarto. Cheap fix: pre-seed the `summarise(...) |> gt()` skeleton in
the task text (or in the setup block) and leave *only* the label/cap/`@ref` lines as the
exercise — keeping the load on the Quarto target. This is the one finding that could measurably
eat into the 30-min floor for a subset of the room.

## 🟡 P2 — nice-to-have

**P2-1 — Authoring Challenge is at the upper load ceiling for 30 min.**
`index.qmd:48-61` bundles four distinct Quarto features (figure cross-ref, table cross-ref,
`column: margin`, display math `{#eq-ratio}`) *plus* a `gt` table *plus* the `fig-alt`
discipline into one ~30-min window. It is per-spec (the Part-1 budget in `topic-store.md:292-299`
lists exactly this), and the folded solution + embedded target figure are real safety nets — so
this is tuning, not a blocker. Suggestion: mark task 5 (the equation, `index.qmd:56-57`) as an
explicit **stretch/optional** so a slower participant still lands the core figure + table +
margin + HTML within the window. Protect the floor.

**P2-2 — Manuscript transfer stops short of the "real paper" title block.**
The Citations Challenge goal is "the manuscript payoff" (`index.qmd:130`) and links
`sample-typst.qmd`, whose author/affiliation front matter (`sample-typst.qmd:4-6`) is what makes
the Typst PDF read as a paper. But the challenge's own tasks (`index.qmd:141-162`) never have
participants *add* an `author:`/affiliation title block — the deck teaches it as part of the
payoff, yet the hands-on doesn't exercise it. Reinforce rule 6 by adding a one-line task ("give
it a real title block: `author:` with name + affiliation") so the manuscript framing is
practiced, not just promised.

**P2-3 — Solution rung is asymmetric with the task list.**
The folded `sol-authoring` (`index.qmd:95-123`) shows the figure, the margin counts, and the
table — but **not** the equation (task 5) nor the in-prose `@fig-bill`/`@tbl-summary` usage,
even though the success criterion (`index.qmd:63-69`) hinges on those `@ref` links resolving.
The equation syntax is fully given in the task and hint, and the complete worked
`penguins-report.qmd` (linked) closes the gap, so this is minor — but adding a one-line
`See @fig-bill …` to the folded solution would make the self-check rung match the "You should
see" promise exactly.

**P2-4 — "Two challenges, one document" scope line can momentarily read as "both in 30 min."**
The scope callout (`index.qmd:9-16`) says "Two challenges, one document" without stating that
each challenge is its own ~30-min part with the gap between them. The Citations "Starting point"
callout (`index.qmd:133-138`) does resolve it ("Nobody is stranded by the break"), and the deck
sequences them one-per-part, so this is a low-severity clarity nit: a half-sentence mapping the
two challenges to the two parts would remove any first-read ambiguity about pacing.

## ✅ Pedagogical strengths confirmed

- **Visible success criteria are excellent.** Both "You should see" callouts
  (`index.qmd:63-69`, `index.qmd:164-169`) are concrete and checkable (numbered Figure 1 /
  Table 1 / Equation 1 + margin placement; in-text *(Gorman et al., 2014)* + APA list + "no
  `?@` markers anywhere"). The Authoring one embeds a rendered **target figure**
  (`index.qmd:71-84`) so participants have a visual to match — a strong autonomy aid.
- **Known-good Part-2 starter verified (rule 2).** `starter.qmd` is a complete Part-1 report
  (figure/table/margin/equation, no citations), renders clean to HTML, has no dangling
  cross-refs, and its prose already contains the exact landing sentence "...collected at Palmer
  Station, Antarctica" (`starter.qmd:29-31`) that task 2 asks to append `[@gorman2014]` to — a
  neat pre-positioned scaffold. `@gorman2014` exists in `references.bib`. Genuinely lets anyone
  who fell behind still do the Citations Challenge.
- **Hands-on opens at value-adds, migration demoted (rule 4).** The Rmd migration is a
  `collapse="true"` optional 2-minute aside (`index.qmd:31-41`), not the opener; the first
  Challenge is Authoring.
- **Graduated rungs + strong self-correction loop.** Task list → collapsible hint → folded
  solution → linked full doc, plus a rich in-lab **Troubleshooting** callout
  (`index.qmd:205-220`) that anticipates the exact traps (`?@` cross-ref, missing package,
  figure path, unbranded Typst, HTML-first fallback). A participant erroring at step N can
  self-correct without flagging a TA — and the deck's `::: notes` (roaming-helper pointers) back
  this up.
- **One vocabulary, deck↔lab (rule 9).** Deck `your-turn-1/2` name "Authoring Challenge" /
  "Citations Challenge" and point at these exact headings.
- **Manuscript through-line is coherent.** One dataset, one document growing across both
  challenges, climaxing in the branded Typst PDF — the "cite it → typeset it" arc is visible end
  to end and named as the manuscript payoff.

## 📝 Evolution since the previous review

First pedagogue pass on these two files (WP2, just authored). Nothing to compare against; no
regressions to flag. The design already banks the fixes the running-order rules encode
(rule 2 starter, rule 4 value-adds-first, rule 6 manuscript naming, rule 9 shared vocabulary),
so this lab lands the 2026-07-07 panel decisions well on first authoring.

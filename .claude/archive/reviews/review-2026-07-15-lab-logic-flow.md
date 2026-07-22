# Review — Lab logic & the prez↔lab flow (7-agent panel)

**Date:** 2026-07-15 · **Scope:** the two teaching cycles end-to-end —
`slides/quarto/index.qmd` + `labs/quarto/index.qmd` (Day 1),
`slides/quarto-projects/index.qmd` + `labs/quarto-projects/index.qmd` (Day 2),
plus shipped assets (`labs/quarto/starter.qmd`, `penguins-report.qmd`, `sample-typst.qmd`,
`labs/quarto-projects/starter/`, `solution/`, `dashboard.qmd`).

**Panel (7 agents, parallel):** three *student* personas (skip-ahead skimmer · faithful follower ·
anxious first-timer), three *teacher* lenses (macro-structure architect · exercise/assessment
designer · prerequisite/cognitive-load auditor), one *technique* pass (renders every executable
asset with the renv library). Commissioned to answer three author questions:

1. Is it clear the course is **prez → lab → prez → lab** (two cycles) and not one prez → lab?
2. Is it clear **what the exercises are**, and do they **fit after the presentation**?
3. When a lab is reached, is there any **question left unanswered**?

**Environment:** `quarto check` green — Quarto 1.9.38, Pandoc 3.8.3, Typst 0.14.2, Dart Sass, Deno,
LaTeX, Chrome Headless, R 4.6.1 (knitr 1.51, rmarkdown 2.31). The technique pass rendered
Day-1 `index`/`penguins-report`/`starter`/`sample-typst`(→PDF) and Day-2 `index`/`dashboard`/`solution/`
with **no errors** (only the documented harmless Typst `unknown font family` warning). Every
`@fig-`/`@tbl-`/`@eq-`/`@gorman2014` reference resolves (rendered HTML grepped for `?@`/`[?]` — none).

---

## Verdict on the three questions

**Q1 — two cycles, clear?** The architecture is **right and real** — four short prez→lab cycles
(2 days × 2 Parts), each Part reaching its own hands-on payoff and shipping a known-good starter so
the between-Parts break strands nobody. The split is pedagogically *forced* by the schedule
(13:30–14:30 / 15:30–16:30), so one-long-lecture-then-one-long-lab isn't even possible. **The gap is
visibility, not structure:** the two-cycle rhythm is stated in the *labs* and *presenter notes* but
**never announced up front on the slides**, and follow-along has a start cue but no stop cue.

**Q2 — exercises clear / fit after prez?** **Strong yes.** All four Challenges are unmistakably
delineated (`## … Challenge`), use the *same name* on slide and in lab, land immediately after the
slide beat that enables them, and carry the full instrument set (Goal → Tasks → "You should see" →
Hint → folded Solution → Troubleshooting). Only minor scoping nits (one stretch task is a near
no-op).

**Q3 — unanswered at the lab?** **Mostly no** — the labs are armored (every task hands its snippet
inline; hints + troubleshooting + shipped starters cover the predictable failures) and everything
renders. The genuine gaps are the **Day-2 working-directory / nested-`_quarto.yml` trap** and two
**slide under-teaches** (a broken cross-ref demo on the Tables slide; margin layout with no code on
its slide).

---

## P0 — blocking
**None.** Both labs run end-to-end as written; the macro-structure is sound and safe to teach.

## P1 — fix before the event

**P1-1 · Day-2 working directory / nested-`_quarto.yml` trap.** *(convergent: skimmer, faithful)*
The workshop repo is itself a Quarto website (`_quarto.yml` `type: website`, `output-dir: _site`).
The lab says `quarto render starter/analysis.qmd` and "lands an `.html` next to the source"
(`labs/quarto-projects/index.qmd:39`) but then "from inside `starter/`, run `quarto render`"
(`:68`) — two cwds back-to-back. Run the first from repo root and the **root** project governs, so
output goes to `_site/…`, not next to the source → the classic 5-minute "where's my HTML?" hole, with
no Troubleshooting entry for it. The slides never situate `_quarto.yml` relative to the cloned repo
(`slides/quarto-projects/index.qmd:59`).
→ Make cwd explicit and consistent (`cd starter/` first), add one slide line on the nearest-wins
`_quarto.yml` project root, verify/correct the "next to the source" claim, and add a Troubleshooting
"wrong cwd / where did my HTML go" entry.

**P1-2 · No up-front "How today works" roadmap slide.** *(convergent: macro-architect, anxious)*
Both decks jump `## Learning Outcomes` → bare `# Part 1` divider; the two-cycle rhythm (short
follow-along build → ~30-min solo Challenge → break → repeat) is never shown to the room, though the
pacing doc requires "announce the My/Our/Your rhythm once, up front" (`workshop-pacing.md:66`). This
is exactly Q1's risk — on the slide surface the answer is "inferred," not "stated."
`slides/quarto/index.qmd:35-51`, `slides/quarto-projects/index.qmd:28-43`.
→ Add one orientation slide after Learning Outcomes on each deck.

**P1-3 · Follow-along has a start marker but no end marker.** *(anxious)*
Once live coding starts, the deck runs into watch-only concept slides with no cue to stop typing, so
the anxious follower keeps typing lecture content and falls behind. Day 1: starts
`slides/quarto/index.qmd:156`, no stop cue at Layouts `:288`. Day 2: starts `:49`, no cue at
Cross-references `:158`. (Day 2 already has the right idiom — the `callout-warning` "Watch-me — not a
live Your turn" at `:315`; mirror it.)
→ Add a one-line "eyes up — no need to type this" cue at each return-to-concept point.

**P1-4 · The real ~1h break is hidden behind "regroup in ~30 min".** *(anxious)*
On-slide text says "regroup in ~30 min" (`slides/quarto/index.qmd:420`; Day 2 `:224`); the actual
between-Parts hour break lives only in presenter notes (`:427`; `:230`).
→ Put the break on the Your-turn or Part-2 divider slide ("~30 min lab, then break — back at HH:MM").

**P1-5 · Tables slide demo would render a broken cross-reference.** *(prereq-auditor)*
`slides/quarto/index.qmd:216-221` shows the `gt` cell with only `#| label: tbl-summary` (no
`tbl-cap`), then `:223` says "refer to it with `@tbl-summary`". A computational table is **not
cross-referenceable without `tbl-cap`** → live-coding the slide yields `?@tbl-summary`, on the very
slide teaching cross-refs. The lab gets it right (`labs/quarto/index.qmd:57-63`).
→ Add `#| tbl-cap: "Mean bill length per species."` to the slide cell (+ presenter note).

**P1-6 · The one layout the lab requires has no syntax on its slide.**
*(convergent: prereq-auditor, faithful, exercise-designer)*
Layouts (`slides/quarto/index.qmd:288-303`) is prose + doc links, zero code, and defers with "in the
lab you'll use margin layout" — but margin is a follow-along "Our turn" item and a core lab task
(`labs/quarto/index.qmd:64`). A follow-along slide with nothing to type can't be followed along.
→ Put the one line on the slide — `#| column: margin` (cell) or `::: {.column-margin}` (prose).

**P1-7 · Day-1 Typst payoff depends on a live Google-Fonts fetch on first render.** *(technique)*
Non-fatal (Typst warns and drops to a system font), but ~40 people hitting Google Fonts on
conference wifi is the biggest single risk to the "branded PDF" climax — worst case, unbranded PDFs.
`labs/quarto/index.qmd:210`,`:250`.
→ Logistics fix: pre-warm the fonts during Setup (one `quarto render … --to typst`).

**P1-8 · Day-1 Typst: the Render button produces no PDF.** *(technique)*
Task 6 relies on CLI `--to typst` (`labs/quarto/index.qmd:190-193`); the solution hint instead says
set `format: typst` (`:230`). A participant who clicks the editor's Render/Preview button renders the
declared `format: html` → no PDF, silent confusion.
→ State both routes explicitly and note the Render-button caveat.

## P2 — polish

- **Day-2 Website stretch task is effectively pre-done.** *(convergent: exercise-designer, technique)*
  `labs/quarto-projects/index.qmd:81-83` says "cross-reference the figure — it already has one," but
  `starter/analysis.qmd:25` already contains `@fig-mass`; nothing to add. → Reword to a real action
  (add a second ref to `@tbl-means`; link `index.qmd → analysis.qmd`) and mirror it in "You should see".
- **Day-2 Ship-it success signal is weak** (absence of compute in the log, easy to miss).
  `labs/quarto-projects/index.qmd:143-157`. → Drop a `cat(format(Sys.time()))` cell; the frozen second
  render leaves the timestamp unchanged — a crisp visible pass/fail.
- **Typst PDF output location differs** for the shipped starter (in the render list → `_site/…/starter.pdf`)
  vs a new doc (next to source). `labs/quarto/index.qmd:192`. → One line naming where it lands.
- **Reference list placeholder (`::: {#refs}`) is lab-only** — never shown on the Citations slide.
  `slides/quarto/index.qmd:454-489` vs `labs/quarto/index.qmd:174-181`. → One slide line on where the
  list renders.
- **`fig-alt` is demanded but never explained** on slides. `labs/quarto/index.qmd:74`. → One clause on
  the Figures slide (what/why).
- **"Your turn" links land at the lab top, not the named Challenge.** *(skimmer)* Add
  `#authoring-challenge`/`#citations-challenge`/`#website-challenge`/`#ship-it-challenge` anchors to
  the slide links (`slides/quarto/index.qmd:421`,`:564`; `slides/quarto-projects/index.qmd:225`,`:329`).
- **Web-page ↔ local-folder bridge is unstated at lab entry.** *(convergent: anxious, faithful, skimmer)*
  "Create a `.qmd` inside `labs/quarto/`" / "this lab ships `starter/`" never say "in your cloned repo".
  `labs/quarto/index.qmd:52`, `labs/quarto-projects/index.qmd:30`. → One bridging clause each.
- **Part 1 has no micro-close** mirroring Part 2's `## What you can do now`. *(macro-architect)*
  Add a one-line "you can now X; after the break we do Y" to the Part-1 Your-turn slide.
- **Day1→Day2 "grown from one file" vs a fresh `starter/`.** *(macro-architect)* Dataset/story stay
  continuous but the *file* does not (`slides/quarto-projects/index.qmd:36` vs `labs/quarto-projects/index.qmd:29-42`).
  → Half a sentence ("a fresh set of penguin pages — same data, clean start").
- **`output-location: column` (revealjs-only) rides on a copied slide cell.** *(faithful, prereq)*
  `slides/quarto/index.qmd:194`. → Optional "(slide-only)" aside on-surface, not just in notes.
- **Two look-alike "column" options one slide apart** (`output-location: column` vs `column: margin`).
  *(prereq-auditor)* Folds into the P1-6 fix.

---

## Strengths confirmed (multiple panelists)

- **The two-cycle structure is real, built, and justified** — four short prez→lab cycles, each Part
  reaching its payoff and shipping a known-good starter (`labs/quarto/index.qmd:157-162`,
  `labs/quarto-projects/index.qmd:129-133`); the break is handled, not ignored.
- **Exercises are exemplary as instruments** — unmistakably delineated, same vocabulary slide↔lab
  (Authoring / Citations / Website / Ship it), each with Goal + Tasks + observable success criterion +
  reachable solution; heavy R-plumbing is pre-handed so load stays on the Quarto mechanic.
- **Labs are armored against a skipped slide** — inline snippets + Hint + "You should see" +
  Troubleshooting re-explain every concept in-lab; shipped `starter.qmd` / `starter/` / `solution/`
  all exist on disk and match the text.
- **Everything renders** with the renv library (empirically, technique pass) — Typst PDF, freeze skip,
  Website Challenge reproduced verbatim, single-file render location confirmed.
- **Idioms are current** — native `.qmd`, `|>`, `#|` hash-pipe, base-R `penguins` columns
  (`bill_len`/`bill_dep`/`body_mass`), editor-agnostic (CLI + Render button).

---

## Suggested fix order

1. **P1-5** (broken `tbl-cap` demo) — smallest, a correctness bug on a teaching slide.
2. **P1-6** (margin syntax on the Layouts slide) — closes a Q3 gap and makes a follow-along slide followable.
3. **P1-1** (Day-2 cwd / nested-`_quarto.yml`) — the biggest live-session time sink; lab + slide + troubleshooting.
4. **P1-2 / P1-3 / P1-4** (roadmap slide + follow-along stop cue + show the break) — the Q1 visibility cluster.
5. **P1-8** then **P1-7** (Typst Render-button routes; font pre-warm) — de-risk the Day-1 climax.
6. P2 batch as time allows; the Day-2 stretch-task reword (P2, convergent) is the highest-value polish.

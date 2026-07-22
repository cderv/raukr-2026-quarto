# Plan — Parameterized-report exercise placement + build (the tracker)

*Study → decide → build. Resolves the one true coverage gap: Parameters is the single topic NBIS
teaches as a full hands-on (`labs/quarto/index.qmd:467-539`) that this workshop has neither taught
nor mentioned. `topic-store.md` planned a Day-2 MENTION "riding inside the CLI framing" but nothing
was built, so it read as an unclosed loop, not a decision. Produced 2026-07-22.*

## 1. Decision up front

**Build it as a clearly-optional, self-service *bonus* section in the Day-1 lab
(`labs/quarto/index.qmd`), after the Citations Challenge, before Troubleshooting.** Ship one tested
reference file `labs/quarto/penguins-by-species.qmd` (house pattern: every challenge ships a
known-good solution). **Not** a new core timed challenge; **not** Day-2.

## 2. Why Day-1, not Day-2 (the strand's core question)

The tension the strand names: params is a *single-document* feature (fits Day-1 "the document"
arc + Christophe's 2026-07-21 lean), **but** overriding a param needs the CLI
(`quarto render doc.qmd -P k:v`), which the old triage read as a Day-2 (projects/CLI) fit, and
Day-1's two parts are both full (Part 2 = the tight Citations→Typst payoff the panel protected).

Resolved:

- **The "CLI → Day-2" rationale is moot.** Day-1 *already* runs `quarto render your-doc.qmd
  --to typst` from the terminal in the Citations Challenge (`labs/quarto/index.qmd:194-197`). So
  `quarto render … -P species:Gentoo` is the **same muscle already introduced on Day 1** — no new
  framing, no reason to defer to Day 2 for the CLI's sake.
- **Thematic fit.** Day-1 identity = *one `.qmd` → one branded document*; Day-2 = *one project →
  many pages (a website), shipped*. A parameterized report is *one source → many rendered
  instances* — a document-level "one → many", closest to Day-1's document axis. Dropping a
  standalone doc rendered N times into the middle of a **website-project** lab is a jarring topic
  shift ("why are we rendering a lone doc three times while building a site?").
- **Audience payoff lands on Day 1.** "One report per sample / species / cohort from one source" is
  the manuscript/team-report path — exactly the Day-1 lab's stated narrative ("from an analysis to
  a submittable write-up"), and a genuinely useful pattern for a life-science audience.
- **Christophe's lean was Day-1** (prior-art-inventory.md :265), with "where exactly" flagged open —
  this plan answers it.

## 3. Why optional/bonus, not a core challenge

- **Parameters is MENTION-level in the triage** (`topic-store.md` Day-1 table :120; "MENTION
  one-slide items ride inside their CORE beat, not as separate timed beats" :378). A self-service
  lab bonus is the lab-side equivalent of a MENTION — available, not spent from the beat budget.
- **No spare core time.** Part 1 = 4 tasks + stretch + accessibility; Part 2 = the Citations→Typst
  payoff the panel fought to keep un-squeezed (technique P1-1, pedagogue P1-1/P1-2). A new *timed*
  challenge would reopen exactly that wound.
- **Zero-cost form.** An optional bonus for fast finishers costs the core flow nothing and mirrors
  the existing `(stretch)` idiom. Matches multi-day rule §9 (labs: beneficial-rep, name the new
  dimension) — the new dimension here is *parameterization*, named on the step.

## 4. The re-skin (iris → penguins, 1:1)

NBIS source (`labs/quarto/index.qmd:467-539`) is actually a **thin** walkthrough: it embeds an
external report iframe, shows YAML + two fragments (the `output: asis` heading, the `!expr`
caption), and says "try versicolor / try PDF" — it never shows the filtering chunk or the `-P` CLI
override. So "re-skin 1:1" is mostly a *from the fragments* rebuild on penguins. Kept teachable
beats:

- `params:` block with a default (`species: Gentoo`), overridable at render time.
- `params$species` to **filter** the data (the missing NBIS chunk, made explicit).
- `#| output: asis` + `cat("## ", params$species, …)` — the **dynamic heading** trick.
- `!expr paste0(...)` — the **dynamic caption** (and `fig-alt`).
- inline `` `r params$species` `` in prose.
- The **CLI override**: `quarto render penguins-by-species.qmd -P species:Adelie` (+ the
  Render-button caveat, consistent with the Typst step's editor-vs-CLI note).

Single species per render ⇒ single-colour plot ⇒ **no CVD/Okabe-Ito concern** (no categorical
colour encoding), so the bonus stays minimal and doesn't need the accessibility scaffolding the
multi-species Part-1 plot carries.

## 5. Build steps

1. `labs/quarto/penguins-by-species.qmd` — minimal tested parameterized report (above beats).
2. Add it to the root `_quarto.yml` render list (renders once with default params = one site page).
3. Test: render with default, then `-P species:Adelie` / `-P species:Chinstrap` — confirm the
   filter, dynamic heading, and caption all track the param.
4. Add the bonus section to `labs/quarto/index.qmd` (after Citations, before Troubleshooting),
   clearly marked optional/self-service, with a raw-GitHub download button (house pattern).
5. `quarto render` the lab + the new file; stage `_freeze/` (freeze hook gate).
6. Worklog entry; close the loop in `prior-art-inventory.md` (gap → built) and record the decision
   in `topic-store.md` (Day-1, optional bonus — supersedes the Day-2-MENTION plan).

## 6. Deliberately deferred (not in this change)

- **Day-1 slide MENTION.** Optional one-liner pointing at the bonus. Touching the deck triggers the
  slides rules (fit-check + freeze) and the beat budget; kept out to keep this a clean lab-only unit.
  Follow-up candidate, not a gap — the exercise itself is the strand's ask.
- **`revealjs`-from-report** (NBIS `:541-623`) — out of scope; format-switching is already covered.

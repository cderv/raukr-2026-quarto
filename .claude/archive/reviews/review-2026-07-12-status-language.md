# Language review — status-confirmation pass (writing + speaking)

**Date:** 2026-07-12
**Reviewer:** workshop-reviewer-language (expanded remit)
**Reference commit:** `88d48cf` (Scope justfile rule to the justfile via paths frontmatter)
**Scope:** the full two-day arc as one corpus —
Day 1: `slides/quarto/index.qmd`, `labs/quarto/index.qmd`, `labs/quarto/starter.qmd`;
Day 2: `slides/quarto-projects/index.qmd`, `labs/quarto-projects/index.qmd`,
`labs/quarto-projects/starter/{index,analysis}.qmd`,
`labs/quarto-projects/solution/{index,analysis}.qmd`, `labs/quarto-projects/dashboard.qmd`.

This is a **status-confirmation** with a **special expanded remit**: cover BOTH written copy
(Part A) AND spoken delivery (Part B). The two parts are labelled throughout so you can see
which dimension each finding belongs to.

---

## TL;DR

- **Writing (Part A): confirmed clean.** Prior cycles' standardisations all held across the
  Day-1/Day-2 boundary — US spelling, "cell" (not "chunk"), "versus" (not "vs."), Oxford
  commas, Challenge names. No regression, one cosmetic nit (a lone "vs" inside a `fig-alt`).
  Nothing to do before the event on the writing side.
- **Speaking (Part B): the under-reviewed dimension, and where the real findings are.** Read
  as a script, the presenter notes are good but **mix two registers** (lines to *say* vs.
  stage-directions to *do*) with no visual marker, carry a little **internal-reviewer jargon**
  that reads oddly aloud, and leave the **highest-friction live beats — the lab handoffs and
  the mid-session break — unscripted** (Day-2 "Your turn" has no note at all). These are
  P1 speaking-support refinements, not blockers.

### Triage

- 🔴 **P0 — none.** No language problem rises to "must fix or it hurts a pro workshop." State
  this plainly: the corpus is in good shape; the expanded remit surfaces refinements, not
  blockers.
- 🟠 **P1 (fix before the event, speaking):**
  - **B1** Lab-handoff + break beats are unscripted (Day-2 `#your-turn-2` has *zero* notes;
    every other "Your turn" note is helper-coaching, not a spoken handoff line).
  - **B2** Presenter notes mix *spoken script* and *stage-direction* with no marker — a
    glance-down mid-flow can't tell which to read aloud.
  - **B3** Internal-reviewer jargon leaks into notes ("beginner P0 mitigation", "the
    load-bearing teach", "cut-first sub-item") — fine as a private cue, but plain-language it.
- 🟡 **P2 (nice-to-have):**
  - **B4** A few on-slide bullets/lines are dense to *say* (the outset/inset bullet; the
    `freeze: true` triple-clause line).
  - **B5** The `→` arrow in headings/prose has no agreed spoken form ("to"? "then"? "becomes"?).
  - **A1** One `fig-alt` uses "vs" where the whole corpus otherwise says "versus".
  - **B6** `WYSIWYM` is an easy read-aloud stumble.

---

# PART A — WRITING (confirmation)

**Verdict: clean. Prior standardisations confirmed intact across both days.** Greps run
(all scoped to the in-scope files):

| Check | Result |
|---|---|
| Corporate/stiff (`in order to`, `utilize`, `leverage`, `facilitate`, `whilst`, `amongst`, `it is important to note`, …) | **0 hits** |
| Doubled words (`the the`, …) | **0 hits** |
| Short `Fig 1` / `Tab 1` in prose | **0 hits** |
| `vs.` vs `versus` in prose/captions | "versus" everywhere; one bare "vs" in a `fig-alt` (A1) |
| `chunk` vs `cell` | 2 hits, **both legitimate** (see below) — no regression |
| US vs UK spelling (`colour`, `-ise`, `centre`, `analyse`, …) | **0 UK hits**; `colored`/`colors`/`millimeters` all US |
| `cross-reference` family | consistent; short form `cross-refs` used only on dense bullets/notes (established choice) |
| `render` vs `build` | consistent split — *render* = the command, *build* = producing a site/project |
| `title block` / `YAML header` | each used consistently for its own referent |

**The two `chunk` hits are correct, not drift:**
- `slides/quarto/index.qmd:38` — *"…not 'what is a code chunk'."* deliberately quotes the
  concept being set aside.
- `labs/quarto/index.qmd:39` — *"cell options move from the **chunk header**…"* — "chunk
  header" is the correct R Markdown term for the thing being migrated *from*. Renaming it
  "cell header" would misdescribe `.Rmd`.

Both are the right call; leave them.

### The one writing nit

| file:line | current | proposed | why |
|---|---|---|---|
| `labs/quarto/index.qmd:117` | `#| fig-alt: "Bill depth vs length for three penguin species…"` | `Bill depth versus length…` | The corpus standardised on "versus"; this lone "vs" is inside a solution `fig-alt`, which a screen reader speaks as "vee-ess". Trivial, but it's the only survivor. |

Everything else on the writing side is confirmed and needs no change.

---

# PART B — SPEAKING / SPOKEN DELIVERY (the expanded remit)

Method: I read every `::: notes` block **as a script the presenter reads aloud**, and every
on-slide bullet as something that has to be *said*, not just displayed. Day 1 has 8 note
blocks, Day 2 has 7.

## ✅ Speaking strengths (confirm)

- **One voice across both days.** Same author, and the notes *sound* like one person: terse,
  em-dash-driven, production-minded. Day 1 and Day 2 share conventions — `Roaming helpers:` to
  open helper-coaching notes, "watch-me" / "cut-able" for demo beats. Register consistency
  between the two days' worth of notes is genuinely good; no seam.
- **The best on-slide lines are already spoken English.** e.g.
  `slides/quarto-projects/index.qmd:231` — *"Bioinformatics compute is slow. You don't want
  every prose edit to re-run a 20-minute alignment."* Direct, second person, short sentences —
  reads aloud perfectly. `slides/quarto/index.qmd:59` *"One tool, many outputs, multiple
  languages. Start native — write `.qmd` directly."* is a clean spoken beat.
- **Some notes are already good scripts.** The Day-1 and Day-2 Learning-Outcomes notes, and
  the Day-2 `#demos` note ("just name the four regions: two valueboxes across the top, a card
  with the boxplot, and a two-tab panel"), hand the presenter something sayable.

## 🟠 P1 speaking findings

### B1 — Handoff and break beats are unscripted (highest-friction live moments)

The brief flags exactly this. The transitions where 40 people get up, move to the lab, or
break for coffee are the moments a presenter most needs a line — and they're the ones with no
spoken cue.

| file:line | beat | what's there | gap |
|---|---|---|---|
| `slides/quarto-projects/index.qmd:301` | Day-2 `#your-turn-2` ("Ship it") | **no `::: notes` at all** | Presenter improvises the entire handoff to the final lab. |
| `slides/quarto/index.qmd:304` | Day-1 `#your-turn-1` | note is `Roaming helpers:` coaching | No *spoken* handoff line ("Right — over to you; back in ~30"). |
| `slides/quarto/index.qmd:438` | Day-1 `#your-turn-2` | note is `Roaming helpers:` coaching | same |
| `slides/quarto-projects/index.qmd:216` | Day-2 `#your-turn-1` | note is `Roaming helpers:` coaching | same |
| Part-2 dividers (`slides/quarto/index.qmd:309`, break sits here) | the mid-session break | subtitle only | The labs say "with the between-parts break in between", but no slide note hands the presenter a line to *call* the break (when to reconvene, where coffee is). |

**⚠️ Recommendation (human to author — this is content, not a reword):** add one short spoken
handoff line to each "Your turn" note (they can co-exist with the `Roaming helpers:` coaching —
e.g. a "Say:" line then a "Helpers:" line), and give Day-2 `#your-turn-2` a note at all. Script
the break call once. Keep it to a sentence each; the goal is to remove the improvise-under-
pressure moment, not to over-produce.

### B2 — Notes mix "say this" and "do this" with no marker

Read aloud verbatim, several notes are stage-directions, not lines — and nothing distinguishes
them from the notes that *are* scripts. A presenter glancing down mid-sentence can misfire.

Stage-direction notes (would sound wrong if read aloud):
- `slides/quarto/index.qmd:62` — *"Reframe from 'Quarto = R Markdown++, nothing new to learn'
  to 'here is what you can now build'. This audience wants to level up…"*
- `slides/quarto/index.qmd:274` — *"DEMO beat, kept tight… This folds the old Execution-options
  + Positron slides into one so Part 1 lands inside its ~18-20 min budget."*
- `slides/quarto/index.qmd:291` — *"Watch-me, cut-able — trim first if Part 1 runs long…"*
  (then a genuine scripted line in quotes — the two modes sit in one block).
- `slides/quarto-projects/index.qmd:336` — *"Cut-able tail — trim from the bottom…"* (then
  good spoken guidance).

**Recommendation:** adopt one lightweight convention so the eye separates the two at a glance —
e.g. lead every stage-direction with a bracketed tag (`[dir]` / `[timing]`) or keep timing/cut
notes on their own line above the spoken cue. Purely a formatting convention; no wording change
needed to the facts. This is the single highest-leverage speaking-support improvement.

### B3 — Internal-reviewer jargon in notes

A few notes borrow the review process's own vocabulary. Fine as a private cue, but it reads
oddly and dates the deck to its production:

| file:line | phrase | plainer cue |
|---|---|---|
| `slides/quarto-projects/index.qmd:297` | *"This is the beginner **P0 mitigation**: foreground the CI story…"* | "This calms the biggest beginner worry: keep the auth cliff off the hands-on path." |
| `slides/quarto-projects/index.qmd:274` | *"…the cache-vs-freeze contrast is **the load-bearing teach**."* | "…the cache-vs-freeze contrast is the point of this slide — protect it." |
| `slides/quarto-projects/index.qmd:274` | *"renv is the **cut-first sub-item**…"* | "renv is the first thing to drop if short on time…" |

Not visible to participants, so low urgency — but since we're auditing the notes as delivery
material, plain-language beats meta-jargon.

## 🟡 P2 speaking findings

### B4 — On-slide lines that are dense to *say*

Most bullets are noun-phrases the presenter naturally expands — fine. Two are mouthfuls read
aloud:

| file:line | current | why it's awkward spoken |
|---|---|---|
| `slides/quarto/index.qmd:214` | *"outset / inset — a figure or table that spills beyond the body (outset) or widens toward the page while keeping a margin from the edge (inset)"* | Nested parentheticals `(outset)…(inset)` force the reader to back-reference mid-sentence; hard to land in one breath. Consider splitting into two short clauses. |
| `slides/quarto-projects/index.qmd:250` | *"`freeze: true` never re-executes on a project build (refresh by rendering the file directly) — the hard-freeze CI mode."* | Three clauses + a parenthetical in one line; the presenter will stumble on the aside. Sayable if the parenthetical becomes its own sentence. |

⚠️ Both touch phrasing of a technical claim — mark for human validation before rewording.

### B5 — The `→` arrow has no spoken form

`→` appears in headings and prose 8×
(`slides/quarto/index.qmd:153,223,231,309`;
`slides/quarto-projects/index.qmd:39,169,259,260`). In a *heading* — "One source → many
formats", "Citations → Typst" — the presenter must vocalise it on the fly ("to"? "then"?
"becomes"?). Not wrong, just unscripted and inconsistent across reads. A one-line house call
("read `→` as 'to'") removes the micro-hesitation. No text change required.

### B6 — `WYSIWYM` read-aloud stumble

`slides/quarto/index.qmd:267` — *"the visual editor (WYSIWYM — what you see is what you
mean)"*. The acronym is glossed on the slide, but spoken cold it's a tongue-twister (and a
riff on WYSIWYG the room may not catch by ear). Fine to keep on the slide; a presenter note
"say 'what you see is what you mean', don't spell the acronym" would de-risk it. Optional.

### Other read-aloud spots checked and cleared

- "hash-pipe" (`slides/quarto/index.qmd:112`) — glossed, sayable. Fine.
- `pak is KO in the sandbox` (`slides/quarto-projects/index.qmd:206`) — slang, but it's a
  private note, never spoken to the room. Fine.
- Day-2 `one file → many` (`:39`) — same arrow issue as B5, otherwise a clean spoken beat.

---

## 📝 Evolution since the previous reviews

- Previous language reviews (`review-2026-07-07-*-language.md`,
  `review-2026-07-08-*-language.md`) worked **within** a single day/artefact. This pass is the
  first to read the **two days as one corpus** and the first to audit the **notes as a spoken
  script** rather than as prose.
- The 2026-07-07/08 standardisations (US spelling, "cell", "versus", Oxford commas, Challenge
  names) are **all confirmed present and un-regressed** at the Day-1/Day-2 boundary — no new
  inconsistency crept in when the decks were merged (`bb54cc9`).
- Net new surface from the expanded remit: the **speaking-support** findings (B1–B6). These
  were out of scope in every prior cycle (notes were "don't touch"), so they're genuinely
  under-reviewed rather than re-flags.

---

## One-line status

**Writing: confirmed clean, no blockers, one trivial `fig-alt` "vs"→"versus".**
**Speaking: solid single-voice notes, but the lab-handoff/break beats are unscripted (B1) and
notes mix say-this/do-this with no marker (B2) — P1 refinements, no P0.**

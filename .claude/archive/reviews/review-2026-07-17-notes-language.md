# Review — presenter `::: notes` as a spoken script (language / copy)

- **Date:** 2026-07-17 · **Reviewer:** language · **Scope tag:** `notes`
- **Reference commit:** `99563e1`
- **Files:** `slides/quarto/index.qmd` (19 note blocks), `slides/quarto-projects/index.qmd` (13 note blocks)
- **Lens:** can the presenter glance mid-flow and instantly tell *say* vs *do*, and does the say-text read as natural spoken English?

## Verdict

The polished notes are a real step up: the marker system (Say / Do / Say (handoff) / Timing / Helpers / Frame) is present in almost every block, the four "Your turn" handoffs are consistent, and the verbatim `Say:` quotes read genuinely spoken. **B1–B3 and A1 all hold** (see Evolution).

The one systemic weakness is the **`Say:` marker doing two different jobs** — sometimes a verbatim line to read aloud (in quotes), sometimes a *what-to-convey* instruction (unquoted). At its worst (L193, L349) a `Say:` line, read verbatim under time pressure, comes out as gibberish ("frame the list as deltas…"). That directly defeats the glance test, so it leads the triage. Everything else is copy-polish: two US/UK spelling slips inside spoken quotes, one stray marker name, and some marker-vocabulary sprawl.

**Counts:** 🔴 P0 ×1 (pattern, 3 instances) · 🟠 P1 ×5 · 🟡 P2 ×5

---

## 🔴 P0

### `Say:` used for non-spoken *instructions* — breaks the say/do glance test

`Say:` elsewhere means "read this aloud" (in quotes). At these three it carries a stage-instruction to the presenter, unquoted. Glanced mid-flow and read verbatim, they don't parse as speech. Reword to a verbatim quote **or** re-mark as `Frame:` (the deck already has `Frame`, Day1 L84).

| file:line | current | proposed | why |
|---|---|---|---|
| `quarto/index.qmd:60` | `**Say (once, up front):** give the room the map — two rounds, same shape; the Follow along / Your turn callouts flag every switch.` | `**Frame (once, up front):** give the room the map — two rounds, same shape…` | "give the room the map" is an instruction, not a line to say |
| `quarto/index.qmd:193` | `**Say:** frame the list as *deltas* over the Markdown they already know — not a Markdown lesson.` | `**Frame:** the list is *deltas* over the Markdown they already know — not a Markdown lesson.` | literally begins "frame the list…"; reads as nonsense aloud |
| `quarto-projects/index.qmd:349` | `**Say:** foreground the CI *story* and keep the auth cliff off the hands-on path — that's the whole reason publishing is watch-me, not your-turn.` | `**Frame:** foreground the CI *story*; keep the auth prerequisites off the hands-on path — that's why publishing is watch-me, not your-turn.` | instruction, not speech; "auth cliff" would stumble aloud |

---

## 🟠 P1

### 1. US/UK spelling drift — inside verbatim `Say:` quotes

The deck standardised on US spelling; these two sit in lines meant to be spoken/read, so they are the ones that matter.

| file:line | current | proposed | why |
|---|---|---|---|
| `quarto/index.qmd:223` | `"A **labelled** cell *becomes* a numbered figure…"` | `labeled` | US convention; slide body L199 already uses "labeled" |
| `quarto/index.qmd:286` | `"…same syntax, different **colour**."` | `color` | US convention |

### 2. Stray marker name — `Helpers cue` vs `Helpers`

| file:line | current | proposed | why |
|---|---|---|---|
| `quarto-projects/index.qmd:173` | `**Helpers cue:** flag the classic trap now…` | `**Helpers:** flag the classic trap now…` | every other helper note is `Helpers:`; one-off "cue" breaks the marker vocabulary |

### 3. `Say:` inconsistently quoted — verbatim vs unquoted talking-point

Roughly 11 `Say:` lines are verbatim-in-quotes; a handful are unquoted speakable points. Not wrong, but the quotes are what let you read straight down. Recommend: **quote anything you intend to say verbatim.** ⚠️ wording only, no meaning change.

| file:line | current | proposed | why |
|---|---|---|---|
| `quarto/index.qmd:333` | `**Say:** margin figures still take @fig-/@tbl-, so layout pairs naturally with cross-refs.` | wrap in quotes: `**Say:** "Margin figures still take @fig-/@tbl- — so layout pairs naturally with cross-refs."` | match the verbatim-quote convention |
| `quarto-projects/index.qmd:172` | `**Say:** contents: auto builds the sidebar from the folder — you don't hand-list pages.` | wrap in quotes | same |

### 4. Spoken line + stage-direction under one `Say:` marker

| file:line | current | proposed | why |
|---|---|---|---|
| `quarto-projects/index.qmd:171` | `**Say:** "Nav is generated…not static HTML." Point at the fig-mass plot: "computed on the page."` | split: keep the two quotes under `Say:`, move `Point at the fig-mass plot` to its own `**Do:**` bullet | a `Do` instruction is buried between two spoken quotes under a `Say` marker |

### 5. Whole-block notes with **no marker** — ambiguous say/do

Four blocks are bare prose while every neighbour is marked; a glance can't tell if they're to-say or to-convey. Add a leading `Frame:` (or `Say:` if verbatim). ⚠️ non-blocking, consistency.

| file:line | block |
|---|---|
| `quarto/index.qmd:46` | Learning Outcomes opener ("You already write R…") |
| `quarto/index.qmd:139` | "How it all works" (knitr engine) |
| `quarto-projects/index.qmd:39` | Learning Outcomes opener ("Day 1 took one .qmd…") |
| `quarto-projects/index.qmd:394` | Demos ("Cut-able tail…") — reads as Timing + Do combined |

---

## 🟡 P2

| file:line | current | proposed | why |
|---|---|---|---|
| (both decks) | `Say (once…)`, `Say (motivation)`, `Say (payoff)`, `Say (relevance)`, `Placement` (proj L241), `Do (live)` / `Do (if demoing live)`, `Frame (not a line)` vs `Pre-flight (not spoken)` | settle on the canonical set (Say / Do / Say (handoff) / Say (trap) / Frame / Timing / Helpers / Pre-flight) and treat the parentheticals as free-text notes, not new markers | marker vocabulary is sprawling; fewer, predictable tokens read faster mid-flow |
| `quarto/index.qmd:287, 302, 404, 471, 570` · `quarto-projects/index.qmd:267` | trailing unmarked director lines ("Next slide closes the live build…", "Gloss Typst on first use.", "One-sentence recap only…") | prefix with `Frame:`/`Timing:` or bullet them as notes | consistently unmarked, low risk, but same say/do ambiguity as P1-5 |
| `quarto/index.qmd:568` | `"…but it's not **the lead** in 2026."` | `"…but it's not the default in 2026."` | "the lead" is journalese; "default" reads more naturally aloud |
| `quarto-projects/index.qmd:239` | `"…until you add **theme_brand_*()**."` | say "…until you add a `theme_brand_*` helper" | the bare `*()` glyph is awkward to voice |
| `quarto/index.qmd:139` ⚠️ | "the knitr engine runs your **chunks**" | leave — likely intentional (Rmd→qmd contrast, "cell options" follows on L140) | only "chunk" in the notes; defensible in R Markdown context, flagging for a human eye |

---

## ✅ Language strengths

- **No spoken-hostile tokens in any `Say:` quote** — grepped the note blocks for `→`, `WYSIWYM`, and bare acronym pile-ups: none land in a line meant to be read aloud. (`WYSIWYM` lives only on slide body L416; the `→` arrows are all slide-body/diagram.)
- **`Say (handoff)` is uniform** across all four "Your turn" notes (Day1 L461/L607, Day2 L257/L361), and the reconvene-time pattern is *correct*: the two pre-break handoffs carry "back at 15:30"; the two final-stretch handoffs (no break after) don't. ⚠️ worth a 5-second sanity check that both days genuinely reconvene at 15:30.
- **"Welcome back"** opens Part 2 identically in both decks (L470 / L266), each with a one-line recap and an explicit "don't re-teach Part 1".
- **Helpers phrasing runs parallel across decks** — your-turn-1 = "Helpers are roaming", your-turn-2 = "helpers are up", the same split in both files.
- The verbatim quotes are genuinely spoken-register: "Same mechanic again…", "Drive it from the CLI, in whatever editor you like", "Over to you — Authoring Challenge in the lab" all read cleanly aloud.
- Product-name casing clean in prose notes (R Markdown, Typst, Positron, VS Code, RStudio, knitr, renv, CI, GitHub).

---

## 📝 Evolution since last review (2026-07-12, B1–B3)

First pass over the **drafted-and-polished** notes (prior pass saw the pre-notes deck). Confirmed, not re-raised:

- **B1** — all four "Your turn" notes carry a `Say (handoff)`; Day-2 your-turn-2 (L361) now has one; pre-break handoffs include the reconvene time. ✅ holds.
- **B2** — every block uses explicit markers (Say / Do / Say (handoff) / Say (trap) / Helpers / Frame / Pre-flight / Timing). ✅ holds — the residual gap is *which* marker (P0/P1-5 above), not missing markers.
- **B3** — reviewer jargon ("load-bearing teach", "shock-absorber", etc.) is gone from the say-text. ✅ holds. Faint traces remain only in director notes ("Cut-able tail", "trim-first", "auth cliff") — none in a spoken line except L349, flagged.
- **A1** — lab `fig-alt` "vs"→"versus" fixed; slide body "Bill length versus depth" (L203) and "Book versus website" (L384) consistent. ✅ holds.

Prior standardisations (US spelling, "cell" not "chunk", Oxford commas, Challenge names) spot-checked: clean **except** the two US/UK slips at P1-1 and the borderline "chunks" at L139.

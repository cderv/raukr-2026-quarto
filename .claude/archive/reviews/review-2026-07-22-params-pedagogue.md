# Review — Parameterized-report bonus (pedagogy) — 2026-07-22

Scope tag `params`. Reference commit **bee98ea**. Reviewer: pedagogue / andragogy.
Focus: the optional parameterized-report bonus added to Day 1 (lab + one slide MENTION +
reference solution). Placement (Day 1, optional) is DECIDED — this review judges execution.

## Overall verdict

Pedagogically ready — ship it. The bonus is a clean, genuinely-skippable unit: it lives
after both timed challenges and before Troubleshooting, is triple-signposted as optional
and self-service, and carries no forward dependency, so a slower participant loses nothing
by skipping it and the protected Citations→Typst payoff cannot be eaten by it (the payoff
is Part 2, *before* the bonus in the flow). The five tasks are well-sequenced
(declare → filter → dynamic heading → dynamic caption → CLI override), each names its new
mechanic, and "one report per species/sample/cohort" is a real, motivating payoff for a
bioinformatics audience. Multi-day §9 is satisfied: parameterization is a genuinely new
dimension over the owned reporting skill, and the new dimension is named on the steps. No
blocking or must-fix pedagogical defects; two small nice-to-haves below.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

None.

## 🟡 P2 — nice-to-have

- **`slides/quarto/index.qmd:457-458` — fit-check the modified `#running` slide.** A second
  bullet (two lines, with the parenthetical "*(Optional bonus in today's lab.)*") was added
  to an already-populated slide (bash block + IDE bullet). I could not confirm no vertical
  overflow (built slide HTML not present; a pedagogy pass doesn't warrant a full render).
  This is really the technique reviewer's gate, but it bears on the pedagogy goal here: the
  MENTION only works if the presenter can name-check `-P` *without* the slide clipping.
  Recommend a `slide-shot.mjs … running` pass before the event. Content-wise the bullet is
  correctly terse and the notes cue ("Don't dwell; it isn't a taught beat") is exactly right.

- **`labs/quarto/index.qmd:266` vs `penguins-by-species.qmd:16` — filter snippet omits the
  NA guard the solution keeps.** Task 2 shows `filter(species == params$species)`; the
  reference solution filters `!is.na(bill_len), !is.na(bill_dep)` as well (needed so the plot
  and `nrow(one)` are clean). A fast finisher copying the task snippet literally onto a
  fresh doc gets NA-bearing rows the "You should see" count implies were dropped. Low stakes
  (penguins NAs are few; the downloadable solution is correct), but a half-line —
  `filter(species == params$species, !is.na(bill_len), !is.na(bill_dep))` — would make the
  task snippet and the reference agree and pre-empt a self-support question. Note this is a
  scaffolding nicety, not a hole: the bonus explicitly points at the runnable solution.

## ✅ Pedagogical strengths confirmed

- **Optional framing is clean and non-holey** (`labs/quarto/index.qmd:249-254`). The H2
  literally reads `Bonus — one report per species (optional)`, the goal line repeats "Fully
  optional, self-service — skip it if you're out of time", and it sits *after* both
  challenges. Nothing later depends on it, so skipping leaves no gap. The top-of-lab Scope
  still says "**Two challenges**, one document" (`:9-12`) and stays true — the bonus is
  deliberately *not* counted as a challenge, so a participant who stops at "You should see"
  for the Citations Challenge has completed the stated core.
- **Payoff time is protected structurally, not just by intent.** The bonus is downstream of
  the Citations→Typst payoff in reading order, and is a lab-side MENTION (available, not
  spent from the beat budget). There is no timed countdown, no regroup, no "we'll share out"
  — so it cannot pull the room's clock. This matches the plan's core constraint (add params
  WITHOUT squeezing Typst).
- **Task sequencing respects cognitive load** (`:261-289`). One new idea per step, in a
  build order that mirrors how you'd actually reach for the feature: declare a param → use it
  as an ordinary value to filter → emit a dynamic heading → make a caption track it → drive
  it from the CLI. Each step's *new* mechanic is bolded ("Use it to filter", "Build a heading
  from the parameter", "Make the caption track the parameter", "Render a different species
  from the CLI"), so the learning target is legible on every line.
- **CLI override is framed as reuse, not a new tool** (`:283-284`, "same `quarto render` you
  used for the Typst PDF, with `-P name:value`"). This is exactly the plan's rationale for
  Day-1 placement made visible to the learner — the muscle is already owned; only the flag
  is new. Good andragogy: build on what they just did.
- **Multi-day §9 (beneficial-rep vs duplication) is satisfied.** The bonus re-practices the
  owned reporting/rendering skill but adds a genuinely new dimension — parameterization
  ("one source → many rendered instances"). Per §9's fix pattern, that dimension is named on
  the steps and in the goal, so it reads as an on-purpose new capability, not a stray rep of
  "render a report".
- **Self-correction / feedback loop is well-supported.** A crisp "You should see"
  (`:292-297`) gives an unambiguous success signal ("nothing says Gentoo"), a Hint callout
  anticipates the two real traps (defaults are mandatory; `output: asis` is what lets code
  emit Markdown — `:299-305`), and the complete runnable solution is one download away
  (`:307-313`). A participant who stalls at step N can self-rescue without flagging a helper.
- **Motivating, audience-true payoff.** "One QC report per sample / one summary per cohort"
  (`:251-253`) is the actual manuscript/team-report pattern for a life-science audience —
  "build something you'll actually use," not a toy.
- **Reference solution is minimal and honest** (`penguins-by-species.qmd`). Single species
  per render ⇒ single-colour plot ⇒ no CVD/Okabe-Ito scaffolding needed, keeping the bonus
  lean; `fig-alt` still tracks the param (`:35`), so the accessibility discipline the rest of
  the lab teaches isn't dropped here. The inline comments on `output: asis` (`:26-27`) and
  the closing count sentence (`:42`) match the "You should see."
- **Slide MENTION is correctly scoped.** `slides/quarto/index.qmd:457-458` name-checks `-P`
  where `quarto render` is already on screen and explicitly labels it "*Optional bonus in
  today's lab*" — a *true* forward pointer (the lab does have it). The `::: notes` cue
  (`:464-465`) tells the presenter it isn't a taught beat and not to dwell, and reaffirms the
  ~18–20 min Part-1 budget. Low-risk, one-breath name-check exactly as intended.

## 📝 Evolution since the previous review

- **Coverage gap closed.** Parameters — previously the one NBIS full-hands-on topic this
  workshop neither taught nor mentioned — is now present as an optional Day-1 bonus plus a
  slide MENTION, without opening a new timed beat. The unclosed Day-2-MENTION loop noted in
  the plan is resolved into a built, tested decision.
- **Execution matches intent.** The plan (§3 optional/bonus, §4 the re-skin beats, §5 build
  steps) is faithfully realized: params block with default, `params$` filter, `output: asis`
  heading, `!expr` caption, `-P` override, Render-button caveat — all present and in the
  planned order. Reference file is in the `_quarto.yml` render list (`:23`) and has a staged
  freeze (`_freeze/labs/quarto/penguins-by-species/`), so it renders as a site page and the
  freeze gate is clean.
- **No regression to protected material.** The Authoring and Citations challenges, the
  accessibility scaffolding, and the Troubleshooting box are untouched by this cycle; the
  bonus is strictly additive and downstream. The "Two challenges" framing in the Scope
  callout remains accurate because the bonus is deliberately not counted as a challenge.
- **Nothing previously flagged reappears.** No re-litigation of prior dispositions; the two
  P2s above are new and specific to this cycle's additions.

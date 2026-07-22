# Pedagogue review — Day-2 arc (`day2-arc`)

- **Reviewer:** workshop-reviewer-pedagogue
- **Date:** 2026-07-08 · **Reference commit:** `9abf90f`
- **Scope:** the WHOLE Day-2 session as one ~2h experience, read ACROSS artifacts — arc-level
  pacing, coherence, motivation seams, and the learning journey from Learning-Outcomes open to
  "What you can do now" close. **Not** a re-review of each file (WP3 deck / WP4 lab were reviewed
  per-file on 2026-07-08).
- **Files:** `slides/quarto-projects/index.qmd` (deck) · `labs/quarto-projects/index.qmd` (lab) +
  `starter/` + `solution/` · `labs/quarto-projects/dashboard.qmd` (new Demos-tail artifact).
- **Not re-litigated (decided/fixed per the brief):** Part budgets as a ceiling with named
  shock-absorbers; publish = watch-me / payoff = render+output-dir; Part 2 opens from the shipped
  `solution/`; Follow-along + Your-turn markers; Dashboards deliberately in the cut-able tail.

## Overall verdict

As one journey, the Day-2 arc holds together and is pedagogically ready. The through-line —
*one file → a whole site → shipped* — is stated in the Learning Outcomes, restated at each Part
frame, carried by a single recurring penguins figure across deck/lab/solution/dashboard, and
mirrored objective-for-objective at the "What you can do now" close (with a two-axes Day-1/Day-2
tie-back). The time budget sums realistically: each ~1h part lands at frame(5) + concept/demo
(~18/~15 ceiling) + hands-on(30) + tail, inside the ~55-min effective slot. The Your-turn
transitions now name the right lab Challenge by the same word, and the Dashboards demo sits
correctly after the payoff and the close, cut-able and static, eroding nothing. Every P1/P2 from
the two per-file reviews has been addressed. The residual items are arc seams only: there is no
scripted Part-1 regroup/bridge beat across the ~1h between-parts gap, and `_metadata.yml` is taught
in the deck but never touched in the lab. Neither is blocking.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

None. No arc-level blocker: the through-line is traced end to end, the budget sums fit, the
between-parts gap is de-risked by the shipped `solution/` fallback, and every prior P1 is resolved.

## 🟡 P2 — nice-to-have

### P2-1 · No Part-1 recap/bridge beat across the ~1h between-parts gap (the seam that most needs a beat)
`slides/quarto-projects/index.qmd:204-216` — the deck jumps straight from `## Your turn` (Website
Challenge, `:204-214`) to `# Part 2 — Scale & ship` (`:216`). There is **no Part-1 closing slide**.
The per-part budget explicitly allocates *5 min recap + bridge* to Part 1 ("next: make builds
reproducible, then publish" — `topic-store.md` § Time budget), and Day 2 is two separate 1h slots
with a **~1h gap** in between (13:30–14:30 + 15:30–16:30). Ending Part 1 on "regroup in ~30 min"
with no slide leaves the after-exercise regroup, the "here's the branded site you just built," and
the re-motivation after the gap entirely ad-lib. The *forward* half of the bridge is partly
recovered by the Part-2 frame subtitle ("Make builds reproducible, then publish — how your team
ships the capstone", `:216-218`) and the Part-2 "Follow along … back in your project's `_quarto.yml`"
(`:222`), so this is P2 not P1 — but the *backward* half (close the Part-1 loop, restate what they
built) has no home. Cheapest fix: a one-line presenter note on `your-turn-1` ("regroup: you built a
branded, navigable site; after the break we make it reproducible and ship it"), or a short bridge
slide. This is the one place the arc's coherence depends on unscripted delivery across a long gap.

### P2-2 · `_metadata.yml` is deck-only — a concept shown but never practiced (densest early load)
`slides/quarto-projects/index.qmd:81-97` teaches `_metadata.yml` plus the three-level precedence
rule (header > `_metadata.yml` > `_quarto.yml`) as its own slide, immediately after the `_quarto.yml`
slide (`:47-79`). That is **three config locations + a precedence order introduced back-to-back,
before the learner has built anything** — the densest cognitive-load moment in Part 1. Yet the lab
(`labs/quarto-projects/index.qmd`) never uses or mentions `_metadata.yml` at all: it is taught and
never touched. It is intentionally a "shown slide" for the NBIS fold-in (`topic-store.md`), so this
is an arc-coherence flag, not a cut demand — but if Part 1 runs long, `_metadata.yml` is the
natural first trim (a concept with no hands-on anchor), even though the *named* Part-1 shock-absorber
is Cross-refs. Worth a presenter awareness note: it can be compressed to a one-line "and folder-level
defaults live in `_metadata.yml`" without losing anything the lab depends on.

### P2-3 · `your-turn-2` under-represents the freeze half of Ship-it (carried-forward, not new)
`slides/quarto-projects/index.qmd:298-300` frames the Ship-it Challenge as "render your project to
`_site/`", but the lab's Ship-it is **primarily a freeze exercise** — Tasks 1-2 are freeze/see-the-skip,
Task 3 is render (`labs/quarto-projects/index.qmd:134-148`). Freeze is also the load-bearing Part-2
teach (8 of the 15 concept minutes). So the slide pointer that lands the learner on the lab leads with
the smaller half. The concept *order* (Freeze → Publishing) does match the lab order, so this is only a
framing/expectation seam at the landing, not a sequencing error. (This echoes the WP4 lab review's
"minor note, no action needed" — flagged here as still-present at the arc level because it shapes what
the learner expects Ship-it to be.) Optional: add "make builds reproducible with **freeze**, then
render to `_site/`" to the callout so the slide word matches the lab's actual emphasis.

## ✅ Pedagogical strengths confirmed (arc-level)

- **The through-line is visible and traced end to end.** *One file → many → shipped* runs from the
  Learning Outcomes ("the same penguins work, grown from one file into a website your team can
  publish", `slides:36`) through both Part frames ("From one file to a whole site", `:45`; "Scale &
  ship", `:216`) to the two-axes close ("one document to a branded PDF (Day 1), one folder to a
  published site (Day 2) — everything your capstone needs", `:313-314`). No dangling promise.
- **One recurring figure carries continuity across every artifact.** The body-mass-by-species boxplot
  appears in the deck (`slides:121-131`), the lab target image (`labs:93-105`), the starter/solution
  analysis pages (`starter/analysis.qmd:16-23`), and the dashboard (`dashboard.qmd:51-57`) — the same
  visual anchor everywhere, so the learner never re-orients to a new subject when moving deck→lab→demo.
- **Objectives promised and mirrored.** `## Learning Outcomes` (`slides:28`) → `## What you can do now`
  (`slides:303`) map objective-for-objective (structure / branded website + cross-refs / reproducible +
  publish). The LO's "publish it" is honestly reconciled with the render-payoff/watch-me design at the
  wrap ("publish the **output folder**", `:309`) — the promise/delivery altitude is squared, not
  papered over.
- **Budget sums are realistic per part.** Part 1 = 5 concept slides for a ~18-min ceiling + frame(5) +
  hands-on(30); Part 2 = 3 concept slides for ~15 + frame(5) + hands-on(30) — each inside the ~55-min
  effective slot with room to aim early. The cut-able tail (Demos + Thank-you) is Part-2 overflow, so
  timing pressure trims the tour, never the 30-min hands-on.
- **The wrap survives a cut.** Order is close (`## What you can do now`, `:303`) → optional Demos-if-time
  (`:316`) → Thank-you + Learn-more (`:331-338`). The recap+close is delivered *before* the cut-able
  demos, so a learner gets the mirror-back-to-objectives whether or not the demos run — exactly the
  pacing rule ("put the wrap-up last so it survives a cut").
- **Your-turn transitions land the learner correctly.** `your-turn-1` names the **Website Challenge**
  (`slides:206-209`) and `your-turn-2` the **Ship it Challenge** (`:298-300`), both linking the lab;
  the lab headings match by word (`labs:43`, `:122`). One vocabulary, right Challenge, right moment.
- **The ~1h gap does not strand anyone.** Part 2 opens from a shipped, complete Part-1 project:
  `solution/` contains a working `_quarto.yml` + `_brand.yml` + both pages, and — verified — it does
  **not** already carry `freeze:`, so Ship-it Task 1 ("add freeze") is a genuine step even for a
  learner who copies the solution wholesale (`solution/_quarto.yml`, `labs:129-131`). The rule-2 seam
  the WP4 review flagged is closed.
- **The new Dashboards demo sits exactly right.** It is post-payoff and post-close (`slides:316-329`,
  after `## What you can do now`), static (`format: dashboard`, no server), linked not built live, and
  self-contained (`dashboard.qmd`) — a cut-able bonus that teaches the layout model (rows / valueboxes /
  tabset) without touching the sacred hands-on, with a "share with a wet-lab collaborator" why-I-care.

## 📝 Evolution since the previous review

This is the first **arc-level** Day-2 pedagogue pass; the baselines are the two per-file reviews of
2026-07-08 (`review-2026-07-08-wp3-deck-pedagogue.md`, `review-2026-07-08-wp4-lab-pedagogue.md`).
Reading the arc as one journey, **every P1/P2 from those reviews has been addressed** at commit
`9abf90f`:

- **WP3 P1-1 (missing Follow-along markers)** → both present now: `slides:49` (Part 1) and `:222`
  (Part 2 Freeze). Both transitions of rule 9 are realized.
- **WP3 P2-1 / P2-2 (CI / Shinylive glossed after first use)** → glossed inline at first use:
  `slides:232` (CI = "a build that runs on every push") and `:328` (Shinylive = "Shiny running in the
  browser, no server").
- **WP3 P2-3 (Part-2 frame dropped the capstone hook)** → restored: `slides:216-218` now reads "how
  your team ships the capstone."
- **WP4 P1-1 (Part 2 can't open from a shipped project — rule-2 regression)** → resolved: the shipped
  `solution/` is a complete Part-1 site and the Ship-it "Starting point" points the stranded learner to
  it (`labs:129-131`).
- **WP4 P2-3 (deck Your-turn didn't name the Challenges)** → fixed: `slides:207` and `:299` now name
  "Website Challenge" / "Ship it Challenge" by word.

What was already good and holds up at the arc scale: the LO↔wrap mirror, the two-axes framing, the
Challenge/Tasks/You-should-see/Hint/Solution structural parity with Day 1, and the honest
watch-me/render-payoff split. **No regressions.** The only items that survive to this pass are the two
seams a single-file review can't see — the unscripted Part-1→gap→Part-2 bridge (P2-1) and the
deck-taught-but-lab-orphaned `_metadata.yml` (P2-2) — plus the carried-forward Ship-it framing
emphasis (P2-3). All P2.

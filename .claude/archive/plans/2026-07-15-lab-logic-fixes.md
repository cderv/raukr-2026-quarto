# Plan — apply the 2026-07-15 lab-logic review fixes

**Source:** `.claude/archive/reviews/review-2026-07-15-lab-logic-flow.md` (7-agent panel).
**Goal:** apply all P1 + P2 findings. **0 P0.** Structure/exercises are sound; the work is
(a) make the two-cycle structure *visible*, (b) close the Day-2 cwd/nested-project trap, (c) fix two
Day-1 slide under-teaches, (d) polish.

## Execution model

- **Four editing subagents, partitioned by file** (no file touched by two agents → no edit conflict):
  - **Agent A** → `slides/quarto/index.qmd` (Day-1 deck)
  - **Agent B** → `slides/quarto-projects/index.qmd` (Day-2 deck)
  - **Agent C** → `labs/quarto/index.qmd` + `setup.qmd` (Day-1 lab + setup)
  - **Agent D** → `labs/quarto-projects/index.qmd` (Day-2 lab)
- **Agents EDIT ONLY.** They must NOT run `quarto render`, NOT `git` anything, NOT touch other files.
  Locate edit sites by content (not line numbers — lines shift). Preserve house style.
- **Orchestrator (me), after agents return:** render each edited executable `.qmd` sequentially,
  grep rendered HTML for `?@`/`[?]` (no broken refs), stage `_freeze/`, commit per deck/lab, push.
  Then: worklog entry, flip the ledger disposition to ✅ applied, move this plan to `archive/plans/`.

## House-style constraints (all agents)

- Slides `format: revealjs`; incremental reveals use `. . .`; mode-markers are callouts titled
  **"Follow along"** / **"Your turn"**. Website pages `format: html`. Always keep `fig-alt` on figures.
- Keep additions tight — this is a ~18–20 min Part-1 budget. New slides = one screen, DEMO pace.
- Don't renumber or restructure beyond the specified edits.

---

## Agent A — `slides/quarto/index.qmd` (Day-1 deck)

**P1-5 · Fix the broken cross-ref demo.** In the `tbl-summary` cell (the `gt` cell under
`## Tables`), add a caption so `@tbl-summary` resolves: add `#| tbl-cap: "Mean bill length per
species."` to the cell. (Without it the very slide teaching cross-refs renders `?@tbl-summary`.)

**P1-6 · Show the margin-layout syntax.** On `## Layouts for a research audience` (`#layouts`), which
is currently prose + links with no code, add one minimal code line so the follow-along beat has
something to type. Add a short fenced example after the bullets:
```` markdown
``` {.r}
#| column: margin
#| fig-cap: "Bill length by species."
# a margin figure — caption and all
```
````
(one line of prose: "A cell's `#| column: margin` drops its output into the margin.") Keep it minimal.

**P1-2 · Add a "How today works" roadmap slide** immediately after `## Learning Outcomes`:
```` markdown
## How today works

Two rounds, each the same shape — **watch → follow along → your turn**:

- some slides I just talk through; when it's hands-on you'll see a **Follow along** callout;
- each round ends with a **~30-minute Challenge** in the lab — solutions are folded in, so you can self-check;
- a **break** sits between the two rounds.

::: notes
Say once, up front, so the room has the map. The "Follow along" / "Your turn" callouts flag every switch.
:::
````

**P1-3 · Add a follow-along STOP cue.** The live build ends around `## Inline code`; the deck then
returns to watch-only concept slides (`## Layouts …`). At the top of the Layouts slide add a minimal
cue so followers stop typing, e.g. an italic lead line: *"Eyes up — the next few slides are concept,
no need to type along."* (One line; don't overdo it.)

**P1-4 · Show the real break.** On the Part-1 `## Your turn` slide the callout says "regroup in ~30
min" but the actual ~1h break is only in notes. Add the break to the on-slide callout text:
"…then a **break** — back after." (Keep the "~30 min" lab framing; just surface that a break follows.)

**P2 · Part-1 micro-close.** On that same Part-1 Your-turn slide add one closing line mirroring Part
2's "What you can do now": *"You can now author a figure, a cross-referenced table, and margin layout
— after the break we cite it and ship a branded PDF."*

**P2 · Reference-list placeholder.** On `## Citations` add one line: "the reference list renders at
the end automatically, or wherever you drop `::: {#refs} :::`."

**P2 · Explain `fig-alt`.** On `## Figures & cross-references` add one clause on what `fig-alt` is and
why (accessibility — screen-reader text), since every example cell uses it but none explains it.

**P2 · `output-location` is slide-only.** On the Figures slide, add a surface "(slide-only)" marker
next to `#| output-location: column` (it's a revealjs placement, currently disambiguated only in notes).

**P2 · Your-turn deep links.** The two "Your turn" slides link to the lab top; add anchors to land on
the named Challenge: `../../labs/quarto/index.qmd#authoring-challenge` and
`…#citations-challenge`.

---

## Agent B — `slides/quarto-projects/index.qmd` (Day-2 deck)

**P1-2 · Add the same "How today works" roadmap slide** after `## Learning Outcomes` (same template as
Agent A; wording generic to the two rounds).

**P1-3 · Follow-along STOP cue.** The Day-2 build returns to concept around `## Cross-references`; add
the same minimal *"Eyes up — concept, no need to type"* lead there. (Day 2 already has the
`callout-warning` "Watch-me — not a live Your turn" idiom — stay consistent with it.)

**P1-4 · Show the break** on the Part-1 `## Your turn` slide (same as Agent A).

**P1-1 (slide half) · Situate `_quarto.yml`.** On `## Why a project` / the `_quarto.yml` slide add one
line: "Quarto uses the **nearest `_quarto.yml`** up the tree as the project root — the workshop repo
already has one, so *your* project is the `starter/` subfolder." (This sets up the lab's cwd step.)

**P2 · Part-1 micro-close** on the Part-1 Your-turn slide (mirror Part 2's close), one line.

**P2 · "grown from one file" seam.** The Learning-Outcomes line "the same penguins work, grown from
one file into a website" oversells continuity (the lab hands a fresh `starter/`). Soften to: "the same
penguins data — a fresh set of pages grown into a website."

**P2 · Your-turn deep links** → `../../labs/quarto-projects/index.qmd#website-challenge` and
`…#ship-it-challenge`.

---

## Agent C — `labs/quarto/index.qmd` + `setup.qmd` (Day-1 lab + setup)

**P1-8 · Typst render routes (Render button gives no PDF).** In the Citations Challenge Typst step
(the `quarto render … --to typst` task) state BOTH routes and the caveat: "Render with the CLI
`quarto render your-doc.qmd --to typst`, **or** set `format: typst` in the YAML and use your editor's
Render button — the button renders whatever `format:` is declared, so with `format: html` you'll get
no PDF." Align the solution hint (which says set `format: typst`) with the task.

**P1-7 · Font pre-warm (in `setup.qmd`).** Add a short note to `setup.qmd`: "The first Typst render
downloads Google fonts (Albert Sans / Fira Mono). Do it once **before** the session — e.g. render the
shipped `labs/quarto/sample-typst.qmd` — so you're not fetching on conference wifi." Keep it a note,
non-blocking.

**P2 · Typst PDF output location.** Near the Typst render task add one line: "rendering the shipped
`starter.qmd` lands the PDF under `_site/…` (it's in the site's render list); a brand-new doc renders
the PDF next to its source."

**P2 · Web→local bridge + setup back-ref.** In Authoring Challenge task 1 ("Create a new `.qmd` inside
`labs/quarto/`…"), add "in your cloned repo" and a pointer to the setup block: "(the setup cell at the
top of this page)".

**P2 · "Typst is bundled" reassurance.** In the Citations Challenge (or its Troubleshooting), add:
"Typst is bundled in Quarto ≥ 1.8 — nothing to install; check `quarto --version`."

---

## Agent D — `labs/quarto-projects/index.qmd` (Day-2 lab)

**P1-1 (lab half) · Working directory.** This is the top-priority fix.
- Make the first render step consistent with the rest: the participant should `cd starter/` FIRST,
  then `quarto render analysis.qmd` (drop the `starter/analysis.qmd` prefix form, or explicitly say
  "from the repo root this builds into `_site/`"). The two render steps must use the SAME cwd.
- Correct the "lands an `.html` next to the source" claim: from the repo root the workshop's own
  `_quarto.yml` (`type: website`, `output-dir: _site`) redirects output to `_site/…`, NOT next to the
  source. State the real behaviour.
- Add a **Troubleshooting** entry: "**Rendered but can't find the HTML?** You're at the repo root — the
  workshop's own `_quarto.yml` sent the output to `_site/`. `cd starter/` first so your project's
  `_quarto.yml` governs."

**P2 · Reword the pre-done stretch task.** The Website Challenge stretch says "cross-reference the
figure — it already has one," but `starter/analysis.qmd` already contains `@fig-mass`, so there's
nothing to do. Make it a real action: "add a second cross-reference to the table (`@tbl-means`), and a
plain link from `index.qmd` to the analysis page." Mirror it in the "You should see" box.

**P2 · Stronger Ship-it success signal.** The current "done when the log shows the R cell skipped" is
an absence-of-compute tell that's easy to miss. Add: "drop `cat(format(Sys.time()))` in a cell — on
the frozen second render the timestamp does **not** change: a visible pass/fail."

**P2 · Starter location bridge.** At first mention of `starter/`, say "in your cloned repo, the
`labs/quarto-projects/starter/` folder" (only `solution/` currently gets the "in your cloned repo"
framing).

**P2 · Setup-cell clarity.** The lab's opening `library()/data(penguins)` cell exists only to render
the lab's own target figure; add a comment "(renders the target figure below — you'll work inside
`starter/`)" so participants don't think it's step zero.

---

## Done criteria

- All four files edited per the specs; each executable `.qmd` re-rendered clean; rendered HTML has no
  `?@`/`[?]`; `_freeze/` staged.
- Commits pushed to `claude/code-review-feedback-y5fa6q`.
- `.claude/worklog.md` updated; ledger row flipped to ✅ applied with commit refs; this plan moved to
  `.claude/archive/plans/`.

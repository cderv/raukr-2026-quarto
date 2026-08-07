# Day-1 rework plan — a starter for the Authoring Challenge, and one role per file

Status: **decided 2026-08-07, awaiting approval to build.** Written 2026-08-07 after a lab review found that Day-1 Part 1
hands over the syntax it is meant to teach, and that neither of the two files the lab calls a
reference is reachable from its tasks. Nothing here is applied. Every decision below is
settled; what remains is approval, then the build. After that, the lab is the truth wherever the two
differ.

This finishes a job that was scoped and left half-done. `day2-rework-plan.md` § The problem in one
line named the defect on 2026-08-03 — *"the fade runs backwards: Day 1 withholds the learning target
and hands over the incidental, while Day 2 supplies the complete answer at every step"* — and the
fix it describes was applied to Day 2 only, on 2026-08-05.

**Build this on current `main`.** The demo-render pipeline (`tools/render-demos.R`, `just demos`,
run automatically by `just render`) landed after the branch this plan was drafted on, and it carries
a per-file manifest that any new or renamed Day-1 file has to be added to. Design and verify against
`main`, not against a checkout that predates it.

## Ground truth this is built on

- `workshop-pacing.md` § Exercise design: "starter files, not instructions on slides"; exercise files
  are "minimal: working code, bare structure — participants add the new concepts"; "keep the goal,
  tasks, and checkpoint aligned".
- `topic-store.md` § Time budget: Day-1 Part 1 = **45 min** hands-on, Part 2 = **~40 min**.
- `day2-rework-plan.md` § The principle: state the task and the acceptance test, withhold the config,
  ladder the help. The four-layer authoring shape (Goal / You should see / Hint ladder / Solution) is
  inherited wholesale, not re-derived.
- `rules/exercises.md` § Structural invariants: `labs/` is source, `exercises/` is generated, the
  Day-1 working and reference files stay **off** the site render list, solutions are sibling folders.
- Prior art: the rr2026 Typst tutorial, `exercises/01-document-typst/`. Its starter ships the R
  complete and the deck says so out loud ("no R to write in the main steps"); its step table is
  *number / action / what you should see / doc link*, where the action states the goal and never the
  syntax; its correction carries a warning naming **how** it exceeds the exercise.

## The problem in one line

Every exercise should satisfy its convergence equation (below), applied literally. Day 2 passes
on every step. Day-1 Part 1 has no starter and supplies the exact code in tasks 2-6, so 45 minutes
of budget buys about 15 minutes of transcription. Day-1 Part 2 has a starter and a named solution
that are two unrelated documents, so a participant self-checking has nothing to check against.

## The principle

Give participants **working R code** and ask them to add the **Quarto authoring features**. The R is
not the learning target and never was; the cross-reference, the caption, the margin, the alt text
are. This is the one thing not up for decision below.

## The three convergence equations

Every claim in this plan reduces to these. Use the applicable one; never write the ambiguous
"starter + tasks".

```
authoring-starter.qmd  +  Part-1 tasks       =  authoring-checkpoint.qmd
authoring-checkpoint.qmd  +  Part-2 tasks    =  solutions/day1/penguins-report.qmd
authoring-starter.qmd  +  all Day-1 tasks    =  solutions/day1/penguins-report.qmd
```

The third is the first two composed, and it is the one a participant who finishes both parts should
be able to check themselves. Today none of the three holds.

## Governing rule — file roles, not file counts

Every file has one clearly named purpose, and no two files claim the same scope. Duplication is not
the defect; ambiguity is. A completed Part-1 checkpoint is a legitimate fallback for Part 2 and is
not to be removed for tidiness.

The current naming already fails this, and the participant README has to apologise for it:
`day1-intro/README.md` says of `citations-starter.qmd` — *"Despite the name, it is not where you
start."* A file whose README has to deny its own name is misnamed.

## File roles

| file | starting state | participant edits | final scope | delivery location |
|---|---|---|---|---|
| `authoring-starter.qmd` *(new)* | setup cell, prose, working `gt` + `ggplot` — no labels, captions or alt text, plain `color = species` | all Part-1 tasks | left-hand side of equation 1 | `day1-intro/` |
| `authoring-checkpoint.qmd` *(rename of `citations-starter.qmd`)* | complete Part-1 report | none — read-only; copied to `my-report.qmd` by anyone who did not finish Part 1 | **equation 1's right-hand side**, equation included | `day1-intro/` |
| `my-report.qmd` | saved from the starter at task 1 | Parts 1 **and** 2 | the participant's complete Day-1 report — their equivalent of `penguins-report.qmd` | not shipped |
| `parameters-starter.qmd` | TODO 1/2/3a/3b, plus a new 3c and the Session appendix | bonus tasks | left-hand side of the bonus equation | `day1-intro/` |
| `sample-typst.qmd` | complete | none — read-only | gains `fig-culmen` (image vendored) and carries the axis disclaimer | `day1-intro/` |
| `_brand.yml`, `references.bib`, `apa.csl` | complete | none | unchanged | `day1-intro/` |
| `day1-intro/README.md` | complete | none | must match the roles above | `day1-intro/` |
| `penguins-report.qmd` | complete | none — read-only | the right-hand side of equation 3 | `solutions/day1/` |
| `penguins-by-species.qmd` | complete | none — read-only | `parameters-starter.qmd` + the bonus tasks (its own equation) | `solutions/day1/` |
| `references.bib`, `apa.csl` (solution copies) | complete | none | unchanged, so the solution renders standalone | `solutions/day1/` |

## Scope guard — this changes guidance, not content

The task list is not under review. Every Day-1 task stays, at the tier it has today: the figure, the
table, the margin element, the accessibility work, the equation. What changes is **where the syntax
lives** (the doc link and the participant's own lookup, not the task text) and **what the participant
starts from** (a working document, not an empty file).

The Day-2 plan's core/stretch re-tiering is *not* inherited. Importing it here turns a guidance fix
into a content review, and a time budget then makes cuts look necessary. It was tried on 2026-08-07
and rejected — if a later pass finds the slot genuinely over-full, that is its own decision with its
own evidence, not a side effect of this one.

## Decisions

**1. File roles — decided.** Add `authoring-starter.qmd` (the bare scaffold) and rename
`citations-starter.qmd` to `authoring-checkpoint.qmd`. Two clearly-named roles in `day1-intro/`,
and it retires the name whose own README has to say "despite the name, it is not where you start".
The rename propagates to every touchpoint in § Delivery consequences.

**2. Part-2 entry point — decided.** A participant who finished Part 1 **continues in their own
`my-report.qmd`**. They never abandon it. `authoring-checkpoint.qmd` is the fallback for those who did
not finish, and they **save a copy of it as `my-report.qmd`** before starting Part 2 — so from task 1
of Part 2 onward there is exactly one filename in the lab's instructions, whichever route a
participant took.

The checkpoint must be **the document Part 1 produces**, per equation 1. That equality is the fix:
today's fallback is a different report from the Part-1 target, which is why nothing a participant
builds can be checked against anything shipped.

**3. The Day-1 reference — decided.** `solutions/day1/penguins-report.qmd` becomes exactly the
right-hand side of equation 3.

- The **`fig-culmen` figure relocates** to `sample-typst.qmd`, which already exists as the branded
  showcase and is already rendered by `00-check-setup.R`. Nothing is deleted; it moves to the file
  whose role is to go further, and the remote-image render risk leaves the file the lab offers as a
  download.
- The **`gt` formatting needs no relocation.** `sample-typst.qmd` already demonstrates richer table
  work than `penguins-report.qmd` does (`theme_brand_gt`, `opt_table_font`, `opt_row_striping`, a
  `cells_title` style). So the reference's table simply becomes the one the task produces, and the
  showcase of what `gt` can do stays where it already lives.

**4. The accessibility task keeps all three parts — decided.** The starter ships the scatter plot
with a plain `color = species` and the default palette. The participant adds `shape = species`,
`scale_color_okabe_ito()` and `#| fig-alt:`, exactly as today.

This is a deliberate exception to "participants add Quarto features, not R", and the reason is that
the alternative erases the lesson. Ship the plot already CVD-safe and redundantly encoded, and the
task shrinks to writing alt text, the "You should see" has nothing to show, and nobody learns *why*
a second channel matters — the workshop carries `ggokabeito` as a dependency for precisely this
moment. Two lines of R, deliberately, in the one task where the R edit *is* the teaching.

Everywhere else the principle holds: the `gt` call, the `ggplot` call and the data wrangling arrive
finished.

**5. The disclaimer describes `sample-typst.qmd` only — decided.** The enumerating note at
`labs/quarto/index.qmd:155` goes: by naming three items it certifies everything it omits, which is how
a reader concludes the formatted table is the target. Its replacement attaches to `sample-typst.qmd`
and names an **axis**: that file styles R output *in R* (`theme_brand_gt`, `theme_brand_ggplot2`) and
sets Typst format options, neither of which the lab asks for; for the exercise, the YAML and the cell
options are what count. That is the rr2026 model, and it stays true as the file grows.

It does **not** cover `penguins-report.qmd`. Under decision 3 that file has nothing left to excuse —
see decision 6.

**6. Every divergence is classified, none is disclaimed — decided.** Decision 3 makes
`penguins-report.qmd` equal to equation 3, so a leftover un-tasked addition there is a defect, not
something a note can excuse. Each one resolves in exactly one of three ways: **given** (it ships in
the starter, so it is never un-tasked), **tasked** (a task introduces it), or **moved** (it becomes
showcase material in `sample-typst.qmd`).

| divergence | resolution |
|---|---|
| the `gt` formatting (`tab_header`, `tab_spanner`, `opt_stylize`) versus the three-line snippet in task 3 | **given** — with a starter, tasks stop supplying R at all. The starter ships one finished `gt` call; the task adds `#\| label:`, `#\| tbl-cap:` and the `@tbl-summary` reference. The snippet disappears and the checkpoint/reference disagreement dissolves with it. |
| `fig-width`, `warning: false` on the figure cell | **given** — plumbing, not teaching. Ships in the starter. |
| `fig-cap-location: margin` on the figure cell | **removed** — the margin task targets the counts table. Two margin mechanics in one document with only one of them asked for is what made this confusing. |
| inline R in prose (`nrow`, `combine_words`) | **given** — ships in the starter's prose, and `day1-intro/README.md` names it so nobody meets it cold. It stays taught on the slide and practised in the bonus. |
| the `fig-culmen` figure | **moved** to `sample-typst.qmd`, and **vendor the image** into the payload rather than fetching it. That file is rendered by `00-check-setup.R` on every participant's machine, so a remote fetch there is worse than in a solution. If the zip-size budget objects, drop the figure instead. |
| `@horst2020` | one of its two uses is the `fig-culmen` caption and **moves** with the figure. The prose use becomes **tasked**: Part-2 task 2 already says to cite the data source, and it extends to citing the package the prose credits. |
| the missing `author:` block | **tasked** — Part-2 task 4 already asks for it, so the reference gains it. This is the one divergence that is an omission rather than an addition. |
| bonus: the closing line gains `params$species` | **tasked** — a TODO 3c in `parameters-starter.qmd`, so the bonus satisfies its own convergence equation. |
| bonus: the Session appendix | **given** — ships in `parameters-starter.qmd`. |

## Delivery consequences

Adding or renaming a Day-1 file is never one edit. `rules/exercises.md` § Structural invariants
already names three of these; the rest are the ones a rename reaches that an addition does not.

1. `tools/sync-exercises.R` — one line per file in the `files` manifest.
2. `tools/exercises-scaffold/.github/workflows/render-check.yml` — a render step per file. Miss this
   and nothing validates the new file at all.
3. `tools/render-demos.R` — the `groups` manifest, for any file a participant is meant to end up
   with. It stages by `exercises/` path, so a rename lands here too. Miss it and the demo hub
   silently drops the page; nothing checks for that.
4. `tools/exercises-scaffold/day1-intro/README.md` — the per-file role list participants read.
5. `tools/exercises-scaffold/README.md` — the top-level folder table.
6. `labs/quarto/index.qmd` — **all affected download links**, not a fixed count. Renaming or adding
   starter/checkpoint files changes how many there are.
7. `_quarto.yml` — a **verification, not an edit**. Confirm every new or renamed Day-1
   working/reference file is absent from the site `render:` list; adding one re-acquires a build the
   delivery repo already owns. Only edit the file if an existing entry has to be *removed*. The demos
   are not a way back in — they render as their own throwaway projects.
8. `tools/exercises-scaffold/00-check-setup.R` — only if the setup check should render the new file.
   It currently renders `sample-typst.qmd` on every participant's machine before the workshop.

## Build order

1. Comment hygiene first, as its own commit. It is independent and touches Day-2 files, so it must
   not land inside the redesign diff.
2. Get approval on this note. No lab file or delivery file is edited before that.
3. Wire delivery (§ Delivery consequences) alongside the file that needs it, not after.
4. Build Part 1: starter, task-first rewrite, per-step doc links, acceptance test stated before the
   work, folded solution ladder.
5. Reconcile the reference files against decisions 3 and 6.

## Verification

Render changed sources and stage `_freeze/` → `just exercises` → `just exercises-check` → render and
test the **generated payload** from `exercises/` → commit source, freeze and payload → publish if in
scope → `just published-check` **after** publishing. That last ordering matters: `published-check`
clones the delivery repo and diffs it against `exercises/`, so between the sync and the publish it is
expected to fail, and running it earlier proves nothing.

**A root `quarto render` does not validate these files.** The Day-1 working and reference files are
deliberately off the `_quarto.yml` render list, so the site build walks straight past them. Name and
render each changed off-list `.qmd` **explicitly** to refresh its source and catch its errors.
`just render` does reach them afterwards through `just demos`, but only from the `exercises/` payload
and only once the sync has run — that validates what participants downloaded, not the source you
just edited. Both passes are needed, in that order.

Convergence needs three checks, not one:

- a **literal participant walk**, doing only what each task says and nothing more;
- the same walk against the **generated payload**, because the student-agent harness hands its agent
  `labs/<lab>/index.qmd` from a worktree of this repo and a sync or publish gap is invisible to it;
- **starter plus each task against a per-step checkpoint**, not only against the final solution. A
  lab can converge at the end while diverging in the middle, and the middle is where a participant
  self-checks.

## Deviations from this plan

Record here what landed differently, once anything has landed. The lab is the truth where the two
differ.

*(none yet — nothing applied)*

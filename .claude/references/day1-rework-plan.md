# Day-1 rework plan — a starter for the Authoring Challenge, and one role per file

Status: **three decisions made 2026-08-07, one open.** Written 2026-08-07 after a lab review found that Day-1 Part 1
hands over the syntax it is meant to teach, and that neither of the two files the lab calls a
reference is reachable from its tasks. Nothing here is applied. The two items in § Still open
have to be settled before any lab file is edited; after that, the lab is the truth wherever the two
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

Every exercise should satisfy **starter + tasks, applied literally, equals solution**. Day 2 passes
on every step. Day-1 Part 1 has no starter and supplies the exact code in tasks 2-6, so 45 minutes
of budget buys about 15 minutes of transcription. Day-1 Part 2 has a starter and a named solution
that are two unrelated documents, so a participant self-checking has nothing to check against.

## The principle

Give participants **working R code** and ask them to add the **Quarto authoring features**. The R is
not the learning target and never was; the cross-reference, the caption, the margin, the alt text
are. This is the one thing not up for decision below.

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
| `authoring-starter.qmd` *(new)* | setup cell, prose, working `gt` + `ggplot` — no labels, captions or alt text | all Part-1 tasks | the Part-1 target | `day1-intro/` |
| `authoring-checkpoint.qmd` *(rename of `citations-starter.qmd`)* | complete Part-1 report | none — read-only fallback | **must equal** what Part 1 produces, equation included | `day1-intro/` |
| `my-report.qmd` | saved from the starter | Parts 1 and 2 | the participant's own copy of the Part-1 target | not shipped |
| `parameters-starter.qmd` | TODO 1/2/3a/3b | bonus tasks 1-3 | unchanged | `day1-intro/` |
| `sample-typst.qmd` | complete | none — read-only | gains the showcase material moved out of the solution | `day1-intro/` |
| `_brand.yml`, `references.bib`, `apa.csl` | complete | none | unchanged | `day1-intro/` |
| `day1-intro/README.md` | complete | none | must match the roles above | `day1-intro/` |
| `penguins-report.qmd` | complete | none — read-only | exactly what starter + tasks produce | `solutions/day1/` |
| `penguins-by-species.qmd` | complete | none — read-only | bonus reference; two un-tasked deltas to settle | `solutions/day1/` |
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

**2. Part-2 entry point — decided.** Part 2 starts from `authoring-checkpoint.qmd`, and the
checkpoint must be **the same document Part 1 produces**, not a parallel one. That equality is the
fix: today's starter is a different report from the Part-1 target, which is why nothing a participant
builds can be checked against anything shipped.

**3. The Day-1 reference — decided.** `solutions/day1/penguins-report.qmd` becomes exactly what
starter + tasks produce. The showcase material it currently carries beyond the tasks (the `fig-culmen`
figure, the `gt` formatting stack) moves into `sample-typst.qmd`, which already exists as the branded
showcase and is already rendered by `00-check-setup.R`. Nothing is deleted — it relocates to the file
whose role is to go further. This also removes the remote-image render risk from the file the lab
offers as a download.

## Still open

**A. What the starter ships already applied.** The principle is that participants add Quarto
features, not R. The accessibility task straddles that line: `#| fig-alt:` is a Quarto cell option,
but `shape = species` and `scale_color_okabe_ito()` are edits to the `ggplot` call. Decide whether the
starter ships those two already applied (task keeps only the alt text), or ships the plot without them
and the task keeps all three (accepting one small R edit, for accessibility). Either way the task
stays — this is about the starter's contents, not the task list.

**B. How the remaining gap is disclaimed.** Decision 3 closes most of it, but `sample-typst.qmd`
will now go further than ever, so it needs a note saying **by axis** how — not a list. The current
disclaimer at `labs/quarto/index.qmd:155` enumerates three items, and by enumerating it certifies
everything it omits: a reader sees no mention of table formatting and concludes the formatted table
is the target. The rr2026 correction states the axis instead ("the correction also brands tables and
plots in R; for this exercise only the YAML steps count") and that is the model.

Divergences decision 3 does **not** resolve, each currently silent:

- the `gt` stack in the reference (`tab_header`, `tab_spanner`, `opt_stylize`) against the three-line
  snippet the task supplies, and against the differently-formatted table in the checkpoint file
- `fig-cap-location: margin`, `fig-width`, `warning: false` on the figure cell
- inline R in prose, taught on a slide and never in the lab
- the `fig-culmen` figure, which fetches its image over the network
- `@horst2020`, cited twice and asked for nowhere
- the `author:` block Part-2 task 4 requires and the reference does not have
- in the bonus solution: the closing line gains `params$species`, and a Session appendix appears

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
7. `_quarto.yml` — a **negative** edit: the new files must stay **off** the site render list, or the
   course site re-acquires a build the delivery repo already owns. The demos are not a way back in;
   they render as their own throwaway projects.
8. `tools/exercises-scaffold/00-check-setup.R` — only if the setup check should render the new file.
   It currently renders `sample-typst.qmd` on every participant's machine before the workshop.

## Build order

1. Comment hygiene first, as its own commit. It is independent and touches Day-2 files, so it must
   not land inside the redesign diff.
2. Settle § Still open, record the answers here, get approval. No lab file is edited before this.
3. Wire delivery (§ Delivery consequences) alongside the file that needs it, not after.
4. Build Part 1: starter, task-first rewrite, per-step doc links, acceptance test stated before the
   work, folded solution ladder.
5. Reconcile the reference files against decision 3 and item B.

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

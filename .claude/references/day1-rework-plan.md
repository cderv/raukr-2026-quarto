# Day-1 rework plan — a starter for the Authoring Challenge, and one role per file

Status: **skeleton, decisions open.** Written 2026-08-07 after a lab review found that Day-1 Part 1
hands over the syntax it is meant to teach, and that neither of the two files the lab calls a
reference is reachable from its tasks. Nothing here is applied. The decisions in § Open decisions
have to be settled and this file filled in before any lab file is edited; after that, the lab is the
truth wherever the two differ.

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

## File roles — fill every cell before building

Proposed names are marked *(proposed)*; keeping the existing name is a valid outcome.

| file | starting state | participant edits | final scope | delivery location |
|---|---|---|---|---|
| `authoring-starter.qmd` *(proposed, new)* | OPEN — setup cell + prose + final `gt`/`ggplot` with no labels, captions, alt text? | OPEN | OPEN | `day1-intro/` |
| `authoring-checkpoint.qmd` *(proposed, rename of `citations-starter.qmd`)* | complete Part-1 report | none — read-only fallback | OPEN — does it keep the `eq-ratio` stretch it currently carries? | `day1-intro/` |
| `my-report.qmd` | created by the participant | Parts 1 and 2 | OPEN — is it still created from nothing, or opened from the starter? | not shipped |
| `parameters-starter.qmd` | TODO 1/2/3a/3b | bonus tasks 1-3 | unchanged | `day1-intro/` |
| `sample-typst.qmd` | complete | none — read-only | unchanged; also rendered by `00-check-setup.R` | `day1-intro/` |
| `_brand.yml`, `references.bib`, `apa.csl` | complete | none | unchanged | `day1-intro/` |
| `day1-intro/README.md` | complete | none | must match whatever the roles become | `day1-intro/` |
| `penguins-report.qmd` | complete | none — read-only | OPEN — see decision 5 | `solutions/day1/` |
| `penguins-by-species.qmd` | complete | none — read-only | bonus reference; two un-tasked deltas to settle | `solutions/day1/` |
| `references.bib`, `apa.csl` (solution copies) | complete | none | unchanged, so the solution renders standalone | `solutions/day1/` |

## Open decisions

**1. The Part-1 core finish line.** What must be true for a participant to have "done Part 1"? State
it as one sentence a participant can check themselves.

**2. Core versus stretch, per task.** Fill the tier column. The `Given` / `Withheld` split is the
same convention as `day2-rework-plan.md` Part 1.

| # | Task | tier | ~min | Given | Withheld (the work) |
|---|---|---|---|---|---|
| 1 | open the starter, render it | core | | | |
| 2 | cross-referenced figure | OPEN | | | |
| 3 | cross-referenced table | OPEN | | | |
| 4 | margin element | OPEN — see decision 3 | | | |
| 5 | accessibility (alt text, shape, CVD palette) | OPEN | | | |
| 6 | display equation | OPEN — see decision 3 | | | |

**3. Do the margin and equation tasks stay?** Both are currently in Part 1 — the margin as core, the
equation as stretch. Options: keep as is, demote both to stretch, or cut the equation and reclaim the
minutes for the cross-reference work. Note that `authoring-checkpoint.qmd` already contains the
equation, so a participant who skips it and picks the checkpoint up gets it done for them.

**4. What Part 2 consumes when Part 1 is unfinished.** Today the answer is
`citations-starter.qmd`, and it is a different document from both the Part-1 target and the Day-1
reference. Decide which file Part 2 starts from and make it the same shape as what Part 1 produces.

**5. Which additions intentionally exceed the tasks.** State this **by axis**, not as a list. The
current disclaimer at `labs/quarto/index.qmd:155` enumerates three items, and by enumerating it
certifies everything it omits — a reader sees no mention of table formatting and concludes the
formatted table is the target. The rr2026 correction states the axis instead ("the correction also
brands tables and plots in R; for this exercise only the YAML steps count") and that is the model.

Known divergences to rule on, each currently silent:

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
2. Settle § Open decisions, fill this file, get approval. No lab file is edited before this.
3. Wire delivery (§ Delivery consequences) alongside the file that needs it, not after.
4. Build Part 1: starter, task-first rewrite, per-step doc links, acceptance test stated before the
   work, folded solution ladder.
5. Reconcile the reference files against decision 5.

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

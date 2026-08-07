---
description: Run the labs as a project-novice student agent in isolated worktrees, collect friction reports, and diff each result against its solution.
argument-hint: "[optional lab: quarto | quarto-projects | all (default)]"
---

# Lab run — the student-participant loop

Have a **student agent actually DO the labs** under real conditions and report the friction a real
beginner hits. This is the executing complement to `/start-workshop` (which *reads* the material):

**isolate → do the lab for real → log friction → diff vs solution → triage → fix.**

`$ARGUMENTS` selects the lab: `quarto` (Day 1), `quarto-projects` (Day 2), or `all` (default).

## Steps

1. **Baseline.** Today's date, `git rev-parse --short HEAD`. The worktree runs against **HEAD** —
   if you want the latest edits tested, **commit them first** (uncommitted changes stay in the main
   tree and won't be in the worktree).

2. **Isolate — per lab.** Run `.claude/scripts/lab-run.sh setup <lab>` and capture the printed
   `WORKTREE` / `LAB_URL` / `WORK_DIR` / `SOLUTION`. It renders and serves the site, so `LAB_URL` is
   the lab page as a participant reads it (hints and solutions collapsed, not spread open like the
   source). The script creates a throwaway git worktree
   (real repo checkout: full lab structure, committed `_freeze/`, the `solution/`) and pre-installs
   the content packages into the default R library so a render that fails on a *missing package* is a
   genuine finding, not an environment gap.

3. **Fan out the student(s).** Launch one **`student-participant`** agent per lab (in parallel — one
   message, multiple Agent calls, if running `all`). Brief each with **only**: its `LAB_URL`, its
   `WORK_DIR`, and the report output path
   `.claude/reviews/review-YYYY-MM-DD-labrun-<lab>.md`. The agent's own definition carries the
   persona + hard rules (follow only the lab page; forbidden solution/source/slides/web; open a Hint
   only when genuinely stuck and log it; run every render for real; log friction). It **writes its own
   report** and returns a one-line summary — do not ask for the body.

4. **Diff vs solution.** For each finished run, `.claude/scripts/lab-run.sh diff <lab> <WORK_DIR>` —
   compare the student's produced `_quarto.yml` / `_brand.yml` / pages against `solution/`. A clean
   diff means a novice-following-the-lab reproduced the reference; divergence the student *didn't
   notice* is itself a finding.

5. **Triage.** Read the friction reports + diffs and produce a consolidated triage: the real,
   audience-relevant frictions (separate genuine lab defects from harness artifacts), each with
   `file:section`. Recommend lab-text fixes, and list the concrete defects worth filing as issues.
   **Do not auto-fix** — wait for go-ahead unless told otherwise.

6. **Clean up.** `.claude/scripts/lab-run.sh clean <WORKTREE>` for each (removes the worktree +
   its render churn).

7. **Record.** Friction reports are dated snapshots in `.claude/reviews/`
   (`review-YYYY-MM-DD-labrun-<lab>.md`) — same immutability as the review panel. That directory
   is local-only (gitignored); carry notable findings into the commit message for the fixes.

## Notes

- **Separate signal from artifact.** The prototype (2026-07-21) taught this: a *bare temp copy* strips
  the repo's renv and manufactures a fake "no package" blocker. The worktree + `ensure_pkgs` fix that,
  so what the student hits is real. Still sanity-check any "blocker" against a real participant's
  environment before treating it as a lab defect.
- **Day-1 vs Day-2 shape.** Day 2 (`quarto-projects`) ships a `starter/` folder — `WORK_DIR` is that
  copy. Day 1 (`quarto`) is authored from scratch — `WORK_DIR` is the lab folder; the student creates
  a new `.qmd` there. There may be no `solution/` to diff for Day 1; the diff step just skips it.
- **The student can't do watch-me steps** (a live `quarto publish` needs auth) — that's expected;
  those are watch-me demos, not participant hands-on.

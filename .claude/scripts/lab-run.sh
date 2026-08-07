#!/usr/bin/env bash
# Lab-runner harness — set up an isolated git worktree for a `student-participant` agent to DO a lab,
# then diff the produced artifact against the shipped solution. Driven by /run-labs.
#
# Why a worktree (not a bare temp copy): a worktree is a real checkout of THIS repo, so it carries the
# lab's full structure + the committed `_freeze/` + the `solution/` to diff against, and it's isolated
# from the working tree (its render churn — `_site/`, `_freeze/` — is thrown away with the worktree).
#
# Why we pre-install the content packages: a `.qmd` renders with the KNITR ENGINE (knitr+rmarkdown),
# and a project render from inside `starter/` runs with renv INACTIVE (no `.Rprofile` there), so it
# uses the DEFAULT R library. A real participant has the packages in their global library; this
# sandbox's is bare. `ensure_pkgs` reproduces the participant's "packages are installed" state so a
# render that fails on a missing package is a REAL lab finding, not an environment artifact.
set -euo pipefail

REPO="$(git rev-parse --show-toplevel)"
SCRATCH="${LABRUN_SCRATCH:-/tmp/claude-labruns}"
CONTENT_PKGS='c("knitr","rmarkdown","dplyr","ggplot2","gt","ggokabeito","brand.yml","ggrepel","prismatic")'

cmd="${1:-}"; lab="${2:-}"

ensure_pkgs() {
  # Install the content packages into the DEFAULT user library (the one a render from starter/ uses).
  # Run from /tmp so renv doesn't capture the install into the project library. Idempotent (only missing).
  ( cd /tmp && Rscript -e "p<-$CONTENT_PKGS; m<-p[!p %in% rownames(installed.packages())]; \
      if (length(m)) { cat('installing:', m, '\n'); install.packages(m) } else cat('content packages: all present\n')" )
}

case "$cmd" in
  setup)
    # lab = quarto | quarto-projects  → prints WORKTREE / LAB_URL / WORK_DIR / SOLUTION for the caller.
    [ -n "$lab" ] || { echo "usage: lab-run.sh setup <lab>" >&2; exit 1; }
    ensure_pkgs >&2
    mkdir -p "$SCRATCH"
    wt="$SCRATCH/labrun-${lab}-$(git -C "$REPO" rev-parse --short HEAD)"
    git -C "$REPO" worktree remove --force "$wt" 2>/dev/null || rm -rf "$wt"
    git -C "$REPO" worktree add --detach -q "$wt" HEAD
    # The student works from the lab's starter/ (day-2 model) or the lab folder itself (day-1: authored
    # from scratch, no starter/). Instructions are always read from the canonical page in the main repo.
    if [ -d "$wt/labs/$lab/starter" ]; then work="$wt/labs/$lab/starter"; else work="$wt/labs/$lab"; fi
    # The student reads the lab from the BUILT page, not the source: in source the Hints and Solutions
    # are plain text, so the agent absorbs them before it has tried anything and can no longer report
    # where a participant gets stuck. See references/reviewing-the-live-site.md.
    site="$("$(dirname "$0")/site-serve.sh" start --render | grep '^SITE_URL=' | cut -d= -f2-)"
    echo "WORKTREE=$wt"
    echo "LAB_URL=$site/labs/$lab/index.html"
    echo "WORK_DIR=$work"
    [ -d "$REPO/labs/$lab/solution" ] && echo "SOLUTION=$REPO/labs/$lab/solution" || echo "SOLUTION="
    ;;
  diff)
    # lab, then the WORK_DIR the student produced in → compare config + content against solution/.
    work="${3:?usage: lab-run.sh diff <lab> <work_dir>}"
    sol="$REPO/labs/$lab/solution"
    [ -d "$sol" ] || { echo "(no solution/ for $lab — nothing to diff)"; exit 0; }
    for f in _quarto.yml _brand.yml index.qmd analysis.qmd; do
      if [ -f "$sol/$f" ] || [ -f "$work/$f" ]; then
        echo "=== $f  (solution → produced) ==="
        diff -u "$sol/$f" "$work/$f" 2>&1 | head -50 || true
      fi
    done
    ;;
  clean)
    # arg2 is the worktree path here.
    wt="${2:?usage: lab-run.sh clean <worktree>}"
    git -C "$REPO" worktree remove --force "$wt" 2>/dev/null || rm -rf "$wt"
    "$(dirname "$0")/site-serve.sh" stop >/dev/null 2>&1 || true
    echo "removed $wt"
    ;;
  *)
    echo "usage: lab-run.sh {setup <lab> | diff <lab> <work_dir> | clean <worktree>}" >&2
    echo "  lab ∈ quarto | quarto-projects" >&2
    exit 1
    ;;
esac

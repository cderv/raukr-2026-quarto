#!/usr/bin/env Rscript
# sync-exercises.R -- assemble the participant-facing exercises tree from the course repo.
#
# THE ONLY WRITE PATH to the exercises layout. The generated `exercises/` dir is committed
# (drift-guarded, like a generated-but-versioned artifact) and is what gets force-pushed to the
# public `cderv/raukr-2026-quarto-exercises` repo. NEVER hand-edit `exercises/` -- edit the SOURCE (the
# real, render-validated files under `labs/`, the root `_brand.yml`, and `tools/exercises-scaffold/`)
# and re-run this. A CI drift-guard runs `--check` on every push touching those sources.
#
# Why a manifest (not folder convention): Day 1 `labs/quarto/` is deliberately FLAT (roles by name),
# Day 2 `labs/quarto-projects/` is SPLIT (starter/ + solution/). The manifest absorbs that asymmetry
# and maps each source file to its exercises-repo home -- reshaping labs/ would break the lab prose,
# the `_quarto.yml` render list, and the NBIS fold-in. (See .claude/rules/exercises.md.)
#
# Usage:
#   Rscript tools/sync-exercises.R            # (re)generate exercises/
#   Rscript tools/sync-exercises.R --check    # regenerate, fail if it differs from what's committed

args  <- commandArgs(trailingOnly = TRUE)
check <- "--check" %in% args

ROOT <- tryCatch(system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE),
                 error = function(e) getwd())
setwd(ROOT)
DEST     <- "exercises"
SCAFFOLD <- "tools/exercises-scaffold"

# ---- role manifest -----------------------------------------------------------------------------
# File-level copies: source (repo-relative) -> destination (under exercises/).
files <- c(
  # Day-1 working folder: Part-2 starter, the branded Typst payoff, the params bonus, shared assets,
  # and the FULL root brand (sample-typst.qmd reads it via read_brand_yml()).
  "labs/quarto/starter.qmd"             = "day1-intro/starter.qmd",
  "labs/quarto/sample-typst.qmd"        = "day1-intro/sample-typst.qmd",
  "labs/quarto/penguins-by-species.qmd" = "day1-intro/penguins-by-species.qmd",
  "labs/quarto/references.bib"          = "day1-intro/references.bib",
  "labs/quarto/apa.csl"                 = "day1-intro/apa.csl",
  "_brand.yml"                          = "day1-intro/_brand.yml",
  # Day-1 solution (sibling): the fully-cited report + its own copy of the citation assets so it
  # renders standalone.
  "labs/quarto/penguins-report.qmd"     = "solutions/day1/penguins-report.qmd",
  "labs/quarto/references.bib"          = "solutions/day1/references.bib",
  "labs/quarto/apa.csl"                 = "solutions/day1/apa.csl",
  # The dashboard is BOTH a site page (it stays on the root render list, and the deck links to it)
  # and the reference solution for the Day-2 dashboard step, so it ships from where it already lives
  # rather than being duplicated into solution/.
  "labs/quarto-projects/dashboard.qmd"  = "solutions/day2/dashboard.qmd"
)

# Directory-level copies (whole tree, artifact-stripped): source dir -> destination dir.
dirs <- c(
  # Day-2 working folder: two pages that render on their own but are NOT yet a project. The source
  # starter/ ships no _quarto.yml / _brand.yml -- creating them IS the Day-2 exercise.
  "labs/quarto-projects/starter"  = "day2-projects",
  # Day-2 solution (sibling): its own minimal _quarto.yml + teaching _brand.yml, never nested.
  "labs/quarto-projects/solution" = "solutions/day2"
)

# ---- helpers -----------------------------------------------------------------------------------
# Render churn + VCS/OS noise that must never ship inside the exercises tree (participants render
# fresh). Mirrors the tuto's is_artifact().
is_artifact <- function(path) {
  grepl("(^|/)(\\.quarto|_site|_book|_freeze|\\.git|\\.DS_Store|\\.gitignore)(/|$)", path) ||
    grepl("_files(/|$)", path) ||
    grepl("\\.(html|pdf)$", path, ignore.case = TRUE)
}

copy_file <- function(src, dst) {
  if (!file.exists(src)) stop("manifest source missing: ", src, call. = FALSE)
  dir.create(dirname(dst), recursive = TRUE, showWarnings = FALSE)
  file.copy(src, dst, overwrite = TRUE, copy.mode = FALSE)
}

copy_tree <- function(src_dir, dst_dir) {
  if (!dir.exists(src_dir)) stop("manifest source dir missing: ", src_dir, call. = FALSE)
  rel <- list.files(src_dir, recursive = TRUE, all.files = TRUE, no.. = TRUE)
  rel <- rel[!vapply(rel, is_artifact, logical(1))]
  for (r in rel) copy_file(file.path(src_dir, r), file.path(dst_dir, r))
}

# ---- build -------------------------------------------------------------------------------------
build <- function(dest) {
  unlink(dest, recursive = TRUE, force = TRUE)          # clean rebuild so deletions propagate
  dir.create(dest, recursive = TRUE, showWarnings = FALSE)
  # 1. static scaffold (README, DESCRIPTION, renv.lock, 00-check-setup.R, .Rproj x3, .gitattributes,
  #    .github/) -- copied verbatim, including dotfiles.
  scaffold_rel <- list.files(SCAFFOLD, recursive = TRUE, all.files = TRUE, no.. = TRUE)
  for (r in scaffold_rel) copy_file(file.path(SCAFFOLD, r), file.path(dest, r))
  # 2. manifest: file-level then dir-level (artifact-stripped).
  for (i in seq_along(files)) copy_file(names(files)[i], file.path(dest, files[[i]]))
  for (i in seq_along(dirs))  copy_tree(names(dirs)[i],  file.path(dest, dirs[[i]]))
  invisible(dest)
}

build(DEST)
n <- length(list.files(DEST, recursive = TRUE, all.files = TRUE, no.. = TRUE))
cat(sprintf("sync-exercises: assembled %s (%d files)\n", DEST, n))

# ---- drift guard -------------------------------------------------------------------------------
if (check) {
  status <- system2("git", c("status", "--porcelain", "--", DEST), stdout = TRUE)
  if (length(status)) {
    cat("\nDRIFT: exercises/ is out of sync with its sources. Run `just exercises` and commit.\n")
    cat(status, sep = "\n"); cat("\n")
    quit(status = 1L)
  }
  cat("sync-exercises: exercises/ is up to date with its sources.\n")
}

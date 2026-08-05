#!/usr/bin/env Rscript
# publish-exercises.R -- push the generated exercises/ tree to the participant exercises repo.
#
# The repeatable sync from this course repo (source of truth) to the delivery repo
# `cderv/raukr-2026-quarto-exercises` (what `usethis::use_course()` downloads). Run `just exercises`
# first (the `publish-exercises` recipe does) so exercises/ is current; this script then mirrors that
# tree onto the exercises repo's `main` as ONE clean commit and pushes.
#
# Cross-platform on purpose (participants aren't the audience, but instructors run Windows too): all
# git/file work goes through R's system2()/file.* -- no bash-isms -- per .claude/rules/justfile.md
# ("push shared logic into an R script both OSes call").
#
# Auth: uses whatever git credentials the environment already has (a PAT/gh helper locally; the
# session proxy on Claude Code on the web). No token handling here.
#
# Usage:
#   Rscript tools/publish-exercises.R [repo-url]
#   just publish-exercises                      # default repo
#   just publish-exercises https://github.com/cderv/raukr-2027-quarto-exercises.git

args  <- commandArgs(trailingOnly = TRUE)
# --check: mirror into the scratch clone, report whether the delivery repo differs, push NOTHING.
# This is the only guard on the LAST hop of the pipeline. `sync-exercises.R --check` guards
# labs/ -> exercises/; nothing guarded exercises/ -> the repo participants actually download, so a
# forgotten `just publish-exercises` shipped stale exercises silently (2026-08-03).
check <- "--check" %in% args
args  <- args[args != "--check"]
DEFAULT_REPO <- "https://github.com/cderv/raukr-2026-quarto-exercises.git"
REPO <- if (length(args) >= 1 && nzchar(args[[1]])) args[[1]] else DEFAULT_REPO
BRANCH <- "main"
SRC    <- "exercises"

git <- function(..., dir = NULL, check = TRUE) {
  a <- if (is.null(dir)) c(...) else c("-C", dir, ...)
  # Build a properly-quoted command line ourselves: R's captured-output path runs through the
  # shell WITHOUT quoting args, so a message/path with spaces or parens would otherwise break.
  # shQuote() with the OS-correct type keeps this working on both Unix (sh) and Windows (cmd).
  qtype <- if (.Platform$OS.type == "windows") "cmd" else "sh"
  cmd  <- paste(c("git", shQuote(a, type = qtype)), collapse = " ")
  out  <- suppressWarnings(system(cmd, intern = TRUE))
  st   <- attr(out, "status")
  if (check && !is.null(st) && st != 0L)
    stop("git ", paste(a, collapse = " "), " failed:\n", paste(out, collapse = "\n"), call. = FALSE)
  out
}

ROOT <- tryCatch(git("rev-parse", "--show-toplevel"), error = function(e) getwd())
setwd(ROOT)
if (!dir.exists(SRC))
  stop(SRC, "/ not found -- run `just exercises` first (or `Rscript tools/sync-exercises.R`).",
       call. = FALSE)

sha <- tryCatch(git("rev-parse", "--short", "HEAD"), error = function(e) "unknown")

# --- clone the delivery repo into a scratch dir -------------------------------------------------
tmp <- file.path(tempdir(), "raukr-exercises-publish")
unlink(tmp, recursive = TRUE, force = TRUE)
cat(sprintf("publish-exercises: cloning %s (%s)...\n", REPO, BRANCH))
git("clone", "--depth", "1", "--branch", BRANCH, REPO, tmp)

# Make sure the commit below can find an identity. Two independent ways it goes missing:
#
# 1. R on Windows sets HOME to the user's *Documents* folder, while git reads the global config from
#    $HOME/.gitconfig. So git launched from Rscript resolves NO global identity -- `git config
#    user.name` exits 1 -- even though the same command works in any shell. The publish then dies
#    with "Author identity unknown" after the mirror is already staged (hit 2026-08-05).
# 2. The scratch clone inherits nothing from THIS repo, so a repo-local identity would not carry.
#
# Fix HOME first, then copy whatever this repo resolves into the clone. Signing config is
# deliberately not copied: a scratch clone prompting for a passphrase would hang a non-interactive
# publish, and these commits are content mirrors. GIT_AUTHOR_*/GIT_COMMITTER_*, if the caller
# exported them, still win over both -- that is git's own precedence and a useful escape hatch.
if (.Platform$OS.type == "windows") {
  up <- Sys.getenv("USERPROFILE")
  if (nzchar(up) && !file.exists(file.path(Sys.getenv("HOME"), ".gitconfig")) &&
      file.exists(file.path(up, ".gitconfig"))) {
    Sys.setenv(HOME = up)
  }
}
for (k in c("user.name", "user.email")) {
  v <- tryCatch(git("config", k), error = function(e) character(0))
  if (length(v) && nzchar(v[[1]])) git("config", k, v[[1]], dir = tmp)
}
if (!length(tryCatch(git("config", "user.email", dir = tmp), error = function(e) character(0))) &&
    !nzchar(Sys.getenv("GIT_AUTHOR_EMAIL")))
  stop("no git identity available for the delivery-repo commit -- set user.name/user.email, or ",
       "export GIT_AUTHOR_NAME/GIT_AUTHOR_EMAIL (and the GIT_COMMITTER_* pair).", call. = FALSE)

# --- replace its whole content with exercises/ (a clean mirror, so deletions propagate) ---------
# Wipe everything tracked/untracked except .git, then copy the freshly-synced tree in.
old <- list.files(tmp, all.files = TRUE, full.names = TRUE, no.. = TRUE)
old <- old[basename(old) != ".git"]
unlink(old, recursive = TRUE, force = TRUE)

rel <- list.files(SRC, all.files = TRUE, recursive = TRUE, no.. = TRUE)
for (r in rel) {
  dst <- file.path(tmp, r)
  dir.create(dirname(dst), recursive = TRUE, showWarnings = FALSE)
  file.copy(file.path(SRC, r), dst, overwrite = TRUE, copy.mode = FALSE)
}
cat(sprintf("publish-exercises: staged %d files.\n", length(rel)))

# --- commit + push (no-op if nothing changed) ---------------------------------------------------
git("add", "-A", dir = tmp)
status <- git("status", "--porcelain", dir = tmp)
if (!length(status)) {
  cat("publish-exercises: exercises repo already up to date -- nothing to push.\n")
  quit(status = 0L)
}

if (check) {
  cat("\nDRIFT: the delivery repo does not match exercises/.\n")
  cat("What participants download is NOT what this repo would ship:\n")
  cat(paste0("  ", status, collapse = "\n"), "\n\n")
  cat("Run `just publish-exercises` to update it.\n")
  quit(status = 1L)
}
git("commit", "-m", sprintf("Sync exercises from course repo (%s)", sha), dir = tmp)
cat(sprintf("publish-exercises: pushing to %s %s...\n", REPO, BRANCH))
git("push", "origin", paste0("HEAD:", BRANCH), dir = tmp)
cat("publish-exercises: done.\n")

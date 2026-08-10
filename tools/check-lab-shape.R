#!/usr/bin/env Rscript
# check-lab-shape.R -- check the structure of every Challenge step.
#
# Inside a `## ... Challenge`, each `###` exercise step needs an observable checkpoint and at least
# one collapsed Hint or Solution. A `walkthrough` marker keeps the checkpoint but waives the fold.
# A `reading` marker waives both requirements.
#
# Steps listed in tools/lab-shape-baseline.txt are reported without failing, so the guard can run
# against material that already breaks it. Any step not listed still fails.
#
# Usage:
#   Rscript tools/check-lab-shape.R    # report invalid steps and exit with status 1

ROOT <- tryCatch(system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE),
                 error = function(e) getwd())
setwd(ROOT)

BASELINE <- "tools/lab-shape-baseline.txt"

# Globbed, so a lab added later is checked without editing this script.
LABS <- Sys.glob("labs/*/index.qmd")
if (!length(LABS)) stop("no lab guide pages found under labs/*/index.qmd", call. = FALSE)

# Headings only count outside code fences and outside `:::` divs -- a callout title is itself a `##`,
# and solution blocks quote whole documents.
scan_structure <- function(lines) {
  kind  <- rep("", length(lines))   # "h2" / "h3" / "code" for a depth-0 non-R fence opener
  fence <- 0L                       # backticks holding the open fence, 0 when closed
  depth <- 0L                       # `:::` div nesting

  for (i in seq_along(lines)) {
    line <- lines[[i]]
    ticks <- regmatches(line, regexpr("^`{3,}", line))

    if (length(ticks) == 1L) {
      n <- nchar(ticks)
      rest <- sub("^`{3,}", "", line)
      if (fence == 0L) {
        fence <- n
        # An executable cell is material to read, not an answer on display.
        if (depth == 0L && !grepl("^\\{+r", trimws(rest))) kind[[i]] <- "code"
      } else if (n >= fence && trimws(rest) == "") {
        fence <- 0L
      }
      next
    }
    if (fence > 0L) next

    if (grepl("^:{3,}", line)) {
      if (trimws(sub("^:{3,}", "", line)) == "") {
        depth <- max(0L, depth - 1L)
      } else {
        depth <- depth + 1L
      }
      next
    }
    if (depth > 0L) next

    if (grepl("^## [^#]", line))  kind[[i]] <- "h2"
    if (grepl("^### [^#]", line)) kind[[i]] <- "h3"
  }
  kind
}

check_lab <- function(path) {
  lines <- readLines(path, warn = FALSE)
  kind  <- scan_structure(lines)

  h2 <- which(kind == "h2")
  h3 <- which(kind == "h3")
  problems <- NULL

  for (start in h2) {
    title <- trimws(sub("\\{.*\\}$", "", sub("^## ", "", lines[[start]])))
    if (!grepl("Challenge", title, fixed = TRUE)) next

    end   <- min(c(h2[h2 > start], length(lines) + 1L)) - 1L
    steps <- h3[h3 > start & h3 <= end]

    for (j in seq_along(steps)) {
      from <- steps[[j]]
      to   <- if (j < length(steps)) steps[[j + 1L]] - 1L else end
      span <- lines[from:to]
      step <- sub("^### ", "", lines[[from]])

      declared    <- regmatches(span, regexpr("(?<=<!-- lab-shape: )\\S+", span, perl = TRUE))
      declared    <- if (length(declared)) declared[[1L]] else ""
      known       <- declared %in% c("walkthrough", "reading")
      # A misspelled marker must not waive the guard, so only a known one counts.
      marker      <- if (known) declared else ""
      checkpoint  <- any(grepl("You should (see|be able)", span))
      folded      <- any(grepl('collapse="true"', span, fixed = TRUE)) &&
                     any(grepl("^#{2,3} (Hint|Solution)", span))

      missing <- character()
      if (declared != "" && !known) {
        missing <- c(missing, sprintf("unknown `lab-shape` marker `%s`, expected `walkthrough` or `reading`",
                                      declared))
      }
      if (!checkpoint && marker != "reading") {
        missing <- c(missing, "no `You should see` checkpoint")
      }
      if (!folded && marker == "") {
        exposed <- sum(kind[from:to] == "code")
        detail  <- if (exposed > 0L) {
          sprintf("no collapsed Hint or Solution, and %d code block%s stating the answer in the open",
                  exposed, if (exposed == 1L) "" else "s")
        } else {
          "no collapsed Hint or Solution"
        }
        missing <- c(missing, detail)
      }

      if (length(missing)) {
        problems <- rbind(problems, data.frame(
          # Keyed by title, not line number, so the baseline survives edits above it.
          key  = sprintf("%s::%s::%s", path, title, step),
          text = sprintf("%s:%d  %s / %s\n    %s", path, from, title, step,
                         paste(missing, collapse = "\n    "))
        ))
      }
    }
  }
  problems
}

problems <- do.call(rbind, lapply(LABS, check_lab))
if (is.null(problems)) problems <- data.frame(key = character(), text = character())

baseline <- if (file.exists(BASELINE)) {
  lines <- trimws(readLines(BASELINE, warn = FALSE))
  lines[nzchar(lines) & !startsWith(lines, "#")]
} else {
  character()
}

new    <- problems[!problems$key %in% baseline, , drop = FALSE]
known  <- problems[problems$key %in% baseline, , drop = FALSE]
# A baseline entry matching nothing means the step was fixed or renamed. Either way the line goes.
stale  <- setdiff(baseline, problems$key)
failed <- FALSE

if (nrow(new)) {
  failed <- TRUE
  cat("Challenge steps that do not let a participant try before the answer:\n\n")
  cat(paste(new$text, collapse = "\n\n"), "\n\n", sep = "")
  cat("Give the step a checkpoint and a collapsed Hint/Solution, or declare what it is:\n",
      "`<!-- lab-shape: walkthrough -->` to be followed as written, `<!-- lab-shape: reading -->`\n",
      "for a worked example with nothing to do.\n\n", sep = "")
}

if (length(stale)) {
  failed <- TRUE
  cat("Baseline entries that no longer match a failing step. Delete them from ", BASELINE, ":\n",
      paste0("  ", stale, collapse = "\n"), "\n\n", sep = "")
}

if (failed) quit(status = 1L)

if (nrow(known)) {
  cat("Lab shape OK, with ", nrow(known), " known gap(s) held in ", BASELINE, ":\n",
      paste0("  ", known$key, collapse = "\n"), "\n", sep = "")
} else {
  cat("Lab shape OK: every challenge step offers a try before the answer.\n")
}

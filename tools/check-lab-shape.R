#!/usr/bin/env Rscript
# check-lab-shape.R -- assert every challenge step lets a participant try before showing the answer.
#
# The invariant is in .claude/rules/exercises.md ("Challenge step shape"): inside a `## ... Challenge`
# section, each `###` step carries an observable checkpoint and a collapsed Hint or Solution. Two
# markers under a heading declare a step that is not an exercise: `<!-- lab-shape: walkthrough -->`
# (the participant follows written commands, so the checkpoint stays but the fold is waived) and
# `<!-- lab-shape: reading -->` (a worked example with nothing to do, so neither applies).
#
# This exists because a structural edit can break the shape without touching a word of the guidance:
# promoting a numbered Tasks list to `###` headings gives a section the silhouette of a challenge
# while its steps still state their own answers.
#
# Usage:
#   Rscript tools/check-lab-shape.R    # names every step that breaks the shape, exits 1 on any

ROOT <- tryCatch(system2("git", c("rev-parse", "--show-toplevel"), stdout = TRUE),
                 error = function(e) getwd())
setwd(ROOT)

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
  problems <- character()

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

      marker      <- regmatches(span, regexpr("(?<=<!-- lab-shape: )[a-z]+", span, perl = TRUE))
      marker      <- if (length(marker)) marker[[1L]] else ""
      checkpoint  <- any(grepl("You should (see|be able)", span))
      folded      <- any(grepl('collapse="true"', span, fixed = TRUE)) &&
                     any(grepl("^#{2,3} (Hint|Solution)", span))

      missing <- character()
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
        problems <- c(problems, sprintf("%s:%d  %s / %s\n    %s",
                                        path, from, title, step,
                                        paste(missing, collapse = "\n    ")))
      }
    }
  }
  problems
}

problems <- unlist(lapply(LABS, check_lab))

if (length(problems)) {
  cat("Challenge steps that do not let a participant try before the answer:\n\n")
  cat(paste(problems, collapse = "\n\n"), "\n\n", sep = "")
  cat("Give the step a checkpoint and a collapsed Hint/Solution, or declare what it is:\n",
      "`<!-- lab-shape: walkthrough -->` to be followed as written, `<!-- lab-shape: reading -->`\n",
      "for a worked example with nothing to do.\n", sep = "")
  quit(status = 1L)
}

cat("Lab shape OK: every challenge step offers a try before the answer.\n")

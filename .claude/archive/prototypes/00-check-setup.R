#!/usr/bin/env Rscript
# VALIDATED PROTOTYPE (dry-run the tracker, 2026-07-22) -- lift into the exercises repo root during
# the the tracker build. Ran green end-to-end against a simulated use_course() unpack: verifies the
# 8 packages + R/Quarto/data, then renders day1-intro/sample-typst.qmd from the root (knitr localizes
# wd -> sibling _brand.yml resolves) and warms the Albert Sans Typst font cache. Shells out to the
# Quarto CLI on purpose (no dependency on the {quarto} R package -- not one of the 8).
#
# 00-check-setup.R -- RaukR 2026 Quarto exercises: one-shot setup verifier + Typst font pre-warm.
# Run this ONCE, before Day 1, from the unpacked exercises folder (double-click the .Rproj first).
# It checks R / Quarto / packages / data, then renders day1-intro/sample-typst.qmd -- which downloads
# and caches the Albert Sans brand font (so the in-session Typst render is fast and works offline).

ok <- function(x) cat(sprintf("  [ok]   %s\n", x))
bad <- function(x) cat(sprintf("  [FAIL] %s\n", x))
fails <- 0L
fail <- function(x) { bad(x); fails <<- fails + 1L }

cat("== RaukR 2026 Quarto -- setup check ==\n\n")

# 1. R version
cat("R\n")
if (getRversion() >= "4.5.0") ok(sprintf("R %s (>= 4.5)", getRversion())) else
  fail(sprintf("R %s -- need >= 4.5 (base-R penguins dataset)", getRversion()))

# 2. Quarto CLI
cat("Quarto\n")
qbin <- Sys.which("quarto")
if (nzchar(qbin)) {
  qv <- tryCatch(system2("quarto", "--version", stdout = TRUE), error = function(e) NA)
  if (!is.na(qv) && numeric_version(qv) >= "1.9.0") ok(sprintf("Quarto %s (>= 1.9)", qv)) else
    fail(sprintf("Quarto %s -- need >= 1.9", qv))
} else fail("quarto not found on PATH -- install Quarto >= 1.9")

# 3. Packages (the 8 content packages)
cat("R packages\n")
pkgs <- c("dplyr", "ggplot2", "ggrepel", "gt", "brand.yml", "prismatic", "knitr", "rmarkdown")
have <- pkgs %in% rownames(installed.packages())
for (i in seq_along(pkgs)) if (have[i]) ok(pkgs[i]) else fail(paste0(pkgs[i], " -- missing"))

# 4. Data (base-R penguins, R >= 4.5)
cat("Data\n")
if (requireNamespace("datasets", quietly = TRUE) && exists("penguins", where = asNamespace("datasets")))
  ok("datasets::penguins available") else
  fail("penguins not found -- need R >= 4.5")

# 5. Prove the chain + pre-warm the Typst font cache
cat("Typst render (proves the chain + caches the Albert Sans brand font)\n")
sample <- file.path("day1-intro", "sample-typst.qmd")
if (!file.exists(sample)) {
  fail(sprintf("%s not found -- run this from the exercises root (open the .Rproj)", sample))
} else if (fails > 0L) {
  cat("  [skip] fix the failures above first, then re-run.\n")
} else {
  # Shell out to the Quarto CLI -- do NOT depend on the {quarto} R package (not one of the 8).
  code <- tryCatch(system2("quarto", c("render", shQuote(sample)),
                           stdout = FALSE, stderr = FALSE),
                   error = function(e) 1L)
  res <- identical(as.integer(code), 0L)
  pdf <- file.path("day1-intro", "sample-typst.pdf")
  if (isTRUE(res) && file.exists(pdf)) ok(paste("rendered", pdf)) else
    fail("Typst render failed -- see message above")
}

cat("\n")
if (fails == 0L) cat(">> All good. You are ready for Day 1.\n") else
  cat(sprintf(">> %d check(s) failed -- see [FAIL] lines above.\n", fails))
quit(status = if (fails == 0L) 0L else 1L)

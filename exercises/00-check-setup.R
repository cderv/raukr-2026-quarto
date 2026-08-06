#!/usr/bin/env Rscript
# 00-check-setup.R -- RaukR 2026 Quarto exercises: one-shot setup verifier + Typst font pre-warm.
# Run this ONCE, before Day 1, from the unpacked exercises folder (double-click the .Rproj first, or
# `setwd()` to this folder). It checks R / Quarto / packages / data, then renders
# day1-intro/sample-typst.qmd -- which downloads and caches the Albert Sans brand font, so the
# in-session Typst render is fast and works offline.
#
# Design notes: shells out to the Quarto CLI on purpose -- it does NOT depend on the {quarto} R
# package (not one of the content packages). The sibling _brand.yml in day1-intro/ is auto-discovered
# (knitr localizes the working dir to the .qmd), so this runs correctly from the exercises root.

ok  <- function(x) cat(sprintf("  [ok]   %s\n", x))
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
if (nzchar(Sys.which("quarto"))) {
  qv <- tryCatch(system2("quarto", "--version", stdout = TRUE), error = function(e) NA_character_)
  if (!is.na(qv) && numeric_version(qv) >= "1.9.0") ok(sprintf("Quarto %s (>= 1.9)", qv)) else
    fail(sprintf("Quarto %s -- need >= 1.9", qv))
} else fail("quarto not found on PATH -- install Quarto >= 1.9")

# 3. Packages (the content packages)
cat("R packages\n")
pkgs <- c("dplyr", "ggplot2", "ggrepel", "gt", "ggokabeito", "brand.yml",
          "prismatic", "knitr", "rmarkdown")
have <- pkgs %in% rownames(installed.packages())
for (i in seq_along(pkgs)) if (have[i]) ok(pkgs[i]) else fail(paste0(pkgs[i], " -- missing"))

# 4. Data (base-R penguins, R >= 4.5)
cat("Data\n")
if (exists("penguins", where = asNamespace("datasets")))
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
  # Shell out to the Quarto CLI -- do NOT depend on the {quarto} R package.
  code <- tryCatch(system2("quarto", c("render", shQuote(sample)),
                           stdout = FALSE, stderr = FALSE),
                   error = function(e) 1L)
  pdf <- file.path("day1-intro", "sample-typst.pdf")
  if (identical(as.integer(code), 0L) && file.exists(pdf)) ok(paste("rendered", pdf)) else
    fail("Typst render failed -- run `quarto render day1-intro/sample-typst.qmd` to see the error")
}

cat("\n")
if (fails == 0L) cat(">> All good. You are ready for Day 1.\n") else
  cat(sprintf(">> %d check(s) failed -- see [FAIL] lines above.\n", fails))
# Exit with a status ONLY when run non-interactively (Rscript / CI). Under the documented
# `source("00-check-setup.R", local = new.env())` path this would quit the user's R session --
# on success too.
if (!interactive()) quit(status = if (fails == 0L) 0L else 1L)
invisible(fails)

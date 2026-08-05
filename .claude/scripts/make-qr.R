#!/usr/bin/env Rscript
# Regenerate the site QR code committed at `slides/images/site-qr.svg`.
#
# The deck's QR is a **static committed asset**, not generated at render time:
# the site URL is fixed, so baking it in keeps the decks free of a render-time
# dependency and free of any network call in the room.
#
# Only re-run this if the site URL changes (`site-url` in `_quarto.yml`):
#
#     Rscript .claude/scripts/make-qr.R
#
# Error correction "Q" (~25% recoverable) survives a projector and a phone
# camera at the back of a room better than the default.

url <- "https://cderv.github.io/raukr-2026-quarto/"
out <- "slides/images/site-qr.svg"

# qrcode is deliberately NOT in renv.lock: it is maintenance-only tooling, and an
# explicit snapshot follows Imports, so a Suggests entry would never be captured
# anyway. Nobody rendering the decks needs it. Install it on demand:
if (!requireNamespace("qrcode", quietly = TRUE)) {
  stop("run renv::install(\"qrcode\") first (maintenance-only, not in renv.lock)", call. = FALSE)
}

dir.create(dirname(out), showWarnings = FALSE, recursive = TRUE)

code <- qrcode::qr_code(url, ecl = "Q")
# show_ = FALSE so this stays non-interactive; the quiet zone is on by default
# and scanners need it, so do not trim the border.
qrcode::generate_svg(code, filename = out, size = 300, foreground = "#1c2833",
                     background = "#ffffff", show = FALSE)

cat(sprintf("wrote %s (%d bytes) for %s\n", out, file.size(out), url))

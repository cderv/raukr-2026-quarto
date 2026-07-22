# Setup-page walkthrough — student-participant agent — 2026-07-21

**Scope:** `setup.qmd` only (the `use_course()` clarity pass). A `student-participant` agent walked
the page as a project-novice, in an isolated worktree at HEAD `c1c4bc7` (R 4.6.1, Quarto 1.9.38),
running every step it could. Launched ad-hoc (not via `/run-labs`), scoped to verify the setup path.

**Verdict:** *yes-with-friction* — Steps 1–3 clear; Step 4 had two commands that fail on a
correctly-restored project, plus one genuine content bug in the Typst pre-warm.

## Findings & disposition

| # | Tag | Finding | Disposition (commit `a72e2b8`) |
|---|---|---|---|
| 1 | BLOCKER | `quarto render labs/quarto/sample-typst.qmd` (the font pre-warm) fails: `invalid color name "teal_lighter"` in `gt::cell_fill(pal("teal_lighter"))`, halts before warming fonts. | **FIXED.** Root cause = **non-ASCII `_brand.yml`** (middle-dot in the brand name, em-dashes/§ in comments) unreadable by `read_brand_yml()` under a **C/POSIX locale**, which empties the palette so `pal()` returns the raw string. Code was correct (`brand.yml` normalizes the `teal-lighter` key → `teal_lighter`). Made `_brand.yml` ASCII-only + a keep-ASCII comment. Verified `teal_lighter → #D1E5E6` under `LC_ALL=C` and a clean render (exit 0) under POSIX; freeze regenerated. Known issue from the tuto (`tuto-quarto-typst-rr-2026`): its French content forced a documented locale note; our English content lets us fix it at the source instead. |
| 2 | error | `quarto::quarto_version()` (line 142) throws — the `quarto` R package isn't in `renv.lock` nor the install list. | **FIXED.** Dropped the R call; Quarto version is already proven by `quarto check` / `quarto --version`. |
| 3 | ambiguous | Quoted `quarto check` failure text (`there is no package called 'rmarkdown'`) doesn't match real output (`rmarkdown: (None)` / "not available in this R installation"). | **FIXED.** Updated the quoted text to match. |
| 4 | had-to-infer | First R launch dumps unannounced renv bootstrap noise. | **FIXED.** Added a one-line "that's expected" reassurance to the R-packages step. |
| 5–7 | worked-fine | `R.version.string`, `quarto --version`, `renv::status/restore` (63 pkgs cached → project lib), `quarto check` → `Checking Knitr engine render......OK`, `penguins` check → TRUE. | No change — confirms the happy path. |

## `use_course()` section

Judged **clear and mostly accurate** (the rewrite lands): the 1-2-3 answers where files go, how to
relocate (`destdir`), the delete-ZIP prompt, and where you end up; it explicitly defines "project
root". Two nits: `destdir` shown only in code (mitigated by the path example, left as-is), and the
accuracy caveat the agent couldn't test — **`use_course()` 404s while the repo is private.** That's
the real gate, tracked in `the tracker` (make the repo public before setup goes out).

## Note on faithfulness

Not a from-zero test: the sandbox already had R/Quarto/packages, so this validated instruction
clarity + the runnable checks, not a bare-laptop first run. The genuine from-zero test (esp. the
Windows `renv::restore()` question that gates the companion-package decision `the tracker`) still
wants a clean-machine dry-run.

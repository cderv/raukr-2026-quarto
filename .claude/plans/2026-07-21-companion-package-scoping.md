# Plan — Lean companion R package for RaukR 2026 Quarto (deferred decision the tracker)

*Groundwork for a go/no-go. Grounded in `/workspace/tuto-quarto-typst-rr-2026` (the pattern that
worked) and this repo (the target). Produced by a Plan agent 2026-07-21. **Status: SCOPING — no
build authorized;** the decision stays deferred pending a setup dry-run.*

## 1. Verdict up front

**Lean toward NOT building the full package; if anything, build only `check_setup()` — and only if
a setup dry-run surfaces real friction.** The tuto's "smooth" win came from two things that are
*muted* here.

- (a) *Binary-deps auto-pull*: installing `tutoquartotypst` dragged in all 8 workshop packages as
  P3M binaries. But RaukR already ships `renv.lock` as the pinning source of truth (CLAUDE.md makes
  this non-negotiable), and `setup.qmd` already gives `renv::restore()` plus a plain
  `install.packages(c(...))` fallback — the same 8 small packages (`knitr, rmarkdown, ggplot2,
  dplyr, gt, brand.yml, ggrepel, prismatic`), all on P3M/CRAN binaries. A package `Imports:` list
  would be a *third* copy of that dependency truth, at risk of drifting from `renv.lock`.
- (b) *get-starters*: in the tuto, participants copy starters to a scratch folder. But **both RaukR
  labs are authored in-place in the cloned repo** — Day-1 `labs/quarto/index.qmd` says "create a
  `.qmd` **inside `labs/quarto/`** … next to `references.bib`/`apa.csl`", and Day-2 says
  "`cd starter/` first" inside `labs/quarto-projects/starter/`. So
  `use_course("cderv/raukr-2026-quarto")` (already the shipped path, already cleaned by
  `.gitattributes` export-ignore) *is* the get-starters channel; a package function that copies
  files to a *different* folder actively fights the in-repo lab design.

Add that the material's primary destiny is **folding into the NBIS site** — a cderv-specific
companion package is infrastructure that does **not** travel there, i.e. throwaway maintenance for a
two-afternoon workshop. The one genuinely package-shaped need is a *single* pre-flight check, and
even that is largely covered by `setup.qmd`'s existing `quarto check` + three R lines. **Net: the
package is mostly overkill for RaukR;** document the design so the decision is cheap to flip, but the
default stays `use_course` + `renv` + `setup.qmd`.

## 2. Package identity (if built)

- **Name:** `raukrquarto` (lean, English; avoids the French `tutoquartotypst`). **Collision note:**
  the repo root already has `DESCRIPTION` with `Package: raukr2026quarto` — but that is a *fake*
  DESCRIPTION whose only job is to drive `renv::snapshot(type="explicit")` (its own Description says
  "Not a real R package"). Do **not** reuse that name or file for the companion package; keep the
  root DESCRIPTION as the renv driver and give the companion its own `pkg/DESCRIPTION` with a
  distinct `Package: raukrquarto`. Two DESCRIPTIONs, two roles — the r-universe build targets `pkg/`
  only.
- **Location:** **`pkg/` subdir of this same repo** (mirrors the tuto). One repo for dev-in-the-open;
  r-universe's `subdir` handles the build; sync + CI drift-guard need `labs/` and `pkg/inst/` in the
  same tree. A separate repo would double the release surface for no gain.
- **DESCRIPTION sketch** (`pkg/DESCRIPTION`):
  ```
  Package: raukrquarto
  Title: Companion Package for the RaukR 2026 Quarto Sessions
  Description: Utilities to prepare for and follow Christophe Dervieux's two
      Quarto sessions at RaukR 2026: verify the R + Quarto toolchain and required
      packages, copy the lab starter files locally, and (after trying first) fetch
      the reference solutions. Installing the package pulls the workshop's R
      prerequisites.
  Authors@R: person("Christophe", "Dervieux", , "christophe.dervieux@gmail.com", role = c("aut","cre"))
  License: MIT + file LICENSE       # NB: repo content is CC BY 4.0; the *code* can be MIT
  Depends: R (>= 4.5)               # matches the penguins/base-R floor in project-context.md
  Imports: cli, rlang, quarto, xfun, withr,
      knitr, rmarkdown, ggplot2, dplyr, gt, brand.yml, ggrepel, prismatic
  Suggests: rstudioapi, testthat (>= 3.0.0)
  SystemRequirements: Quarto (>= 1.9.0)
  Encoding: UTF-8
  Language: en
  ```
  The second Imports line = the 8 workshop packages (auto-pull, tuto-style). **Risk to flag:** this
  line must stay identical to the root `DESCRIPTION` `Imports:` and to `renv.lock`; a third source of
  dependency truth is exactly the drift CLAUDE.md's "renv.lock stays the pinning source of truth"
  rule guards against. Mitigation: a small test asserting `pkg` Imports ⊇ root Imports.

## 3. Function surface (LEAN — 3 functions)

| Fn | Signature | Behavior | Tuto analog |
|---|---|---|---|
| **`check_setup()`** | `check_setup(test_render = TRUE)` | Checks in order: R ≥ 4.5, Quarto ≥ 1.9 (`quarto::quarto_version()`), the 8 packages installed, `"penguins" %in% ls("package:datasets")`; then optionally renders a tiny bundled knitr+Typst test doc to prove the chain. Prints a `cli` summary + next step. Returns `invisible(TRUE/FALSE)`. | `verifier_installation()` + `checks.R` — **the one function worth keeping.** |
| **`get_starters()`** | `get_starters(dest = NULL, which = c("all","day1","day2"), force = FALSE)` | Copies bundled starter files to a user-picked folder (RStudio `selectDirectory()` → text prompt → non-interactive default `"raukr-quarto"`). Interactive folder choice = consent. Refuses a non-empty dest without `force`. Solutions never copied here. | `installer_exercices()` (incl. dest-non-empty guard). |
| **`get_solution()`** | `get_solution(which = c("day1","day2"), local = FALSE, dest = "raukr-quarto", force = FALSE)` | **Gated "try first".** Default `local=FALSE`: confirms, opens the solution on GitHub (`labs/quarto/penguins-report.qmd` for day1; `labs/quarto-projects/solution/` for day2). `local=TRUE`: confirms, copies bundled solution sources next to the starters. Both print the "more useful once you've tried" line. | merges `ouvrir_correction()` + `recuperer_correction()`. |

**Explicitly OMIT vs the tuto** (~21 of its 24 functions — Typst/brand noise specific to that
tutorial): all of `brand.R` (charte-switching), all of `typst.R` (`.typ` inspection),
`creer_projet_typst`, the `naviguer.R` catalogue, `reinitialiser_exercice` (in-repo authoring +
`git checkout` covers reset), standalone `exporter_diagnostic`/`diagnostiquer_rendu` (fold into
`check_setup()` failure branch), offline-fonts machinery (RaukR uses Google Fonts + `setup.qmd`
pre-warm), `.Rproj` injection (optional nicety).

## 4. Sync design — `labs/` → `pkg/inst/` (the tricky part)

**The asymmetry, concretely:**
- **Day 2 `labs/quarto-projects/` is already SPLIT** and maps 1:1 to the tuto convention:
  `starter/{index.qmd, analysis.qmd}` + `solution/{_quarto.yml, _brand.yml, index.qmd,
  analysis.qmd}` (+ `dashboard.qmd`, `index.qmd`).
- **Day 1 `labs/quarto/` is FLAT and deliberately so.** project-context.md § Content patterns:
  *"Solutions inline, not a separate folder, by default… ship a separate `starter/` file only when an
  exercise genuinely starts from scratch."* Day-1 files carry roles by name: `starter.qmd` = Part-2
  start; `penguins-report.qmd` = the fully-cited **solution**; `references.bib` + `apa.csl` = shared
  citation assets; `sample-typst.qmd` = branded font pre-warm sample; `index.qmd` = the lab page.
  Lab instructions hard-code these flat paths.

**Recommendation: do NOT reshape `labs/quarto/`.** Reshaping would (a) break the path instructions
inside `labs/quarto/index.qmd`, (b) break the `_quarto.yml` `render:` list (which names
`penguins-report.qmd`/`sample-typst.qmd`/`starter.qmd`), (c) violate the "solutions inline, portable
to NBIS" house rule, and (d) fight the in-repo authoring flow. Instead, drive the sync from a **role
manifest**, not folder convention — absorbs the flat/split asymmetry in ~12 lines of data:

```r
# pkg/data-raw/sync-labs.R (adapt the tuto's sync-exercices.R; English inst/labs/)
manifest <- list(
  day1 = list(
    label    = "Introduction to Quarto",
    starter  = c("labs/quarto/starter.qmd", "labs/quarto/references.bib",
                 "labs/quarto/apa.csl", "labs/quarto/sample-typst.qmd"),
    solution = c("labs/quarto/penguins-report.qmd")
  ),
  day2 = list(
    label    = "Quarto projects",
    starter  = "labs/quarto-projects/starter/",     # whole dir
    solution = "labs/quarto-projects/solution/"      # whole dir
  )
)
# → writes pkg/inst/labs/day1/{starter/*, solution/*}, pkg/inst/labs/day2/{starter/*, solution/*}
```

- **Artifact-stripping:** reuse the tuto's `is_artifact()` — drop `.quarto/`, `_site/`, `_book/`,
  `*_files/`, `*.html`, `*.pdf`, `.DS_Store`, `.gitignore`, **`_freeze/`** (versioned at repo root but
  must not ship inside `inst/` — participants re-render).
- **Clean rebuild:** `unlink(dest, recursive=TRUE)` then re-copy, so deletions propagate.
- **`--check` drift mode:** regenerate, then `git status --porcelain -- pkg/inst/labs` and
  `quit(status=1)` on diff.
- **CI drift-guard** `.github/workflows/pkg-inst-sync.yml` (copy the tuto's): trigger on
  `paths: [labs/**, pkg/inst/labs/**, pkg/data-raw/sync-labs.R]`, one step
  `Rscript pkg/data-raw/sync-labs.R --check`. Same command locally and in CI, no `just` on the runner.
- **Accessor:** `.labs_dir()` → `system.file("labs", package = "raukrquarto")`.

*Alternative (reshape Day 1 into folders): rejected* — see the four breakages. The manifest keeps
`labs/quarto/` untouched and NBIS-portable while still feeding a clean split
`inst/labs/dayN/{starter,solution}`. **This is the single most important design choice in the plan.**

## 5. r-universe wiring (adapted to `cderv`)

Follow `pkg/dev/PUBLICATION-r-universe.md` verbatim, substituting `raukrquarto`:
1. Public repo **`cderv/cderv.r-universe.dev`** (may already exist for the tuto — if so, add a second
   `packages.json` entry) with root `packages.json`:
   ```json
   [ { "package": "raukrquarto",
       "url": "https://github.com/cderv/raukr-2026-quarto",
       "subdir": "pkg" } ]
   ```
2. Install the **r-universe GitHub app** on `cderv`.
3. First build ~20–40 min; dashboard `cderv.r-universe.dev/builds`, page `cderv.r-universe.dev/raukrquarto`.
4. `setup.qmd` install line:
   ```r
   install.packages("raukrquarto",
     repos = c("https://cderv.r-universe.dev", "https://cloud.r-project.org"))
   raukrquarto::check_setup()
   ```
5. Expect + accept the "Namespaces in Imports not imported from" NOTE (the 8 pulled-but-unused
   packages); only "build failed" matters.

## 6. justfile recipes

Add three single-call cross-platform recipes (per `.claude/rules/justfile.md` — no OS split needed):
```just
pkg-sync:            # Regenerate pkg/inst/labs/ from labs/
    Rscript pkg/data-raw/sync-labs.R
pkg-sync-check:      # Verify up to date (regenerate + fail on diff) — same as CI
    Rscript pkg/data-raw/sync-labs.R --check
pkg-site:            # optional pkgdown site
    Rscript -e "pkgdown::build_site('pkg')"
```
Don't touch `clean`'s OS-split logic (`pkg/inst/` is committed-generated, leave it). Sanity-check with
`just --list` / `just --dry-run pkg-sync`.

## 7. Effort + sequencing

**~10–16 h** for the full 3-function package; **~3–4 h** for a `check_setup()`-only slice. **No Day-1
reshaping needed** — the manifest sync avoids it (reshaping would be its own ~2 h task touching
`index.qmd` + `_quarto.yml` + slide callbacks; a reason to prefer the manifest).

Full build order: (1, 0.5 h) scaffold `pkg/` — DESCRIPTION/NAMESPACE/LICENSE/.Rbuildignore. (2, 2 h)
`sync-labs.R` + manifest + `is_artifact()`. (3, 0.5 h) CI + justfile recipes. (4, 3 h) helpers +
`check_setup()` + checks (English, R≥4.5/Quarto≥1.9, penguins check). (5, 2 h) `get_starters()` +
`get_solution()`. (6, 1.5 h) bundled `check_setup` test doc (knitr + minimal `format: typst`). (7,
1.5 h) testthat (non-interactive `force=TRUE`, sync round-trip, Imports ⊇ root) + roxygen/man/README.
(8, 1 h) r-universe registry + app; verify install on a clean container; wire `setup.qmd`.

Descoped `check_setup()`-only: steps 1, 4, 6, 7(partial), 8 → ~3–4 h, no sync/CI/manifest.

## 8. When it's worth it vs overkill

**Stick with `use_course` + `renv` + `setup.qmd` UNLESS a Day-1 setup dry-run reveals:**
- **Windows friction** (*strongest trigger*): `renv::restore()` failing for a meaningful fraction on
  Windows (source compilation, PATH, locale) that binary-first `install.packages()` from r-universe
  would dodge.
- **File-delivery failures:** participants unable to `use_course()`/clone at a rate a one-liner
  `get_starters()` would rescue — *weaker than it looks*, since the in-repo lab design means
  get-starters is only a partial substitute.
- **Toolchain opacity:** `quarto check` + the three R lines proving *insufficient* to catch the real
  failure (e.g. Quarto < 1.9, or knitr engine missing) that a single `check_setup()` with a rendered
  test would catch earlier → argues for the **`check_setup()`-only slice**, not the full package.

**Overkill when** the dry-run shows `use_course` + `renv::restore()` + `quarto check` already gets
~all participants green (the tuto's own smooth experience suggests the 8-binary path is fine on P3M).
Then the package duplicates dependency truth against `renv.lock`, copies files to a folder the labs
don't use, and doesn't travel to the NBIS integration — pure added maintenance for two afternoons.

**Recommended decision rule:** run the `run-labs`/setup dry-run first; build **at most
`check_setup()`**, and only if it demonstrably prevents a real failure `setup.qmd` misses. Reserve
`get_starters`/`get_solution` for a future reuse (a longer or recurring workshop) where the
in-repo-vs-scratch tension is resolved.

## Critical files (for a future implementer)
- `/workspace/tuto-quarto-typst-rr-2026/pkg/data-raw/sync-exercices.R` — sync + `--check` pattern to adapt.
- `.../pkg/R/checks.R` + `.../pkg/R/verifier-installation.R` — the `check_setup()` source to translate.
- `labs/quarto/index.qmd` — hard-codes the flat Day-1 paths that forbid reshaping (drives the manifest).
- `_quarto.yml` — the `render:` list naming flat Day-1 files (must stay consistent with any sync).
- `setup.qmd` — the shipped setup path the package would parallel; where the r-universe line would land.

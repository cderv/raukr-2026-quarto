# Technique review — exercise-delivery migration (scope: delivery)

*Reviewer: workshop-reviewer-technique · Reference commit **1a8c757** · 2026-07-22*
*Scope: the obtain-flow migration to `cderv/raukr-quarto-exercises@raukr-2026` — `setup.qmd`,
`labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd`, `_quarto.yml`, both slide decks; sync
infra as context.*

## Overall verdict

The structural migration is sound and mostly coherent: the render list correctly drops the four
Day-1 files, no site page links to them (verified — no broken cross-refs or internal links), the
`labs/quarto/` sync source is intact (7 files), the package list is consistent across
`setup.qmd` / `00-check-setup.R` / `DESCRIPTION` (all nine), and the Day-2 deck + lab are fully
purged of the `cd starter/` / `_site`-capture apparatus. **But the single most important, most
printed, most participant-facing command of the whole migration is wrong:**
`usethis::use_course("cderv/raukr-quarto-exercises@raukr-2026")` — usethis does **not** support the
`@ref` spec form, so this resolves to a bogus URL and **fails for every participant** (P0, verified
against usethis source + its own docs). Two smaller old-model residues survive (a Day-1 speaker note
that still claims an `_site/` output split; a Day-2 solution blurb that names `starter/`). The site
build is green because none of this touches the render graph — the breakage is a runtime download
failure and a couple of stale claims, exactly the semantic class the brief asked me to hunt.

---

## 🔴 P0 — blocking technical bug

### 1. `use_course("owner/repo@ref")` is not a supported spec — the primary obtain command fails

`setup.qmd:70` (and `:77`, `:100`), echoed by the whole flow, tells every participant to run:

```r
usethis::use_course("cderv/raukr-quarto-exercises@raukr-2026")
```

**`usethis::use_course()` does not accept the `owner/repo@ref` shorthand.** Verified against the
actual usethis source (`R/course.R`, `R/utils-github.R`, fetched from `r-lib/usethis@main`):

```r
# R/course.R
expand_github <- function(url) {
  repo_spec <- parse_repo_spec(url)
  glue_data_chr(repo_spec, "github.com/{owner}/{repo}/zipball/HEAD")   # <- HEAD, hardcoded
}

# R/utils-github.R
parse_repo_spec <- function(repo_spec) {
  repo_split <- strsplit(repo_spec, "/")[[1]]          # splits on "/" ONLY
  if (length(repo_split) != 2) ui_abort(...)
  list(owner = repo_split[[1]], repo = repo_split[[2]])
}
```

For `"cderv/raukr-quarto-exercises@raukr-2026"`, `strsplit` gives two parts, so no error is raised;
`owner = "cderv"`, **`repo = "raukr-quarto-exercises@raukr-2026"`** (the `@raukr-2026` is glued onto
the repo name). `expand_github` then builds:

```
https://github.com/cderv/raukr-quarto-exercises@raukr-2026/zipball/HEAD
```

There is no repo named `raukr-quarto-exercises@raukr-2026` → **404 → `use_course()` errors out.**
`normalize_url()`'s `tryCatch(error = url)` does *not* save it — `expand_github` doesn't error here,
it cheerfully returns the broken URL. Corroborated independently by DeepWiki and by usethis's **own
docs**, which show branch selection requires a *full* URL, never `@ref` (`R/course.R:42-47`):

```r
use_course("r-lib/rematch2")                                            # shorthand = HEAD only
use_course("https://api.github.com/repos/r-lib/rematch2/zipball/main")  # branch = full URL
use_course("https://github.com/r-lib/rematch2/archive/main.zip")        # branch = full URL
```

This is not the "raw URL dead until push" handoff (that's a separate, known item and is fine) — this
command is **malformed regardless of whether the repo exists**. The dry-run `the tracker` validated a
*simulated unpack* (an already-unzipped folder); it never exercised `use_course`'s `@ref` resolution,
so this was assumed, not verified — flagging it is in-scope, not re-litigating a settled item.

**Two distinct defects, one fatal:**
- **(fatal)** the printed command 404s for every participant, on every platform, before Day 1.
- **(design)** even written correctly as `owner/repo`, `use_course` targets **`HEAD` (the default
  branch)**, never a ref — so the plan §3 longevity rationale ("a printed `@raukr-2026` pin resolves
  to frozen content forever, even after `main` rolls to 2027") is **unachievable via the shorthand**.
  A 2027 participant running a 2026 handout's shorthand would silently get `main`.

**Fix** — use a full branch URL (documented, and it also *actually pins the branch*):

```r
usethis::use_course("https://github.com/cderv/raukr-quarto-exercises/archive/refs/heads/raukr-2026.zip")
# or:  use_course("https://api.github.com/repos/cderv/raukr-quarto-exercises/zipball/raukr-2026")
```

Apply at `setup.qmd:70`, `:77` (the `destdir` variant), `:100` (reset callout). The browser Plan-B
at `setup.qmd:107` (`.../tree/raukr-2026` ▸ **Code ▸ Download ZIP**) already targets the branch
correctly — ironically the *only* currently-correct path in the doc.

**Fix follow-through (do not skip):** a full-URL download names the unpacked folder from the zip's
top-level dir, **not** from `destdir`. A branch archive unpacks as `raukr-quarto-exercises-raukr-2026`
(and the api-zipball form as `cderv-raukr-quarto-exercises-<sha>`), so the "a folder called
**`raukr-quarto-exercises`**" claim at `setup.qmd:78`, and the "**top `raukr-quarto-exercises`
folder**" references at `:87`, `:138`(callout), `:152`, are then wrong too. Verify the exact unpacked
name against the real codeload zip the moment the repo is pushed, and reconcile the setup prose to it.
(This is the one spot where the `@ref` shorthand, had it worked, would have kept the folder name clean
— which is likely why it was chosen. It doesn't work; the folder-name text must move with the fix.)

---

## 🟠 P1 — fix before the event

### 2. Stale old-model speaker note contradicts the migration (and its own lab)

`slides/quarto/index.qmd:677` (Day-1 deck, `::: notes` on the Citations "Your turn"):

> "'Where's my PDF?' is usually the output-location split — the shipped `starter.qmd` renders under
> `_site/…`, but a brand-new doc renders next to its source."

Under the new model there is **no `_site/`** above `day1-intro/`: `starter.qmd` renders next to its
source (`day1-intro/starter.pdf`) exactly like a brand-new doc — the "output-location split" the note
describes **no longer exists**, and this is precisely the confusion the migration was built to kill.
It also directly contradicts the lab this note points at: `labs/quarto/index.qmd:210` — "there's no
project folder above to redirect it, so `starter.qmd` gives `starter.pdf`". A helper reading this crib
at the exact "Where's my PDF?" moment would re-inject the killed confusion. It's the **only** stale
`_site`/old-model residue left in the Day-1 materials (grep confirms the Day-1 lab is clean). Delete
the split clause or rewrite to: "every doc renders next to its source — there's no project folder
above `day1-intro/` to redirect it."

---

## 🟡 P2 — nice-to-have / robustness

### 3. Day-2 solution blurb names `starter/`, a folder the new model doesn't ship

`labs/quarto-projects/solution/index.qmd:10` (sync source → delivered as `solutions/day2/index.qmd`;
the stale text is already carried into the generated `exercises/solutions/day2/index.qmd:10`):

> "This is the finished **Website Challenge** project — the `.qmd` pages from `starter/`, plus the
> `_quarto.yml` and `_brand.yml` …"

In the delivered model the participant's working pages live in **`day2-projects/`**, not `starter/`
(there is no `starter/` in their download). A participant opening `solutions/day2/` reads about a
folder that doesn't exist. The exercises-repo CI renders it green (it's valid prose), so CI won't
catch it. Rename to `day2-projects/`. (This is exercises-repo content the brief scoped as context —
noting it because it's a genuine lingering old-model reference a participant will read.)

### 4. renv-only path leaves the day folders with no packages — reasoning is right, the warning is thin

The plan's pressure-test (a) holds: `renv::restore()` at the *top* folder builds a **project-private**
library keyed to that folder's `renv/activate.R` + `.Rprofile`; the day folders (`day1-intro/`,
`day2-projects/`) are separate working dirs with their own `.Rproj` and **no** renv activation, so
they never see that library — `install.packages()` into the user library is indeed the correct
primary path. `setup.qmd:135-148` frames this correctly (plain-install primary, renv "optional",
"the simpler path when you open the day folders directly"). **Residual sharp edge:** a cautious reader
who does *only* `renv::restore()` (reading "Pick one") and then opens a day folder gets **zero**
packages available there — a silent, confusing failure. Consider one line in the renv callout: "renv
alone won't cover the day folders — either also `install.packages()`, or open the *top* folder as your
project." Low priority (callout is collapsed and labelled optional), pure robustness.

---

## ✅ Technical choices validated

- **Render list correctly pruned** (`_quarto.yml:9-21`). The four Day-1 files
  (`starter.qmd`, `penguins-report.qmd`, `sample-typst.qmd`, `penguins-by-species.qmd`) are gone from
  the render graph; the comment block documenting *why* is accurate. `labs/*/index.qmd` is a
  single-level glob, so the leftover `labs/quarto-projects/{starter,solution}/index.qmd`
  (incl. `solution/_quarto.yml`, a nested project) are **not** matched and don't pollute the site —
  consistent with the green 8-target build.
- **No broken links from the removal.** Grep of all `.qmd` for markdown-link / `href=` targets to the
  four files: the only references are (a) plain-text mentions and (b) external `raw.githubusercontent`
  download buttons — **zero** internal site links or cross-references. Homepage table
  (`index.qmd:17-18`) and navbar (`_quarto.yml:40-51`) point only at rendered pages. Removing the four
  files cannot break the site build or any `@ref`/link — matches the reported exit 0.
- **Sync source intact.** `labs/quarto/` still carries all seven Day-1 assets
  (`starter.qmd`, `penguins-report.qmd`, `penguins-by-species.qmd`, `sample-typst.qmd`,
  `references.bib`, `apa.csl`, `index.qmd`).
- **Package list coherent across all three contracts** (nine packages, exact set match):
  `setup.qmd:116-120/126-132` · `00-check-setup.R:35-36` · `tools/exercises-scaffold/DESCRIPTION`
  Imports. `dplyr, ggplot2, gt, ggokabeito, brand.yml, ggrepel, prismatic, knitr, rmarkdown`. The
  "nine R packages" prose count (`setup.qmd:112,158`) is correct.
- **Day-2 deck + lab fully migrated.** `slides/quarto-projects/index.qmd` and
  `labs/quarto-projects/index.qmd` consistently use `day2-projects/`, the "nearest `_quarto.yml`"
  framing (deck :90-91, lab :122-124), `solutions/day2/` pointers, and output-next-to-source — the
  `cd starter/` paragraph, root-render warning, and nested-trap troubleshooting are gone. No `_site`
  split residue in the Day-2 materials.
- **Day-1 lab clean.** No `_site` / `cd starter` / `cloned` residue; the `day1-intro/` +
  create-`my-report.qmd` framing (`labs/quarto/index.qmd:24-28,63-64,210`) and the output-next-to-
  source claims are internally consistent.
- **Download buttons are correctly formed.** `raw.githubusercontent.com/.../raukr-2026/...` encodes
  the branch in the path (this *is* the right form for `raw`, unlike `use_course`), the RaukR
  house-pattern `<a class="btn ...">` markup is intact, and each is framed as an *alternative* to the
  local copy ("It's already in your `day1-intro/` folder … or take the source") — not misleading
  about the dead-until-push handoff.
- **`00-check-setup.R` is engine-honest** — shells out to the Quarto CLI (doesn't depend on the
  `{quarto}` R package, which isn't in the contract), checks R ≥ 4.5 / Quarto ≥ 1.9 / the nine
  packages / base `penguins`, then renders `day1-intro/sample-typst.qmd` for the Typst font pre-warm.
  Consistent with `setup.qmd`'s "Check your setup" prose.

---

## 📝 Evolution since the previous review

- The **nested-project trap is structurally removed**, not merely warned about: the whole
  `cd starter/` / repo-root-render / `_site` apparatus is deleted from the Day-2 lab and deck, and the
  four Day-1 working files left the render list cleanly (no dangling links — verified). This is a real
  robustness gain over the in-repo model.
- The **obtain-flow is now unified and single-sourced** (one `use_course` line, one day-folder story
  for both days), and the three package contracts were brought into exact agreement — good hygiene.
- **Regression introduced by the migration:** the `use_course` *spec form* (P0). The design chose the
  `@ref` shorthand for its clean folder name, but usethis silently does not honor it — a classic
  "reads plausibly, resolves to a 404" trap. The dry-run's "simulated unpack" bypassed exactly the
  step that would have caught it. Two stale prose residues (P1 `_site` note, P2 `starter/` blurb)
  slipped the sweep because they live in speaker notes and sync-source solution prose — neither shows
  up in a render-graph or link check, only in a semantic read.

# RaukR 2026 · Quarto — exercises

Hands-on files for Christophe Dervieux's two Quarto sessions at **RaukR 2026** (Advanced R for
Bioinformatics, Visby): *Introduction to Quarto* (Mon 10 Aug) and *Quarto projects* (Tue 11 Aug).
One download covers **both** days. No Git or GitHub account needed.

> **This folder is generated.** It is assembled from the course repo
> [`cderv/raukr-2026-quarto`](https://github.com/cderv/raukr-2026-quarto) by a sync script — do not
> hand-edit it here; edits are overwritten on the next sync. File issues on the course repo.

## Get the files

In R (RStudio or Positron), one line — it downloads a ZIP, unpacks it to your Desktop, and opens it:

```r
# install.packages("usethis")
usethis::use_course("cderv/raukr-2026-quarto-exercises")
```

Answer **No** when it offers to delete the ZIP — keep it as your reset button (see below). No R?
Download the ZIP in a browser from the green **Code ▸ Download ZIP** button and unzip it.

## Open the right folder

Open the day folder for the session — **not** this top folder:

- **Day 1** → open `day1-intro/` (double-click `day1-intro.Rproj`).
- **Day 2** → open `day2-projects/` (double-click `day2-projects.Rproj`).

Each day folder is self-contained (its own working directory, brand, and assets), so your renders
land next to your files — there is no project above them to capture the output.

## Check your setup (do this once, before Day 1)

From this top folder, run the setup check. It verifies R, Quarto, the packages, and the data, then
renders the Day-1 Typst sample — which caches the brand fonts so the in-session render does not pause to download them:

```r
source("00-check-setup.R")
```

Packages, if you need them:

```r
install.packages(c(
  "dplyr", "ggplot2", "ggrepel", "gt", "ggokabeito",
  "brand.yml", "prismatic", "knitr", "rmarkdown"))
```

## What's here

| Path | What it is |
|---|---|
| `day1-intro/` | Day-1 working folder: the Part-2 `starter.qmd`, the branded Typst payoff `sample-typst.qmd`, the parameterized-report bonus, plus `references.bib` / `apa.csl` / `_brand.yml`. |
| `day2-projects/` | Day-2 working folder: two pages that render on their own but are **not yet a project** — turning them into one is the exercise. Ships **without** `_quarto.yml`. |
| `solutions/` | Reference solutions for both days. Try the challenge first — they're most useful once you've attempted it. |
| `00-check-setup.R` | The one-shot setup check + Typst font pre-warm. |

## Reset (no Git needed)

If an attempt goes wrong, get a **fresh folder** (don't extract over your working copy):

- Re-run `usethis::use_course("cderv/raukr-2026-quarto-exercises")` — it makes a new,
  numbered folder and leaves your old attempt untouched; or
- Unzip the ZIP you kept to a **new** location.

## Reuse

Instructor reusing this? It's a **template repository** — click **Use this template** for your own
copy. License: content CC BY 4.0.

# Beginner review — obtain-and-work flow (delivery cycle)

- **Scope tag:** delivery
- **Reference commit:** 1a8c757 · **Date:** 2026-07-22
- **Reviewer lens:** experienced R user, new to Quarto, walking the new obtain-flow end to end
- **Files walked:** `setup.qmd`, `labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd`,
  the delivered `exercises/` tree (`00-check-setup.R`, `README.md`, `day1-intro/`, `day2-projects/`,
  `solutions/`)

## Overall verdict

The new `use_course()` flow is a big step up: the nested-project / `cd starter/` trap that used to
bite Day 2 is **structurally gone**, the day folders are genuinely self-contained, and the
"renders land next to your files" promise is now *true* (I confirmed there is no `_quarto.yml`
above either day folder). I could get the files, install packages, run the check, and start both
labs without an instructor. Two things would still lose a lone beginner: a **phantom `starter/`
folder** named in the Day-2 solution I'm explicitly told to open, and a **step-ordering snag** where
the page emphatically tells me to open the day folder *before* it tells me to run the check from the
top folder. Neither is fatal, but both cost confused minutes at the worst moment (alone, pre-workshop).

## 🔴 P0 — blocking for the event

None. I can complete the obtain-flow and both labs.

## 🟠 P1 — fix before the event

### 1. Phantom `starter/` folder in the Day-2 solution the lab tells me to open
`exercises/solutions/day2/index.qmd:10` (canonical source: `labs/quarto-projects/solution/index.qmd:10`):

> "This is the finished **Website Challenge** project — the `.qmd` pages from `starter/`, plus the
> `_quarto.yml` and `_brand.yml`…"

There is **no `starter/` folder anywhere** in my download — the Day-2 working folder is
`day2-projects/`. The Day-2 lab actively sends me here: `labs/quarto-projects/index.qmd:132-134`
says *"open it to compare, or copy it wholesale."* So when I open the solution to compare, line 10
tells me my pages came "from `starter/`" — a folder I never had. As a beginner I don't know this is
stale migration text; I assume I lost a folder or unpacked wrong and start hunting. This is exactly
the "false you saw this" trap. Fix: reword to `day2-projects/` (the folder I actually opened).

### 2. "Open the day folder, not the top folder" is stated *before* "run the check from the top folder"
The emphatic callout `setup.qmd:84-95` ("## Open the **day folder**, not the top folder … double-click
`day1-intro.Rproj`") lands in step 2. But the check step `setup.qmd:150-155` says:

> "From the **top** `raukr-quarto-exercises` folder, run: `source("00-check-setup.R")`"

and the renv note `setup.qmd:135-145` also says "from the **top** … folder". `use_course()` drops me
in the top folder — good — but if I obey the loud callout and double-click `day1-intro.Rproj` right
away (nothing in it says "wait until the session"), my working dir becomes `day1-intro/` and
`source("00-check-setup.R")` fails: the file is in the parent. The check script itself anticipates
this wrong turn (`exercises/00-check-setup.R:50`: *"run this from the exercises root (open the
.Rproj)"*) — but that recovery hint says "open **the** .Rproj" when there are **three** `.Rproj` files,
right after I was told *not* to open the top one. Circular for a beginner.
Fix: sequence it explicitly — "do steps 3–4 while you're still in the top folder; open the day folder
only when the session starts." (Right now the happy path only works if I *don't* act on the callout.)

## 🟡 P2 — nice-to-have

### 3. Day-1 lab fallback install omits the engine it just said I need
`labs/quarto/index.qmd:16-17` says the report needs "the `knitr`/`rmarkdown` engine every `.qmd` with
R code needs", but the fallback one-liner `labs/quarto/index.qmd:20` installs only four:
`install.packages(c("dplyr", "ggplot2", "gt", "ggokabeito"))` — no `knitr`/`rmarkdown`. A beginner who
skipped Setup and runs only this on a bare R could hit an engine error at first render. Most people
have those two already, hence P2, but the text and the command disagree. (Setup's own list is
correct: 9 packages.)

### 4. "exercises folder" vs "top `raukr-quarto-exercises` folder" wording
`setup.qmd:17` (glance) and `:63` say "the exercises folder"; `:152` says "the **top**
`raukr-quarto-exercises` folder". Since the callout at `:84-95` renamed the *day* folders as where I
work, "exercises folder" reads ambiguously — is that the top one or the day one? Aligning on one
name (e.g. always "the top `raukr-quarto-exercises` folder" for the check) removes the wobble and
reinforces the fix for #2.

### 5. Download buttons + browser fallback 404 today (known pre-freeze)
`setup.qmd:107` (browser fallback link) and the `starter.qmd` / `penguins-report.qmd` /
`penguins-by-species.qmd` buttons (`labs/quarto/index.qmd:138,158,331`) point at
`cderv/raukr-quarto-exercises@raukr-2026`, not pushed yet. Nothing *on the page* tells a beginner
"not live yet," so anyone testing early gets a bare 404 with no explanation (the "goes live once
pushed" note is an HTML comment I can't see). Understood this is a known handoff and resolves at
freeze — flagging only so the push isn't forgotten, since the pages present the buttons as working.

## ✅ What reassures me

- **The old trap is gone, not just warned about.** No `_quarto.yml` at or above either day folder
  (verified), so "everything you render lands right next to your files"
  (`labs/quarto/index.qmd:27-28`, `labs/quarto-projects/index.qmd:43-45`) is literally true. No more
  `cd starter/` — Day 2 is genuinely simpler.
- **Day 2 stands alone.** `day2-projects/` ships `index.qmd` + `analysis.qmd` + its `.Rproj` and
  depends on nothing from Day 1, so arriving fresh on Tuesday isn't a blocker — matches the promise
  at `labs/quarto-projects/index.qmd:45`.
- **Solutions are present locally as siblings** (`exercises/solutions/day1`, `.../day2`) and the labs
  point me at the right paths — I can compare without network.
- **Reset advice fits a non-git beginner:** "get a fresh folder" (re-run `use_course()` or unzip the
  kept ZIP to a new spot), not "unzip over your copy" (`setup.qmd:97-108`, `README.md:60-66`). Sensible.
- **Consistent package story:** 9 packages match across the Setup install (`setup.qmd:116-120`),
  README (`README.md:46-48`), and the check script (`00-check-setup.R:35`).
- **Callbacks check out:** the Day-2 "exactly as yesterday" cross-ref note
  (`labs/quarto-projects/index.qmd:90-93`) is true — `analysis.qmd` really carries `@tbl-means`, and
  `index.qmd:8` really has the plain `[analysis](analysis.qmd)` link the lab describes.
- Setup "at a glance" anchors (`#software`, `#get-the-materials`, `#r-packages`, `#check-your-setup`)
  all resolve to real headings.

## 📝 Evolution since the previous review

- **Big win:** the Day-2 obtain flow lost the `cd starter/` machinery and the root-render warnings; a
  beginner no longer has to understand nested projects to avoid a silent wrong-output trap. This was
  the class of thing that used to lose me — it's now designed out.
- The params-bonus items settled last cycle (the `penguins-by-species.qmd` "Starting point" reframe,
  plot `one`, the output note) are all in place and read cleanly — not re-flagged.
- New rough edges are migration residue, not design flaws: one stale `starter/` mention that the
  layout rename missed (P1 #1), and a step-ordering wrinkle introduced by the new "open the day
  folder" guidance (P1 #2). Both are one-line fixes.

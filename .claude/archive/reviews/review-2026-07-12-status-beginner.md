# Status-confirmation review — beginner seat (2026-07-12)

_Fictional participant: experienced R + tidyverse user, life-science background, has dabbled in
R Markdown/Quarto for simple reports, never built a Quarto project. Walked the whole two-day arc
in order: `index.qmd` → `setup.qmd` → Day 1 slides + lab (+ `starter.qmd`) → Day 2 slides + lab
(+ `starter/`, `solution/`, `dashboard.qmd`)._

## Overall verdict

Yes — I make it through **both** days. The arc is coherent from the seat: every "Your turn"
points at a named Challenge I can actually complete from what the slides + lab handed me, every
scary word (Typst, freeze, CI, WYSIWYM, brand, OJS/Shinylive) is glossed *at or before* first use,
and the safety nets are real folder paths (`starter/`, `solution/`, `starter.qmd`) with no dead
site-links — the prior-cycle demotion held. The single thing that would trip me **before** I walk
in is that nothing on the participant-facing path ever tells me to `git clone` the repo, yet the
whole hands-on depends on files that only live in it (`references.bib`, `apa.csl`, `starter/`,
`solution/`). That's an in-room-bridgeable P1, not a day-blocker. No P0s.

## 🔴 P0 — blocking for the event

None. I could not find anything that stops me cold on the day: files referenced by the labs all
exist, the SCSS themes the configs point at (`theme.scss`, `theme-html.scss`) are present, the
running dataset is zero-install, and the nested-project trap on Day 2 is pre-empted.

## 🟠 P1 — fix before the event

**1. The clone step is never spelled out — and the entire hands-on depends on it.**
`setup.qmd:29` tells me to run `renv::restore()` *"From the repo root:"* and Day 2 lab points me at
*"`solution/` (in your cloned repo)"* (`labs/quarto-projects/index.qmd:120`), but nowhere on the
participant path (`index.qmd`, `setup.qmd`) is there a `git clone <URL>` line or even the repo URL.
As a participant doing *"Before you arrive"* prep, I literally cannot: I don't know where the repo
is. This isn't cosmetic — the Day-1 Citations Challenge needs `references.bib` + `apa.csl`, and
**both** safety nets (`labs/quarto/starter.qmd`, Day-2 `starter/` & `solution/`) live only in the
clone. If I skip cloning and just make my own `.qmd`, half the lab and every catch-up net are
unreachable. On the day the instructor will paste the URL in Slack, so it's survivable — but the
setup page *promises* self-service prep (`index.qmd:27`: "See Setup for what to install") and
doesn't deliver the one step that unlocks the rest. Add a "Get the materials" block to `setup.qmd`
with the clone command + URL, ahead of the `renv::restore()` block that already assumes it.

## 🟡 P2 — nice-to-have

- **`sample-typst.qmd` link resolves to a PDF, not a page.** `labs/quarto/index.qmd:235` links it
  as reference material; per `_quarto.yml` it renders to PDF. Clicking it mid-lab gives me a PDF
  download rather than an HTML page — fine once I expect it, mildly surprising if I don't. A word
  ("the branded PDF output") on the link would set expectations.
- **Package list is stated in two places with slightly different framing.** `setup.qmd` bundles
  `brand.yml`/`ggrepel`/`prismatic` into the "before you arrive" install; the Day-2 lab
  (`labs/quarto-projects/index.qmd:26`) re-introduces `install.packages("brand.yml")` as
  *optional*. Not contradictory, but if I did the full `setup.qmd` install I'll wonder why Day 2
  tells me to install it again. Harmless.
- **Day 1 slide `knitr::inline_expr("nrow(penguins)")`** (`slides/quarto/index.qmd:100`) is a
  meta-construct (code that shows how to write inline code). With the presenter narrating it's
  clear; re-reading the slide cold to revise, it reads oddly. The `. . .` line under it and the
  callout slide (`#callouts`) do resolve it, so low priority.

## ✅ What reassures me (beginner's-eye clarity)

- **Every "Your turn" is completable from what I was given.** Day-1 Authoring names the exact cell
  options (`#| label: fig-bill`, `#| column: margin`), and the underscore-in-`$$` subscript trap is
  called out *explicitly* with the escaped form (`labs/quarto/index.qmd:65-71`) — that's the one
  place I'd have burned 5 minutes, and it's defused.
- **The nested-`_quarto.yml` trap is pre-empted.** Day-2 hint (`labs/quarto-projects/index.qmd:112`)
  tells me the *nearest* `_quarto.yml` wins, so my `starter/_quarto.yml` is its own project — the
  exact confusion I'd have hit with the repo's root config was answered before I asked.
- **Jargon is glossed at first use, arc-wide — no regression.** Typst = "a modern PDF engine bundled
  in Quarto — no LaTeX" (`slides/quarto/index.qmd:54`); CI = "continuous integration — a build that
  runs on every push" (`slides/quarto-projects/index.qmd:238`); WYSIWYM spelled out
  (`slides/quarto/index.qmd:268`); freeze vs cache given a clean two-bullet contrast
  (`slides/quarto-projects/index.qmd:234-239`); OJS/Shinylive/htmlwidget all parenthetically defined
  (`:331-333`). Nothing landed on me undefined.
- **Safety nets are folder paths, not links — the dead-`solution/`-site-link fix held.** Day 2 lab
  says *"the complete... project is in `solution/` (in your cloned repo)"* and *"open the ready-made
  `solution/` project"* — filesystem paths I can just open, no clickable site link to 404. `solution/`
  is genuinely the finished Website-Challenge state (has `_quarto.yml` + `_brand.yml`, no `freeze:` —
  correct, since Ship-it adds freeze on top). The behind-participant story actually works.
- **Continuity across the break is honest.** Day-1 `starter.qmd` is a real known-good Part-1 doc
  ending exactly where Citations picks up; Day-2 `solution/` is the Part-1 end-state the Ship-it
  Challenge starts from. Falling behind in part 1 doesn't strand me in part 2 on either day.
- **Slides stand alone for revision.** Re-reading cold, the callouts carry the "why" (the
  cross-page-refs-are-a-book note, the freeze-vs-cache box, the publish "watch-me" warning) without
  needing the presenter notes.
- **"Learn more" footers are useful, not decorative** — real quarto.org deep links (Typst format,
  brand.yml, Projects/Freeze/Publishing) I'd actually follow to redo this at home.

## 📝 Evolution since the previous review

- **Safety-net links: confirmed still clean.** The prior cycle's demotion of the dead `solution/`
  site-link to a plain folder path is intact across both Ship-it starting-point and the
  Website-Challenge reference — no clickable dead net remains anywhere on the lab path.
- **Underscore/LaTeX subscript trap: still defused** in both the slide (`#tables-math`) and the lab
  task, with the escaped `bill\_len` form shown. Good.
- **Jargon glosses: no regression** — every term the earlier cycles flagged is still defined inline
  at first use across the whole arc (checked Typst, freeze, CI, WYSIWYM, brand, OJS, Shinylive).
- **What was already good and stayed good:** the zero-install `penguins` spine, the explicit
  "You should see" target-figure blocks that let me self-check, and the troubleshooting callouts at
  the foot of each lab (the `?@…` and unbranded-plot entries are exactly the mistakes I'd make).
- **New gap this pass:** the clone step (P1 above). I flag it as unaddressed rather than regressed —
  it's the seam between "install toolchain" (covered) and "get the materials" (assumed).

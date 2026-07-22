# Day-2 arc — beginner review (2026-07-08)

**Reviewer lens:** experienced R/tidyverse user, new to Quarto *projects*. Walked the whole Day-2
session start-to-finish as one ~2h chronological experience: setup → deck Part 1 → Website
Challenge (from `starter/`) → between-parts break (open `solution/`) → deck Part 2 → Ship it
Challenge → Demos tail + dashboard link. Scope tag `day2-arc`. Reference commit `9abf90f`.

## Overall verdict

I make it through the day. The deck → lab handoffs are clean, the paths line up, and the arc
tells one coherent story (one file → project → branded website → reproducible → shipped). I
**empirically confirmed** the load-bearing beginner worry — that rendering the `starter/` page
before adding its own `_quarto.yml` might leak the workshop repo's teal brand and spoil the
"add `_brand.yml` → teal" payoff — and it does **not**: Quarto renders the excluded file
standalone (plain Bootstrap, in-place), so the branding reveal in Task 3 still lands. The
between-parts safety net (`solution/`) is real and complete, and the Ship it freeze demo is
walkable. Remaining findings are all polish — nothing blocks or strands a first-timer. No P0, no
true P1.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

None that would lose me on the day. The two closest calls (the in-place first render, the
`_metadata.yml` slide with no lab counterpart) are documented as P2 below — each is a moment of
mild puzzlement, not a stall.

## 🟡 P2 — nice-to-have

**1. The "confirm it works" render drops an `.html` next to the source, not in `_site/` —
unremarked.**
`labs/quarto-projects/index.qmd:37`: *"render one page first to confirm it works —
`quarto render starter/analysis.qmd` gives a normal HTML page."* I ran this: because
`starter/analysis.qmd` isn't in the workshop repo's render list, Quarto renders it **standalone,
in place** (`starter/analysis.html` appears next to the `.qmd`), *not* into any `_site/`. That's
actually the clean outcome (no brand leak — good), but the whole lab frames the deliverable as a
`_site/` folder, so a first-timer may be briefly confused that their very first render produced a
loose `.html` beside the source instead. One clause would fix it: "(this single-file render lands
next to the source; the *project* render in the next step is what fills `_site/`)". The contrast
is a teachable moment currently left silent.

**2. `_metadata.yml` is taught in the deck but never exercised in the lab.**
`slides/quarto-projects/index.qmd:81-97` teaches `analysis/_metadata.yml` for a **subfolder**.
The `starter/` project is **flat** (`index.qmd` + `analysis.qmd` at the folder root, no subdir),
so there's nowhere to apply it in either Challenge. As a beginner I'd finish the lab unsure
whether I was *supposed* to create one. Not wrong — it's a "here's a tool" slide — but it's the
one concept from Part 1 with no hands-on echo. Either a one-line "we don't need this in today's
flat project, but reach for it when a folder of pages shares options" on the slide, or a stretch
task, would close the promise/delivery gap.

**3. Deck's illustrative `custom.scss` vs the lab's `theme: cosmo`.**
`slides/quarto-projects/index.qmd:64`: `theme: [default, custom.scss]` — there is no
`custom.scss` in the lab, and the lab authoritatively hands me `theme: cosmo`
(`labs/…/index.qmd:65`). Following the lab I'm fine; but if I'm revising from the slides later and
copy that snippet, `custom.scss` won't exist. Low risk (the lab is where I type), worth a
"(your own SCSS, optional)" comment on the slide so the deck doesn't read as a copyable recipe.

**4. The `solution/` hyperlink won't resolve in the rendered/deployed site.**
`labs/quarto-projects/index.qmd:119`: *"in **[`solution/`](solution/)**"*. `solution/` (and
`starter/`) are deliberately **excluded from the project render list** (`_quarto.yml:8-22`), so
there's no `solution/` page in `_site/` — clicking that link from the deployed or locally-built
lab HTML gives nothing. In practice I'm working from the cloned repo and navigate the folder in
my editor, so I'm not stranded; but the one place the lab makes it a *hyperlink* (everywhere else
it's plain text / a `cd` path) sets up a 404 for anyone reading the lab in a browser. Consider
making it plain code (`` `solution/` ``) like the Ship-it reference at line 130, to match the
"open the folder" model used everywhere else.

## ✅ What reassures me (beginner's-eye clarity)

- **Deck → lab handoff is unambiguous.** Both "Your turn" callouts name the exact lab section
  ("Website Challenge" / "Ship it Challenge") and the relative link
  `../../labs/quarto-projects/index.qmd` resolves correctly. Slide word == lab word; I never
  wonder where to go.
- **The `starter/` is a genuine on-ramp.** `labs/…/index.qmd:29-41` tells me I don't start blank,
  names both files, and says render one to confirm. `starter/index.qmd` and `starter/analysis.qmd`
  use the base `penguins` names (`bill_len`, …) consistently with the deck's setup chunk — no
  name drift to debug.
- **The between-parts break is truly covered.** Ship it's "Starting point" (`:129-131`) lets me
  open `solution/` if I fell behind; `solution/` is a complete, pre-freeze Part-1 project
  (`_quarto.yml` + `_brand.yml` + both pages), so I can start Part 2 clean. Confirmed it has no
  `freeze:` block — correct, since adding it *is* Task 1.
- **The freeze demo is a first-timer-safe recipe.** `:141-143` is render-twice-**with-no-edit**
  → skip, then edit code → only that page re-runs. That's the version that actually demonstrates
  the skip; I can follow it without understanding freeze internals first.
- **Jargon is defined inline where I'd trip.** CI (`slides:233`), htmlwidget / OJS / Shinylive
  (`slides:326-328`), listings (`slides:136`) all get a parenthetical the moment they appear — I
  can revise the deck later without presenter notes.
- **The Troubleshooting box (`:183-197`) reads like it was written for me** — YAML indentation,
  "No project" / nearest-`_quarto.yml`, brand-not-applied-on-plots, `?@…` xref, freeze-didn't-skip,
  missing package. Every 5-minute-typo trap I'd hit is pre-answered.
- **The dashboard demo lands where promised.** `slides:325` `[See one]` →
  `../../labs/quarto-projects/dashboard.html`, which is in the render list and *does* exist in
  `_site/` — the link works from the deployed deck, and the page is self-contained static HTML
  that makes sense at the "if time" moment. The deck flags it "static — no server", so I don't
  expect to build it.
- **Branding expectations are set honestly.** The lab's "You should see" (`:85-91`) tells me the
  navbar/headings turn teal but the **plot keeps default species colors** (needs
  `theme_brand_ggplot2()`), so I won't waste time wondering why my boxplot didn't change — and the
  target figure I'm shown matches what the starter actually produces.

## 📝 Evolution since the previous review

This is the first pass over Day 2 as a **single arc** rather than per-file, and the pieces the
brief lists as already-fixed are exactly what make the walk hold together: the freeze demo is now
render-twice-no-edit→skip in both deck and lab (I could follow it cold); `solution/` is a
complete known-good Part-1 project and Ship-it explicitly opens from it (the break no longer
strands me); the "Your turn" callouts name the Challenges (one vocabulary, deck↔lab); the target
figure matches the starter's default theme; and the branding copy scopes itself to the chrome, not
the plot. With those in place, what's left for me is genuinely cosmetic. The strongest structural
win from a beginner seat is that the two-axes framing ("Day 1 = one file → PDF, Day 2 = one folder
→ site") and the capstone call-forward give every step a reason I can hold onto.

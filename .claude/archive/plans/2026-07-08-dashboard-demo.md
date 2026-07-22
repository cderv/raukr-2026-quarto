# Plan — Day-2 Dashboards demo (static artifact) · the tracker

**Goal:** build the one deferred Day-2 DEMO artifact — a self-contained `format: dashboard`
penguins page — so the deck's "Demos — if time" bullet has a real page to *open and narrate*
(or link if the tail is cut). Static only (no Shiny/OJS backend). Satisfies technique P2-5:
show the **layout model**, not an underwhelming single-plot page.

## Scope (from topic-store / prior-art)
One `format: dashboard` penguins page: **2 rows · 2 valueboxes · 1 `.card` plot · 1 tabset**.
Watch-me / static. Runs on base-R `datasets::penguins`, `dplyr` + `ggplot2` (already in renv).
Brand carries via the project `_brand.yml` (dashboards are a supported brand format) — teal
chrome + valuebox color, default plot fills (monochrome-teal can't separate 3 species by hue;
same reason as the payoff figure — keep layout the teaching point, not plot color).

## Steps
1. Author `labs/quarto-projects/dashboard.qmd` (`format: dashboard`).
   - Row 1 (small height): 2 valueboxes computed from data (species count, penguins measured).
   - Row 2: card with body-mass boxplot; tabset column (bill scatter tab + means-table tab).
   - `fig-alt` on every plot; `::: notes`-style aside not needed (it's a page, not slides).
2. Wire into `_quarto.yml` `render:` list so a full build validates it.
3. Add a real **link** to the deck's Demos slide (`slides/quarto-projects/index.qmd`).
4. Render the dashboard (executable → stage `_freeze/`); confirm green.
5. Offer `/start-workshop` review; log in worklog; close the tracker.

## Out of scope
Interactive/Shiny/OJS dashboards (firmly out); dashboard-specific parameters; deployment
(same as publishing). A `.card` per-plot brand-color pass (default fills are fine for a layout demo).

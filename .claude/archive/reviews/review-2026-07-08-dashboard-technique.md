# Review — Day-2 Dashboards DEMO (technique lens)

- **Scope:** `labs/quarto-projects/dashboard.qmd` + its `_quarto.yml` render entry + the deck link on the "Demos — if time" slide (`slides/quarto-projects/index.qmd`).
- **Reference commit:** `9abf90f` (2026-07-08)
- **Quarto:** `1.9.38` installed; project floor `quarto-required: ">=1.8.0"` (`_quarto.yml:28`).
- **Method:** read + Grep + fresh `quarto render labs/quarto-projects/dashboard.qmd` (exit 0), plus structural inspection of `_site/labs/quarto-projects/dashboard.html`.

## Overall verdict

Technically clean and ships as-is. `format: dashboard` is valid and well above the 1.8 floor; the valuebox idiom, the `{height=}` row split and the `{.tabset}` column all render to exactly the intended 2-row / 2-valuebox / 1-card / 1-tabset layout — verified against the compiled HTML, not just the source. Values compute correctly (Species = 3, Penguins measured = 342 after the NA filter), Bootstrap-icon names resolve (`bi-tags`, `bi-clipboard-data`), and the `_brand.yml` chrome claim is accurate: teal `#4C979F` and Albert Sans are compiled into the page's Bootstrap bundle, so valuebox `primary`/`secondary` map to the RaukR palette while the plots keep ggplot defaults by design. The deck link path resolves. Only one minor robustness nit (P2); no P0/P1.

## 🔴 P0 — blocking technical bug

None.

## 🟠 P1 — fix before the event

None.

## 🟡 P2 — nice-to-have / robustness

- **`slides/quarto-projects/index.qmd:325`** — the demo link targets the *output* file directly:
  `[See one](../../labs/quarto-projects/dashboard.html)`. The path is correct and works. But because the deck is part of the website project, linking to the **input** (`…/dashboard.qmd`) would let Quarto validate the target exists at render time and rewrite the extension itself — a rename/typo would then surface as a render warning instead of a silent 404 in the room. Purely defensive; the current `.html` form is not wrong.

## ✅ Technical choices validated

- **Format validity** — `format: dashboard` (`dashboard.qmd:4`) is a real Quarto format, GA since 1.4 and fully current at 1.9.38; short form is appropriate for a no-options page. Fresh render exits 0.
- **Valuebox idiom** — `#| content: valuebox` returning `list(color=, icon=, value=)` (`dashboard.qmd:27-45`) is the correct R-cell contract. Rendered output confirms `Species → 3` and `Penguins measured → 342`; titles come from `#| title:`, icons `tags`/`clipboard-data` resolve to `bi-tags`/`bi-clipboard-data`. `color = "primary"`/`"secondary"` are valid theme-color roles.
- **Row-height split** — `## Row {height="20%"}` / `## Row {height="80%"}` (`dashboard.qmd:25,47`) compile to `grid-template-rows: minmax(3em, 20fr) minmax(3em, 80fr)` in the output — the intended proportion, verbatim.
- **Tabset column** — `### Column {.tabset}` (`dashboard.qmd:59`) produces a `nav-tabs` control with the two expected tabs (`Bill scatter`, `Mean measurements`); the sibling `### Column` (`dashboard.qmd:49`) holds the single boxplot card. Nesting (`##` rows → `###` columns) is idiomatic dashboard layout.
- **Layout outcome** — verified end-to-end: row 1 = 2 valueboxes, row 2 = 1 chart card + 1 two-tab tabset. Matches the stated design.
- **Brand-via-`_brand.yml` claim** — accurate and now proven, not asserted: `#4C979F` (×63) and `Albert Sans` (×11) are compiled into `site_libs/bootstrap/bootstrap-*.min.css`, so the dashboard *chrome* (header, fonts, valuebox fills) picks up the brand while ggplot fills stay default. The header comment (`dashboard.qmd:7-14`) states this correctly, including the honest "plots aren't branded without `theme_brand_*`" caveat.
- **Data + idioms** — `data(penguins)` uses the base-R (≥4.5.0) dataset with the short column names `bill_len`/`bill_dep`/`body_mass`; native pipe `|>` and `.by =` throughout; `#| message: false` suppresses attach chatter. No `%>%`, no deprecated calls, no OS-specific paths. `dplyr`/`ggplot2`/`knitr` are all in the Day-1 setup surface.
- **Cell options** — all `#|` YAML comment syntax, dashes-not-dots keys; `fig-alt` present on both plot cells (`dashboard.qmd:53,63`).
- **Project wiring** — `dashboard.qmd` is listed in `_quarto.yml:23` render list; it is the only non-`index.qmd` page in `labs/quarto-projects/`, so the `labs/*/index.qmd` glob would otherwise skip it — the explicit entry is correct and necessary.
- **Deck link path** — deck at `_site/slides/quarto-projects/index.html`, `../../labs/quarto-projects/dashboard.html` → `_site/labs/quarto-projects/dashboard.html`, which exists. Correct.

## 📝 Evolution since the previous review

First technique review of this page — no prior dashboard review to diff against. The wiring inherits an already-sound Day-2 project (`_quarto.yml` render list, `_brand.yml`, freeze discipline) and slots in without disturbing it: the render list gained one coherent explicit entry, the deck gained one correct relative link. The single deliberate-design carve-out (monochrome-teal brand can't hue-separate three species, so plots keep ggplot defaults) is consistent with the Day-1 payoff-figure constraint and is documented in-file. Nothing regressed.

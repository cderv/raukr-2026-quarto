# Day-2 arc — technique review (whole-arc pass)

- **Scope tag:** `day2-arc` · **Reference commit:** `9abf90f` · **Date:** 2026-07-08
- **Reviewer lens:** technique (cross-artifact coherence across the ~2h Day-2 arc)
- **Files:** `slides/quarto-projects/index.qmd`, `labs/quarto-projects/index.qmd` (+ `starter/`, `solution/`), `labs/quarto-projects/dashboard.qmd`, `_quarto.yml`, `_brand.yml`
- **Toolchain:** Quarto `1.9.38` (floor `>=1.8.0`); full `quarto render` succeeded.

## Overall verdict

The Day-2 spine holds together end-to-end: freeze semantics are stated identically across deck, lab, and root `_quarto.yml`; the penguins column names (`bill_len`/`bill_dep`/`body_mass`), the `.by =` summarise idiom, the native `|>`, and the NA-filter line are byte-for-byte consistent across all five executable surfaces; the challenge vocabulary ("Website Challenge" / "Ship it Challenge") matches exactly between the deck's *Your turn* callouts and the lab headings; and the brand three-surfaces claim plus `theme_brand_ggplot2()` is coherent deck↔lab. The full project renders clean from committed `_freeze/` (git status clean afterward — reproducible), with only the expected Typst Linux font-fallback warnings on the *Day-1* Typst artifact. One genuine whole-arc seam surfaced that per-file review could not catch: the lab's `solution/` safety-net link 404s on the rendered site because `starter/`/`solution/` are nested projects excluded from the build. No P0.

## 🔴 P0 — blocking technical bug

None.

## 🟠 P1 — fix before the event

**1. The lab's `solution/` reference link 404s on the rendered site** — `labs/quarto-projects/index.qmd:119`
`[`solution/`](solution/)` renders to `href="solution/"` (verified in `_site/labs/quarto-projects/index.html`), which resolves to `_site/labs/quarto-projects/solution/` — **that directory does not exist in the build**. `starter/` and `solution/` each carry their own `_quarto.yml`, so they are separate nested projects and are excluded from the parent render (confirmed: `_site/labs/quarto-projects/` contains only `index.html` + `dashboard.html`, no `solution/`/`starter/`).

Why this matters for the arc: this exact link is the anti-stranding mechanism the Day-2 design leans on — "open it to compare, or copy it wholesale if you fell behind" (`:119-120`), reinforced from the deck's *Your turn* handoff and the lab's *Starting point* boxes (`:40`, `:129-130`). A participant reading the lab on the published website clicks it and gets a 404 precisely when they are behind. On-disk (repo clone) the folder exists, so the break is site-only — but the lab is delivered *as* a website page, so it is the reader's real path.

Mitigation options (pick per the delivery model):
- If the safety net is a **filesystem** instruction (participants have the repo), demote the link to a code-styled path — match how `starter/` is already written (`:34-37` uses `` `starter/` `` in code font, not a hyperlink), so there is no dead web link.
- If it should be **clickable on the site**, point it at the repo folder on GitHub (a real URL) rather than a project-relative directory the build never emits.
- A `resources:` copy of `starter/`/`solution/` into `_site` would ship the raw `.qmd` but not make `solution/` *open* (no `index.html` for a directory link) — not a clean fix on its own.

## 🟡 P2 — nice-to-have / robustness

**2. Deck→dashboard link authored as literal `.html`, bypassing Quarto's link check** — `slides/quarto-projects/index.qmd:325`
`[See one](../../labs/quarto-projects/dashboard.html)` resolves today (dashboard is in the render list, so `dashboard.html` exists), but a hardcoded `.html` is not validated or rewritten by Quarto — if `dashboard.qmd` were ever dropped from the `_quarto.yml` render list (`_quarto.yml:23`), the link would break silently. The lab/deck's other cross-file links use `.qmd` and get validated + rewritten (e.g. `:207`, `:299`, `:325` lab link). Prefer `../../labs/quarto-projects/dashboard.qmd` for the same robustness. (Quarto rewrites `.qmd`→`.html` for a `format: dashboard` page just as for html.)

**3. `tbl-means` labelled `tbl-` but has no `tbl-cap`** — `labs/quarto-projects/starter/analysis.qmd:34`, `labs/quarto-projects/solution/analysis.qmd:34`
The `#| label: tbl-means` cell (kable) has no caption, so it is not actually a resolvable cross-reference — inconsistent with the sibling `fig-mass` cell right above it (`fig-cap` present). It renders fine and is never referenced by `@tbl-means`, and these files are not built by the parent project, so it is invisible until a participant renders `starter/` themselves. For teaching cleanliness either add `#| tbl-cap: "Mean measurements by species."` (making it a real `@tbl-` demo alongside the `@fig-mass` one) or drop the `tbl-` prefix. Low impact.

## ✅ Technical choices validated

- **Freeze semantics are consistent across the arc.** Deck (`slides/…:229-246`), lab Ship-it (`labs/…:135-164`), and root default (`_quarto.yml:65-66`) all state `auto` = re-execute only when a document's *own source* changes, `true` = never on a project build (CI-without-R). The render-twice-no-edit → cell-skipped claim (`labs/…:141-143`) is correct and matches how the arc actually freezes.
- **`_freeze/` is committed for every Day-2 executable** — deck, lab `index`, and `dashboard` all have `execute-results`; a full `quarto render` reproduced the site with **clean git status** (no `_freeze/` or `_site/` churn), i.e. the frozen results are current.
- **Running-dataset spine is uniform.** `data(penguins)` + `filter(!is.na(bill_len), !is.na(bill_dep), !is.na(body_mass))` is identical in deck `:16-23`, lab `:8-15`, dashboard `:16-23`, starter/solution `analysis.qmd`. Base-R column names (`bill_len`/`bill_dep`/`body_mass`), `.by = species`, and `|>` are used everywhere — no `%>%`, no palmerpenguins `_mm` names, R ≥ 4.5 floor stated consistently (lab `:23`, starter/solution prose).
- **Challenge vocabulary is one word, deck↔lab.** "Website Challenge" (deck `:207` ↔ lab `:43`) and "Ship it Challenge" (deck `:299` ↔ lab `:122`) match exactly — no "Your turn"/"Challenge" split.
- **Cross-reference messaging is coherent and correct.** Within-page `@fig-`/`@tbl-`/`@sec-` (deck `:140-145`, lab `:80-82`, resolving `@fig-mass` in starter/solution) vs. cross-page = links + nav, with project-wide numbering correctly scoped to `type: book` (deck `:154-157`, lab `:82`, `:193`). The deck speaker note even hedges to test one cross-page `@fig-` on the installed version (`:159-162`).
- **Brand three-surfaces claim is accurate and applied.** Deck `:164-196` (HTML/revealjs/Typst read `_brand.yml` natively; R side via `library(brand.yml)` + `theme_brand_ggplot2()`) matches the lab scope note (`:25-27`) and the "plot keeps default fills until `theme_brand_*()`" caveat (deck `:194`, lab `:89-90`, dashboard header comment). Root `_brand.yml` and the taught minimal `_brand.yml` (deck `:171-181`, lab Task 3 `:70-78`, `solution/_brand.yml`) are all well-formed brand syntax (`color.palette`/`primary`, `typography.fonts`/`base`; link color correctly under `typography.link`).
- **Project YAML is coherent.** Explicit `render:` list (`_quarto.yml:9-23`) deliberately excludes `starter/`/`solution/` (nested projects) while listing `dashboard.qmd:23`; `output-dir: _site` story is consistent deck↔lab↔config; `quarto-required: ">=1.8.0"` clears every feature used (`format: dashboard` ≥1.4, `_brand.yml` ≥1.6). No invented format keys; `format: dashboard` is valid and renders a proper static layout (rows `## {height=…}`, `#| content: valuebox`, `### Column {.tabset}`, bootstrap icons `tags`/`clipboard-data`).
- **Deck→lab→dashboard handoffs resolve.** `../../labs/quarto-projects/index.html` and `dashboard.html` both exist in `_site`; `.qmd`→`.html` rewrite confirmed for the lab link.

## 📝 Evolution since the previous review

Verified intact in the arc pass — the WP3/WP4 fixes hold across files, not just within each:
- Freeze wording now agrees in **all three** places (deck, lab, root config); no stale "freeze caches a cell" or "true = default" residue anywhere.
- `library(brand.yml)` is present in the deck R-side snippet (`:189`) and `theme_brand_ggplot2()`/`theme_brand_gt()` framing is consistent with the lab.
- Cross-refs are reworded to resolve within a page, with the book caveat present in both deck and lab (and the lab Troubleshooting `?@…` bullet, `:193`).
- `solution/` ships as a completed Part-1 project and Ship-it opens from it; `contents: auto` is glossed (deck `:114`, lab hint `:113`), `renv::init()`/`snapshot()`/`restore()` shown (deck `:258-262`, lab `:145-147`).

The one new whole-arc catch (P1 above) is a build-topology seam — the `solution/` link is correct *as a filesystem path* but dead *as a site link* — which only a cross-artifact + rendered-site pass exposes.

# WP4 Day-2 Lab — Technique review (2026-07-08)

**Reviewer:** workshop-reviewer-technique
**Scope:** `labs/quarto-projects/index.qmd` (the lab) + shipped starter
`labs/quarto-projects/starter/index.qmd`, `starter/analysis.qmd`. Cross-checked against the
committed Day-2 deck `slides/quarto-projects/index.qmd` (bb5c9bf).
**Env:** Quarto 1.9.38, R 4.6.1 (both verified via `quarto --version` / `Rscript`).
**Working tree, uncommitted, branch `claude/goal-command-wx5go6`.**

---

## Overall verdict

The Website Challenge is technically clean and ships correctly: the solution `_quarto.yml` /
`_brand.yml` are valid, the navbar is well-formed, `output-dir: _site` matches the stated
artifact, the "nearest `_quarto.yml` = project root" claim is accurate, and the starter renders
as a standalone project once the solution config is dropped in. **One blocking bug sits in the
Ship-it Challenge: the `freeze: auto` demonstration is inverted.** The lab's central Part-2 proof
— "edit a line of prose, re-render, the R cell did *not* re-run" — is false for `freeze: auto`;
per the Quarto docs and an empirical test in this sandbox, `auto` re-executes whenever the
**source file** changes (prose included). Participants following Task 2 will watch the cell
recompute, contradicting the "You should see" box, live, in front of 40 people. That single
config value (`auto` → `true`, or reframe the demo) is the fix; everything else stands.

---

## 🔴 P0 — blocking technical bug

### P0-1 — `freeze: auto` does **not** skip on a prose edit; the Ship-it demo is inverted

The entire second challenge hinges on: *set `freeze: auto`, edit prose only, re-render, watch the
R cell get skipped.* That is not how `auto` behaves.

**Official docs** (`quarto.org/docs/projects/code-execution.html`, fetched during review):
> `freeze: auto` — *re-render only when **source** changes.*

A prose edit changes the source file, so the document re-renders and the cell re-executes.
Cell-level "re-run only when the code changed" is **`cache`** (knitr), not `freeze` — which the
deck itself draws correctly at `slides/quarto-projects/index.qmd:229-234`, then contradicts.

**Empirical confirmation** (minimal website project, `freeze: auto`, repo's renv library,
Quarto 1.9.38): a cell printing a timestamp froze at `06:20:29.837`; I edited **only prose**,
ran a full `quarto render` again → the frozen result changed to `06:20:34.876`. The cell
**re-executed on a prose-only edit.**

Every statement below is therefore wrong and must change together:

- `labs/quarto-projects/index.qmd:164` — `freeze: auto      # re-run a cell only when its own code changes` — false; `auto` re-runs on any change to the source file, and freeze is file-level, not cell-level.
- `labs/quarto-projects/index.qmd:167` — Task 2: "edit a line of **prose** on `analysis.qmd`, `quarto render` again — the R cell did **not** re-run" — it *will* re-run.
- `labs/quarto-projects/index.qmd:176-179` — "You should see … on the **second** render (after a prose-only edit) the log shows the R cell **skipped**" — the cell is re-executed, not skipped.
- `labs/quarto-projects/index.qmd:183-184` — Hint: "`freeze: auto` re-runs a cell only when its **code** changes … Editing prose alone re-runs nothing either way." — false for `auto`.
- `labs/quarto-projects/index.qmd:200-202` — Solution comment: "edit a sentence on analysis.qmd (prose only) … 2nd build: cell skipped, result reused from `_freeze/`." — false.
- `labs/quarto-projects/index.qmd:218-219` — Troubleshooting: "`auto` re-runs on any **code** change." — should read *any source change*.

**Fix options (pick one, keep deck + lab in lock-step):**

1. **Use `freeze: true` for the "edit-prose-watch-it-skip" demo.** `true` = *never re-render
   during a project render* → a prose edit is genuinely skipped. This is the honest way to show
   "no compute on rebuild," and the lab already describes `true` correctly at line 184
   ("never re-runs (the hard-freeze CI mode)").
2. **Keep `auto` but reframe the observable.** `auto`'s real payoff is the CI story the lab
   already tells (lines 179, 186): commit `_freeze/`, then render on a machine **with no R** —
   the frozen result is reused *because the source hasn't changed since the commit*. Demonstrate
   "render twice with **no** edit → second render skips," not "edit prose → skip."

**Cross-check note (not re-flagging the deck):** `slides/quarto-projects/index.qmd:241,245-246`
carries the identical wrong claim ("render → edit prose → re-render → the analysis didn't
re-run"). Whatever fix lands in the lab must also land in the deck, or Part 2 slide and lab will
disagree. The deck's `cache` vs `freeze` contrast (lines 229-234) is correct and can anchor the
corrected wording.

---

## 🟠 P1 — fix before the event

None beyond the propagation obligation folded into P0-1 (deck must move with the lab).

---

## 🟡 P2 — nice-to-have / robustness

### P2-1 — Warn that a single-file render always executes (guards the freeze demo)
The lab correctly instructs "from inside `starter/`, run `quarto render`" (whole-project render,
required for freeze to apply). But a participant who tests by running `quarto render analysis.qmd`
will see the cell execute **every time** regardless of freeze — the docs are explicit: *"an
incremental render of a single document or a project sub-directory always executes code."* A one
-line note in the Ship-it Hint ("test freeze with a full `quarto render`, not
`quarto render analysis.qmd` — single-file renders always execute") pre-empts a confusing false
negative that compounds P0-1.

### P2-2 — `tbl-means` labelled cell has no `tbl-cap`
`starter/analysis.qmd:30` labels the summary cell `tbl-means` but sets no `#| tbl-cap:`. Without
a caption it produces no numbered/cross-referenceable table (and nothing references `@tbl-means`,
so no broken `?@`). Harmless as shipped, but if the intent is "a figure **and a table**"
(lab line 87 / 176), add `#| tbl-cap: "Mean measurements by species."` so it reads as a proper
captioned table; otherwise the `tbl-` prefix is inert.

---

## ✅ Technical choices validated

- **`_quarto.yml` solution** (`index.qmd:121-135` / `48-64`) — valid: `project.type: website`,
  `output-dir: _site`, `website.title`, `navbar.left` items are well-formed `href` + `text`
  pairs (`index.qmd`, `analysis.qmd`). `format: html: theme: cosmo` is correct short-inside-long
  usage. No invented keys.
- **`_brand.yml` solution** (`index.qmd:137-143` / `68-76`) — valid brand syntax: `color.palette`
  + `color.primary`, `typography.fonts` (inline-flow `{family, source: google}`) + `typography.base`.
  Layering `_brand.yml` over `theme: cosmo` is legal; brand wins. Auto-discovery-at-root claim
  (line 111) is correct — no header line needed.
- **"Nearest `_quarto.yml` = project root"** (`index.qmd:107-108`) — accurate. Verified the
  parent `render:` list (`_quarto.yml`) is `labs/*/index.qmd`, which matches
  `labs/quarto-projects/index.qmd` but **not** `labs/quarto-projects/starter/index.qmd` (single
  path segment) — so the shipped starter is *not* double-rendered by the workshop site, and
  becomes its own project the moment `starter/_quarto.yml` is added. Claim of independence holds.
- **Starter renders as a project once the solution config is added** — the two starter pages
  declare no `format:` and correctly inherit `format: html` from the added project `_quarto.yml`;
  `[analysis](analysis.qmd)` link resolves to `.html`; both pages are ordinary `.qmd`. (In-sandbox
  nested-project render fails only on renv-not-active-in-subdir — a sandbox artifact, per the
  brief, not a content bug.)
- **Cross-references** — `@fig-mass` (`starter/analysis.qmd:25`) resolves within its page against
  the captioned `fig-mass` cell; `fig-target` (lab line 91) is display-only. The lab's guidance
  that cross-page numbering is a *book* feature and websites use plain links (lines 78-80, 216-217)
  matches the deck (`slides/…:140-157`). Consistent.
- **Code cell options** — correct `#|` syntax, dash-keyed throughout (`fig-cap`, `fig-alt`,
  `code-fold`, `fig-width`); solution blocks use `#| eval: false` so config YAML shown as R
  comments never executes. `#| message: false` on setup is consistent starter↔lab.
- **`freeze: true` semantics** (`index.qmd:184`) — described correctly ("never re-runs, the
  hard-freeze CI mode"). Only the `auto` branch is wrong (P0-1).
- **R correctness** — `datasets::penguins` verified present (R 4.6.1, 344 rows) with exactly the
  columns the code uses: `species island bill_len bill_dep flipper_len body_mass sex year`.
  `theme_brand_ggplot2()` (lab line 214, deck line 192) is a real exported function of the
  installed `brand.yml` package. Modern idioms throughout — `|>`, `.by = species`, no `%>%`.
- **`renv::snapshot()` framing** (lines 171-172, 220) — accurate second reproducibility leg,
  consistent with the deck's "two legs" slide.
- **Publish = watch-me** (lines 22, 149-152, 204) — consistent with the deck's watch-me callout
  (`slides/…:285-289`); no per-participant auth cliff.

---

## 📝 Evolution since the previous review

First technique review of the WP4 lab (newly authored; no prior lab review to diff). Relative to
the just-committed Day-2 deck it accompanies, the lab is well-aligned on structure (two ~30-min
challenges, break between), on the cross-page-refs-are-links teaching, on the publish-as-watch-me
boundary, and on the two-legs reproducibility story. The single inherited defect is the
`freeze: auto` prose-edit claim, which the lab faithfully mirrors from the deck (`slides/…:241,
245-246`) — meaning the correction is a coordinated deck+lab edit, not a lab-only patch.

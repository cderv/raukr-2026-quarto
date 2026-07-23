# Technique review — "Quarto docs" margin pointers + collapsible solutions

- **Scope:** the 6-commit delta since the 2026-07-23 cycle, `labs/quarto/index.qmd`,
  `labs/quarto-projects/index.qmd`, `labs/quarto/sample-typst.qmd` (prose only).
- **Reference commit:** c7d97e3, branch `claude/workshop-review-fuzcfj`.
- **Environment:** `quarto --version` → **1.9.38** (floor `>=1.9.0` in `_quarto.yml:22`); site
  rebuilt clean; both changed pages render without error.

## Overall verdict

Technically clean delta, nothing blocking. The page-level `format: html:` override **merges** with
the project HTML options (verified against the resolved metadata dump: `theme`, `toc-depth: 4`,
`number-sections`, `lightbox`, `code-copy` all survive; only `toc-location` flips to `left`), so no
option is silently dropped. `::: {.column-margin}` is the correct current idiom for arbitrary margin
asides, moving the TOC left is a legitimate collision fix, the `::::`/`:::` solution callouts render
as proper collapsed notes, and the literal `::: {#refs}` inside a ```` ```markdown ```` fence stays
as text (no stray `id="refs"` div in the output). All 9 doc URLs resolve `200` to canonical guide
pages. No multi-format conflict is introduced and the freeze is committed and git-clean.

## 🔴 P0 — blocking

None.

## 🟠 P1 — fix before the event

None.

## 🟡 P2 — nice-to-have / robustness

- **TOC-location now inconsistent across the site.** `labs/quarto/index.qmd:8` and
  `labs/quarto-projects/index.qmd:8` set `toc-location: left`; every other site page (`setup.qmd`,
  `index.qmd`, the decks) keeps the project default `toc-location: right` (`_quarto.yml:59`). This is
  a deliberate, commented trade-off (free the right gutter for the asides) and reads fine in
  isolation, but a participant moving between the lab and the setup page sees the TOC jump sides. If
  you want site-wide consistency without losing the margin, the alternative is to **keep TOC right**
  and rely on Quarto stacking the `.column-margin` content *above* the TOC in the same right gutter —
  it works, but on these dense pages the asides and a 4-deep TOC compete for vertical space, so the
  left-TOC choice is the cleaner call. Recommend keeping it; just flagging the cross-page seam.

- **`reference-location: margin` is not a substitute here (and correctly not used).** That option
  only relocates *footnotes/citations* to the margin, not arbitrary link asides, so `.column-margin`
  is the right mechanism for the "Quarto docs" pointer blocks. No action — noting it because the task
  asked whether a better idiom exists: there isn't one for this content.

- **Two-file `quarto render A B` invocation is fragile** (test-only observation, not a repo defect).
  `quarto render labs/quarto/index.qmd labs/quarto-projects/index.qmd` in one call aborted the second
  file with `pandoc: ... withBinaryFile: does not exist`; rendering each alone (or the whole project
  via `just render`) is clean. The shipped build paths are unaffected — just don't script a
  multi-file positional render.

## ✅ Technical choices validated

- **Page-level `format: html:` merges, does not replace** (the core question). Resolved metadata for
  `labs/quarto/index.qmd` shows `toc-location: left` alongside the inherited
  `theme: [default, ../../theme-html.scss]`, `toc-depth: 4`, `number-sections: true`,
  `lightbox: auto`, `code-copy: true`. Deep-merge with `_quarto.yml:56-66` confirmed; nothing dropped.
  Docs: <https://quarto.org/docs/projects/quarto-projects.html> (metadata merge) and
  <https://quarto.org/docs/reference/formats/html.html> (`toc-location: left` is a valid value).

- **`::: {.column-margin}` is the current, correct idiom** for margin asides
  (`labs/quarto/index.qmd:60,169,283`; `labs/quarto-projects/index.qmd:54,149`). Built HTML shows 3
  real `column-margin` divs on Day 1 and 2 on Day 2 (the 4th Day-1 grep hit is the literal
  `<code>column: margin</code>` in the Hint, not a div). Source:
  <https://quarto.org/docs/authoring/article-layout.html> (`.column-margin`).

- **All 9 doc URLs are live and canonical** (checked `200`, no redirect):
  `authoring/cross-references.html`, `authoring/article-layout.html`, `authoring/citations.html`,
  `output-formats/typst.html`, `computations/parameters.html`, `docs/websites/`,
  `authoring/brand.html`, `projects/code-execution.html#freeze` (the `id="freeze"` anchor exists),
  `docs/publishing/`. The two directory URLs are correctly written *without* `.html`.

- **`::::`/`:::` nesting is valid and renders.** The solution blocks
  (`labs/quarto/index.qmd:240-272`, `labs/quarto-projects/index.qmd:197-223`) use a 4-colon
  `:::: {.callout-note collapse="true"}` fence wrapping 3-backtick fenced `yaml`/`markdown`/`bash`
  code — built HTML shows the expected collapsed `callout-note callout-titled` blocks. The outer
  fence needs more colons than any inner div, and there are no inner divs here (just code fences), so
  even a 3-colon outer would parse; the 4-colon form is defensively correct.

- **Literal `::: {#refs}` stays text.** Inside the ```` ```markdown ```` fence at
  `labs/quarto/index.qmd:258-263`, the output contains the escaped text `{#refs}` and **no**
  `id="refs"` div — it is not parsed as a div. Correct.

- **No multi-format conflict.** Both pages declare a single `format: html`; no revealjs or extra
  format added, so the single-format website invariant holds (`_quarto.yml:3-5`).

- **Freeze committed and clean.** `git status` is clean at HEAD; the executed cells (`setup`,
  `fig-target`, `session`) are untouched by this prose/YAML delta, so `_freeze/` is current. A local
  re-render shows only benign one-line churn in the stored `markdown` field (environment stamp), not
  content drift.

- **Shortcode dependency satisfied.** `{{< fa book-open >}}` is backed by the installed
  `_extensions/quarto-ext/fontawesome` extension; built HTML emits `fa-book-open`. `book-open` is a
  valid Font Awesome free icon.

- **Prose idiom fixes are sound.** `sample-typst.qmd` "no LaTeX involved" and the reworded Day-1
  Citations goal read cleanly; the Scope "run Setup" trim is intentional (per brief, not re-flagged).

## 📝 Evolution since the previous review (2026-07-23 cycle)

- **Solutions upgraded from comment-cells to real fenced code.** The old
  `{r} #| eval: false` + `#| code-fold` blocks (commented pseudo-code) became
  `:::: {.callout-note collapse="true"}` callouts holding genuine ```` ```yaml ````/```` ```bash ````/
  ```` ```markdown ```` blocks. Technically better: the code is now copy-pasteable (real `code-copy`
  buttons) and syntax-highlighted per language, instead of an `# comment` wall. No executable cell,
  so no freeze impact.
- **Margin doc-pointers added coherently.** The `.column-margin` asides + `toc-location: left` are a
  matched pair — the TOC move is what keeps the asides off the right TOC. Both halves landed together.
- **Scope callouts slimmed** to a Setup pointer (intended); no package list drift because these index
  pages are website-only and not synced to the exercises repo.
- Already-good and unchanged: single-format-per-page discipline, the `#refs` div pattern taught in
  prose, the fontawesome shortcode usage, and the freeze/render pipeline.

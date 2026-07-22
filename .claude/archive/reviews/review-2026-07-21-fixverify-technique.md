# Technical review — fix-verification pass (2026-07-20 batch)

- **Reviewer:** workshop-reviewer-technique
- **Date:** 2026-07-21 · **Scope tag:** `fixverify`
- **Reference commit:** 356e840 (`claude/code-review-sync-h6uj17`); delta audited: `6a910a5..HEAD`
  (703e19d content fixes + 356e840 doc audit)
- **Quarto:** 1.9.38 (`quarto --version`) · **R:** 4.6.1
- **Smoke render:** `LANG=C.UTF-8 LC_ALL=C.UTF-8 quarto render` → **exit 0**, 11/11 files,
  `Output created: _site/index.html`; only the known/expected Typst `unknown font family`
  warnings from `sample-typst.qmd`'s `gt` font stack. *(A first render attempt died at the
  finalize step with `NotFound … rename 'slides/quarto/index.html' -> '_site/…'` — traced to
  **two other reviewer agents rendering the same worktree concurrently**, not to content; a solo
  re-run is clean and leaves `_freeze/` byte-identical to HEAD.)*

## Overall verdict

Every fix in the 2026-07-20 batch is **technically correct as landed**, and I found no
regression introduced by the batch. The centerpiece — the braced inline-code migration — is
verified end-to-end: every single-brace site executes to the right value in the built HTML,
every double-brace site renders the literal single-brace syntax with no brace leakage, and I
reproduced the underlying escape semantics empirically on Quarto 1.9.38 (5/5 cases match what
`slides.md` §5 now claims) and against
[quarto.org/docs/computations/inline-code.html](https://quarto.org/docs/computations/inline-code.html).
The freeze rewording, CI glosses, block-form `_brand.yml`, anchor and Wi-Fi fixes all check
out; all nine changed slides fit-check at 720/720 including fragment states. **0 P0 · 0 P1 ·
2 P2** (both one-liners, neither participant-blocking).

## 🔴 P0 — blocking technical bug

None.

## 🟠 P1 — fix before the event

None. (Verification detail per fix is in the ✅ section.)

## 🟡 P2 — nice-to-have / robustness

**1. The CI gloss lands one slide *after* CI's first on-slide appearance.**
The worklog records "CI glossed on first slide appearance (`#freeze-workflow`)", but the first
*body* use of the bare acronym is one slide earlier — `slides/quarto-projects/index.qmd:277`
(`#freeze` bullet: "commit it and **CI** rebuilds with **no R at all**"); the gloss
"*(the automated build that runs on every push)*" only arrives at
`slides/quarto-projects/index.qmd:316-317` (`#freeze-workflow`). The speaker note at `:296` does
gloss it verbally on `#freeze`, so a presenter following notes covers it — this is a
first-use-rule nit, not an accuracy bug (the gloss itself is a fair definition). Cheapest fix:
move the parenthetical to `:277`, or leave it to the spoken gloss deliberately.

**2. `slides.md` §5's "single brace = executes" holds only when a computation engine is active.**
Empirically (scratchpad renders, Quarto 1.9.38): in a document with **no executable cell**, the
markdown engine is used and `` `{r} 1+41` `` renders **literally** — it does *not* execute; add
one `{r}` cell and the same file executes it everywhere (prose → 42, double-backtick span → 42,
inside a ```` ```markdown ```` display block → 42). Every current repo use sits in an
engine-active document (`slides/quarto/index.qmd`, both Day-1 labs all have R cells), so nothing
is wrong today — but a one-line caveat in `.claude/rules/slides.md:97-105` ("assumes the doc has
at least one executable cell") would keep the rule from misleading a future edit to a
markdown-only page. Doc-precision only.

## ✅ Technical choices validated (fix-by-fix verification)

**Braced inline-code migration — correct at every site, no leakage, no mis-execution.**

- *Executable sites execute:* built HTML shows `We measured <strong>342</strong> penguins`
  and "342 penguins of 3 species — Adelie, Chinstrap, and Gentoo" for
  `labs/quarto/starter.qmd:29-30`, `labs/quarto/penguins-report.qmd:33-34`, and
  `slides/quarto/index.qmd:301` (`_site/labs/quarto/starter.html`,
  `_site/labs/quarto/penguins-report.html`, `_site/slides/quarto/index.html`). The
  `Adelie\,` comma-escapes visible in the frozen intermediate markdown
  (`_freeze/labs/quarto/starter/execute-results/html.json`) are pandoc escapes and render as
  plain commas — cosmetically clean.
- *Literal sites stay literal:* `slides/quarto/index.qmd:154` (`#anatomy`, inside the
  4-backtick `{.markdown code-line-numbers="|1-4|6|8-13"}` block) and `:296` (`#inline-code`,
  inside a ```` ```markdown ```` block) use the double-brace escape `` `{{r}} …` `` and render
  the literal `` `{r} nrow(penguins)` `` — screenshot-verified on both slides;
  `grep -c '{{r}}' _site/slides/quarto/index.html` → **0** (no brace leakage). The
  `code-line-numbers` ranges still map correctly onto the 13-line block (1-4 YAML / 6 inline /
  8-13 cell).
- *Semantics matrix reproduced* (minimal doc with one `{r}` cell, Quarto 1.9.38): prose
  `` `{r} x+1` `` → 42 · double-backtick span → 42 · inside a display block → 42 ·
  `` `{{r}} x+1` `` in a block → literal · `` `{{r}} x+1` `` inline → literal. This confirms
  both the "gotcha" that motivated the double-brace fix and the new `slides.md` §5 text (modulo
  P2-2). Doc cross-check: quarto.org states the braced form "works across all three engines
  (Jupyter, Knitr and OJS)" and documents the double-brace / extra-backtick escapes —
  the quote in `project-context.md:162-165` and `slides.md` §5 is accurate.
- *No stragglers:* `knitr::inline_expr` is gone repo-wide; no legacy `` `r expr` `` inline
  remains outside `labs/quarto/sample-typst.qmd` (deliberate, dispositioned — not re-flagged).

**`freeze: auto` rewording — accurate.** `slides/quarto-projects/index.qmd:288` now reads "the
sane setting to adopt", exactly the phrasing the 2026-07-20 review proposed; the incorrect "the
default" claim is gone. The residual "(the sane default)" at `:285` (YAML comment) and `:332`
(speaker note) was explicitly accepted by that review (`review-2026-07-20-technique.md:40-43`)
as a recommendation-reading — dispositioned, not re-flagged.

**CI rewordings — technically accurate.** "The project build and **CI** … stay **R-free**"
(`slides/quarto-projects/index.qmd:316-318`), "no R needed in CI" (`:372`), lab "lets CI render
the site with no R at all" (`labs/quarto-projects/index.qmd:172-173`) and "`freeze: true` …
(the CI mode)" (`:181`) all hold under the taught commit-`_freeze/` workflow: with the source
hash unchanged, a project render reuses frozen results and never starts R — verified here by a
solo full render leaving `_freeze/` byte-identical to HEAD. The "exactly how quarto.org itself
is built" anchor (`freeze: true` in `quarto-dev/quarto-web/_quarto.yml`) was verified in the
previous cycle and is unchanged.

**Lab `_brand.yml` block-form YAML — valid and now canonical.**
`labs/quarto-projects/index.qmd:79-88` parses cleanly (`yaml.safe_load` →
`color.palette.teal` / `color.primary` / `typography.fonts[{family, source: google}]` /
`typography.base.family`, all legal brand.yml keys) and is **byte-identical** to the shipped
`labs/quarto-projects/solution/_brand.yml` — the P2-3 copy-vs-solution divergence is fully
closed, not just stylistically approximated.

**Anchor + Wi-Fi fixes.** `slides/quarto-projects/index.qmd:181` now shows
`[analysis page](analysis.qmd)` — no `sec-model` string remains anywhere in `**/*.qmd`, and the
plain page link is the right teaching example for the "across pages, use ordinary links" point.
`setup.qmd:98` "conference Wi-Fi" — no lowercase `wifi` left in any `.qmd`.

**Slide fit-checks — all changed slides pass.** `slide-shot.mjs` on the built decks:
D1 `learning-outcomes`, `anatomy`, `inline-code` and D2 `learning-outcomes`, `xrefs`, `freeze`,
`freeze-workflow`, `publishing`, `demos` all report `scrollH == clientH == 720`;
`--all-fragments` re-runs on `inline-code`, `freeze`, `freeze-workflow` also 720/720.
Screenshots eyeballed: no horizontal clip in the `#anatomy` display block, no fragment/aside
collision.

**`.claude` doc audit (356e840) — spot-checked claims hold.**
- `quarto-doc-sources.md:19-22` (Context7 can be disconnected → quarto.org is the fallback
  source of truth): sound advice; Context7 happens to be *reachable* today
  (`resolve-library-id` returns `/quarto-dev/quarto-web` etc.), which the "can be" phrasing
  correctly allows for.
- `sandbox-setup.md:148-155` (`sample-typst.qmd` `gt` `check_named_colors` live-render failure
  masked by committed `_freeze/`): consistent with the dispositioned known issue and with the
  observed green project render; mechanism description (freeze reuse / stale-freeze hook)
  matches `.claude/hooks/check-freeze.sh` behavior. Not destructively re-verified (would
  require deleting a committed freeze).
- `topic-store.md:81,218` legacy → braced inline swaps: match the shipped content.
- `project-context.md:162-168` braced-idiom + escape + `sample-typst` exception: accurate,
  verified above.
- `rules/slides.md` §5: accurate except the engine-active caveat (P2-2).

**Incidental (informational, not a defect):** `slides/quarto/index.qmd`'s frozen result embeds a
`gt` table whose HTML id is randomized per execution (`gthjthmexo` → new id on any re-run), so
any re-execution of that deck produces a large-looking but content-identical `_freeze/` diff
while the source hash stays the same. Expected freeze behavior — worth knowing when reading
`_freeze/` diffs, especially with parallel agents rendering.

## 📝 Evolution since the previous review (2026-07-20)

- The single P1 from the last technique review (`freeze: auto` "the default") is fixed with the
  exact wording that review proposed; the P2-3 lab/solution `_brand.yml` divergence is closed to
  byte-identity. Nothing from the prior fix list regressed.
- The inline-code migration (raised as a beginner P1, `knitr::inline_expr` showing literally) was
  fixed by moving *forward* to the modern braced idiom rather than back to the legacy form — the
  right call for the 2026 house line, and the discovered escape gotcha was banked into
  `slides.md` §5 / `project-context.md` so it can't bite the next edit. The rule text is
  empirically correct (5/5 test cases) with one small missing caveat (P2-2).
- The repo continues to render exit-0 with a self-consistent committed `_freeze/`; the freeze
  discipline (hook + committed results) demonstrably delivers the R-free rebuild the slides
  claim, which is the best kind of internal corroboration for the CI story being taught.

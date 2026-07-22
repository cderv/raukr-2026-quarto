# Status-confirmation review — whole two-day arc (technique)

**Date:** 2026-07-12 · **Reviewer:** workshop-reviewer-technique (status-confirmation pass)
**Scope:** the shipped whole — Day 1 (`slides/quarto/` + `labs/quarto/`) + Day 2
(`slides/quarto-projects/` + `labs/quarto-projects/` incl. `starter/`, `solution/`, `dashboard.qmd`)
+ root wiring (`_quarto.yml`, `_brand.yml`, `index.qmd`, `setup.qmd`, `theme.scss`, `theme-html.scss`).
**Environment:** Quarto **1.9.38**, R **4.6.1**, renv library present.
**Method:** read every active source; full `LANG=C.UTF-8 quarto render`; scanned rendered `_site/`;
checked freeze drift via `git status`.

---

## Overall verdict

**Confirmed ready.** The "content-complete and arc-verified" claim holds up under an independent
end-to-end pass. A full `quarto render` completes cleanly (**exit 0**, all 11 targets, including the
branded Typst PDF at `_site/labs/quarto/sample-typst.pdf`), and `git status` is **empty afterward** —
the versioned `_freeze/` is consistent with source, so nothing re-executed into a drift. The two
prior-cycle structural fixes both held: the **freeze semantics** (`auto` = re-execute only when a
doc's own source changes; render-twice-no-edit → skip) is stated correctly and identically in deck
and lab, and the **cross-refs book-vs-website trap** is taught correctly (within-page resolves;
cross-page = links + nav; global numbering = `type: book`). Brand teal `#4C979F` is baked into the
compiled Bootstrap CSS, the dashboard compiles its full layout (28 valuebox/card nodes), and no
unresolved `?@`/`[?]` markers leak into any rendered page (every `?@` in output is intentional
troubleshooting text inside `<code>`). The only genuine remaining item is a **stale "under
construction" notice on the public landing page** — cheap, but participant-visible.

Counts: **P0 = 0 · P1 = 1 · P2 = 3.**

---

## 🔴 P0 — blocking technical bug

None. A full end-to-end render passes today.

---

## 🟠 P1 — fix before the event

**P1-1 — Landing page still declares the site "under construction / skeletons".**
`index.qmd:12-14`:

```markdown
::: {.callout-note}
This site is under construction — the pages below are skeletons while the programme is authored.
:::
```

This is now **false** and self-contradicting: the programme table directly below links to fully
authored slides + labs, and the whole arc is content-complete. It is the first thing a participant
sees on the live site during the session — an actively misleading note on the exact page they land
on. One-line delete (or swap to a "last updated / by Christophe Dervieux" line). Not a render
blocker, which is why it's P1 not P0, but it should not ship as-is on event day.

---

## 🟡 P2 — nice-to-have / robustness

**P2-1 — Leftover author TODO comment in a shipped page.** `setup.qmd:40`:
`<!-- TODO: extend DESCRIPTION Imports + renv::snapshot() as the exercises pull in more packages. -->`
Invisible in the rendered page (HTML comment) and harmless, but it's a maintenance note living in a
learner-facing source file. Degrades gracefully; remove or move to the worklog at leisure.

**P2-2 — Typst font-fallback warnings are noisy but expected.** The render emits a wall of
`warning: unknown font family: segoe ui / roboto / helvetica / …` from
`labs/quarto/sample-typst.typ:477` (the `gt` table's default fallback stack). **Albert Sans itself
is *not* in the unknown list**, confirming the brand font was fetched and carried into Typst — so
these are purely cosmetic, exactly as the lab troubleshooting section already documents
(`labs/quarto/index.qmd:250-252`). No action needed; noted so a future reader doesn't mistake them
for a regression. (These are the "Linux font-fallback warnings are expected, not blockers" category.)

**P2-3 — Two open-strand TODO markers remain in source (both degrade gracefully — see below).**
`slides/quarto/index.qmd:283-288` (Positron screenshot) and `slides/quarto-projects/index.qmd:25-26`
(logos). Neither breaks anything; listed here only so they're not forgotten when the assets land.

---

## ✅ Technical choices validated

- **Full render passes on the target toolchain.** Quarto 1.9.38 + R 4.6.1: all 11 render targets
  build, revealjs decks + HTML pages + dashboard + the Typst PDF. `_site/` is complete (10 HTML
  pages + `sample-typst.pdf`).
- **`_freeze/` is consistent — zero drift.** `git status --short` is empty after a full project
  render: frozen results matched source, nothing silently re-executed. This directly answers the
  "would a full end-to-end render plausibly pass given `_freeze/` is versioned" question — **yes,
  verified at-machine this pass.**
- **Prior P0 (freeze semantics) held.** `slides/quarto-projects/index.qmd:246-251` and
  `labs/quarto-projects/index.qmd:137-166` both describe `auto` = "re-execute a document only when
  its own source changes" and the honest render-twice-no-edit → skip demo. No inverted claim survives.
- **Prior trap (cross-refs book-vs-website) held.** `slides/quarto-projects/index.qmd:145-162` states
  within-page `@fig-`/`@tbl-`/`@sec-`/`@eq-` resolve, cross-page needs Markdown links + navbar/sidebar,
  and global numbering is a `type: book` feature. Correct for Quarto 1.9. **No shipped file actually
  attempts a cross-page numbered `@ref`**, so the delivered materials cannot surface a broken `?@`
  from this — the risk is purely a presenter live-demo one, correctly flagged in the `::: notes`.
- **Cross-references + citations all resolve in output.** No `?@`/`[?]` in any rendered page except
  intentional `<code>?@…</code>` troubleshooting text; `@gorman2014` resolves to "Gorman…" (3×) in
  `penguins-report.html`; within-page `@fig-`/`@tbl-`/`@eq-` labels each have a matching, unique,
  correctly-prefixed cell across deck, labs, starter, solution, report, and typst payoff.
- **Format validity + pages-vs-slides discipline.** Root defaults `format: html`; both decks override
  to `format: revealjs` in their own front-matter (replace semantics); `dashboard.qmd` declares
  `format: dashboard`; `sample-typst.qmd` declares `format: typst`. No invented keys, no multi-format
  conflict, no page silently rendered in the wrong format.
- **`_brand.yml` well-formed and applied.** `color: palette:` + roles, `typography: fonts/base/
  headings/monospace/link` all valid; teal `#4C979F` confirmed baked into compiled Bootstrap CSS
  (light + dark). Nested `solution/_brand.yml` is a valid standalone brand. No `logo:` key is
  referenced anywhere, so the absent logos can't 404.
- **Nested-project exclusion is correct.** `starter/` and `solution/` carry their own `_quarto.yml`;
  the parent render list uses single-level globs (`labs/*/index.qmd`) + explicit entries, so those
  subfolder pages are not walked into the parent build — and the lab correctly points at
  `` `solution/` `` as a cloned-repo folder path, not a site link (the prior arc-review P1 fix held).
- **Code-cell options coherent.** `#|` hash-pipe throughout, dashes-not-dots keys; folded solutions
  use `#| eval: false` with the inner `#| label:`/`#| column:` shown as teaching text (not executed);
  every figure carries `fig-alt`. `execute: freeze: auto` set once at root.
- **R portability.** Base-R `datasets::penguins`, `|>` throughout (no `%>%`), `.by =` idiom
  consistent across all executable surfaces; packages (`dplyr`, `ggplot2`, `gt`, `brand.yml`,
  `ggrepel`, `prismatic`) all declared in `setup.qmd` + renv. `theme_brand_gt()`/`theme_brand_ggplot2()`
  actually run (the Typst payoff renders green using them). Editor framing stays agnostic
  (Positron / VS Code / RStudio / CLI).

---

## 📝 Verify-at-machine items — status after this pass

| Item flagged by the plans | Status now | Residual doubt |
|---|---|---|
| **Cross-page cross-refs behaviour** | **Closed for shipped content.** Claim is stated correctly; no delivered artifact exercises a cross-page numbered `@ref`, and the full render produced no `?@`. | Presenter-side only: the deck's own advice to "test one cross-page `@fig-` on your installed Quarto" before a *live* demo remains sensible but affects nothing shipped. |
| **Live-publish auth** | **N/A by design.** Framed as a watch-me demo on a pre-provisioned repo (`slides/quarto-projects/index.qmd:290-294`); never run live, never relied on. Correct mitigation of the original beginner P0. | Cannot and need not be "verified" — it is deliberately not on the hands-on path. |
| **Demo reproducibility** | **Verified this pass.** Full project render green on R 4.6.1 + Quarto 1.9.38 with zero freeze drift. | None locally. A participant on a fresh machine still depends on `renv::restore()` succeeding — standard, out of scope here. |
| **`freeze: true` / CI-renders-without-R claim** | **Mechanism verified.** `_freeze/` is versioned and the render reused frozen results with no drift, which is exactly what lets CI skip execution. | The literal "renders with **no R** on the runner" end-state can't be exercised here (R is present locally); it is a standard, correct Quarto behaviour, so residual doubt is low. Would only be closed by an actual R-absent CI run. |

## Open strands — do they leave a broken rendered state?

**No — both degrade gracefully, confirmed against the render.**

- **Positron screenshot (`the tracker`).** The `![](images/positron-quarto-preview.png)` markdown is
  entirely inside an HTML comment (`slides/quarto/index.qmd:283-288`), so it is never emitted — no
  404, no broken `<img>`. `slides/quarto/images/` contains only a `README.md` placeholder (tracked),
  no dead binary reference. The slide still teaches via prose + the CLI slide. Swap-in is the
  documented one-liner.
- **Logos (`the tracker`).** A `<!-- TODO(logos) -->` comment in the Day-2 deck; `_brand.yml` has no
  `logo:` key, and nothing references a logo asset, so there is no missing image to 404. Brand renders
  green without it.

Neither strand produces a dead link, a missing rendered image, or commented-out markdown that leaks
into output.

---

## Evolution since the previous review

Nothing to re-flag from the ledger — the freeze-semantics P0 and the cross-refs book-vs-website P1
from the WP4 / day2-arc cycles are both **confirmed still fixed** in the current source, and the
`solution/`-link-404 arc-review P1 is confirmed applied (code-styled folder path, not a site link).
This pass adds what the earlier cycles couldn't assert at the time: an **actual full-project render
on the intended toolchain (Quarto 1.9.38 + R 4.6.1) with the versioned `_freeze/` proven
drift-free** — the strongest evidence yet that the two-day arc will render on a clean checkout. The
one net-new finding is housekeeping: the landing page's obsolete "under construction" notice
(P1-1), which the content-completion work outran without updating the front door.

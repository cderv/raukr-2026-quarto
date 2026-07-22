# Technical review — RaukR 2026 Quarto (both days)

- **Reviewer:** workshop-reviewer-technique
- **Date:** 2026-07-20
- **Reference commit:** 6a910a5
- **Quarto:** 1.9.38 (`quarto --version`) · **Scope:** whole repo, both days
- **Smoke render:** `LANG=C.UTF-8 LC_ALL=C.UTF-8 quarto render` → **exit 0**, 11/11 files

## Overall verdict

The repo is in strong technical shape and ships clean: a full `quarto render` completes
with exit 0, emitting only the expected, documented Typst `unknown font family` fallback
warnings on the `gt` default font stack — no blockers. Every real cross-reference resolves
to a number (`penguins-report.qmd`: Figure 1/2, Table 1, Equation 1) and every citation
renders (Gorman et al., 2014); the only `?@`/`[?]` strings in the built HTML are deliberate
troubleshooting copy. Format validity, the four output formats (html / revealjs / typst /
dashboard), `_brand.yml`, the `typst-render` extension, the project render list, and slide
overflow all check out across ~15 spot-checked slides. I found **no P0 and no true build
break**; two precision/robustness items are worth a look before the event.

## 🔴 P0 — blocking technical bug

None.

## 🟠 P1 — fix before the event

**1. `slides/quarto-projects/index.qmd:288` — `freeze: auto` is described as "the default", which is incorrect.**

```
That's `freeze: auto`, the default — a page re-runs only when its own source changes.
```

Quarto's built-in default is **no freeze** — documents re-execute on every render; `freeze`
is opt-in (`auto` or `true`) and must be set explicitly. Confirmed against
[quarto.org/docs/projects/code-execution.html](https://quarto.org/docs/projects/code-execution.html)
(freeze is presented purely as an optional technique; the unset state executes every render).
Internal corroboration: this repo's own `_quarto.yml:66-67` *sets* `execute: freeze: auto`
explicitly — if it were the default it wouldn't need setting. For this precise audience the
phrasing risks a returning researcher omitting `freeze` in CI on the belief that `auto` is
automatic, then being surprised when the runner re-runs R. The line-285 comment already softens
it to "(the sane default)"; reword line 288 to match — e.g. "That's `freeze: auto` — the sane
value to adopt" — reserving "default" for its true meaning. (`#freeze-workflow:321` says "the
sane default", which is fine as a recommendation.)

## 🟡 P2 — nice-to-have / robustness

**2. renv is not activated when rendering the Day-2 lab from `starter/`.**
renv activates via the repo-root `.Rprofile` (`renv/activate.R`). The Day-2 lab instructs
`cd starter/` then `quarto render analysis.qmd` (`labs/quarto-projects/index.qmd:42`), where the
knitr engine's R process starts in the subdirectory and does **not** source the repo-root
`.Rprofile`, so the pinned renv library is off the path. In this sandbox that fails with
`The knitr package is not available` (verified: knitr resolves only to
`renv/library/.../knitr`, nothing global). Most real participants have a global knitr and
won't notice (they'd just get unpinned versions); anyone who set up strictly via
`renv::restore()` will hit it. Consider a one-line lab note ("if you see *knitr not available*,
your renv library isn't on the path from this subfolder — install knitr globally or open R at
the repo root"), or drop a minimal `renv` activation into `starter/`. Note this also means the
`starter/`/`solution/` projects' R execution is never exercised by the main site render (they're
correctly excluded from the render list), so the sandbox can't validate them without renv active.

**3. Lab `_brand.yml` example uses flow-mapping YAML, diverging from the shipped solution.**
`labs/quarto-projects/index.qmd:80,83` teaches:
```yaml
color:
  palette: { teal: "#4C979F" }
  primary: teal
typography:
  fonts: [{ family: Albert Sans, source: google }]
  base: { family: Albert Sans }
```
It's valid YAML and parses fine, but the shipped `solution/_brand.yml`, the project `_brand.yml`,
and both slide decks (`slides/*/index.qmd`) all use block form — and the 2026-07-17 fix
deliberately moved the *slides* off inline `{ }`. A participant who copies the lab snippet ends up
with a stylistically different file than the `solution/` they're told to compare against. Cosmetic;
align to block form for one consistent house idiom.

**4. `slides/quarto/index.qmd` `#citations` (slide 23/29) is dense.** Fits at 720
(`scrollH==clientH==720`, no clip), but the bottom `::: aside` (the CSL definition) sits very
close to the `::: {#refs}` code block. Screenshot-verified readable; a touch more breathing room
(or moving the CSL gloss to `::: notes`) would harden it against future edits.

## ✅ Technical choices validated

- **Smoke render:** exit 0; the only warnings are `unknown font family: system-ui / Segoe UI / …`
  from the plain `gt` table's default font stack in `sample-typst.qmd` — exactly the harmless case
  the lab troubleshooting already documents (`labs/quarto/index.qmd:263-265`).
- **Cross-references & citations resolve.** Built output: `#fig-culmen`→Figure 1, `#fig-bill`→Figure 2,
  `#eq-ratio`→Equation 1, `#tbl-summary`→Table 1; Gorman et al., 2014 renders in-text and in the APA
  reference list. Every `?@`/`[?]` in `_site/**` is intentional teaching copy ("@ref renders a stray
  `?@`", the troubleshooting rows), not a broken ref.
- **Format validity.** Only real formats: pages `format: html` (project default), decks
  `format: revealjs` (1280×720, `slide-level: 2`) in their own front-matter, `sample-typst.qmd`
  `format: typst` (papersize/margin/toc/linestretch all valid keys), `dashboard.qmd`
  `format: dashboard`. No multi-format conflict; `sample-typst.pdf` (89 KB) and the dashboard HTML
  both build.
- **`_brand.yml` well-formed and applied.** `color.palette` + `primary`/`secondary`/`foreground`/
  `background`, `typography.fonts`/`base`/`headings`/`monospace`/`link`. Link color correctly lives
  under `typography.link.color` (AA-compliant `#3C7C83`) with the palette note explaining why it's
  not a top-level role. `#4C979F` is present in the built site CSS (revealjs theme + page HTML) —
  brand is actually reaching output. `theme.scss` + `theme-html.scss` both present and referenced.
- **Extension / shortcodes.** `typst-render` is installed (`_extensions/mcanouil/typst-render`),
  declared in the Day-1 deck `filters:`, and produces `typst-figures/typst-block-1.svg` for the
  engine flowchart. No undeclared `{{< … >}}` shortcodes anywhere in participant content.
- **Project YAML coherent.** Explicit `render:` list matches the 11 rendered files; `starter/` and
  `solution/` (single-level globs) are correctly excluded. Verified empirically that a single-file
  render of a nested `starter/` file lands **next to its source**, not in the repo `_site/` — so the
  lab's "cd starter/ … analysis.html right next to its source" claim (`labs/quarto-projects/index.qmd:42`)
  is **correct**. `quarto-required: ">=1.9.0"` matches the 1.9-only Typst margin/marginalia claim.
- **Slide overflow.** Spot-checked D1 {how-it-works, markdown-content, figures, citations, brand,
  your-turn-2, wrap-up} and D2 {why-project, metadata, xrefs, freeze, freeze-workflow, websites,
  demos} — all `scrollH==clientH==720`; `--all-fragments` on the aside-bearing slides
  (why-project, websites, demos) stays 720 with no body/aside collision; no horizontal clip in any
  `::: {.column}` code block. `theme.scss` adjacency `@each` correctly covers all three code-block
  wrappers.
- **House line respected.** Zero `%>%` in participant content; Positron named alongside VS Code /
  RStudio (`slides/quarto/index.qmd:424`, `setup.qmd:19`); no stale hardcoded version strings; the
  `1.4+` (Typst bundled) and `≥ 1.9` (margin layout) claims are accurate. No "capstone" in
  participant-facing files.
- **`data(penguins)` + base-R names** (`bill_len`/`bill_dep`/`body_mass`) used consistently across
  all 10 executable docs; R ≥ 4.5 floor and the palmerpenguins fallback are correctly stated in
  `setup.qmd`.

## 📝 Evolution since the previous review (2026-07-17)

- **Freeze split landed cleanly.** `#freeze` (cache-vs-freeze concept) + `#freeze-workflow`
  (`freeze: true`, render-on-demand) both render without overflow; Day-2 deck confirmed at **19
  slides** (screenshot slide-numbers 5/19 … 18/19). The cache = engine's cache (knitr / Jupyter
  Cache), freeze = Quarto's project-only switch distinction is accurate vs quarto.org. The one
  residual nit is the "the default" wording (P1 above), not the split itself.
- **`_brand.yml` slides now block YAML** — confirmed `slides/quarto/index.qmd:605` and
  `slides/quarto-projects/index.qmd:203` use `palette:` block form. (The remaining flow-mapping is
  in the *lab*, P2 #3 — not previously in scope.)
- **Brand setup→payoff pair is coherent and its callbacks are true.** Day-1 `#brand` scopes the
  claim to the Typst PDF it actually builds; Day-2 `#brand` widens the *same file* to project scope
  (auto-discovery + `brand: false`/`brand: other.yml` escape hatch). Verified Day 1 does build a
  branded PDF, so the Day-2 "you wrote this yesterday" callback is accurate. The Day-1 `#execution`
  freeze teaser is picked up verbatim on Day-2 `#freeze` ("Day 1 I teased freeze — here's the full
  story"). `@sec-` is introduced on `#xrefs` as a parallel ("work the same way"), not falsely
  attributed to Day 1 — matches the intended design.
- **"team project" swap complete**; publishing / metadata / lab cross-ref stretch all present and
  render. Nothing from the prior fix list regressed.

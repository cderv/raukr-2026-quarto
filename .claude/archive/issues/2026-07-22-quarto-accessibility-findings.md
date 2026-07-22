# Quarto accessibility findings — three candidate upstream issues (2026-07-22)

Found during an axe-driven WCAG pass on the RaukR 2026 site (worklog 2026-07-22; fixes in
`theme-html.scss`, captured in `rules/brand.md § 5`). **None are filed.** All three were observed on
**Quarto 1.9.38**; **verify each against 1.10.x before filing** — 1.10.16 is out but couldn't be
installed in this session (the GitHub release download is off-scope for the sandbox proxy), and some
of these may already be fixed. Repo: `quarto-dev/quarto-cli`.

---

## A. `_brand.yml` `typography.link.color` does not reach HTML `$link-color` (highest value)

**Claim (verify first — could be a config-form issue, not a bug).** With a project `_brand.yml` that
sets a link colour under `typography.link.color`, the compiled HTML keeps the Quarto **default**
`--bs-link-color: #2a76dd` instead of the brand colour, so every link (content links, cross-refs,
citations, TOC, refs) renders the default blue — which also happens to fail WCAG AA (#2a76dd on white
= **4.43:1**).

**Minimal repro.**
```yaml
# _brand.yml
color:
  palette:
    brandlink: "#33666B"
typography:
  link:
    color: brandlink
```
```yaml
# doc.qmd
---
title: t
format: html
---
A [link](https://example.com).
```
Render, then inspect the compiled `--bs-link-color` (in `site_libs/bootstrap/bootstrap-*.min.css`):
observed `#2a76dd`, not `#33666B`.

**Expected:** `typography.link.color` feeds Bootstrap's `$link-color` so `--bs-link-color` is the
brand colour. **Actual:** stays the Quarto default.

**Before filing:** confirm the config form is correct — does `typography.link.color` accept a
**palette-key reference** (`brandlink`) or does it require a literal hex / a different key? If a
palette ref is unsupported there, this is a docs/validation gap rather than a wiring bug. Our
workaround: set `$link-color` explicitly in a `theme-html.scss` `scss:defaults` block.

---

## B. Default `arrow` highlight tokens fall below WCAG AA on the default code-cell background

**Claim.** Quarto renders code cells on a light-grey background (`#eceef1` here) while the default
`arrow` highlight theme's token colours are tuned for white. Some tokens then miss AA: the
**attribute** token `.at` (`#657422`) on `#eceef1` = **4.43:1** (it clears on pure white at 5.15:1).

**Repro.** Any `format: html` doc with an R cell using named arguments (e.g. `count(species, name =
"n")`), rendered with defaults; run axe-core (or a contrast checker) on the `.at` spans → 4.43:1.

**Expected:** shipped default theme + default code-cell background clear AA for all tokens.
**Actual:** at least `.at` is sub-AA on the grey cell background. Not brand-specific (reproduces with
no `_brand.yml`). Fix would be either a slightly lighter code-cell bg or an arrow-token tweak; note
`_brand.yml` cannot reach token colours (`rules/brand.md § 4`), so this is a Quarto-defaults concern.

---

## C. The built-in `axe:` checker reports false-positive contrast violations on callout icons/toggles

**Claim.** Quarto's `axe:` integration (axe-core) reports `color-contrast` violations on callout
**collapse toggles** (`div[data-bs-target=".callout-N-contents"]`) and **FontAwesome callout icons**
(`.fa-*`), with **empty `fg/bg` data** — axe can't resolve the callout header's semi-transparent
background. A direct computed-style probe shows those elements are body-ink (`#222`) on a light tint
(~13:1) — i.e. **not** real failures.

**Repro.** A doc with collapsible callouts (`::: {.callout-note collapse="true"}`) + `format: html`
with `axe: {output: json}`; the violation list includes those nodes with no fg/bg.

**Expected:** the checker either resolves the effective (composited) background or excludes elements
it can't resolve, so the report isn't noisy with unactionable entries. **Actual:** they surface as
violations. This is partly an axe-core limitation, but Quarto's integration is what presents it — a
default exclusion or a note in the html-accessibility docs would help. Lowest priority of the three.

---

**Environment:** Quarto 1.9.38; project `type: website`, `format: html` with `theme: [default,
theme-html.scss]` + a project `_brand.yml`. Verified with axe-core 4.10.3.

# Quarto accessibility findings — three candidate upstream issues (2026-07-22)

Found during an axe-driven WCAG pass on the RaukR 2026 site (2026-07-22; fixes in
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

---

## Prior-art check (2026-08-01)

Searched `quarto-dev/quarto-cli`. cderv already filed an 11-issue a11y batch on 2026-04-17
(**#14375-#14384**, all open) plus **#14710** (2026-07-20) from earlier axe passes. None of them is
A, B or C below.

- **A (brand `typography.link.color` does not reach `$link-color`)** — not filed. Note **#11254**
  "Implement `brand.typography.link` for HTML formats" is **closed/implemented** (2024-10), so the
  feature exists: either this is a regression or the palette-key form is the problem, which is
  exactly the open question this draft flags. Resolve that before filing. Adjacent: **#12877**
  (`brand.typography.link.background-color` applies to the mode toggle, open).
- **B (`arrow` `.at` token sub-AA on the grey code-cell background)** — not filed. Closest are
  cderv's **#14383** (appendix code `<details><summary>` fails color-contrast) and mcanouil's
  **#14090** / **#14135** (code-block background colour) — related area, different element.
- **C (axe false positives on callout icons/toggles)** — not filed. Nearest is **#14668**
  "`axe: output: document`: report never updates after page state changes" (cwickham, open), which
  is a different defect.

**Action:** A, B and C are all still unreported. Verify each against 1.10.x before filing (Quarto
1.10.18 is installable now, so the blocker noted above is gone).

---

## Verified against Quarto 1.10.18 (2026-08-01)

### A — brand `typography.link.color` → `$link-color`: **FIXED, do not file**

Tested both config forms (palette-key reference *and* literal hex). Both now work:
compiled `--bs-link-color: #33666B` and the rendered link's computed colour is
`rgb(51, 102, 107)` = the brand colour. On 1.9.38 this was the Quarto default `#2a76dd`.
The open question in the draft ("is a palette-key ref supported?") is moot — both forms feed
Bootstrap correctly. Fixed somewhere in 1.10; drop this candidate. The `$link-color` override in
`theme-html.scss` is now belt-and-braces rather than a workaround (its comment says as much: "May be
1.9-only; recheck on 1.10+").

### B — `.at` token below AA: **REPRODUCES, but the diagnosis in this draft is wrong**

The draft blamed a flat `#eceef1` code background. The real cause is narrower and cleaner:

Quarto's **inline**-code rule
`p code.sourceCode, li code.sourceCode, td code.sourceCode { background-color: rgba(233,236,239,.65) }`
also matches **block** code when the block sits inside a list item. The block already sits on
`div.sourceCode`'s `rgba(233,236,239,.65)`, so two semi-transparent layers composite to a darker grey.

Measured with computed styles and proper alpha compositing over white — same code block, twice:

| placement | `code` element bg | composited bg | `.at` (`#657422`) | AA |
|---|---|---|---|---|
| top level | transparent | `rgb(240.7, 242.7, 244.6)` | **4.62:1** | pass |
| inside a list item | `rgba(233,236,239,.65)` | `rgb(235.7, 238.3, 241.0)` | **4.44:1** | **fail** |

Stock 1.10.18, no `_brand.yml`, no custom theme. This is also why the RaukR labs measure 4.44 — their
code blocks sit inside the Tasks-callout lists — so it wants a local `theme-html.scss` fix as well.

### C — axe colour-contrast false positives on callouts: **DOES NOT REPRODUCE, do not file**

On 1.10.18 a doc with two collapsible callouts produces **no** `color-contrast` violation at all.
The drafted claim is dead.

**But the same run surfaced a real one**: `aria-allowed-attr`, impact
**critical**, one node per collapsible callout. Quarto emits the toggle as a generic `<div>` carrying
`aria-expanded` with no `role` (and no `tabindex`):

```html
<div class="callout-header d-flex align-content-center collapsed" data-bs-toggle="collapse"
     data-bs-target=".callout-1-contents" aria-controls="callout-1" aria-expanded="false"
     aria-label="Toggle callout">
```

`aria-expanded` is not permitted on a role-less `div`. Likely fix: `role="button"` + `tabindex="0"`,
or a real `<button>`. Not filed upstream (#14373 is an a11y umbrella with no rule ids; #14668 is a
different defect).

*(Repro note: `axe: {output: json}` writes to the browser console, not a file, and the axe module is
CORS-blocked over `file://` — serve the page over HTTP and capture the console.)*

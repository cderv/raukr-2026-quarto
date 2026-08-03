---
paths:
  - _brand.yml
  - "**/_brand.yml"
  - theme-html.scss
  - theme.scss
---

# Rule — `_brand.yml` (and brand-driven theme) gotchas

Non-obvious traps that silently break a render when editing a brand file. The house look and the
"don't vendor the host school's SCSS — rebuild it here" framing live in `project-context.md` /
`multi-day-workshop-scaffold.md § 5`; this is the short list of **technical** gotchas. When you
**edit** `_brand.yml`, apply these; when you **review**, check them. Gotcha § 4 also covers a
brand-triggered highlight bug whose *fix* lives in `theme-html.scss` (hence this rule surfaces there
too).

## 1. ASCII-only — or R-side branding silently breaks under a C locale

The R side reads this file with `brand.yml::read_brand_yml()` (here: `labs/quarto/sample-typst.qmd`,
via `pal()` / `brand_color_pluck()` / `theme_brand_gt()`). Under a **`C`/POSIX locale** — minimal
containers, CI, and this repo's non-interactive tool/agent shells — `read_brand_yml()` **fails to
parse any non-ASCII byte** and returns an **empty palette**, so every `pal("…")` passes the raw name
through and `gt`/`ggplot` reject it (`invalid color name "teal_lighter"`). A single `·` / `—` / `§`
in `meta.name` or a comment is enough; interactive UTF-8 machines hide it.

- **Keep the whole file ASCII** — `--`/`-` for dashes, "section" for `§`, etc.
- **Verify:** `LC_ALL=C Rscript -e 'print(brand.yml::read_brand_yml("_brand.yml")$color$palette)'`
  must print the palette, not `NULL`.
- Hit twice — the tuto (`tuto-quarto-typst-rr-2026`, French content → *had* to document a locale
  requirement) and RaukR (English → fixed at the source). Full story: `sandbox-setup.md` + scaffold § 5.

## 2. Hyphen in the YAML key, underscore in the R lookup

A palette key written with a hyphen (`teal-lighter:`) is resolved **from R with an underscore**:
`brand_color_pluck(brand, "teal_lighter")` returns the hex; `"teal-lighter"` returns the raw string
(unresolved). So `sample-typst.qmd` is *correct* using `pal("teal_lighter")` even though the YAML
says `teal-lighter`. **Don't "fix" the underscore to match the YAML** — that breaks it. (The
Quarto/CSS-native side uses the hyphen as written; only the R accessor renames `-` → `_`.)

## 3. `link` is not a color role — it lives under `typography.link.color`

The R `brand.yml` package **rejects** a `link:` entry under `color:` (the roles are
primary / secondary / foreground / background / …). Put the link color under `typography.link.color`
instead, keeping the palette entry (e.g. `link-teal`) for reference. Check the link color clears
**WCAG AA** — the RaukR `link-teal` is `#33666B` (see § 5 for why that exact value).

## 4. Using `brand` ships a dark highlight sheet that leaks into light mode — and code highlighting is NOT brand-themed

Two linked facts about `brand` + code syntax highlighting on **HTML** pages (revealjs is unaffected —
it ships a single light sheet):

- **Highlighting can't be branded.** `_brand.yml` reaches only `monospace-block.background-color`;
  the *token* colors come from KDE `.theme` files selected by `highlight-style`, never the palette.
  Don't try to recolor code by editing the palette — it won't move.
- **The leak.** Using `brand` makes Quarto emit a **dark "alternate" highlight sheet even on a
  light-only site** (quarto-cli **#13450**), and its unscoped rules **leak into light mode** for the
  token classes the light theme leaves colorless. Under the default `arrow` theme those are the shell
  command words `.ex` (external, e.g. `quarto`) and `.bu` (builtin, e.g. `cd`) — both `arrow-light`
  leaves uncolored while `arrow-dark` bolds them cyan (#00e0e0) (quarto-cli **#14299**). Symptom:
  `quarto` in a ```` ```sh ```` block renders **bold cyan on white**.

**Fix** (in `theme-html.scss`, until upstream lands): force the leaking classes back to body ink.
```scss
code span.ex, code span.bu { color: inherit; font-weight: inherit; }
```
Don't add `.wa` — `arrow-light` *does* color it (`#5E5E5E`), so overriding it would be wrong.
**Verify** with computed styles (Chromium): the command word must be body ink (`#003B4F`), not
`rgb(0,224,224)`. (Diagnosed 2026-07-21; reported upstream.)

## 5. The brand teals fail WCAG AA as text / light surfaces — override in `theme-html.scss`

The palette's teals are tuned as fills/accents, so several **auto-applied text roles** land below AA's
4.5:1 (fixed 2026-07-22, axe-driven). Don't re-tune the palette (it would ripple
everywhere) — override the specific roles in `theme-html.scss`:

- **`$secondary` (teal-light `#A6CBCF`) is used as muted-text** — Bootstrap paints figure/table
  captions, the whole `.column-margin` (incl. a kable dropped there), and `.blockquote` (the lab
  "Goal:" boxes) with it → **~1.74:1**. Override those selectors to a darker teal. Watch specificity:
  Bootstrap's `.blockquote` (class) beats a bare `blockquote`, and `.column-margin figcaption`
  (descendant) beats a bare `figcaption` — match them or the override loses.
- **`$primary` (teal `#4C979F`) as the navbar background** under near-white text → **3.33:1**. Darken
  *only the bar* (`.navbar { background-color: … }`), not the palette.
- One derived shade covers both: `$teal-dark: darken($primary, 15%)` = **`#33666B`** (~6.4:1 on white).
- **Links didn't get the brand link colour under Quarto 1.9.x — FIXED in 1.10.** `typography.link.color`
  now reaches Bootstrap's `$link-color` for both the palette-key and literal-hex forms (verified
  2026-08-03 on 1.10.18: compiled `--bs-link-color: #33666B`, computed `rgb(51,102,107)`; on 1.9.38 it
  stayed the Quarto default `#2a76dd`, 4.43:1, failing). Our explicit `$link-color` in `theme-html.scss`
  is now belt-and-braces rather than a workaround — keep it while the floor allows 1.9, and still pick
  the value against the **grey code background** (`#f1f3f5`/`#eceef1`),
  not just white — an inline-`code` link on that bg drops ~0.5:1, so `#3C7C83` (4.8 on white) fails on
  code (4.28) while **`#33666B`** clears it everywhere (~5.5:1). Keep the `_brand.yml` `link-teal`
  palette value in sync (also `#33666B`) so a future Quarto that *does* wire the brand link colour
  won't regress. (Recheck the whole gap on Quarto 1.10+.)
- **Verify with axe-core**, not by eye — and re-check the residuals rather than inheriting them. On
  1.9.38 the callout toggles and FontAwesome icons were dismissed as *false* colour-contrast positives
  (empty fg/bg, axe unable to resolve the header's semi-transparent background). **On 1.10.18 that is
  wrong twice over:** there is no `color-contrast` violation on callouts at all, and both elements
  instead raise *real* ARIA violations — `aria-allowed-attr` (critical) on the collapse toggle, a
  role-less `<div>` carrying `aria-expanded`, and `aria-prohibited-attr` (serious) on the `{{< fa >}}`
  icons, a role-less `<i>` carrying `aria-label`. Neither is CSS-fixable; both are tracked upstream.
  The `.at` token gap is now § 6 and is fixed.

## 6. Two AA gaps that come from Quarto's own defaults, fixed in `theme-html.scss`

Both found 2026-08-03 by running axe-core over the rendered site; both are shipped-default behaviour,
not ours, and both are reported upstream. Verified fix: `color-contrast` violations on the two lab
pages went **12 → 0** and **13 → 0**.

- **Block code inside a list item is double-shaded.** Quarto's *inline*-code rule
  `p code.sourceCode, li code.sourceCode, td code.sourceCode { background-color: rgba(233,236,239,.65) }`
  also matches the **block** `<code>` when the block sits in a list item. It then stacks on
  `div.sourceCode`'s identical layer, and the darker composite drops the default `arrow` attribute
  token `.at` (`#657422`) from **4.62:1 to 4.44:1**. Our labs put every code block inside the
  Tasks-callout lists, so this hit 25 nodes. Fix: reset `li/p/td pre > code.sourceCode` to
  `background-color: transparent`.
  *Note when reporting it:* axe says **4.43** with `bgColor: #eceef1`, and `#eceef1` **is** that
  double-composited background rounded to 8-bit — so don't frame the report as "it's 4.44, not 4.43";
  the number was always right, only the mechanism was misdiagnosed.
- **`<details><summary>` is sub-AA** at `#7b838a` on white = **3.84:1** (the labs' Session block).
  Upstream `quarto-dev/quarto-cli#14383`. Fix: `details > summary { color: $teal-dark; }`.

Measuring contrast correctly: **composite the whole ancestor background stack over white before
computing the ratio.** Quarto's code background is semi-transparent (`rgba(…,.65)`), so reading the
raw `background-color` gives a wrong (too harsh) number — that mistake produced a false "fails AA" on
stock defaults during this pass before it was caught.

## 7. A named bootswatch `theme:` outranks the brand palette — put `brand` last

`theme: cosmo` (or any named bootswatch) **silently defeats `_brand.yml`'s colors**. Quarto expands a
bare `theme:` to `[brand, cosmo]`, and *later layers win*, so cosmo's `$primary` lands and the brand
teal survives only as an unconsumed `--brand-teal` custom property.

The trap is that **typography still comes through** (`--bs-body-font-family: Albert Sans`), so the
page visibly changes and everyone concludes the brand worked. Measured on 1.10.18:

| `theme:` | `--bs-primary` | navbar |
|---|---|---|
| `cosmo` | `#2780e3` (cosmo blue) | `#f8f9fa` |
| `[brand, cosmo]` | `#2780e3` | `#f8f9fa` |
| **`[cosmo, brand]`** | **`#4C979F`** | **`#4c979f`** |
| *(no `theme:`)* | `#4C979F` | `#4c979f` |

So: **`brand` goes last**, or omit `theme:` entirely. `theme: [cosmo, brand]` renders fine even when
no `_brand.yml` exists yet, so it is safe to write before the brand file is added — which is what
makes a before/after brand demo work at all. (This repo's own `theme: [default, theme-html.scss]` is
unaffected: only a *named bootswatch* triggers the override.)

Found 2026-08-03: the Day-2 lab told participants to write `theme: cosmo` in step 1 and then promised
teal in step 3, and the shipped reference solution reproduced the same bug — four reading reviewers
missed it, an agent that actually rendered caught it immediately.

**Related wording trap:** `primary` does **not** color headings. `--bs-heading-color` stays `inherit`
in every configuration above. What turns brand-colored is the **navbar and links**. Don't write "the
headings turn teal" as a checkpoint — participants will read it as a failure when they got it right.

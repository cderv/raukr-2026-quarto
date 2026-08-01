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
**WCAG AA** — the RaukR `link-teal` is `#33666B` (see § 5 for why that exact value, and why the
`typography.link.color` alone isn't enough under Quarto 1.9.x).

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
- **Links don't get the brand link colour under Quarto 1.9.x.** `_brand.yml`'s `typography.link.color`
  does **not** reach Bootstrap's `$link-color` — the compiled `--bs-link-color` stays the Quarto
  default `#2a76dd` (**4.43:1**, fails). Set `$link-color` explicitly in a `theme-html.scss`
  `scss:defaults` block. And pick the value against the **grey code background** (`#f1f3f5`/`#eceef1`),
  not just white — an inline-`code` link on that bg drops ~0.5:1, so `#3C7C83` (4.8 on white) fails on
  code (4.28) while **`#33666B`** clears it everywhere (~5.5:1). Keep the `_brand.yml` `link-teal`
  palette value in sync (also `#33666B`) so a future Quarto that *does* wire the brand link colour
  won't regress. (Recheck the whole gap on Quarto 1.10+.)
- **Verify with axe-core**, not by eye. Known residual axe *false* positives to ignore: callout
  collapse toggles + FontAwesome callout icons (reported with **empty fg/bg** — axe can't resolve the
  callout header's semi-transparent bg; the icons are actually body-ink on a light tint). Also
  sub-AA-but-hard: the `arrow` highlight `.at` token on the grey code bg (4.43) — a shipped-theme gap,
  see § 4 ("highlighting isn't brand-themed").

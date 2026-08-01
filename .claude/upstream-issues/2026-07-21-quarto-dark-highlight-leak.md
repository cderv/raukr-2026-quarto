# Dark "alternate" syntax-highlighting colors leak into light mode for colorless token classes (with `brand`)

> Draft bug report for `quarto-dev/quarto-cli`. Reduced from a real workshop website that uses
> `_brand.yml`. **Not yet filed** — see "Related issues" below; this may be best filed as a
> concrete reproduction on #13450 rather than a new issue.

## Bug description

On an HTML page that uses `brand` (a `_brand.yml`) but has **no dark theme configured**, Quarto
still emits a dark "alternate" syntax-highlighting stylesheet, and its token colors **leak into
light mode** for any token class the *light* theme leaves colorless. Visibly, a shell command word
renders **bold cyan on white**.

## Steps to reproduce

Two files, no `_quarto.yml` needed. A `brand` is required to trigger the dark sheet — a plain
`format: html` page with no brand emits only one highlight sheet and does *not* leak.

`leak.qmd`:

````markdown
---
title: "Dark highlight leak MRE"
format: html
brand: _brand.yml
---

```sh
quarto check
```
````

`_brand.yml`:

```yaml
color:
  primary: "#1a808c"
```

Render:

```sh
quarto render leak.qmd
```

Open `leak.html` in a browser and inspect the word `quarto` in the code block.

## Expected behavior

In light mode, the command word `quarto` (tokenized `<span class="ex">`) should render with the
**light** theme's styling for that class — i.e. uncolored/default text, since the default light
theme (`arrow-light`) leaves `.ex` colorless. The dark theme's rules should not apply while the
page is in light mode.

## Actual behavior

`quarto` renders **bold cyan** — `color: rgb(0, 224, 224)` (`#00e0e0`), `font-weight: 700` — which
is the **dark** theme's `.ex` rule, on a white background. The builtin `cd` (`<span class="bu">`)
likewise leaks the dark green `#abe338`.

## CSS / computed-style evidence

The `<head>` loads three highlight stylesheets, in this order:

```html
<link href="…/quarto-syntax-highlighting-<hash>.css"      rel="stylesheet" class="quarto-color-scheme"                        id="quarto-text-highlighting-styles">
<link href="…/quarto-syntax-highlighting-dark-<hash>.css" rel="stylesheet" class="quarto-color-scheme quarto-color-alternate" id="quarto-text-highlighting-styles">
<link href="…/quarto-syntax-highlighting-<hash>.css"      rel="stylesheet" class="quarto-color-scheme-extra"                  id="quarto-text-highlighting-styles">
```

Sheet 1 and sheet 3 are the **same** (light) file; sheet 2 is the dark file. The `.ex` rules:

```css
/* sheet 1 & 3 — light (quarto-color-scheme / -extra) */
code span.ex { font-style: inherit; }        /* no color, no font-weight */

/* sheet 2 — dark (quarto-color-alternate) */
code span.ex { font-weight: bold; color: #00e0e0; }
```

All three selectors have equal specificity, so the cascade resolves by document order:

- `color`: set only by sheet 2 (dark) → **`#00e0e0` wins**
- `font-weight`: set only by sheet 2 (dark) → **`bold` wins**
- `font-style`: set by sheet 3 (light) → `inherit` (correct)

Computed style on `<span class="ex">quarto</span>` in light mode: `color: rgb(0, 224, 224)`,
`font-weight: 700`.

Token classes that the light theme *does* color (`.fu`, `.st`, `.kw`, …) are re-asserted by sheet 3
and render correctly. Only classes the light theme leaves colorless leak. Under the default `arrow`
theme those are exactly **`.ex`** (external command) and **`.bu`** (builtin) — both `inherit` in
light. (`.wa` does *not* leak here: the light theme gives it `#5E5E5E`, which sheet 3 re-asserts.)

## Root cause hypothesis

With `brand`, Quarto emits both a light and a dark syntax-highlighting sheet even when no dark mode
is configured (this is the `resolveSassBundles` / brand dark-variant behavior; the extra-sheet
emission is tracked in #13450). The dark sheet carries `class="quarto-color-alternate"`, which is
meant to keep the dark rules from applying in light mode — but the class is only on the `<link>`
element and the rules inside are plain `code span.ex { … }` selectors with no scoping. So the dark
rules participate in the normal cascade.

The light "extra" sheet (sheet 3) re-asserts the light theme's declarations *only for the properties
the light theme actually sets*. For a class the light theme leaves colorless (`.ex`, `.bu`), sheet 3
sets no `color`/`font-weight`, so nothing overrides the dark sheet's `color`/`font-weight`, and the
dark values win in light mode. The leak is therefore limited to token classes that are colorless in
the light theme.

Two independent fixes would each close this: (a) not emitting the dark sheet at all when no dark
mode is configured (#13450), or (b) scoping the `quarto-color-alternate` rules so they cannot apply
in light mode (e.g. under a selector gated by the active color scheme), or (c) having sheet 3
explicitly reset `color`/`font-weight` for every token class rather than only those the light theme
colors.

## Related issues

- **#13450** — "any use of brand causes three stylesheets to be present in output" (open, v1.10).
  Same three-sheet emission; root-caused by the maintainer to brand providing dark variants even
  when dark mode is not enabled. This report is the **user-visible color consequence** of that; it
  may be best filed as a reproduction comment there.
- **#14299** — "Quarto default style (arrow-light) for code does not highlight dsBuiltIn and
  dsExtension, where arrow-dark does" (open, PR #14370). Same `.ex`/`.bu` classes, opposite
  framing: with no dark sheet present those classes show as plain text; fix proposed is to give the
  light theme colors. That fix would also mask this leak (sheet 3 would then re-assert a color).
- **#14099** — "Dark syntax highlighting themes don't override light theme's base `.sourceCode`
  text color" (open). Related cascade issue in the opposite direction (light base color surviving
  into dark mode).

## Environment

```
quarto --version : 1.9.38
pandoc (bundled) : 3.8.3
OS               : Ubuntu 24.04.4 LTS (Linux x86_64)
```

---

## Prior-art check (2026-08-01) — NOT filed; file as a repro on #13450

Searched `quarto-dev/quarto-cli`. No issue covers this leak. Nearest open ones:

- **#13450** "any use of brand causes three stylesheets to be present in output" (gordonwoodhull,
  2025-09-26, open) — the emission cause. Still the best home for this, as this draft already says.
- **#14099** "Dark syntax highlighting themes don't override light theme's base `.sourceCode` text
  color" (jdonaldson, open) — same family, different symptom.
- **#14090** / **#14135** (mcanouil, open) — adaptive-theme and inline-code background colour.
- **#14299** + PR **#14370** (open, unmerged as of 2026-08-01) — arrow-light *missing* dsBuiltIn /
  dsExtension. Checked the thread: it does **not** discuss dark tokens leaking into light mode, so it
  is the opposite direction and does not subsume this.

**Action:** still worth reporting. Post as a concrete reproduction on #13450 rather than a new issue.

---

## Verified against Quarto 1.10.18 (2026-08-01) — STILL REPRODUCES → strand the tracker

Rendered the MRE above on 1.10.18. All three highlight stylesheets are still emitted, the dark one
(`class="quarto-color-alternate"`) still loads after the light one, and the rules are unchanged:

| sheet | `code span.ex` |
|---|---|
| light | `font-style: inherit;` (no colour) |
| dark  | `font-weight: bold; color: #00e0e0;` |

Chromium computed style on the word `quarto`, page in **light** mode:
`color: rgb(0, 224, 224)`, `font-weight: 700`. Confirmed exactly as drafted.

**Action:** post as a concrete reproduction on **#13450** (open). Tracked as **the tracker**.

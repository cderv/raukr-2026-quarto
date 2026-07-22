# Diagrams via `typst-render` (fletcher) — recipe & gotchas

How we render on-brand vector diagrams in the decks: a `{typst}` code block compiled to **SVG** by
Quarto's bundled Typst via **[`mcanouil/quarto-typst-render`](https://github.com/mcanouil/quarto-typst-render)**
(docs: <https://m.canouil.dev/quarto-typst-render/>). Chosen over Mermaid/Graphviz because it needs
**no Chrome** (Mermaid→PDF does), gives controllable size + crisp vector, and eats our own dog food
(the workshop's whole thesis is "Typst, no LaTeX"). First used for the Day-1 **"How it all works"**
engine diagram (`slides/quarto/index.qmd`). Prior art: **`tuto-quarto-typst-rr-2026`** uses fletcher
for the `_brand.yml` star (`1-quarto-typst.qmd`) and a typst pipeline (`2-projets.qmd`).

## The pieces that must ALL be present

1. **Extension** — `quarto add mcanouil/quarto-typst-render` → `_extensions/mcanouil/typst-render/`
   (committed). **Sandbox can't `quarto add`**: the agent proxy blocks non-session GitHub repos
   ("not enabled for this session"). Options: add it from a real machine and push, or `add_repo` +
   clone + copy the files in. `@preview` package *downloads* during render, however, DO work through
   the proxy.
2. **Filter** — `filters: [typst-render]` in the deck front matter (or `_quarto.yml`).
3. **knitr passthrough (R engine only)** — `{typst}` collides with knitr's chunk engine
   (`Unknown language engine 'typst'`) and the source leaks out as prose. Fix = source the shipped
   resource in a setup chunk:
   ```r
   source(file.path(Sys.getenv("QUARTO_PROJECT_DIR"),
                    "_extensions/mcanouil/typst-render/_resources/typst_define.R"))
   ```
   It registers a passthrough knitr engine so `{typst}` reaches the filter. Not needed for the
   jupyter/markdown engines.
4. **Options syntax — the sharp edge.** Under knitr, `#|` cell options are consumed by knitr and
   hoisted onto the parent `.cell` div; they **do not reach the filter** (so `alt` silently falls
   back to the raw Typst *source*). Put filter options as **`//|` comments INSIDE the code block**:
   `//| alt:`, `//| align:`, `//| width:`. Keep `#| echo: false` (that one is for knitr — suppresses
   the source echo).
5. **Package version pin.** fletcher **0.5.8** (→ cetz 0.3.4) works with Quarto 1.9.38's bundled
   **Typst 0.14.2**. fletcher **0.5.2 fails** (`Failed to resolve coordinate (0,0)`). Re-check the
   pin whenever Quarto bumps its Typst (`quarto typst --version`).
6. **`output-directory` — or images 404 on deploy.** By default SVGs land in the gitignored
   `.quarto/` cache; deployed, they break (learned in `tuto-quarto-typst-rr-2026`). Set:
   ```yaml
   typst-render:
     output-directory: typst-figures     # a PUBLISHED folder, next to the doc
   ```
   and gitignore `**/typst-figures/` — they regenerate on every render and publish from `_site/`.
7. **Offline / reproducible builds (recommended).** Vendor the Typst packages and point at them:
   ```yaml
   typst-render:
     package-path: /_typst-packages      # leading / = project root
     output-directory: typst-figures
   ```
   Commit `_typst-packages/preview/{fletcher,cetz,oxifmt}/…` (≈688K; copy the exact pinned tree from
   `tuto-quarto-typst-rr-2026`). Without it, every render — including the deploy render — downloads
   `@preview` packages (fine in the sandbox, not truly offline/reproducible).

## Fonts

Typst uses **system fonts, not Google web fonts** — `Albert Sans` isn't found at compile time
(harmless `unknown font family` warning) and falls back. Always give a fallback list:
`#set text(font: ("Albert Sans", "DejaVu Sans"), …)`. To actually render in the brand font, install
it and pass `font-path`.

## Brand colours

Hardcode from the `_brand.yml` palette, or use `background: auto` / `foreground: auto` (the filter
pulls them from `_brand.yml`). The engine diagram uses teal `#4C979F`, fill `#D1E5E6`, ink `#1c2833`.

## Freeze caveat (non-deterministic churn)

The knitr passthrough emits via `knitr::asis_output`, which wraps output in **random 4-char markers**
(e.g. `tiyq`→`pdmj`). So `_freeze/**/html.json` shows a diff on **every** render even when nothing
changed — but the `hash` field (MD5 of the source) stays stable, so the freeze is still valid.
`git checkout` that churn unless the source hash actually changed.

## Minimal working block (knitr deck)

````markdown
```{typst}
#| echo: false
//| align: center
//| alt: "…screen-reader description…"
#import "@preview/fletcher:0.5.8" as fletcher: diagram, node, edge
#set text(font: ("Albert Sans", "DejaVu Sans"), size: 16pt, fill: rgb("#1c2833"))
#diagram( /* nodes + edges */ )
```
````

## Next-tutorial scaffold checklist

- [ ] `_extensions/mcanouil/typst-render/` committed
- [ ] `filters: [typst-render]` + `typst-render: {output-directory: typst-figures, package-path: /_typst-packages}`
- [ ] `_typst-packages/` vendored (fletcher 0.5.8 / cetz 0.3.4 / oxifmt) and version-checked against the current Quarto Typst
- [ ] `**/typst-figures/` gitignored
- [ ] setup chunk sources `typst_define.R` (knitr decks)
- [ ] filter options via `//|`, not `#|`; `fig-alt`/`alt` on every diagram

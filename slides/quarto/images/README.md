# `slides/quarto/images/` — deck image assets

Screenshots and static figures referenced by the Day-1 deck (`../index.qmd`) with **relative** paths,
so the deck stays portable if folded into the NBIS site.

## Expected assets

| File | Used by | Status |
|------|---------|--------|
| `positron-quarto-preview.png` | "Quarto in Positron" slide (`#positron`) | ✅ **in use** — placeholder from the [Quarto docs](https://quarto.org/docs/tools/positron/) (`positron-render.png`); source + preview + Source/Visual toggle. Python example — swap for a local R/penguins capture when available (strand `the tracker`) |
| `positron-quarto-r-panes.png` | optional 2nd Positron frame | ⏳ optional |

**Capture spec / shot list:** `.claude/plans/2026-07-08-positron-demo.md`. Positron is a desktop
Electron app that can't run in the web sandbox, so an R/penguins capture is a **local** task. Until
then the slide rides on the Quarto-docs screenshot above (credited on-slide via `::: aside`). Swap-in
is: overwrite `positron-quarto-preview.png` here → `quarto render slides/quarto/index.qmd` → stage
`_freeze/`. The slide markdown and `fig-alt` already point at this path.

> **Provenance / licensing:** `positron-quarto-preview.png` is Posit's `positron-render.png` from
> `quarto-dev/quarto-web` (quarto.org docs), credited on-slide. Confirm the quarto-web license permits
> redistribution in this public repo, or replace with a local capture.

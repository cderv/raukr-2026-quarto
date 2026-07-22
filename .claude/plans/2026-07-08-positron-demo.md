# Plan — Positron × Quarto minimal demo (capture spec) · the tracker

**Status:** authoring done in-session (slide slot + asset contract wired); **capture is a LOCAL task**
(Positron is a headless-incompatible desktop Electron app, and its installer ships from GitHub, which
is proxy-scoped in the web sandbox — same wall as the Quarto `.deb`). This doc is the storyboard the
local capture follows so wiring is a one-step swap-in.

## Scope (locked by the strand, P3 — keep minimal)
Show **only the Quarto integration inside Positron**, not a Positron tour — participants meet the IDE
in an adjacent slot. Correctness guardrail (already in the deck, keep it): Positron has **no**
RStudio-style visual editor; visual-editor talk stays scoped to RStudio
(`slides/quarto/index.qmd:267-269`).

**Default build (this session):** one static screenshot ("money shot"), on the Day-1 "Running &
editing" beat, as a dedicated cut-able slide. Frame 2 is optional (see below); recording was
considered and rejected (autoplay/size/Wi-Fi risk; the workshop is static/room-safe throughout).

## Asset-path contract (fixed — capture just drops files here)
- **Shot 1 (required):** `slides/quarto/images/positron-quarto-preview.png`
- **Shot 2 (optional):** `slides/quarto/images/positron-quarto-r-panes.png`

Relative path under the deck folder → NBIS-portable. The slide already contains the exact
`![](…){fig-alt=…}` markdown, commented out behind a `TODO(positron)` marker; swap-in = drop the PNG +
uncomment + re-render the Day-1 deck (executable → stage `_freeze/`).

## Shot list / storyboard

**Global capture settings (both frames):**
- Positron **light theme** (the slides are light + teal brand; a dark IDE shot clashes).
- Window ~**1280×800**, app cropped to its own chrome (no desktop/menu-bar bleed).
- **Zoom up** so code + UI labels are legible on a projector (Cmd/Ctrl-+ a few times).
- Open a **real repo `.qmd`** so the content matches the workshop — use
  `labs/quarto/starter.qmd` or `labs/quarto/penguins-report.qmd` (recognizable penguins figure).
- Hide clutter: close the minimap, extra sidebars, notifications; **no personal info** in the title
  bar / file paths / git branch (scrub or use a clean clone path — this is a public repo).

**Shot 1 — "Quarto lives in your editor" (the money shot):**
- **Left:** source editor with the `.qmd` open — YAML header + one `#|`-annotated R cell + some
  markdown visible (ties back to the `.qmd`-anatomy slide).
- **Right:** the live **Preview** pane showing the rendered HTML (penguins figure visible).
- The Quarto **Preview/Render** control visible in the editor toolbar.
- One frame that says: edit on the left, rendered doc on the right, driven by Preview.

**Shot 2 — R-side integration (optional, only if we go to 2 frames):**
- Same window, after running an R cell: the **Plots** pane shows the figure and the **Variables**
  pane shows the `penguins` data frame — Positron's R panes lighting up from a Quarto cell.

## Local capture — two ways
1. **By hand:** launch Positron → open the `.qmd` → Preview → arrange panes per Shot 1 → OS screenshot
   → save to the path above → re-render deck → commit.
2. **Automated (electron skill / agents-browser):** drive the Positron Electron app, set theme+zoom,
   open the file, trigger Preview, screenshot the window to the fixed path. The naming contract above
   is stable so the automation target doesn't move.

## After capture (either machine)
- Drop the PNG(s), uncomment the `![…]` in `slides/quarto/index.qmd`, `quarto render` the Day-1 deck,
  stage `_freeze/`, verify the slide on screen, commit, close **the tracker**.

## Out of scope
A Positron feature tour; the visual editor (doesn't exist in Positron); dark-theme shots; video.

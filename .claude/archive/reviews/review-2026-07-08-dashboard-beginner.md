# Review — Dashboards DEMO page (beginner) — 2026-07-08

**Scope:** `labs/quarto-projects/dashboard.qmd` (static `format: dashboard` penguins page) and the
"Demos — if time" Dashboards bullet + `[See one]` link in `slides/quarto-projects/index.qmd`.
Reference commit `9abf90f`. Judged as a *demo the presenter shows* — not a hands-on exercise —
plus "would the source read well as a starting point when I click through at home?"

## Overall verdict

This lands well. When the presenter opens the page and talks over it, I see exactly the four things
the slide bullet promises — two valueboxes across the top, a boxplot, and a two-tab panel — and the
rendered page confirms it (Species = 3, Penguins measured = 342, tabs "Bill scatter" / "Mean
measurements", teal `bg-primary` valuebox). The source is short, clean, and copyable as a skeleton
for my own dashboard, and both plots carry a `fig-alt`. Nothing blocks the demo. My only friction is
that two of the concepts the demo is *meant* to teach me — what a **card** is, and why the headings
are literally named "Row"/"Column" — are invisible or unexplained in the source, so if I read it cold
at home without the presenter's narration I'd half-learn them. All P2, all "would make the page
self-teaching," none required for the day.

## 🔴 P0 — blocking for the event

None. The page renders, the link resolves, and there is no task for me to get stuck on.

## 🟠 P1 — fix before the event

None.

## 🟡 P2 — nice-to-have (make the source self-teaching for the at-home read)

- **The "card" concept is invisible in the source.** `dashboard.qmd:8-13` (comment) and the slide
  (`slides/quarto-projects/index.qmd:324`, *"rows, columns, cards"*) both promise **cards**, but the
  `.qmd` never contains the word `card` or a `.card` class — each code cell silently *becomes* a card.
  So the one concept the deck names, I cannot find when I read the file. Reading the source alone I'd
  conclude "there's no card here." A one-line comment near the boxplot cell — e.g. *"each cell becomes
  a card; `#| title:` sets its header"* — would close the promise-vs-delivery gap. (The presenter can
  say this live; it only bites the at-home reader.)

- **"Row"/"Column" heading text looks load-bearing but isn't.** `dashboard.qmd:25,47,49,59`:
  `## Row {height="20%"}`, `### Column`, `### Column {.tabset}`. As an experienced-R-but-new-to-Quarto
  reader I can't tell whether Quarto keys off the *word* "Row"/"Column" or the *heading level*. (It's
  the level — `##` = row, `###` = column — and the text is a free label.) If I copy this as a starter
  I'll likely think I must type "Row" verbatim. A short comment — *"`##` makes a row, `###` a column;
  the heading text is just a label"* — would save the guesswork.

- **`#| content: valuebox` returns a bare `list(color=, icon=, value=)` with no orientation to
  what's what.** `dashboard.qmd:27-35`. The `icon = "tags"` / `"clipboard-data"` are Bootstrap-icon
  names with no hint of where they come from, and `color = "primary"/"secondary"` are brand slots.
  This is the least obvious cell to reuse. A trailing comment like `# icon: any bootstrap-icons name`
  on line 32 would make it copy-and-adapt-able. Minor.

## ✅ What reassures me (beginner's-eye clarity)

- **The top comment (`dashboard.qmd:7-14`) is genuinely useful.** It tells me up front this is
  *static, no Shiny/OJS*, that the teaching point is the **layout model** not plot color, and *why*
  the plots keep default fills (monochrome teal can't separate three species) — which pre-empts the
  exact "why isn't this teal?" question I'd have asked.
- **The rendered result matches the promise.** Valueboxes show real computed numbers (3, 342),
  the tabset works, and the `bg-primary` teal chrome demonstrates the "brand carries through" claim
  live — I can see `_brand.yml` doing something without being told to trust it.
- **`format: dashboard` and `{.tabset}` are legible from the source.** The YAML keyword and the
  `### Column {.tabset}` marker are the two concepts I *would* pick up unaided.
- **Both plots have a `fig-alt`** (`dashboard.qmd:53,63`) and they're accurate to the figures.
- **The slide link is correct.** `slides/quarto-projects/index.qmd:325`
  `[See one](../../labs/quarto-projects/dashboard.html)` resolves to the rendered page from the slide
  directory, and the `*(static — no server)*` tag sets my expectation honestly before I click.
- **Good "starter" ergonomics.** The file is ~80 lines, one setup chunk, no hidden dependencies —
  exactly the kind of thing I'd copy and swap my own data into.

## 📝 Evolution since the previous review

First review of this page — `dashboard.qmd` and the Dashboards demo bullet are new at commit
`9abf90f`, no prior dashboard-scoped review to compare against. Compared with the surrounding Day-2
material I've seen reviewed, the strong habits already carry over: an explanatory top comment, honest
scope tags ("static — no server"), `fig-alt` on every plot, and a link that actually resolves. The
open items are purely about making the *source* narrate its own layout model for the at-home reader.

# Language review — WP2 Day-1 lab (`labs/quarto/index.qmd` + `starter.qmd`)

- **Date:** 2026-07-07
- **Reviewer:** language (English copy + plain language)
- **Reference commit:** bb42f07 (files just authored, uncommitted)
- **Scope:** ONLY the two lab files. Deck + WP0 assets out of scope.
- **Register target:** clear, direct lab instructions (imperative task steps expected).

## Verdict

**Clean.** Professionally written, crisp imperatives, concrete "You should see" blocks,
consistent US spelling (`colored`, no British drift in prose), one bill/culmen vocabulary
(always **bill**, never "culmen" — good). Product casing all correct (Quarto, Typst, HTML,
PDF, YAML, APA, LaTeX). No P0. A handful of small copy nits and one deliberate
terminology split worth documenting.

**Triage: 🔴 P0 = 0 · 🟠 P1 = 1 · 🟡 P2 = 4**

## Recurring patterns / cross-cutting notes

1. **`vs` / `vs.` / `versus` drift in figure captions** (P2). Rendered captions mix all
   three forms. Pick `versus` for prose captions (already the majority) and leave `vs` in
   code/variable references like ``bill_len vs bill_dep``.
2. **`separated` vs `separate` clusters** (P1). One "You should see" checkpoint says "three
   *separated* clusters"; every other mention (fig-alt, hint, starter) says "*separate*
   clusters". Align to `separate`.
3. **`cell` vs `chunk`** — this is a *deliberate, role-based split*, not drift: the code
   **block** is a "chunk" (R-user vocabulary), the `#|` options are "cell options" (Quarto
   vocabulary). It reads consistently by role; no change needed. Documented here so it isn't
   re-flagged.
4. **"Part 1/2" (starter) vs "Authoring/Citations Challenge" (lab)** — bridged correctly by
   the "Starting point" callout (`index.qmd:136` maps "known-good Part-1 report" → the
   Authoring Challenge). No action; noted for awareness.

## `labs/quarto/index.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 65 | "the bill scatter, three **separated** clusters" | "three **separate** clusters" | Match `separate` used everywhere else (lines 79, 103; starter 50); "separated" implies an action. |
| 76 | `fig-cap: "Target: bill length **vs.** depth by species."` | "Target: bill length **versus** depth by species." | Caption consistency — other captions (102, starter 47) spell out "versus". |
| 10 | "one penguins document with the authoring **value-adds**" | "…with the authoring **extras**" (or "…with the extra authoring features") | "value-adds" is corporate/jargon; "extras" is plainer for a lab intro. ⚠️ light meaning check only. |
| 51 | "Add a scatter plot of `bill_len` vs `bill_dep` **colored by** `species`." | fine as-is | US spelling correct; `vs` here refers to variables — leave (do not "versus" a code reference). |
| 32 / 87 / 172 / 206 | Callout titles: "Coming from R Markdown?", "Hint", "Troubleshooting", "You should see", "Starting point", "Scope" | fine | All read cleanly and scan well. |

Notes (no change):
- Challenge headings "**Authoring Challenge**" (43) and "**Citations Challenge**" (128) both
  read cleanly and parallel.
- Both "You should see" blocks (64–69, 165–169) state concrete, checkable outcomes
  (numbered Figure/Table/Equation, live cross-ref links, in-text "(Gorman et al., 2014)",
  "No `?@gorman2014` or `[?]` markers"). Strong — these are exactly checkable.
- `summarise()` / `labs()` British-looking spellings are R function names — correctly left.

## `labs/quarto/starter.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 43 | "so the species **cluster**." | "so the species **form clusters**." (optional) | Slightly terse verb-use of "cluster"; "form clusters" reads a hair smoother. ⚠️ style-only, meaning unchanged — leave if you prefer the terse punch. |
| — | Prose (27–65) | fine | Report body is clean, direct, US spelling; "bill" throughout. |

Notes (no change):
- Learner-facing subtitle "Part-2 starter — a finished Part-1 document, ready to cite" (3)
  is clear; the Part↔Challenge mapping is handled by `index.qmd:136`.
- HTML comments (8–13, 86–87) are authoring notes, not rendered prose — relaxed register
  fine, not copy-edited.
- `>=` in the code comment (22) vs `≥` in `index.qmd:12` prose — code comment, left as-is
  (not rendered prose).

## ✅ Language strengths

- **Consistent US spelling** in prose (`colored`, `colors`) — no British drift outside R
  function names.
- **One vocabulary for the bird anatomy**: always "bill", never "culmen".
- **Crisp imperative task steps** ("Create a new `.qmd`…", "Add a scatter plot…", "Render to
  HTML…") — unambiguous, numbered, one action each.
- **Concrete, checkable "You should see" blocks** — the strongest feature; they name exact
  rendered artifacts and failure markers.
- **Correct product/API casing** throughout: Quarto, Typst, HTML, PDF, YAML, APA, LaTeX,
  R Markdown, `_brand.yml`, `references.bib`, `apa.csl`.
- **Two-words "front matter"** (208) — correct and consistent.
- Callout titles are short, scannable, and consistently phrased.

## 📝 Evolution since previous review

First language pass on these two WP2 lab files (just authored, uncommitted). No prior
language review of `labs/quarto/` to diff against.

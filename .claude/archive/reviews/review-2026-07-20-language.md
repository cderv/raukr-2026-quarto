# Language & copy-edit review — 2026-07-20

**Reviewer:** workshop-reviewer-language · **Reference commit:** 6a910a5
**Scope:** all participant-facing prose across both days — root pages (`index.qmd`, `setup.qmd`),
both decks (`slides/quarto/`, `slides/quarto-projects/`), both labs (`labs/quarto/`,
`labs/quarto-projects/`), and the worked reference docs participants open (`penguins-report.qmd`,
`starter.qmd`, `sample-typst.qmd`, `dashboard.qmd`, `starter/`, `solution/`).
Presenter notes `::: {.notes}` were read for context but are **out of scope**.

## Summary

This material has clearly been through prior language passes and reads well: spoken-but-professional
register, consistent US spelling, direct address, topic-named slide titles, product casing all
correct. The fixes logged since 2026-07-17 (capstone → team project, genericized freeze motivation,
positive publishing callout) all landed cleanly — I found **no** stray "capstone" in learner-facing
prose, and the freeze-slide motivation on `slides/quarto-projects/index.qmd:269` is now generic
("Compute can be slow") with the domain example correctly parked in `::: notes`.

So this is a **short** report by design: 6 proposals, only 2 of them worth acting on before the
event. Thirty solid beats two hundred trivial — here there are genuinely only a couple.

### Triage

- 🔴 **P0** — none. No real language defect for a pro workshop.
- 🟠 **P1** (fix before the event) — 2:
  1. `slides/quarto/index.qmd:40` — a Learning Outcome labels the audience ("for a research
     audience") instead of addressing the learner. The one third-person-audience phrasing left in
     the decks.
  2. `slides/quarto-projects/index.qmd:417` — "share results with a **wet-lab collaborator**" locks
     a slide body to the life-science domain where a generic phrasing would keep the deck reusable
     (the domain flavor belongs in `::: notes`).
- 🟡 **P2** (nice-to-have) — 4: a spelling-consistency nit (`wifi` vs `Wi-Fi`), two mild
  undefined-jargon terms on slides/labs ("the runner", "hard-freeze"), and one jargon-y slide title
  ("think in deltas").

### Recurring patterns

- **Direct address is otherwise excellent** — every `##` slide title across both decks names the
  topic or speaks to the learner; the single lapse is the P1 outcome line below.
- **Reusability is otherwise well-handled** — the freeze motivation and the `::: notes` localization
  cue ("a sequence alignment, a long MCMC…") are exactly the generic-on-slide / domain-in-notes
  pattern. The lone slide-body domain lock is "wet-lab collaborator".
- **DevOps jargon** ("runner", "CI") sits slightly ahead of its glosses for a life-science cohort —
  CI is glossed in `::: notes` but "the runner" is not glossed on-slide. Minor.

---

## `slides/quarto/index.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 40 | "lay a document out **for a research audience** (page, margin, columns, panels);" | "lay a document out — page, margin, columns, panels;" | Speak to the learner / name the topic; don't label who's in the room. The matching slide title (`:306`) is already the direct form ("Layouts: body, margin, and beyond"), so this outcome is the last third-person-audience phrasing left. |
| 168 | "## Markdown & content — **think in deltas**" | "## Markdown & content — what Quarto adds" (or keep, but gloss "deltas" on the slide body) | 🟡 "deltas" (= differences) is undefined jargon on a title; the slide body never glosses it (only `::: notes` do). Probably fine for this tech audience — optional. |

## `slides/quarto-projects/index.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 417 | "arranges plots/tables/valueboxes into a static layout (rows, columns, cards) — **share results with a wet-lab collaborator**." | "…(rows, columns, cards) — **share results with a collaborator who won't open R**." (move "wet-lab" to `::: notes` as a localization cue) | 🟠 Domain-locked on a slide body; the generic form keeps the deck reusable beyond bioinformatics. Meaning preserved (both mean a non-coding reader). |
| 371 | "rendering from the committed `_freeze/` with **no R on the runner**." | "…with **no R needed in CI**." (or gloss "runner") | 🟡 "the runner" is CI/DevOps jargon; CI itself is only glossed in `::: notes`. Mild. |

## `labs/quarto-projects/index.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 170 | "is exactly what lets CI render the site with no R **on the runner**" | "…with no R **in CI**" | 🟡 Same "runner" jargon as the deck; align the two for one vocabulary. |
| 177 | "never re-execute on a project build (the **hard-freeze** CI mode)." | "…(the CI mode)." | 🟡 "hard-freeze" is a coined term, not a Quarto term; the preceding clause already defines the behavior, so the label adds jargon without adding meaning. Self-glossed, so low priority. |

## `setup.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 98 | "so you're not fetching them on conference **wifi**." | "…on conference **Wi-Fi**." | 🟡 Spelling consistency: the presenter note at `slides/quarto-projects/index.qmd:379` already uses "Wi-Fi"; hold one form in participant-facing prose. |

## `index.qmd`

Clean. The subtitle "Advanced R for Bioinformatics, Visby" (`:3`) is the school's actual name — a
proper noun, correctly left as-is (not a reusability lock).

## `labs/quarto/index.qmd`, `penguins-report.qmd`, `starter.qmd`, `sample-typst.qmd`, `dashboard.qmd`, `starter/`, `solution/`

Clean. No spelling, terminology, register, or direct-address issues found. Note the deliberate and
**correct** distinction in `labs/quarto/index.qmd:39` — "cell options move from the **chunk** header
to the `#|`" — where "chunk" names the R Markdown side and "cell" the Quarto side; not a
terminology-drift bug.

---

## ✅ Language strengths

- **Consistent US spelling** — `color`, `colored`, `grayscale`, `summarize`; no UK drift anywhere
  (`grep` for `colour|behaviour|organis|analyse|centre|licence|labelled|catalogue` → 0 hits in
  participant prose).
- **Product / API casing all correct** — Quarto, R Markdown, RStudio, Positron, VS Code, YAML,
  ggplot2, Typst, GitHub Pages, GitHub Actions, `_brand.yml`, `_quarto.yml`, `_metadata.yml`.
- **Terminology held steady across four files** — "code cell" / "cell" (not "chunk") for Quarto,
  "cross-reference", "render", "project", "freeze", "team project", "publication-ready article",
  "cite-able" (consistent hyphenation across all 5 uses).
- **Direct address / imperative throughout** — "Open your editor", "Head to the Lab", "You can
  now…"; slide titles name the topic or address the learner in every case but one.
- **No corporate/stiff tics** — `grep` for `in order to|utilize|leverage|it is important to
  note|in the event that|in terms of|with regard to|facilitate|allows you to|enables you to` → 0
  hits in participant prose. No doubled words, no `Fig 1`/`Tab 1` short forms in prose.

## 📝 Evolution since the previous review (2026-07-17)

- **"capstone" → "team project"** fully applied in learner-facing prose — verified 0 stray hits.
- **Freeze motivation genericized** — `slides/quarto-projects/index.qmd:269` now reads "Compute can
  be slow" with the domain example ("a sequence alignment, a long MCMC…") correctly in `::: notes`.
  This is the model the one remaining slide-body domain lock (`:417`, "wet-lab collaborator") should
  follow.
- **Publishing callout** (`:373`) now states the format positively ("Watch-me — not a live *Your
  turn*"); the "room-killer" logistics rationale is in `::: notes` (`:379`), out of scope and
  correctly placed.
- The new cache-vs-freeze bullets and the freeze split (`:263`–`:334`) read cleanly and consistently
  — no copy issues introduced.

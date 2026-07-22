# Language review — WP3 Day-2 deck (`slides/quarto-projects/index.qmd`)

- **Date:** 2026-07-08
- **Branch:** `claude/goal-command-wx5go6` (uncommitted working tree)
- **Reviewer role:** native-English copy-editor (spelling/typos/consistency + register)
- **Scope:** one file — `slides/quarto-projects/index.qmd`. Anchored against the shipped Day-1
  deck `slides/quarto/index.qmd` for US spelling, "cell" vs "chunk", caption style, callout
  titles. Presenter notes (`::: notes`) excluded from register per house rules.

---

## Verdict

**Clean deck, ships as-is after two small edits.** Mechanically spotless — no corporate tics,
no doubled words, no short "Fig/Tab" forms, US spelling consistent, product names correct
(Quarto, `_brand.yml`, `_quarto.yml`, `_metadata.yml`, GitHub Pages, Netlify, Typst, revealjs,
OJS, Shinylive). Callout titles, "Your turn — regroup in ~30 min" wording, caption style, and
the "After this session you will be able to:" / "What you can do now" bookends all match Day 1.

Two findings actually need a decision before the room sees them: the "one letter apart" gag
(line 213) doesn't describe `cache` vs `freeze` and will send readers hunting for a difference
that isn't there; and a couple of stage-direction phrases ("cut-able under time pressure",
"One slide's worth") leaked onto participant-facing slides. Everything else is polish.

- 🔴 **P0:** 0
- 🟠 **P1:** 3
- 🟡 **P2:** 6

---

## 🔴 P0 — real language problems

None.

---

## 🟠 P1 — fix before the event

| line | current | proposed | why (1 line) |
|---|---|---|---|
| 213 | "Two tools, one letter apart:" | ⚠️ "Two tools, easily confused:" (or "one word apart") | `cache` and `freeze` are **not** one letter apart — the line is literally false and a sharp reader will stall trying to reconcile it. Rewrite touches intent, so a human should confirm the wording. |
| 301 | "After the payoff, cut-able under time pressure:" | ⚠️ "Extra topics, if we have time:" | Reads as a stage direction addressed to the presenter, not the audience; also redundant with the slide title "Demos — if time", and "cut-able" is awkward (would be "cuttable"). |
| 217 | "a **chunk's** result is reused across that doc's re-renders." | "a **cell's** result …" | Day-1 anchor is "cell" for code cells; "chunk" is reserved there for the knitr/R-Markdown-lineage aside (Day-1 L87). This is a plain feature description, so "cell" keeps the deck consistent. ⚠️ Note: `cache` is a knitr chunk option, so if you deliberately want the knitr register here, leave it — but decide, don't drift. |

---

## 🟡 P2 — nice-to-have

| line | current | proposed | why (1 line) |
|---|---|---|---|
| 133 | "One slide's worth; link in the resources." | ⚠️ "More in the linked resources." | Telegraphic authoring-note tone in a participant-facing aside; "One slide's worth" is opaque on screen. |
| 258 | "The honest hands-on kernel is small:" | "The hands-on part is small:" | "honest … kernel" is writerly; plainer reads better aloud. Meaning unchanged. |
| 270 | "conference wifi" | "conference Wi-Fi" | US house style; the deck is otherwise carefully cased. |
| 92 | "Precedence is intuitive:" | "Precedence runs top-down:" (or cut "intuitive") | Telling learners it's intuitive can backfire if it isn't for them; the concrete chain that follows already carries the point. |
| 177 / 185 | "through the `brand.yml` package" / "`theme_brand_*()`" | keep as-is, but note Day-1 L406 bolds it: "the **brand.yml** package" | Minor styling drift (code font vs bold) for the same package name across decks; pick one. Code font is arguably more correct given `install.packages("brand.yml")`. |
| — | "site" (L45, L68, L249, L296…) vs "website" (L33, L95, L143…) used interchangeably | leave as-is | Named anchor checked: the alternation reads naturally as shorthand and is never ambiguous. Flagged only for awareness — no churn recommended. |

---

## ✅ Language strengths

- **Zero corporate bloat.** Grep for `in order to / utilize / leverage / facilitate / it is
  important to note …` returns nothing. Verbs are direct and active throughout ("build",
  "publish", "push", "pin", "point a host at").
- **Cross-deck consistency is strong.** Learning-Outcomes stem, "What you can do now" close,
  "Your turn — regroup in ~30 min" callout title, `_brand.yml` framing, sentence-case captions
  ending in a period, and the two-axes / capstone motif all match Day 1 cleanly.
- **US spelling holds** across the file; no UK drift.
- **Product/API casing is correct everywhere:** Quarto, `_quarto.yml`, `_metadata.yml`,
  `_brand.yml`, GitHub Pages, GitHub Actions, Netlify, Typst, revealjs, YAML, OJS (Observable
  JS), Shinylive, htmlwidget, ggplot2.
- **Spoken-but-professional register lands well:** "one build, one output folder",
  "render → edit prose → re-render → the code didn't run", "Reproducibility has two legs",
  "room-killer" — terse, concrete, reads cleanly off a slide.
- **Every figure carries `fig-alt`** (L120); caption/alt discipline matches Day 1.

---

## 📝 Evolution since the previous review

First language pass on this newly authored WP3 deck — no prior review of this file to diff
against. Benchmarked against the shipped Day-1 deck rather than a previous Day-2 snapshot.

---

### Greps run (evidence of mechanical cleanliness)

```
corporate/stiff (in order to|utilize|leverage|facilitate|it is important to note|…)  → 0 hits
doubled words  \b(\w+) \1\b                                                          → 0 hits
short Fig/Tab in prose  Fig ?[0-9] | Tab ?[0-9]                                       → 0 hits
chunk|cell                                                                           → 1 hit (L217, flagged)
```

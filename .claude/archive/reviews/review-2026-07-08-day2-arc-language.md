# Day-2 arc — language consistency review (`day2-arc`)

**Scope:** cross-file copy/register pass over the whole Day-2 arc — deck
(`slides/quarto-projects/index.qmd`), lab (`labs/quarto-projects/index.qmd`),
`starter/`, `solution/`, and the new `labs/quarto-projects/dashboard.qmd`.
**Reference commit:** `9abf90f` · **Date:** 2026-07-08 · **Convention:** US English.
**Lens:** term drift across artifacts (cell / versus / Challenge names / Wi-Fi /
"precedence runs top-down" / "Extra topics, if we have time") + does the new dashboard
page match Day-2 register and terminology.

## Verdict

**Strong pass.** The arc reads as one voice: the locked house terms hold across every
artifact and the new dashboard page slots in cleanly. One genuine spelling drift (a UK
spelling in the dashboard's alt text) is the only P1. Two P2 polish items. No P0.

Counts: **1 P1**, **2 P2**, plus 1 note.

---

## 🔴 P0 — none

Checked and clean across the arc:
- **cell (not chunk):** all prose uses "cell" — deck:230 "a **cell's** result", lab:141/152/177/192/194 "the R cell / cell label". No stray "chunk" anywhere in `.qmd` prose (the only "chunk" hits are auto-generated `dashboard.knit.md` figure filenames — out of scope).
- **Challenge names verbatim:** "Website Challenge" (deck:208, lab:43/45/129) and "Ship it Challenge" (deck:299, lab:122/125) — spelled and cased identically everywhere.
- **"Extra topics, if we have time"** — deck:318, exact.
- **"Wi-Fi"** — deck:286, exact.
- **"Precedence runs top-down"** — deck:96, exact.
- **"easily confused"** — deck:227, exact.

---

## 🟠 P1 — fix before the event

| file:line | current | proposed | why |
|---|---|---|---|
| `labs/quarto-projects/dashboard.qmd:63` | "bill length in **millimetres**" | "bill length in **millimeters**" | UK spelling in the one new file; the rest of the arc is US English ("colored" dashboard:63/66, "colors" lab:89, "grams"/"g" throughout). Only US/UK drift in the whole Day-2 material — and it's in the artifact you're reviewing for fit. |

---

## 🟡 P2 — nice-to-have

| file:line | current | proposed | why |
|---|---|---|---|
| `slides/quarto-projects/index.qmd:321` | "**Book vs website**" | "**Book versus website**" | House term is "versus"; the dashboard alt (dashboard.qmd:63) already says "versus". This is the only visible in-slide "vs" (the other two "vs" hits, deck:212 and deck:269, are in `::: notes` — out of scope, leave them). Nudging the bullet to "versus" makes the one comparison label the audience *sees* match the caption convention. Judgment call — "vs" is defensible in a terse label. |
| `labs/quarto-projects/index.qmd:22` | "each is its own ~30-minute part, with **the between-parts break in between**." | "each is its own ~30-minute part, with **the break in between**." | Redundant: "between-parts … in between" says it twice. "the break in between" reads clean and keeps the meaning. |

---

## Note (no change needed)

- **CI expansion:** the deck expands the acronym on first use — deck:232-233 "**CI** *(continuous integration — a build that runs on every push)*" — but the lab uses "CI" bare (lab:147/153/162/190). Fine for this audience (experienced bioinformaticians) and the deck precedes the lab, so no action. Flagged only so the asymmetry is a deliberate call, not an oversight.

---

## ✅ Language strengths

- **Terminology is genuinely locked across five files.** cell, freeze/cache, `output-dir`, `_quarto.yml` / `_metadata.yml` / `_brand.yml`, "branded website", "publishable folder", "watch-me demo" (deck:285/288, lab:23/125/180 — consistent hyphenation) — all uniform.
- **One voice, one register.** The "nobody is stranded / would strand a room of 40 / fell behind" safety motif (deck:213/286, lab:23/39/131) recurs deliberately across deck and lab without drifting in wording.
- **"versus" already used correctly in the dashboard alt** (dashboard.qmd:63) — the new file adopted the house caption term without prompting.
- **Product/API casing clean:** Quarto, GitHub Pages, GitHub Actions, Netlify, revealjs, Typst, knitr, ggplot2, renv, htmlwidget — all correct and consistent.
- **The dashboard page fits the arc.** Its participant-facing copy is deliberately terse (card titles + alt text, appropriate for `format: dashboard`); the register matches, one-word "valuebox(es)" agrees with the deck bullet (deck:323), and the "static — no server" framing echoes deck:325/328.
- **No corporate bloat** (no "in order to / utilize / leverage / facilitate"), **no doubled words**, **no short "Fig/Tab" forms** in prose — all greps came back empty.

---

## 📝 Evolution since the previous review

- The already-applied fixes hold: "easily confused" (deck:227), "Extra topics, if we have time" (deck:318), chunk→cell everywhere, standardized Challenge names, "Wi-Fi", "precedence runs top-down" — none regressed.
- The **new** `dashboard.qmd` arrives well-aligned to the arc; its only language snag is the single UK spelling (P1 above), not a register or terminology mismatch.

---

### Greps run

```
vs/versus, chunk, cell, corporate (in order to|utilize|leverage|…),
doubled words \b(\w+) \1\b, Wi-Fi, UK spellings (colour|…|millimetre|…),
Fig/Tab short forms
```
Over `slides/quarto-projects/index.qmd`, `labs/quarto-projects/{index,dashboard}.qmd`,
`labs/quarto-projects/{starter,solution}/*.qmd`. `_*.qmd`, `::: notes`, `.knit.md`
artifacts, code identifiers, and YAML keys excluded.

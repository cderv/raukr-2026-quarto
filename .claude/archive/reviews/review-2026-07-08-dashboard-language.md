# Language review — Dashboards DEMO (scope tag `dashboard`)

**Reviewer:** workshop-reviewer-language
**Reference commit:** `9abf90f` · **Date:** 2026-07-08
**Scope (this cycle only):** the newly-added Day-2 Dashboards DEMO page
`labs/quarto-projects/dashboard.qmd` (title/subtitle, valuebox titles, plot titles, HTML
comment, `fig-alt` wording) + the Dashboards bullet and `[See one]` link on the "Demos — if
time" slide in `slides/quarto-projects/index.qmd`.

---

## Verdict

**Ship after one fix.** The addition is well-written, spoken-professional, and terminologically
in step with the rest of Day 2. There is **one genuine copy-editing defect** — a UK spelling
in an otherwise US-spelled document — and nothing else worth blocking on. **1 proposal total
(0 P0, 1 P1, 0 P2).**

---

## 🔴 P0 — real language problems for a pro workshop

None.

---

## 🟠 P1 — fix before the event

### `labs/quarto-projects/dashboard.qmd`

| line | current | proposed | why |
|------|---------|----------|-----|
| 63 | `…bill length in millimetres, colored by species…` | `…bill length in millimeters, colored by species…` | UK spelling in a US-spelling project; also self-inconsistent — the same line already uses US `colored`, and the axis labels on lines 66 use `(mm)`. "millimeters" is the only spelled-out instance of the unit in the whole repo, so US form is the safe pick. |

---

## 🟡 P2 — nice-to-have

None. (Considered dropping the spelled-out unit for `(mm)` to match the axis labels, but a
screen-reader `fig-alt` reads better with the word spelled out — leave it, just US-spell it.)

---

## ✅ Language strengths

- **US spelling holds** everywhere else: `color`/`colored` (lines 10, 13, 63, 66),
  `artifact` (line 8, not "artefact"). Only `millimetres` breaks ranks.
- **House terminology is respected.** No "chunk" anywhere — the comment says "cell"-free
  layout language ("rows, valueboxes, a card, a tabset"). "versus" is spelled out in the
  `fig-alt` (line 63), matching the locked caption convention used across Day 1/Day 2
  (`labs/quarto/*`, `slides/quarto/*`) rather than "vs." / "vs".
- **Slide phrasing matches the deck.** The `[See one]` bullet (`slides/quarto-projects/index.qmd:323-325`)
  is a clean spoken fragment — "arranges plots/tables/valueboxes into a static layout (rows,
  columns, cards) — share results with a wet-lab collaborator" — parallel to the sibling
  bullets, no corporate bloat, and the `*(static — no server)*` gloss reads well. The HTML
  comment's back-reference "Demos — if time" correctly names the actual slide heading
  (`index.qmd:316`).
- **`fig-alt` quality is high.** Both alts are concrete and quantified ("Gentoo is clearly the
  heaviest, Adelie and Chinstrap overlap around 3,700 g", line 53) rather than generic.
- No typos, no doubled words, no broken sentences. Valuebox titles ("Species", "Penguins
  measured") and plot titles ("Body mass by species", "Bill scatter", "Mean measurements")
  are terse and correctly cased.

---

## 📝 Evolution since the previous review

New page — no prior language review of this artifact. It lands consistent with the
already-reviewed Day-2 register (spoken-professional bullets, mode-marker discipline elsewhere,
US spelling, spelled-out "versus" in figure text). The lone regression against that baseline is
the `millimetres` spelling flagged above.

### Greps run

- `millimet|colour|color|versus|\bvs\b|\bvs\.` (case-insensitive) across `*.qmd` — confirmed
  the repo standard is US `color`/`colored` and spelled-out "versus" in captions; `millimetres`
  at `dashboard.qmd:63` is the sole UK outlier.
- Doubled-word / typo scan of the in-scope prose — clean.

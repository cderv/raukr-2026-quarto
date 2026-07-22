# Language review — exercise-delivery migration (2026-07-22)

**Scope tag:** delivery · **Reference commit:** 1a8c757 · **Reviewer:** language/copy-edit
**Files:** `setup.qmd`, `labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd`,
`slides/quarto/index.qmd`, `slides/quarto-projects/index.qmd`

## Verdict

**Ship-ready prose; one consistency knot worth fixing before the event.** The migration reads
cleanly and in-voice — direct, spoken, no corporate bloat (greps for `in order to` / `utilize` /
`leverage` / `it is important to note` all came back empty). The exercises-repo slug
`cderv/raukr-quarto-exercises@raukr-2026`, the folder names `day1-intro/` / `day2-projects/`, the
9-package list, and `ggokabeito` are spelled and cased **identically everywhere**. The one real
issue is that the *top* download folder gets **three different names** within a few lines of
`setup.qmd`, and one of those names is reused for a command that must run from that exact folder —
a learner could run the check from the wrong place. No P0. Two P1 consistency fixes, five P2
polish items.

| Triage | Count |
|--------|-------|
| 🔴 P0 | 0 |
| 🟠 P1 | 2 |
| 🟡 P2 | 5 |

### Recurring patterns
- **Three names for one directory.** The top `raukr-quarto-exercises` folder is called "the
  exercises folder", "the top folder", and "the top `raukr-quarto-exercises` folder" — sometimes
  in adjacent clauses. "day folder" for the inner one is, by contrast, rock-solid. Pin the umbrella
  to one name (gloss once) so "run X from the exercises folder" can't be misread as the day folder.
- **US/UK colour drift in prose.** House convention is UK ("colour-blind-safe colours" in the
  slides and setup); three prose spots drift to US "color(ed/s)". Code identifiers
  (`scale_color_okabe_ito`, `color = species`) stay US — those are API, not prose.

---

## 🔴 P0 — none

Greps for stiff/corporate phrasing, doubled words, and short `Fig`/`Tab` forms in prose returned
nothing in these files. No broken sentences or misspellings found.

---

## 🟠 P1 — fix before the event

### `setup.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 17 | "`source("00-check-setup.R")` **from the exercises folder**." | "…**from the top folder**." | The check must run from the top `raukr-quarto-exercises` folder (line 152 says so); "exercises folder" is also the umbrella name (line 63), so a learner who just opened `day1-intro/` may run it in the wrong place. Match the concrete wording at line 152. |
| 63, 85–87, 152 | "a small **exercises folder**" (63) … "not the **top folder**" (85) … "The **exercises folder** holds one folder per day … not the top `raukr-quarto-exercises` folder" (86–87) … "The **exercises folder** ships a one-shot check. From the **top** `raukr-quarto-exercises` folder" (152) | Define once and hold it: "the **exercises folder** (the top `raukr-quarto-exercises` folder)" on first mention (line 63), then say **"the top folder"** consistently whenever you contrast it with a day folder. | One directory carries three interchangeable names, twice inside a single sentence pair (86–87). Pinning the term removes the "which folder does he mean?" beat right where a learner is deciding what to open. ⚠️ meaning-adjacent (folder identity) — apply the naming, don't alter what opens where. |

---

## 🟡 P2 — nice-to-have

### `labs/quarto/index.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 66 | "a scatter plot … **colored** by `species`" | "…**coloured** by `species`" | UK "colour" is house (this file uses "colour-blind-safe" at 16/38); prose spelling should match. Leave `color = species` / `scale_color_okabe_ito()` — those are R API. |
| 114 | "three penguin species in **distinct colors**" (alt text) | "…in **distinct colours**" | Same UK/US drift, in participant-facing alt text. |
| 85 | "6. Render to HTML (`quarto render **your-doc.qmd**` …)" | "…(`quarto render **my-report.qmd**` …)" | Task 1 just had them create `my-report.qmd`; the generic `your-doc.qmd` placeholder is right in the Citations section (where they may be on `starter.qmd`), but here the file has a concrete name. ⚠️ mild — keep `your-doc.qmd` at 203/248 where the source is genuinely either file. |

### `labs/quarto-projects/index.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 100 | "the plot keeps its **default species colors**" | "…**default species colours**" | UK/US colour drift in prose (2× on this line region). |
| 24–25 | "a **watch-me demo**, not a per-participant step **(the auth cliff would strand a room of 40)**." | "a **watch-me demo**, not a per-participant step — publishing needs an account and auth setup, so we run it once up front." | Presenter's own room-management rationale ("strand a room of 40") leaks into participant prose and presumes the room size; state the format positively and give the neutral reason. ⚠️ meaning-adjacent — verify the reframed reason before applying. |

### `setup.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 106–107 | "If `use_course()` can't reach GitHub **(venue firewall)**, use the browser…" | "If `use_course()` can't reach GitHub **(blocked network / firewall)**, use the browser…" | Predicts a venue network problem we can't know (the venue may be a well-connected university); the neutral reason serves the same advice without the presumption. |
| 94 | "the reference answers are in **`solutions/`** (try first)." | "the reference answers are in **`solutions/day1/`** and **`solutions/day2/`** at the top folder (try first)." | `solutions/` is a sibling of the day folders at the **top** level, not inside a day folder; the bare path in a callout about opening *day* folders can read as if it's local. Both labs already say `solutions/day1/` / `solutions/day2/` — match them. |

---

## ✅ Language strengths

- **Repo slug is airtight.** `cderv/raukr-quarto-exercises@raukr-2026` (setup 70/77/102) and the
  raw-GitHub button URLs `…/raukr-quarto-exercises/raukr-2026/…` (labs/quarto 138/158/331,
  labs/quarto-projects buttons) are byte-identical — no casing or edition-branch drift.
- **Folder names are consistent.** `day1-intro/` and `day2-projects/` (with trailing slash) appear
  the same way across setup, both labs, and both decks; no stray `starter/`, "cloned repo", "repo
  root", or "the project" survived the nested-trap deletion (grep clean).
- **Package list matches everywhere.** setup's nine (dplyr, ggplot2, gt, ggokabeito, brand.yml,
  ggrepel, prismatic, knitr, rmarkdown) and the per-day subsets agree; "nine packages" count is
  consistent (setup 112/158); `ggokabeito` never mis-spelled.
- **"Output lands next to source" is one phrase, reused well** — setup 92, labs/quarto 27/210/307,
  labs/quarto-projects 43–44. Same mental model, same words; a genuine consistency win.
- **`use_course` / Download-ZIP / reset prose is plain and calm** — "say **No**, and keep it: it's
  your one-click reset", "if an attempt goes sideways", "it makes a new, numbered folder and leaves
  your old attempt untouched". Spoken, not stiff.
- **Slide asides are tight.** The reworded "nearest `_quarto.yml`" aside
  (slides/quarto-projects 89–92) is direct and self-contained; helper/logistics rationale correctly
  lives in `::: notes` (out of scope, left untouched).

## 📝 Evolution since the previous review

- The **params-bonus** fixes from the earlier 2026-07-22 params-language cycle (braced inline,
  `-P name:value`, "command-line only", dropped "self-service") are intact and **not re-flagged**.
- The nested-trap apparatus is gone from labs/quarto-projects' "Starting point" (now a clean
  "shipped set of pages" framing) — no leftover nesting jargon.
- New surface added by this migration: the `use_course()` acquisition flow, the day-folder callout,
  the reset/renv callouts, and the `00-check-setup.R` step. All land in-voice; the only debt they
  introduce is the top-folder naming knot above.

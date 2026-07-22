# Language review — WP4 Day-2 lab (Quarto projects)

**Date:** 2026-07-08
**Reviewer:** workshop-reviewer-language
**Branch / state:** `claude/goal-command-wx5go6`, working tree (uncommitted)
**Scope:** `labs/quarto-projects/index.qmd` + shipped starter
`labs/quarto-projects/starter/{index,analysis}.qmd`
**Anchors:** Day-1 lab `labs/quarto/index.qmd`, Day-2 deck `slides/quarto-projects/index.qmd`
**Convention:** US English

---

## Verdict

**Ship-ready, minor polish.** The new lab is clean, well-written, and consistent with the Day-1
lab and the Day-2 deck: US spelling throughout, "cell" (never "chunk"), "website"/"site", and the
exact callout-title vocabulary the anchors use (`Scope` / `Starting point` / `Tasks` /
`You should see` / `Hint` / `Troubleshooting`). Automated hunts came back empty — no stiff
corporate phrasing, no doubled words, no short `Fig`/`Tab` prose refs, no UK spellings. The only
real issue is a three-way inconsistency in the **Challenge names**; the rest is optional register
polish and small drift from the Day-1 template.

**Triage counts — 🔴 P0: 0 · 🟠 P1: 1 · 🟡 P2: 4**

Greps run (all empty except Challenge naming):
```
grep -niE '(in order to|utilize|leverage|it is important to note|in the event that|...|whilst|amongst)'  → 0
grep -En  '\b(\w+) \1\b'  (doubled words)                                                                → 0
grep -nE  'Fig ?[0-9]|Tab ?[0-9]'                                                                         → 0
grep -niE '(colour|behaviour|organis|optimis|customis|centre|licence|analyse|grey)'  (UK spelling)       → 0
```

---

## 🔴 P0 — none

No language problem rises to blocker level for a professional workshop.

---

## 🟠 P1 — fix before the event

### `labs/quarto-projects/index.qmd`

| line | current | proposed | why |
|------|---------|----------|-----|
| 41 / 149 / 156 | `## Website Challenge` … `## Ship it Challenge` … "your **Website-Challenge** `starter/`" | Pick one spelling of each name and use it verbatim on reference. E.g. keep the two headings as-is and write "your **Website Challenge** `starter/`" (no hyphen) | The challenge is named three ways across three lines — heading "Website Challenge", back-reference "Website-Challenge" (hyphenated). Day-1's anchor refers back with no hyphen ("If you finished the **Authoring Challenge**…", `labs/quarto/index.qmd:159`). A reader jumping into Part 2 should see the same token they saw as the heading. |

---

## 🟡 P2 — nice-to-have

### `labs/quarto-projects/index.qmd`

| line | current | proposed | why |
|------|---------|----------|-----|
| 22–23 | "Publishing to GitHub Pages / CI is a **watch-me demo**, not a per-participant step (the auth cliff would strand a room of 40)." | "…not a per-participant step — signing in to each host would trip up too many people at once." ⚠️ | "the auth cliff would strand a room of 40" reads as a presenter's note-to-self (sizing/logistics jargon), not something you'd say to the participant reading the Scope. The deck keeps this rationale in `::: notes`; the lab surfaces it in participant prose. Reword touches wording/emphasis, not the technical claim. |
| 149 | `## Ship it Challenge` | consider `## Shipping Challenge` (or `Ship-it Challenge`) | Parallelism/register: Day-1's challenges are noun + "Challenge" ("Authoring", "Citations") and the sibling heading here is "Website Challenge". "Ship it Challenge" mixes a verb-phrase into the set and reads slightly abrupt in title case. Keep if the punchy voice (echoing the deck's "Scale & ship") is deliberate. |
| 23 | "Everything runs on base-R `datasets::penguins` (R ≥ 4.5) — no data to download." | "Everything runs on **base-R `datasets::penguins`** (R ≥ 4.5) — no data to download." | Day-1 Scope bolds the phrase (`labs/quarto/index.qmd:13`); here it's plain. Trivial visual-consistency drift between the two Scope callouts. |
| 22 | "each is its own ~30-minute part, with the between-parts break in between." | "…each is its own ~30-minute part, with a break between them." | "between-parts break in between" is redundant. NOTE: this exact phrase is copied verbatim from Day-1 (`labs/quarto/index.qmd:12`), which is out of scope — fixing only WP4 would create drift. Recommend fixing **both** or **neither** to keep the twin Scope callouts identical. |
| 30 | `## Starting point — a shipped set of pages` | (optional) `## Starting point` | Day-1's equivalent callout title is the bare "Starting point" (`labs/quarto/index.qmd:158`). The em-dash subtitle here is fine and arguably clearer; flag only for exact title-parity if you want the two labs to line up. |

### `labs/quarto-projects/starter/index.qmd`

Clean. Prose is spoken, correct, US spelling. No changes.

### `labs/quarto-projects/starter/analysis.qmd`

Clean. The single prose line ("@fig-mass shows that Gentoo penguins are clearly the heaviest of
the three species.") is direct and correct. No changes.

---

## ⚠️ Meaning-touching rewrites (human to validate)

- **`index.qmd:22–23`** — the "auth cliff" reword rephrases the *reason* publishing is a demo.
  The intended fact (host sign-in doesn't scale to the whole room live) is preserved, but confirm
  the softened wording still says what you want.

---

## ✅ Language strengths

- **Terminology is on-anchor.** "cell" everywhere for code cells (`:162,167,178,184,219`), never
  "chunk"; "website"/"site" used as the deck does; `project`, `freeze`, `output-dir`, `_freeze/`,
  `_quarto.yml`, `_brand.yml` all cased correctly and matching the deck.
- **Callout vocabulary matches the house style exactly** — `Scope`, `Starting point`, `Tasks`,
  `You should see`, `Hint`, `Troubleshooting` — same titles, same order, same tone as Day-1.
- **Register is instructional and spoken**, not stiff: imperative task verbs ("Render the whole
  folder", "Brand it.", "prove freeze works"), short second-person sentences, no corporate tics.
- **Cross-doc consistency of recurring lines** — "Nobody is stranded by the break", the
  static-host list "(GitHub Pages, Netlify, an internal server)", the "reproducibility has two
  legs" framing, and the "watch-me demo" label all echo the deck/Day-1 verbatim, which is exactly
  what you want across a two-day set.
- **Marked asides are honest and well-signposted** — `*(stretch)*` and `*(note, not a step)*`
  match Day-1 usage and clearly separate optional/for-context material from tasks.

---

## 📝 Evolution since the previous review

First language pass on this newly authored WP4 lab — no prior review to diff against. Baseline
established: the lab lands consistent with its two anchors on the first pass; only the
Challenge-name token needs unifying (P1).

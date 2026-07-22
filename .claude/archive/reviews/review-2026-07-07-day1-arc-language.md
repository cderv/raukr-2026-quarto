# Day-1 arc — cross-file language consistency review

- **Date:** 2026-07-07
- **Type:** language (arc consistency pass, not per-file copy-edit)
- **Reference commit:** 3c45287 (all committed)
- **Scope:** `slides/quarto/index.qmd`, `labs/quarto/index.qmd`, `labs/quarto/starter.qmd`,
  `labs/quarto/penguins-report.qmd`, `labs/quarto/sample-typst.qmd`
- **Reviewer:** language specialist (native-English copy/register)

## Verdict

The arc is **in good shape and largely consistent**. Terminology, product-name casing, axis
labels, challenge names, and voice all hold across the five files. Two genuine cross-file
drifts are worth fixing before the event, plus two minor nice-to-haves. **No P0.**

Triage: **🔴 P0 = 0 · 🟠 P1 = 2 · 🟡 P2 = 2**

## Recurring patterns (cross-cutting)

### 🟠 P1-A — "cell" (deck) vs "chunk" (lab) for the code block

The deck **teaches** the code block as a Quarto **cell**, and even names the `#|` lines "cell
options":

- `slides/quarto/index.qmd:92` — "…Markdown prose, and executable **code cells**."
- `slides/quarto/index.qmd:139` — "A labeled **code cell** becomes a numbered… figure."
- `slides/quarto/index.qmd:269` — "`#|` **cell options** tune each **cell**…"

The lab then uses **chunk** as its working noun almost everywhere:

- `labs/quarto/index.qmd:52` — "…with `format: html` and the setup **chunk** above."
- `labs/quarto/index.qmd:53` — "Give its **chunk** `#| label: fig-bill`…"
- `labs/quarto/index.qmd:54` — "…**in the prose, outside the chunk** — refer to it…"
- `labs/quarto/index.qmd:57` — "give the **chunk** `#| label: tbl-summary`…"
- `labs/quarto/index.qmd:101` — "A **chunk** becomes a cross-referenceable figure/table…"
- `labs/quarto/index.qmd:103` — "…is a **cell option** (`#|`) for a **chunk**…" (both nouns in one line)
- `labs/quarto/index.qmd:242` — "The **chunk** label must start with `fig-`/`tbl-`/`eq-`…"

The deck also slips once itself: `slides/quarto/index.qmd:118` — "Every follow-along **chunk**
assumes this setup" — which contradicts the "code cell" it just taught (92, 139).

**Why it matters:** the Anatomy slide makes "cell" the taught vocabulary (Quarto's own term),
then the lab the learner works in calls the same object a "chunk". For a level-up audience
that's a small but real "which word is right?" wobble.

**Recommendation:** standardize on **cell** for the Quarto code block across deck + lab
(keeping "cell options", which both already use). Reserve **chunk** only where you deliberately
contrast with R Markdown / knitr — those uses are correct and should stay:
`slides/quarto/index.qmd:86` ("the knitr engine runs your **chunks** — the same engine as R
Markdown"), `slides/quarto/index.qmd:38` (notes, out of scope), and the migration aside
`labs/quarto/index.qmd:38` ("cell options move from the **chunk** header"). ⚠️ Purely a
vocabulary swap — no meaning changes — but it touches ~8 lines, so a human should apply it in
one deliberate pass rather than piecemeal.

### 🟠 P1-B — figure captions: "vs." (deck) vs "versus" (all labs)

Same figure, two caption spellings. The deck abbreviates; all four lab files spell it out:

| file:line | caption |
|---|---|
| `slides/quarto/index.qmd:143` | "Bill length **vs.** depth, by species." |
| `slides/quarto/index.qmd:104` | "Bill length **vs.** depth" *(inside a Markdown teaching example)* |
| `labs/quarto/index.qmd:89` | "Target: bill length **versus** depth by species." |
| `labs/quarto/index.qmd:115` | "Bill length **versus** depth, colored by species." |
| `labs/quarto/starter.qmd:48` | "Bill length **versus** depth, colored by species." |
| `labs/quarto/penguins-report.qmd:79` | "Bill length **versus** depth, colored by species." |
| `labs/quarto/sample-typst.qmd:122` | "Bill length **versus** depth by species…" |
| `labs/quarto/sample-typst.qmd:118` | heading "# Bill length **versus** depth" |

**Recommendation:** align the deck to **versus** (the arc's majority and the long-form caption
style). Change `slides/quarto/index.qmd:143` and `:104` (`:104` is a teaching example the
learner reads, so it should model the same style the lab uses).

## Minor nice-to-haves

### 🟡 P2-A — "YAML header" vs "front matter"

Two names for the front YAML block appear in the arc:

- `slides/quarto/index.qmd:92` — "a **YAML header**"
- `labs/quarto/index.qmd:216` — "# In the **YAML header**:"
- `labs/quarto/index.qmd:237–238` — "…check the **front matter** for stray spaces…" (line-wrapped)

The deck settles on "YAML header"; the lab uses both. **Recommendation:** pick one for prose —
"YAML header" matches the deck — and let the lab troubleshooting line follow it. Low stakes.

### 🟡 P2-B — "body markdown" lowercase vs "Markdown" the language

`labs/quarto/index.qmd:138` — "…live in the **body markdown**, outside any chunk" uses lowercase
`markdown`, whereas the language is capitalized everywhere else in the arc
(`slides/quarto/index.qmd:92, 129, 189`). Either capitalize ("body Markdown") or reword to "the
document body" to avoid the proper-noun clash.

## Per-file notes

Nothing file-specific beyond the cross-file items above. `starter.qmd`, `penguins-report.qmd`,
and `sample-typst.qmd` are clean on the arc dimensions (casing, labels, spelling, register); the
two P1 patterns land in the deck and `labs/index.qmd`.

## ✅ Language strengths (verified across all five)

- **US English is 100% consistent** — `colored`/`colored by species`, `labeled`, `summarized`,
  `colored`; a targeted grep for British forms (`colour`, `-ise`, `labelled`, `behaviour`,
  `centre`, `towards`, `whilst`, `grey`, …) returned **no matches**. (The R verb `summarise`
  is code, correctly left alone.)
- **Product/API casing uniform** across the arc: Quarto, Typst, Markdown, Pandoc, HTML, PDF,
  YAML, CSL, R Markdown, `_brand.yml` — no drift found.
- **Axis / label wording identical everywhere**: every `labs()` call and the relevant table
  labels read "Bill length (mm)" / "Bill depth (mm)" (slides:150, labs/index:95 & 119,
  starter:54, penguins-report:87, sample-typst:141).
- **Challenge names match deck ↔ lab exactly**: "Authoring Challenge"
  (`slides:280` ↔ `labs/index:44`) and "Citations Challenge" (`slides:414` ↔ `labs/index:151`).
- **`culmen` is deliberate, not drift** — introduced and glossed once in the one document that
  carries the culmen figure (`penguins-report.qmd:55`, "the *culmen*, @fig-culmen"); every other
  file uses plain "bill". Correct.
- **Callout titles consistent**: "Follow along" (`slides:116, 310`) and "Your turn — regroup in
  ~30 min" (`slides:279, 413`).
- **Voice/register is consistent deck ↔ lab**: direct, second-person, imperative, em-dash
  rhythm; the lab reads as the same author as the deck.
- **Compound-modifier hyphenation applied consistently** across files: "Part-2 starter" /
  "Part-1 report" and "Day-1 document" as modifiers vs open "Part 2" / "Day 1" as nouns.

## 📝 Evolution since the previous reviews

Prior language work was **per-file copy-editing** (dispositions in
`.claude/archive/reviews/README.md`); this is the first **arc-wide consistency** pass. It does
**not** re-flag anything from those individual passes — it looks only at drift *between* files.
The two P1 items (cell/chunk, vs./versus) are exactly the kind of divergence that only surfaces
when the five files are read as one set, and they are the sole substantive cross-file findings.

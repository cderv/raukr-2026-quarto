# Language review — margin "Quarto docs" pointers + Scope/goal trim

**Scope:** changed lines only in `labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd`,
`labs/quarto/sample-typst.qmd` (delta `b926461..HEAD`, ref commit c7d97e3).
**Not re-flagged:** anything outside the delta; the 2026-07-23 em-dash/colour/idiom/French-spacing
sweep; the collapsible-solution reformat; the Scope-trim decision itself.

## Verdict

**Ship it.** The new margin pointers are house-voice clean and fully consistent across both labs;
the trimmed Scope prose and reworded goal are short, declarative, and free of em-dash asides and
leaked spoken register. No P0, no P1. Two P2 word-choice nits, both optional.

- 🔴 P0: 0
- 🟠 P1: 0
- 🟡 P2: 2

## 🔴 P0

None.

## 🟠 P1

None.

## 🟡 P2 (optional, word choice)

| file:line | current | proposed | why |
|---|---|---|---|
| `labs/quarto/index.qmd:19`, `labs/quarto-projects/index.qmd:30` | "**Before you start:** run through the **[Setup page]**…" | "…**work through** the **[Setup page]**…" or "…**go to** the **[Setup page]**…" | "run through" is a mild phrasal verb that can read as "skim". A plainer verb matches the ESL-precise register. Borderline; keep if you read it as "complete". Apply to **both** labs to stay in sync. |
| `labs/quarto-projects/index.qmd:31` | "The optional branded-plot **stretch** also uses `brand.yml`." | "The optional branded-plot **step** also uses `brand.yml`." | "stretch" (as in stretch-goal) is workshop jargon used as a noun; the sibling lab marks its optional part "Fully optional" instead. Plain "step" avoids the undefined term. ⚠️ mild meaning shift (drops the "harder/extra" connotation) — leave to author. |

## ✅ Language strengths

- **Margin pointers are perfectly consistent** across all five instances (both labs): identical icon
  `{{< fa book-open >}}`, identical bold label `**Quarto docs**`, identical spaced-middle-dot
  separator ` · `, link text in Quarto's own doc-page casing ("Cross-references", "Article layout",
  "Citations", "Typst", "Parameters", "Websites", "Brand", "Freeze", "Publishing"). Zero wording
  drift between the two files.
- The ` · ` separator is the established repo convention (matches the subtitles, e.g. "RaukR 2026 ·
  Day 2"), so the non-ASCII middle dot is intentional, not drift.
- **"Before you start:" sentence is byte-identical** in both labs — colon into the instruction, short
  imperative spine, direct second person. Textbook house voice.
- **Reworded Citations goal** (`labs/quarto/index.qmd:167`) drops the old trailing em-dash aside
  ("— the manuscript payoff, no LaTeX") for a clean full stop. Removes a machine-tell and a duplicate
  of the retired "— no LaTeX" verbal tic (house-voice §"retire these beats").
- **`sample-typst.qmd:82`** "no LaTeX **in the loop**" → "no LaTeX **involved**" swaps an idiom for
  the literal statement — exactly the ESL-plain fix the house voice asks for, and now the sole,
  plainly-stated "no LaTeX" instance carries it.
- Copy-edit: no doubled words, no space before `?`/`!`/`:`, no typos in the changed lines; the reworded
  Scope keeps ASCII where the surrounding prose does.

## 📝 Evolution since last review

Continues the 2026-07-23 sweep's direction: this delta removes two more of the flagged patterns
(the "— no LaTeX" trailing-dash echo on the Citations goal, and the "in the loop" idiom in
sample-typst), and adds the new margin-pointer component in a disciplined, uniform way — no new
em-dash asides, no reassurance narration, no antithesis flips introduced. The Scope trim keeps the
"watch-me demo, not a per-participant step" contrast that predates this delta (unchanged, not
flagged). Net: the changed lines are cleaner than what they replaced.

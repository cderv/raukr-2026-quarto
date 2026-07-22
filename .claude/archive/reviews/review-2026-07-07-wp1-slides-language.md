# Language review — WP1 Day-1 deck (`slides/quarto/index.qmd`)

- **Date:** 2026-07-07
- **Reviewer:** language (English copy + plain language)
- **Reference commit:** 31cae8e (deck just authored, uncommitted)
- **Scope:** ONLY `slides/quarto/index.qmd`. Lab skeleton out of scope. Presenter notes
  (`::: notes`) out of scope (relaxed register allowed there).
- **House rule:** US English. Register = clear, spoken-but-professional slide phrasing;
  fragments are fine and encouraged.

---

## Summary

This is a clean, well-paced deck. The prose is already crisp and speakable — no corporate
bloat, no hedging pile-ups, no run-ons. The two grep sweeps for stiff phrasing came back
**empty**:

```
grep -inE '\b(in order to|utilize|leverage|facilitate|it is important|in terms of|with regard to)\b'  → no matches
```

Terminology is disciplined: "bill" is used throughout (never "culmen"); product casing is
correct everywhere (Quarto, Typst, Markdown, Pandoc, LaTeX, YAML, knitr, Positron, VS Code,
RStudio, Jupyter). The deck deliberately bridges R Markdown "chunk" → Quarto "cell", which is
the right instinct for this audience.

Findings are few and small. Nothing rises to P0.

### Triage

- 🔴 **P0 — 0.** No real language problems.
- 🟠 **P1 — 1.** One British spelling in prose ("labelled") violates the US house rule.
- 🟡 **P2 — 3.** Chunk/cell slip on one slide; Oxford-comma drift; a minor parallelism wobble.

### Recurring patterns

1. **cell vs chunk (P2).** The deck standardizes on "cell" for Quarto and reserves "chunk"
   for the R Markdown bridge — good. The one exception is slide `Execution options`
   (line 245), which flips to "chunk" twice inside a pure-Quarto context.
2. **Oxford comma drift (P2).** Some lists carry the serial comma, some don't. US house
   style leans Oxford; pick one.

---

## `slides/quarto/index.qmd`

| line | current | proposed | why (1 line) |
|------|---------|----------|--------------|
| 128 | "A **labelled** code cell becomes a numbered, referenceable figure:" | "A **labeled** code cell …" | British spelling in prose; US house rule (note: `label:` the option and `labs()` the R call stay as-is). |
| 245 | "`#\|` cell options tune each **chunk** — shown as deltas, not a **chunk** tour:" | "`#\|` cell options tune each **cell** — shown as deltas, not a cell-by-cell tour:" | The deck's Quarto term is "cell" (lines 85, 90, 128); "chunk" here reads as a slip. ⚠️ If the intent is to speak the audience's R Markdown dialect on this slide, leave it — the mixed "cell options … each chunk" in one line is the only real snag. |
| 30, 350 | "figures, tables, cross-references **and** math" / "HTML, PDF **and** Typst" | "figures, tables, cross-references**,** and math" / "HTML, PDF**,** and Typst" | Oxford comma is used elsewhere (e.g. line 413); align on serial comma under US style. Cosmetic — batch only if you want strict consistency. |
| 198 | "places content in the **body**, the **margin**, or **wider than the body**" | "places content in the **body**, the **margin**, or a zone **wider than the body**" | Third item breaks the noun-phrase parallel; a hair smoother to say aloud. ⚠️ optional — meaning is already clear. |

### Non-issues checked and cleared

- **"referenceable" vs "cross-referenceable"** (lines 128, 143, 149, 160): both forms appear,
  but each reads correctly in context (the bare form where "cross-" is implied). Not worth
  churning.
- **"deltas"** (lines 112, 245): jargon, but a deliberate, consistent motif for a technical
  audience — keep.
- **"The data come from…"** (line 314): plural "data" is correct and appropriate for this
  life-science audience — a strength, not an error.
- **`summarise()`** (line 155): dplyr function name — correctly left untouched (not prose).
- **vs.** (lines 99, 132): consistent with the period both times.

---

## ✅ Language strengths

- Zero corporate filler — the whole deck already speaks in the target register
  ("That is the whole switch.", "Reproducible by construction.", "no LaTeX toolchain").
- Consistent product/API casing throughout; lowercase `knitr` correctly stylized.
- "bill" used uniformly; no "culmen" drift.
- Slide fragments are tight and land as headlines, not padded prose — exactly right for
  revealjs.
- Callout titles ("Follow along", "Your turn", "Pre-flight", "Format caveat") are short and
  spoken.

## 📝 Evolution since the previous review

First language pass on this deck (WP1, freshly authored) — no prior review to diff against.

---

**Verdict:** ship-ready on language. Fix the one British spelling (line 128) before the event;
everything else is optional polish.

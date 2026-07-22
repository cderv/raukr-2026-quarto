# Language review — 2026-07-21 (`fixverify`)

**Scope:** verification pass on the 2026-07-20 fix batch (delta `6a910a5..356e840`, commits
703e19d + 356e840). Changed content files only: `slides/quarto/index.qmd`,
`slides/quarto-projects/index.qmd`, `labs/quarto-projects/index.qmd`, `labs/quarto/starter.qmd`,
`labs/quarto/penguins-report.qmd`, `setup.qmd`; light pass over the changed `.claude` docs.
Reference commit: 356e840.

## Verdict

**PASS.** Every targeted 2026-07-20 fix landed and reads naturally in context. Two small
leftovers to clean before the event (both one-liners), a handful of nice-to-haves. No P0.

Fix-by-fix verification of the priority targets:

| Fix | Where it landed | Verdict |
|---|---|---|
| "the sane setting to adopt" | `slides/quarto-projects/index.qmd:288` | ✅ landed; ⚠️ the code comment above it still says "the sane default" — see P1-1 |
| "a collaborator who won't open R" | `slides/quarto-projects/index.qmd:418` | ✅ generic, spoken, natural |
| "in CI" replacing "the runner" | `slides/quarto-projects/index.qmd:372` ("no R needed in CI") | ✅; "runner" survives only in `::: notes` (line 381) — allowed |
| "CI mode" replacing "hard-freeze" | `labs/quarto-projects/index.qmd:181` ("the CI mode") | ✅ reads cleanly in the hint |
| CI gloss on `#freeze-workflow` | `slides/quarto-projects/index.qmd:316-317` | ✅ grammatical; placement note in P2-2 |
| "within-page cross-references" Day-2 outcome | `slides/quarto-projects/index.qmd:32` | ✅ accurate; "with within-" tongue-twister — P2-1 |
| within-page vs across-page contrast step | `labs/quarto-projects/index.qmd:91-96` | ✅ clear; "vs" breaks the "versus" convention — P1-2 |
| `Wi-Fi` | `setup.qmd:98` | ✅; matches the only other occurrence (`slides/quarto-projects/index.qmd:380`, notes) |
| Braced `` `{r} `` migration | `labs/quarto/penguins-report.qmd:33-34`, `labs/quarto/starter.qmd:29-30`, `slides/quarto/index.qmd:154, 291-305` | ✅ consistent — see strengths |

Clean sweeps run on the changed files (all empty): doubled words
(`\b(\w+) \1\b`), stiff phrasing (`in order to|utilize|leverage|it is important|facilitate`),
UK spellings (`colour|behaviour|organise`), `capstone`, `wet-lab`, `hard-freeze` — the last
three are fully gone from participant-facing content.

## 🔴 P0

None.

## 🟠 P1

### slides/quarto-projects/index.qmd

| line | current | proposed | why (1 line) |
|---|---|---|---|
| 285 | `freeze: auto        # re-execute a document only when its source changes (the sane default)` | ⚠️ `freeze: auto        # re-execute a document only when its source changes` | The prose fix (line 288) deliberately dropped the "default" claim (`freeze: auto` is not Quarto's out-of-the-box default) and the comment re-asserts it; also "sane" now appears twice on one slide. Dropping the parenthetical lets line 288 carry the judgment. Human to confirm the technical intent. |

### labs/quarto-projects/index.qmd

| line | current | proposed | why (1 line) |
|---|---|---|---|
| 91 | "the **within-page vs across-page** rule" | "the **within-page versus across-page** rule" | House convention is "versus" in prose (held everywhere else in content — 7 other prose/caption uses, zero "vs"); this new line is the only drift. |

## 🟡 P2

### slides/quarto-projects/index.qmd

| line | current | proposed | why (1 line) |
|---|---|---|---|
| 32 | "a navigable, **branded website** with within-page cross-references and reproducible builds" | "a navigable, **branded website** — within-page cross-references, reproducible builds" | "with within-page" is a tongue-twister read aloud; an em-dash list keeps the exact claims. |
| 277 | "commit it and **CI** rebuilds with **no R at all**" | *(optional)* move the parenthetical gloss here from line 316-317 | First **on-slide** "CI" is one slide before the written gloss; acceptable as-is since the `#freeze` notes (line 296) cue the presenter to gloss it aloud at first use. |

### labs/quarto-projects/index.qmd

| line | current | proposed | why (1 line) |
|---|---|---|---|
| 24 | "GitHub Pages / CI is a **watch-me demo**" | *(optional)* "GitHub Pages / CI *(the automated build)* is a **watch-me demo**" | Lab's first "CI" is unglossed; mild because the lab follows the slides where it's glossed twice (spoken + written). |
| 93-96 | "Then, on `index.qmd`, point to the analysis page with a plain Markdown link — `[the analysis](analysis.qmd)` — because **across** pages there is no auto-numbering: that's a *book* feature, not a website one, so a link is how you connect website pages." | split after "auto-numbering": "…there is no auto-numbering. That's a *book* feature, not a website one — so a link is how you connect website pages." | One sentence carrying three clauses; a split reads better on the bench. Meaning unchanged. |

### .claude docs (internal — errors only)

No typos or factual slips found in the delta to `project-context.md`, `topic-store.md`,
`quarto-doc-sources.md`, `sandbox-setup.md`, or `rules/slides.md`. (Passing, non-delta note:
`quarto-doc-sources.md` has pre-existing "behaviour" ×2 against the US-spelling convention —
internal doc, out of this pass's scope, fix opportunistically.)

## ✅ Language strengths

- **The braced-inline migration is vocabulary-consistent and technically disciplined.** Both
  decks and labs use `` `{{r}} …` `` where the syntax is *shown* (`slides/quarto/index.qmd:154,
  296`) and `` `{r} …` `` where the *value* should print (`:301`, both labs) — exactly the
  single-brace-executes / double-brace-literal rule in `rules/slides.md` §5. The concept is
  named "inline code" everywhere it's discussed (`slides/quarto/index.qmd:188, 291-293`).
- **The new inline-code slide reads well aloud** — "drops a computed value straight into
  prose… It renders with the live count" is plain, direct, and the show→result two-beat is a
  nice teaching rhythm.
- **Reusability discipline held**: "collaborator who won't open R", "Compute can be slow" +
  the localization cue in notes (`slides/quarto-projects/index.qmd:292`), zero domain-locked
  wording in the delta; "capstone" is gone from participant-facing terms including
  `topic-store.md`.
- **Presenter logistics stayed in notes**: "runner", the room-killer rationale, and the
  40-laptops framing all live in `::: notes` only.
- The CI gloss sentence (`slides/quarto-projects/index.qmd:316-317`) is grammatically tight —
  compound subject, plural "stay", gloss set off in italics without breaking the sentence.

## 📝 Evolution since the previous review (2026-07-20 language)

All language P0/P1 items from `review-2026-07-20-language.md` are verified fixed in this
delta; nothing regressed. The dispositioned deferrals ("think in deltas" title,
`sample-typst.qmd` legacy inline form) were respected and are not re-flagged. The only new
issues are two small artifacts *of* the fix batch itself: the orphaned "(the sane default)"
code comment next to the reworded prose (P1-1) and one "vs" in the new lab stretch step
(P1-2). The `.claude` doc audit (356e840) introduced no language errors.

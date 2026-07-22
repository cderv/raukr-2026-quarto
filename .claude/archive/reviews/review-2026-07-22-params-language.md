# Language review — params bonus content (2026-07-22)

**Scope tag:** `params`. Reference commit **bee98ea**.
**Files reviewed:** the new `## Bonus — one report per species` section in
`labs/quarto/index.qmd` (249–313), the new `labs/quarto/penguins-by-species.qmd`, and the
`-P` bullet + `::: notes` on `slides/quarto/index.qmd` (`## Running & editing`, 445–468).

## Verdict

**Solid.** The new prose is clear, direct, and in-voice — imperative task wording, spaced
em-dashes, "versus" (not "vs"), consistent Goal-blockquote and "complete, runnable solution
is …" patterns that match the rest of the lab. No P0. Two real cross-file **consistency**
issues (P1) worth fixing before the event, plus two small register trims (P2). Nothing here
changes meaning.

- 🔴 P0: 0
- 🟠 P1: 2
- 🟡 P2: 2

---

## 🟠 P1 — fix before the event

### `labs/quarto/penguins-by-species.qmd` — inline-R form differs from its sibling files

| line | current | proposed | why |
|------|---------|----------|-----|
| 19 | `` **`r params$species`** penguins only `` | `` **`{r} params$species`** penguins only `` | The two parallel HTML report files, `penguins-report.qmd` (`{r} nrow(penguins)`) and `starter.qmd` (`{r} nrow(penguins)`), use the **braced** house form; this new file uses the legacy `` `r …` ``. Match the house form (also the preferred portable form per `.claude/rules/slides.md §5`). Safe — the doc has an executable `setup` cell. |
| 42 | `` `r nrow(one)` `r params$species` penguins had both … `` | `` `{r} nrow(one)` `{r} params$species` penguins had both … `` | Same inline-R form; convert both spans on this line. |

Note: `sample-typst.qmd` also uses legacy `` `r …` ``, so the lab is already mixed — but the
two files that mirror this one (report → HTML) are braced, so aligning the new file removes the
inconsistency a reader most likely notices (open `penguins-report.qmd` and `penguins-by-species.qmd`
side by side).

### Slide vs lab — the `-P` placeholder metavariable disagrees

| file:line | current | proposed | why |
|-----------|---------|----------|-----|
| `slides/quarto/index.qmd:457` | `` **`-P key:value`** `` | `` **`-P name:value`** `` | The lab writes the placeholder as `name:value` twice (`labs/quarto/index.qmd:284`, `:302`); the slide says `key:value`. Same concept, two tokens across linked materials. `name` reads better against `params$species` (parameters are referenced by name), and the lab is where learners type it — so align the slide to the lab. (Either token is defensible; the point is picking one.) |

---

## 🟡 P2 — nice-to-have

| file:line | current | proposed | why |
|-----------|---------|----------|-----|
| `labs/quarto/index.qmd:284` | "the parameter override is a command-line thing" | "the parameter override is command-line only" | "a … thing" is loose for the workshop register; "command-line only" is tighter and carries the same "no Render button" point. |
| `labs/quarto/index.qmd:253` | "Fully optional, self-service — skip it if you're out of time." | "Fully optional — skip it if you're short on time." | "self-service" is mild corporate jargon and adds little next to "Fully optional"; ⚠️ only if you want to keep the "do it unguided" nuance — otherwise the trim reads cleaner. |

---

## ✅ Language strengths

- **US/UK spelling — consistent, question resolved.** "parameterized" (`index.qmd:251`, US
  `-ize`) matches the lab's US verb spelling elsewhere ("colored", `:60`); "colour-blind-safe"
  is a deliberate compound-term exception, not drift. No change needed — the task's
  "parameterized vs parameterised" question lands on **parameterized**.
- **Terminology consistent:** "parameter" / `params$…` / "parameterized" used correctly and
  uniformly across lab, solution file, and slide.
- **"versus" not "vs"** in the new fig-caps and prose (`index.qmd:281`,
  `penguins-by-species.qmd:34`) — honours the prior disposition.
- **Code-span formatting** (`` `-P` ``, `` `params$species` ``, `` `#| output: asis` ``,
  `` `quarto render` ``) matches the lab's established style.
- **Direct address / imperative** throughout the Tasks list ("Declare", "Use it", "Build",
  "Render") — spoken-to-the-learner, no third-person audience labelling.
- **Structural patterns reused:** Goal blockquote (`> **Goal:**`) and "The complete, runnable
  solution is …" mirror lines 52/155 and 126 — no new inconsistency introduced.
- **Slide bullet is a clean MENTION** — one line, name-checks `-P`, defers the hands-on to the
  lab; not overstuffed.

## 📝 Evolution since the previous review

New content only (Day-1 optional params bonus); no regressions against earlier dispositioned
fixes. The 2026-07-21 US/UK and "versus"/"vs" resolutions hold in the new prose. Only genuinely
new issues: the two P1 cross-file consistency mismatches (inline-R form; `-P` placeholder) that
arise precisely because this material is new and hadn't been reconciled against its siblings.

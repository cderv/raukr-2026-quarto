# Beginner review — Day-1 lab (WP2): `labs/quarto/index.qmd` + `starter.qmd`

- **Date:** 2026-07-07
- **Reviewer role:** simulated RaukR participant — fluent R (dplyr/ggplot2), new to Quarto beyond R Markdown
- **Reference commit:** bb42f07 (WP2 lab files uncommitted)
- **Scope:** only `labs/quarto/index.qmd` and `labs/quarto/starter.qmd`. Deck + WP0 assets treated as given.
- **Conditions:** room B27, doing (not reading) both Challenges, TAs roaming, I did **not** finish Part 1.

## Overall verdict

I can get through both Challenges on the day — the happy path holds. I verified the load-bearing
facts myself: the setup chunk runs, `bill_len`/`bill_dep`/`body_mass`/`species` are the real base-R
column names, `@gorman2014` is genuinely a key in `references.bib`, and the shipped `starter.qmd`
really is known-good — I rendered it to **Typst and got a branded PDF**, gt table and all. So no
blocker. What will cost me time is two under-specified spots: the lab never tells me **where** to
create my new `.qmd` (and Part 2's relative `bibliography:`/`csl:` and the project `_brand.yml` only
resolve if it sits in `labs/quarto/`), and the **equation task** gives me no content and no warning
about the `bill_len` underscore trap — which fails *silently*. The gap handoff to `starter.qmd` is
the strongest part: explicit, kind, and it works.

## 🔴 P0 — blocking for the event

None. Both Challenges are completable as written; the gap path via `starter.qmd` is safe.

## 🟠 P1 — fix before the event

### P1-1 — "Create a new `.qmd`" never says *where*, and Part 2 breaks if I guess wrong

`index.qmd:50` — *"Create a new `.qmd` with `format: html` and the setup chunk above."*

Nothing tells me which folder. As a doer I'd plausibly create `penguins-report.qmd` on my Desktop
or home dir. Then in the **Citations Challenge**:

- `index.qmd:143-145` — `bibliography: references.bib` / `csl: apa.csl` are **relative to my doc**.
  If my doc isn't in `labs/quarto/` (where those two files live), both silently fail → I get
  `[?]` / `?@gorman2014` and no reference list.
- The branded Typst payoff relies on the project-root `_brand.yml`, which Quarto only applies to a
  file **inside the project**. A stray file renders unbranded.
- Even Part 1 `library(gt)` depends on the project `renv` — outside the project the library isn't on
  the path.

The gap path is fine (the starter already lives in `labs/quarto/`), but a doer who *did* finish
Part 1 in the wrong place hits all three. One sentence fixes it: *"Create it inside `labs/quarto/`
(next to `references.bib`/`apa.csl`) so Part 2's paths and branding resolve."*

### P1-2 — the equation task: no content given, and a silent underscore trap

`index.qmd:56-57` — *"Add the bill-shape ratio as a display equation with `$$ … $$ {#eq-ratio}`"*.
Hint `index.qmd:92` repeats the syntax but never says **what the ratio is** or how to write it.

Two problems for a Part-1 doer:
1. I have to invent the LaTeX. The real content is `\text{ratio} = \frac{\text{bill\_len}}{\text{bill\_dep}}`
   (it's in `starter.qmd:59-61` — but I don't open the starter during Part 1).
2. **Silent trap:** if I write the natural `bill_len` / `bill_dep` inside `$$…$$`, the `_` is math
   subscript — it renders "bill" with a subscript "len", **no error, no warning**. I'd stare at
   wrong-looking output and not know why. The underscores must be escaped (`bill\_len`).

And the in-lab solution doesn't save me: the `sol-authoring` chunk (`index.qmd:95-123`) contains the
figure, the margin counts, and the table — but **omits the equation entirely**. So the one task with
a hidden gotcha has neither content guidance nor a fold-out solution; my only recourse is the
external `penguins-report.qmd`. Please add the escaped form (or at least warn about `\_`) to the hint
or the solution chunk.

## 🟡 P2 — nice-to-have

### P2-1 — solution chunk omits the prose cross-references (and the equation)
`index.qmd:95-123`, header *"Solution — the key chunks"*. Tasks 2/3/5 tell me to "refer to it in
prose with `@fig-bill`", but the solution shows only chunk code — never where `@fig-bill` /
`@tbl-summary` / `@eq-ratio` go (in body markdown, outside any chunk). New-to-Quarto me isn't sure
prose refs live outside code blocks. A one-line prose example would close it.

### P2-2 — Typst render spews scary font warnings that aren't explained
When I render the starter (with its plain `gt()` table) `--to typst`, I get ~8 red blocks:
`warning: unknown font family: helvetica / arial / sans-serif / …` — then `DONE` and a PDF. I
confirmed this by rendering it. A beginner will read "warning … warning …" as failure. The
Troubleshooting callout (`index.qmd:205-220`) covers many things but not this. One line — *"gt tables
print harmless `unknown font family` warnings under Typst; the PDF still builds"* — would stop me
flagging down a TA. (The fully branded table via `theme_brand_*` is in `sample-typst.qmd`, but the
lab doesn't ask me to use it, so my table stays default-fonted — that's fine, just warn me.)

### P2-3 — starter placeholder `author: "Your name"` lands in my output
`starter.qmd:4` — `author: "Your name"`. If I pick up the gap path and never touch it, my HTML and
branded PDF are literally authored by "Your name". Harmless but sloppy in the manuscript payoff;
the lab never tells me to replace it. A `<!-- replace this -->` nudge or a task line would help.

### P2-4 — "open the shipped starter.qmd" link points at the rendered page, not the source
`index.qmd:136` — *"open the shipped **[`starter.qmd`](starter.qmd)**"*. In the rendered lab the link
resolves to `starter.html` (a rendered report), but I need the **source** `.qmd` to edit. Say *"open
`labs/quarto/starter.qmd` in your editor"* so I don't click through to a read-only page and get
confused.

### P2-5 — citation Task 2 may make me paste a duplicate sentence
`index.qmd:147` shows the full sentence *"…collected at Palmer Station, Antarctica [@gorman2014]."*
But `starter.qmd:30-31` **already contains that sentence without the citation**. Doing the gap path,
I might paste a second copy instead of just inserting `[@gorman2014]` before the period in the
existing sentence. A nudge — *"the sentence is already in the starter; just add `[@gorman2014]`"* —
avoids the double.

## ✅ What reassures me (from a beginner's seat)

- **Setup is spelled out and declared assumed:** `index.qmd:18` *"Start every document with this
  setup — the challenges below assume it"* + the copy-paste chunk (`:20-29`). Columns `bill_len` /
  `bill_dep` are the correct base-R `datasets::penguins` names (I checked) — no `palmerpenguins`
  `bill_length_mm` mismatch to trip me.
- **The facts under the tasks are real:** `@gorman2014` is actually in `references.bib`;
  `knitr::combine_words(levels(species))` and `nrow()` in the starter run clean.
- **A concrete visual target:** the rendered `fig-target` (`index.qmd:71-84`) shows me exactly what
  "three separated clusters" should look like — I know when I'm done.
- **The gap handoff is the best-designed part:** `index.qmd:133-138` — *"Nobody is stranded by the
  break."* The starter is genuinely known-good: I rendered it straight to Typst and got a branded PDF
  (Albert Sans fetched, no errors).
- **Troubleshooting covers the failure modes I'd actually hit:** `?@…` cross-refs, `[?]` citations,
  YAML indentation, missing package, brand/fonts/network-on-first-render (`index.qmd:205-220`).
- **R ≥ 4.5 is flagged** up front (`index.qmd:12`), so I won't be blindsided if my laptop R is old.
- The R-Markdown-migration aside (`index.qmd:31-41`) is exactly the reassurance an Rmd dabbler wants,
  and it's collapsed/optional so it doesn't slow me down.

## 📝 Evolution since the previous review

No prior **beginner** review exists for these two WP2 files — they were just authored, so this is the
baseline pass. Nothing here re-flags an earlier-fixed item. For the ledger: the strong points to
preserve on any re-review are the explicit setup chunk, the rendered target figure, and the
"nobody is stranded" gap handoff.

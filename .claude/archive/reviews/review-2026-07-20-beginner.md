# Beginner review — participant seat, both days (2026-07-20)

_Fictional stance: experienced R + tidyverse, life-science, have dabbled in R Markdown for simple
reports but never built a Quarto project, never touched `_brand.yml` / extensions / Quarto slides.
I attend **both** days. Walked the participant path in chronological order:
`setup.qmd` → `index.qmd` → Day-1 slides + lab (+ `starter.qmd`, `penguins-report.qmd`) →
Day-2 slides + lab (+ `starter/`, `solution/`). Reviews are of participant-facing content only._
Reference commit `6a910a5`, scope: whole repo (both days).

## Overall verdict

I make it through the two days. The setup page is genuinely reassuring (versions, editor choice,
clone step, an renv **and** a plain-`install.packages` path, a font pre-warm, and a dataset
fallback for R < 4.5), the vocabulary that used to trip me is glossed at first use (Typst, CSL,
WYSIWYM, hash-pipe, `output-dir`), and the labs chain cleanly with real safety nets (`starter.qmd`,
`solution/`) so the 1-hour gap can't strand me. The Day-2 callbacks to Day 1 all check out — none of
the "you saw this yesterday" lines made me doubt my memory (details below). **One thing will
actively mislead me:** the two slides that teach **inline code** display `knitr::inline_expr(...)`
verbatim instead of the `` `r nrow(penguins)` `` I'm supposed to write — I rendered it to confirm.
That's the one fix I'd want before the day; everything else is polish.

## 🔴 P0 — blocking for the event

None. Every file the material points me at exists, the citation key resolves, the `cd starter/`
trap is over-documented, and the re-entry safety nets are real.

## 🟠 P1 — fix before the event

**1. The inline-code teaching shows `knitr::inline_expr(...)` literally — twice — instead of the
`` `r nrow(penguins)` `` I'm meant to write.** I rendered both constructs to be sure.

- **Anatomy slide** `slides/quarto/index.qmd:154`, inside the ```` ```{.markdown} ```` example block:
  `` We measured **`r knitr::inline_expr("nrow(penguins)")`** penguins. `` — because a `.markdown`
  block is verbatim, this renders on-screen as the literal text
  `` We measured **`r knitr::inline_expr("nrow(penguins)")`** penguins. `` (confirmed by render). But
  this slide is titled *"Anatomy of a `.qmd`"* — it's the **first example of a real document I see**,
  and a real `.qmd` contains `` `r nrow(penguins)` ``, not a call to `inline_expr`.
- **Inline code slide** `slides/quarto/index.qmd:294`: `` `` `r knitr::inline_expr('nrow(penguins)')` `` ``
  — the double-backtick wrapping protects it from execution, so it too renders as the literal
  `` `r knitr::inline_expr('nrow(penguins)')` `` (confirmed by render), when the sentence
  ("*write X and the prose says 'N penguins'*") clearly wants X to be `` `r nrow(penguins)` ``.

Why it loses me: inline code is the one piece of "magic" being taught on this beat, and on both the
concept slide and the demo slide I'm shown a function call I've never heard of instead of the actual
syntax. If I copy from the slide I get literal garbage in my output; if I'm revising from the slides
later (no presenter to correct it) I'll believe inline code requires `knitr::inline_expr()`. It also
contradicts the labs, which get it right — `starter.qmd:29` and `penguins-report.qmd:33` both use the
plain `` `r nrow(penguins)` ``. The fix is to display the literal form directly (double-backticks
around `` `r nrow(penguins)` ``, no `inline_expr`). Note the author clearly *knows* the escaping idiom
— the code chunk right below uses `` ```{{r}} `` (double-brace) correctly; it's only the inline case
that's wrong.

## 🟡 P2 — nice-to-have

**2. "CI" is never spelled out on a slide body — only in the speaker notes.** `slides/quarto-projects/index.qmd:277`
("commit it and **CI** rebuilds with **no R at all**"), `:316` ("the project build and CI stay
R-free"), `:354`. The gloss *"a build that runs on every push"* lives at `:296` — a `::: notes`
line I never see. I've done bioinformatics for years but never web CI; on revision without the
presenter, "CI" is an undefined term on the most-repeated payoff of Day 2. One parenthetical on the
first slide use would fix it.

**3. The cross-page-link example points at an anchor that doesn't exist.** `slides/quarto-projects/index.qmd:181`
shows `` See the [analysis page](analysis.qmd#sec-model) for the model. `` but neither
`starter/analysis.qmd` nor `solution/analysis.qmd` has a `#sec-model` section (they're "Body mass by
species" / "Mean measurements"). It's an illustrative slide, not a lab task, so it doesn't block me —
but if I copy the pattern verbatim I get a dead in-page link and wonder why. Use a section that
actually exists, or a clearly generic placeholder.

**4. Small promise-vs-delivery on the Day-2 wrap-up.** `slides/quarto-projects/index.qmd:400` lists
`_metadata.yml` among what "you can now" do, but I only ever *saw* it on a slide (`#metadata`) — the
lab project is flat and explicitly has "no folder to scope" (`:118-121`), so I never created one.
I did learn the concept, so this is mild, but "you can now" overclaims a thing I didn't practice.

## ✅ What reassures me (beginner's-eye clarity)

- **Setup is thorough and calm.** `setup.qmd` gives me the R/Quarto floors *with the reason*
  (`penguins` needs R ≥ 4.5; Typst margin layout needs Quarto ≥ 1.9), lets me pick any editor, has an
  explicit **clone** step before the `renv::restore()` that depends on it, a non-renv
  `install.packages` fallback (`:79-84`), a dataset fallback for R < 4.5 (`:27-47`), and a font
  pre-warm so I'm not fetching Google fonts on conference wifi (`:95-107`). I know exactly what to do
  before I arrive.
- **The scary words are defined the moment they appear.** Typst ("a modern typesetting system that
  ships inside Quarto — no LaTeX"), CSL ("Citation Style Language — decides how citations are
  formatted"), WYSIWYM, the `#|` "hash-pipe", `output-dir`, OJS, Shinylive — all glossed inline, not
  assumed. "YAML header", not "front matter", throughout — friendlier.
- **The Day-2 callbacks are all true — I checked each against Day 1.** Header-vs-cell precedence
  (Day-1 `#execution:374-398` → Day-2 `#metadata:104`), `_brand.yml` (Day-1 `#brand` → Day-2
  `#brand:194`), and the freeze teaser (Day-1 `#execution:400-401` "that's the Day 2 story" → Day-2
  `#freeze:269` "Day 1 I teased freeze — here's the full story") are matched pairs. `@sec-` is
  correctly introduced as **new** on Day 2 (`#xrefs:173`, "Section headings work the same way")
  rather than claimed as something I saw yesterday — Day 1 only ever taught `@fig-`/`@tbl-`/`@eq-`.
  Nothing made me doubt my memory.
- **The labs get the inline-code syntax right**, so the exercise I actually type is correct even
  though the slide isn't — `starter.qmd:29`, `penguins-report.qmd:33`.
- **The 1-hour gap can't strand me.** Both Part-2s open with a one-line "welcome back" and both labs'
  *Starting point* callouts hand me a known-good file (`labs/quarto/index.qmd:159-164` → `starter.qmd`;
  `labs/quarto-projects/index.qmd:140-144` → `solution/`). If I fall behind I rejoin clean.
- **The `cd starter/` trap is impossible to miss** — a full paragraph (`labs/quarto-projects/index.qmd:42-48`),
  a slide aside (`slides/quarto-projects/index.qmd:89-92`), and two troubleshooting bullets. As the
  person most likely to render from the wrong directory, I'm covered.
- **Every challenge tells me what "done" looks like** — the *You should see* callouts and target
  figures mean I'm never guessing whether I succeeded.

## 📝 Evolution since the previous review

- **The fixes from the 2026-07-17 cycle all land for me.** `#xrefs` now introduces `@sec-` as new
  (I verified Day 1 never taught it), `#metadata` bridges cleanly from Day-1 precedence, the freeze
  split into `#freeze` (concept: cache vs freeze) + `#freeze-workflow` (the edit→render→commit loop)
  reads clearly and the teaser/payoff pair is intact, publishing is framed positively as a watch-me
  demo (the auth-cliff rationale sits in notes, not on my slide), and **"capstone" is gone from every
  participant-facing file** (grepped: none) — "team project" reads naturally to an international
  cohort like me.
- **Already solid and still solid:** the setup page, the first-use glossing, the folded self-check
  solutions, and the cwd-trap documentation all held. The one thing this cycle surfaces
  (`inline_expr`) is a longstanding slide defect no prior beginner review had caught, not a
  regression.

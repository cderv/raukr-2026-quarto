# Beginner fix-verification — participant seat (2026-07-21, scope `fixverify`)

_Fictional stance: experienced R + tidyverse, life-science, dabbled in R Markdown, never built a
Quarto project. This is a **verification pass** on the 2026-07-20 fix batch (baseline `6a910a5` →
`356e840`, commits `703e19d` + `356e840`), not a full re-walk. I re-walked each changed passage in
context: Day-1 slides (#anatomy, #inline-code, Learning Outcomes), the two Day-1 lab files, the
Day-2 slides (freeze / CI / cross-page link / wrap-up bullets), the Day-2 lab (brand YAML, stretch
step, freeze wording), and `setup.qmd`. For the inline-code fix I checked the **rendered output**
(fresh `quarto render` of `slides/quarto/index.qmd` and `labs/quarto/starter.qmd`, plus the
committed `_freeze/` results), not just the source._

Dispositioned items from 2026-07-20 (presenter-judgment deferrals, `sample-typst.qmd` legacy inline
form) were not re-examined.

## Overall verdict

The fix batch lands. The one thing that would have actively misled me — the inline-code slides
showing `knitr::inline_expr(...)` — is now correct in the **rendered** deck: both #anatomy and
#inline-code display the literal `` `{r} nrow(penguins)` `` I should type, and the executed form
prints the live **342**; the labs execute the same braced form cleanly (I checked the final HTML,
including the species list, which renders as plain "Adelie, Chinstrap, and Gentoo"). The CI gloss,
the dead `#sec-model` anchor, the flow-style brand YAML, and the freeze wording are all improved.
What's left is residue, not defects: the CI gloss sits one slide *after* CI's first on-slide use,
and the freeze slide's YAML comment still says "the sane default" right above prose that now
carefully avoids calling it a default. I'd sail through both days on this material.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

None. Nothing in the delta blocks or misleads me; the two residues below are P2.

## 🟡 P2 — nice-to-have

**1. "The sane default" survives in the YAML comment the prose fix sits under.**
`slides/quarto-projects/index.qmd:285` — the code block still reads
`freeze: auto        # re-execute a document only when its source changes (the sane default)`
while the very next paragraph (`:288`) was deliberately reworded to "That's `freeze: auto`, the
sane setting to adopt" (the 2026-07-20 fix, replacing "the default"). Reading the slide top to
bottom I hit "the sane default" first and "the sane setting to adopt" second, and briefly wonder:
*is* it the default (so why am I writing it?) or a setting I must add? Behaviorally I'm fine — the
slide and the lab (`labs/quarto-projects/index.qmd:152-156`, whose comment is clean: "re-execute a
document only when its own source changes") both tell me to add the block, so I add it. But the
exact ambiguity the wording fix targeted still sits one line above the fixed sentence. Aligning the
comment (e.g. "the setting to adopt") finishes the job. (Presenter note `:332` also says "the sane
default" — notes-only, harmless.)

**2. The CI gloss lands one slide after CI's first on-slide appearance.**
The gloss "*(the automated build that runs on every push)*" was added at
`slides/quarto-projects/index.qmd:316-317` (#freeze-workflow) — but the first slide-body use of
"CI" is the slide *before*: `:277` (#freeze) "commit it and **CI** rebuilds with **no R at all**",
still bare. On the day the presenter note `:296` covers it verbally; revising from the deck alone I
meet one unglossed "CI", then the definition on the next slide — a big improvement over before
(every later use, `:355`, `:372`, now reads fine), but the parenthetical belongs on `:277`. Same
residue in the lab: `labs/quarto-projects/index.qmd:24` ("Publishing to GitHub Pages / CI is a
**watch-me demo**") is the lab's first "CI" and is read at Part-1 lab start, before any gloss —
though since it only tells me what I *won't* do, it never blocks me.

## ✅ What reassures me (verification detail per fix)

- **Inline code — verified in the rendered output, both directions.** The double-brace escapes on
  the source side (`slides/quarto/index.qmd:154`, `:296` — `` `{{r}} nrow(penguins)` ``) render in
  the built deck as the literal single-brace `` `{r} nrow(penguins)` `` on both #anatomy and
  #inline-code (fresh render of `_site/slides/quarto/index.html`, confirmed by inspection), and the
  single-brace form at `:301` executes to "We measured **342** penguins" — so the slide now shows
  me *exactly* what to type **and** what I'll get. The rewritten #inline-code slide (`:291-305`) is
  also better teaching than before: syntax block, then the rendered sentence, then the payoff line
  ("The number updates when the data does").
- **Labs execute the braced form cleanly.** `labs/quarto/starter.qmd:29-30` and
  `labs/quarto/penguins-report.qmd:33-34` now use `` `{r} nrow(penguins)` `` etc.; the committed
  `_freeze/` results and a fresh render both give "We measured **342** penguins of 3 species —
  Adelie, Chinstrap, and Gentoo" — I checked the final HTML specifically because the intermediate
  frozen markdown shows escaped commas (`Adelie\,`); they render as plain commas. No silent trap.
  Slides and labs now teach/model **one** inline idiom — the contradiction from my last review is
  gone.
- **The dead anchor is gone and slide↔lab vocabulary agrees.** `slides/quarto-projects/index.qmd:181`
  now shows `[analysis page](analysis.qmd)` — copy the pattern and it works, since the lab project
  really has an `analysis.qmd`. The lab's new stretch step (`labs/quarto-projects/index.qmd:91-96`)
  is the same pattern (`[the analysis](analysis.qmd)`) plus a within-page `@tbl-means` — and
  `starter/analysis.qmd:30` really carries `#| label: tbl-means`, so the reference resolves. The
  step names *why* each works ("share **one page** (exactly as yesterday)" / "across pages …
  a link is how you connect website pages") — I can follow it without a helper, and the "You should
  see" (`:100-107`) tells me what done looks like (live Table 1 + a plain link).
- **The callbacks the edits touched are still true.** "exactly as yesterday" on the stretch step
  and "exactly as on Day 1" on #xrefs (`:172-173`) both point at things Day 1 actually taught
  (`@fig-`/`@tbl-` on #figures/#tables). The Day-2 outcome now promises "**within-page**
  cross-references" (`slides/quarto-projects/index.qmd:32`) — honest scoping that #xrefs then
  delivers; no over-promise of cross-page numbering.
- **The brand YAML is now block-style and identical in slide and lab.**
  `labs/quarto-projects/index.qmd:78-89` matches `slides/quarto-projects/index.qmd:202-212`
  line for line — the old flow-style `{ teal: "#4C979F" }` / `[{ family: … }]` I'd have mistyped
  is gone, and I can diff my file against either source.
- **"Hard-freeze CI mode" → "the CI mode"** (`labs/quarto-projects/index.qmd:181`) drops a compound
  jargon term I'd have stumbled on; by the time I read that hint the slide has glossed CI.
- **Small reusability/wording edits all read fine at my seat:** "a collaborator who won't open R"
  (`slides/quarto-projects/index.qmd:418`), "no R at all" / "no R needed in CI" replacing
  "runner" (`labs/quarto-projects/index.qmd:173`, `slides/quarto-projects/index.qmd:372` — "runner"
  was one more undefined infra word), the trimmed Day-1 outcome (`slides/quarto/index.qmd:40`), and
  "conference Wi-Fi" on `setup.qmd:98` (pure spelling; my setup path is unchanged and still clear).

## 📝 Evolution since the previous review (2026-07-20)

- **My one P1 is fixed and verified end-to-end** — the `inline_expr` display defect on both slides
  is gone from the rendered deck, and the fix went the right way (teach the braced portable form,
  escape with double braces to show it literally) rather than just patching the display.
- **Both P2s I raised were addressed:** CI now has an on-slide gloss (residue: one slide late —
  P2 #2 above), and the `#sec-model` dead anchor is replaced by a link that works — plus the lab
  gained a stretch step that turns that slide's rule into something I actually do.
- **The 2026-07-20 P2 #4** (wrap-up overclaiming `_metadata.yml`) was presenter-judgment /
  untouched by this batch — not re-examined per scope.
- **Nothing regressed for me.** The setup page, the lab chaining, the `cd starter/` trap coverage,
  and the Day-1↔Day-2 teaser/payoff pairs all still hold where the edits brushed against them.

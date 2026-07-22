# Beginner review — WP1 Day-1 deck `slides/quarto/index.qmd`

- **Date:** 2026-07-07
- **Reviewer role:** simulated RaukR participant — fluent R user (dplyr/ggplot2, writes
  functions), **new to Quarto** beyond having *seen* R Markdown.
- **Scope:** ONLY `slides/quarto/index.qmd` (WP1, uncommitted). Reference commit `31cae8e`.
  Lab is a TODO skeleton — out of scope.
- **Method:** walked the deck slide-by-slide, chronologically, as if sitting in room B27 with
  no Google, one instructor, TAs roaming.

---

## Overall verdict

I would make it through the day. The arc is clear and motivating — "one `.qmd` → a
branded, cited PDF manuscript" is a payoff I *want*, and the deck mostly earns it. The live
code slides show full, runnable ggplot/gt code (`echo: true`), so I can follow the reasoning,
and the two "Your turn" callouts hand me off to the lab cleanly with a regroup time. Two
things would trip me on the day: **"Typst" is waved at me five times before anyone tells me
what it is**, and the **"Follow along" invitation assumes a setup (libraries + the penguins
NA-filter) that never appears on a visible slide** — so if I actually open my editor and type
along, my first figure chunk fails. Neither is fatal, both are cheap to fix. No P0.

Counts: **P0: 0 · P1: 2 · P2: 8**

---

## 🔴 P0 — blocking for the event

None. Nothing hard-stops a participant.

---

## 🟠 P1 — fix before the event

### P1-1 · "Typst" is used 5× before it's defined (rule-7 gloss)
`index.qmd:32`, `:52`, `:79`, `:288`, `:296` name Typst; it is first **defined** only at
`index.qmd:352-354` ("**Typst** is a modern typesetting system that ships inside Quarto").

- `index.qmd:32` — *"turn it into a **cited, branded Typst PDF** — no LaTeX."*
- `index.qmd:52` — *"a **branded PDF via Typst** — a real manuscript, no LaTeX toolchain."*
- `index.qmd:79` — diagram node *"PDF / Typst or LaTeX"*.

From my seat, "Typst" reads as a mystery brand for the whole first half. The "no LaTeX"
context is a *hint* (so I guess "some PDF thing that isn't LaTeX"), but I spend Part 1
half-wondering. Rule 7 explicitly lists Typst as must-gloss-on-first-use. A four-word
parenthetical at `:32` or on the "What you can now build" slide (`:52`) — e.g. *"Typst (a
modern PDF engine bundled in Quarto, no LaTeX)"* — removes the itch and costs nothing.

### P1-2 · The "Follow along" path has a hidden setup — my first chunk will fail
`index.qmd:114` invites me in: *"Open your editor and render as we go — from here on we're
building one document together."* But every prerequisite lives in an **`include: false`**
chunk I never see:

- `index.qmd:16-24` — `library(dplyr)`, `library(ggplot2)`, `library(gt)`, `data(penguins)`,
  and crucially `penguins <- penguins |> filter(!is.na(bill_len), !is.na(bill_dep))`.

The Anatomy slide (`:92-106`) shows a `.qmd` skeleton (`title`, `format: html`, one fig
chunk) but **no `library()` calls and no data load**. So when I dutifully type the first
figure chunk from `:130-140`, on my machine `ggplot()` isn't found (ggplot2 not loaded) and,
once it is, the un-filtered `penguins` throws "removed N rows containing missing values"
warnings the presenter's copy doesn't. For a room told to "build one document together," a
**visible starter chunk** — the three `library()` lines + the NA-filter, shown once right at
the "Follow along" callout — is the difference between typing along and falling behind while a
TA untangles it. (Locked "self-contained live code" argues *for* showing it, not hiding it.)

---

## 🟡 P2 — nice-to-have

### P2-1 · The equation code doesn't match the equation shown
`index.qmd:162-166` shows the source as
`\text{ratio} = \frac{\text{bill\_len}}{\text{bill\_dep}}`, but the rendered equation right
below at `:170-172` is `r = \frac{\text{len}}{\text{dep}}`. Different left-hand side,
different variable names. Comparing code-to-output (exactly what a beginner does on a "here's
the syntax → here's the result" slide), I'd think I misread or mistyped. Make the shown code
and the rendered result identical.

### P2-2 · `WYSIWYM` is an unexpanded acronym
`index.qmd:272` — *"The **visual editor** (WYSIWYM) is an **RStudio** feature"*. I know
WYSIWY**G**; WYSIWY**M** ("What You See Is What You **Mean**") is unusual and unexpanded, so
it reads as a typo. Spell it out once.

### P2-3 · `theme_brand_ggplot2()` / `theme_brand_gt()` have no package attribution
`index.qmd:397` — *"The R side (`theme_brand_ggplot2()`, `theme_brand_gt()`) themes your
plots and tables from the same palette."* Named as if I already have them. I'd immediately
ask "from which package? do I install something?" One clause naming the source package (or
"ships with recent ggplot2/gt") closes it.

### P2-4 · Layout is *told*, never *shown* — the one promise I can't see
The Learning Outcome at `index.qmd:31` promises *"lay a document out for a research audience
(page, margin, columns, panels)."* The layout slide `:196-214` then lists margin / outset /
inset / panels as bullets, and its own caveat (`:206-209`) says the model *"does **not**
transpose to revealjs slides."* So on the deck I get a vocabulary list but never *see* a
margin figure or an outset table. That's inherent to the no-screenshots decision, but as a
visual learner I'd value one sentence pointing forward — *"you'll see these live in the
lab"* — so the promise doesn't feel unmet mid-session.

### P2-5 · The concrete end-artifact isn't shown up front
The motivating target — *"We build one document and carry it all the way to a publishable
PDF"* — lives in the **speaker notes** at `index.qmd:35-37`, not on any visible slide. On the
Learning Outcomes slide I get abstract capability verbs. A single on-slide line naming the
payoff ("by the end: a submittable penguins paper as a branded PDF") would anchor the whole
arc for me from slide one. (The wrap-up at `:409-420` mirrors the outcomes well — this is just
about front-loading the *artifact*, not the skills list.)

### P2-6 · "Pandoc + Lua" adds jargon the diagram doesn't need
`index.qmd:66` introduces Pandoc reasonably ("hands Markdown to Pandoc"), but the diagram node
at `:75` reads `Pandoc + Lua`. "Lua" is never mentioned again and means nothing to me; it's
noise in an otherwise clean flowchart. Consider just "Pandoc".

### P2-7 · The "Your turn" links point at `.qmd`, not a resolved page
`index.qmd:281` and `:405` link to `../../labs/quarto/index.qmd`. If the deck is rendered
standalone (the relative `theme.scss` at `:7` suggests it isn't yet a full project) rather
than inside a Quarto project, a `.qmd` link may not rewrite to the built page — and a dead
"Your turn" link mid-session strands 40 people at the exact hand-off moment. Worth verifying
at build time. (Build wiring is tracked separately in `review-2026-07-07-build-gap.md`; the
lab target file does exist on disk.)

### P2-8 · "Zero install" could be over-read
`index.qmd:186-188` — *"Native `penguins` (R ≥ 4.5) means zero install."* True for the
dataset, but the demo also leans on `dplyr`, `ggplot2`, and `gt` (`:19-21`), none of them
base. Watching, this is fine; but a beginner planning to redo it at home might read "zero
install" as covering the whole workflow. A half-clause ("the *data* is zero-install; you'll
still want dplyr/ggplot2/gt") would prevent a surprised `Error: there is no package`.

---

## ✅ What reassures me (beginner's-eye clarity)

- **Learning Outcomes (`:26-32`) mirrored by the "What you can do now" wrap-up (`:409-420`).**
  I know what I'm getting and I get told I got it. Motivating, not patronizing.
- **Live code slides show the *whole* chunk** (`:130-140`, `:151-157`) with `echo: true` — the
  full ggplot and gt pipelines are on screen, so I could reproduce them from the slide alone.
- **Jargon that *is* glossed, is glossed well and on time:** the `#|` "hash-pipe" (`:110`),
  outset/inset defined on first use (`:202-203`), and **CSL** expanded in an aside on the same
  slide it appears (`:331-334`). This is the pattern I wish P1-1 followed.
- **The format caveat callout (`:206-209`)** pre-empts exactly the "why doesn't margin layout
  work on these slides?" confusion I'd otherwise have.
- **Typst pre-flight (`:367-369`)** — "check once with `quarto --version`", floor stated — is
  the kind of concrete guardrail that stops me silently failing at home.
- **The "Your turn" callouts (`:280-284`, `:404-407`)** name the exact lab section
  ("Authoring Challenge"), state the artifact I'll produce, and give a regroup time. Clean,
  unambiguous hand-off — the slide word and the lab word agree.
- **Verified, not a bug:** the `knitr::inline_expr()` calls on the Anatomy (`:98`) and
  Callouts (`:193`) slides render to the *clean* `` `r nrow(penguins)` `` syntax (I knitted a
  minimal repro to confirm), so I see tidy inline-code syntax, not a scary function. Good.

---

## 📝 Evolution since the previous review

This is the **first beginner pass on the actual WP1 deck** — earlier 2026-07-07 beginner
reviews (`review-2026-07-07-scope-beginner.md`, `-nbis-beginner.md`,
`-convention-beginner.md`) reviewed conventions and the NBIS baseline, not this authored
content, so nothing here re-flags them.

**What was already good (carried in from the convention panel):** the mode-marker decisions
land cleanly in this deck — a single "Follow along" `callout-note` at the start of live
coding, "Your turn" `callout-tip`s only at the two lab transitions (no patronizing per-slide
badges), `## Learning Outcomes` open and "What you can do now" close, and no `{{< fa >}}`
timer chrome on the critical path. As a participant, the rhythm reads as respectful of an
experienced audience. The remaining friction (P1-1, P1-2) is about *content gloss and the
follow-along setup*, not the structure.

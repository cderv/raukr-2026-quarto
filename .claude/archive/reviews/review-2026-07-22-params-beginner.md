# Beginner review — Day-1 lab bonus (parameterized reports)

**Scope tag:** `params` · **Reference commit:** bee98ea (2026-07-22)
**Reviewer:** fictional workshop participant (experienced R, new to Quarto projects)
**Focus:** the NEW optional bonus only — `labs/quarto/index.qmd` `## Bonus — one report per
species (optional)`, the new `labs/quarto/penguins-by-species.qmd`, and the `-P key:value` slide
bullet. Everything through the 2026-07-21 fixverify + 2026-07-22 appendix/a11y work is out of scope.

## Overall verdict

As an optional, do-it-alone extra, this lands softly enough that I won't panic — the "(optional)"
heading and "skip if you're out of time" line are unmistakable, and `params` / `asis` are both
glossed the moment they appear. The concept teaches well. But if I actually *try* it during the gap,
two things trip me: (1) I can't tell **which file** I'm supposed to be editing — Tasks 1–4 float
free of any filename, then Task 5 suddenly hard-codes `penguins-by-species.qmd`, the *solution*
file; and (2) unlike the Citations Challenge right above it, the bonus never tells me **where my
rendered output lands**, and it lands in `_site/…` (the file is in the site render list), so I'll
run the command, look next to the source, and find nothing. Neither is event-blocking because the
bonus is self-service, but both will quietly lose the handful of people who attempt it. No P0.

## 🔴 P0 — blocking for the event

None. Nothing in the bonus is broken, and its "optional / skip if out of time" framing means a
confused participant just moves on rather than getting stuck in front of the room.

## 🟠 P1 — fix before the event

### P1-1 · Which file am I editing? Tasks are unanchored, then Task 5 names the *solution* file

`labs/quarto/index.qmd:259-290`. The two earlier challenges are careful about this: the Citations
Challenge opens with a **"Starting point"** box (`:158-163`, *"If you finished the Authoring
Challenge, keep going on your own document. Otherwise open `starter.qmd`…"*) and every command uses
the generic **`your-doc.qmd`** (`:79`, `:196`). The bonus has **no "Starting point" box** and Tasks
1–4 never name a file — they just say *"Declare a parameter … in the header"*, *"filter in your
setup cell"*. Then Task 5 (`:286-288`) jumps to a concrete, different name:

> ```bash
> quarto render penguins-by-species.qmd -P species:Adelie
> ```

That's the **solution** filename. So I'm left guessing: do I add params to *my* Part-1 report? To a
fresh file? Or am I meant to edit the shipped solution? If I built Tasks 1–4 into my own
`your-doc.qmd`, Task 5's command renders the wrong file. Add a "Starting point"-style line ("do this
in your own report, or just open the shipped `penguins-by-species.qmd`") and make Task 5 use
`your-doc.qmd` for consistency with the rest of the lab — or state plainly that the bonus is meant
to be run against the shipped solution.

### P1-2 · Silent trap: filtering to `one` doesn't rewire my existing figure/table/margin cells

`labs/quarto/index.qmd:266-268`. Task 2 has me add `one <- penguins |> filter(species ==
params$species)` to my setup cell. But my Part-1 report's `fig-bill`, `tbl-summary`, and margin-count
cells all reference **`penguins`**, not `one`. Nothing tells me to point them at `one`. So if I do
the bonus on my own report, my plot and table still show **all three species**, yet the "You should
see" box (`:293-296`) promises *"figure caption, and point count are **all** about Adelie"*. That
only comes true in the self-contained solution file (which plots `one` throughout). This is the flip
side of P1-1: the tasks only cohere if I'm using the shipped `penguins-by-species.qmd`, but they're
written as "modify a document." Either say "use the solution file" or add a task step: "point your
figure/table cells at `one`."

### P1-3 · "Where does my output land?" — the `_site/…` trap is unwarned here

`labs/quarto/index.qmd:283-289` vs `:202-204`. The Citations Challenge explicitly warns:

> Where the PDF lands: rendering the shipped `starter.qmd` writes the PDF under `_site/…` (it's in
> the site's render list); a brand-new doc renders the PDF next to its source.

`penguins-by-species.qmd` is **also in the site render list** (`_quarto.yml:23`), so `quarto render
penguins-by-species.qmd -P species:Adelie` writes to `_site/labs/quarto/penguins-by-species.html`,
**not** next to the source. The bonus carries **no equivalent note**. I'll run the command
(succeeds), look in `labs/quarto/` for the HTML, find nothing, and assume I did it wrong. The "You
should see" box describes the *content* but never says *which file to open*. Add the same one-line
"where it lands" note the Citations Challenge has — and, since this is the first place I'm handed a
bare concrete filename to render, say I need to be **in `labs/quarto/`** (or render the full path
from the repo root); nothing states the working directory.

## 🟡 P2 — nice-to-have

### P2-1 · `!expr` gloss is thin, and it's a second mechanism with no "why"

`labs/quarto/index.qmd:279-281`. Task 4 glosses `!expr` as *"evaluate R in a cell option"* — literally
true but terse. The bump is conceptual: Task 3 injects the parameter into a **heading** via
`cat()` + `output: asis`, then Task 4 injects it into a **caption** via `!expr` — two different
mechanisms for "put the parameter into some text," with no word on why the caption can't reuse the
same trick (answer: `fig-cap` is a YAML option, so it needs `!expr`). For an optional bonus this is
tolerable, but one clause — "cell *options* are YAML, so running R there needs `!expr`" — would stop
`!expr` reading as a second piece of magic.

### P2-2 · `cat("## ", params$species, "at a glance\n")` emits a double space after `##`

`labs/quarto/index.qmd:276` and `penguins-by-species.qmd:28`. `cat()`'s default `sep=" "` adds a
space between arguments, so on top of the trailing space in `"## "` the output is `##  Gentoo at a
glance`. It renders as a correct heading (Markdown ignores the extra space), so this is cosmetic — but
a copy-following beginner staring at the raw `cat()` output while debugging might wonder. Harmless;
noting for completeness.

## ✅ What reassures me (beginner's-eye)

- **"Optional" is impossible to miss.** The heading says `(optional)` (`:249`) and the Goal
  blockquote says *"Fully optional, self-service — skip it if you're out of time."* (`:254`). I will
  not panic if I don't reach it. This is exactly right.
- **`params` is defined before it's used** (`:256-257`): *"A parameter is a value declared in the
  YAML that your code can read as `params$…`."* No undefined jargon dropped on me.
- **`output: asis` is explained, not hand-waved — three times.** Task 3 (`:270-271`, *"it writes the
  cell's text output as raw Markdown, so `cat()` becomes a real heading"*), the Hint (`:303-304`,
  *"without it, `cat()` output would show as a printed code result, not a heading"*), and a comment
  in the solution (`penguins-by-species.qmd:26-27`). By the third pass it reads as mechanism, not
  magic. Good.
- **Real-world framing.** *"the 'one QC report per sample / one summary per cohort' pattern"*
  (`:253`) tells me instantly why I'd care — this is the life-science payoff, not a toy.
- **The Hint's defaults caveat is the right one** (`:301`): *"Parameters must have defaults —
  `params$species` has to resolve when no `-P` is passed."* That's the first thing I'd get wrong.
- **The download/open path is consistent** with the Authoring/Citations challenges (`:307-313`) —
  same "open from your cloned `labs/quarto/`, or take the source" + raw-GitHub button pattern I've
  already seen twice, so no new mental model.
- **The slide mention is a clean setup, not an over-claim** (`slides/quarto/index.qmd:457-458`):
  *"The same `quarto render` also takes `-P key:value` … (Optional bonus in today's lab.)"* — it
  name-checks the flag where `quarto render` is already on screen and explicitly points at the lab,
  without pretending to teach it. Exactly the "MENTION" weight the notes call for.

## 📝 Evolution since the previous review

This bonus is net-new content, so there's no prior params review to diff against — but it clearly
inherits the good habits established earlier in this same lab: the glossed-on-first-use vocabulary,
the three-touch explanation of a tricky mechanic (`asis`), the "optional, nobody's stranded" framing,
and the identical download-button pattern. What it did **not** inherit — and should — are the two
things the challenges right above it get right: an explicit **"Starting point"** anchor telling me
which file I'm working in (P1-1), and the **"where does my output land"** `_site/…` note (P1-3). The
bonus reads like it was written assuming I'll render the shipped solution, while its Tasks are phrased
as "build this into your document"; closing that gap (P1-1/P1-2/P1-3 are really one seam) is the whole
fix.

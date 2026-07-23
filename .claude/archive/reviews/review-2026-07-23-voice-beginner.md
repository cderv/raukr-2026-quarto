# Review — 2026-07-23 — house-voice sweep, beginner lens

**Reviewer:** workshop-reviewer-beginner (fictional participant: experienced R user, new to Quarto)
**Reference commit:** b9ccc53
**Scope this cycle:** the full "house voice" sweep (em-dash asides → colon/paren/split, semicolons
removed, voice-over/idiom cut) across `setup.qmd`, both labs, both decks, and the shipped Day-1 demo
files. Primary question: does any rewrite now read *worse* or block a Quarto newcomer? I walked
setup → Day-1 lab → Day-2 lab in order and diffed every edit against its pre-sweep wording.

## Overall verdict

I make it through cleanly, and the sweep did me no harm. I read every edited sentence in the three
files I actually work from, diffed each against the version before the sweep, and none of the
feared failure modes landed: no instruction split into an ambiguous "do X: do Y", no colon that
promises code where only prose follows, no truncated sentence, no cut clause that took away a *why*
I needed. Where a colon replaced an em-dash it introduces the real instruction or a genuine
code/list block every time. The three "Nobody is stranded by the break" removals are pure
reassurance narration — the functional message (open the shipped known-good file and keep going) is
still stated in full right next to where the reassurance used to be, so nothing I needed left with
it. One genuinely awkward phrase survives untouched (see P2), but it predates this sweep and is not
a regression.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

None. Every voice edit in the participant path is neutral-to-better. Spot checks:

- **Day-1 lab Task 2** (`labs/quarto/index.qmd:66-68`) actually got *clearer*: the mid-sentence
  em-dash aside "then — **in the prose, outside the cell** — refer to it" became "then refer to it
  with `@fig-bill` **in the prose, outside the cell**." The instruction now reads left-to-right in
  the order I do it.
- **Day-1 lab Task 3** (`:69`): "your job is the **cross-reference mechanic** — give the cell…" →
  "Your job is the **cross-reference mechanic**: give the cell…". The colon here introduces the
  real sub-steps and a code block follows two lines down. Not a false code-promise.
- **Day-2 "You should see" (freeze)** (`labs/quarto-projects/index.qmd:166-172`): the split of the
  long dash-joined sentence into "…the R cell **skipped** (reused from `_freeze/`), and the …line
  prints the **same** time…" is easier to parse than the original, and the causal chain is intact.
- **The "Nobody is stranded" cuts** (Day-1 Citations Starting point `:168`; Day-2 Scope `:45`;
  Day-2 Ship-it Starting point `:143`): each still tells me plainly I can open the shipped
  known-good file and do the steps there. Reassurance gone, information kept. Good.

## 🟡 P2 — nice-to-have

- **`labs/quarto/index.qmd:12-13` — "with the between-parts break in between."** The doubled
  "between" reads oddly on first pass ("the *between-parts* break *in between*" — in between what?).
  This is **pre-existing**: the sweep only changed the surrounding em-dash to a colon (`one
  document — each…` → `one document: each…`), it did not introduce the doubling. Worth noting the
  Day-2 lab now says the cleaner "with a break between them" (`:23`) for the same idea, so the two
  labs diverge on a sentence that used to rhyme. A one-word trim (e.g. "…each is its own hands-on
  part, split by the break") would fix both the doubling and the drift. Non-blocking.

- **Already on record, not a voice issue:** the same-day run-labs gate
  (`review-2026-07-23-labrun-day1-usecourse.md`) noted Day-1 Authoring **Task 4** ("species counts
  in the **margin**", `labs/quarto/index.qmd:76`) supplies no R code while every neighbour task
  does. Still true after the sweep. Flagging only so it's visible in this pass; it's a pre-existing
  polish finding, not a voice regression, and already recorded.

## ✅ What reassures me (beginner clarity)

- **Colons land on real payloads.** Every colon that replaced a dash introduces either the actual
  instruction, a YAML/code block, or a bulleted list. I never hit a colon and then wait for code
  that isn't there. E.g. Day-1 setup cell intro (`:30`) "Start every document with this setup (the
  challenges below assume it):" is immediately followed by the fenced R cell.
- **Glosses survived.** The sweep cut connectives, not definitions — "colour-blind-safe palette",
  "watch-me demo (publishing needs an account and auth setup…)", "a parameter is a value declared
  in the YAML that your code can read as `params$…`" all still gloss their jargon inline.
- **The swept demo files read cleanly.** `sample-typst.qmd` ("does bill shape tell the species
  apart?** We render the answer as a branded PDF with **Typst**…") and `penguins-by-species.qmd`
  ("…renders one report per species. Change the parameter, not the document.") both split their
  dash-joined sentences without losing the causal link — and these are files I open and read.
- **No French spacing or truncation.** Grepping the three files for ` ?`/` !` in prose returns only
  `!is.na(...)` inside R code (false positives). No stray "see below" with no target, no dangling
  colon, no half-sentence.

## 📝 Evolution since the previous review

- **Improved for me:** the two long dash-chained sentences that used to make me re-read — Day-1
  Task 2's subject-verb-splitting aside and the Day-2 freeze "You should see" — are now linear and
  first-pass readable. The Day-1 Layouts concept slide
  (`slides/quarto/index.qmd`, "The **article-layout model** puts content in the body, the margin,
  or a zone wider than the body (in the paged formats: HTML, LaTeX, Typst):") reads more directly
  than the old parenthetical-inside-dashes version, with meaning fully preserved.
- **Already good, held:** the Starting-point boxes still do their job (pick up from a shipped
  known-good file), the output-location and working-directory notes are all intact, and the
  Troubleshooting bullets kept every diagnostic even as their em-dashes became colons.

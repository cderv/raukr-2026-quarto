# Lab-format review — the DOER's seat (participant, timed bench)

**Date:** 2026-07-21
**Reviewer lens:** workshop participant *doing the lab live* — experienced R user, new to Quarto
projects. ~40 in the room, one roaming TA, a countdown running, eyes flicking between the lab page
and my editor. The question: is our **callout-heavy, "Challenge"-framed** format right, or is NBIS's
**long prose-walkthrough** better — or a hybrid? Judged on *presentation*, not topic choice.

Files walked: `labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd` (ours);
`raukr-nbis/labs/quarto/index.qmd`, `raukr-nbis/labs/quarto-site/index.qmd` (NBIS 2026).

---

## Walking OURS (callout + task-first + folded solution)

**Where I was well-guided.**

- `labs/quarto/index.qmd:52-102` is the single best stretch in either repo for a doer. The triad
  **Tasks → You should see → rendered target picture** answers the three questions I actually have
  under a clock, in order: *what do I type* (Task box, with `#| label: fig-bill` given verbatim so I
  copy not invent), *how do I know I'm done* (`You should see`, lines 81-87), *what does right look
  like* (the rendered `fig-target`, 89-102). I never had to guess the exercise's shape.
- Consistent callout titles become **landmarks**. After the first challenge I knew: the box titled
  *Tasks* is where I type, *Hint* is the click-if-stuck, *Solution* is the fold I peek at. Scanning
  the second challenge I jumped straight to *Tasks* without reading the connective prose. That is the
  payoff of the repeated structure — the format teaches its own navigation in one cycle.
- The **folded solution + collapsible hint** is a real rescue, not decoration. At
  `labs/quarto/index.qmd:113-140` I can open `sol-authoring`, lift the key cells, and be caught up by
  the break without flagging the one TA. NBIS-site has no equivalent (see below) — this is where our
  format concretely saves a straggler.
- `labs/quarto-projects/index.qmd:161-164` (freeze's `cat(format(Sys.time()))` visible tell) is the
  best single doer-affordance in the whole set: it converts "the log shows no compute" — which I'd
  never check mid-task — into a pass/fail I can *see* on the page. Keep this verbatim.
- Nothing I needed while doing was hidden. `You should see` and the target image are **unfolded**
  (correct); only spoilers (Hint, Solution) and the optional R-Markdown aside are folded. The
  collapse keeps the page clean *without* hiding a success gate.

**Where I felt lost / slowed — and it's the format betraying itself.**

- `labs/quarto/index.qmd:8-20` (**Scope**) is prose-in-a-box: ~13 lines including a packages
  paragraph and a data note. Under a countdown I bounce off it — it *looks* like a landmark callout
  but reads like a page of reference, so the one box I hit first is the one that doesn't scan. The
  content is right; the shape is wrong.
- `labs/quarto-projects/index.qmd:33-50` (**Starting point**) is worse — a 17-line wall about
  `cd starter/` and the nested-`_quarto.yml` trap. It *is* load-bearing (the trap really bites), but
  as the second thing I read on Day 2 it stalls me. And the same rationale is repeated in
  Troubleshooting (`:210-212`), so the front box can shrink to the one-liner and point down.
- Minor: the stacked-box rhythm (Scope, aside, Goal, Tasks, You-should-see, Hint, Solution, prose ×2
  challenges) is a lot of boxes. It works *because* titles differ — but two over-long boxes are what
  make it occasionally feel like "all boxes, where's the task."

**On "Challenge" framing:** to an experienced adult it lands as neutral-to-mildly-gamified — not
offensive, not especially motivating. The real motivation is carried by the **Goal blockquotes**
(*"branded Typst PDF — the manuscript payoff, no LaTeX"*, `:158-159`), which name a concrete payoff.
"Challenge" itself is borderline gimmicky but harmless; not worth a churn.

## Walking NBIS (prose reference, read top-to-bottom)

**Where I was lost (as a doer).**

- `raukr-nbis/labs/quarto/index.qmd`: I do not learn *what the exercise is* until **line 592** — the
  `Tasks` callout sits after ~590 lines of reference, and there are only two, both under-specified
  (*"Try to create a new report for versicolor"*). The entire "Report" section (`:471-591`) shows me
  finished code and narrates it, but never says "now you type this." As a doer with a clock, that's
  590 lines of textbook before a starting gun. I'd spend the block reading, not doing.
- `raukr-nbis/labs/quarto-site/index.qmd:22-42` opens with **create a GitHub account, `git clone` over
  SSH** — an auth/setup cliff before a single line of Quarto, exactly the "strand a room of 40" hazard
  our labs deliberately demote to a watch-me demo. My first bench minutes go to git, not Quarto.
- That site lab is a **593-line uninterrupted scroll** with no task markers, no `You should see`
  gates (just scattered screenshots), and — critically — **no folded solution or `solution/` folder**.
  Lose my place and I'm stranded with nothing but more prose to re-read. This is precisely the
  fall-behind scenario our format handles and NBIS's does not.

**Steelman NBIS (it genuinely wins here).**

- **Everything is inline and Ctrl-F-able.** Nothing behind a fold, nothing to click. A fast or
  confident reader self-serves at their own pace and can read ahead — good for a mixed-ability room's
  top end.
- It **doubles as take-home notes.** After the session the NBIS page is a complete reference; our
  terse, folded lab is a worse artifact to re-read cold. (We mitigate this with `penguins-report.qmd`
  and `solution/`, but the NBIS single-page reference is genuinely more browsable later.)
- The **site lab's imperative steps** ("create file X, paste this content", e.g. `:120-149`) are
  individually clear and copy-pasteable — where it *is* a walkthrough, it's a followable one.
- **Zero framing gimmick** — no "Challenge", no stakes language. For an audience that might find
  gamification patronizing, that's a point in its column.

---

## Recommendation — **KEEP ours, TRIM two boxes, do NOT adopt the prose walkthrough**

For a doer under a countdown our format wins decisively on the one metric that matters most —
**"what do I type next?"** — because the answer sits in a titled *Tasks* box with verbatim options,
not at line 592 after a textbook. The folded solution is a real fall-behind rescue that NBIS-site
simply lacks. Don't hybridize toward NBIS's structure; hybridize only by keeping our terse lab
*linked to* a fuller take-home reference (we already do). Concretely:

1. **Keep the callout + task-first + folded-solution format as the spine.** It self-documents its own
   navigation in one challenge-cycle and gives a stranded participant a copy-and-catch-up path the
   NBIS site lab has no answer for. Do not move toward prose-walkthrough: NBIS's two real tasks live
   at `raukr-nbis/labs/quarto/index.qmd:592`, after 590 lines — a doer can't find the starting gun.

2. **Trim the two prose-in-a-box callouts that read as walls under pressure.** Day-1 **Scope**
   (`labs/quarto/index.qmd:8-20`) → three bullets (build / data / packages). Day-2 **Starting point**
   (`labs/quarto-projects/index.qmd:33-50`) → lead with the `cd starter/` one-liner; the full trap
   rationale already lives in Troubleshooting (`:210-212`), so point there. These are the only boxes
   that betray the landmark-callout format by being unscannable — fixing them is what keeps the boxes
   feeling like navigation rather than "all boxes, no task."

3. **Protect the doer-facing affordances that already work — don't let a cleanup erode them.** Keep
   `You should see` + the rendered target **unfolded** (they're the success gate). Keep the Day-2
   `Sys.time()` visible-tell (`labs/quarto-projects/index.qmd:161-164`) — best pass/fail on the page.
   Keep the explicit "fell behind? open `starter.qmd` / `solution/` now" nudges. On **"Challenge"**:
   leave it (the Goal blockquotes carry the motivation); it's mildly gimmicky but not worth churn.

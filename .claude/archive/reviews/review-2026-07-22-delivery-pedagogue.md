# Pedagogy review — exercise-delivery migration (use_course model)

*Scope tag: **delivery**. Reference commit **1a8c757** (2026-07-22). Reviewer: workshop-reviewer-pedagogue.*
*Files under review: `setup.qmd`, `labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd`,
`slides/quarto/index.qmd`, `slides/quarto-projects/index.qmd`. Design: `.claude/plans/2026-07-22-exercise-delivery.md` §5.*

## Overall verdict

Pedagogically ready to ship after one P1 fix. The new obtain → open → work → reset flow is a
**net cognitive-load reduction** for the target cohort: the nested-project trap is gone
structurally (no more "author inside a website repo", no `cd starter/` caveat), so the Day-2 lab
now opens with a *positive* "here's a shipped set of pages" framing instead of a defensive
warning — a clean simplification win. "Nobody is stranded by the break" still holds on both days
because starters and solutions are now **local** (`day1-intro/starter.qmd`, `solutions/day2/`),
which is actually *more* robust than the old click-to-preview model. The one thing missed by the
migration is a stale presenter note that still describes the deleted `_site/` output split — it
now misdirects roaming helpers and must be corrected. One genuine UX casualty (the in-browser
branded-PDF payoff-preview) is worth a cheap mitigation but is not blocking.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

**1. `slides/quarto/index.qmd:677` — stale helper note describes an output split that no longer exists (false in-room guidance).**
The Citations-Challenge helper note reads: *"'Where's my PDF?' is usually the output-location
split — the shipped `starter.qmd` renders under `_site/…`, but a brand-new doc renders next to its
source."* Under the new model there is **no `_site/` above `day1-intro/`** — both `starter.qmd`
and `my-report.qmd` render next to their source, which is exactly what the lab now teaches
(`labs/quarto/index.qmd:210`: *"there's no project folder above to redirect it, so `starter.qmd`
gives `starter.pdf`"*). A roaming helper reading this note will send a stuck participant to look in
a `_site/` folder that doesn't exist. Per the multi-day/callback discipline a *false* pointer is
worse than none. Fix: the answer to "Where's my PDF?" is now uniform — *next to the source, inside
`day1-intro/`* — the split is gone.

## 🟡 P2 — nice-to-have

**2. `slides/quarto-projects/index.qmd:394` — helper note points at the old `solution/` folder name.**
*"Behind? Open the shipped `solution/` project and start from there."* The delivered folder is
`solutions/day2/` — which the sibling handoff note at `slides/quarto-projects/index.qmd:251` and
the lab (`labs/quarto-projects/index.qmd:45,144`) both name correctly. A helper following line 394
looks for a `solution/` folder that isn't there. Align to `solutions/day2/`.

**3. Lost in-browser payoff-preview of the branded Typst PDF — the one real UX casualty (`labs/quarto/index.qmd:213-218`).**
This *is* a mild pedagogical loss and worth flagging. The HTML target is still shown inline as a
live figure (`fig-target`, line 107) — good goal-visibility. But the marquee Day-1 payoff, the
**branded Typst PDF**, now has only a prose "You should see" description; the four Day-1 files left
the site render list, so participants can no longer click to *glimpse the destination* before
committing effort. For adult learners, seeing the "wow" artifact up front is a real motivator
("build something you'll actually use"). Cheap mitigation that keeps the file off the render list:
embed a **static screenshot** of the finished branded PDF in the Citations-Challenge "You should
see" block. Restores the target-preview without reintroducing any render dependency.

**4. Day-1 slide surface never names `day1-intro/`; the folder orientation lives only in the lab.**
The first Follow-along (`slides/quarto/index.qmd:171-172`) says *"Open your editor"* generically;
the "open the `day1-intro/` folder" step-0 orientation is carried entirely by the lab
(`labs/quarto/index.qmd:24-28,63`) and Setup. Low risk — lab Task 1 is explicit and every "Your
turn" routes to the lab — but a participant driving from the slides alone could create
`my-report.qmd` in the wrong place. The planned IDE "you are here" screenshot (plan §5; build-order
step 8, ~Aug 1) will close this; noting so it isn't forgotten. Day-2 handles this better —
`slides/quarto-projects/index.qmd:91,95` name `day2-projects/` on the slide surface.

## ✅ Pedagogical strengths confirmed

- **`setup.qmd:84-95` — the "Open the *day folder*, not the top folder" callout-important is exactly the right scaffolding.** It isolates the single new spatial concept, gives the concrete double-click target per day, and explains *why* (own working dir, output lands next to files, no capturing parent). For experienced-R users this is low load and well-placed.
- **Nested-trap removal is a clean cognitive-load win, not a gap.** The Day-2 lab now opens with "Starting point — a shipped set of pages" (`labs/quarto-projects/index.qmd:33-45`) as positive framing; the deleted `cd starter/` / root-render machinery left **no** confusing hole — the residual Troubleshooting note (`:206-209`) is now benign "where's my HTML" help, not trap-defense.
- **"Nobody stranded by the break" holds locally on both days.** Day-1 Citations start-point → `day1-intro/starter.qmd` (`labs/quarto/index.qmd:167-170`); Day-2 Ship-it start-point → `solutions/day2/` (`labs/quarto-projects/index.qmd:141-145`). Both are shipped in the download — a straggler with flaky Wi-Fi needs no re-fetch.
- **Reset ergonomics are sound and honest** (`setup.qmd:97-108`): re-run `use_course()` for a fresh numbered folder (old attempt preserved) or unzip the kept ZIP, plus a browser Plan-B. "Get a fresh copy, don't unzip over your working copy" is the right instinct to teach.
- **Day-2 self-seeds** (`labs/quarto-projects/index.qmd:33-45`): `day2-projects/` is independent of any Day-1 artifact, so a fresh Day-2 arrival is not blocked — the multi-day robustness requirement is met.
- **Multi-day sequencing is well handled.** Day-2 opens with a true bridge (`slides/quarto-projects/index.qmd:29` "Yesterday: one `.qmd` → a branded PDF. Today, the other axis"), "How today works" is correctly trimmed to a one-breath recap (`:43-53`, note "Quick recap, don't re-teach"), and the identical obtain-UX is compressed to one sentence per the plan's intent — the "open the right folder" orientation lands without patronizing.

## 📝 Evolution since the previous review

- **Improved:** the fragile in-place authoring model (author inside the course-website repo, with a
  mandatory `cd starter/` and a "don't render from the root" warning) is gone. Wrong-folder work is
  now *benign* (a local render on the Desktop, not a foreign `_site/`), and the delivery UX is
  unified across both days.
- **Already good, preserved:** inline `fig-target` HTML previews, the folded/`code-fold` solution
  self-check idiom, the "manuscript → team-project" through-line, and the Day-2 bridge/recap
  discipline all survived the migration intact.
- **Regressed (one item):** the output-location split that the old nested model required is deleted
  everywhere *except* one leftover presenter note (`slides/quarto/index.qmd:677`) that still tells
  helpers to look under `_site/…` — the P1 above. A second cosmetic straggler is the `solution/` vs
  `solutions/day2/` folder-name drift (P2 #2). Both are last-mile grep misses from an otherwise
  thorough migration.

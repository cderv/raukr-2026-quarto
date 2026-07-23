# Beginner review — margin "Quarto docs" pointers, copyable solutions, trimmed Scope

**Reviewer:** beginner participant (experienced R, new to Quarto)
**Date:** 2026-07-23
**Reference commit:** c7d97e3
**Scope:** ONLY the three delta items — right-margin "Quarto docs" notes, the collapsible
Solution callout with real copyable code, and the Scope box that now points at the Setup page
instead of listing packages. Everything else was reviewed earlier the same day and is out of scope.

Method: read both labs, rebuilt/inspected the committed `_site`, and screenshotted the rendered
pages with playwright at 600 / 700 / 800 / 1100 / 1600 px to check reflow of the `.column-margin`
asides and the left TOC.

---

## Overall verdict

This delta is a clean win for me and nothing in it blocks the day. The margin "Quarto docs" notes
point at exactly the right official page for the task in front of me (cross-references + article
layout beside the Authoring challenge, citations + Typst beside the Citations challenge, and so on),
and at narrow widths they reflow sensibly — they drop inline right between the challenge Goal and the
Tasks callout, which is the moment I'd be reaching for help. The TOC on the left doesn't throw me;
if anything it feels more like RStudio/most docs sites than the old right-hand TOC. The Solution
callout now holds real fenced `yaml`/`markdown`/`bash` with working copy buttons, so I can finally
lift the code instead of hand-cleaning commented-out R. My only reservations are small (P2):
on a desktop the margin note is anchored to the top of the challenge and scrolls out of view by the
time I'm deep in a task, and the trimmed Scope leans entirely on my having actually done the Setup
page.

---

## 🔴 P0 — blocking for the event

None.

---

## 🟠 P1 — fix before the event

None.

---

## 🟡 P2 — nice-to-have

**1. On desktop the margin pointer scrolls away before I'm actually stuck.**
`labs/quarto/index.qmd:60-64` places the "Quarto docs" aside next to the challenge **Goal**, i.e. at
the very top of the section. At ≥1200px it renders in the right margin aligned to the Goal
blockquote (confirmed in the 1600px shot). But it's anchored there — by the time I'm fumbling task 3
(`the cross-reference mechanic`) or task 5 (the equation), the note has scrolled off the top of the
viewport. The help link is furthest away exactly when I'd want it. This is only a real issue on wide
screens (at ≤700px it reflows inline just above the Tasks, which is well placed). Low-cost options if
you care: leave it as-is (it's one short section), or move the aside to sit beside the **Tasks**
callout rather than the Goal so it tracks the work. Not worth much effort — the challenges are short
enough that a scroll-up is cheap.

**2. Trimmed Scope is fine only if I really ran Setup — one belt-and-braces line would close the
gap.** `labs/quarto/index.qmd:19-20` and `labs/quarto-projects/index.qmd:30-32` now say *"Before you
start: run through the Setup page … Its `00-check-setup.R` confirms R, Quarto, and the packages this
lab uses."* If I did the Setup page I'm fully covered (all nine packages installed), so the trim is
the right call. The only person it strands is someone who skipped Setup and lands cold on the lab —
the setup code cell at `labs/quarto/index.qmd:31-41` then throws `there is no package called 'gt'`
(or `ggokabeito`) with no in-lab hint of what to install. The Troubleshooting box does catch this
(`Missing package? install.packages(...)`), so it's a soft landing, not a wall. Optional: the "You
should see" / Troubleshooting already cover it; no change strictly needed.

**3. The Accessibility box link stays inline while the rest moved to the margin — minor
inconsistency.** `labs/quarto/index.qmd:99-101` keeps *"See Quarto's accessibility docs"* as an
inline link inside the "Make it accessible" callout, whereas the challenge-level help now lives in
the margin note. Not confusing (the accessibility box isn't a numbered challenge), but if the pattern
is "official-doc pointers live in the margin," this one is the exception. Leave it if intentional.

---

## ✅ What reassures me (from a beginner's seat)

- **The links point at the *right* page every time.** I spot-checked all nine: Cross-references +
  Article layout for the figure/table/margin/equation tasks; Citations + Typst for the cite/PDF
  tasks; Parameters for the bonus; Websites + Brand for the site build; Freeze (deep-linked to the
  `#freeze` anchor) + Publishing for "Ship it." No mismatch, no placeholder `(#)`, no link pointing
  at a generic landing page when a specific one exists.
- **The narrow-width reflow is exactly what I'd want.** At 600–700px the `.column-margin` note drops
  out of the margin and lands inline directly below the Goal and above the Tasks callout
  (`narrow-top-d1.png`, `verynarrow-d1.png`) — it doesn't overlap, clip, or vanish. At 800px it still
  sits cleanly in the right margin without collision. So whether I read the lab full-screen or in a
  half-width window next to RStudio, the pointer is somewhere sensible.
- **The left TOC behaves.** At desktop the "On this page" list sits alone on the left with the four
  section links, no collision with anything (`wide-d1-top.png`); at ≤700px it folds into the navbar
  hamburger and gets out of the way. Having navigated with it, left-vs-right made no difference to me
  — it reads as normal.
- **I can finally copy the solution code.** Both Solution callouts render (`Solution: the header and
  the cite`, `Solution: the freeze block and the render flow`) with real fenced `yaml`/`markdown`/
  `bash`/`r` blocks, each carrying the standard Quarto copy button (23 copy buttons on Day 1's page,
  13 on Day 2's). One click, clean paste — a genuine improvement over the old commented-out R I'd have
  had to un-comment by hand.
- **It's obvious it's a solution and that I should try first.** The blue collapsed callout titled
  literally "Solution: …" with a chevron reads unambiguously as "expand me after you've had a go."
- **The `.column-margin` label is self-explanatory.** `{{< fa book-open >}} **Quarto docs**` with the
  book icon tells me at a glance these are the official docs for when I'm stuck — no jargon, no
  guessing what the aside is for.

---

## 📝 Evolution since the previous review (same-day baseline)

- **New and good:** the per-challenge margin "Quarto docs" notes didn't exist before; they give me a
  first move when I'm stuck that isn't "ask the one instructor" — and they're targeted, not a generic
  "see the Quarto docs."
- **Fixed for me:** solution code is now copyable. The earlier commented-out-R form was a real
  friction point for a beginner (you copy it and then have to strip `#` off every line); the fenced
  `yaml`/`bash` blocks with copy buttons remove that entirely.
- **Trimmed sensibly:** the Scope no longer double-maintains a package list that could drift from the
  Setup page; pointing at Setup is the single source of truth. Confident as long as I ran Setup.
- **Already solid, unchanged:** the Troubleshooting boxes still catch the "missing package" case, so
  the Scope trim doesn't leave a hard edge.

# Pedagogy review — WP1 Day-1 deck (`slides/quarto/index.qmd`)

- **Date:** 2026-07-07
- **Reviewer:** workshop-reviewer-pedagogue
- **Scope:** ONLY `slides/quarto/index.qmd` (Day 1 "Introduction to Quarto", 2 parts). Lab is a
  TODO skeleton — out of scope.
- **Reference commit:** 31cae8e (deck itself uncommitted/just authored)
- **Session:** RaukR 2026, in-person, ~40 experienced R users / life-science researchers,
  basic Quarto familiarity, "level up". Two ~1h parts with a gap, ~2:1 hands-on. Budget per part:
  ~5 min frame + ~18-20 min talk+demo + ~30 min hands-on + ~5 min recap. Slots are upper limits.

---

## Overall verdict

Pedagogically this is a strong first draft: the aspiration reframe (rule 5), the named
manuscript/capstone transfer (rule 6), the `## Learning Outcomes` → "What you can do now" bookend,
and a single penguins through-line are all in place, and both parts reach a real hands-on payoff.
The learning design is sound. The one blocking-adjacent problem is **budget asymmetry**: Part 1
carries ~11 content slides (incl. two beats — Execution options, Positron — that the topic-store
budget does not fund) into a ~15-20 min window, while Part 2 is correctly lean. This is a
V3-budget overflow in Part 1 and needs a cut *from the list*, not the exercise. Two locked-rule
gaps remain (Your-turn-2 doesn't name its lab Challenge; the "your Part-1 document" framing
ignores the rule-2 fallback). None is a true P0 for slide-readiness. Fix the P1s and this deck is
ready to stand in front of the room.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

### P1-1 — Part 1 talk+demo overflows the budget; cut two beats from the *list*
`slides/quarto/index.qmd:44-276`. Between the "Part 1" section header and "Your turn" there are
**11 content slides**, several carrying live code to render:
What-you-can-build · How-it-works (mermaid) · Anatomy · Markdown&content · Figures&cross-refs ·
Tables&math · Callouts&inline · Layouts · One-source→many · **Execution options** · **Editor &
Positron**. The topic-store budget (`topic-store.md:292-299`) funds the ~15-min concept+demo
window with only "Markdown deltas · Layouts · doc types". **Execution options (`:243`)** and
**Editor & Positron (`:261`)** are extra beats the budget does not carry. At ~15 min this is
<90 s/slide with zero demo slack — it will not land in ~18-20 min. Per the "cut from the list, not
the exercise" rule and the topic-store's own guidance ("Positron DEMO → MENTION is the first thing
to compress"; Execution = deltas that fold into the figures/callouts demo):
- **Fold Execution options (`:243-259`)** into the Figures/Callouts demo — `echo`/`warning`/
  `fig-cap` already appear on `:132-136` and `:186-194`; drop the standalone slide.
- **Compress Editor & Positron (`:261-276`)** to a one-line MENTION (another guest instructor covers the IDE).
- Optionally tighten Anatomy (`:88`) — the audience knows chunks; keep only the hash-pipe/native
  point.
This is the V3 budget check: **Part 1 overflows, Part 2 is fine.** Fixing it protects the 30-min
Your-turn.

### P1-2 — "Your turn 2" doesn't name its lab Challenge (rule 9 half-applied)
`slides/quarto/index.qmd:404-407`. Rule 9 (`topic-store.md:359-363`) requires the "Your turn"
slide to point at the lab's `## … Challenge` **by the same name**. Your-turn-1 does this correctly
— "start at the **Authoring Challenge**" (`:281`). Your-turn-2 says only "Back to the **Lab**: add
citations… render… as a branded Typst PDF" with **no Challenge name**. Add a same-name pointer
(e.g. "start at the **Citation & Typst Challenge**") so the slide↔lab vocabulary is consistent.
The lab is a skeleton, so the canonical name is TBD — but the deck should still carry a Challenge
name for parity and to force the lab to match it.

### P1-3 — "your Part-1 document" strands anyone who didn't finish (rule 2)
`slides/quarto/index.qmd:292` ("You have a clean HTML document") and `:405` ("add citations to
**your Part-1 document**"). Rule 2 (`topic-store.md:337-339`) is explicit: because of the
between-parts gap, **Part 2 must open from a shipped starting point, not "your Part-1 file".** The
slide language presumes continuity and offers no fallback. Since Part 2 is meant to stand somewhat
alone, reword to reference a **shipped known-good starter** ("open the Part-2 starter — or your own
Part-1 file if you finished it"). The starter itself lives in the lab (out of scope here), but the
slide wording is in scope and currently violates the rule.

## 🟡 P2 — nice-to-have

### P2-1 — Part 2 has no "Follow along" transition marker
`slides/quarto/index.qmd:286-402`. Part 1 marks the watch→follow transition with a "Follow along"
callout (`:114`). Part 2 goes frame → Citations (live demo) → … → Your turn with **no** such
marker. Since Part 2 stands alone after the gap, add one `::: {.callout-note title="Follow along"}`
at the first Part-2 demo beat (Citations, `:303`) so the follow-along cue is symmetric across
parts. Rule 9 marks *two* transitions per part; Part 2 currently marks only one.

### P2-2 — Your-turn slides carry no presenter notes for in-room support
`slides/quarto/index.qmd:278-284` and `:402-407`. Neither "Your turn" slide has a `::: notes`
block anticipating traps for roaming helpers (e.g. Part 1: `fig-`/`tbl-` prefix required for
cross-refs, label collisions, `@ref` renders `?@` on a missing label; Part 2: Typst Google-font
fetch needs network, `.bib` key must match `@key`, CSL↔Typst bibliography edge cases). Most
hint/solution material will live in the lab (out of scope), but a 2-3 line presenter note on each
Your-turn slide gives helpers a fast pointer during the 30-min exercise. Other slides model this
well (`:211-214`, `:256-259`, `:371-374`).

### P2-3 — "Tables & math" packs two new features on one dense slide
`slides/quarto/index.qmd:145-174`. A two-column slide with a live `gt` + `fmt_number` table on the
left and display-math + `{#eq-ratio}` cross-ref on the right is two distinct new concepts at once —
a load spike for the 2:1 pace. Math is a justified CORE-delta for this audience, but consider
giving it a beat that doesn't share the slide with tables, or presenting one column at a time
(the `output-location: fragment` on `:153` helps the table side). Watch-for, not blocking.

## ✅ Pedagogical strengths confirmed

- **Aspiration reframe (rule 5) landed.** `:44` "What you can now build" + notes `:60-61`
  explicitly flip Rmd++ reassurance to "here's what you can build". `:26-32` Learning Outcomes are
  learner-framed infinitives.
- **Capstone/manuscript transfer named, not implied (rule 6).** `:288` "The manuscript path",
  `:292` "make it a **paper**", `:301` "your **capstone** write-up", `:301` "your manuscript path".
- **Bookend present and mirrored.** `## Learning Outcomes` (`:26`) ↔ "What you can do now"
  (`:409-416`), then a Day-2 bridge (`:420`) and Thanks/Questions (`:422`) placed last so they
  survive a timing cut.
- **Both parts reach a hands-on payoff.** Part 1 → render HTML (`:280-284`); Part 2 → branded
  Typst PDF (`:404-407`). Both callouts state "regroup in ~30 min", matching the budget.
- **Single through-line.** base-R `penguins` (`:16-24`) runs the whole arc; `:114` "from here on
  we're building one document together" makes the build explicit.
- **Jargon glossed on first use (rule 7).** Typst `:354` + notes `:372`; outset/inset `:202-203`;
  CSL `:331-334`. No undefined term left to the room.
- **Section headers each open with a promise.** `:42` "Author a document, land it as HTML"; `:288`
  "cite it, then typeset it". Delete-all-but-H1 test passes.
- **Part 2 is correctly lean** (~4 content slides in an 18-min window) — the payoff is protected,
  exactly as running-order rule 1 intends.
- **Format caveat handled pedagogically.** `:206-209` warns the body/margin/column model doesn't
  transpose to revealjs — anticipates a real learner misconception.

## 📝 Evolution since the previous review

No prior review of this deck exists — this is the first pedagogy pass on WP1 slides (the deck is
just-authored/uncommitted). Measured against the 9 running-order rules the panel encoded on
2026-07-07, the deck **already implements** rules 3 (one dataset), 5 (aspiration), 6 (named
transfer), 7 (glossing), and 9's mode-marker convention (Follow-along + two Your-turns, no bespoke
class). The **residual gaps** are rule 9's same-name Challenge link in Part 2 (P1-2), rule 2's
shipped-starter framing (P1-3), and the Part-1 side of the time budget the panel filled
(`topic-store.md:287-299`), which the current slide count overshoots (P1-1). Nothing has regressed;
these are first-authoring gaps, not backslides.

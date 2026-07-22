# Pedagogue review — WP3 Day-2 deck (`slides/quarto-projects/index.qmd`)

**Date:** 2026-07-08 · **Branch:** `claude/goal-command-wx5go6` (uncommitted working tree)
**Scope:** one file — the Day-2 revealjs deck. Judged for adult-learning / pedagogy against
`topic-store.md` § *Day-2 CORE beat-lock* + § *Running-order rules* and `workshop-pacing.md`.
**Out of scope / not re-flagged:** Day-1 deck, the CORE triage, the Part1/Part2 split, the
beat-lock itself (confirmed — judged only whether the deck *realizes* it), the logo TODO.

## Overall verdict

Pedagogically strong and very close to event-ready. The deck realizes the beat-lock almost
verbatim: both parts open under a clear promise and reach a hands-on payoff, the objectives are
mirrored end to end (Learning Outcomes → What you can do now), the Freeze beat is a textbook
motivation-first / cache-vs-freeze / CI-without-R / renv-second-leg execution, and the publishing
watch-me framing carries the beginner P0 auth-cliff mitigation cleanly. The one real gap is
mode-marker completeness: the deck marks the *Your turn* transition but never the *Follow along*
transition, so it realizes only half of the two-transition convention (rule 9 / pacing §
Slide-deck structure). A couple of jargon glosses land after first use (CI, Shinylive). None of
this is blocking; fix the Follow-along markers and the two glosses and it's ready.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

**P1-1 · Missing "Follow along" transition marker — only one of the two required transitions is
marked.** `index.qmd:47` (Part 1 first My+Our beat), `index.qmd:211` (Part 2 first My+Our beat).
The convention (`workshop-pacing.md` § Slide-deck structure; running-order rule 9) is explicit and
symmetric: mark **both** ambiguous transitions with built-in callouts — live-coding starts →
`::: {.callout-note title="Follow along"}`, exercise starts → `::: {.callout-tip title="Your turn
…"}`. The deck has the two *Your turn* callouts (`:197`, `:281`) but **no `Follow along` callout
anywhere** (confirmed by grep). Both parts are budgeted "My + Our" — live coding is interwoven with
the concept slides — yet nothing on-slide cues the room to switch from watching to typing along.
Add one `callout-note title="Follow along"` where live-coding begins in each part (e.g. the "Why a
project?" beat `:47` and the "Freeze" beat `:211`). Low-effort; brings the deck into full
compliance with the named convention. (Mitigating factor: this is Day 2, so the rhythm was
established Day 1 — hence P1, not P0 — but the cue is still the convention.)

## 🟡 P2 — nice-to-have

**P2-1 · "CI" is used before it is glossed (rule 7 = gloss on first appearance).** First
substantive use is `index.qmd:219` ("what lets **CI render the site without R at all**"), and it
also appears unglossed in Learning Outcomes at `:34`. The one-line gloss ("a build that runs on
every push") only arrives 46 lines later at `:265`. Move or duplicate the gloss to the first body
use (`:219`) so the term isn't left undefined during the load-bearing Freeze teach.

**P2-2 · "Shinylive" not glossed at `index.qmd:309`.** OJS gets a parenthetical gloss on the same
line ("*Observable JS — a browser-side, non-R path*") but Shinylive rides through undefined, and
rule 7 lists Shinylive explicitly. Add ~4 words (e.g. "Shinylive — Shiny running in the browser,
no server"). Low stakes (it's in the cut-able demos-if-time tail), but the rule names it.

**P2-3 · Part 2 frame slide drops the scripted capstone hook.** The beat-lock (budget line: Part 2
frame = "this is how your team publishes the capstone") and rule 6 want the capstone transfer
*named* at the Part 2 opening; the Part 2 title slide `index.qmd:207-209` subtitle is only "Make
builds reproducible, then publish." The capstone is recovered at the wrap-up (`:297`) and is well
named elsewhere (`:36`, `:75`), so this is a minor completeness point — consider restoring the hook
to the Part 2 frame so each part opens on its "why do I care" stake, not just Part 1.

## ✅ Pedagogical strengths confirmed

- **Objectives promised and mirrored.** `## Learning Outcomes` open (`:28`, infinitive "be able
  to") and `## What you can do now` close (`:286`) map objective-for-objective
  (structure/build/publish → structure/reproducible/publish). Delete everything but the H1s and you
  still know what you'll learn.
- **Both parts reach a hands-on payoff.** Part 1 Your turn = branded website (`:195`), Part 2 Your
  turn = render to `_site` (`:279`). Neither part is slides-only.
- **Beat-lock realized end to end.** Part 1: Why-a-project + `_metadata.yml` (`:47`,`:77`) →
  Website + listings-as-aside (`:95`,`:131`) → Cross-refs shock-absorber (`:136`) → `_brand.yml`
  (`:156`). Part 2: Freeze (`:211`) → renv second leg (`:232`) → Publishing (`:256`). Running order
  matches the spec exactly; the cut-able demos tail sits **after** the payoff and the close (`:299`),
  so timing pressure trims the tour, never the hands-on (rule 1).
- **Freeze beat is exemplary.** Motivation-first ("slow bioinformatics compute", `:213`), crisp
  cache-vs-freeze one-letter-apart contrast (`:217-219`), the 2-render scenario made concrete
  (`:230`), CI-without-R payoff, and renv named as the *second* reproducibility leg (`:232-249`) —
  exactly the spec's load-bearing teach.
- **Shock-absorbers are labelled in the notes, as scripted.** renv "cut-first sub-item… drop it
  under time pressure" (`:251-253`); cross-refs flagged as the Part-1 shock-absorber with the
  honest book-vs-website hedge "Verify on your Quarto build before relying on it live" (`:150-153`) —
  matches the beat-lock's "don't demo project-wide `@fig-` live".
- **Beginner P0 (live-publish auth cliff) mitigated on-slide and in notes.** Watch-me callout
  (`:268`) plus presenter pre-flight note (`:274-276`); the hands-on kernel is honestly narrowed to
  `render` + `output-dir` (`:258`, `:271`).
- **In-room support is real.** Roaming-helper notes anticipate the top trap (`output-dir` vs
  relative page paths, `:202-204`) and name the known-good starter so anyone behind can open Part 2
  clean (`:203`, rule 2 satisfied).
- **Jargon mostly glossed on first use:** `output-dir` (`:68`), `freeze` (`:217`), listings
  (`:132`), OJS (`:309`).
- **Capstone transfer named** at open (`:41`), Part 1 (`:75`), and the two-axes wrap-up (`:296-297`).
- **Within concept+demo budget.** Part 1 = 5 content slides (~18 min ceiling), Part 2 = 3 (~15 min);
  load is managed — listings demoted to an aside (`:131`), `_brand.yml`'s native-vs-R-package
  distinction kept to one honest claim ("same palette, not the whole brand system", `:185`).

## 📝 Evolution since the previous review

No prior pedagogue review of this file exists — this is the **newly authored** Day-2 deck (WP3), so
there is no regression baseline. Relative to the *spec it was built against*, the deck is a faithful
realization of the confirmed beat-lock and running-order rules: the panel-era risks (payoff squeeze,
live-publish P0, capstone-transfer implied-not-named, starter-artifact strand) are all already
addressed in the authored text. The single carried-forward convention gap is the missing
*Follow along* marker (P1-1) — the deck adopted the *Your turn* half of rule 9 but not the
*Follow along* half.

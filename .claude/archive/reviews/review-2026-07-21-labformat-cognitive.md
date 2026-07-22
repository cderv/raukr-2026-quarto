# Lab format through a cognitive-load lens — callout-heavy "Challenge" vs NBIS prose-walkthrough

**Date:** 2026-07-21
**Lens:** learning-design / cognitive load — how the lab is *presented*, not what it teaches.
**Decision:** keep our callout-heavy format, adopt NBIS's prose style, or hybridize?
**Verdict (short):** **Keep our structure — it is the right spine for a time-boxed *doing* lab — but trim ~2 boxes/page and collapse the optional ones.** The defect is not the callout *count*; it is that a couple of boxes are left open when they should be on-demand, and the top-of-page and post-task regions stack too many boxes in a row.

---

## 1. The two formats, framed by cognitive-load type

Cognitive-load theory splits load three ways: **intrinsic** (the material's own complexity — identical for both, same Quarto concepts), **extraneous** (imposed by *presentation*), and **germane** (effort that builds a schema). Format only moves the last two. The question is which format lowers extraneous load and supports germane load **for a first-time doer working against a clock**, given an audience that is expert-R but Quarto-novice.

### Our format — a functional callout taxonomy

Each challenge runs a fixed spine: **Scope** (note) → **Tasks** (note) → *target figure* → **Hint** (collapsed tip) → **Solution** (folded code) → **You should see** (note) → **Troubleshooting** (tip) → **Session** (`<details>`). See `labs/quarto/index.qmd:8` (Scope), `:52` (Tasks), `:81` (You should see), `:104` (Hint), `:113` (Solution), `:252` (Troubleshooting).

The load-bearing observation: those boxes map almost 1:1 onto the distinct questions a doer asks in sequence — *what is this / where do I start / what exactly do I do / I'm stuck / show me / did it work / it broke*. That is **signalling** in the CLT sense: the boxes are not decoration, they partition the page by *function*. When signalling marks genuinely distinct functions it **lowers** extraneous load, because the learner spends no search effort locating "the next action" — the author pre-structured it.

Two more CLT wins are baked in:

- **Worked-example / completion effect.** The folded `#| code-fold: true` / `#| eval: false` solution (`labs/quarto/index.qmd:113`) is a worked example available *on demand*. For novel Quarto syntax (hash-pipe labels, `$$…$${#eq-ratio}`) a worked example is exactly what the literature says novices learn most from — and folding it preserves the problem-solving attempt first, so it's a faded-guidance design, not a spoiler.
- **Self-explanation / success criterion.** "You should see" (`:81`, `:209`) gives an external target to self-check against — germane load, the learner verifies their own schema.

### NBIS format — continuous prose reference

`.../raukr-nbis/labs/quarto/index.qmd` is 759 lines with **3 callouts total**: one intro note (`:9`), one lone `{{< fa clipboard-list >}} Tasks` box near the very end (`:592`), one Troubleshooting tip (`:603`). Everything else is textbook prose — YAML shown, then each key explained bullet-by-bullet (`:139`), concepts woven with their rationale. The site lab (`.../quarto-site/index.qmd`, 593 lines, 4 callouts) is the same: a linear "do this, then this" build narrative with success shown as embedded screenshots/iframes (`:475`), never as a checklist.

---

## 2. Steelman each — then where each actually fails

**Steelman NBIS.** Uninterrupted prose has real virtues my lens must credit. It reads like a **reference you keep**: the elaborated "why" (every YAML option annotated at `:139`) supports *retention* and later browsing far better than our terse imperative Tasks. There is no box-chrome to fragment the eye — a reader in study mode flows top-to-bottom with low visual noise. The redundancy effect even argues *for* it here: our expert-R audience may find repeated framing (Tasks + Solution + You-should-see all restating the goal) mildly wasteful, whereas NBIS states each thing once. As a **post-workshop artifact**, NBIS's format is arguably superior.

**Where NBIS fails — for first-time doing under time pressure.** Low callout count is *not* low cognitive load. Prose **shifts** the structuring work onto the learner: the task is buried in narration ("Try changing some of these arguments", `:92`), the one explicit Tasks box sits at line 592 of 759, and success is implicit. A doer must now spend extraneous effort *extracting* "what do I do next" and *inventing* "did it work?" from continuous text — a search cost incurred 40 times over in the room. With no checkpoints, the failure mode is passive reading and silent divergence: people read instead of do, and can't tell when they've fallen behind. For a 2h hands-on slot that is the expensive failure.

**Steelman ours.** The functional taxonomy front-loads exactly that structuring work into the author's design, so the doer pays it once (at authoring) not N times (at the bench). The folded Solution + collapsed Hint are textbook progressive disclosure. And ours is ~1/3 the length for the same concepts — less to wade through when the clock is running.

**Where ours fails — chrome density in three specific spots.** Ten boxes/page *can* become wallpaper, and in three places it does:

1. **Open Troubleshooting.** `labs/quarto/index.qmd:252` and `labs/quarto-projects/index.qmd:208` are *open* `callout-tip` boxes — 10 bullets on day 1. Troubleshooting is a **reference appendix**, consulted only when something breaks, yet it renders as a large open block on every page. This is pure extraneous load in the default read. Note the inconsistency: the **Hint** right above it *is* collapsed (`:104`) but Troubleshooting isn't — so the "optional = folded, spine = open" rule the format implies is violated by the single biggest box on the page.
2. **"You should see" as a second open note.** At `:81` it's a full `callout-note` — same visual weight as the Tasks note — and it partly restates the goal, then it stacks with the target figure (`:89`) + Hint (`:104`) + Solution (`:113`) into a four-block wall between "here are the tasks" and "next section". The content is germane (self-check) and worth keeping, but as a co-equal note it competes with the actual spine.
3. **Top-of-page double note.** Day 2 opens Scope (`labs/quarto-projects/index.qmd:19`) immediately followed by "Starting point" (`:33`) — ~30 lines of boxed prose before the first task. The learner scrolls two big boxes before any action.

So the honest read: our callout density is *correct in kind* — the taxonomy earns its place — but **mis-tuned in a few instances**, where an on-demand box was left open or a germane aside was given spine-level weight.

---

## 3. Note-vs-tip semantics — keep, and make it the documented rule

Our two callout types carry a consistent meaning worth naming explicitly: **note = load-bearing, must-read spine** (Scope, Tasks, You-should-see); **tip = optional / on-demand** (Hint, Coming-from-Rmd aside, Troubleshooting). That is good signalling — the *color/icon* itself tells the learner "read now" vs "later if needed". The one fix that makes the semantic honest: everything typed `tip` that is genuinely on-demand should also be `collapse="true"`. Hint and the Rmd aside already are (`:35`, `:104`); Troubleshooting should join them. Once that holds, the format teaches the reader its own convention.

---

## 4. Recommendation — **KEEP, TRIM** (a light hybrid, mostly ours)

Our callout-heavy "Challenge" format is the right choice for a hands-on, time-boxed lab and should stay. Do not move toward NBIS's walkthrough for the *lab* — but do borrow its one strength (woven rationale) where our Tasks are too bare, and consider shipping a prose "reference" version as take-home if retention is a goal. Concrete changes:

**Callouts that earn their place (keep):**
- **Scope** (note) — sets intrinsic-load expectation + package list. Essential orientation.
- **Tasks** (note) — *the* "what do I do next" spine. Untouchable.
- **Hint** (collapsed tip) — model progressive disclosure. Keep as-is.
- **Solution** (folded code) — worked-example/self-check. Keep as-is.

**Trim / retune (noise as currently rendered):**
- **Troubleshooting → `collapse="true"`** on both days (`labs/quarto/index.qmd:252`, `labs/quarto-projects/index.qmd:208`). Biggest single extraneous-load win; also fixes the folded-Hint/open-Troubleshooting inconsistency. *(This is the #1 change.)*
- **"You should see" → demote.** Either merge it into the Tasks box as a closing **"Done when: …"** line, or keep it but give it lighter weight than the Tasks note (e.g. a plain bordered aside, not a co-equal `callout-note`). Preserve the content (it's germane self-assessment); reduce its chrome so it stops competing with the spine and stops stacking into the four-block wall.
- **Top-of-page double note (day 2).** Merge Scope + "Starting point" into one orienting box, or trim "Starting point" to a single line, so the first Task is reachable with less boxed prose above it.

**Borrow from NBIS (small):** where a Task is purely imperative, add a *half-line* of "why" inline (our day-2 `cd starter/` trap explanation at `:44` already does this well — that's the model). Don't import NBIS's paragraph-per-option density into the lab; if a full reference is wanted, ship it as a separate take-home page, not inside the timed lab.

Net effect: pages drop from ~10 open-ish boxes to ~4 open spine boxes + 3 folded on-demand boxes. The taxonomy — our genuine asset — survives intact; the chrome that fragments the first-time read is gone.

---

### Bottom line
Callout-heavy is not the problem; a couple of *open* optional boxes and one over-weighted germane box are. Fix those three and the format is close to optimal for a doing-lab under a clock — decisively better than NBIS prose for first-time doing, while NBIS prose remains the better *take-home reference*.

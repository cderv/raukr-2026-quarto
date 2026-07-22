# Scope review — beginner (simulated participant) — 2026-07-07

**Reviewer role:** `workshop-reviewer-beginner` (stand-in). Fluent R + tidyverse, writes R
Markdown occasionally, life-science/bioinformatics data work. Has *dabbled* in Quarto/Rmd for
simple reports. **Never** built a Quarto project, never touched `_brand.yml`, Quarto extensions,
or Quarto presentations. Reads English fine; undefined jargon trips me.

**What I reviewed:** the proposed run-of-show (not authored slides/labs — none exist yet):
`topic-store.md`, `prior-art-inventory.md`, `project-context.md` @ commit `715d3ec`.

---

## Overall verdict

From my seat the *shape* is right: you explicitly skip "what is a code chunk"
(`topic-store.md:39`) and teach the basics "as deltas, fast" (`topic-store.md:60`), so I won't
be bored on fundamentals, and each part promises a hands-on payoff I can walk out with. My real
worry is the back half of **Day 2**: publishing with **CI foregrounded**
(`topic-store.md:109`) is the single most prerequisite-heavy, auth-dependent thing in the whole
programme, and the plan gives it no on-ramp — that's where a room full of people who've never
built a project (me included) gets stranded on GitHub setup instead of learning Quarto. Second,
the plan is dense with words I don't own yet — *Typst, outset/inset, CSL, shortcodes, freeze,
OJS, Shinylive* — dropped with no gloss; each is a small cliff. Third, **Citations** is your one
CORE topic I care about most (I write papers) but it's your *thinnest* existing material
(`prior-art-inventory.md:69,92`), so it's the biggest promise-vs-delivery risk. None of this is
fatal at scope stage — it's all fixable before you author.

---

## 🔴 P0 — blocking (would stop me cold in the room)

**P0-1 — Day 2 Part 2 "Publishing + CI" is an environment cliff with no on-ramp.**
`topic-store.md:109` — *"Publishing | `quarto publish gh-pages` **and** CI (GitHub Actions) |
`_(new)_` foreground CI"*. I have never built a project and never set up CI. To do this
hands-on I need: a GitHub account authenticated *on this laptop*, a repo, `gh-pages` enabled,
and — for the Actions path — an understanding of what a workflow/runner/YAML action even is. In
a room with no chat and one instructor, a hands-on publish step becomes a room-wide auth-and-setup
sink; those of us who hit an auth wall spend the slot debugging tokens, not learning Quarto, and
walk out of the *final* part of the two days with nothing shipped. The plan has no fallback
(e.g. "publish is a DEMO you watch" vs "hands-on with a pre-authed repo"), and "foreground CI"
foregrounds the hardest, least-portable piece. **Ask:** demote live CI to a *watch-me* DEMO with
a finished repo you show; keep the *hands-on* to `quarto publish` against a repo participants set
up in advance (or a pre-provisioned one), and state the exact auth prerequisite in a pre-flight
note.

---

## 🟠 P1 — fix before the event

**P1-1 — Typst: is it install-free? The plan never says, and it's my Part-2 payoff.**
`topic-store.md:63` — *"Typst | modern PDF without LaTeX"* is the Day-1 Part-2 finale. As
someone who's only made simple HTML reports, "Typst" is a brand-new word *and* a brand-new
toolchain to me. If a live or hands-on Typst render needs anything beyond my Quarto install, and
my Quarto is old, I'm stranded exactly at the payoff. Please bake in an explicit one-liner —
"Typst ships **inside** Quarto, no LaTeX, nothing to install" — plus a pre-flight version check
against your floor (`project-context.md:39` sets **Quarto ≥ 1.8**). Without that reassurance I
won't trust the "without LaTeX" promise and will assume I need to install something scary.

**P1-2 — Undefined-jargon cluster with no gloss in the plan.** Words dropped as if known:
*Typst* (`:63`), *outset / inset* (`:46,60`), *CSL styles* (`:62`), *shortcodes* (`:71`),
*freeze* (`:108`), *OJS / Shinylive* (`:114`). Each is a term I'd have to quietly look up — and I
can't (no Stack Overflow in the room). I don't need all defined deeply, but every one needs a
one-line "here's what this word means" the first time it appears on a slide, or it silently loses
part of the room. *outset/inset* especially — that's page-layout jargon I've genuinely never met.

**P1-3 — Citations is CORE but your thinnest material — the promise I most want kept.**
`topic-store.md:62` promotes Citations to CORE ("*research audience writes manuscripts*") with
the CORE contract of slides + demo + **exercise** (`:20`). But `prior-art-inventory.md:69`
grades it *"⚠️ weak … no dedicated exercise"* and `:92` lists it under "gaps to build fresh." I
am precisely the person this is aimed at (I write papers), so if the citations segment turns out
to be a thin `.bib` + `@ref` wave-through with no real hands-on, I'll feel shortchanged on the
one topic I came for. Make sure the built exercise matches the CORE promise, incl. a real CSL
style swap on a realistic reference list.

**P1-4 — Freeze vs cache: a genuinely confusing pair, and I'll leave muddled without a crisp
model.** `topic-store.md:108` — *"knitr `cache` vs quarto `freeze` — distinguish the two"*. You
flagged this yourself. For me (never built a project, so no mental slot for either) these are two
overlapping magic words. Why I'd care is huge — I run slow bioinformatics computations and don't
want to re-run them on every render — but only if you *lead* with that motivation and give one
clean "cache = within a doc's re-render / freeze = don't re-run at project build" contrast.
Otherwise it's abstract config I won't retain.

**P1-5 — Day 2 Part 2 is overstuffed for a ~1h part with 2:1 hands-on.** `topic-store.md:99`
packs *caching, freeze, publishing, interactivity* into "scale & ship," and `:111` adds CI on
top. That's four heavy, new-to-me topics plus an auth-gated hands-on in ~60 min. With your own
"slots are upper limits — land fewer things well" rule (`project-context.md:19`), this part is
the one most likely to overrun and leave me with a half-finished publish. Cut interactivity to a
30-second teaser here (it's already DEMO/weak, `prior-art-inventory.md:87`) and protect time for
one clean publish.

---

## 🟡 P2 — nice-to-have

**P2-1 — Don't open the Day-1 lab on the trivial first exercise.** `prior-art-inventory.md:41`
marks Ex1 (*"render `simple-document.qmd`, source vs visual editor"*) as *"trivial; maybe skip
for advanced."* If the lab starts there I'm bored in minute one. Enter the arc at authoring
features (Ex4) and make Ex1 optional warm-up.

**P2-2 — Editor mismatch on the Positron demo.** `topic-store.md:72` shows Quarto × Positron. I
may be sitting in RStudio; keystroke-level demos won't translate. Keep it conceptual (Quarto
integration, not Positron mechanics) so a non-Positron user can still follow — which is already
the stated intent, just make sure the demo honors it.

**P2-3 — "Why do I care" connective tissue for Parameters, Dashboards, Interactivity.** These
are new to me and their tie to *my* work isn't self-evident. One sentence each lands it:
parameters → "re-run the same report per sample/cohort"; dashboards → "share results with a wet-lab
collaborator"; a website → "your lab site / the end-of-school capstone." The capstone hook is
explicitly available (`project-context.md:34-35`) — use it.

**P2-4 — Make the Day-1 Part-2 payoff something I *make*, not just watch.** With a gap between
parts, I want to leave Part 2 holding my own Typst PDF, not just having watched you render one.
If Typst stays "Our turn" only, the gap-break feels like it ended mid-thought.

---

## ✅ What reassures me

- You **cut the fundamentals I'd resent sitting through**: "skip what is a code chunk"
  (`topic-store.md:39`), basics "as deltas" (`:60`). No boredom cliff on things I know.
- **Migration de-emphasized** (`topic-store.md:34,78`). I have almost no Rmd baggage, so teaching
  Quarto-native from the start (`:34`) fits me better than a long Rmd→Quarto detour would.
- **Slots are upper limits, "land fewer things well"** (`project-context.md:19`) — the stated
  discipline is exactly what keeps a dense plan from drowning me.
- **Each part lands a usable payoff** — Day-1 Part-1 "author a document, land HTML"
  (`topic-store.md:51`), Day-2 Part-1 a working website (`:98`). I leave each gap with something
  finished, not hanging.
- You **saw my actual need**: Citations promoted to CORE *because* "research audience writes
  manuscripts" (`topic-store.md:62`). That's the right instinct; P1-3 is only about delivery
  matching it.
- **TAs in the room + one running dataset** (`project-context.md:34`, `prior-art-inventory.md:34`)
  — continuity and live help soften the jargon and auth risks above.

---

## 📝 Evolution since previous review

None — this is the first review cycle for this repo (`reviews/` held only `.gitkeep` at
`715d3ec`).

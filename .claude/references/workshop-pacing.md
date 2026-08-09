# Workshop pacing guidelines

Generic hands-on-workshop pedagogy, derived from Mine Çetinkaya-Rundel's workshops
(USCOTS 2023, Monash 2023) and carried over from the RR 2026 Quarto tutorial. These are
principles, not this session's programme — the programme lives elsewhere once decided.

## The two modes

Every module cycles through two teaching modes:

- **My turn** — the presenter explains and demonstrates. Participants watch (~5-10 min max per cycle)
- **Your turn** — independent exercise within the announced hands-on block

The cycle repeats multiple times per module. It is **not** "30 min talk then 30 min exercise."

> **Revised 2026-08-09 — there is no "Our turn".** The generic model this file was derived from
> has a middle mode where the room types along with the presenter. We tried it and retired it:
> under a typing label a slide's job becomes "supply a working snippet", so the slide stops
> explaining and starts printing the lab's steps. **Slides explain, labs try** — the full rule and
> the test that catches the failure live in `project-context.md § Content patterns`. The rhythm's
> real home is still the per-part time budget and running-order rules in `topic-store.md`. On the
> **slide surface** only the slides→lab handoff is marked, and there is **no per-slide badge and no
> bespoke CSS class** (it wouldn't survive folding into the NBIS site). See § Slide-deck structure
> below.

## Time ratios

Rule of thumb: **~1h hands-on for ~30min talk** (2:1 favoring exercises).

For a 2h workshop with ~110 min effective time:
- ~35-40 min presentation + live demo ("My turn")
- ~60-70 min hands-on ("Your turn")

Mine's Monash workshop (3h): each 60-min module ≈ 20 min presentation/demo + 25-30 min
hands-on.

## Exercise design

- **Starter files, not instructions on slides** — participants have something open immediately.
- Exercises are **short and focused**, not comprehensive. Announce the hands-on block time on the
  transition slide. Do not publish per-task estimates until they have been tested in a rehearsal or
  a previous delivery: untested numbers create false precision and make participants feel behind.
- **Solutions inline by default** (refined 2026-07-07): a folded `#| code-fold: true` /
  `::: {.callout-tip collapse="true"}` solution in the lab doc — not a secret — is more portable
  (one file) and lets participants self-check on the spot, matching RaukR's idiom. Ship a separate
  `starter/` file only when an exercise genuinely starts from scratch. The **lab is the main path**
  through the material: it is where every participant action happens.
- **Progressive**: later exercises build on earlier ones; provide a fallback starting point
  for participants who didn't finish the previous one. Name the **core finish line**, then mark
  **stretch**, **optional**, and **demo** work. Keep the goal, tasks, and checkpoint aligned. A demo
  becomes an exercise only when the slides teach enough for participants to build it.
- Exercise files are minimal: working code, bare structure — participants add the new concepts.
- A **pre-workshop install mini-test** (a tiny self-contained document that exercises the
  full toolchain) de-risks setup before the day. Reference it from the prerequisites page.

## Structure patterns

### File organization (template — adapt to the real programme)
```
exercises/
  00-setup-check/          # standalone pre-workshop install test
  01-<topic>/
    starter/               # minimal working file, new concepts removed
    solution/              # reference after "Your turn"
N-<module>/
  index.qmd                # landing page (overview + exercise links)
  slides.qmd               # RevealJS slides (short!)
```

### Slide-deck structure

- Announce the watch-then-do rhythm **once, up front** — then trust the audience; don't re-badge
  every slide.
- Mark only the **handoff**, with a **built-in callout** (no custom class, no extension):
  - exercise starts → `::: {.callout-tip title="Your turn — regroup in ~N min"}` pointing at the
    lab's `## … Challenge` (same word on slide and in lab).
  - the one exception is a **"Do this now" checkpoint**: one command with a stated pass condition,
    used only where the participant's own machine is the point (the setup gate, the first Typst
    render).
- **Countdown: presenter-side by default.** State "regroup in ~N min" in the callout and run the
  clock off-screen (phone/room). The `{{< countdown >}}` extension prints raw text if it's absent
  from the render tree — put it on-slide only if declared (`quarto add`) in both our repo and the
  NBIS tree, and keep every slide teachable without it. Frame it as a **regroup clock**, not a
  performance stopwatch.
- Keep slides short — the live demo carries the teaching, not the slides.
- End each module with a pointer to the relevant docs ("Learn more").
- **Session wrap-up**: a few terminal slides — (a) "What you can do now" mirroring the objectives,
  (b) "Where next" pointers, (c) "Thanks / Questions?". Put them last so they survive even if an
  optional segment is cut for timing.
- **Learner-framed objectives**: open with a **`## Learning Outcomes`** slide (RaukR's native
  idiom — zero integration cost) using infinitive verbs ("By the end you'll be able to…"), and
  validate it with the "What you can do now" close. Promise up front, mirror at the end.

### What works well

- "Build something you'll actually use" framing beats toy exercises.
- Share-out slots after exercises (peer learning).
- A cloud fallback (Posit Cloud / Codespaces) for setup issues.
- `chalkboard: true` for live annotation on slides.
- A curated "what to explore next" resources page.

## Sources

- USCOTS 2023 (Theobold): <https://github.com/atheobold/uscots-quarto>
- Monash 2023 (Çetinkaya-Rundel): <https://github.com/mine-cetinkaya-rundel/quarto-monash>

# Workshop pacing guidelines

Generic hands-on-workshop pedagogy, derived from Mine Çetinkaya-Rundel's workshops
(USCOTS 2023, Monash 2023) and carried over from the RR 2026 Quarto tutorial. These are
principles, not this session's programme — the programme lives elsewhere once decided.

## The three modes

Every module cycles through three teaching modes:

- **My turn** — short concept presentation via slides (~5-10 min max per cycle)
- **Our turn** — live coding; participants follow along in their editor
- **Your turn** — independent exercise with a countdown timer (5-10 min)

The cycle repeats multiple times per module. It is **not** "30 min talk then 30 min exercise."

> **These are facilitation modes, not slide chrome** (decided 2026-07-07 — see
> `project-context.md` § Content patterns). The rhythm's real home is the per-part time budget
> and running-order rules in `topic-store.md`. On the **slide surface** it shows up only as
> built-in callouts at the ambiguous transitions (watch→follow-along, follow-along→watch,
> follow-along→solo) —
> **no per-slide "My turn" badge, no bespoke CSS class** (it wouldn't survive folding into the
> NBIS site). See § Slide-deck structure below.

## Time ratios

Rule of thumb: **~1h hands-on for ~30min talk** (2:1 favoring exercises).

For a 2h workshop with ~110 min effective time:
- ~35-40 min presentation + live demo ("My turn" + "Our turn")
- ~60-70 min hands-on ("Your turn")

Mine's Monash workshop (3h): each 60-min module ≈ 20 min presentation/demo + 25-30 min
hands-on.

## Exercise design

- **Starter files, not instructions on slides** — participants have something open immediately.
- Exercises are **short and focused** (5-10 min each with a countdown), not comprehensive.
- **Solutions inline by default** (refined 2026-07-07): a folded `#| code-fold: true` /
  `::: {.callout-tip collapse="true"}` solution in the lab doc — not a secret — is more portable
  (one file) and lets participants self-check on the spot, matching RaukR's idiom. Ship a separate
  `starter/` file only when an exercise genuinely starts from scratch. The "Our turn" live coding
  stays the main path through the material.
- **Progressive**: later exercises build on earlier ones; provide a fallback starting point
  for participants who didn't finish the previous one.
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

- Announce the My/Our/Your rhythm **once, up front** — then trust the audience; don't re-badge
  every slide.
- Mark only the **transitions**, with **built-in callouts** (no custom class, no extension):
  - live coding starts → `::: {.callout-note title="Follow along"}`, naming the file to create and
    the file to open if you fall behind.
  - live coding ends → `::: {.callout-warning title="Eyes up — not a live *Follow along*"}`. Don't
    settle for an italic line: a participant looking at their editor misses it and keeps typing.
  - exercise starts → `::: {.callout-tip title="Your turn — regroup in ~N min"}` pointing at the
    lab's `## … Challenge` (same word on slide and in lab).
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

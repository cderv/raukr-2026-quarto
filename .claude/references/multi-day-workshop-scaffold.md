# Scaffold — bootstrapping a new multi-day workshop

A portable starting point for the **next** multi-day (or multi-session) workshop,
distilled from this RaukR 2026 Quarto build. Copy the parts you need; the concrete
RaukR frame lives in `project-context.md`, the pedagogy in `workshop-pacing.md`,
and the day-to-day authoring gotchas in the path-scoped rules (`slides.md`,
`multi-day-sequencing.md`, `justfile.md`). This document is the **skeleton + spin-up
checklist**; those are the depth.

Terminology: a **day** (or **session**) is one ~2h block for the same cohort; a
day splits into two **rounds** (watch → follow along → your turn), with a break
between. Days after the first are **follow-ups** — see `multi-day-sequencing.md`.

## 1. Directory layout

One folder per day for slides and for the lab; shared config and brand at the root.

```
_quarto.yml            # project: type: website; output-dir: _site; navbar per day
_brand.yml             # ONE palette + fonts → site, slides, and R plots (see §5)
DESCRIPTION            # renv Imports: drive the snapshot
justfile               # render / preview / clean / publish <target>  (cross-platform)
index.qmd  setup.qmd   # landing + participant setup/install-check page
slides/
  day1-<slug>/index.qmd   # format: revealjs
  day2-<slug>/index.qmd
labs/
  day1-<slug>/index.qmd   # format: html (inherits project defaults)
  day2-<slug>/index.qmd
_freeze/               # VERSIONED — committed computed results (see §4)
.claude/               # plans, references, rules, agents, archive (dev-in-the-open)
```

Scale the `dayN-` pairs to the real programme. Slides are `format: revealjs`, labs
default to the project's `format: html` — keep each doc **single-format** to dodge
the multi-format preview conflict.

## 2. Per-day deck skeleton

The canonical running order — the wrap-up slides go **last** so they survive a
timing cut. Fill the `<…>` and delete what a given day doesn't need.

```markdown
---
title: "<Day title>"
subtitle: "<Workshop> · Day N — <one-line theme>"
author: "<Name>"
format:
  revealjs:
    theme: [default, ../../theme.scss]
    width: 1280
    height: 720
    slide-level: 2
    incremental: false
    echo: true
    slide-number: true
# Keep author notes as YAML comments here — NOT as an HTML comment in the body,
# which renders a phantom empty leading slide (any top-level block before the
# first `##` becomes its own slide).
---

​```{r}
#| label: setup
#| include: false
# libraries + dataset every follow-along cell assumes
​```

## Learning Outcomes
# Day 1: infinitive-verb outcomes + "By the end: <artifact>".
# Day N (follow-up): open with a bridge line first — "Yesterday: X. Today: Y."

## How today works
# Day 1: full watch → follow along → your turn + Challenge + break explanation.
# Day N: trim to "same shape as yesterday" + the Follow along / Your turn reminder.

# Part 1 — <name> {.center}

## <teaching slide> {#anchor}
# ::: {.callout-note title="Follow along"} at the first live-coding slide.
# Concept-only stretch? ::: {.callout-warning title="Eyes up — not a live Follow along"}.

## Your turn {#your-turn-1}
# ::: {.callout-tip title="Your turn — regroup in ~N min"} pointing at the lab's
# `## <Name> Challenge` (same word on slide and in lab). Then the break.

# Part 2 — <name> {.center}
# Section note = one-sentence "welcome back" recap; don't re-teach Part 1.

## <teaching slides> …
## Your turn {#your-turn-2}

## What you can do now {#wrap-up}
# Mirror the Learning Outcomes. Final day: name the whole arc built across days.

## Thank you! {.center}
# Questions? + "Learn more" links. Footer contact via ::: {.smaller}, NOT ::: aside
# (aside overlaps a centered slide).
```

Lab skeleton (html): scope `callout-note` + `library()` chunk at the top; sections
are `##`; graded exercises are `## <Name> Challenge` with a folded
`#| code-fold: true` / `#| eval: false` solution and a `<details>` **Session**
(`sessionInfo()`) block at the end. Day-N Challenges must **state the target
artifact explicitly** — participants can't picture a thing they've never built.

## 3. Day-1 vs Day-N framing

The single highest-leverage move across days: **make later days sound like
follow-ups.** The full discipline is the path-scoped rule
`multi-day-sequencing.md` (auto-surfaced when you edit `slides/**` or `labs/**`).
In one line: on later days, *widen the scope of what learners already own* — recap
recurring structure, bridge from yesterday in the opening, pay off any "that's the
Day N story" teasers, and verify every "you saw this yesterday" against the earlier
deck before writing it.

Two traps worth pre-empting when you build day N (both in the rule, §7–§8):

- **The repeat can originate on the *earlier* day.** If a later slide reads like a
  repeat, check whether Day 1 **over-claimed** a scope it can't yet demonstrate (Day 1
  "themes the whole site + slides" when it only builds one PDF). Fix by **narrowing the
  earlier day** to what it actually builds, making the pair setup → payoff — not by
  contorting the later slide.
- **Run a discrete cross-day dedup sweep** whenever a later deck changes — a fresh
  reviewer holding *both* decks, classifying each later-deck slide repeat / partial /
  clean and checking every callback is *true*. It catches cross-references a
  slide-at-a-time author misses. **Sweep labs with a different lens** (rule §9): in a
  lab, re-practicing an owned skill is *good* — hunt only **duplication** (same task,
  same outcome, no new dimension), classifying duplication / beneficial-rep / clean-new.
  Ship earlier-day content pre-authored (`starter/`) so every action lands on the new
  day's layer, and name the added dimension on any repeated step.

## 4. Build, freeze & environment

- **`justfile` orchestrates** (`render` / `preview` / `clean` / `publish <target>`).
  Keep it **cross-platform** — participants run it on Windows too
  (`.claude/rules/justfile.md`).
- **`_freeze/` is versioned.** After editing an executable `.qmd`, re-render it and
  stage `_freeze/`; commit it so CI (and colleagues) rebuild the site with **no R at
  all**. `execute: freeze: auto` in `_quarto.yml` is the sane default.
- **R deps via `renv`** — snapshot driven by `DESCRIPTION` `Imports:`;
  `renv::restore()` to rebuild. (`freeze` pins *results*; `renv.lock` pins *what
  produced them* — you want both.)
- **Fit-check every changed slide** headless at native deck size — overflow is
  invisible in source (`.claude/scripts/slide-shot.mjs`, `.claude/rules/slides.md`).

> **Getting materials to participants.** For an R audience,
> `usethis::use_course("owner/repo")` is the smoothest path — it downloads the repo as a
> ZIP (a `git archive`), no git or GitHub account needed, same on every OS. Keep dev
> scaffold (`.claude/`, editor config) **out of that ZIP** with `.gitattributes`
> `export-ignore` — but know its limit: `export-ignore` is honored **only** by
> `git archive`/zipball, **not** by `git clone` or the GitHub web UI. So once the repo is
> public the full `.claude/` tree is visible to anyone who clones or browses; the shield
> keeps the *participant download* clean, it does not hide anything. Tidy `.claude/` for a
> cold reader before going public rather than relying on it — keep the durable craft (rules,
> references, hooks, scripts) and drop the process log. (RaukR: a companion r-universe package
> was scoped and **deferred**.)

## 5. One brand everywhere

A single root `_brand.yml` carries palette + fonts to the **site**, the **slides**,
*and* R **plots/tables** (via the `brand.yml` package's `theme_brand_ggplot2()` /
`theme_brand_gt()`). Introduce it once; on later days remind rather than
re-introduce. Don't vendor a host school's SCSS — rebuild the look in `_brand.yml`.

Two brand + code caveats bite at HTML render: code **syntax highlighting is not
brand-themed** (palette edits won't move token colors), and using `brand` ships a dark
highlight sheet that **leaks into light mode** (command words go bold cyan) — fixed with a
small `theme-html.scss` override. Both live in `.claude/rules/brand.md § 4`.

> **Keep `_brand.yml` ASCII-only.** The R side reads it with `read_brand_yml()`, which **fails to
> parse non-ASCII under a `C`/POSIX locale** (minimal containers, CI, some sandbox tool-shells): it
> silently returns an **empty palette**, so `brand_color_pluck()` passes raw names through and
> `gt`/`ggplot` reject them (`invalid color name "teal_lighter"`). A single decorative `·` / `—` /
> `§` in the brand `name` or a comment is enough to trigger it. Interactive UTF-8 machines hide it;
> a render under `LC_ALL=C` exposes it. Hit twice — the tuto (French content → *had* to document a
> locale requirement) and RaukR (English content → fixed at the source, made the file ASCII).
> Check: `LC_ALL=C Rscript -e 'print(brand.yml::read_brand_yml("_brand.yml")$color$palette)'` must be
> non-`NULL`.

## 6. The authoring loop

**Plan → author → review → triage/fix.** Review each change through four distinct lenses
before it ships, because they catch different failures:

- **Technique** — false claims, invalid syntax, multi-format conflicts.
- **Pedagogy** — altitude, dose, whether the struggle is preserved.
- **Beginner** — what actually blocks a first-time participant.
- **Language** — copy-editing plus register (see the prose note in `CLAUDE.md`).

Triage findings by severity and fix the blockers before moving on.

## 7. Spin-up checklist

- [ ] `_quarto.yml` (website, `output-dir`, navbar with a Slides + Lab entry per day).
- [ ] `_brand.yml` at the root (palette + fonts); wire the R side with `brand.yml`. Keep it
      **ASCII-only** — `read_brand_yml()` empties the palette on non-ASCII under a `C` locale (§5).
- [ ] `justfile` (render / preview / clean / publish); confirm it runs on Windows.
- [ ] `DESCRIPTION` `Imports:` + `renv::snapshot()`; commit `renv.lock`.
- [ ] `theme.scss` for slide tweaks (consecutive-code-block spacing, etc.).
- [ ] One `slides/dayN-*/index.qmd` + `labs/dayN-*/index.qmd` pair per day, from §2.
- [ ] `index.qmd` (overview) + `setup.qmd` (install check) landing pages.
- [ ] Day-1 decks: full framing. Day-N decks: follow-up framing (§3).
- [ ] **Cross-day dedup sweep** (§3): audit each later-deck slide against the earlier
      deck (repeat / partial / clean); fix repeats — narrowing the earlier day where it
      over-claims — and verify every "you saw this yesterday" callback is true. Sweep
      **labs** with the duplication lens (rule §9): keep beneficial reps, cut only same
      task / same outcome / no new dimension.
- [ ] Render everything, stage `_freeze/`, fit-check changed slides.
- [ ] Review through the four lenses (§6); triage; fix the blockers.

# Day-2 rework plan — task-first exercises with a hint ladder

Status: **applied.** The current lab is the source of truth. It differs from this rationale in these
ways:

- **Part 1 step 4** scopes `code-fold` + `code-summary` in `reports/_metadata.yml`, not `echo: false`.
- **Part 2 step 2** (`cache` versus `freeze`) is a discussion step with a comparison table, not a
  build step.
- **Part 2 step 4** keeps the dashboard as an **optional group demo** with optional follow-up work,
  rather than promoting it to a required hands-on step.
- The guided `freeze: true` experiment is core. Publishing remains optional.
- Timing estimates stay out of participant material until supported by rehearsal.

Ground truth this is built on:

- `topic-store.md` § Time budget: Day-2 Part 1 = **50 min** hands-on, Part 2 = **48 min**,
  concept+demo capped ~18 / ~15.
- `topic-store.md` § Block 2 CORE: why a project, websites (navbar/sidebar **and listings**),
  cross-referencing across pages, freeze **and the cache-vs-freeze contrast**, publishing
  (hands-on is `render` + `output-dir`, `publish` is watch-me).
- `workshop-pacing.md` § Exercise design: "starter files, not instructions on slides", exercises
  "short and focused (5-10 min each)", "minimal: working code, bare structure, participants add
  the new concepts", progressive with a fallback.
- `prior-art-inventory.md` § The exercise catalogue: Family A steps 6-8 (project → website →
  freeze → publish) and the **starter + correction** pairing used across the earlier tutorials.
- `multi-day-sequencing.md` § 9: in a lab the failure mode is **duplication**, not repetition.
  Same skill in a new context is a beneficial rep, and the new dimension has to be named on the
  step itself.

## The problem in one line

Day 2 announces "~45-minute Challenge" three times, the plan budgets 50 and 48, and the lab holds
about 12 minutes of copying YAML the page already supplies in full.

Padding it with more transcription would fill the clock without teaching anything. The real defect
is that **the fade runs backwards**: Day 1 withholds the learning target and hands over the
incidental ("the `gt` plumbing is below, your job is the cross-reference mechanic"), while Day 2
supplies the complete answer at every step. Later in the same arc, with the same cohort, the
scaffolding should be **wider**, not narrower.

## The principle

**State the task and the acceptance test. Withhold the config. Ladder the help.**

Every Day-2 step is authored in four layers, in this order on the page:

1. **Goal** — one line, what you are trying to make happen.
2. **You should see** — the acceptance test, stated *before* the work, so a participant can tell
   for themselves whether they are done. This is the piece that lets you withhold the answer
   without stranding anyone.
3. **Hints, collapsed, in a ladder.** Hint 1 is a *question*, not an answer. Hint 2 names the
   mechanism but still shows no code. Only then a folded **Solution** with the real config.
4. **Trigger questions in `::: notes`** — what the presenter asks the room out loud at roughly the
   five-minute mark, instead of reading the answer off a slide.

The website half is the easy half, so it carries the most of this: the task is stated, and the
room is walked to the answer by question, not by transcription. The harder halves (freeze, the
dashboard) can be blunter because the work itself is the challenge.

### The hint-ladder shape (copy this per task)

```markdown
**Goal.** One sentence.

::: {.callout-note appearance="simple" icon=false}
## You should see
The observable result, concretely enough to self-check.
:::

::: {.callout-tip collapse="true"}
## Stuck? (1) — a question to ask yourself
Which file does Quarto treat as the project root, and how does it decide?
:::

::: {.callout-tip collapse="true"}
## Stuck? (2) — the mechanism
Quarto walks up from the file and uses the *nearest* `_quarto.yml`. Nothing sits above
`day2-projects/`, so a `_quarto.yml` there makes that folder the project.
:::

::: {.callout-note collapse="true"}
## Solution
`` `yaml` block with the real config ``
:::
```

## Part 1 — Build & structure a project (50 min)

Starting point stays a shipped set of pages (nobody starts from a blank folder). The starter grows
a `reports/` subfolder so `_metadata.yml` has something to scope.

| # | Step | ~min | Given | Withheld (the work) |
|---|---|---|---|---|
| 1 | **Make it a project** | 8 | `project:` stanza only (`type: website`, `output-dir`) | where the file goes, and that `quarto render` with no argument builds the folder |
| 2 | **Build the navigation** | 12 | the page list | the whole `website:` block, written from the page list. Then swap in `sidebar: contents: auto` and compare |
| 3 | **Brand it** | 12 | the `_brand.yml` body | the `theme:` interaction (see below) |
| 4 | **Scope options to a folder** | 10 | the `reports/` pages | the `reports/_metadata.yml` that sets `echo: false` + `code-fold: true` there and nowhere else |
| 5 | *(stretch)* **Listings** | 8 | — | a `listing:` on a page that indexes `reports/` |

Steps 4 and 5 are new work, and both are already **taught on a slide and never practised** today
(`_metadata.yml` at `slides/quarto-projects/index.qmd:100-128`, `contents: auto` at `:147-152`).
That is why they are cheap: no new teaching, only a place to use it.

### Step 3 is the productive-failure beat

The `theme: cosmo` / `_brand.yml` clash (see `rules/brand.md` § 7) becomes the **exercise** instead
of a trap. The starter's `_quarto.yml` ships with a bare `theme: cosmo`. The participant adds
`_brand.yml`, re-renders, and sees the font change but **not** the colors.

- **You should see** says exactly that, so the surprise is expected and nobody thinks they broke it.
- **Trigger question:** "the type changed but the navbar didn't. What does that tell you about how
  `theme:` and the brand combine?"
- **Hint 1:** "`theme:` is a list even when you write one value. What order is it in?"
- **Hint 2:** a bare `theme: cosmo` expands to `[brand, cosmo]`, and later layers win.
- **Solution:** `theme: [cosmo, brand]`.

This teaches layer precedence, which is real Quarto knowledge they will hit again, and it costs no
extra content. It needs the acceptance test stated up front or it turns into ten minutes of silent
confusion, so that ordering is not optional.

## Part 2 — Scale & ship (48 min)

| # | Step | ~min | Given | Withheld (the work) |
|---|---|---|---|---|
| 1 | **Make the build skip unchanged pages** | 12 | the goal only | `execute: freeze: auto`, **and how to prove it worked** |
| 2 | **`cache` versus `freeze`** | 8 | both names | which one survives a project build, which one is per-document |
| 3 | **Put your Day-1 report on the site** | 12 | — | copy `my-report.qmd` in, add it to the nav, re-render |
| 4 | **Ship a dashboard** | 16 | `analysis.qmd` to copy | `format: dashboard` plus the layout model (rows, a card, two valueboxes, a tabset) |
| 5 | *(optional, end of day)* **Put it online** | 10 | the command | see below |

### Step 5 is the optional publish, and it is Connect Cloud, not gh-pages

Publishing was ruled a watch-me demo because a live `quarto publish gh-pages` for 40 people is a
room-killer (GitHub account, a repo, a `gh-pages` branch, git auth on the laptop, then push and wait
for a green check). **Posit Connect Cloud removes every one of those.** Verified 2026-08-03:

- `quarto publish posit-connect-cloud` uploads **locally rendered static content**. A GitHub
  repository is *not* required (the GitHub integration is for automatic redeployment, optional).
- Authentication is a browser OAuth against a Posit account.
- The free tier publishes **unlimited static documents** (the 5-item cap is on interactive apps,
  which this is not).

So the participant already has the deliverable from step 3 (`_site/`), and one command puts it on a
URL they can open on their phone. That is the Day-2 payoff made concrete, in about two minutes.

**gh-pages is dropped entirely, not kept as the watch-me** (decided 2026-08-03). The workshop never
teaches git or GitHub, and the whole logistics chain is built on not needing them: `use_course()`
is sold on "no git, no GitHub account". Demoing a `gh-pages` publish would teach a path the room
has no way to walk, and would contradict the setup page two days running. Connect Cloud needs no
repository, so it is the only publish target the material mentions.

What survives from the CI story is the **freeze** payoff, which is already generic and glossed on
its own slides ("commit `_freeze/` and **CI** *(the automated build)* rebuilds with no R at all").
That is a reason to commit `_freeze/`, not a demo, and it does not depend on GitHub.

**The one prerequisite goes on the Setup page, not into the session.** Creating the Posit account is
the only slow part, so `setup.qmd` gets an *optional* line: "if you'd like to publish your site on
Day 2, make a free Posit account beforehand". Then the in-session step really is one command.

**Why it is last and optional.** It depends on nothing downstream, so running out of time costs
nothing. It also doubles as the **named overflow for fast finishers**, which the pedagogy review
flagged as missing on both days.

Risks: venue Wi-Fi for 40 uploads (small, `_site/` is text plus a few plots), and a locked-down
laptop blocking the OAuth browser flow (fallback: they still have `_site/`, which was the actual
deliverable). The presenter can demo it on this very repo, since the justfile already carries
`just publish connect`.

### Step 1 withholds the proof, not just the setting

Today the lab hands over both the two-line freeze block *and* the `cat(format(Sys.time()))` trick
that makes the skip visible. Withhold the second one: ask **"how would you prove the code did not
re-run?"** Letting them invent the timestamp tell is the whole lesson, and it is a genuinely good
question for this audience. The hint ladder still ends at the same snippet for anyone stuck.

Step 2 closes a CORE item (`topic-store.md` names the cache-vs-freeze contrast) that the lab has
never covered.

### Step 3 is the arc fix

Day 2 currently starts from fresh pages and never touches the document they spent Day 1 building,
so "one document → one project" is asserted on the wrap-up rather than experienced. One step
("copy your `my-report.qmd` into the project, add it to the navbar, re-render") converts the
assertion into a demonstration. The fallback is `starter.qmd` for anyone who did not finish Day 1.

### Step 4 promotes the dashboard from demo to hands-on

`labs/quarto-projects/dashboard.qmd` already exists, is static (no server), and its header comment
already says the teaching point is the **layout model**, not the plots. It is the most appealing
exercise available on Day 2 and it currently gets spent on a "Demos (if time)" slide. Promote it,
keep the existing file as the reference solution.

## What this makes true again

| Currently false | After |
|---|---|
| "~45-minute Challenge" ×3 | matches the actual work |
| `topic-store.md` 50 / 48 min hands-on | matches |
| LO + wrap-up claim `_metadata.yml` | now practised (Part 1 step 4) |
| LO claims "publish it" | true for anyone who does the optional step 5. Reword to "produce a publishable folder, and put it online" so it covers both |
| "a **fresh** set of pages" | Part 2 step 3 brings the Day-1 document in |
| Cache-vs-freeze contrast is CORE | now practised (Part 2 step 2) |
| `sidebar: contents: auto`, listings taught only | now practised |

## Build checklist (the mechanics, in order)

0. **Setup page** — add the *optional* pre-event line: a free Posit account for anyone who wants to
   publish in step 5. This is the only part of that step that is slow, so it must not happen in the
   room.
1. **Starter files** — add `day2-projects/reports/` with two short pages. Keep `day2-projects/`
   **without** a `_quarto.yml` (`rules/exercises.md` structural invariant: creating it is the
   exercise). Ship the starter `_quarto.yml`'s `theme: cosmo` deliberately for step 3.
2. **Solution files** — extend `labs/quarto-projects/solution/` to the finished state, still a
   **sibling** folder (never nested in a day folder).
3. **Lab rewrite** — `labs/quarto-projects/index.qmd`, one hint-ladder block per task.
4. **Slides** — retime the three "~45 min" callouts, put the trigger questions in `::: notes`, add
   the layer-order beat to the brand slide, fix the LO wording, drop the dashboard from
   "Demos (if time)".
5. **Margin notes** — each Tasks callout carries a `::: {.column-margin}` "Quarto docs" pointer
   (this is why the labs set `toc-location: left`). New steps need new pointers, and they are easy
   to forget because they sit outside the task text: **listings** →
   `https://quarto.org/docs/websites/website-listings.html`, **`_metadata.yml`** →
   `https://quarto.org/docs/projects/quarto-projects.html`, **cache vs freeze** →
   `https://quarto.org/docs/projects/code-execution.html`, **dashboards** →
   `https://quarto.org/docs/dashboards/` (all verified live 2026-08-03). Keep them to two or three
   links so the margin stays scannable.
6. **Re-render** the executable `.qmd` and stage `_freeze/` (commit hook blocks a stale freeze).
7. **`just exercises`** to regenerate the payload, then commit `exercises/`.
8. **CI** — add render steps for the new starter and solution pages in
   `tools/exercises-scaffold/.github/workflows/render-check.yml`.
9. **Watch the payload size** — the exercises CI has a 2 MB zip budget. New pages are text, so the
   headroom is fine, but do not add images.

## Risks

- **Scope.** This is the largest single change left before the sessions. If time is short, Part 1
  steps 1-3 plus Part 2 step 1 already close most of the gap, and steps 4-5 / 3-4 can land later.
- **Productive failure needs the acceptance test.** Step 3 of Part 1 only works because the page
  says up front what the wrong result looks like. If that line is cut, the step becomes the bug we
  just fixed.
- **Helper load.** Less guidance means more hands up. The trigger questions are partly there to let
  one presenter serve the room from the front instead of forty individual rescues.
- **A hint ladder is longer to author than a code block.** Budget for the writing, not just the
  design.

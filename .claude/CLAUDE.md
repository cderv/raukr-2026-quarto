# CLAUDE.md — RaukR 2026 Quarto session

Repo for Christophe Dervieux's **two afternoon Quarto sessions** at RaukR 2026 (Advanced R for
Bioinformatics, Visby): *Introduction to Quarto* (Mon 10 Aug, 150 min) and *Quarto projects*
(Tue 11 Aug, 180 min), each two parts split by a 30-min break (verified times:
`project-context.md` § Event), for an experienced-R / life-science audience. English; each block is slides (revealjs) + lab (html);
branding rebuilt via `_brand.yml` (RaukR teal, Albert Sans / Fira Mono — don't vendor NBIS SCSS).
This file is the **method/workflow scaffold**; the concrete frame — event, audience, stack, house
style, prior art — is in **`.claude/references/project-context.md`**, and content-dependent depth
lives in the other references.

## Build & environment

- **`justfile` is the build orchestrator** (`just render` / `preview` / `clean` / `publish <target>`);
  `quarto preview` for the live loop. **Publishing takes a target** — `just publish gh` (GitHub Pages)
  or `just publish connect` (Posit Connect Cloud); `publish-only <target>` skips the rebuild. **Must
  stay cross-platform** (participants run it on Windows too) —
  editing rules + the PowerShell/`[unix]`/`[windows]` conventions live in **`.claude/rules/justfile.md`**.
- **`just demos` builds the unlinked instructor demo pages from `exercises/`;** `just render` runs it
  after the site build. See `.claude/rules/justfile.md` for the build constraints.
- **R deps via renv** — `renv::restore()`; explicit snapshot driven by `DESCRIPTION` `Imports:`.
  **`pak` works here** (verified 2026-07-21, pak 0.11.0 — the old "pak KO" note was stale): use it
  for **system-requirement detection/repair** (`pak::sysreqs_check_installed()` /
  `sysreqs_fix_installed()`, which auto-`apt`s as root) and as a package installer; **`renv.lock`
  stays the pinning source of truth** (add-a-package = edit `DESCRIPTION` → install →
  `renv::snapshot()`). Sandbox specifics are in `.claude/references/sandbox-setup.md` (kept in sync
  with the SessionStart hook `.claude/hooks/session-start.sh`).
- **Freeze discipline — `_freeze/` is versioned.** After editing an executable `.qmd`, re-render it
  (`quarto render <file>`) and stage `_freeze/`. A `PreToolUse(Bash)` hook
  (`.claude/hooks/check-freeze.sh`) **blocks `git commit`** on a stale freeze; pure-markdown pages
  are skipped. Backstop: a full `quarto render` at end of session.
- **Exercises are delivered from a separate repo, generated from here.** The hands-on files ship in
  `cderv/raukr-2026-quarto-exercises` (English; a GitHub template; year-in-name), which participants
  download via `usethis::use_course(...)` — no git, no account. **`labs/` is the source of truth;**
  `just exercises` regenerates the committed `exercises/` payload (`tools/sync-exercises.R`, the only
  write path — never hand-edit `exercises/`), and `just publish-exercises` mirrors it onto that repo's
  `main`. So **editing `labs/**` means: `just lab-shape-check` + re-render + re-sync + commit
  `exercises/`** (two CI guards enforce the shape and the match). The shape check is the one that
  catches a structural edit turning an exercise into a walkthrough — the Day-1 Part-2 failure.
  The full model, structural invariants (no `_quarto.yml` above the
  day starters; sibling solutions; the Day-1 working/reference files off the site render list), and gotchas are the
  path-scoped rule **`.claude/rules/exercises.md`** (auto-surfaced on `labs/**`, `exercises/**`, the
  sync/publish scripts, `setup.qmd`, `_quarto.yml`).

## Publishing — this repo is public (since 2026-08-03)

Both repos are live: this one, and `cderv/raukr-2026-quarto-exercises`, which participants download
with `usethis::use_course()`. Everything committed here is world-readable the moment it lands.

**The site is deployed at <https://cderv.github.io/raukr-2026-quarto/>** (since 2026-08-03), from the
`gh-pages` branch of this repo. `just publish gh` renders and pushes it, then prints that URL;
`_quarto.yml` carries it as `site-url` (sitemap, absolute links). Any doc that points a
reader at the rendered material should use that URL.

**Write about roles and artifacts, never about people.** This is the rule that matters, and it is a
*write-time* decision — there is no way to grep for it later. Say "the organizer-suggested list", not
"Roy's list"; "the prior deck has no citations exercise", not "<name>'s deck is content-dated". Never
commit an assessment of someone else's work under their name, a quote from private correspondence,
or anything tracking a named person's activity. The 2026-08-03 cleanup had to strip exactly this from
the planning references, and it cost nothing to lose: the de-personalized notes kept every actionable
line (what to reuse, what is missing, `file:line`) and shed only the attribution and the judgement,
which were never useful for authoring anyway. Situated material that genuinely needs the candour
belongs in a private notes repo, not here.

**No secrets** — `.gitignore` covers braid's local config (its doc id is a bearer token),
`.claude/reviews/`, private links, and third-party PII. **Never commit issue-tracker IDs** (`br-…`)
in tracked files; they mean nothing to a reader and leak the tracker's shape.

**Before any visibility change, enumerate every ref** — `git ls-remote origin` — and audit each one,
not just the branch you changed. Rewriting a branch is not rewriting a repository: on 2026-08-03,
`main` was clean while 18 stale `claude/*` branches were publishing the full unpurged history, and
the exercises repo nearly went public with a leaking branch still on it.

**History was rewritten twice on 2026-08-03** (trailers + authorship, then content). Any clone made
before that has an unrelated history: `git fetch origin && git reset --hard origin/main`. Never
`git pull` — it will refuse to merge, and that refusal is the safety net.

## Authoring

Website pages `format: html`, slides `format: revealjs` (avoids the multi-format conflict); always
add `fig-alt`. **Slides explain, labs try** — a slide teaches the concept, the lab carries every
participant action. The test: if a slide's `Do:` note matches a lab step's solution, the slide is
doing the lab's job. The **full RaukR house style** — slide structure, `. . .` incremental, the
"Your turn" handoff callout, `## Learning Outcomes` open / "What you can do now" close,
lab `code-fold` solution + `<details>` Session block — is in **`project-context.md` § Content
patterns** (pedagogy rationale: `workshop-pacing.md`).

The **house voice** — write like Christophe (short declarative spine, asides in parentheses not
em-dashes, plain warm words) and strip the LLM tells that keep re-introducing spoken-register clutter
(stacked em-dash asides, voice-over tails, reassurance narration) — is the path-scoped rule
**`.claude/rules/prose-voice.md`** (auto-surfaced on prose `.qmd`), with the full profile +
before/after in **`.claude/references/house-voice.md`**. One principle: written prose *states*; the
presenter's voice belongs in `::: notes`. Notes may be conversational, but they must remain
glanceable in presenter mode. Slide bodies stay terse.

**Comments are local explanations, not authoring notes.** Default to no comment. File headers and
local comments are one sentence unless a complex constraint genuinely needs more. Do not record
history, investigation, verification, teaching plans, commit-style summaries, or information held
elsewhere. Before committing, inspect every added comment in the diff. In participant files, retain
exercise TODOs, accessibility text, and narrow explanations of surprising code. Do not modify
generated or vendored comments directly.

**Applied plans do not become permanent project history.** Delete working plans after use, or
distil only current constraints into the matching scoped rule. Do not retain rejected alternatives,
bench estimates, review transcripts, or implementation logs.

**Commit messages are short. The reasoning lives in the strand.** Most commits here are a subject
line alone. Add a body only for the why a reader cannot get from the diff, and keep it to a few
lines. Do not write the investigation: which review found the defect, how it was verified, what was
tried first, or which fix turned out to be wrong. That material belongs in the strand, where it can
be corrected when it proves wrong. A pushed commit message cannot. Say what changed and why, not
how you came to know it. And never cite the strand id (see Publishing).

The **slide-craft gotchas** — fit-check every changed slide (`.claude/scripts/slide-shot.mjs`),
`.center`-slide layout, `code-line-numbers`, `filename`, consecutive-code-block spacing, `echo: fenced`
to show a cell's `#|` options — are the path-scoped rule **`.claude/rules/slides.md`**
(auto-surfaced when editing `slides/**/*.qmd`). Day-2+ decks are **follow-ups** for the same cohort —
reminders and callbacks, not first-time framing: the path-scoped rule
**`.claude/rules/multi-day-sequencing.md`** (auto-surfaced when editing `slides/**` or `labs/**`).
**Brand-file gotchas** — ASCII-only (R's `read_brand_yml` empties the palette on non-ASCII under a
`C` locale), hyphen-key→underscore-lookup, `link` under `typography` not `color`, and the
brand-triggered dark-highlight leak (code highlighting isn't brand-themed; the fix lives in
`theme-html.scss`) — are the path-scoped rule **`.claude/rules/brand.md`** (auto-surfaced when
editing `_brand.yml` or the theme SCSS).

## Where things live

- **References** → `.claude/references/`: `project-context` (the frame), `topic-store` (per-block
  scope), `workshop-pacing` (pedagogy), `multi-day-workshop-scaffold` (skeleton + spin-up checklist
  for a new multi-day workshop), `sandbox-setup` (environment), `quarto-doc-sources`,
  `prior-art-inventory`, `typst-render-diagrams` (Typst/fletcher diagram recipe + deploy gotchas),
  `colorblind-safe-palettes` (CVD-safe ggplot palette best-practice + recipes), `house-voice`
  (how Christophe writes + the LLM-tell strip-list; paired with the `prose-voice` rule).
- **Rules** → `.claude/rules/`: path-scoped gotchas for `justfile`, `exercises`, `slides`,
  `multi-day-sequencing`, `brand`, plus `prose-voice`.
- **Skills** → `.claude/skills/`: `quarto-authoring`, `quarto-alt-text`, `brand-yml`, `braid`.
- **Work tracking** → **braid**, an issue tracker whose items are called **strands**. The `braid`
  CLI is on the PATH and finds the skein from the environment, so it just works. `braid ready` is
  the start-of-session question, `braid agents-info` the full guide, and `.claude/skills/braid/`
  the auto-invoking stub that defers to it. **Use it** — plan and follow-up work belongs in a
  strand, not only in a markdown note. (The two rules below stay: never commit `br-…` ids, never
  run `braid secret` unless a human asks.)
- **Agents** → `.claude/agents/`: the four `workshop-reviewer-*` lenses (technique / pedagogue /
  beginner / language) and `student-participant`, which actually walks a lab and reports friction.
  **Commands:** `/start-workshop` (fan out the panel), `/run-labs` (drive the student agent).
  The **pedagogue and the student read the rendered site**, not the `.qmd` (in source the Hints and
  Solutions are open, so neither can judge what a participant actually meets):
  `.claude/scripts/site-serve.sh start --render` serves the build, and the agent-browser recipe plus
  the traps that cost an hour each are in **`.claude/references/reviewing-the-live-site.md`**.
- **Upstream issues** → `.claude/upstream-issues/`: Quarto bug reports reduced from this material,
  drafted here before filing against `quarto-dev/quarto-cli`.

## Reviewing

`/start-workshop` fans out the four reviewer lenses in parallel; `/run-labs` walks the labs as a
novice participant. Both write dated reports to **`.claude/reviews/`, which is gitignored** — they
are working notes, not repo content. The durable output of a cycle is the commit that fixes what it
found, plus any lasting gotcha promoted into the matching `.claude/rules/` file. Never edit a past
report; a same-day re-review gets a `bis`/`ter` file.

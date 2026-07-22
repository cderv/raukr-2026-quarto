# CLAUDE.md — RaukR 2026 Quarto session

Repo for Christophe Dervieux's **two ~2h Quarto sessions** at RaukR 2026 (Advanced R for
Bioinformatics, Visby): *Introduction to Quarto* (Mon 10 Aug) and *Quarto projects* (Tue 11 Aug),
for an experienced-R / life-science audience. English; each block is slides (revealjs) + lab (html);
branding rebuilt via `_brand.yml` (RaukR teal, Albert Sans / Fira Mono — don't vendor NBIS SCSS).
This file is the **method/workflow scaffold**; the concrete frame — event, audience, stack, house
style, prior art — is in **`.claude/references/project-context.md`**, and content-dependent depth
lives in the other references.

## How we work — the loop

**Plan → author → review → triage/fix → archive.**

1. In-progress plan → `.claude/plans/<YYYY-MM-DD>-<slug>.md`; move to `.claude/archive/plans/` when done.
2. Author / change content.
3. `/start-workshop` fans out the four `workshop-reviewer-*` agents in parallel (technique /
   pedagogue / beginner / language); each writes one dated report to `.claude/archive/reviews/`.
4. Fix P0/P1; record notable changes in the work log `.claude/worklog.md`; mark each review's
   disposition in the ledger `.claude/archive/reviews/README.md`.
5. **Reviews + plans are immutable, versioned snapshots** — never edit a past review (a re-review
   gets a new dated `bis`/`ter` file). Conventions: `.claude/archive/README.md`.

**Public repo, dev-in-the-open:** everything under `.claude/` is versioned. **No secrets** —
`.gitignore` covers braid's `.braid.toml` (its doc id is a bearer token), private links, third-party PII.

## Build & environment

- **`justfile` is the build orchestrator** (`just render` / `preview` / `clean` / `publish <target>`);
  `quarto preview` for the live loop. **Publishing takes a target** — `just publish gh` (GitHub Pages)
  or `just publish connect` (Posit Connect Cloud); `publish-only <target>` skips the rebuild. **Must
  stay cross-platform** (participants run it on Windows too) —
  editing rules + the PowerShell/`[unix]`/`[windows]` conventions live in **`.claude/rules/justfile.md`**.
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

## Issue tracking (braid)

Work items ("strands") live in braid; the `braid-issue-tracking` skill defers to `braid agents-info`.
`braid sync` works from remote web sessions. Loop: `braid ready` →
`braid update <id> --status in_progress --assignee cderv` → `braid close <id>`.

## Authoring

Website pages `format: html`, slides `format: revealjs` (avoids the multi-format conflict); always
add `fig-alt`. The **full RaukR house style** — slide structure, `. . .` incremental, mode-marker
callouts ("Follow along" / "Your turn"), `## Learning Outcomes` open / "What you can do now" close,
lab `code-fold` solution + `<details>` Session block — is in **`project-context.md` § Content
patterns** (pedagogy rationale: `workshop-pacing.md`). The **slide-craft gotchas** — fit-check every
changed slide (`.claude/scripts/slide-shot.mjs`), `.center`-slide layout, `code-line-numbers`,
`filename`, consecutive-code-block spacing — are the path-scoped rule **`.claude/rules/slides.md`**
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
  `colorblind-safe-palettes` (CVD-safe ggplot palette best-practice + recipes).
- **Skills** → `.claude/skills/`: `quarto-authoring`, `quarto-alt-text`, `brand-yml`.
- **Agents** → `.claude/agents/`: the four `workshop-reviewer-*`. **Command:** `/start-workshop`.
- **Archive** → `.claude/archive/`: `plans/`, `reviews/` (+ its disposition ledger `README.md`),
  `issues/` (drafts to file upstream). Conventions in `.claude/archive/README.md`.

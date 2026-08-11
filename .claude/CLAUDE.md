# RaukR 2026 Quarto workshop

This repository contains two afternoon Quarto sessions for experienced R users in the life sciences:
*Introduction to Quarto* (10 August, 150 minutes) and *Quarto projects* (11 August, 180 minutes).
Each session combines revealjs slides with an HTML lab. Read
`.claude/references/project-context.md` before changing workshop content.

## Build and dependencies

- Use the `justfile`: `just render`, `just preview`, `just clean`, `just publish gh`, and
  `just publish connect`. Keep every recipe compatible with Unix and native Windows; see
  `.claude/rules/justfile.md`.
- Restore R dependencies with `renv::restore()`. `DESCRIPTION` declares direct dependencies and
  `renv.lock` pins them. To add a package, update `DESCRIPTION`, install it, then run
  `renv::snapshot()`.
- `_freeze/` is versioned. After changing an executable `.qmd`, render it and include the updated
  freeze output. The commit hook rejects stale freeze entries. Run a full `just render` before
  finishing broad content changes.
- `just demos` builds the unlinked instructor demos from the generated exercise payload. It also runs
  as part of `just render`.

## Exercises

- `labs/` is the source of truth. `exercises/` is generated and committed; never edit it directly.
- After changing a lab, run `just lab-shape-check`, render the changed file, run `just exercises`,
  and include any resulting `exercises/` and `_freeze/` changes.
- `just exercises-check` verifies `labs/ -> exercises/`. `just published-check` verifies the
  published exercise repository. Use `just publish-exercises` only when publication is requested.
- A Challenge step must let the participant attempt the task before revealing the answer. The full
  structure and delivery invariants are in `.claude/rules/exercises.md`.

## Public repository

Both this repository and the exercise repository are public.

- Do not commit secrets, private links, third-party personal data, private correspondence, review
  reports, or braid strand IDs (`br-...`).
- Describe roles and artifacts, not named people, when recording assessments or prior-art findings.
- Before changing repository visibility, enumerate and audit every remote ref with
  `git ls-remote origin`; checking one branch is insufficient.
- If a clone made before 2026-08-03 reports unrelated histories, follow
  `.claude/references/history-rewrite.md`. Do not reset a worktree with uncommitted changes.

## Authoring

- Website pages use `format: html`; slides use `format: revealjs`.
- Add `fig-alt` to every meaningful image.
- Slides explain concepts; labs contain participant procedures. If a slide's `Do:` note reproduces a
  lab solution, move the procedure to the lab.
- Open a deck with `## Learning Outcomes` and close it with `What you can do now`.
- Use the `Your turn` callout for the slides-to-lab handoff. Do not reintroduce sustained
  follow-along typing.
- Follow `.claude/rules/prose-voice.md` for participant prose and presenter notes.
- Comments explain the adjacent code or setting. Do not record investigation history, plans, review
  transcripts, or commit summaries in source comments.
- Delete completed working plans. Promote only durable constraints to a scoped rule or reference.
- Keep commit messages short. Add a body only when the reason is not clear from the diff.
- For a broad rewrite of `.claude` instructions, include a deletion ledger in the commit body. Map
  each removed constraint to its new location or explain why it was dropped. Test runnable commands
  before removing them.

## Scoped guidance

- Slides: `.claude/rules/slides.md`
- Later-day sequencing: `.claude/rules/multi-day-sequencing.md`
- Labs and generated exercise payload: `.claude/rules/exercises.md`
- `_brand.yml` and theme SCSS: `.claude/rules/brand.md`
- Cross-platform `justfile`: `.claude/rules/justfile.md`
- House voice: `.claude/rules/prose-voice.md` and `.claude/references/house-voice.md`
- Maintainer prose and configuration comments: `.claude/rules/maintainer-prose.md`
- Quarto bug reports reduced from this material, drafted before filing upstream:
  `.claude/upstream-issues/`

Detailed background belongs in `.claude/references/`; repeatable task workflows belong in
`.claude/skills/` or `.claude/commands/`. Keep scoped rules limited to current, actionable
constraints.

## Work tracking and review

- Use braid for work that needs tracking. Run `braid ready` at the start of a planning session and
  `braid agents-info` when its workflow is unclear. Never run `braid secret` unless the user asks.
- `/start-workshop` runs the four reviewer lenses. `/run-labs` runs the student-participant agent.
- Review reports go in `.claude/reviews/` (gitignored). Treat them as immutable snapshots. The durable
  result is the content change and, when necessary, a concise current constraint in a scoped rule.

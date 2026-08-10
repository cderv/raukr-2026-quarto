---
description: Run a review cycle — fan out the workshop-reviewer panel in parallel and collect dated reports.
argument-hint: "[optional scope tag, e.g. slides / block1 / setup]"
---

# Review cycle — the workshop-reviewer panel

Run one full review cycle on the current state of the material. This is the repeatable
loop the whole repo is organized around:

**author/change content → run the panel → triage → fix → repeat.**

`$ARGUMENTS` (optional) is a **scope tag** — a slug describing what to focus on this cycle
(e.g. `slides`, `block1`, `setup`). If empty, review the whole repo. Fold the tag into each
review filename as `review-YYYY-MM-DD[-tag]-[type].md`.

## Steps

1. **Establish the baseline.** Determine today's date, the current reference commit
   (`git rev-parse --short HEAD`), and the **delta since the last cycle**: read the most
   recent `.claude/reviews/*.md` if any (the directory is local-only, so a fresh clone has none)
   and list the fixes already applied since then, so
   each reviewer is told what **NOT** to re-flag.

2. **Serve the site.** The `pedagogue` reviews rendered pages, not source, so it needs a site to read:
   `.claude/scripts/site-serve.sh start --render`, pass the printed `SITE_URL`, and `site-serve.sh stop`
   when the cycle ends. `--render` matters, because a stale build makes every finding describe content
   you already changed. (The deployed site is not an option here, and
   `.claude/references/reviewing-the-live-site.md` says why.)

3. **Fan out the panel — in parallel, one message, multiple Agent calls.** Launch these four
   subagents concurrently. Give each the **same briefing**: the reference commit, the
   "fixes since last review — do NOT re-flag" list, the known session specifics (format,
   length, blocks, presenters), the `SITE_URL`, and its exact output path.

   | agent | output path |
   |---|---|
   | `workshop-reviewer-technique` | `.claude/reviews/review-YYYY-MM-DD[-tag]-technique.md` |
   | `workshop-reviewer-pedagogue` | `.claude/reviews/review-YYYY-MM-DD[-tag]-pedagogue.md` |
   | `workshop-reviewer-beginner`  | `.claude/reviews/review-YYYY-MM-DD[-tag]-beginner.md` |
   | `workshop-reviewer-language`  | `.claude/reviews/review-YYYY-MM-DD[-tag]-language.md` |

   Each agent **writes its own dated report** and returns only a one-line summary (verdict +
   P0/P1/P2 counts). Do not ask them to return report bodies — they save via Write.

   > If the content is incomplete (early in the project), still run the relevant reviewers;
   > they will flag what can't yet be judged. Skip a reviewer only if its scope literally
   > doesn't exist yet (e.g. no prose → language reviewer has little to do).

4. **Collect & triage.** Once all reports are written, read them and produce a consolidated
   triage for me: the union of 🔴 P0 / 🟠 P1 / 🟡 P2 across reviewers, de-duplicated, with
   `file:line`. Recommend what to fix now (P0/P1) vs defer (P2). **Do not auto-fix** — wait
   for my go-ahead unless I tell you otherwise.

   **Check the premise of every finding you promote.** A reviewer can verify that something
   breaks without verifying that it happens here — a reproduction from a hand-written input, an
   absence claim from one file, a grep hit against a documented exception. Each agent is told to
   check this, and each cycle so far has still produced a few. For anything you put in the
   fix-now list, confirm the trigger exists in the material before it reaches me. Do not repeat a
   reviewer's confidence you have not checked; say which findings you verified and which you are
   relaying.

5. **Report discipline.** Reviews are **immutable snapshots**: never edit a past review —
   a re-review the same day gets a new file with a `bis`/`ter` tag. `.claude/reviews/` is
   local-only (gitignored) — the durable record of what changed is the commit message, and
   any lasting gotcha belongs in the matching `.claude/rules/` file.

## Conventions (recap)

- Review filename: `review-YYYY-MM-DD[-tag]-[type].md`, `[type]` ∈ `technique`, `pedagogue`,
  `beginner`, `language` (plus ad-hoc scope types like `content` when relevant).
- Same-day repeats: `-bis`, `-ter`, `-quater`.
- Each report format: verdict → 🔴P0 → 🟠P1 → 🟡P2 → ✅ strengths → 📝 evolution-since-last —
  every finding in `file:line`.
- Reports live in `.claude/reviews/` (gitignored). Promote anything durable into `.claude/rules/`.

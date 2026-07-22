#!/bin/bash
# PreToolUse(Bash) hook — block a `git commit` when a staged .qmd no longer matches its
# committed _freeze/ hash (i.e. you edited an executable page but forgot to re-render, so the
# frozen results are stale). Quarto's freeze hash is the MD5 of the LF-normalized source file.
#
# Deliberately small: this repo is simple and we know our files. Scope is commit-only (push
# follows already-gated commits) and the real backstop is a full `quarto render` at end of
# session, which refreshes every _freeze/ anyway. Pages with no _freeze/ (pure markdown, or no
# executable code) are skipped automatically.

# Only act on `git commit`. The PreToolUse payload (with the Bash command) arrives as JSON on stdin.
cmd=$(jq -r '.tool_input.command // ""' 2>/dev/null)
echo "$cmd" | grep -qE 'git[[:space:]]+commit' || exit 0

# Cross-platform MD5 of stdin, LF-normalized (macOS `md5 -r` / Linux `md5sum`).
md5_lf() { tr -d '\r' | { md5sum 2>/dev/null || md5 -r; } | cut -d' ' -f1; }

stale=""
while IFS= read -r qmd; do
  [ -n "$qmd" ] || continue
  # execute-results is html.json for BOTH html labs and revealjs decks (revealjs is html-family;
  # verified 2026-07-07 against Quarto 1.9.38 by rendering a deck with an R chunk) — one path fits.
  freeze="_freeze/${qmd%.qmd}/execute-results/html.json"

  # Stored hash: read the freeze JSON from git (staged, else last commit) — not the working tree,
  # so a re-rendered-but-unstaged freeze can't produce a false pass. Skip pages with no freeze.
  freeze_json=$(git show ":$freeze" 2>/dev/null || git show "HEAD:$freeze" 2>/dev/null)
  [ -n "$freeze_json" ] || continue
  stored=$(printf '%s' "$freeze_json" | jq -r '.hash // empty' 2>/dev/null)
  [ -n "$stored" ] || continue

  current=$(git show ":$qmd" 2>/dev/null | md5_lf)
  [ -n "$current" ] || continue
  [ "$current" = "$stored" ] || stale="${stale}  ${qmd}"$'\n'
done < <(git diff --cached --name-only 2>/dev/null | grep '\.qmd$')

if [ -n "$stale" ]; then
  {
    echo "_freeze/ is stale — these staged .qmd changed but their frozen results didn't:"
    printf '%s' "$stale"
    echo "Run: quarto render <file.qmd>  (or the whole site), then stage the updated _freeze/."
  } >&2
  exit 2
fi
exit 0

# Recover a clone after the 2026-08-03 history rewrite

## Symptom

On a clone created before 2026-08-03, `git pull` refuses because the local and remote histories are
unrelated. Use this procedure only for that symptom and only on the local `main` branch.

## Cause

The repository history was rewritten on 2026-08-03. Older clones no longer share a commit history
with the current remote repository.

## Recovery

1. Confirm the current branch:

   ```bash
   git branch --show-current
   ```

   Stop unless it prints `main`.

2. Check for uncommitted work:

   ```bash
   git status --short
   ```

   If this prints anything, stop and preserve those changes before continuing.

3. Fetch the current remote history and retain the old local history on a backup branch:

   ```bash
   git fetch origin
   git branch backup/pre-rewrite-2026-08-03 HEAD
   ```

   If the backup branch already exists, choose another name.

4. Reset local `main` to the remote branch:

   ```bash
   git reset --hard origin/main
   ```

The backup branch keeps the previous commits available for inspection or recovery.

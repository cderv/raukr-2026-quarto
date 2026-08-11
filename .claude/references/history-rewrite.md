# Recover a clone with unrelated history

## Symptom

After fetching `origin`, `git pull` reports unrelated histories, or `git merge-base main origin/main`
prints nothing and exits with a nonzero status. Use this procedure only for that symptom and only to
reset the local `main` branch.

## Cause

The repository history has been rewritten more than once. A clone or branch based on an earlier
root may share no ancestor with the current remote history.

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

3. Fetch the current remote history and verify the symptom:

   ```bash
   git fetch origin
   git merge-base main origin/main
   ```

   If `git merge-base` prints a commit, stop: the histories are related, so this procedure does not
   apply.

4. List local branches and retain the old local `main` on a backup branch:

   ```bash
   git branch --format='%(refname:short)'
   git branch backup/pre-rewrite-main HEAD
   ```

   If the backup branch already exists, choose another name. Note any feature branches that contain
   work you need to migrate. The reset below changes only `main`; it does not delete those branches.

5. Reset local `main` to the remote branch:

   ```bash
   git reset --hard origin/main
   ```

The backup and feature branches keep their previous commits available. After recovering `main`,
create new branches from the current history and cherry-pick any commits you still need. Do not merge
the unrelated histories.

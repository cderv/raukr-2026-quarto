---
paths:
  - justfile
  - "**/justfile"
---

# Rule — the `justfile` must stay cross-platform (Unix + native Windows)

Participants run this on their own machines. Many are on **Windows** (RStudio terminal, PowerShell,
cmd). The `justfile` must work there with **zero setup** — no Git Bash install, no PATH surgery, no WSL.

## The core facts (why the current setup is the way it is)

- `just`'s default shell is `sh -cu` on **every** OS, including Windows. Stock Windows has **no `sh`**
  on PATH → `just` fails with `could not find the shell 'sh'`. That's the error this rule prevents.
- We pin Windows to PowerShell (always present) at the top of the `justfile`:
  ```just
  set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]
  ```
  `windows-shell` takes precedence over `shell` **only on Windows**; Unix keeps the default `sh`.
- **Do not** point `windows-shell` at `bash`. On a contributor's machine `bash` may resolve to
  **WSL bash** (a Linux world: `/mnt/c/...` paths, Linux toolchain) before Git Bash — silent breakage.
  PowerShell is unambiguous.

## The house rules for editing the `justfile`

1. **Prefer plain `quarto <x>` linewise recipes.** `quarto` is one cross-platform binary; `quarto render`
   runs fine under both `sh` and PowerShell. No per-OS handling needed. Almost every recipe should be this.

2. **Any Unix-only shell command needs an OS split.** `rm -rf`, `cp`, `mv`, globbing, `&&`-chains with
   Unix tools, etc. do **not** run in PowerShell. Split the recipe with `[unix]` / `[windows]` attributes
   (two recipes, same name). Current example — `clean`:
   ```just
   [unix]
   clean:
       rm -rf _site .quarto

   [windows]
   clean:
       Remove-Item -Recurse -Force -ErrorAction SilentlyContinue _site, .quarto
   ```

3. **Script recipes (multi-line shell logic): use per-OS shebang variants, not a single recipe.**
   `set windows-shell` / `set shell` do **not** affect shebang or `[script]` recipes, and
   `script-interpreter` is a single global (no per-OS variant). So:
   ```just
   [unix]
   foo:
       #!/usr/bin/env bash
       set -euo pipefail
       ...

   [windows]
   foo:
       #!powershell.exe
       $ErrorActionPreference = "Stop"
       ...
   ```
   **Windows shebang gotcha:** a shebang containing `/` (e.g. `#!/usr/bin/env bash`) is run through
   `cygpath.exe` → requires Git Bash/Cygwin. A **bare** interpreter name (`#!powershell.exe`, `#!pwsh`,
   `#!python`) is executed directly, no cygpath. Windows variants must use the bare form.
   Better still: if two script bodies want shared logic, push it into an R script or a `quarto` call
   both variants invoke — bash and PowerShell aren't the same language, there's no DRY shortcut.

4. **Sanity check before committing a `justfile` change:** `just --list` and `just --dry-run <recipe>`
   here (Unix) at minimum. Windows can't be tested in the sandbox — reason about it via the rules above.

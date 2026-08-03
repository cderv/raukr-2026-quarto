# RaukR 2026 Quarto — build orchestrator.
# `just` with no recipe lists them all. `quarto render` alone is the whole build for now;
# recipes grow (profiles, publishing) as content lands.

# Cross-platform: unix uses just's default `sh`; Windows has no `sh` on a stock PATH,
# so point it at PowerShell (always present — no Git Bash install needed). Almost every
# recipe just calls the cross-platform `quarto` binary; only `clean` needs an OS variant.
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# Where each publish target lands (printed once the publish succeeds)
gh_url := "https://cderv.github.io/raukr-2026-quarto/"
connect_url := "https://connect.posit.cloud/cderv/content/019f5c4d-f1c7-0d48-88b9-b10861a493e7"

# List available recipes
default:
    @just --list

# Install R deps pinned in renv.lock
deps:
    Rscript -e "renv::restore(prompt = FALSE)"

# Render the whole site to _site/
render:
    quarto render

# Live preview with auto-reload
preview:
    quarto preview

# Regenerate the participant exercises tree (exercises/) from labs/ + tools/exercises-scaffold/
exercises:
    Rscript tools/sync-exercises.R

# Verify exercises/ is in sync with its sources (regenerate + fail on drift) — same command as CI
exercises-check:
    Rscript tools/sync-exercises.R --check

# Sync + publish exercises/ to the participant repo's main (pass a URL to retarget a new year)
[confirm("Publish exercises/ to the exercises repo main? This pushes a fresh sync.")]
publish-exercises repo="https://github.com/cderv/raukr-2026-quarto-exercises.git": exercises
    Rscript tools/publish-exercises.R "{{ repo }}"

# Remove build artifacts
[unix]
clean:
    rm -rf _site .quarto

[windows]
clean:
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue _site, .quarto

# Shared target dispatch (private recipe): just's native conditional, NOT a shebang —
# the emitted `quarto publish …` line is one cross-platform binary call, so it runs under
# both sh and PowerShell (see .claude/rules/justfile.md). `--no-render` because `publish`
# renders first; `error(...)` gives a helpful message instead of an obscure failure.
# The second line echoes the resulting URL (`echo` exists in both sh and PowerShell);
# an unknown target aborts on the first line, so it never prints a URL.
_publish target:
    {{ if target == "gh" { "quarto publish gh-pages --no-prompt --no-render" } else if target == "connect" { "quarto publish posit-connect-cloud --no-prompt --no-render" } else { error("Unknown target: '" + target + "' — use 'gh' or 'connect'") } }}
    @echo "Live at {{ if target == "gh" { gh_url } else { connect_url } }}"

# Publish the whole site: just publish gh       →  GitHub Pages (gh-pages branch)
#                         just publish connect  →  Posit Connect Cloud
[confirm("Publish the whole site? This renders, then pushes to the chosen target.")]
publish target: render (_publish target)

# Publish without rebuilding (when `just render` already ran)
[confirm("Publish the whole site (no rebuild)?")]
publish-only target: (_publish target)

# RaukR 2026 Quarto — build orchestrator.
# `just` with no recipe lists them all. `quarto render` alone is the whole build for now;
# recipes grow (profiles, publishing) as content lands.

# Cross-platform: unix uses just's default `sh`; Windows has no `sh` on a stock PATH,
# so point it at PowerShell (always present — no Git Bash install needed). Almost every
# recipe just calls the cross-platform `quarto` binary; only `clean` needs an OS variant.
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

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
_publish target:
    {{ if target == "gh" { "quarto publish gh-pages --no-prompt --no-render" } else if target == "connect" { "quarto publish posit-connect-cloud --no-prompt --no-render" } else { error("Unknown target: '" + target + "' — use 'gh' or 'connect'") } }}

# Publish the whole site: just publish gh       →  GitHub Pages (gh-pages branch)
#                         just publish connect  →  Posit Connect Cloud
[confirm("Publish the whole site? This renders, then pushes to the chosen target.")]
publish target: render (_publish target)

# Publish without rebuilding (when `just render` already ran)
[confirm("Publish the whole site (no rebuild)?")]
publish-only target: (_publish target)

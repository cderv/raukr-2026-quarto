# RaukR 2026 Quarto build commands.

# Use PowerShell on Windows; recipes must stay cross-platform.
set windows-shell := ["powershell.exe", "-NoLogo", "-Command"]

# R reports its locale in the labs' Session block, so an unpinned build records whoever ran it and
# the freeze churns from machine to machine. Exported to every recipe on both shells.
export LC_ALL := "C"

# Where each publish target lands (printed once the publish succeeds)
gh_url := "https://cderv.github.io/raukr-2026-quarto/"
connect_url := "https://connect.posit.cloud/cderv/content/019f5c4d-f1c7-0d48-88b9-b10861a493e7"

# List available recipes
default:
    @just --list

# Install R deps pinned in renv.lock
deps:
    Rscript -e "renv::restore(prompt = FALSE)"

# Render the whole site to _site/, then the demos into _site/demos/
render: && demos
    quarto render

# Render the finished lab documents to _site/demos/ (for showing on screen during the sessions)
demos:
    Rscript tools/render-demos.R

# Live preview with auto-reload
preview:
    quarto preview

# Regenerate the participant exercises tree (exercises/) from labs/ + tools/exercises-scaffold/
exercises:
    Rscript tools/sync-exercises.R

# Verify exercises/ is in sync with its sources (regenerate + fail on drift) — same command as CI
exercises-check:
    Rscript tools/sync-exercises.R --check

# Re-syncs first, like publish-exercises does, so `just render` demo artifacts left inside
# exercises/solutions/day2/ are not reported as drift.
#
# Verify the DELIVERY repo matches exercises/ (i.e. participants download what this repo ships)
published-check: exercises
    Rscript tools/publish-exercises.R --check

# Sync + publish exercises/ to the participant repo's main (pass a URL to retarget a new year)
[confirm("Publish exercises/ to the exercises repo main? This pushes a fresh sync.")]
publish-exercises repo="https://github.com/cderv/raukr-2026-quarto-exercises.git": exercises
    Rscript tools/publish-exercises.R "{{ repo }}"

# Remove build artifacts
[unix]
clean:
    rm -rf _site .quarto demos-build

[windows]
clean:
    Remove-Item -Recurse -Force -ErrorAction SilentlyContinue _site, .quarto, demos-build

# Keep target selection inside just so it works in both shells.
_publish target:
    {{ if target == "gh" { "quarto publish gh-pages --no-prompt --no-render" } else if target == "connect" { "quarto publish posit-connect-cloud --no-prompt --no-render" } else { error("Unknown target: '" + target + "' — use 'gh' or 'connect'") } }}
    @echo "Live at {{ if target == "gh" { gh_url } else { connect_url } }}"

# Render, then publish the whole site to the chosen target
[confirm("Publish the whole site? This renders, then pushes to the chosen target.")]
publish target: render (_publish target)

# Publish without rebuilding (when `just render` already ran)
[confirm("Publish the whole site (no rebuild)?")]
publish-only target: (_publish target)

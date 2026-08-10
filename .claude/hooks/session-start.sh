#!/bin/bash
# SessionStart hook — prepares a Claude Code on the web (remote) sandbox for
# working on this Quarto + R workshop repo. It is a no-op on local machines.
#
# What it does (all guarded, all idempotent, all non-fatal):
#   1. Set the commit identity so sandbox commits carry the right author.
#   2. Apply the two sandbox prerequisites that R requires (UTF-8 locale; the
#      proxy's self-signed CA that R's curl must be pointed at).
#   3. Asynchronously install the toolchain: R (CRAN apt), Quarto, just (cargo),
#      plus the two tools the slide fit-check needs (simple-http-server, agent-browser).
#
# Install-source strategy (deliberate — see .claude/references/sandbox-setup.md):
#   - R    → CRAN apt repo (cloud.r-project.org). No GitHub.
#   - just → `cargo install just` (crates.io). No GitHub.
#   - simple-http-server → crates.io, same reason as just.
#   - agent-browser → npm registry, then its own `install --with-deps` for Chromium.
#   - Quarto → GitHub releases (its ONLY distribution). Version resolved from
#     quarto.org so it's never stale. This is the one step that needs the web
#     environment's network policy to allow github.com; if it's blocked, Quarto
#     won't install and you must widen the environment's network policy.
# Earlier versions parsed GitHub's HTML release pages, which proxy policies often block.
# Use only direct or pinned URLs here.
set -euo pipefail

# Only run in remote (Claude Code on the web) environments.
if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

# --- Synchronous prerequisites: git identity + locale + CA (R requires these) ---

# Commit identity for sandbox commits. Remote-only, so local sessions keep the developer's own
# global identity untouched.
#
# The test is on the LOCAL config on purpose. The old version tested `git config user.email`, i.e.
# the EFFECTIVE identity -- and the base image now ships a global one (Claude <noreply@anthropic.com>),
# so that test always succeeded, no local identity was ever set, and commits came out authored by
# the instructor (GIT_AUTHOR_* is supplied by the platform) but COMMITTED by Claude. Every other
# commit in this history has the same person on both sides; caught 2026-08-03.
#
# Still only fills a GAP, and still never stamps this repo's author onto someone else's commits:
# the identity comes from GIT_AUTHOR_*, which the platform sets per user, so a fork or another
# contributor gets their own. The hardcoded fallback applies only when the platform supplies nothing.
if [ -z "$(git config --local user.email 2>/dev/null)" ]; then
  git config --local user.name "${GIT_AUTHOR_NAME:-Christophe Dervieux}" || true
  git config --local user.email "${GIT_AUTHOR_EMAIL:-christophe.dervieux@gmail.com}" || true
fi

# a) Locale: the image starts in C/POSIX, which breaks reading UTF-8 .qmd/.yml.
if ! grep -q 'LANG=C.UTF-8' ~/.bashrc 2>/dev/null; then
  printf '\nexport LANG=C.UTF-8\nexport LC_ALL=C.UTF-8\n' >> ~/.bashrc
fi
if ! grep -q 'LANG=C.UTF-8' ~/.profile 2>/dev/null; then
  printf '\nexport LANG=C.UTF-8\nexport LC_ALL=C.UTF-8\n' >> ~/.profile
fi
printf 'LANG=C.UTF-8\nLC_ALL=C.UTF-8\n' > /etc/environment 2>/dev/null || true
export LANG=C.UTF-8 LC_ALL=C.UTF-8

# b) Proxy with a self-signed CA: base-R's curl finds no packages until it is
#    pointed at the system CA bundle. Also select P3M Linux binaries (fast).
#    NOTE: pak works here (verified 2026-07-21) and is used in step 5 for system
#    requirements; install.packages()/renv stay the pinning path. (See sandbox-setup.md.)
update-ca-certificates 2>/dev/null || true
if [ ! -f ~/.Rprofile ]; then
  cat > ~/.Rprofile <<'RPROF'
local({
  ca <- "/etc/ssl/certs/ca-certificates.crt"
  if (file.exists(ca)) Sys.setenv(CURL_CA_BUNDLE = ca, SSL_CERT_FILE = ca)
  options(
    repos = c(P3M = "https://packagemanager.posit.co/cran/__linux__/noble/latest"),
    HTTPUserAgent = sprintf("R/%s R (%s)", getRversion(),
      paste(getRversion(), R.version$platform, R.version$arch, R.version$os)),
    Ncpus = max(1L, parallel::detectCores())
  )
})
RPROF
fi

# --- Hand back to the session; the toolchain install runs asynchronously. ---
echo '{"async": true, "asyncTimeout": 600000}'

# 1. R — install the CURRENT R (renv.lock wants 4.6.x; the base-R `datasets::penguins` the whole
#    arc uses needs R >= 4.5). Prefer **rig** (r-lib): its apt repo + the Posit R-builds CDN it
#    pulls from are both non-GitHub, and it manages versions cleanly. Fall back to the CRAN apt
#    repo. ROOT-CAUSE NOTE: a broken third-party PPA (e.g. ondrej/php changing its Label) makes
#    `apt-get update` exit 100. Later apt installs then fail because the CRAN repo was not indexed;
#    R falls back to Ubuntu's 4.3.3 package, and rig cannot install system requirements.
#    `--allow-releaseinfo-change` lets both paths continue.
apt-get update --allow-releaseinfo-change -qq 2>/dev/null || true
r_lt_45() { c=$(R --version 2>/dev/null | sed -n '1s/.*version \([0-9.]*\).*/\1/p'); \
  [ -z "$c" ] || [ "$(printf '%s\n4.5.0\n' "$c" | sort -V | head -1)" != "4.5.0" ]; }
if r_lt_45; then
  echo "Installing current R via rig..."
  {
    command -v rig >/dev/null 2>&1 || {
      curl -fsSL https://rig.r-pkg.org/deb/rig.gpg -o /etc/apt/trusted.gpg.d/rig.gpg &&
      echo "deb http://rig.r-pkg.org/deb rig main" > /etc/apt/sources.list.d/rig.list &&
      apt-get update -qq --allow-releaseinfo-change && apt-get install -y r-rig; } &&
    rig add release && rig default release
  } || echo "rig R install failed — trying CRAN apt..."
fi
if r_lt_45; then   # rig unavailable/failed → CRAN apt (now that update is resilient, resolves 4.6.x)
  echo "Installing R from CRAN apt repo..."
  {
    curl -fsSL https://cloud.r-project.org/bin/linux/ubuntu/marutter_pubkey.asc \
      -o /etc/apt/trusted.gpg.d/cran.asc &&
    echo "deb https://cloud.r-project.org/bin/linux/ubuntu noble-cran40/" \
      > /etc/apt/sources.list.d/cran.list &&
    apt-get update -qq --allow-releaseinfo-change &&
    apt-get install -y --no-install-recommends r-base r-base-dev
  } || echo "R install failed (non-fatal) — check the env allows the rig / cloud.r-project.org hosts"
fi

# 2. Quarto — prefer the official .deb. Try GitHub releases first (canonical), then
#    Posit's Cloudsmith CDN (dl.posit.co — the SAME official .deb, non-GitHub), then
#    conda-forge via micromamba as a last resort. Version resolved from quarto.org
#    (non-GitHub, never stale), pinned as fallback.
#    NOTE: on Claude-Code-on-the-web the egress proxy scopes github.com to the session's
#    source repos, so quarto-dev/quarto-cli returns 403 ("not enabled for this session").
#    The Cloudsmith .deb is the clean fallback there — identical binary, standard layout,
#    no wrapper. conda-forge repackages the same bundled deno/pandoc/typst but needs a
#    PATH wrapper. See .claude/references/sandbox-setup.md § Quarto.
if ! command -v quarto >/dev/null 2>&1; then
  QV=$(curl -fsSL https://quarto.org/docs/download/_download.json 2>/dev/null \
        | python3 -c "import json,sys; print(json.load(sys.stdin).get('version',''))" 2>/dev/null)
  QV="${QV:-1.9.38}"   # fallback pin — bump when convenient
  DEB="quarto-${QV}-linux-amd64.deb"
  echo "Installing Quarto ${QV} (.deb)..."
  curl -fSL -o /tmp/quarto.deb \
    "https://github.com/quarto-dev/quarto-cli/releases/download/v${QV}/${DEB}" 2>/dev/null \
    || { echo "GitHub blocked (proxy scopes github.com per source-repo) — trying Posit Cloudsmith..."; \
         curl -fSL -o /tmp/quarto.deb \
           "https://dl.posit.co/public/open/deb/any-distro/pool/any-version/main/q/qu/quarto_${QV}/${DEB}" 2>/dev/null; }
  if [ -s /tmp/quarto.deb ]; then apt-get install -y /tmp/quarto.deb && rm -f /tmp/quarto.deb; \
    else echo ".deb unavailable from GitHub and Cloudsmith — trying conda-forge..."; fi
fi
# Fallback: conda-forge via micromamba (no GitHub). Installs into /opt/quarto and drops a
# PATH wrapper exporting the QUARTO_* deps the bare conda launcher needs (deno/pandoc/typst).
if ! command -v quarto >/dev/null 2>&1; then
  QV="${QV:-1.9.38}"
  echo "Installing Quarto ${QV} from conda-forge (micromamba)..."
  {
    curl -sSL "https://micro.mamba.pm/api/micromamba/linux-64/latest" -o /tmp/mm.tar.bz2 &&
    tar -xjf /tmp/mm.tar.bz2 -C /tmp bin/micromamba &&
    MAMBA_ROOT_PREFIX=/opt/mamba /tmp/bin/micromamba create -y -p /opt/quarto \
      --override-channels -c conda-forge "quarto=${QV}" &&
    cat > /usr/local/bin/quarto <<'QWRAP' &&
#!/bin/sh
export QUARTO_DENO=/opt/quarto/bin/deno
export QUARTO_PANDOC=/opt/quarto/bin/pandoc
export QUARTO_ESBUILD=/opt/quarto/bin/esbuild
export QUARTO_TYPST=/opt/quarto/bin/typst
export QUARTO_DART_SASS=/opt/quarto/bin/sass
export QUARTO_SHARE_PATH=/opt/quarto/share/quarto
export QUARTO_CONDA_PREFIX=/opt/quarto
export DENO_DOM_PLUGIN=/opt/quarto/lib/deno_dom.so
export QUARTO_DENO_DOM=/opt/quarto/lib/deno_dom.so
export TYPST_PACKAGE_PATH=/opt/quarto/share/typst/packages
export TYPST_FONT_PATHS=/opt/quarto/fonts
exec /opt/quarto/bin/quarto "$@"
QWRAP
    chmod +x /usr/local/bin/quarto
  } || echo "Quarto conda-forge fallback failed (non-fatal)"
fi

# 3. just — via cargo (crates.io), best-effort; only needed once a justfile exists.
if ! command -v just >/dev/null 2>&1 && command -v cargo >/dev/null 2>&1; then
  echo "Installing just via cargo..."
  cargo install just --quiet 2>/dev/null || echo "just install failed (non-fatal)"
fi

# 4. R packages — restore the renv-locked environment (renv.lock) into the project library.
#    The project ./.Rprofile bootstraps renv and sources ~/.Rprofile first (for the proxy CA).
#    We pass the platform-specific P3M URL so renv fetches noble *binaries* (no compilation,
#    no -dev system libs); the committed lockfile itself stays platform-neutral (cran/latest).
#    Add packages by editing DESCRIPTION + `renv::snapshot()`, not here.
if command -v R >/dev/null 2>&1 && [ -f renv.lock ]; then
  echo "Restoring R packages with renv (P3M binaries)..."
  # renv discards the entire restore if one package fails. bitops can report a misleading dependency
  # error involving gt. renv::restore() reports that error for bitops alone too, so install the
  # binary directly first and let the complete restore skip it.
  Rscript -e 'try(renv::install("bitops",
      repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/noble/latest"),
      prompt = FALSE), silent = TRUE)' \
    || true
  Rscript -e 'renv::restore(repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/noble/latest"), prompt = FALSE)' \
    || echo "renv restore failed (non-fatal) — run renv::restore() from an R session in the repo root"
fi

# 5. System requirements — let pak install the -dev libs that SOURCE installs need. renv's binary
#    restore (step 4) needs none, but an agent installing a package with no P3M binary does. We are
#    root + passwordless sudo, so pak runs apt itself; the missing list is derived from installed
#    packages' SystemRequirements, so it stays correct as the dep set grows. All non-fatal.
if command -v R >/dev/null 2>&1; then
  echo "Ensuring system requirements via pak (sysreqs_fix_installed)..."
  Rscript -e '
    if (!requireNamespace("pak", quietly = TRUE))
      try(install.packages("pak", repos = "https://packagemanager.posit.co/cran/__linux__/noble/latest"), silent = TRUE)
    if (requireNamespace("pak", quietly = TRUE))
      try(pak::sysreqs_fix_installed(), silent = TRUE)
  ' 2>/dev/null || echo "pak sysreqs step skipped (non-fatal)"
fi

# 6. Slide fit-check tooling — a static server plus a browser driver. Checking whether a revealjs
#    slide overflows its 720 px frame means measuring it in a real browser (see rules/slides.md § 1).
#    Serve the deck over HTTP because its JavaScript does not run correctly over `file://`.
#    `.claude/scripts/slide-shot.mjs` is the older path and only works here, because it imports
#    Playwright from a hardcoded /opt/node22 path; agent-browser is the one that also works on the
#    instructor's machine, so prefer it and keep the two environments on the same recipe.
if ! command -v simple-http-server >/dev/null 2>&1 && command -v cargo >/dev/null 2>&1; then
  echo "Installing simple-http-server via cargo..."
  cargo install simple-http-server --quiet 2>/dev/null \
    || echo "simple-http-server install failed (non-fatal)"
fi
if ! command -v agent-browser >/dev/null 2>&1 && command -v npm >/dev/null 2>&1; then
  echo "Installing agent-browser (npm) + its Chromium..."
  # --with-deps pulls the system libraries headless Chromium needs on a bare Ubuntu image. We are
  # root here, so it can apt them itself.
  { npm install -g agent-browser >/dev/null 2>&1 && agent-browser install --with-deps >/dev/null 2>&1; } \
    || echo "agent-browser install failed (non-fatal) — slide fit-checks will need another route"
fi

command -v R >/dev/null 2>&1 && echo "R: $(R --version | head -1)"
command -v quarto >/dev/null 2>&1 && echo "Quarto: $(quarto --version)"
command -v just >/dev/null 2>&1 && echo "just: $(just --version)"
command -v simple-http-server >/dev/null 2>&1 && echo "simple-http-server: present"
command -v agent-browser >/dev/null 2>&1 && echo "agent-browser: $(agent-browser --version)"
echo "Sandbox setup done."

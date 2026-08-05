# Sandbox setup (Claude Code on the web / blank sandbox)

Referenced from `.claude/CLAUDE.md`. Most of this is **automated by the SessionStart hook**
(`.claude/hooks/session-start.sh`) on remote sessions — this file is the manual/explanatory
companion: what the hook does and why, and how to reproduce it by hand if the hook is
disabled or a step fails. In a normal local session, nothing to do here.

> **The container is ephemeral**: everything below (packages, `~/.Rprofile`, locale) is lost
> when the container is reclaimed. It re-runs on each new sandbox.

## 0. Two sandbox gotchas to fix first (or R breaks)

Neither is in the default image; both block R package installs and reading accented UTF-8
files. The hook does both — here they are explicitly:

```bash
# a) Locale: the image boots in C/POSIX → reading UTF-8 .qmd/.yml can fail
#    ("invalid input" / YAML scanner errors on accented files).
printf '\nexport LANG=C.UTF-8\nexport LC_ALL=C.UTF-8\n' >> ~/.bashrc
printf '\nexport LANG=C.UTF-8\nexport LC_ALL=C.UTF-8\n' >> ~/.profile
printf 'LANG=C.UTF-8\nLC_ALL=C.UTF-8\n' > /etc/environment
export LANG=C.UTF-8 LC_ALL=C.UTF-8   # current shell

# b) Proxy with a self-signed CA: base-R's curl finds no packages
#    ("SSL: self signed certificate in certificate chain"). The system bundle
#    /etc/ssl/certs/ca-certificates.crt already contains the proxy CA; point R
#    at it and select P3M Ubuntu-noble binaries.
update-ca-certificates
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
```

> ⚠ **The locale export (a) reaches login/interactive shells — not every non-interactive shell.**
> Tool / sub-agent Bash shells (and some CI steps) can still boot in `C`/POSIX, so an R-side render
> that calls `read_brand_yml()` on a **non-ASCII `_brand.yml`** fails there (empty palette →
> `invalid color name "…"`) even though the SessionStart hook "set the locale". Surfaced 2026-07-21
> by the setup-page student walkthrough. The durable fix is to keep **`_brand.yml` (and any config R
> parses) ASCII-only** so the render is locale-proof regardless of shell — see
> `multi-day-workshop-scaffold.md` § 5 for the rationale + the `LC_ALL=C` check.

> ✅ **pak works in this sandbox** (verified 2026-07-21, pak 0.11.0): it installs packages through
> the proxy — metadata DB and P3M binaries both fetch cleanly — so the earlier "bundled libcurl
> ignores `CURL_CA_BUNDLE`" failure **no longer reproduces**. `install.packages()` / `renv` remain
> the pinning path; **pak's real value here is system requirements** (see § 2.1). *(If a future
> session ever hits pak TLS failures again, fall back to `install.packages()`, which honors the CA
> bundle.)*

## 1. Toolchain: R, Quarto, just

Install-source strategy (chosen to minimize the GitHub dependency, because the sandbox's
network policy may block github.com — see the note below):

- **R → rig** (`rig.r-pkg.org` apt repo + the Posit R-builds CDN, both non-GitHub), CRAN apt as
  fallback. rig installs the **current** R (matches `renv.lock`, which wants **4.6.x**) instead of
  Ubuntu's stale `r-base`. **⚠️ Root cause of the "R 4.3.3" bug:** a broken third-party PPA
  (`ondrej/php` changed its `Label`) made `apt-get update` **exit 100**, silently starving every
  downstream install — so the CRAN repo never got indexed and R fell back to Ubuntu universe's
  **4.3.3**. `apt-get update --allow-releaseinfo-change` fixes it (and lets rig's sysreqs step run).
  ```bash
  apt-get update --allow-releaseinfo-change -qq || true   # <- the load-bearing fix
  # rig (preferred): non-GitHub, version-managed, installs current R from the Posit CDN
  curl -fsSL https://rig.r-pkg.org/deb/rig.gpg -o /etc/apt/trusted.gpg.d/rig.gpg
  echo "deb http://rig.r-pkg.org/deb rig main" > /etc/apt/sources.list.d/rig.list
  apt-get update -qq --allow-releaseinfo-change && apt-get install -y r-rig
  rig add release && rig default release          # -> R 4.6.1, /usr/local/bin/R
  # CRAN apt fallback (now that update is resilient, r-base-core resolves to 4.6.x):
  # curl .../marutter_pubkey.asc -o /etc/apt/trusted.gpg.d/cran.asc; echo "deb .../noble-cran40/" > ...;
  # apt-get update --allow-releaseinfo-change && apt-get install -y r-base r-base-dev
  ```
  After a fresh R lands, restore the library for the new R version (§ 2): `renv::restore(...)`.
- **just → `cargo install just`** (crates.io), no GitHub. Only needed once a justfile exists.
- **Slide fit-check pair → `cargo install simple-http-server` + `npm install -g agent-browser`**,
  then `agent-browser install --with-deps` for headless Chromium and the system libraries a bare
  Ubuntu image lacks. Neither touches GitHub. Deciding whether a revealjs slide overflows its 720 px
  frame means measuring it in a real browser (`rules/slides.md` § 1), and `file://` is more trouble
  than serving the built `_site/` over http. Prefer this pair over
  `.claude/scripts/slide-shot.mjs`, which imports Playwright from a hardcoded `/opt/node22` path and
  therefore runs **only** here — the same recipe then works on the instructor's machine too.
- **Quarto → official `.deb`, with fallbacks.** Quarto's canonical distribution is GitHub
  releases, but on the web sandbox the egress proxy **scopes github.com to the session's source
  repos**, so `quarto-dev/quarto-cli` returns `403` ("not enabled for this session"). The hook
  tries three sources in order and takes the first that works:
  1. **GitHub** `.deb` — canonical; works on local / unscoped envs.
  2. **Posit Cloudsmith** `.deb` (`dl.posit.co`) — the **same official binary**, non-GitHub, so
     it sails through the proxy; clean apt install, standard layout. *This is what succeeds on
     Claude-Code-on-the-web.*
  3. **conda-forge** via micromamba (`micro.mamba.pm` + `conda.anaconda.org`) — repackages the
     same bundled deno/pandoc/typst into `/opt/quarto`; needs a small PATH wrapper exporting the
     `QUARTO_*` vars the bare conda launcher expects. Last resort.
  Version is resolved from `quarto.org/docs/download/_download.json` (non-GitHub, never stale),
  pinned as fallback:
  ```bash
  QV=$(curl -fsSL https://quarto.org/docs/download/_download.json | \
       python3 -c "import json,sys; print(json.load(sys.stdin)['version'])")
  DEB="quarto-${QV}-linux-amd64.deb"
  # GitHub (canonical) → Posit Cloudsmith (same .deb, non-GitHub, unscoped)
  curl -fSL -o /tmp/quarto.deb "https://github.com/quarto-dev/quarto-cli/releases/download/v${QV}/${DEB}" \
    || curl -fSL -o /tmp/quarto.deb "https://dl.posit.co/public/open/deb/any-distro/pool/any-version/main/q/qu/quarto_${QV}/${DEB}"
  apt-get install -y /tmp/quarto.deb
  ```

> **Network policy matters.** Outbound access is set by the environment's network policy. R (CRAN),
> just (crates.io), and the **Posit Cloudsmith / conda-forge** Quarto fallbacks work under the
> default web policy; only the *GitHub* `.deb` needs github.com opened. If all three Quarto sources
> fail, widen the policy (or add `quarto-dev/quarto-cli` as a session source, which lifts the
> per-repo github scoping). Note: any `GH_TOKEN` in the sandbox is proxy-scoped to the session's
> repos — it does **not** grant third-party release-asset access, so don't rely on it for installs.

## 2. R packages — via **renv** (P3M binaries, fast)

R dependencies are pinned with **renv** (`renv.lock`), so every machine restores the *same*
package versions. The hook (step 4) runs `renv::restore()`; by hand it's:

```bash
# from the repo root — ./.Rprofile bootstraps renv and sources ~/.Rprofile (proxy CA) first
Rscript -e 'renv::restore(repos = c(CRAN = "https://packagemanager.posit.co/cran/__linux__/noble/latest"), prompt = FALSE)'
```

Two things make this fast and portable:

- **P3M binaries, no compilation.** The committed `renv.lock` records the *platform-neutral*
  `https://packagemanager.posit.co/cran/latest`. On this sandbox we pass the platform-specific
  URL (`.../cran/__linux__/noble/latest`) to `restore()` so P3M serves **pre-built noble
  binaries** — no `-dev` system libraries, no build chain (only `r-base`). We pass it explicitly
  because renv's automatic PPM→binary rewrite needs a PPM status probe that the **egress proxy
  blocks**, so without the override renv silently falls back to compiling from source (slow, and
  it then wants `libcurl4-openssl-dev`, `libxml2-dev`, `libnode-dev`, …). The `__linux__/noble`
  override sidesteps all of that.
- **The project `.Rprofile` shadows `~/.Rprofile`.** R reads only one user profile; renv writes a
  project `.Rprofile` (`source("renv/activate.R")`). We prepend `if (file.exists("~/.Rprofile"))
  source("~/.Rprofile")` so the proxy CA bundle + repos are still set before renv fetches. Without
  it, restore fails TLS behind the proxy.

**Managing the dependency set.** The lock is an **explicit** snapshot
(`renv::settings$snapshot.type("explicit")`) driven by the repo's `DESCRIPTION` `Imports:`. To add
a package: add it to `DESCRIPTION`, `renv::install("pkg")`, `renv::snapshot()`, commit `renv.lock`.
Current set: **knitr + rmarkdown** (the Quarto knitr *engine* — a `.qmd` with R chunks fails
without them: `there is no package called 'rmarkdown'`) and **ggplot2 / dplyr / gt** (content).

> ✅ **R ≥ 4.5 for the content dataset — resolved (2026-07-08).** The whole arc uses base-R
> `datasets::penguins`, which only exists in **R 4.5.0+**. Earlier the sandbox landed **R 4.3.3**
> (the broken-PPA `apt-get update` bug above starved the CRAN repo), where `data(penguins)` errored
> and `quarto render` of any penguins page failed at the R chunk — even though Quarto + the knitr
> engine were fine. **Now fixed**: rig installs **R 4.6.1** (matching `renv.lock`), `data(penguins)`
> resolves with the expected columns, and a penguins → knitr → **Typst PDF** render succeeds end to
> end. If a future session regresses to 4.3.3, it means `apt-get update` failed — apply the
> `--allow-releaseinfo-change` fix in § 1.

### 2.1 System requirements — via **pak** (self-healing in the hook)

The renv binary restore (§ 2) needs **no** `-dev` system libraries — that's the whole point of the
P3M `__linux__/noble` binary URL. But anything installed **from source** (an agent trying a package
with no P3M binary, a compiled dep of `devtools::load_all()`) does need them, and the base image
ships without `libcurl4-openssl-dev`, `libxml2-dev`, `libnode-dev`, or `pandoc`.

**pak detects and repairs this** — the sandbox runs as `root` with passwordless `sudo`, so pak runs
the `apt` install itself (no "ask an administrator" step — *we* are the administrator):

```r
pak::sysreqs_check_installed()   # table: which system pkgs are installed vs missing, and why
pak::sysreqs_fix_installed()     # apt-get installs the missing ones (auto, because root)
pak::pkg_sysreqs("V8")           # what a not-yet-installed package will need + the shell command
# options(pak.sysreqs_dry_run = TRUE)  # print the command instead of running it
```

The **SessionStart hook now runs `sysreqs_fix_installed()` (step 5)** so a fresh sandbox self-heals
the four missing libs — source installs "just work" without a manual apt step. The list is derived
from the installed packages' `SystemRequirements`, so it stays correct as the dependency set grows.
All non-fatal: if pak or the apt step fails, the binary renv restore (§ 2) is unaffected.

## 3. End-to-end check

```bash
LANG=C.UTF-8 LC_ALL=C.UTF-8 quarto render     # once there is content to render
quarto --version && quarto typst --version    # Typst is bundled with Quarto
```

> **~~Known live-render failure masked by freeze (2026-07-20)~~ — NO LONGER REPRODUCES (2026-08-03).**
> `labs/quarto/sample-typst.qmd` used to throw a `gt` `check_named_colors` error when its R chunks
> executed *live*, which meant you could not re-freeze it here. On **Quarto 1.10.18 / R 4.6.1** it
> renders cleanly: verified twice from the participant payload (`quarto render
> day1-intro/sample-typst.qmd`), once via `00-check-setup.R` and once standalone, in both `C.UTF-8`
> and a bare `C` locale. It was almost certainly the `gt`/`brand.yml` version skew the old note
> guessed at, resolved by the current pins. **Re-freezing this file is safe** — the old warning was
> discouraging a legitimate operation.

## Toolchain — verified working end to end (2026-08-03)

The full stack installs and runs in this sandbox; earlier sessions worked blind because it didn't.
Running `.claude/hooks/session-start.sh` with `CLAUDE_CODE_REMOTE=true` set installs everything:

| tool | version |
|---|---|
| R | 4.6.1 |
| Quarto | 1.10.18 (Cloudsmith `.deb` path; GitHub releases are proxy-blocked) |
| just | 1.57.0 (`cargo install`) |

**Gotcha — `renv::restore()` fails on a cold cache** with a spurious circular error:
`failed to install "bitops", "gt"` reported as *"bitops: dependency failed (gt)"* and
*"gt: dependency failed (bitops)"*. They do not depend on each other. Fix:

```sh
Rscript -e 'install.packages(c("bitops","gt"))'   # then re-run
Rscript -e 'renv::restore(prompt = FALSE)'        # -> "No issues found"
```

**Rendering a single `.qmd` needs the project library on PATH** if you render outside the project
root: `export R_LIBS_USER=<repo>/renv/library/linux-ubuntu-noble/R-4.6/x86_64-pc-linux-gnu`.
Without it Quarto reports "The knitr package is not available" even though the project is restored.

### Verifying rendered output (accessibility, contrast, computed styles)

Playwright is the global install at `/opt/node22/lib/node_modules/playwright/index.mjs`; Chromium is
preinstalled (`PLAYWRIGHT_BROWSERS_PATH=/opt/pw-browsers`) — never run `playwright install`.

- **axe-core ships inside Quarto** at `/opt/quarto/share/formats/html/axe/axe.min.js`. Inject it with
  `page.addScriptTag({ path: … })` and call `window.axe.run(document, { resultTypes: ['violations'] })`.
  You do **not** need `axe:` in the document front matter to scan a rendered page.
- **`axe: {output: json}` writes to the browser console, not to a file** — capture it with a
  Playwright `console` listener.
- **Serve over HTTP; `file://` breaks it.** The axe module and `quarto.js` are ES modules and get
  CORS-blocked on `file://`. `npx http-server -p <port> -s _site` works.
- **Composite the background stack over white before computing a contrast ratio.** Quarto's code
  background is `rgba(…, .65)`; reading the raw `background-color` gives a too-harsh number and
  invents failures that aren't there.

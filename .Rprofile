# Sandbox (Claude Code on the web): the proxy's CA bundle + P3M repos are set in ~/.Rprofile,
# which this project-level .Rprofile would otherwise shadow (R reads only one user profile).
# Source it first so renv can fetch packages behind the proxy. No-op on a machine without it.
if (file.exists("~/.Rprofile")) source("~/.Rprofile")

source("renv/activate.R")

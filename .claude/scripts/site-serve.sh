#!/usr/bin/env bash
# Serve the built site over HTTP so a reviewer agent can read the pages a participant actually sees.
#
# Why this exists: reading `labs/<lab>/index.qmd` is not reading the lab. In source, a Hint and its
# Solution are plain text, so an agent absorbs them the moment it opens the file; on the rendered page
# both are collapsed callouts that stay shut until someone clicks. Same for what a page looks like at
# the top, how long it scrolls, and what the TOC promises. Those are the things the pedagogue and the
# student agent are supposed to judge, and they only exist after a render.
#
# Why HTTP and not file://: the collapsible callouts are Bootstrap collapse widgets. Over file:// the
# page still LOOKS right, but its JS never runs, so clicking a Hint silently does nothing and an agent
# concludes the hint is broken. Serving over http fixes it. (Same reason the slide fit-check serves the
# deck — see the session-start hook § 6.)
#
# python3 is the server on purpose: it is the one thing present in every environment this repo runs in
# (this sandbox, the instructor's machine, a fresh clone) and it needs no install step.
set -euo pipefail

REPO="$(git rev-parse --show-toplevel)"
PORT="${SITE_SERVE_PORT:-8910}"

cmd="${1:-start}"
shift || true
render=0
for a in "$@"; do case "$a" in --render) render=1 ;; --port) shift ;; esac; done

# Sources whose edit invalidates the built site. Kept deliberately short: the point is to catch
# "you edited a page and forgot to re-render", not to model Quarto's dependency graph.
#
# Compared with `find -newer` against the most recently written file in _site, rather than by reading
# mtimes: `stat -c` and `find -printf` are GNU-only, so a timestamp version works here and silently
# reports "stale" forever on the instructor's macOS. `-newer` and `ls -t` are POSIX.
sources_newer_than_site() {
  local ref
  ref="$(find "$REPO/_site" -type f -exec ls -t {} + 2>/dev/null | head -1)"
  [ -n "$ref" ] || return 0
  # Only the pages _quarto.yml actually renders, plus the theme files. A blanket `*.qmd` sweep reports
  # the whole site stale whenever `just exercises` regenerates `exercises/` -- a payload that is never
  # built into _site -- and a warning that fires every run is a warning nobody reads.
  find "$REPO/_quarto.yml" "$REPO/_brand.yml" "$REPO"/*.scss \
       "$REPO/index.qmd" "$REPO/setup.qmd" \
       "$REPO"/slides/*/index.qmd "$REPO"/labs/*/index.qmd \
       "$REPO/labs/quarto-projects/dashboard.qmd" \
       -newer "$ref" -print 2>/dev/null | head -5
}

case "$cmd" in
  start)
    if [ "$render" = 1 ] || [ ! -f "$REPO/_site/index.html" ]; then
      echo "rendering the site..." >&2
      ( cd "$REPO" && quarto render >&2 )
    fi

    # A stale site is the trap this whole script exists to avoid: the agent reads a page that no longer
    # matches the source, and every finding it reports is about content you already changed. Say so
    # loudly rather than serving it quietly.
    stale=0
    newer="$(sources_newer_than_site || true)"
    if [ -n "$newer" ]; then
      stale=1
      echo "WARNING: these sources are newer than the built site -- re-run with --render:" >&2
      echo "$newer" | sed "s|^$REPO/|  |" >&2
    fi

    if ! curl -sf -o /dev/null "http://127.0.0.1:$PORT/index.html" 2>/dev/null; then
      # `exec` detaches the subshell's own fds BEFORE forking the server, so nothing downstream of the
      # server inherits the caller's stdout. Without this, `site-serve.sh start | tail` hangs forever
      # waiting for EOF while the server itself runs perfectly -- a confusing failure to debug.
      ( exec </dev/null >/dev/null 2>&1; cd "$REPO/_site" && setsid python3 -m http.server "$PORT" --bind 127.0.0.1 & )
      for _ in $(seq 1 40); do
        curl -sf -o /dev/null "http://127.0.0.1:$PORT/index.html" 2>/dev/null && break
        sleep 0.25
      done
    fi

    curl -sf -o /dev/null "http://127.0.0.1:$PORT/index.html" 2>/dev/null \
      || { echo "failed to serve _site on port $PORT" >&2; exit 1; }

    echo "SITE_URL=http://127.0.0.1:$PORT"
    echo "SITE_STALE=$stale"
    ;;
  stop)
    # Match on the server's own command line, not the recorded pid: `setsid` re-forks, so `$!` is the
    # wrapper we started, not the python that ends up holding the port.
    for p in $(pgrep -f "http.server $PORT" 2>/dev/null || true); do kill "$p" 2>/dev/null || true; done
    echo "stopped (port $PORT)"
    ;;
  status)
    if curl -sf -o /dev/null "http://127.0.0.1:$PORT/index.html" 2>/dev/null; then
      echo "SITE_URL=http://127.0.0.1:$PORT"
    else
      echo "not serving on port $PORT"
      exit 1
    fi
    ;;
  *)
    echo "usage: site-serve.sh {start [--render] | stop | status}" >&2
    exit 1
    ;;
esac

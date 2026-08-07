#!/usr/bin/env bash
# Serve the built site over HTTP for the reviewer agents (rationale: references/reviewing-the-live-site.md).
set -euo pipefail

REPO="$(git rev-parse --show-toplevel)"
PORT="${SITE_SERVE_PORT:-8910}"

cmd="${1:-start}"
shift || true
render=0
for a in "$@"; do case "$a" in --render) render=1 ;; --port) shift ;; esac; done

# Compares with `-newer` and `ls -t` because `stat -c` and `find -printf` are GNU-only and would
# report "stale" forever on macOS.
sources_newer_than_site() {
  local ref
  ref="$(find "$REPO/_site" -type f -exec ls -t {} + 2>/dev/null | head -1)"
  [ -n "$ref" ] || return 0
  # Only the pages _quarto.yml renders: a blanket `*.qmd` sweep also catches `exercises/`, which never
  # reaches _site, and would warn on every run.
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

    stale=0
    newer="$(sources_newer_than_site || true)"
    if [ -n "$newer" ]; then
      stale=1
      echo "WARNING: these sources are newer than the built site -- re-run with --render:" >&2
      echo "$newer" | sed "s|^$REPO/|  |" >&2
    fi

    if ! curl -sf -o /dev/null "http://127.0.0.1:$PORT/index.html" 2>/dev/null; then
      # `exec` must detach the fds before forking, or `site-serve.sh start | tail` hangs forever
      # waiting for EOF the inherited stdout never closes.
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
    # Matches the command line, not `$!`: `setsid` re-forks, so the recorded pid is the wrapper
    # rather than the python holding the port.
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

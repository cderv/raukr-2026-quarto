# Reference — reviewing the rendered site (agent-browser recipe)

How the `student-participant` and `workshop-reviewer-pedagogue` agents read the material: from the
**built site over HTTP**, not from the `.qmd` source. Everything below was verified against this repo
on 2026-08-07; the failures are recorded because each one costs an agent a confused half hour.

## Sandbox setup — turn the proxy off first

```bash
npm install -g agent-browser            # not on the PATH by default; lands in /opt/node22/bin
export AGENT_BROWSER_PROXY="direct://"  # required in the sandbox
```

`HTTPS_PROXY` is set in this sandbox and agent-browser routes the **browser** through it. Navigation
then never commits: `open` fails with a generic `✗ Operation timed out` and the page stays at
`about:blank`. That reads like a launch failure and is not one (`eval` and `screenshot` keep working
while navigation hangs, so the browser is up). `env -u HTTPS_PROXY` and the `--proxy direct://` flag
do the same job.

Verified 2026-08-09. Four things that look like the fix and are not: `--executable-path`
(unnecessary, `agent-browser install` works here and fetches its own Chrome), `--args "--no-sandbox"`
(already added automatically when running as root), a simplified `NO_PROXY=localhost,127.0.0.1`, and
`AGENT_BROWSER_PROXY_BYPASS`.

## Why the source is the wrong input for these two

A lab page in source shows its Hints and Solutions as plain text, so an agent reads them the instant
it opens the file. On the rendered page they are collapsed callouts that stay shut until clicked. An
agent briefed on the source cannot honestly report "I got stuck here" (it already saw the answer),
and cannot judge what a participant meets first, how far the page scrolls, or what the TOC promises.
Those questions are the whole job for these two agents.

The other two lenses (`technique`, `language`) still read source — syntax and wording live there.

## The target is a local build, not the deployed site

```bash
SITE_URL=$(.claude/scripts/site-serve.sh start --render | sed -n 's/^SITE_URL=//p')
.claude/scripts/site-serve.sh stop
```

Review work targets the **local build**: it is the only one that carries unpublished changes, and
`SITE_STALE` guards against reviewing a page that no longer matches the source.

**Corrected 2026-08-09 — the deployed site is reachable after all.** This section used to say every
external URL failed with `net::ERR_CONNECTION_RESET`. That was the proxy defect above wearing a
different mask. With `AGENT_BROWSER_PROXY` set, the failure becomes
`net::ERR_CERT_AUTHORITY_INVALID` (the sandbox intercepts TLS) and one flag loads it:

```bash
agent-browser --ignore-https-errors open "https://cderv.github.io/raukr-2026-quarto/"
```

Use it only to check what is actually published. It is not the review target.

`SITE_STALE=1` names the sources newer than the build. Reviewing a stale page produces findings about
content that no longer exists, so treat it as a stop sign. `--render` rebuilds first.

**HTTP, never `file://`.** Over `file://` the page still looks right, but its JS never runs, so a
click on a Hint silently does nothing and the reviewer concludes the hint is broken. This is why the
script exists rather than handing the agent an `_site/` path.

## Read a page

```bash
agent-browser --session <name> open "$SITE_URL/labs/quarto-projects/index.html"
agent-browser --session <name> get text main        # the page as a participant sees it
agent-browser --session <name> screenshot top.png   # layout, when the question is visual
```

`get text main` excludes collapsed callout bodies, which is the point: 15 Hint/Solution *titles* are
visible on the Day-2 lab, and not one body until you open it.

**Always pass `--session <name>`.** `/start-workshop` and `/run-labs` fan agents out in parallel and
agent-browser is a shared daemon, so two agents without distinct sessions drive the same browser and
overwrite each other's page.

## Open a collapsed Hint or Solution

```bash
agent-browser --session <name> scrollintoview ".callout-header[data-bs-toggle=collapse]"
agent-browser --session <name> click ".callout-header[data-bs-toggle=collapse]"
```

Use `find nth <n>` for a specific one. The `scrollintoview` is **required**, not defensive: a click on
an element below the fold reports `✓ Done` and does nothing at all.

Three things that look like they should work and do not, all traceable to Quarto emitting the callout
toggle as a **role-less `<div>`** (an open a11y strand, so it may be fixed upstream one day):

| attempt | result |
|---|---|
| `snapshot -i` then `click @eN` | the callouts are not in the tree, so there is no ref to click |
| `find text "Hint" click` | matches, clicks, nothing expands |
| `click "<css>"` without scrolling first | reports success, nothing expands |

The same defect is why a screen-reader user cannot operate these hints. An agent hitting it is the
cheap version of the same finding.

`eval` is the fallback when you need to inspect state rather than click (counting
`.callout-collapse.show`, say). One caveat: every `eval` in a session shares a single JS context, so a
bare `const` throws `Identifier has already been declared` on the second call. Wrap the snippet in an
IIFE (`(()=>{ … })()`).

## Slides

The deck loads over HTTP and `Reveal.isReady()` returns true, but `::: notes` render as
`<aside class="notes">` that `get text` does not return (16 of them on the Day-2 deck). **Read speaker
notes from source.** For slide layout keep using `.claude/rules/slides.md` § 1 — that fit-check is a
measurement (`scrollH === clientH`) and is not replaced by anything here.

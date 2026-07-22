# Quarto documentation sources

Where to fetch **authoritative, current** Quarto docs when authoring or reviewing content —
instead of relying on training-data memory (Quarto moves fast; features and defaults change).
Reach for these whenever a claim about Quarto behaviour, syntax, or a YAML key needs checking.

## Primary — the official docs

- **Docs site:** <https://quarto.org/> — the canonical reference (guide + reference sections).
- **`llms.txt`:** <https://quarto.org/llms.txt> — a compact, LLM-friendly index of the docs;
  good first stop to find the right page fast, then fetch the full page.
- **Docs source repo:** `quarto-dev/quarto-web` — <https://github.com/quarto-dev/quarto-web>
  (the `.qmd` behind quarto.org; useful to read exact source or check very recent changes).
- **CLI source repo:** `quarto-dev/quarto-cli` — <https://github.com/quarto-dev/quarto-cli>
  (engine/CLI behaviour, format implementations, changelog, issues).

## Via Context7 (MCP — for the technique reviewer & authoring)

> **Context7 can be disconnected** (it was for all of 2026-07-20). Treat it as a *bonus*, not a
> dependency: when it's unavailable, **`quarto.org` is the authoritative fallback** (via WebFetch —
> the docs page + `llms.txt`), with **DeepWiki** for "how is X *actually* used / configured" (e.g.
> how quarto.org itself sets `freeze`). Don't block on Context7.

Resolve then query these library ids with the Context7 tools:

- `quarto-dev/quarto-web` — the docs.
- `quarto-dev/quarto-cli` — the CLI/engine.
- `llmstxt/quarto_llms_txt` — the `llms.txt` index.
- website mirrors: `websites/quarto`.

(URLs, for reference: <https://context7.com/quarto-dev/quarto-web> ·
<https://context7.com/quarto-dev/quarto-cli> · <https://context7.com/llmstxt/quarto_llms_txt> ·
<https://context7.com/websites/quarto>.)

## Via DeepWiki (MCP — natural-language questions over a repo)

- <https://deepwiki.com/quarto-dev/quarto-web> — ask questions about the docs.
- <https://deepwiki.com/quarto-dev/quarto-cli> — ask questions about the CLI/engine internals.

## How to use, in order

1. Need a **specific fact / YAML key / syntax** → **`quarto.org` first** (find the page via
   `llms.txt`) — the source of truth; Context7 `quarto-dev/quarto-web` if it's connected.
2. Need **CLI / engine behaviour, defaults, edge cases** → Context7 / DeepWiki on `quarto-cli`,
   or the repo's changelog/issues.
3. **Reviewers** (esp. `workshop-reviewer-technique`) should verify version-sensitive claims
   here before flagging or approving them. Target the Quarto floor set in `project-context.md`
   (≥ 1.8; the school ships 1.9.x).

> Christophe's own prior tutorials (see `project-context.md` § *Christophe's own prior
> materials*) are the fastest source for *worked examples*; the links above are for
> *authoritative behaviour*.

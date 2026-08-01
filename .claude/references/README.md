# References -- the concrete frame & recipes

Durable reference docs for the workshop: the concrete frame (event, audience, scope, prior art)
plus environment notes and authoring recipes. This is the depth behind `CLAUDE.md`'s
method scaffold -- contrast with `rules/` (path-scoped authoring gotchas) and `skills/`
(packaged how-tos).

These are **living docs** -- updated in place as understanding improves. Cite the current state,
not a witness to a past stage.

## The frame

- [project-context.md](project-context.md) -- the concrete "read before content" companion to
  `CLAUDE.md`: event, dates/slots, audience, stack, house style, reference URLs.
- [topic-store.md](topic-store.md) -- scope-control artifact: every teachable topic triaged
  CORE/DEMO/MENTION/STORE so the afternoon slots don't balloon; per-part time budget + running-order rules.
- [prior-art-inventory.md](prior-art-inventory.md) -- content map of Christophe's five prior Quarto
  talks/tutorials: what to reuse for which block, and the gaps.

## Pedagogy

- [workshop-pacing.md](workshop-pacing.md) -- generic hands-on pedagogy (Mine Cetinkaya-Rundel):
  the three modes (my/our/your turn), time ratios; principles, not this session's programme.
- [multi-day-workshop-scaffold.md](multi-day-workshop-scaffold.md) -- portable skeleton + spin-up
  checklist for bootstrapping the *next* multi-day workshop, distilled from this build.

## Environment & build

- [sandbox-setup.md](sandbox-setup.md) -- what the SessionStart hook does and why (locale, proxy CA,
  R deps) and how to reproduce it by hand; the manual companion to `session-start.sh`.
- [quarto-doc-sources.md](quarto-doc-sources.md) -- where to fetch authoritative, current Quarto
  docs (quarto.org, `llms.txt`, source repos, Context7/DeepWiki) instead of trusting training memory.

## Recipes & gotchas

- [typst-render-diagrams.md](typst-render-diagrams.md) -- rendering on-brand vector diagrams via the
  `typst-render` (fletcher) extension: the pieces that must all be present + deploy gotchas.
- [colorblind-safe-palettes.md](colorblind-safe-palettes.md) -- CVD-safe ggplot2 palette
  best-practice + recipes (Okabe-Ito, viridis, Paul Tol); the raster-side counterpart to axe's HTML
  contrast checks.
- [house-voice.md](house-voice.md) -- how Christophe writes (profile distilled from four prior
  workshops) + the LLM-tell strip-list; the depth behind the `rules/prose-voice.md` path-scoped
  rule and the register half of `agents/workshop-reviewer-language.md`.

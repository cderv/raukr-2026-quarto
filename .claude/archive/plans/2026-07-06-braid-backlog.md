# Braid backlog seed — RaukR 2026 Quarto

> **Status: SEEDED (2026-07-07).** This backlog was run into the skein from a remote web session —
> `braid sync` reaches `wss://sync.web3sider.dev` directly after all (the earlier "proxy-bypass /
> unreachable from web" assumption no longer holds). It created epic `the tracker` + 16 children;
> verify with `braid dep tree the tracker`. This file is kept as the archived record of the seed;
> **do not re-run it** (a second run would duplicate every strand). No secret is stored here (the
> doc id comes from env).

## Backlog (seeded — do not re-run)

```sh
# Prereq: braid on PATH, env vars set (or a local .braid.toml). Verify: braid config
set -euo pipefail

EPIC=$(braid create "RaukR 2026 Quarto sessions — build" \
  --type epic --priority 1 \
  --description "Two 2x1h afternoon sessions (Mon Intro / Tue Projects) for RaukR 2026. Context in .claude/references/{project-context,topic-store,prior-art-inventory}.md.")

# --- Setup / infra ---
braid create "Decide remaining defaults: license + publishing target" \
  --type question --priority 2 --deps parent-child:$EPIC \
  --description "License CC BY 4.0 (content) + MIT (code)? Publish to GitHub Pages under cderv/raukr-2026-quarto? (defaults from scaffold plan, not yet confirmed)."

braid create "Obtain RaukR + NBIS/SciLifeLab logo assets" \
  --type task --priority 2 --deps parent-child:$EPIC \
  --description "Needed for the _brand.yml rebuild. Ask NBIS or export from their public site; do not re-license their images."

SCAF=$(braid create "Scaffold the Quarto project (_quarto.yml, profiles, justfile)" \
  --type task --priority 1 --deps parent-child:$EPIC \
  --description "type: website, lang: en, freeze, tuto/pretuto profiles, justfile recipes. Mirror the typst-2026 infra pattern.")

BRAND=$(braid create "Rebuild the RaukR _brand.yml + reveal SCSS" \
  --type task --priority 1 --deps parent-child:$EPIC,waits-for:$SCAF \
  --description "Reconstruct the RaukR house look (teal #4C979F, Albert Sans / Fira Mono, dual logos) via _brand.yml + a thin reveal .scss. No vendoring of NBIS slides.scss.")
braid dep add "$BRAND" "$(braid search 'logo assets' --json | jq -r '.[0].id')" --type waits-for || true

braid create "Choose the running dataset (penguins vs a life-science set)" \
  --type question --priority 2 --deps parent-child:$EPIC \
  --description "The exercise arc is dataset-agnostic; palmerpenguins works, or swap for an -omics/clinical table to fit the audience."

# --- Day 1 — Introduction to Quarto (single document) ---
D1LOCK=$(braid create "Day 1 — lock CORE into Part 1 / Part 2 + timings" \
  --type task --priority 1 --deps parent-child:$EPIC \
  --description "Turn the Day-1 CORE (topic-store) into a Part1 (basics: authoring, layout, doc types) / Part2 (citations, Typst payoff) run sheet with ~1h-per-part timings.")

braid create "Day 1 — build the deck (base on raukr-2025, reskin + modernize)" \
  --type task --priority 1 --deps parent-child:$EPIC,waits-for:$BRAND,waits-for:$D1LOCK \
  --description "Start from cderv/raukr-2025-quarto (EN, Quarto 1.8). Reskin to the RaukR _brand.yml; modernize (Quarto 1.9/1.10, |> not %>%, Positron); native .qmd first, Rmd migration is a quick note."

braid create "Day 1 — build the lab (fork user2024 penguins progression)" \
  --type task --priority 1 --deps parent-child:$EPIC,waits-for:$D1LOCK \
  --description "Fork the user2024-tutorial penguins arc (migrate -> enrich authoring -> multi-format). Modernize; add the Typst finale (lift typst-2026 Ex1)."

braid create "Day 1 — create the Citations segment (no prior material)" \
  --type feature --priority 2 --deps parent-child:$EPIC \
  --description "CORE for a manuscript-writing audience; only footnotes/bibliography exist in prior art. Build .bib + @ref + CSL teaching + a short exercise step."

# --- Day 2 — Quarto projects (projects + tips & tricks) ---
D2LOCK=$(braid create "Day 2 — lock CORE into Part 1 / Part 2 + timings" \
  --type task --priority 1 --deps parent-child:$EPIC \
  --description "Part1 (build & structure: _quarto.yml, website, navigation, cross-refs) / Part2 (scale & ship: freeze/caching, publishing+CI, interactivity taste).")

braid create "Day 2 — build the deck (projects + tips & tricks)" \
  --type task --priority 1 --deps parent-child:$EPIC,waits-for:$BRAND,waits-for:$D2LOCK \
  --description "Projects story with the tips-and-tricks flavor Christophe wants. Reuse raukr-2025 projects section + typst-2026 book/brand material."

braid create "Day 2 — build the lab (harvest NBIS website lab + typst-2026 book/brand)" \
  --type task --priority 1 --deps parent-child:$EPIC,waits-for:$D2LOCK \
  --description "Combine penguins Ex6/7/8 (website/freeze/publish) with typst-2026 Ex2 (book + project _brand.yml). Harvest NBIS labs/quarto-site; reframe onto our structure, drop RStudio/Rmd-first framing."

braid create "Day 2 — create the Dashboards demo (new)" \
  --type feature --priority 2 --deps parent-child:$EPIC \
  --description "format: dashboard — a useful modern output; no prior material, build a small demo."

braid create "Day 2 — Positron x Quarto minimal demo" \
  --type task --priority 3 --deps parent-child:$EPIC \
  --description "Just the Quarto integration (not a Positron tour) — participants see Positron in an adjacent slot."

# --- Process ---
braid create "Run the first /start-workshop review cycle once content exists" \
  --type chore --priority 3 --deps parent-child:$EPIC \
  --description "Fan out the four workshop-reviewer agents; triage P0/P1."

braid create "Archive the scaffold plan (2026-07-06-scaffold.md)" \
  --type chore --priority 3 --deps parent-child:$EPIC \
  --description "Its phase is closed; move to .claude/archive/plans/ when the build plan opens."

echo "Seeded. Review: braid list --all ; braid dep tree $EPIC"
```

## Notes

- Uses `jq` for the one cross-strand dep lookup (logos → brand); if `jq` is absent, wire that
  dep by hand: `braid dep add <brand-id> <logos-id> --type waits-for`.
- Everything is `parent-child` under the epic, so `braid dep tree <epic>` gives the whole plan;
  `waits-for` edges encode the real ordering (brand + locks gate the decks/labs).
- Priorities: 1 = the spine (scaffold, brand, locks, decks, labs); 2 = decisions + gap content
  (citations, dashboards); 3 = process + minimal demos.

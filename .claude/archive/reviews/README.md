# Review ledger — disposition of every archived review

Reviews in this folder are **immutable snapshots** (never edited — a re-review gets a new dated
file with a `bis`/`ter` tag; see `../README.md` and `CLAUDE.md` § *Working-note archiving*).
Because they can't be edited, **this ledger is where "taken into account" is tracked** — each
review maps to its disposition and the commit(s) that acted on it, so on resumption there is no
doubt about what was applied.

**Disposition key:** ✅ **applied** (findings folded into the plan docs) · ☑️ **confirmed**
(review validated an existing call, no change needed) · ⏳ **pending** · ⤴️ **superseded** (by a
later dated review).

## Cycle 2026-07-07 — pre-content planning (all applied)

Six panels ran the same day against the scaffold, before any `.qmd` exists. All findings are
folded into `topic-store.md`, `project-context.md`, `prior-art-inventory.md`, `workshop-pacing.md`,
and `CLAUDE.md`. **Nothing is pending.**

| Review file | Verdict (1-line) | Disposition | Applied in commit(s) → where |
|---|---|---|---|
| `review-2026-07-07-scope-technique.md` | Triage technically clean (0 P0); risks are demo-reproducibility + Day-1 Part-2 density | ✅ applied | `a60523f` → topic-store v2 (triage, time budget, running-order rules) |
| `review-2026-07-07-scope-pedagogue.md` | Direction sound; the risk is **load**; blank time budget hid the overload | ✅ applied | `a60523f` → topic-store v2 |
| `review-2026-07-07-scope-beginner.md` | 1 P0 = live-publish auth cliff; jargon + Day-2 Part-2 overstuffed | ✅ applied | `a60523f` → topic-store v2 (Publishing → watch-me DEMO) |
| `review-2026-07-07-nbis-technique.md` | Toolchain-current, spine-dated; harvest the 2 labs, don't inherit the deck spine | ✅ applied | `a43866a` → prior-art § NBIS harvest map |
| `review-2026-07-07-nbis-pedagogue.md` | Competent reference tour, not a workshop; lift scaffolds, rebuild spine; iris→penguins | ✅ applied | `a43866a` → prior-art § NBIS harvest map; `82cf138` (dataset) |
| `review-2026-07-07-nbis-beginner.md` | Website lab is the keeper; drop the SSH-clone opener; citations absent | ✅ applied | `a43866a` → prior-art § NBIS harvest map |
| `review-2026-07-07-convention-technique.md` | Built-in callouts only; custom class → silent unstyled div, missing timer → raw text | ✅ applied | `32031b3` → convention decision (4 docs) |
| `review-2026-07-07-convention-pedagogue.md` | Hybrid: keep My/Our/Your as facilitation, adopt RaukR idioms, no bespoke chrome | ✅ applied | `32031b3` → convention decision |
| `review-2026-07-07-convention-beginner.md` | Hybrid weighted to RaukR; markers only at the 2 transitions; retire "My turn" badge | ✅ applied | `32031b3` → convention decision |
| `review-2026-07-07-coverage-authoring.md` | Day-1 well-shaped; 7 cheap gaps (math, front-matter, callouts, Word, inline, conditional, diagrams) | ✅ applied | `d75c286` (Layouts) + `7d57cd7` → topic-store § Coverage-audit deltas |
| `review-2026-07-07-coverage-projects.md` | Day-2 right on the spine; add renv leg, promote `_metadata.yml`, Books→MENTION | ✅ applied | `7d57cd7` → coverage deltas + table reclassifications |
| `review-2026-07-07-coverage-advanced.md` | 1 gap (Authors/Affiliations→Day-1); Manuscripts signpost; extension-authoring firmly out | ✅ applied | `7d57cd7` → coverage deltas |
| `review-2026-07-07-coverage-examples.md` | Gallery confirms triage; add journal/preprint Typst-native templates; LaTeX-template trap | ✅ applied | `7d57cd7` → coverage deltas |
| `review-2026-07-07-build-gap.md` | Day-1 ~80% / Day-2 ~60% reuse; only 4 build-fresh; Day-2 deck exists; brand.yml de-risked | ✅ applied | `6f585e6` → topic-store Block-2 + prior-art build backlog |

### Reciprocal pointer
Each `topic-store.md` / `prior-art-inventory.md` note cites the review it came from (e.g.
`(technique P1-3)`, `(coverage projects GAP 2)`, `(build-gap)`), so the trace runs both ways:
review → plan doc, and plan doc → review.

## Cycle 2026-07-07 — WP1 Day-1 deck (`slides/quarto/index.qmd`) — first content review

First panel against **authored content** (the Day-1 deck). **0 P0 across all four reviewers.** The
six P1s and the cheap/high-value P2s were fixed in the same commit that authored the deck; the
deck re-rendered green (V0) after the fixes. Reports are scoped to the deck only (the lab is a
skeleton, reviewed later in WP2).

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-07-wp1-slides-technique.md` | Technically clean; 0 P0 / 0 P1 / 4 P2 — all claims verified vs Quarto 1.9 | ✅ applied | P2s folded: `cache`→`freeze` gloss, outset/inset wording, `@tbl-summary`→`@tbl-mean` |
| `review-2026-07-07-wp1-slides-pedagogue.md` | Strong first draft; 0 P0 / 3 P1 (Part-1 budget overflow; Your-turn-2 unnamed Challenge; "your Part-1 file" ignores shipped-starter rule) / 3 P2 | ✅ applied | Merged Execution+Positron → one "Running & editing" slide (V3 budget); named "Citations Challenge"; shipped-starter framing; +Part-2 Follow-along; +Your-turn presenter notes |
| `review-2026-07-07-wp1-slides-beginner.md` | Would make it through; 0 P0 / 2 P1 (Typst used 5× before defined; Follow-along hides setup → first chunk fails) / 8 P2 | ✅ applied | Glossed Typst on first substantive use; added a **visible setup chunk** at the Follow-along callout; equation code==rendered; WYSIWYM spelled out; `theme_brand_*` attributed; "Pandoc+Lua"→"Pandoc"; zero-install caveat; front-loaded the artifact |
| `review-2026-07-07-wp1-slides-language.md` | Ship-ready; 0 P0 / 1 P1 ("labelled"→"labeled") / 3 P2 (chunk/cell slip, Oxford drift) | ✅ applied | US spelling fixed; cell/chunk aligned; Oxford commas |

**Deferred (P2, non-blocking, acceptable):** Tables&math slide density (pedagogue P2-3);
`data(penguins)` redundancy (technique — kept for teaching explicitness); the two Your-turn `.qmd`
links (technique confirmed the website project rewrites them to `.html`).

## Cycle 2026-07-07 — WP2 Day-1 lab (`labs/quarto/index.qmd` + `starter.qmd`)

Panel on the Day-1 **lab** + its shipped Part-2 starter. **0 P0 across all four.** The four P1s and
the cheap P2s were fixed in the authoring commit; both docs re-rendered green (V0) with freeze
consistent. Scope: the two lab files only (deck + WP0 assets already committed).

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-07-wp2-lab-technique.md` | Ship-ready; 0 P0 / 0 P1 / 3 P2 — folded-solution `#|`-in-`eval:false`, citations→Typst, links all verified vs frozen render | ✅ applied | Typed the bare `.callout` (a11y); `author:"Your name"` nudge; "separate" wording |
| `review-2026-07-07-wp2-lab-pedagogue.md` | Ready; 0 P0 / 1 P1 (`gt` table = unscaffolded R plumbing off the Quarto target) / 4 P2 | ✅ applied | Pre-seeded the `summarise\|>gt` skeleton so only the `tbl-`/`@ref` mechanic is the exercise; marked the equation *(stretch)* to protect the 30-min floor; added a title-block task (rule 6); prose-ref example in the solution; scope line maps 2 challenges → 2 parts |
| `review-2026-07-07-wp2-lab-beginner.md` | Both challenges completable; 0 P0 / 2 P1 (doc location unstated → Part-2 relative paths/brand break; equation task has no content + silent `bill_len` underscore-subscript trap) / 5 P2 | ✅ applied | "Create it **inside `labs/quarto/`**"; equation task now gives the **escaped** LaTeX + warns about `\_`; gt/Typst font-warning troubleshooting line; "open `starter.qmd` in your editor"; duplicate-sentence nudge |
| `review-2026-07-07-wp2-lab-language.md` | Clean; 0 P0 / 1 P1 ("separated"→"separate") / 4 P2 (vs/versus captions, "value-adds"→"extras") | ✅ applied | US wording fixed; "extras"; caption "versus"; starter "form clusters" |

**Verified strength (beginner, kept):** the shipped `starter.qmd` is genuinely known-good — the
reviewer rendered it straight to a **branded Typst PDF** (Albert Sans fetched, no errors), so the
between-parts gap handoff works.

## Cycle 2026-07-07 — Day-1 **integrated arc** review (deck + lab + 3 shared assets)

First **cross-artifact** pass — the five Day-1 files read as one ~2h experience (seams, coherence,
whole-day timing, terminology drift), not a re-review of each. **0 P0 across all four.** Verdict:
the arc was authored as a genuine unit — spine columns, `|>`, citation strings, `fig-bill`/`eq-ratio`
semantics, version floors, and the HTML→Typst brand path all agree across files (technique
live-checked the brand-color resolution). The three P1s were all seam effects invisible to
single-file review. All P1s + cheap P2s fixed in one pass (user-approved); re-rendered green, five
freeze hashes match.

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-07-day1-arc-technique.md` | Technically coherent end to end; 0 P0 / 0 P1 / 3 P2 | ✅ applied | Deck table label `tbl-mean`→`tbl-summary` (one label arc-wide); `.by = species` idiom unified across lab solution + starter + penguins-report + sample-typst |
| `review-2026-07-07-day1-arc-pedagogue.md` | Coherent, event-ready; 0 P0 / 1 P1 (deck layouts "you'll build these" over-promises what the lab practices) / 4 P2 | ✅ applied | Softened the layouts line to name margin only; capstone clause in the lab Scope; "reference, not a checklist" note on the worked-solution pointer (P2-3 title drift + P2-4 timing = deferred/no-op) |
| `review-2026-07-07-day1-arc-beginner.md` | One document, both seams handled; 0 P0 / 1 P1 (same layouts over-promise) / 4 P2 | ✅ applied | Same layouts fix; author replace-nudge; Part-2 Follow-along "or open the starter"; Learn-more links on the close |
| `review-2026-07-07-day1-arc-language.md` | Largely consistent; 0 P0 / 2 P1 ("cell" deck vs "chunk" lab; "vs." deck vs "versus" labs) / 2 P2 | ✅ applied | Standardized on **cell** across deck+lab (kept "chunk" only in the R Markdown-contrast aside); deck captions → "versus"; "front matter"→"YAML header"; "body markdown"→"body Markdown" |

**Deferred (defensible as-is):** the four document titles drifting (pedagogue: letting the title
"firm up as the doc matures" is almost a feature); Typst gloss repeating across worked files;
Part-1 breadth (already budget-fit). **Day 1 is content-complete and arc-verified.**

## Cycle 2026-07-07 — Day-2 CORE beat-lock (`topic-store.md` § Day-2 beat-lock, `the tracker`)

Scoped **planning-lock** review (not content — no Day-2 `.qmd` exists yet): only the new per-part,
per-beat running order + timings that WP3 builds against. Ran the two relevant reviewers —
**pedagogue** (pacing/beats) and **technique** (Quarto-reality of the claims); beginner/language
skipped (no learner-facing prose). **0 P0, 3 P1 — all fixed in the same edit.** `quarto` was
unavailable this session, so judged by knowledge + repo cross-checks, not a render.

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-07-day2lock-pedagogue.md` | Sound, WP3-ready; 0 P0 / 2 P1 (zero-slack 18/18-15/15 sums; overloaded 8-min Freeze beat) / 3 P2 | ✅ applied | Reframed sums as a **ceiling** (aim ~16/~13) + named per-part **shock-absorber** (Cross-refs / `renv.lock` slide); named `renv.lock` **cut-first** inside Freeze; added rule-2 starter pointer; reconciled the stale `_brand.yml` DEMO-note → "locked to Part 1" |
| `review-2026-07-07-day2lock-technique.md` | Technically sound, one real trap; 0 P0 / 1 P1 (cross-refs "resolve project-wide" is a **book** feature, breaks in a website) / 2 P2 | ✅ applied | Reworded Cross-refs beat → resolve **within a page**; cross-page = links + nav (⚠️ + verify-at-machine); `_brand.yml` beat now **shows `theme_brand_*()`**; Freeze pins **`freeze: true`** for the CI-without-R claim |

**Deferred (P2, non-blocking):** finer in-window trim guidance beyond the named shock-absorber
(pedagogue P2-2, partly addressed). **Next:** this spine unblocks **WP3 (Day-2 deck)** — needs
`quarto` restored to author + render.

## Cycle 2026-07-08 — WP3 Day-2 deck (`slides/quarto-projects/index.qmd`) — first content review

First panel on the **authored Day-2 deck** (built against the beat-lock, rendered revealjs green,
`_freeze/` staged). **0 P0 on the deck's own content** (technique / pedagogue / language); the single
P0 (beginner) is a cross-artifact dependency — the Your-turn slides point at the still-skeleton lab —
**resolved by building WP4 (the lab), the next strand in this run.** All deck P1s + the cheap
correctness/clarity P2s fixed in one pass; re-rendered green.

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-08-wp3-deck-technique.md` | Ships green; 0 P0 / 0 P1 / 3 P2 — all claims verified vs Quarto 1.9 | ✅ applied | Added `library(brand.yml)` to the R-side brand snippet (P2 — else `theme_brand_ggplot2()` wouldn't run) |
| `review-2026-07-08-wp3-deck-pedagogue.md` | Strong, near-ready; 0 P0 / 1 P1 (missing "Follow along" marker) / 3 P2 | ✅ applied | Added **Follow-along** callouts at both parts' first live beat (rule 9 now symmetric); glossed CI at first use + Shinylive; restored the capstone hook to the Part-2 frame |
| `review-2026-07-08-wp3-deck-beginner.md` | Concepts followable; **1 P0** (Your-turn → empty lab) / 3 P1 / 4 P2 | ✅ applied (P1/P2); **P0 → WP4** | `freeze: auto` shown as the default (`true` reframed as hard-freeze); CI defined before use; dropped the cross-ref callout hedge; +`library(brand.yml)`, `contents: auto` gloss, `renv::init()` note |
| `review-2026-07-08-wp3-deck-language.md` | Clean, ships after edits; 0 P0 / 3 P1 / 6 P2 | ✅ applied | "one letter apart"→"easily confused"; stage-direction "cut-able under time pressure"→"Extra topics, if we have time"; "chunk"→"cell"; +Wi-Fi, "hands-on part", "precedence runs top-down" |

**P0 disposition:** beginner P0-1 (both Your-turn slides route to the all-TODO lab) is an **arc
dependency**, not a deck defect — the deck correctly pairs with the lab. Resolved by authoring
**WP4 `labs/quarto-projects/`** (strand `the tracker`), built next in the same overnight run.
**Deferred (P2, non-blocking):** `site`/`website` shorthand alternation (language — reads naturally,
no churn); brand.yml code-font vs bold styling.

## Cycle 2026-07-08 — WP4 Day-2 lab (`labs/quarto-projects/` + `starter/` + `solution/`)

Panel on the **authored Day-2 lab** and its shipped starter/solution (renders green, `_freeze/`
staged). **0 P0 on pedagogy/beginner/language; technique found 1 P0 — a real freeze-semantics bug
that also sat in the deck.** All fixed in one pass; deck + lab re-rendered green. This cycle also
**resolves the WP3 beginner P0** (the deck's Your-turn slides now land on a built lab).

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-08-wp4-lab-technique.md` | Website Challenge clean; **1 P0** — `freeze: auto` "edit-prose-and-skip" demo is inverted (auto re-executes on any *source* change; freeze is file-level) / 0 P1 / 2 P2 | ✅ applied (deck + lab) | Reframed the demo to **render-twice-no-edit → skip**; corrected `auto` = "re-execute a doc only when its source changes", `true` = never-on-project-build; fixed the identical wrong claim in the **deck** freeze slide (lock-step) |
| `review-2026-07-08-wp4-lab-pedagogue.md` | Strong; 0 P0 / 1 P1 (Part 2 doesn't open from a shipped known-good *project* — rule-2 regression) / 3 P2 | ✅ applied | Shipped **`solution/`** — the completed Part-1 project (`_quarto.yml` + `_brand.yml` + pages); Ship-it now opens from it; Website Solution points to `solution/` (kills the inert Tasks-duplication P2); deck Your-turn callouts now **name** the Challenges (rule 9) |
| `review-2026-07-08-wp4-lab-beginner.md` | Makes it through, no blockers; 0 P0 / 1 P1 (target figure `theme_minimal` didn't match the grey-default starter) / 7 P2 | ✅ applied | Target figure aligned to the starter's default theme; "You should see" clarifies branding themes the **chrome** (navbar/headings), not the plot; +baseline-render step |
| `review-2026-07-08-wp4-lab-language.md` | Ship-ready; 0 P0 / 1 P1 (Challenge named 3 ways) / 4 P2 | ✅ applied | Standardized on **Website Challenge** / **Ship it Challenge** verbatim on every reference |

**Cross-artifact note:** the freeze P0 was fixed in **both** `labs/quarto-projects/index.qmd` and
`slides/quarto-projects/index.qmd` in the same pass, so Part-2 slide and lab agree. **Deferred (P2):**
remaining low-value beginner/language P2s (flow-style YAML, `execute:` placement note).

## Cycle 2026-07-08 — Dashboards DEMO (`labs/quarto-projects/dashboard.qmd`)

Panel on the **new static `format: dashboard` demo page** + its wiring (render-list entry, deck
"Demos — if time" link). **0 P0 / 0 P1** on the page's own content across technique/pedagogue/beginner;
the single P1 was a US-spelling slip. All findings fixed in the same pass; dashboard re-rendered green,
freeze re-staged. The technique review **proved** (not asserted) the layout compiles to 2-row/2-valuebox/
1-card/1-tabset and that `_brand.yml` teal is baked into the page CSS — discharging the long-standing
technique P2-5 ("budget the layout model or it's an underwhelming single-plot page").

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-08-dashboard-technique.md` | Ships as-is; 0 P0 / 0 P1 / 1 P2 — layout + brand proven vs compiled HTML | ✅ applied | Deck link `dashboard.html`→`.qmd` (Quarto now validates + rewrites it) |
| `review-2026-07-08-dashboard-pedagogue.md` | Ready as a demo; 0 P0 / 0 P1 / 3 P2 — correctly post-payoff, cut-able, cannot over-run | ✅ applied (2/3) | Added `::: notes` presenter cue on the Demos slide; `[See one]` opens in a new tab (`target="_blank"`). **Deferred:** collaborator-facing artifact re-title (subjective) |
| `review-2026-07-08-dashboard-beginner.md` | Lands well; 0 P0 / 0 P1 / 3 P2 — make the source self-teaching for the at-home read | ✅ applied | Comments added: `##`=row/`###`=column (text is a label); each cell becomes a `.card`; icon = any bootstrap-icons name |
| `review-2026-07-08-dashboard-language.md` | Ship after one fix; 0 P0 / 1 P1 / 0 P2 | ✅ applied | `millimetres`→`millimeters` (`dashboard.qmd` fig-alt) |

## Cycle 2026-07-08 — Day-2 **integrated arc** review (deck + lab + starter + solution + dashboard)

First **cross-artifact** pass over the whole ~2h Day-2 experience (parallel to the Day-1 arc review).
**0 P0 across all four.** The spine is coherent end-to-end — freeze wording identical in deck/lab/root
config, penguins idioms byte-for-byte consistent across all five executable surfaces, Challenge vocab
matches deck↔lab, brand three-surfaces claim agrees. One genuine whole-arc seam surfaced (P1) that
per-file review could not catch. All P1 + cheap P2s fixed; deck + lab re-rendered green.

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-08-day2-arc-technique.md` | Coherent arc, one build-topology seam; 0 P0 / 1 P1 / 2 P2 | ✅ applied | **P1:** `solution/` safety-net link 404'd on the rendered site (nested project, excluded from build) → demoted to a code-styled `` `solution/` `` path ("open the folder in your cloned repo"), matching how `starter/` is written. **P2:** deck→dashboard `.html`→`.qmd`; `tbl-means` given a `tbl-cap` in starter+solution |
| `review-2026-07-08-day2-arc-pedagogue.md` | Pedagogically ready; 0 P0 / 0 P1 / 3 P2 | ✅ applied (1/3) | `_metadata.yml` now noted as "not needed in today's flat project — reach for it when a subfolder shares options". **Deferred:** unscripted Part-1→break bridge + your-turn-2 freeze-half weighting (presenter-side scripting) |
| `review-2026-07-08-day2-arc-beginner.md` | Makes it through cleanly; 0 P0 / 0 P1 / 4 P2 — empirically confirmed no brand leak on the standalone starter render | ✅ applied | Same `solution/`-link fix; added a clause that the first single-file render lands `.html` next to source (the *project* render fills `_site/`); deck `custom.scss` marked "(your own, optional)" |
| `review-2026-07-08-day2-arc-language.md` | Ship after edits; 0 P0 / 1 P1 / 2 P2 | ✅ applied | Same `millimetres`→`millimeters`; "Book **versus** website" (`slides:321`); killed "break in between" redundancy (`lab:22`) |

**Cross-artifact catch:** the `solution/` link was correct *as a filesystem path* but dead *as a site
link* — only a cross-artifact + rendered-site pass exposed it; fixed once, referenced consistently.
**Deferred (defensible):** artifact re-title, presenter-script nuances. **Day 2 is content-complete and
arc-verified** — matching Day 1.

## Cycle 2026-07-12 — whole-arc STATUS-CONFIRMATION pass (all four reviewers)

A readiness-check pass (not a build review) over the **entire two-day arc**, run to independently
confirm the "content-complete and arc-verified" claim and to give the **speaking / presenter-delivery**
dimension its first dedicated look (prior cycles reviewed written copy but never the `::: notes` as a
spoken script). **All four verdicts: confirmed ready. 0 P0 across the board.** The technique pass ran a
**full `quarto render` (Quarto 1.9.38 + R 4.6.1) — exit 0, all 11 targets, `git status` clean after** —
proving the versioned `_freeze/` is drift-free (the strongest reproducibility evidence yet). Two cheap
factual/additive P1s fixed in the same pass; the remaining P1s are **presenter-authorial** (spoken notes)
and **left for cderv** — surfaced, not silently actioned.

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-12-status-technique.md` | Confirmed ready; full render green + freeze drift-free; 0 P0 / 1 P1 / 3 P2 | ✅ applied | **P1-1:** stale "under construction / skeletons" callout removed from the public landing page (`index.qmd`) — it was false and participant-visible. P2s (setup TODO comment, Typst font-fallback noise, open-strand markers) noted, non-blocking |
| `review-2026-07-12-status-beginner.md` | Makes it through both days; 0 P0 / 1 P1 / 3 P2 | ✅ applied | **P1:** no `git clone` step on the participant path though the whole hands-on depends on the clone → added a **"Get the materials"** block (clone command + repo URL) to `setup.qmd`, ahead of the `renv::restore()` "from the repo root" step |
| `review-2026-07-12-status-pedagogue.md` | Confirmed ready; 0 P0 / 1 P1 / 2 P2 | ✅ applied | **P1-1** applied: the live-demo beat-sheets + 1-hour-gap re-entry notes were drafted in `4ca2a05` (right after this review's `88d48cf` baseline, so the review never saw them) and given a spoken-script polish on **2026-07-17** (plan `2026-07-17-presenter-notes-polish.md`). Both decks now carry Say/Do beat-sheets on every live slide + "Welcome back" notes on both Part-2 dividers. P2s (Day-1 Part-2 cut-first beat named; Day-2 attendance) non-blocking |
| `review-2026-07-12-status-language.md` | Writing confirmed clean; speaking has the findings; 0 P0 / 3 P1 (speaking) / P2 | ✅ applied | **Writing:** confirmed clean (A1 `vs`→`versus` fixed). **Speaking B1-B3** applied via `4ca2a05` + the **2026-07-17** polish: all four "Your turn" slides carry a `Say (handoff)` line with the reconvene time (D2 your-turn-2 had none); notes use consistent **Say/Do/Helpers** markers (B2); reviewer jargon plain-languaged (B3) |

**Net:** the two safe P1s (landing-page notice, clone step) were applied in the pass; the one substantive
open theme at the time — **presenter/spoken notes** (pedagogue P1-1 = language B1-B3) — turned out to have
been drafted in `4ca2a05` immediately after this review's baseline, so the "pending (author)" disposition
was a **ledger lag**, not real open work. Reconciled 2026-07-17 with a spoken-script polish pass (see the
2026-07-17 cycle below). Open strands unchanged (Positron screenshot capture = local; logos = deferred).
The arc is **content-complete, render-verified, and ready to deliver**.

## Cycle 2026-07-15 — lab logic & prez↔lab flow (7-agent panel)

A single **consolidated** review (not four per-panel files): a 7-agent panel — three student personas
(skimmer / faithful / anxious), three teacher lenses (macro-structure / exercise-design /
prerequisite-audit), one technique pass — commissioned by cderv to answer three questions: is the
**prez→lab→prez→lab** two-cycle shape clear (vs one prez→lab); are the **exercises** clear and
well-placed; is anything **unanswered when a lab is reached**. Technique pass rendered every executable
asset with the renv library (Quarto 1.9.38 + R 4.6.1) — **0 errors, all refs resolve**. **0 P0.**

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-15-lab-logic-flow.md` | Architecture right (two cycles justified), exercises exemplary, labs render clean & armored; gaps are **structure visibility** + Day-2 cwd trap + two slide under-teaches. 0 P0 / 8 P1 / ~11 P2 | ✅ applied | **All P1 + P2 applied** in `a93b69e` (plan `2026-07-15-lab-logic-fixes.md`, four file-partitioned editing agents). Roadmap slide + follow-along stop cue + surfaced break on both decks; Day-2 `cd starter/` / nested-`_quarto.yml` trap fixed (lab + slide + troubleshooting); broken `@tbl-summary` demo → `tbl-cap`; margin syntax added to the Layouts slide; Typst Render-button routes + font pre-warm; P2 polish (deep-link anchors, stretch reword, visible freeze timestamp, fig-alt/refs notes). All four files re-rendered clean |

**Net:** the two-cycle structure and the exercises were **confirmed sound** (Q1 architecture / Q2 both
yes); the applied work (a) **made the structure visible** — one roadmap slide per deck + a follow-along
stop cue + the real break; (b) **closed the Day-2 working-directory / nested-project trap**; (c) fixed
two **Day-1 slide under-teaches** (broken `@tbl-summary` demo; margin syntax); plus the P2 batch. Done in
`a93b69e`.

## Cycle 2026-07-17 — presenter-notes spoken-script polish (self-review, no panel)

Not a reviewer-panel cycle: a **reconciliation + polish** pass triggered by cderv ("keep working on
feedback"). Discovery: the presenter `::: notes` that pedagogue **P1-1** and language **B1–B3** asked
for had already been drafted in `4ca2a05` (2026-07-12 15:43), **after** those reviews' `88d48cf`
baseline — so the reviews graded the pre-notes deck and the ledger's "pending (author)" was lag, not
open work. No reviewer had ever assessed the *drafted* notes. This pass read them as a spoken script,
tightened the blocks still written as authoring-rationale, made the **Say/Do marker** discipline (B2)
consistent across *every* note block, and plain-languaged the residual jargon (B3 tail). Both decks
re-rendered clean (Quarto 1.9.38 + R 4.6.1); `_freeze/` staged.

**Applied** (plan `2026-07-17-presenter-notes-polish.md`): Day-1 *Running & editing* note (was pure
slide-reorg meta) → marked Do/Say preview beat; Day-1 *Positron* note → Say/Do markers, screenshot-
capture TODO demoted to a parenthetical authoring note; Day-1 *What-you-can-build* / *Layouts* / *Typst*
/ *How-today-works* and Day-2 *brand* / *cross-refs* / *How-today-works* → unmarked stage-directions
given Say/Do/Pre-flight markers; "shock-absorber" → "trim-first" (B3). The 2026-07-12 pedagogue and
language rows above updated to ✅ applied.

## Cycle 2026-07-17 — presenter `::: notes` review panel (notes tag)

The "new eyes" pass cderv asked for: the full four-reviewer panel run against the **drafted-and-
polished** presenter notes (`99563e1`) — the first time any reviewer graded the notes themselves
(every prior cycle saw the pre-notes deck). All four wrote dated `review-2026-07-17-notes-*.md`
reports. **No blocking event defect** (the one language "P0" is a marker-clarity issue, not a
delivery blocker). Convergent signal across three reviewers: **Day-1 Part-2's two live slides
(Citations, Branding) still carry no beat-sheet** — the last tail of the old pedagogue P1-1.

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-17-notes-technique.md` | Spoken script technically sound; every `Do:` beat real. 0 P0 / 1 P1 / 2 P2 | ✅ applied | P1: "Four types" of callouts → **five** (added `caution`) in the note *and* the slide body. P2s both applied: freeze "tell" reframed cell→document (whole page not re-executed); publishing note now keeps `quarto publish gh-pages` (renders locally) distinct from GitHub Actions (no R on runner) |
| `review-2026-07-17-notes-pedagogue.md` | Notes are a real delivery instrument; P1-1 re-entry closed. 0 P0 / 1 P1 / 2 P2 | ✅ applied (P1) · ⏸ deferred (P2) | **P1 applied:** Day-1 Part-2 Citations + Branding slides got 3-line Do/Say/Helpers beat-sheets (Day-1 notes 19→21). **P2 deferred** (subjective/symmetry): Figures beat-sheet density trim; note-less Anatomy/One-source concept slides |
| `review-2026-07-17-notes-beginner.md` | Helper-usable; strand-you traps well-nets. 0 P0 / 2 P1 / 4 P2 | ✅ applied | P1: Citations follow-along beat-sheet added; Day-2 your-turn-1 Helpers now leads with the `cd starter/` cwd trap (link-relativity demoted to secondary) + names `solution/`. P2: `#\|`-placement added to the `?@` trap; "where's my PDF" output-location cue added; `solution/` named |
| `review-2026-07-17-notes-language.md` | Notes markedly improved, B1-B3/A1 hold; one systemic marker issue. 1 P0 (3×) / 5 P1 / 5 P2 | ✅ applied (P0+P1) · ⏸ deferred (P2) | **P0:** the 3 instruction-`Say:` sites re-marked `Frame:`. **P1:** US-spelling in Say quotes fixed; `Helpers cue`→`Helpers`; verbatim Say lines quoted; the buried Say+Do split; 4 unmarked blocks given `Frame:`/`Timing:`+`Do:`. **P2 deferred:** marker-vocab consolidation, "the lead"→"default", minor voicing |

**Triage:** consolidated for cderv 2026-07-17; **applied the recommended set** (all P0/P1 + the
correctness-flavoured P2s) on go-ahead. Both decks re-rendered clean; `_freeze/` staged. Deferred =
subjective/symmetry P2s only (Figures density, concept-slide symmetry notes, marker-vocab
consolidation, "the lead"/voicing) — non-blocking, available for a future pass.

## Cycle 2026-07-21 — fixverify panel (ref 356e840): verification of the 2026-07-20 fix batch

Scoped VERIFICATION pass on the delta since the last panel (703e19d content fixes + 356e840 doc
audit) — each reviewer diffed `6a910a5..HEAD`, verified every applied fix as landed, and hunted
regressions. **0 P0 anywhere; every 2026-07-20 fix independently confirmed correct** — technique
proved the braced-inline migration end-to-end in built HTML (empirical escape-semantics matrix),
full render exit 0, `_freeze/` byte-clean, 9/9 changed slides fit 720/720. Convergent residues:
the "(the sane default)" YAML comment left beside the reworded freeze prose (3 reviewers), and
the CI gloss landing one slide after CI's first on-slide use (all 4).

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-21-fixverify-technique.md` | All fixes verified correct, no regressions; 0 P0 / 0 P1 / 2 P2 | ✅ applied | **P2:** CI gloss moved to first on-slide use (`#freeze` :277, shortened to fit 720); engine-active caveat added to `slides.md` §5 (braced inline renders literally in a no-cell markdown-engine doc) |
| `review-2026-07-21-fixverify-pedagogue.md` | Fix batch pedagogically sound; arcs + multi-day pairings intact; 0 P0 / 1 P1 / 2 P2 | ✅ applied | **P1:** "(the sane default)" dropped from the `#freeze` YAML comment; note :332 → "the sane setting". **P2:** `freeze: true` nickname unified to "the CI mode" (note :333, matching the lab hint) |
| `review-2026-07-21-fixverify-beginner.md` | Fixes verified in rendered output; 0 P0 / 0 P1 / 2 P2 | ✅ applied | Same two convergent items (sane-default comment; CI gloss placement) — fixed as above. Lab's first bare "CI" (:24) left as-is (tells the participant what they *won't* do; never blocks) |
| `review-2026-07-21-fixverify-language.md` | PASS, all fixes landed; 0 P0 / 2 P1 / 4 P2 | ✅ applied (2 P1 + 2 P2) · ⏸ deferred (2 P2) | **P1:** sane-default comment (as above); "vs" → "versus" (`labs/quarto-projects/index.qmd:91`). **P2:** "with within-page" tongue-twister → em-dash list (deck :32). **Deferred:** long lab sentence split (:93-96, subjective); pre-existing "behaviour" ×2 in `quarto-doc-sources.md` (out of scope) |

## Cycle 2026-07-20 — whole-repo panel (ref 6a910a5); first run of the adapted agents

Full four-reviewer panel on both days. **No P0 anywhere.** First exercise of the agents adapted
earlier this session (multi-day sweep, jargon/reusability, overflow, false-callback, doc fallbacks) —
all fired and confirmed this session's prior fixes clean.

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-20-technique.md` | Renders exit-0, no overflow, refs/brand/freeze valid. 0 P0 / 1 P1 / 3 P2 | ✅ applied (P1 + 2 P2) · ⏸ deferred (1 P2) | **P1:** `freeze: auto` "the default" → "the sane setting to adopt". **P2:** lab `_brand.yml` flow-mapping → block form. **Deferred:** `#citations` density; renv-from-`starter/` subdir note (sandbox-only) |
| `review-2026-07-20-pedagogue.md` | Pedagogically ready; multi-day sequencing clean. 0 P0 / 0 P1 / 5 P2 | ✅ applied (1 P2) · ⏸ deferred (4 P2) | **P2 applied:** Day-2 outcome "cross-references" → "within-page cross-references". **Deferred** (presenter judgment): Figures 4th-move density, 2 note-less Day-1 slides, Part-1 pacing length, freeze density |
| `review-2026-07-20-beginner.md` | Makes it through both days; callbacks all true. 0 P0 / 1 P1 / 3 P2 | ✅ applied | **P1:** inline-code showed `knitr::inline_expr(...)` literally → fixed + migrated to braced `` `{r} …` `` (double-brace escape for the literal). **P2:** CI glossed on first slide use; dead `#sec-model` anchor → page link; `_metadata.yml` wrap kept (taught concept) |
| `review-2026-07-20-language.md` | Reads well; register strong. 0 P0 / 2 P1 / 4 P2 | ✅ applied (P1 + 3 P2) · ⏸ deferred (1 P2) | **P1:** "wet-lab collaborator" genericized; "for a research audience" trimmed. **P2:** "the runner" → "in CI", "hard-freeze" → "CI mode", `wifi` → `Wi-Fi`. **Deferred:** "think in deltas" title (optional) |

**Triage:** consolidated for cderv 2026-07-20; **applied the recommended set** (all 4 P1 + the cheap
cross-reviewer P2 clusters) on go-ahead. Notable side-quest: Christophe's call to adopt the portable
braced inline form `` `{r} …` `` (verified vs quarto.org) drove a repo-wide inline migration + the
double-brace-escape lesson (`slides.md` §5). `sample-typst.qmd` inline reverted (un-refreezable
in-sandbox `gt` error). All touched executable `.qmd` re-rendered + fit-checked 720/720. Deferred =
presenter-judgment / subjective P2s only — non-blocking.

## Cycle 2026-07-22 — params panel (ref bee98ea): the new parameterized-report bonus

First panel against the Day-1 **parameterized-report** optional bonus (the tracker: `penguins-by-species.qmd`,
the lab `## Bonus` section, the `#running` slide MENTION). **0 P0 anywhere.** Technique empirically
verified every syntax claim (asis→numbered heading, `!expr` in both `fig-cap`/`fig-alt`, `-P species:`
colon form) and confirmed **no freeze/website stale-artifact trap** (an explicit single-file render
always honours `-P`). Convergent P1s: the new file used the legacy `` `r …` `` inline (technique +
language) against the settled braced house form, and a slide/lab `-P` placeholder mismatch (language).
The beginner panel found the real UX seam — the bonus was written as "modify a document" but only
cohered against the shipped solution.

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-22-params-technique.md` | Technically sound, all claims render-verified; 0 P0 / 1 P1 / 4 P2 | ✅ applied | **P1:** legacy→braced inline (`penguins-by-species.qmd:19,42`). **P2:** Session appendix added to the file; `cat("##", …)` double-space; `fig-alt: !expr` shown alongside `fig-cap` in the task. `!expr`-is-knitr = note only |
| `review-2026-07-22-params-beginner.md` | Safe as optional; *doing* it exposed a file/output seam; 0 P0 / 3 P1 / 2 P2 | ✅ applied | **P1 (all three, one fix):** added a "Starting point" box anchoring the shipped `penguins-by-species.qmd`; Task 2 now says plot `one` not `penguins`; Task 5 gained the `_site/…` output-location + working-dir note. **P2:** `!expr` "why" clause added; double-space fixed |
| `review-2026-07-22-params-language.md` | Solid, no P0; 2 cross-file consistency P1s; 0 P0 / 2 P1 / 2 P2 | ✅ applied | **P1:** braced inline (as above); slide `-P key:value` → `-P name:value` to match the lab. **P2:** "a command-line thing" → "command-line only"; dropped "self-service" from the goal |
| `review-2026-07-22-params-pedagogue.md` | Pedagogically ready, ship it; 0 P0 / 0 P1 / 2 P2 | ✅ applied / ☑️ confirmed | **P2:** NA guard added to the task-2 filter snippet (matches the reference). Fit-check of `#running` = already done (720/720), re-confirmed after the placeholder edit |

**Triage:** 0 P0; applied the full set (1 P1 idiom regression + the beginner UX seam + the cheap
cross-reviewer P2s) — all reviewer-specified, no judgment call. The beginner's three P1s shared one
root cause (bonus written as "modify a doc", only coherent against the shipped file) and were closed by
one reframe: anchor on `penguins-by-species.qmd`, name the DIY caveat (plot `one`), add the output note.
All touched executable `.qmd` re-rendered; braced inline re-verified as executing (not literal);
`-P species:Chinstrap` re-verified end-to-end with the added Session cell; `_freeze/` staged; `#running`
re-fit-checked 720/720. No deferrals.

## Cycle 2026-07-22 — exercise-delivery migration (`delivery` tag, ref `1a8c757`)

Panel over the `use_course()` externalization migration (setup.qmd + both labs + `_quarto.yml` + both
decks; sync infra as context). **1 P0** caught — the primary obtain command was broken — plus a
folder-naming/ordering knot and stale old-model residue. All applied in `68e78a2`; the P0 fix also
**revised the §3 branch semantics** (plain `use_course` shorthand → `main`, not an `@raukr-2026` pin,
since usethis rejects the `@ref` form). Christophe chose the shorthand→`main` approach + apply-all.

| Review file | Verdict (1-line) | Disposition | Applied → where |
|---|---|---|---|
| `review-2026-07-22-delivery-technique.md` | Structurally sound but the primary obtain command is broken; 1 P0 / 1 P1 / 2 P2 | ✅ applied | **P0:** `use_course('owner/repo@ref')` unsupported → plain shorthand `use_course('cderv/raukr-quarto-exercises')` (main); buttons → `/main/`; plan §3/4/8 revised (`68e78a2`). **P1:** stale `_site/` note `slides/quarto/index.qmd:677`. **P2:** renv caveat strengthened |
| `review-2026-07-22-delivery-pedagogue.md` | Pedagogically ready after one P1; net cognitive-load reduction; 0 P0 / 1 P1 / 3 P2 | ✅ applied | **P1:** same `:677` stale note (dedup w/ technique). **P2:** slide `solution/`→`solutions/day2/` (`:394`). *Lost in-browser payoff-preview noted, accepted (inline target figs remain)* |
| `review-2026-07-22-delivery-beginner.md` | No blockers; trap structurally gone; 0 P0 / 2 P1 / 3 P2 | ✅ applied | **P1:** phantom `starter/` in `labs/quarto-projects/solution/index.qmd:10`→`day2-projects/` (re-synced); setup open-day-folder-vs-check-from-top **ordering** fixed (sequence cue). **P2:** Day-1 Scope install adds knitr/rmarkdown; download-buttons-404-until-pushed = known handoff |
| `review-2026-07-22-delivery-language.md` | Ship-ready prose, one consistency knot; 0 P0 / 2 P1 / 5 P2 | ✅ applied | **P1:** top folder named three ways → defined once + "top folder" throughout (`setup.qmd`). **P2:** UK `colour`; `your-doc.qmd`→`my-report.qmd`; presenter "strand a room of 40" reframed; "venue firewall"→neutral; bare `solutions/`→`solutions/day1|day2` |

**Triage:** 1 P0 + 3 P1 (deduped from 6) + ~8 P2, **all applied** (Christophe: shorthand→main + apply-all).
The P0 was a real regression the migration introduced (the `@ref` spec form) — the kind a post-build
`run-labs` against a real `use_course()` unpack (plan §8 step 7) would also have caught. Site re-render
green (8 targets); `_freeze/` refreshed; `exercises/` re-synced + drift-guard green; no slide fit-checks
needed (only speaker notes changed this round).

## Cycle 2026-07-23 — run-labs FINAL gate against a real `use_course()` unpack (`labrun` tag)

Plan §8 step 7: the post-handoff pre-freeze gate. Two `student-participant` agents walked Day-1 and
Day-2 **from a faithful `use_course()` unpack** (`git archive` of the pushed `cderv/raukr-2026-quarto-exercises`
`main` = exactly what codeload serves), following only the lab prose, rendering for real, packages
exposed as the participant's user library. **Both labs completed with ZERO blockers**; migrated prose
matches the delivered tree exactly (day-folder framing, no `starter/`/`cd` apparatus, `.Rproj` present,
output-location + reset notes all true; siblings `solutions/` not peeked). Artifacts produced: Day-1
`my-report.html` + branded Typst `my-report.pdf` + `penguins-by-species.html` (×3 species); Day-2 a full
branded `_site/` with working navbar + a correct freeze demo.

| Report file | Verdict (1-line) | Disposition |
|---|---|---|
| `review-2026-07-23-labrun-day1-usecourse.md` | 0 BLOCKER; all artifacts render; 2 had-to-infer / 1 ambiguous | ☑️ gate PASS — polish findings recorded, not auto-fixed (run-labs triage) |
| `review-2026-07-23-labrun-day2-usecourse.md` | 0 BLOCKER; branded `_site/` + freeze demo behave as documented | ☑️ gate PASS — one visual-only checkpoint noted |

**Findings (all P2/P3, pre-existing prose nits — none a migration regression; NOT auto-fixed, per
`/run-labs` recommend-and-await discipline):** (1) Day-1 Authoring Task 4 ("species counts in the
**margin**") supplies no R code while every neighbour does — a dplyr-fluent participant infers
`count(species)`, a less-fluent one may stall (`labs/quarto/index.qmd`, Authoring Challenge). (2) The
Day-1 lab page has no "start over" pointer though it edits shipped files in place — `setup.qmd` has the
reset story; the lab doesn't link it. (3) Day-2 Website "navbar turns teal" is a visual-only checkpoint —
a CLI-only participant has no textual confirmation; one "open `_site/index.html` / `quarto preview`" line
would close it (`labs/quarto-projects/index.qmd`, "You should see"). (4) The three Day-1 download buttons
404 until the repo is flipped **public** — **expected**, that is the pre-delivery step; files ship in the
download, so no one is blocked. **Gate verdict: GO for freeze** (public flip + Windows `renv::restore()`
tester remain the only pre-delivery residuals).

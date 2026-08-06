# Lab-2 completeness plan — findings and open decisions

Status: **decided and applied in part, 2026-08-06** (external review verdict: a conservative
subset, sized for one instructor, no reliable helpers, no rehearsal). Written 2026-08-06 from a
three-lens review (prior-art mining of the earlier tutorials, an official-docs audit, a pedagogy
sizing pass). The dated reports live in `.claude/reviews/` (gitignored working notes), so this
document carries the substance. Every minute figure below is a bench estimate, not a rehearsal
result: treat them as direction, not commitments.

What was applied (behavior verified by live renders on Quarto 1.10.18 before writing):

- **D** — project-scope `quarto preview` in "Build the navigation", with the preview as the
  checkpoint and the default search magnifier named there (not a separate exercise).
- **A, as guided reinforcement** — a commands-shown `freeze: true` experiment after the Day-1
  report step (switch to `true`, edit the plot code, render project / file / project), closing
  with the switch back to `auto`. Not a discovery step: the review judged another hint ladder too
  expensive for one instructor.
- **Inconsistency 1** — fixed by trimming the Scope sentence (candidate B declined).
- **Inconsistency 3** — one line under the first step's stanza: `_site` is the website default,
  written to keep the publish folder named in the config.
- **Two finish lines** stated in the Part-2 intro: minimum = freeze works + the Day-1 report is a
  page; complete core = the guided experiment too. Dashboard and publishing stay overflow.

Declined: **B, C, E, F** (so inconsistency 4 stays as-is: demo remains "if time permits" on both
surfaces). **G**'s recommendation stands (no step-by-step correction). Timing estimates stay out
of participant-facing material.

## The question

After the 2026-08-05 rework, is the Day-2 lab complete, or is it missing exercise steps or depth?
If it has slack, the competing uses are: more required work, the dashboard live demo as a scheduled
beat, or time for a step-by-step correction.

## Findings

- **Part 1 (Website Challenge) is complete.** The four core steps plus the listings stretch fill
  the hands-on window on a bench reading, the brand failure beat is well pre-framed by its
  "You should see", and the fast-finisher path is reachable. The docs audit confirmed every
  mechanism claim in the lab (freeze, theme-layer order, `_metadata.yml` merge precedence),
  checked by live renders on Quarto 1.10.18. No contradictions.
- **Part 2 (Reproducible Build Challenge) reads short of its slot.** The required path is
  freeze + proof, the cache-vs-freeze discussion, and the Day-1 report step; the sizing review
  estimates that at roughly half the hands-on window for a median participant. The estimate is
  untested, but all three lenses point the same way, and the shortfall traces to the two places
  the applied rework softened the plan (dashboard demoted to optional demo, cache-vs-freeze
  became a discussion). Rehearsal should settle the size before any timing goes on a slide.
- **The strongest candidate additions are things the deck already teaches but the lab never
  practises** (cheapest kind: no new teaching, only a place to use it). Both mining lenses found
  the same two independently: the `freeze: true` workflow (a full slide, `#freeze-workflow`) and
  the brand-related R-side stretch named in the beat-lock.

## Inconsistencies to fix regardless of the plan

These are wrong today, whatever gets decided below.

1. **Dangling promise: the branded-plot stretch.** The lab's Scope callout
   (`labs/quarto-projects/index.qmd:27-29`) says "The optional branded-plot stretch also uses
   `brand.yml`" — no such step exists on the page. Fix by building the stretch (candidate B) or
   by trimming the sentence. The setup page's package comment
   (`setup.qmd`, the `brand.yml`/`ggrepel`/`prismatic` line) says those packages serve the Day-1
   Typst PDF, so it needs a matching touch only if the stretch is built.
2. **Unowned search button.** Verified by render: a navbar website ships `search.json` and a
   search magnifier **by default**. Participants will see a button the lab never mentions. Either
   name it in the navigation checkpoint or set `search: false`. Caution before wording a
   checkpoint: search likely fails from a double-clicked `_site/index.html` (`file://` cannot
   fetch `search.json`) — verify in a browser, and note this is one more argument for teaching
   `quarto preview` (candidate D).
3. **`output-dir: _site` is already the website default.** Harmless to set explicitly, but the
   first step presents it as the config that redirects output. Worth a presenter note at most;
   do not let a future edit claim the redirect *requires* it.
4. **Dashboard demo is "if time permits"** in both lab and deck. Consistent today, but if the
   demo becomes a scheduled beat (candidate C) both surfaces change together
   (`labs/quarto-projects/index.qmd:544-548`, deck notes near the Part-2 Your-turn).

## Candidate additions (each is a separate decision)

**A. `freeze: true` second beat** — inside "Make the build skip unchanged pages": switch to
`true`, edit code, watch the project render reuse the stale result, refresh with a single-file
render. Taught on `#freeze-workflow`, never practised; every prior tutorial exercised both values
(user2024 `3-projects.qmd:882-890`). Small estimate, one new sub-step, no new teaching. The
strongest single filler for Part 2, endorsed by both mining lenses and the sizing pass.

**B. Branded-plot stretch** — `theme_brand_ggplot2()` (optionally `theme_brand_gt()`) after
"Brand it", scoped down from the Typst tutorial's bonus (`tuto-quarto-typst-rr-2026`
`2-projets/index.qmd:208-297`). The beat-lock names exactly this call; `brand.yml` and
`prismatic` already ship in the participants' package list. Fixes inconsistency 1 the right way.
Mid-size estimate. If declined, trim the Scope sentence instead.

**C. Schedule the dashboard group demo** — change "if time permits" to a committed beat after the
core Part-2 steps, keeping the copy-along optional. Already authored, serves the whole room, and
the copy-along absorbs bench time for fast finishers. The sizing pass ranked this first.

**D. `quarto preview` at project scope** — one instruction in "Build the navigation". Day 1
taught preview on a document; Day 2 never widens it, and the lab is render-and-open-file
throughout — the one workflow regression versus every predecessor tutorial. Also makes the search
button demonstrable (inconsistency 2).

**E. Brand swap** — a second palette file and `brand: _brand-alt.yml`, chained after B
(Typst tutorial bonus). Taught on the brand slide, never used. Only worth it if B is built.

**F. Fast-finisher customize menu** — an open-ended "customize from the docs" close to the
Website Challenge (the elastic overflow both penguins tutorials used), with docs-verified menu
items: `page-footer`, the announcement bar, drafts (`draft: true` + `draft-mode`), a light/dark
theme pair with brand. The dark pair needs a highlight fit-check first (`rules/brand.md`, the
dark-sheet leak). Near-zero authoring for the frame; each menu item is a link plus one line.

**G. Correction format** — the sizing pass recommends **against** a step-by-step correction for
this audience (solutions are already folded per step); a short debrief off the existing
`::: notes` trigger questions covers the same ground. No authoring needed beyond one note line.

## Fenced — considered and not proposed

Settled decisions were not re-opened: books stay DEMO-only, publishing stays optional Connect
Cloud, gh-pages stays dropped, cache-vs-freeze stays a discussion, renv stays slide-plus-callout,
blogs and About pages stay with the school's own website lab. From the docs sweep, rated
not-worth-a-step: redirects/`aliases` (no observable mid-workshop result), `page-navigation` and
`bread-crumbs` (need sidebar nesting the lab's navbar site lacks), `back-to-top`, `repo-actions`
and comments (git constraint), profiles (too heavy), `title-block-banner`.

## If (parts of) this is applied

The usual chain: edit `labs/quarto-projects/**` (+ starter/solution siblings) → re-render → stage
`_freeze/` → `just exercises` → commit `exercises/` → deck edits get a fit-check → CI covers any
new pages. Timing claims stay off slides and lab until a rehearsal supports them (the 2026-08-05
pass removed untested estimates; do not reintroduce them).

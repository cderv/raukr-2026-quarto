# Pedagogue review — Day-2 CORE beat-lock (scoped)

**Scope:** only the subsection "## Day-2 CORE beat-lock — per-part, per-beat (the tracker,
2026-07-07)" in `.claude/references/topic-store.md:330-362`, judged against the "## Time budget"
per-part allocations (`:285-326`), the 9 "## Running-order rules" (`:366-399`), and the confirmed
Day-2 CORE table (`:160-168`). Reference commit `9bedb72`, branch `claude/goal-command-wx5go6`,
2026-07-07. Out of scope (not re-flagged): CORE/DEMO/MENTION/STORE triage, Part1=build/Part2=ship
direction, dataset, Day-1, publish=watch-me.

## Overall verdict

The beat-lock is pedagogically sound and ready to build WP3 against. Both parts reach a genuine
hands-on payoff (Part 1 → navigable branded site; Part 2 → `render` + `output-dir`), all five
confirmed CORE beats are present with none missing, and the ordering carries a clean causal
through-line — Part 1 config→build→link→brand, Part 2 freeze-as-groundwork then publish-CI-story
that builds directly on the committed `_freeze/`. Minute weighting is load-appropriate (the richest
and hardest beats, Website and Freeze, get the most time). Two realism cautions keep it from being
frictionless: the per-part sums land at *exactly* the concept+demo cap (no slack against live-demo
overrun), and the 8-min Freeze beat is the densest, most abstract moment of Day 2. No P0.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

**P1-1 · Beats sum to exactly the cap — zero absorption for live-demo overrun.**
`topic-store.md:338-345` sums to 18/18, `:347-352` to 15/15. The header (`:334`) and the parent
budget both say "upper limits — aim to finish early," and the budget section exists precisely
because a blank budget "was hiding the overload" (pedagogue P1-1, `:287`). Filling the window to
100% re-hides it: the two demo-heavy beats (Website 6 min `:343`, Freeze 8 min `:351`) are exactly
the ones that expand live, and there is no cushion before the sacred 30-min hands-on. Either target
~16/13 with the 18/15 as the ceiling, or explicitly name the per-part shock-absorber beat so the
overrun trims a known place instead of eating the payoff.

**P1-2 · Freeze beat (8 min, `topic-store.md:351`) is optimistic for its payload.** It bundles four
distinct concepts — motivation, `cache` vs `freeze`, committed `_freeze/` → CI-renders-without-R,
*plus* a `renv.lock` slide — all pure concept with no hands-on, positioned before the payoff (the
highest cognitive-load moment of Day 2). The CORE table itself (`:167`) warns freeze's value "only
*shows* across 2 renders / a commit / a CI run" and must be scenario-ed as "render, edit prose,
re-render → code didn't re-run"; that live 2-render demo alone consumes minutes. 8 min to land the
cache/freeze distinction *and* run the scenario *and* narrate CI-without-R *and* add renv is tight.
Name `renv.lock` as the cut-first sub-item inside this beat (it is already MENTION, `:187/:241`) so
the 8 min protects the cache-vs-freeze scenario, which is the load-bearing teach.

## 🟡 P2 — nice-to-have

**P2-1 · `_brand.yml` is labeled DEMO but locked as a CORE-window beat.** The beat-lock gives it a
fixed 4-min slot (`:345`), yet the DEMO table (`:174`) classifies it DEMO and even carries a stale,
self-contradictory note ("→ runs in Part 1" *and* "After the publish payoff in Part-2 order if shown
there"). Since the Part-1 hands-on target is a "*branded* website" (`:316`), `_brand.yml` is
load-bearing for the payoff → effectively CORE, so the promotion is the right call — but WP3 will hit
the mismatched label and the residual Part-2 clause. Reconcile the DEMO-table note to match the lock.

**P2-2 · No in-window trim candidate named.** Rule 1 / the tail (`:354-355`) is the stated pressure
valve, but if Part 1's 18-min window itself overruns before the tail, which of the four beats yields?
Cross-refs (3 min, "Our", `:344`) is the natural in-window trim (it extends Day-1 knowledge
project-wide, lowest novelty). A one-line "if the window runs long, compress X" per part would give
roaming/pacing guidance the tail alone doesn't.

**P2-3 · Continuity to rule 2 (starter artifact).** Part 2's Freeze and Publishing beats operate on
"your project" (`:351-352`, `:325`). The beat-lock declares hands-on "unchanged" (`:333`) so this is
strictly out of its remit, but a one-line pointer that Part 2 opens from the *shipped* known-good
starter (rule 2, `:373-374`) — not the learner's possibly-unfinished Part-1 site — would keep the
beat spine honest for anyone who fell behind between parts.

## ✅ Pedagogical strengths confirmed

- **Both parts reach a hands-on payoff, payoff-sacred honored.** Part 1 → branded navigable site,
  Part 2 → `render` + `output-dir`; DEMOs kept in the cut-able post-payoff tail (`:354-355`, rule 1).
- **Clean, causal through-line.** Part 1: `_quarto.yml`→website→cross-refs→brand (config, build,
  link, style). Part 2: Freeze first (reproducible groundwork) → Publishing whose CI story *reuses*
  the committed `_freeze/`. The freeze-before-publish order is causally correct, not arbitrary.
- **All 5 confirmed CORE beats present; none missing** (`:342-352` vs the CORE table `:160-168`).
- **Load-appropriate weighting** — the largest slots go to the richest (Website 6) and hardest
  (Freeze 8) beats, not spread flat.
- **Our-turn rhythm preserved where it matters.** My+Our follow-along on the two centerpiece beats
  (Website, Freeze); watch-me correctly reserved for `_brand.yml` (multi-surface, hard to follow live)
  and publish/CI (unrunnable live).
- **MENTION items explicitly ride inside CORE beats** (`:361-362`) — prevents beat-count inflation
  and keeps the per-beat budget honest.

## 📝 Evolution since previous review

New deliverable — no prior beat-lock to compare. It correctly inherits and operationalizes the
pedagogue fixes already in the tree (payoff-sacred rule 1, `_brand.yml`→Part 1 per P1-2, freeze
motivation-first). The one carried-forward wrinkle it surfaces is the `_brand.yml` DEMO-vs-CORE
labeling drift (P2-1), which predates this subsection.

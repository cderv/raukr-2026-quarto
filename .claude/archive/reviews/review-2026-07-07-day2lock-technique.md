# Technique review — Day-2 CORE beat-lock (the tracker)

**Scope:** the single new subsection `## Day-2 CORE beat-lock — per-part, per-beat`
(`topic-store.md:330–362`) plus its immediate anchors (Day-2 tables at `:310–326`, CORE table
`:160–176`). Judging **Quarto-technical accuracy of the locked beats/timings only**. Out of
scope (per brief): CORE triage, Part1/Part2 split direction, dataset choice, Day-1 content.

**Reference commit:** `9bedb72` · branch `claude/goal-command-wx5go6` · 2026-07-07
**Constraints this session:** Quarto not installed (no smoke render); Context7 MCP not exposed
as a tool here — judged by knowledge + repo cross-checks, not by build. Cross-reference-scope
finding below is stated with that caveat and flagged "verify at the machine before podium."

---

## Overall verdict

The beat-lock is technically sound and internally consistent with the CORE/DEMO/MENTION tables
it derives from — the freeze-vs-cache contrast, the `_quarto.yml` + `_metadata.yml` + `output-dir`
framing, the "committed `_freeze/` → CI renders without R" claim, the `renv.lock`-as-second-leg
pairing, and the `quarto render` + `output-dir` honest kernel with `publish`/GitHub Actions as
watch-me are all correct and well-scoped. `_brand.yml` is honestly limited to "same palette"
(not the whole brand system), matching the de-risked reality in `topic-store.md:174`. Static
`format: dashboard` + plotly/leaflet as post-payoff demos is accurate. **One beat carries a real
multi-format trap:** the Part 1 "Cross-refs across pages … resolve project-wide" beat
(`:344`, echoed `:315`) claims a **book** capability inside a **website** build — in a plain
website, `@fig-`/`@sec-` do *not* resolve across pages, so a live "Our" type-along would surface
a broken `?@fig-` reference. No P0 (nothing is authored/rendered yet); 1 P1, 2 P2.

---

## 🔴 P0 — blocking technical bug

None. No invented format name, no fabricated YAML key, no beat that is outright false as written.

---

## 🟠 P1 — fix before the event

### P1-1 · "Cross-refs across pages … resolve project-wide" is a book claim inside a website beat
`topic-store.md:344` — `| 3 | **Cross-refs across pages** | Our | `@fig-`/`@sec-` resolve project-wide |`
(and the Part 1 concept line `:315`: "cross-refs across pages").

The problem: Part 1 **builds a website** — `:154` "Part 1 = build & structure a project (a
website…)", `:165` "Websites | pages, navbar/sidebar navigation, listings", and Books are
explicitly demoted to MENTION (`:184`, "book-vs-website decision (1 slide)"). But Quarto's
**project-wide** cross-reference resolution — where `@fig-`/`@sec-`/`@tbl-` on one page resolve
to a numbered reference on *another* page — is a **book** feature (Quarto renders a book as one
unit with global numbering). In a **website** project each page renders independently; a
`@fig-x` pointing at a label on a different page does **not** resolve and renders as an unresolved
`?@fig-x`. This matches the repo's own prior art, which frames project cross-refs strictly as
*book* cross-refs: `prior-art-inventory.md:82` "Cross-referencing (project) | … | book cross-refs"
and `:55` "single Typst book … cross-refs". The CORE table itself blurs it — `:166`
"across pages/**chapters** of a project" — chapters ≠ website pages.

Why it matters at the podium: the beat's mode is **Our** (`:344`), i.e. type-along. A live demo
that writes `@fig-…` referencing another *website page* and expects "Figure 3.2" will show a
broken cross-reference in front of the room — the exact "cross-reference resolution" pitfall.

Fix options (pick one; keep the beat, correct the claim):
- **Demo cross-refs *within a page*** (where `@fig-`/`@sec-`/`@tbl-`/`@eq-` always resolve) and
  demo **cross-*page* navigation** via ordinary links / the sidebar — do not claim numbered
  `@fig-` resolves across website pages. Reword `:344` → "cross-refs resolve within a page;
  cross-page = links + navigation".
- **Or** build this specific artifact as a `type: book` (where project-wide `@fig-`/`@sec-`
  genuinely resolve) — but that fights the "Websites" spine and the Books→MENTION decision, so
  option 1 is the cheaper, on-message fix.
- Either way, **verify against the installed release at the machine** before the podium (I could
  not render this session): confirm whether the current Quarto build resolves cross-page refs in a
  website — historically it does not, and I'd not bet a live "Our" beat on an unverified yes.

---

## 🟡 P2 — nice-to-have / robustness

### P2-1 · The `_brand.yml` "R-side plots, same palette" beat needs the R mechanism shown, or the palette won't actually appear
`topic-store.md:345` — `| 4 | **`_brand.yml`** — site + slides + R-side plots, same palette | My |`

The "same palette (not whole brand)" scoping is correct and consistent with `:174`. But be
precise in the deck: an R plot does **not** auto-inherit `_brand.yml`. HTML/revealjs/Typst read
the file natively; **R-side plots read it through a second mechanism** — the `brand.yml` R
package + `theme_brand_ggplot2()` / `theme_brand_gt()` / thematic (exactly as `:174` notes:
"two mechanisms reading one file"). At 4 min in **My** mode this is fine, but the slide must
actually *show* the `theme_brand_*()`/thematic call, otherwise "R-side plots, same palette"
is aspirational and a live ggplot will render in default grey. Budget one line of R for it.
(Also keep the `install.packages("brand.yml")` setup pin from `:174` — `pak` is KO in-sandbox.)

### P2-2 · "committed `_freeze/` → CI renders without R" — state the freeze mode so the claim holds
`topic-store.md:351` — the Freeze beat.

The claim is correct and the two-legs framing (`_freeze/` = results, `renv.lock` = what runs) is
the right mental model. One robustness note for the slide: "CI renders without R" holds when the
committed freeze is **current** and freeze is effectively pinned — with `freeze: auto`, if a
participant edits a code cell and CI has no R, the render *fails* (Quarto tries to re-execute the
changed cell). For the "green check with no R runtime" story to be honest, show `freeze: true`
(or make the "edit prose, not code" scenario from `:167` explicit). Minor, but it's the
difference between a demo that always goes green and one that surprises. Also worth one word:
`freeze` is engine-agnostic and project-level; `cache` is knitr-only and per-document — the
beat's "`cache` vs `freeze`" contrast is correct, just keep that axis crisp.

---

## ✅ Technical choices validated

- **`_quarto.yml` + `_metadata.yml` + `output-dir`** (`:342`) — all real, correctly scoped:
  `_metadata.yml` is genuine directory-level metadata, `output-dir` is a valid `project:` key,
  and staging `_metadata.yml` as a *shown slide* (MENTION, `:182`) rather than a timed beat is
  the right call.
- **Freeze vs cache** (`:351`) — the two are correctly distinguished (project-level result freeze
  vs knitr per-doc cache); motivation-first ("don't re-run slow bioinformatics compute") is the
  right teaching order and matches `:167`.
- **`renv.lock` as the second reproducibility leg** (`:351`) — accurate: renv pins *what* runs,
  freeze pins *results*; complementary, not redundant.
- **Publishing kernel** (`:352`) — `quarto render` + `output-dir` as the honest hands-on, with
  `quarto publish` / GitHub Actions as **watch-me on a pre-provisioned repo (auth pre-flighted)**
  is technically and operationally correct; live `quarto publish gh-pages` for 40 laptops is
  genuinely a room-killer (consistent with the beginner P0 at `:168`). CI can't be run live
  anyway (push → wait for the check), so foregrounding the *story* is right.
- **Static `format: dashboard`** (`:355`) — real format (Quarto ≥ 1.4), and "static" is the
  correct qualifier: a dashboard built from htmlwidgets/static content is self-contained HTML
  with no Shiny server. Correct to keep it post-payoff and cut-able.
- **htmlwidget (plotly/leaflet)** (`:355`) — pure-R, reliable, self-contained HTML; the right
  choice for a live interactivity demo over OJS/Shinylive (consistent with `:176`).
- **`_brand.yml` "same palette" honesty** (`:345`) — correctly *not* overclaiming the whole
  brand system on the R side; matches the de-risked reality in `:174`.
- **MENTION items ride inside their CORE beat** (`:360–362`) — Parameters/website-tools/
  extensions/profiles folded in rather than timed as beats: sound budgeting, no format traps.
- **Timings** — Part 1 concept+demo 5+6+3+4 = 18 ✓; Part 2 8+7 = 15 ✓; both reconcile with the
  §"Time budget" tables (`:315`, `:324`). Framing them as upper limits ("aim to finish early") is
  the right hedge given the cross-ref beat is only 3 min.

---

## 📝 Evolution since the previous review

This is a *new* deliverable (no prior beat-lock to compare), so this section notes what it
inherits cleanly. The beat-lock faithfully carries forward the already-good technical decisions
from the 2026-07-07 CORE pass: the freeze motivation-first framing and CI-without-R claim
(`:167`), the publishing P0 mitigation (`:168`), the `_brand.yml` "two mechanisms, one file /
same palette" de-risking (`:174`), and the `_metadata.yml` promotion (`:182`). The one item it
*inherited without tightening* is the cross-reference scope: the CORE table's ambiguous
"across pages/chapters of a project" (`:166`) is hardened in the beat-lock into the firmer, and
now technically wrong-for-a-website, "resolve project-wide" (`:344`) — see P1-1. Fixing it at
the spine (here) is cheaper than after WP3 builds the deck against it.

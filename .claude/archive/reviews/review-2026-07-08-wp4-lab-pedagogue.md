# Pedagogy review — WP4 Day-2 lab (Quarto projects)

- **Reviewer:** workshop-reviewer-pedagogue
- **Date:** 2026-07-08
- **Branch / state:** `claude/goal-command-wx5go6`, working tree (uncommitted)
- **Scope:** `labs/quarto-projects/index.qmd` + `labs/quarto-projects/starter/{index,analysis}.qmd`
- **Lens:** adult-learning / instructional design for a ~2h Day-2 workshop, experienced-R /
  life-science audience, ~30 min hands-on per part
- **References checked:** `topic-store.md` § Day-2 beat-lock + § Running-order rules;
  `workshop-pacing.md`; structural comparison to the shipped Day-1 lab (`labs/quarto/index.qmd`)
- **Out of scope (not re-flagged):** the deck, the Day-1 lab, scope/triage/beat-lock, missing logos

## Overall verdict

Pedagogically strong and close to ready. Both Challenges state an explicit **target artifact**
(Website → a `starter/_site/` with two linked pages + teal navbar; Ship-it → a regenerated `_site/`
plus a proven freeze-skip on the 2nd render), and they map cleanly to the two parts (build / ship).
The lab reuses the Day-1 Challenge → Tasks → You-should-see → Hint → Solution shape faithfully,
scaffolds the R plumbing out of the way (the analysis is pre-shipped so the *mechanic* — project
config, then freeze — is the exercise), and its troubleshooting block anticipates the real traps.
The one substantive gap is a **running-order-rule-2 regression relative to Day-1**: the shipped
`starter/` is not yet a project, so a learner stranded at the break cannot *open* Part 2 from a
shipped known-good project — they must hand-rebuild `_quarto.yml` + `_brand.yml` from the fold-out
Solution first. Everything else is P2 polish.

## 🔴 P0 — blocking for the event

None.

## 🟠 P1 — fix before the event

### P1-1 — Part 2 does not open from a shipped known-good *project* (rule 2 regression vs Day-1)

`labs/quarto-projects/index.qmd:154-158` — the Ship-it "Starting point" tells a learner who didn't
finish Part 1: *"the Solution above is the known-good `_quarto.yml` + `_brand.yml` — drop those two
files into `starter/`."* But the shipped `starter/` (`starter/index.qmd`, `starter/analysis.qmd`)
contains **only content pages, no `_quarto.yml`** — it is deliberately "not yet a project"
(`index.qmd:29-39`). So Ship-it Task 1 (`index.qmd:162`, *"Add freeze to `starter/_quarto.yml`"*)
assumes a file that a stranded learner does not have. The documented recovery is real, but it is a
*create-two-files-and-paste-YAML* step performed at the exact between-parts break that rule 2 exists
to de-risk.

Compare Day-1: `labs/quarto/starter.qmd` is a **shipped, ready-to-open** Part-2 fallback — a complete
Part-1 output the learner just opens and builds on (its own header calls this out as "running-order
rule 2"). The beat-lock Notes are explicit: *"Part 2 opens from the shipped known-good starter (rule
2), not the learner's possibly-unfinished Part-1 site."* Day-2 currently ships the *inputs* to Part 1,
not the *output* Part 2 needs.

**Fix (align with Day-1):** ship the finished-Part-1 project in a copy-ready location so recovery is a
single move, not a rebuild — e.g. a `starter/` that already contains a known-good `_quarto.yml` +
`_brand.yml`, or a sibling `solution/` (or `starter-part2/`) the learner copies in wholesale. Then
Part 2 genuinely *opens from* a shipped project for everyone, and Task 1 (add `freeze:` to an existing
`_quarto.yml`) is true on first read. Borderline P1/P2 for this experienced audience — the rebuild is
~2 min — but it lands at the sacred break and diverges from the locked design, so fix before the event.

## 🟡 P2 — nice-to-have

### P2-1 — Website Solution is a verbatim repeat of the Tasks (empty self-check)

`index.qmd:116-147` (Solution) reproduces the same `_quarto.yml` and `_brand.yml` already given in full
in Tasks 1 and 3 (`index.qmd:48-77`). A stuck learner who unfolds the Solution gains **no new
information** — the self-check loop is inert here. Day-1's Solution earns its fold-out by consolidating
and slightly extending the Tasks (the full `gt()` with `fmt_number`, the margin `count`). Either make
the Website Tasks describe intent + values (leaving the learner to assemble the two files) and let the
Solution show the literal result, or trim the duplicated block. Related: because the complete YAML is
handed over in the Tasks, the Website Challenge's production demand is low (transcribe + render) — fine
as scaffolding for a *first* project, but the pairing of "full answer in Tasks" + "identical Solution"
is the redundant part to resolve.

### P2-2 — Ship-it "prove freeze works" gives no picture of the success signal

`index.qmd:167` and the You-should-see (`index.qmd:175-180`) ask the learner to *"watch the log; no
compute"* and confirm the cell was *"skipped"*, but neither the Tasks nor the Hint (`index.qmd:182-188`)
shows **what that log line actually looks like**. For the one exercise whose payoff is an *absence*
(nothing re-ran), a learner working solo can't easily tell success from "it just rendered fast."
The Troubleshooting entry *"Freeze didn't skip the cell?"* (`index.qmd:218-219`) helps after the fact;
a one-line "you'll see the cell reported as reused/cached, not executed" in the Hint would close the
self-verification loop up front.

### P2-3 — Deck "Your turn" callouts don't name the lab Challenges (rule-9 same-word linkage)

Pairing is topically correct — deck your-turn-1 (`slides/quarto-projects/index.qmd:206-208`,
"navigable, branded website") maps to the **Website Challenge**, and your-turn-2 (`:298-300`, "render
your project to `_site/`") maps to the **Ship it Challenge**. But unlike Day-1, whose Your-turn slides
name the target by word ("start at the **Authoring Challenge**", "at the **Citations Challenge**"), the
Day-2 deck callouts never say "Website Challenge" / "Ship it Challenge." Rule 9 wants the same word on
slide and in lab so a learner lands on the right section unambiguously. The lab section names are good;
the linkage would be tighter if the deck echoed them. Advisory only — the fix touches the (already
reviewed) deck, not the lab.

Minor note (no action needed): your-turn-2 foregrounds *render → `_site/`* while the lab's Ship-it
leads with *freeze* (Tasks 1-2) before the render (Task 3). Both live in Part 2 and are compatible;
just be aware the slide pointer and the lab's opening emphasis differ slightly in order.

## ✅ Pedagogical strengths confirmed

- **Explicit target artifacts, cleanly mapped.** Each Challenge opens with a bold **Goal** naming a
  concrete deliverable (`index.qmd:43-44`, `:150-152`), each restated in a "You should see"
  (`:83-88`, `:175-180`). Website → Part 1 (build/structure), Ship-it → Part 2 (scale/ship) — a clean
  one-Challenge-per-part split matching the beat-lock.
- **Structural parity with Day-1.** Same Scope callout → Starting-point → Challenge → Tasks →
  You-should-see (+ target figure) → collapsible Hint → folded Solution → shared Troubleshooting →
  Session block. Learners who did Day 1 read Day 2 with zero format re-learning.
- **The mechanic is the exercise, not the plumbing.** The R (ggplot boxplot, `kable`) is pre-shipped
  in `starter/analysis.qmd` with default echo, so the Website hands-on is purely project config and
  the Ship-it hands-on is purely freeze/render — the learning target (Quarto projects), not incidental
  R.
- **Honest target image.** `fig-target` (`index.qmd:90-103`) uses `theme_minimal`, matching the
  site-chrome-only branding the lab actually promises; the plot is *not* shown teal, and Troubleshooting
  (`:214-215`) correctly explains that `_brand.yml` alone doesn't reach ggplot. No false payoff.
- **Cognitive-load discipline.** `renv::snapshot()` is explicitly marked *"(note, not a step)"*
  (`:171`), stretch items are tagged *(stretch)* (`:78`), and the publish auth-cliff is kept off the
  hands-on path as a watch-me demo (`:150-152`) — consistent with the beginner-P0 mitigation.
- **Self-correction support.** The end-of-lab Troubleshooting (`:207-221`) anticipates the genuine
  traps for this audience: YAML indentation, "no project" / broken links from a misplaced `_quarto.yml`,
  brand not reaching plots, `?@…` cross-refs, freeze not skipping, missing packages — so a learner who
  errs at step N can usually recover without flagging a helper.
- **Concrete "make it a site" framing.** The shipped starter pages render on their own but aren't a
  project, so the Part-1 transformation ("turn these into a *site*") is tangible rather than abstract —
  good "build something real" motivation.

## 📝 Evolution since the previous review

This is the first pedagogy review of the WP4 Day-2 lab (newly authored) — no prior report to diff
against. Relative to the **Day-1 lab it is modeled on**: the Challenge/Tasks/You-should-see/Hint/
Solution architecture, the load-management conventions, and the troubleshooting depth all carried over
cleanly and are already good. The one place Day-2 is **behind Day-1** is the between-parts fallback
(P1-1): Day-1 ships a ready-to-open `starter.qmd` Part-2 fallback, whereas Day-2 ships only the raw
Part-1 inputs and asks a stranded learner to rebuild the project from the Solution — a rule-2 step back
that is worth closing before the event.

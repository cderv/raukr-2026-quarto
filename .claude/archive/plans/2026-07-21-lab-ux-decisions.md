# 2026-07-21 — Lab UX decisions: presentation format · fontawesome · materials distribution

**Question (Christophe):** is our callout-heavy / "Challenge"-framed lab *presentation* the right way
vs NBIS's long-prose style — and separately, what's the best UX for participants to get **starters,
solutions, and assets**? "I want various perspectives to decide."

**Method:** a 5-agent panel (reports are immutable snapshots in `.claude/archive/reviews/`):
`review-2026-07-21-labformat-{cognitive,participant,technique,design}.md` +
`review-2026-07-21-materials-distribution.md`. Factual scaffold: **ours** ≈ 230–280 lines, ~10
callouts/page, 5–6 "Challenge" headings, folded solutions, zero shortcodes; **NBIS 2026** ≈ 590–760
lines, 1–4 callouts, no "Challenge" framing, `{{< fa >}}` + tabsets (2025 ≈ 2026).

---

## Decision 1 — Presentation format → **KEEP the callout spine** (unanimous, all 4 lenses)

Nobody recommends switching to NBIS prose (it buries the tasks — its one Tasks box sits at line
592/759). The spine is right for a time-boxed *doing* lab; it's **over-boxed in specific spots**, not
wrong. Convergent fixes:

1. **Demote "You should see"** — RESOLVED by design-`bis`: a full solid-blue box right after the
   solid-blue Tasks box, so color stops distinguishing "do this" from "check this." Make it an
   **`appearance="simple"` callout with a `circle-check` icon** — *not* a bare `>` blockquote (which
   goes semantically mute); the icon keeps the "expected-output checkpoint" signal at zero added
   weight. This reconciles the participant-vs-others split: content kept, container lightened.
2. **Troubleshooting → real `## H2`** (design) so it enters the TOC — right now headings inside
   callouts are excluded, so our right-rail is ~2 entries/day vs NBIS's ~11; a mid-lab reader can't
   jump to the solution/troubleshooting. Optionally `collapse` the body (cognitive).
3. **Trim the top-of-page double-box** (Day-2 Scope + Starting-point ≈ 30 lines of stacked blue).
4. **Rescue inverted emphasis** — behavior-changing instructions ("*a reference, not a checklist*")
   sit in skippable prose while routine confirmations are boxed.
5. **Lock the note/tip rule:** blue = must-read spine, gold = pull-when-stuck-and-collapsed.
6. **One hybrid borrow:** a dependency-free `::: {.panel-tabset}` for Day-1's two Typst render routes.

**Options:** **A (light)** = #1 + #3 only. **B (full)** = all six + document the rule. → **Recommend B**
(the TOC fix is a real navigation gap; documenting prevents drift). All copy/structure, no spine change.

## Decision 2 — fontawesome → **available in the NBIS tree** (verified), so it's a free choice

`_extensions/quarto-ext/fontawesome/` **v1.2.0 is committed in `NBISweden/raukr-2026`** (+ `mcanouil`,
`royfrancis`). So `{{< fa >}}` renders when our file folds into their site — not a portability trap.
For our standalone build, we'd `quarto add quarto-ext/fontawesome` (we already vendor `mcanouil`). The
technique lens's "NBIS is fragile" framing was overstated.

- **(a) zero-dep** — emoji/plain titles, nothing to install (current stated practice).
- **(b) fontawesome** — one committed extension, richer icons, and we can match NBIS's
  `{{< fa clipboard-list >}} Tasks` idiom so a folded-in lab reads as native. → **Recommend (b)** given
  the explicit upstream-integration goal. Update `project-context.md:161` from "avoid" → "vendored, OK".

**Design-`bis` finding (icons + thinning are one package):** fontawesome does **not** change the
"thin the palette" verdict — an icon is an *identity* device, not a *weight* device (two stacked blue
fills still read as one heavy block). But it makes the thinning **lossless**, so Decisions 1 and 2
merge into one coherent change. **Icon scheme — 4 glyphs, type-markers only** (thin the icon palette
like the color one): Tasks = `clipboard-list` (full blue box, matches NBIS); You-should-see =
`circle-check` (on the demoted `appearance="simple"` callout); Hint = `lightbulb`; Troubleshooting =
`wrench` **in the body only** (keep the promoted `## Troubleshooting` heading text plain so the TOC
entry stays clean). **No icon** on Scope / Starting-point / Rmd-aside (one-off orientation boxes, no
confusion partner). Plus `download` / `file-pdf` on genuine asset/PDF links.

## Decision 3 — Materials distribution UX

**Priors:** NBIS = env images (2025 Docker + conda) + an **SSH-clone opener** (the confirmed
room-killer) + `{{< fa download >}}` per-asset buttons. Christophe's lineage evolved zip → zip → a
**companion R package** (`tutoquartotypst`): `installer_exercices()` copies starters (no git/auth,
cross-platform), `ouvrir_correction()`/`recuperer_correction()` reveal solutions **online, on demand**
(strongest solution-timing design; but package-heavy, doesn't fold into NBIS).

- **Starters + assets → lead with `usethis::use_course("cderv/raukr-2026-quarto")`** (no git/SSH/account,
  Windows-native unzip, assets bundled, `renv.lock` rides along, **another guest instructor's canonical mechanism** —
  she's a sibling instructor). Keep `git clone https://…` as a demoted alternative. Rewrite
  `setup.qmd` § "Get the materials" (currently lines 54–57). → **Recommend.**
- **Solutions → keep out of the pre-seeded working tree:** inline collapsed `code-fold` for the in-room
  timed reveal + the `solution/` project **published online / behind a click**. *Open nuance:*
  `use_course` unzips the *whole repo*, so it would bring `solution/` along — to truly keep it out we'd
  need either a curated "student" zip or to rely on the online-published solution as the reveal. **Decide.**
- **Download buttons** for `references.bib` / `apa.csl` / `starter.qmd` as the roaming-TA recovery path
  — `{{< fa download >}}` (pairs with Decision 2b) or `downloadthis` (embeds files, wifi-resilient). → **Recommend**, mechanism follows Decision 2.

---

## Decision 4 — Upstream integration into `NBISweden/raukr-2026` → **content PR, not subtree**

Keep `cderv/raukr-2026-quarto` as the dev source + `use_course` distribution point; fold into NBIS's
site via a **content PR** (we mirrored their `slides/<topic>/` + `labs/<topic>/` convention for a
near drop-in). **Not git subtree** — subtree merges into ONE prefix dir, but our content spreads
across their tree and mixes replace + net-new:

| our path | → NBIS path | nature |
|---|---|---|
| `slides/quarto/` | `slides/quarto/` | replace (modernize) |
| `labs/quarto/` | `labs/quarto/` | replace |
| `labs/quarto-projects/` | `labs/quarto-site/` (**rename**) | replace/merge |
| `slides/quarto-projects/` | *(new)* `slides/quarto-projects/` | **net-new** (they have no Day-2 deck) |

CC BY → their CC BY-NC-SA is compatible (attribution to Christophe preserved). A small **sync script**
encodes the mapping for repeatable re-PRs. At integration, check whether any lifted file uses our
vendored `mcanouil` extension (it must travel with the file); fontawesome already ships on their side.

## Status — APPLIED 2026-07-21 (branch `claude/code-review-sync-h6uj17`)

Christophe: "yes go." Applied:
- **1B + 2b (one change):** vendored `quarto-ext/fontawesome` (FA Free 6.5.2, into `_extensions/`),
  re-skinned **both** labs with the 4-glyph icon scheme (Tasks `clipboard-list`; "You should see" →
  `appearance="simple"` + `circle-check`; Hint `lightbulb`; **Troubleshooting → real `## H2`** wrapping
  a collapsed tip + `wrench`), de-boxed the Day-2 top double-callout, rescued the inverted-emphasis
  lines. Documented the scheme in `project-context.md`. Icons verified in rendered HTML; Troubleshooting
  now a TOC-level H2 on both days.
- **3:** `setup.qmd` § "Get the materials" now leads with `usethis::use_course("cderv/raukr-2026-quarto")`,
  `git clone` demoted to the alternative.
- **4:** content-PR-not-subtree mechanism recorded (§ Decision 4) — not yet built.

**Deferred (strand-tracked, not blocking):** download buttons for `references.bib`/`apa.csl`/`starter.qmd`
— blocked on the repo going public (**`the tracker`**) + a `downloadthis`-vs-raw-link call; the upstream
**sync-script** (build when content is final); the **solution-timing** sub-decision (folded into the
cleanup strand `the tracker`).

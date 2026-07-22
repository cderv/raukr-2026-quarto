# Plan — exercise delivery for the RaukR 2026 Quarto sessions

*Design synthesis for how participants obtain and work on the hands-on exercises across BOTH Quarto
sessions. Produced 2026-07-22 from a Fable design panel (robustness-first + reuse-first; a
pedagogy-first agent did not return in time — its UX refinements are folded in from what we know and
flagged where thin) + the scout facts + the prior scoping plan
`2026-07-21-companion-package-scoping.md`. **Status: PROPOSED — awaiting Christophe's ratification of
the open decisions (§4) before build.***

## 0. Why this exists

The current model has participants author in-place inside the cloned **course website** repo — Day-1
in `labs/quarto/`, Day-2 in `labs/quarto-projects/starter/` with a mandatory `cd starter/`. Because
the repo root is itself a Quarto website (`_quarto.yml`, `output-dir: _site`), any render not preceded
by the `cd` is captured by the root project → output lands in `_site/`, `_freeze` confusion, wrong
file edited. That is a fragile **nested-project trap** for ~40 laptops. This plan removes it
structurally and unifies Day-1 and Day-2 delivery.

## 1. The decisive constraint (scout, verified against the live RaukR 2026 schedule)

**Git & GitHub is taught Wednesday 12 Aug — AFTER both Quarto sessions (Mon 10 + Tue 11).** No earlier
session seeds git; no git prerequisite on the registration page. So in-session delivery MUST assume
**no git, no GitHub account, no SSH/PAT** — only a public HTTPS download plus R + Quarto + an editor
(already required). ~40 participants. This rules out, *for the live sessions*: clone-based delivery
and the "Use this template" button (account-gated). It points squarely at **`usethis::use_course()`**
(a plain public zip download, "designed for workshops", opens the IDE at the unpacked root) with a
browser Download-ZIP fallback.

## 2. The converged architecture (high confidence — both designs + the updated scoping plan agree)

1. **A dedicated, tiny, public exercises repo** — NOT the whole course repo — delivered by
   **`usethis::use_course(...)`** on the **Setup page, before Day 1**. One line, no git, no account.
   **Identical for Day 1 and Day 2** (one download covers both).
2. **No `_quarto.yml` anywhere at or above the starters.** It unpacks to a plain Desktop folder, so
   there is no ancestor project to capture a render — the trap is *impossible*, not warned-about. The
   whole "`cd starter/` / don't render from the repo root" apparatus in the Day-2 lab is deleted.
3. **One self-contained folder per day** (`day1-intro/`, `day2-projects/`), each with its own
   **`.Rproj`** (correct working dir on double-click). Each Day-1 folder carries its own
   `references.bib` / `apa.csl` / `_brand.yml` so the lab's relative paths always resolve.
4. **Solutions as SIBLING folders** (`solutions/day1/`, `solutions/day2/`), never nested — critical,
   because once a participant creates `day2-projects/_quarto.yml` a *nested* solution would be swept
   into their website render. Sibling + its own `_quarto.yml` = never captured.
5. **Solutions shipped** (present locally) for in-room resilience — "nobody is stranded by the break",
   and a stuck participant with flaky Wi-Fi needs a *local* reference, not a re-download. Withholding
   is *spatial* (separate top-level folder, "try first" framing). A one-line `export-ignore` "dial"
   can hard-strip them for a stricter future audience without restructuring.
6. **No companion R package.** The 2026-07-21 scoping plan already reached this verdict; the reuse
   design confirms it. Its one useful function, `check_setup()`, becomes a plain **`00-check-setup.R`
   inside the zip** (verifies R >= 4.5, Quarto >= 1.9, the 8 packages, base-R `penguins`, then renders
   `day1-intro/sample-typst.qmd` — which doubles as the Typst font pre-warm). Zero r-universe upkeep.
7. **Reset, no custom tooling:** re-run `use_course()` (usethis auto-suffixes a fresh sibling folder,
   preserving the broken attempt) or re-extract the kept ZIP (answer **No** to "delete the ZIP?").
8. **Fallbacks, ordered:** (a) `use_course()` → codeload zip; (b) browser **Download ZIP**
   (`…/archive/refs/heads/<edition>.zip`) — browsers trust venue/corporate CAs R's curl may not;
   (c) a mirror of the same zip on the published course site (different domain); (d) **USB sticks** in
   the room (byte-identical payload — it's one small folder). Because the zip is tiny (no `_freeze/`,
   no `_extensions/`, no `slides/`), even bad Wi-Fi survives 40 concurrent pulls.

### Why this also fixes the NBIS fold-in
The teaching site folds into `NBISweden/raukr-2026`, which is *itself* a Quarto website. If starter
*projects* folded in too, the nested trap would be recreated inside the NBIS repo. Externalizing the
working files into a repo with **no root `_quarto.yml`** cures the trap for this year, for NBIS, and
for every future edition at once.

### The insight that updates the prior plan
`2026-07-21-companion-package-scoping.md` argued *against* moving files out — to preserve the
"author in-place in the cloned repo" design. **That premise is overturned:** the in-place model IS the
nested-trap problem. So its **"no package" verdict stands and is reinforced**, but its **"keep in-repo
/ `use_course` the whole course repo" stance is superseded**. (Today `setup.qmd` already runs
`use_course("cderv/raukr-2026-quarto")` — the whole repo, trap and all; the fix is to retarget it at
the small exercises repo.)

## 3. Recommended resolutions of the open decisions

| Decision | Options | Recommendation |
|---|---|---|
| **Source of truth** | (A) keep canonical files in the course repo, a **sync script** generates+pushes the exercises repo; (B) **move** files out entirely, course repo keeps only lab prose | **(A) sync.** Keeps files where they're already render-validated + embedded in lab pages, keeps the Day-1 flat layout the old plan showed must not be reshaped, one edit point. Reuse the old plan's **role-manifest sync** (`§4` there) — it already solved the flat-Day-1 / split-Day-2 asymmetry. Cost: a second repo + a sync script + CI drift-guard. |
| **Versioning** | (A) year-in-name repo; (B) **year-agnostic repo + edition branches** (`@raukr-2026`) | **(B).** `use_course("cderv/raukr-quarto-exercises@raukr-2026")` printed in 2026 handouts keeps resolving forever; 2027 = branch `main`, change one Setup line. Strong longevity win, ~free. |
| **renv for participants** | (A) drop it (robustness); (B) ship a small `renv.lock` in the exercises repo | **(B) with the plain-install fallback kept** (as today). renv.lock-as-truth is a house rule; the 8 packages are small binaries. Offer `install.packages(c(...))` for anyone renv trips up. Revisit only if a dry-run shows Windows renv friction. |
| **Template repo** | flag now vs post-course only | **Flag it** (one checkbox) as the instructor-reuse on-ramp; delivery still `use_course`. Template = reuse-by-others (account, offline from the session); `use_course` = live attendee delivery (no account). Each used where it's strong. |

## 4. What to build (and migrate)

**New — the exercises repo `cderv/raukr-quarto-exercises` (public, CC BY 4.0):**
`README.md` (participant quickstart + instructor on-ramp), `.Rproj`, per-day `.Rproj`s, `renv.lock` +
`DESCRIPTION` (the 8 packages), `00-check-setup.R`, `day1-intro/`, `day2-projects/` (ships WITHOUT
`_quarto.yml` — creating it IS the Day-2 exercise), `solutions/day{1,2}/`, and
`.github/workflows/render-check.yml` (renders both solutions incl. the Typst PDF + `sample-typst.qmd`
+ asserts no root `_quarto.yml` + zip-size check; push + weekly cron = between-years rot canary).
Flag as a **template repository**.

**New — in the course repo:** a **role-manifest sync script** (adapt the old plan's `sync-labs.R`
manifest + the tuto's `sync-exercices.R` / `is_artifact()` artifact-stripping) + a `just exercises`
recipe + a CI drift-guard; it force-pushes the assembled layout to the exercises repo.

**Migration edits in the course repo:**
- `setup.qmd` — retarget "Get the materials" to `use_course("cderv/raukr-quarto-exercises@raukr-2026")`;
  "keep the ZIP" advice; the `00-check-setup.R` / `sample-typst.qmd` verification (pre-warm); Plan-B/C
  fallbacks; keep the plain-install fallback.
- `labs/quarto/index.qmd` — Task 1 → "create `my-report.qmd` inside your open `day1-intro/` folder";
  Part-2 start → `day1-intro/starter.qmd`; the `starter.qmd` download button retargets to the exercises repo.
- `labs/quarto-projects/index.qmd` — delete the `cd starter/` paragraph + root-render warning + the
  Troubleshooting nested-trap lines; "open `day2-projects/`"; solution pointer → `solutions/day2/`.
- `_quarto.yml` `render:` — files that move into the exercises-repo-only role leave the site render
  list (validation transfers to the exercises-repo CI); the demo `dashboard.qmd` stays.
- Slides — grep `slides/**` for hardcoded `labs/…` paths; step-0 frames get a "you opened the right
  folder" IDE screenshot (per `rules/multi-day-sequencing.md` §5, keep callbacks true).
- **Wednesday tie-in (free win):** the git session can put `day2-projects/` under version control —
  "create your own repo" returns exactly when git exists.

## 5. Learner-UX (pedagogy design did not return — this section is the thinner one, verify)

- **Identical obtain-UX both days** (one sentence: "open `dayN-…` from Setup"); an IDE-title-bar
  screenshot as the "you are here" check on the first slide of each lab.
- **Between-parts break / "nobody stranded":** `day1-intro/starter.qmd` is the known-good Part-1
  report to start Part-2 from — already shipped, now in the delivered folder.
- **Day-2 without Day-1 output:** `day2-projects/` is fully self-seeded (doesn't depend on Day-1's
  artifact), so a fresh Day-2 arrival is not blocked.
- **Reset-without-losing-work:** re-`use_course()` makes a *new* folder (old attempt preserved), or
  re-extract selected files from the kept ZIP. No git needed.
- *(Open — grab from the pedagogy agent if it lands: finer reveal-solution flow + reset ergonomics.)*

## 6. Top risks + mitigations

1. **Cross-repo drift** (lab prose here ↔ files there): the sync script is the *only* write path to the
   exercises repo (never hand-edit it); exercises-repo CI renders everything; a pre-workshop
   **`run-labs` dry-run against a real `use_course()` unpack** (not the dev checkout); freeze the
   edition branch the Friday before, hotfix by additive cherry-pick.
2. **Room network / no-setup stragglers:** setup-before-arrival is step 0; tiny zip; USB sticks;
   browser Plan-B; budget a 10-min "everyone open `day1-intro`" checkpoint at the start of Day 1.
3. **Wrong-folder work** (opens the repo root, or creates Day-2's `_quarto.yml` too high): now
   *benign* (a local, visible, harmless render on the Desktop, not a foreign `_site/`), mitigated by
   the root README "open a day folder, not this one" + the IDE screenshot + roaming helpers.

## 7. Honest cost
Two repos, two `renv.lock`s (site build vs. participant contract, overlapping on 8 packages), a sync
script + CI, and the "one site render validates everything" property moves to the exercises-repo CI
(one remove). The lab page (browser) and the working folder (local, deliberately without the lab
prose) are now separate. Bought: a trap that cannot fire, a zip ~100× smaller, a clean NBIS fold-in,
one-click instructor reuse, and per-edition pins that keep every past handout working.

## 8. Build order
1. Create `cderv/raukr-quarto-exercises` (public, CC BY, template flag); scaffold README/.Rproj/
   DESCRIPTION/renv; write `00-check-setup.R`.
2. Write the course-repo role-manifest **sync script** + `just exercises`; run it; commit first synced state.
3. **Empirically verify** a single-file Typst render in `day1-intro/` picks up the sibling `_brand.yml`
   (brand discovery for non-project renders); add explicit `brand:` front-matter if not.
4. Exercises-repo CI (render solutions + starter + `sample-typst.qmd` + no-root-`_quarto.yml` +
   zip-size); course-repo sync drift-guard CI.
5. Add the `exercises.zip` mirror to the course-site publish pipeline.
6. Rewrite `setup.qmd` + both lab pages + slide step-0 frames; delete the `cd starter/` machinery.
7. **End-to-end dry run on a clean machine** via `run-labs` against a real `use_course()` unpack; both
   reset paths. Fix friction.
8. ~Aug 1: cut the `raukr-2026` edition branch, pin it on Setup, declare content freeze; load USB
   sticks; print the "open this folder" screenshots into the decks.

## Critical files
- `setup.qmd` · `labs/quarto/index.qmd` · `labs/quarto-projects/index.qmd` · `_quarto.yml` (render list)
- `.claude/plans/2026-07-21-companion-package-scoping.md` (the no-package rationale + the manifest-sync
  design to reuse; the `check_setup()` spec to translate into `00-check-setup.R`)
- New repo `cderv/raukr-quarto-exercises` + a course-repo `tools/sync-exercises.R` (or `pkg/data-raw/`-style)

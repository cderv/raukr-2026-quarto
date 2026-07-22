# Content build plan — RaukR 2026 Quarto (Day 1 + Day 2)

> **Status:** active plan · **Date:** 2026-07-07 · **Branch:** `claude/project-continuation-fdg2ir`
>
> The scaffold is done (site renders green, brand, renv, freeze guard). This plan turns the four
> **skeletons** into finished content, and is written to be **executed autonomously** — each work
> package (WP) is a self-contained `/goal` with done-criteria, and the review cycle is a `/loop`.
>
> **This plan does not restate the pedagogy** — it *operationalizes* three locked references. Read
> them first; this plan only adds build order, source→destination wiring, verification, and prompts:
> - `.claude/references/topic-store.md` — the confirmed triage, **per-part time budgets**, and the
>   9 **running-order rules**. This is the spec for *what* each beat contains and *in what order*.
> - `.claude/references/prior-art-inventory.md` — the **sources**: exercise catalogue, the NBIS
>   harvest map (line-level), the re-skin tax, the 4 build-fresh items, keystone assets.
> - `.claude/references/project-context.md` — stack, dataset (base-R `penguins`), house content
>   patterns, portability rules.

---

## 0. How to run this plan (autonomous modes)

**One WP = one `/goal`.** Each WP below has: *inputs → outputs → steps → done-when → verify*. To run a
WP, hand yourself the **`/goal` prompt** in § 6 (they are copy-paste ready). A WP ends only when its
verification ladder (§ 4) is green **and** its reviewer-panel P0/P1 are resolved.

**The review cycle = a `/loop`.** After a draft renders, run `/start-workshop` (fans out the 4
reviewer sub-agents), triage, fix, re-run — until P0 = P1 = 0. The `/loop` prompt is in § 6.

**Golden rules while authoring** (from the references — enforced, not optional):
- One dataset through the whole arc: **base-R `datasets::penguins`** (columns `bill_len`,
  `bill_dep`, `flipper_len`, `body_mass`; R ≥ 4.5). Never `palmerpenguins`, never
  `bill_length_mm`. Native pipe `|>`, never `%>%`. US English.
- Every lifted snippet pays the **re-skin tax** (prior-art § re-skin tax) in the same pass:
  drop `library(palmerpenguins)`, rename columns, `%>%`→`|>`, refresh dates, drop RStudio-first framing.
- Mode-markers = built-in callouts at the **two transitions only** (`project-context.md` § Content
  patterns). Gloss jargon on first use. `## Learning Outcomes` open / "What you can do now" close.
- After editing an executable `.qmd`: **re-render it and stage `_freeze/`** (the PreToolUse hook
  blocks the commit otherwise).

---

## 1. Prerequisite — sourcing (WP0a, do once)

The prior-art repos are **not** in this session. Clone them to a throwaway location (the `.gitignore`
already lists these dir names at repo root as gitignored throwaway clones), then lift + re-skin. These
are **Christophe's own** (reuse freely) except NBIS (reference only, CC BY-NC-SA — do **not** vendor):

| Clone | Role (prior-art §) | Key files |
|-------|--------------------|-----------|
| `cderv/raukr-2025-quarto` | **Day-1 deck base** | the standalone EN deck |
| `cderv/user2024-tutorial-quarto` | **Day-1 lab** (penguins Ex1-8) + **Day-2 deck base** | `3-projects.qmd:22-947`; the penguins exercise progression; `new-penguins-full-example-corrected.qmd` |
| `cderv/tuto-quarto-typst-rr-2026` | **Typst payoff** + **R-side `_brand.yml`** | Star Wars Typst lab (reskin→penguins); book `theme_brand_*` |
| `cderv/user2024-quarto-talk` | Day-1 **opening hook** | why-Quarto slides |
| `NBISweden/raukr-2026` (**reference**) | harvest map targets | `slides/quarto/`, `labs/quarto/`, `labs/quarto-site/` (see prior-art § NBIS harvest map for exact `file:line`) |

Clone command (into scratchpad or gitignored repo-root dirs):
```bash
for r in raukr-2025-quarto user2024-tutorial-quarto tuto-quarto-typst-rr-2026 user2024-quarto-talk; do
  git clone --depth 1 https://github.com/cderv/$r "$SCRATCH/$r"
done
git clone --depth 1 https://github.com/NBISweden/raukr-2026 "$SCRATCH/raukr-2026"   # check develop too
```
> If a clone is blocked by the network policy, use `add_repo` for the `cderv/*` repos (Christophe's).
> NBIS is cross-owner → throwaway clone only, never committed.

---

## 2. Shared assets (WP0b) — build before the day-specific WPs

Both days' demos and exercises draw on these. Build + verify them **first** so the arc is coherent:

| Asset | Dest | Source / note | Verify |
|-------|------|---------------|--------|
| Running **penguins document** (grows through Day-1) | `labs/quarto/` (+ a slide demo copy) | keystone `new-penguins-full-example-corrected.qmd`, re-skinned | renders HTML **and** `--to typst` |
| `references.bib` (5-6 entries) | repo root or `labs/quarto/` | **build-fresh**; include **Gorman et al. 2014, PLoS ONE** (the penguins paper — anchors the citation payoff) | `@key` resolve in HTML **and** Typst |
| A mainstream **CSL** | co-located | e.g. `apa`/a journal CSL | bib renders in Typst specifically (CSL↔Typst edge cases) |
| **Sample Typst** doc + `_brand.yml` PDF styling | `labs/quarto/` | reskin Star Wars Typst lab → penguins + RaukR brand | `quarto render --to typst` → branded PDF, no LaTeX |
| **R-side brand** helpers (`theme_brand_ggplot2/gt`) | demo chunk | lift from typst-2026 book; needs `install.packages("brand.yml")` → add to `DESCRIPTION` + `renv::snapshot()` | ggplot/gt pick up RaukR palette |

**Dependency note:** adding `brand.yml` (the R package) or any new package = edit `DESCRIPTION`
`Imports:`, `renv::install()`, `renv::snapshot()`, commit `renv.lock`, and mirror on `setup.qmd`.

---

## 3. Build order — the work packages

Critical path: **WP0 → WP1 → WP2** (Day-1 deck then lab) and **WP0 → WP3 → WP4** (Day-2). Day-1 and
Day-2 are independent after WP0; a single agent does them sequentially (Day-1 first — most reuse,
defines the penguins arc). Sub-agents may parallelize *harvest* and *review/verify* within a WP (§ 5).

| WP | Target | Primary sources (see prior-art harvest map for `file:line`) | Build-fresh |
|----|--------|--------------------------------------------------------------|-------------|
| **WP0** | sourcing + shared assets (§ 1-2) | all clones | bib, CSL, sample Typst |
| **WP1** | `slides/quarto/` (Day-1 deck) | raukr-2025 deck (base) · user2024-talk hook · NBIS engine-mermaid `slides/quarto:535-562` | Citations→Typst slides; Positron×Quarto (DEMO) |
| **WP2** | `labs/quarto/` (Day-1 lab) | user2024 penguins Ex4/Ex5 · typst-2026 Ex1 · NBIS troubleshooting `labs/quarto:603-611` | **Citations exercise** |
| **WP3** | `slides/quarto-projects/` (Day-2 deck) | **user2024 `3-projects.qmd:22-947`** (promote) · freeze/cache `:797-896` | Dashboards; Interactivity (htmlwidget) |
| **WP4** | `labs/quarto-projects/` (Day-2 lab) | NBIS website lab `labs/quarto-site:84-390` (reframe) · dual-publish `:456-513` · typst-2026 Ex2 | starter project; watch-me publish framing |
| **WP5** | `index.qmd` + `setup.qmd` + a **Resources** page | STORE topics + NBIS "learning more" gallery `labs/quarto-site:515-593` | resources/appendix page |

**Per-WP loop** (every WP follows this): draft from sources (re-skin) → **V0-V1 verify** (§ 4) →
`/start-workshop` **V2** → triage P0/P1 → fix → **V3** budget check → worklog + review-ledger →
commit (freeze staged). WP done only when P0 = P1 = 0.

---

## 4. Verification ladder (what we can actually check)

Run in order; a WP is not done until all four are green.

- **V0 — Build.** `just render` exits 0; `_site/` has the page; `_freeze/**/execute-results/` staged
  (PreToolUse hook enforces on commit). For a deck, confirm it renders **revealjs** not html.
- **V1 — Content smoke-tests** (scriptable; run as a verifier sub-agent):
  - Re-skin complete: `rg -n 'palmerpenguins|bill_length_mm|flipper_length_mm|body_mass_g|%>%'` in
    the WP's files → **must be empty**.
  - **Typst payoff renders:** `quarto render <doc> --to typst` → a PDF exists; for WP2 the **citations
    resolve in Typst** (open/parse the PDF text, or check no `?@` / unresolved-cite markers).
  - Cross-refs resolve: rendered HTML has no `?@fig-`/`?@tbl-`/`?@eq-` placeholders.
  - `fig-alt` on every image (use the `quarto-alt-text` skill).
  - **Jargon gloss** checklist — first appearance of *Typst, outset/inset, CSL, shortcode, freeze,
    OJS, Shinylive* carries a one-line definition (running-order rule 7).
  - Portability: no extension shortcodes (`{{< fa >}}`) unless declared; no absolute `/assets` paths
    (project-context § portability).
- **V2 — Reviewer panel** (`/start-workshop`): the 4 sub-agents (technique / pedagogue / beginner /
  language) each write a dated report to `.claude/archive/reviews/` and return P0/P1/P2. Triage,
  fix P0+P1, record disposition in the ledger. This is the main quality gate.
- **V3 — Time-budget fit** (`topic-store.md` § time budget): does the part's talk+demo fit ~18-20 min
  at ~2:1 hands-on? If the beat list overflows, **cut from the list, not the exercise** (the gating
  test for CORE). A judgment check, but explicit.

---

## 5. Sub-agent decomposition

Author with the **main agent** (coherence across the arc — one dataset, one voice — is easily lost if
two agents draft the same doc). Fan out the **bracketing** work:

- **Harvest agents** (parallel, `Explore`/`general-purpose`): one per source file — *"read
  `<clone>/<file>` lines A-B, extract `<beat>`, return it re-skinned to base-R penguins + `|>`,
  modernized (Quarto 1.9, Positron, no RStudio-first)."* Returns a ready-to-paste snippet, not prose.
- **Reviewer panel** (parallel, the existing `workshop-reviewer-*` via `/start-workshop`): V2.
- **Verifier agents** (parallel, `general-purpose`): one per V1 check (Typst render; grep audits;
  xref/fig-alt; jargon gloss). Each returns pass/fail + offending lines.
- **Isolation:** if two WPs are drafted concurrently (e.g. WP1 and WP3), give each agent a **worktree**
  (`isolation: "worktree"`) so their `_freeze/` + file writes don't collide; merge sequentially.

Recommended shape per WP: `harvest (parallel) → main agent drafts → verify (parallel) + panel
(parallel) → main agent triages/fixes → commit`.

---

## 6. Ready-to-use prompts

### 6a. `/goal` — author one work package (template)

> **Goal: author WP<N> — <target>.** Read `.claude/plans/2026-07-07-content-plan.md` § 2-4 and the
> three references it names. Sources for this WP: <rows from § 3>. Clone/ött prior-art per § 1 if not
> present. Draft `<target>` from those sources, **re-skinned to base-R penguins + `|>`**, following the
> `topic-store.md` beats/budget for this part and the 9 running-order rules. Build the shared assets in
> § 2 that this WP needs. Then run the **verification ladder** (§ 4): V0 render green + freeze staged;
> V1 smoke-tests (fan out verifier sub-agents); V2 `/start-workshop` panel → triage & fix all P0+P1,
> record dispositions in the review ledger; V3 budget fit. Update `.claude/worklog.md`. Commit when
> P0 = P1 = 0 and the ladder is green. Do **not** proceed to the next WP in the same run — stop and report.

Filled example (WP1):

> **Goal: author WP1 — the Day-1 deck (`slides/quarto/index.qmd`).** Base it on the
> `cderv/raukr-2025-quarto` deck (reskin to the RaukR `_brand.yml`, modernize: Quarto 1.9, `|>`,
> Positron alongside VS Code/RStudio, drop RStudio-centrism), fold in the useR!-2024-talk opening hook
> (aspiration, not "Rmd++"), and the NBIS engine-mermaid slide (`slides/quarto/index.qmd:535-562`,
> modernized). Cover the Day-1 Part-1 + Part-2 beats and budget from `topic-store.md`. Mode-markers =
> callouts at the two transitions; `## Learning Outcomes` open / "What you can do now" close; gloss
> Typst/CSL/outset-inset on first use. Verify per § 4, run `/start-workshop`, fix P0+P1, commit.

### 6b. `/loop` — the review cycle

> `/loop 0 /start-workshop` — run the reviewer panel on the current draft, then **triage**: fix every
> P0 and P1, record each review's disposition in `.claude/archive/reviews/README.md`, note changes in
> `.claude/worklog.md`, re-render + stage `_freeze/`. **Stop the loop when a full panel returns P0 = P1 = 0**
> (a `bis`/`ter` re-review with no P0/P1). Never edit a past review — re-reviews get a new dated file.

### 6c. `/goal` — a single verification sweep (between drafts)

> **Goal: verify `<target>` (V1).** Run the § 4 V1 smoke-tests as parallel verifier sub-agents:
> (1) `rg` for palmerpenguins/old-columns/`%>%` → empty; (2) `quarto render <target> --to typst` →
> PDF, citations resolved; (3) xref/fig-alt audit; (4) jargon-gloss checklist. Return a pass/fail
> table with offending `file:line`s; fix the fails.

---

## 7. Definition of done (content phase) & risk register

**Done when:** all 4 docs authored + WP5 support/resources; each passed V0-V3 with P0 = P1 = 0; the
penguins arc is coherent HTML→Typst; `_brand.yml` applies to site + slides + R plots; publishing is a
watch-me demo (never a live 40-laptop `publish`); worklog + review ledger current; site renders green
and the frozen results are staged.

**Risks / watch-items** (from the panels + this session's review):
1. **Render scope.** `_quarto.yml` `render:` matches only `slides/*/index.qmd` + `labs/*/index.qmd`.
   The moment a WP adds a supporting/starter/sample `.qmd`, **widen the render list** (or the file
   silently won't build). Decide the exact structure per WP and update `_quarto.yml`.
2. **Typst + citations** is the thinnest, most edge-case-prone asset (CSL↔Typst-native bib). Smoke-test
   in Typst *specifically*, early (WP0).
3. **Publishing P0** (beginner panel): a live per-participant `quarto publish gh-pages` is a room-killer
   — keep it a watch-me DEMO on a pre-provisioned repo; hands-on = `render` + `output-dir`.
4. **htmlwidget freeze libs** (low risk — confirmed against quarto-cli via DeepWiki that
   `_freeze/site_libs/` is regenerable and not meant to be committed). If a *frozen* Day-2 page ever
   gains a plotly/leaflet widget and its lib fails to load off-engine on CI, un-ignore / selectively
   track that lib in `.gitignore`. Not expected to bite (interactivity is a watch-me DEMO).
5. **Slot overrun.** Slots are upper limits; V3 is the gate — cut from the beat list, never the lab.

---

## 8. Suggested first run

1. **WP0** (`/goal` 6a for sourcing + shared assets) — clone, build `references.bib` + sample Typst +
   penguins doc, prove the Typst+citations path. Smallest, de-risks the whole Day-1 payoff.
2. **WP1** then **WP2** (Day-1 deck → lab), each ending on a clean `/start-workshop`.
3. **WP3** then **WP4** (Day-2), then **WP5**.
4. Between drafts, `/loop` 6b until panels are P0 = P1 = 0.

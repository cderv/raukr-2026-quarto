# Coverage-gap audit — Day 2 "Quarto projects" (projects · websites · books · publishing · reproducibility)

> Region: projects + websites + books + publishing + reproducibility. Scope: the assigned
> Quarto topic set from quarto.org/llms.txt, fetched live (not from memory) and judged against
> our Day-2 triage in `topic-store.md`. Audience frame: advanced R / life-science, building a
> **team capstone site**, material must **fold back into the NBIS RaukR tree**. Budget: **2 ×
> ~55-min effective parts, ~2:1 hands-on** — slots are upper limits.
>
> Reviewer: coverage-projects. Snapshot — do not edit; a re-review gets a `bis` file.

## Verdict

The Day-2 triage is **directionally right and correctly weighted on the spine** (project →
website → cross-refs → freeze → publish). The gaps are **not in the CORE** — they're in the
**reproducibility leg** and in **two integration-critical mentions** that the current triage
under-weights relative to *this project's own stated goals*.

**One real hole:** the reproducibility story is currently **one-legged (freeze only)**. For a
life-science capstone team, `renv` is the other leg and it is **ABSENT** from the triage entirely.
Freeze answers "don't re-run the slow compute"; renv answers "reproduce *what* runs." You cannot
tell the CI-renders-without-R story honestly without naming how the local environment that
*produced* `_freeze/` is itself pinned.

**Two under-weighted mentions that this project specifically needs:** `_metadata.yml` (the
`project-context.md` integration goal literally depends on directory metadata travelling with
files) and **drafts** (the natural team-collaboration feature for a shared capstone site).

**Overload risk:** the "demos if time" tail of Part 2 stacks **four** DEMOs (`_brand.yml` is
safely in Part 1, but Books + Dashboards + Interactivity all queue behind the publish payoff).
That tail realistically fits **one**. Books is the one to demote.

## TOP GAPS (ranked)

1. **renv / reproducible R environment** — *ABSENT.* The biggest gap. Pair it with freeze as a
   **two-legged reproducibility slide**: `freeze` = skip re-execution at project build (commit
   `_freeze/`, CI renders without R); `renv.lock` = pin the package versions that produced those
   results and let the **team** rebuild the same environment. This is keystone reproducibility for
   bioinformatics and directly serves the capstone-team hook. **Real slot: one slide inside the
   existing Freeze CORE beat** (no new hands-on) + resources link. Do not ship a "CI renders
   reproducibly" claim with only freeze.
   [/docs/projects/virtual-environments.html] [/docs/projects/code-execution.html]

2. **`_metadata.yml` (directory metadata)** — *in triage as a buried MENTION, under-weighted.*
   `project-context.md` § Repository layout makes this **load-bearing for the integration goal**:
   directory-level metadata (same schema as `_quarto.yml`, inherited only within its dir) is
   exactly what lets a file + its `{{< meta >}}` keys survive the move into the NBIS tree. **Real
   slot: one concrete slide in the `_quarto.yml` CORE beat** — "project vs directory vs document
   metadata, and why folder-level travels." Elevate from throwaway-link to shown-once.
   [/docs/projects/quarto-projects.html]

3. **Drafts workflow (`draft: true` / `draft-mode`)** — *ABSENT.* The obvious team feature for a
   shared capstone site: publish the site while a teammate's page is still WIP; `quarto preview`
   shows drafts, `render` hides them. **Real slot: one-line MENTION** tied to the "your team ships
   the capstone" hook. Cheap, high relevance. [/docs/websites/website-drafts.html]

4. **Website tools cluster — social cards / redirects / 404 / "search is already on"** — *ABSENT.*
   Bundle as **one MENTION slide or a resources block**, not four topics. Two earn their line:
   **redirects** (`_redirects`) matter precisely when the NBIS fold-in relocates URLs and breaks
   links; **search is free** (on by default, zero config) — worth saying so nobody builds it.
   OpenGraph/social cards and custom 404 are polish → resources. [/docs/websites/website-tools.html]
   [/docs/websites/website-search.html]

5. **Pre-render / post-render scripts** — *ABSENT.* Genuine bioinformatics fit (data import/prep
   before render, integrated into `quarto render` without an external build tool). But it competes
   with the justfile framing and adds surface. **Resources page / one-line MENTION**, not a slot.
   [/docs/projects/scripts.html]

## Mapping table

| Topic | Quarto page | Fit for Day-2? | In our triage? | Recommendation | 1-line why |
|-------|-------------|----------------|----------------|----------------|------------|
| **Project Basics (`_quarto.yml`, output-dir, metadata merge)** | /docs/projects/quarto-projects.html | yes | CORE | keep-CORE | The one-file→whole-project jump; already the Part-1 spine. |
| **`_metadata.yml` (directory metadata)** | /docs/projects/quarto-projects.html | yes | MENTION (buried, w/ profiles) | **add-MENTION → shown slide** | Load-bearing for the NBIS fold-in: folder metadata travels with the file (integration goal). |
| **Project Profiles (`--profile`, `_quarto-<p>.yml`)** | /docs/projects/profiles.html | edge | MENTION | keep-MENTION | Real (dev-vs-CI freeze, `content-visible when-profile`) but advanced; one slide/link, don't demo. |
| **Code Execution Mgmt — Freeze** | /docs/projects/code-execution.html | yes | CORE | keep-CORE | `_freeze/` is what lets CI render without R; the reproducibility payoff. |
| **Caching (`cache`)** | /docs/projects/code-execution.html | yes | CORE (paired w/ freeze) | keep-CORE | The `cache` (within-doc) vs `freeze` (project build) contrast is the teachable distinction. |
| **Virtual Environments / renv** | /docs/projects/virtual-environments.html | yes | **ABSENT** | **add-MENTION (slot in Freeze beat)** | **TOP GAP #1** — renv.lock is the second reproducibility leg; the team's shared environment. |
| **Project Environment Variables (`_environment`)** | /docs/projects/environment.html | no | ABSENT | skip / resources | Credentials & data-URL defaults — real but niche; not needed to build a capstone site. |
| **Project Scripts (pre/post-render)** | /docs/projects/scripts.html | edge | ABSENT | add-MENTION / resources | Data-prep hook for bioinformatics, but overlaps the justfile framing; one line at most. |
| **Using Binder (`quarto use binder`)** | /docs/projects/binder.html | no | ABSENT | skip / resources | Jupyter/webR-flavored reproducible env sharing; adds flakiness, off the R-first path. |
| **Website Navigation (navbar/sidebar/page-nav)** | /docs/websites/website-navigation.html | yes | CORE | keep-CORE | Navbar + sidebar depth is core to "turn `.qmd` into a navigable site." |
| **About Pages** | /docs/websites/website-about.html | edge | STORE ("blog plumbing") | keep-in-lab / MENTION | Quick win (`about: template:`) and already in the harvested website-lab spine; don't spend slide time. |
| **Drafts (`draft:`/`draft-mode`)** | /docs/websites/website-drafts.html | edge→yes | **ABSENT** | **add-MENTION** | **TOP GAP #3** — the team-collaboration feature for a shared capstone site; one line. |
| **Document Listings** | /docs/websites/website-listings.html | yes | CORE (under Websites) | keep-CORE | Auto-generated index pages; the capstone's "results/reports" landing. |
| **Custom Listings** | /docs/websites/website-listings.html | no | ABSENT | skip / resources | Advanced (custom fields/templates); default listings cover the audience. |
| **Website Search** | /docs/websites/website-search.html | edge | ABSENT | add-MENTION (one line) | **On by default, zero config** — say "you already have search," don't build it. |
| **Website Tools (social cards/analytics/404/redirects/dark-mode)** | /docs/websites/website-tools.html | edge | ABSENT | **add-MENTION (bundle)** | **TOP GAP #4** — redirects for the NBIS URL move + social cards as polish; one slide/resources. |
| **Creating a Blog** | /docs/websites/website-blog.html | no | STORE ("blog plumbing") | keep-STORE | Explicitly a specialization of website+listings — audience gets it from the CORE, no new machinery. |
| **Output for LLMs (`llms-txt`)** | /docs/websites/website-llms.html | no | ABSENT | skip (fun aside at most) | Brand-new, cute for a Posit presenter, but zero capstone value; cut for budget. |
| **Cross-referencing (across project)** | /docs/books/book-crossrefs.html | yes | CORE | keep-CORE | Organizer-listed; cross-refs reaching across pages/chapters is the project-scale delta. |
| **Book Structure** | /docs/books/book-structure.html | edge | DEMO | **DEMO → MENTION** | Shares ~90% machinery with websites; the *book-vs-website decision* is a 1-slide, not a live demo. |
| **Customizing Book Output** | /docs/books/book-output.html | no | ABSENT | skip / resources | Cover images, download buttons — inherited website features; nothing new to teach. |
| **Book Crossrefs** | /docs/books/book-crossrefs.html | yes | CORE (as cross-refs) | keep-CORE | Same `@` syntax reaching across chapters + auto chapter numbering; folds into the cross-ref beat. |
| **Publishing Basics (`quarto publish`, output-dir)** | /docs/publishing/index.html | yes | CORE (render+dir) / DEMO (publish) | keep | Hands-on = `render` + `output-dir`; `publish`/CI = watch-me. Correctly split by the panel. |
| **GitHub Pages** | /docs/publishing/github-pages.html | yes | CORE(manual) / DEMO(gh-pages+CI) | keep | Manual `docs/` route = auth-light hands-on; `publish gh-pages`/Action = the watch-me story. |
| **Publishing with CI** | /docs/publishing/ci.html | yes | DEMO (watch-me) | keep-DEMO | The CI + `_freeze` (+ renv) story is the reproducibility climax — narrate it, can't run it live. |
| **Quarto Pub** | /docs/publishing/quarto-pub.html | edge | MENTION ("other targets") | keep-MENTION | Zero-auth-friction alternative worth a link; not the gh-pages spine. |
| **Netlify** | /docs/publishing/netlify.html | no | STORE (Day-1 list) / MENTION | keep-MENTION (link) | One of many targets; the *pattern* (render→push) generalizes, so a link suffices. |
| **Posit Connect (+ Cloud)** | /docs/publishing/rsconnect.html | edge | MENTION | keep-MENTION (link) | Connect Cloud is free & Posit-hosted (relevant to Christophe's frame); link, don't teach. |
| **Hugging Face Spaces** | /docs/publishing/hugging-face-spaces.html | no | ABSENT | skip / link | ML-hosting niche; off-audience. |
| **Confluence** | /docs/publishing/confluence.html | no | STORE | keep-STORE | Enterprise wiki target; explicitly cut in Day-1 triage, stays cut. |
| **Publishing with CI — other services** | /docs/publishing/other-services.html | no | MENTION | keep-MENTION (link) | "Anywhere that serves HTML" — one reassuring line + link. |

## Mis-triage findings

- **Publishing labelled CORE slightly oversells the CORE kernel.** The genuine hands-on CORE is
  narrow — `quarto render` + `output-dir` + point Pages at it (which is really a *project-basics*
  feature). Everything with teeth (`publish gh-pages`, the Action, `_freeze` in CI) is DEMO/story
  by the panel's own P0 call. **Not a bug — keep it** (render-to-dir *is* the Part-2 payoff and
  must stay CORE), but author it honestly: the payoff exercise is "your project renders to a
  publishable folder," and the reproducible-CI arc is the narrated climax on the pre-provisioned
  repo. The thing that makes that arc *true* is the missing renv leg (Gap #1).

- **Books: DEMO → MENTION.** Books is currently a post-payoff DEMO competing with Dashboards and
  Interactivity for the same ~5-min cut-able tail. It shares almost all machinery with the Websites
  CORE (config, cross-refs, search, nav) — the *only* new teachable is the **book-vs-website
  decision** and single-document/numbered-chapter output, which is a **one-slide conceptual**, not
  a live build. Demote to a MENTION slide ("same project engine, linear navigation model — pick a
  book when you want numbered chapters / a PDF deliverable; here's the doc") + Christophe's
  typst-2026 book lab as the resources link. Frees the tail for the more novel demo.

- **`_metadata.yml` + profiles bundled as one MENTION under-serves `_metadata.yml`.** They're
  different weights *for this project*: profiles is genuinely optional/advanced (keep MENTION), but
  `_metadata.yml` is integration-critical per `project-context.md`. Split them; promote
  `_metadata.yml` to a shown slide, leave profiles as the link.

## Redundancy / overload — what to drop to protect the budget

The Part-2 post-payoff tail is the pressure point. In priority order:

1. **Keep exactly one after-payoff live demo.** The strongest for this audience is the
   **htmlwidget/dashboard** ("share results with a wet-lab collaborator" — beginner P2-3 hook).
   Demote **Books → MENTION** (above). Interactivity stays a single htmlwidget teaser; OJS/Shinylive
   remain link-only (already MENTION, correct).
2. **Bundle the new website mentions into one slide,** don't scatter them: *drafts + search-is-free
   + redirects/social-cards* → a single "website tools you'll want for the capstone" slide + a
   resources block. Three of my top gaps collapse into one low-cost slide.
3. **Fold renv into the existing Freeze CORE beat** — one extra slide, no new hands-on. It doesn't
   add a segment; it completes one.
4. **Blog stays STORE, About stays in-lab.** Both are website+listings specializations the audience
   infers from CORE — no separate airtime.

Net: **+~2 slides** (renv leg; a bundled website-tools mention), **+1 slide promoted**
(`_metadata.yml`), **−1 live demo** (Books → MENTION). Budget-neutral to slightly positive, and it
closes the reproducibility hole and the two integration-critical mentions.

## Safe to skip (resources page or cut)

Project Environment Variables · Binder · Custom Listings · Output-for-LLMs · Customizing Book
Output · Hugging Face Spaces · Confluence · deep dives on Netlify/Connect/Quarto-Pub (links only) ·
About-page template tour (the lab already ships one). None of these move the needle for an advanced
R team building and publishing a capstone site in ~2 hours.

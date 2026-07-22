# Work log — RaukR 2026 Quarto session

The **work-done log** for this repo (dev-in-the-open): notable decisions and changes, newest
first, in loose [Keep a Changelog](https://keepachangelog.com/) style. Rationale for reviews lives
in `.claude/archive/reviews/` (see the ledger there). Not a released-product changelog — there are
no releases; this is the running record of what was built and why.

## Log

### Register the accessibility learnings — brand.md, a strand, Quarto issue drafts — 2026-07-22

Closing the "is this all captured?" gaps from this session's a11y work:

- **`rules/brand.md`** (the path-scoped rule surfaced when editing `_brand.yml`/theme SCSS) was
  **stale + thin** — fixed. § 3 said `link-teal` was `#3C7C83` (now `#33666B`); added **§ 5** capturing
  the WCAG-AA contrast fixes: `$secondary` teal-light used as muted text (captions / `.column-margin` /
  `.blockquote` at ~1.74:1) with the specificity traps (`.blockquote`, `.column-margin figcaption`);
  `$primary` as navbar bg (3.33:1) → darken the bar only; the `typography.link.color`-not-reaching-
  `$link-color` gap; and "pick the link/text teal against the grey code bg, not just white" (why
  `#33666B` not `#3C7C83`). Verify-with-axe + the known false positives noted.
- **Accessibility-checker agent → braid strand `the tracker`** (not built now, per Christophe): a 5th
  `workshop-reviewer-accessibility` panel agent that checks all content (contrast via axe, colour-blind
  palettes, alt text, callout icons, semantic structure). The strand carries the **axe-run method**
  (the CDN-block workaround, local-server + Playwright inject, the false-positive filter) so that
  knowledge is durable until the agent is built (promote scratch `axe-inject.mjs` → `.claude/scripts/`).
- **Quarto issue drafts** → `.claude/archive/issues/2026-07-22-quarto-accessibility-findings.md`: three
  candidates (brand `typography.link.color` gap; arrow `.at` token sub-AA on the grey code bg; axe
  false-positives on callout icons/toggles). **Not filed** — each marked "verify against 1.10.x first";
  the link-colour one flagged "confirm it's not a config-form issue before filing."

### Fix double callout icons in the labs (`icon=false`) — 2026-07-22

Spotted from a screenshot: every lab callout with a `{{< fa … >}}` title showed **two** icons — the
custom fa icon **plus** the callout type's default (worst case: `## {{< fa lightbulb >}} Hint` on a
`callout-tip`, whose default is *already* a lightbulb → two lightbulbs). Researched the fix
(context7 + deepwiki, from the Quarto source): HTML callout icons are **per-type SVG-in-CSS via a
`::before`**, there is **no native custom-icon attribute**, and Quarto's own Lua `fa_icon`
customization is **Typst-only** — so a `{{< fa >}}` in the title always stacks on the default. The
lever is **`icon=false`** (per-callout or global `callout-icon: false`). Fix applied to
`labs/quarto/index.qmd` + `labs/quarto-projects/index.qmd`: add `icon=false` to every callout with a
*distinct* custom icon (Tasks/clipboard, "You should see"/check, Troubleshooting/wrench,
accessibility/♿); for **Hint** (tip, lightbulb = the default) **drop the `{{< fa lightbulb >}}`** and
use the native icon. Verified in the built HTML (`no-icon` class + single fa icon; zero
`fa-lightbulb`). Updated the **lab callout icon scheme in `project-context.md`** — which had baked in
the bug (no `icon=false`, and a `{{< fa lightbulb >}} Hint`) — so the house style is now correct.

### Add an accessibility teaching beat + Okabe-Ito on the penguins plot — 2026-07-22

Follow-on to the contrast work: accessibility was taught only as `fig-alt`. Added a **Day-1 Part-1
slide "Make it accessible"** (end of the authoring beats, before "One source -> many formats") framing
accessibility as three habits — **alt text** (callback, they already do it), **colour-blind-safe
palettes** (Okabe-Ito), and **checking contrast with Quarto's built-in `axe`** — and threaded the
thread through **Learning Outcomes** and **"What you can do now"**. Matching **lab callout** in
`labs/quarto/index.qmd` (`{{< fa universal-access >}} Make it accessible`) pointing at
`scale_color_okabe_ito()` + **`axe: {output: document}`** (a visible on-page WCAG report — chosen over
`axe: true`/dev-tools console so a lab checkpoint needs no dev-tools) + the Quarto html-accessibility
doc. One slide + a lab note,
**not** a hands-on exercise (tight budget); logged in `topic-store.md` MENTION so it isn't read as
scope-creep. Both slides fit-checked (`slide-shot.mjs`: accessibility + wrap-up = 720/720). Later refinements: a
**Learn more** link to Quarto's HTML-accessibility doc on the slide; **cut the "~8% of men" CVD stat**
(first footnoted, then dropped — low-value aside, and it was duplicated slide+lab); and **trimmed the
lab callout to actionable-only** (slides carry the *why*, the lab carries the *do* — `add
scale_color_okabe_ito()` / `add axe: {output: document}` + a doc link, no re-explaining). En route we
confirmed (deepwiki + quarto.org) that **revealjs has no margin** — footnotes/asides render
bottom-of-slide; `reference-location: margin` / `.column-margin` are HTML/Typst article-layout only.
Baked two register rules into **`workshop-reviewer-language`**: cut (don't reflexively footnote)
low-value slide asides, and don't duplicate a slide's explanation in the lab.

**Okabe-Ito applied** to the penguins scatter (the concrete tie-in): `ggokabeito::scale_color_okabe_ito()`
on `penguins-report.qmd` (the running/branded report) and on the lab's target + solution plots, with
`shape = species` kept for redundant encoding. Added **`ggokabeito`** to `DESCRIPTION` `Imports:` and
`renv::snapshot()`ed (renv.lock). Gate honoured: the plot default was changed **only because** we now
have a slide that explains the *why* (user's call).

**Content grounded by a research subagent** (Context7 + quarto.org, no memory): `axe` is axe-core,
built into Quarto **since 1.8** (so it works in our 1.9.38), formats html/revealjs/dashboard, output
modes `console`/`document`/`json`, and it runs **in the browser on preview** (not a render/publish
gate). WCAG AA = 4.5:1 text; red-green CVD ~8% of men (X-linked). **Could NOT verify 1.10-specific
axe changes** — the GitHub changelog is off-scope for this session's proxy — so the slide/notes only
say 1.10 "polishes the on-page report"; **verify the deeper revealjs/dashboard axe report against the
actual workshop Quarto build before promising a live demo.** (New reference `colorblind-safe-palettes.md`
already carried the palette rationale.)

### Revisit HTML colours for WCAG AA contrast (axe-driven) — 2026-07-22

Prompted from a screenshot of the Day-1 lab: audited the site's colours against WCAG AA with
**axe-core**. Ran it headless (injected `axe-core` 4.10.3 via Playwright over a local HTTP server)
because Quarto's built-in `axe:` feature pulls axe-core from a **CDN the sandbox proxy blocks** (the
proxy scopes GitHub/CDN egress; skypack import → 405). Same engine, same DOM, same results.

Root causes were all **brand teals used as text/where they're too light** — fixed in
`theme-html.scss` (+ one `_brand.yml` value), keeping brand Sass vars, not disturbing the palette:

- **Navbar** — `$primary` (#4C979F) bar under near-white text = **3.33:1**. Darkened *only the bar* to
  `$teal-dark` = `darken($primary,15%)` = **#33666B** (~5.6:1); keeps the teal identity, doesn't
  recolour buttons/accents.
- **Captions + all margin content** (figure/table captions, the whole `.column-margin` incl. the
  per-species counts kable) — Bootstrap maps `$secondary` (teal-light #A6CBCF) onto muted-text roles =
  **1.74:1**. Overrode to `$teal-dark`. Margin figure captions needed the descendant selector
  `.column-margin figcaption` to out-specify Quarto's rule.
- **"Goal:" / "Citations" blockquotes** — teal-light **1.74:1**. The existing `blockquote` override
  didn't win: Quarto tags these `<blockquote class="blockquote">` and Bootstrap's `.blockquote` class
  out-specifies a bare element. Added `.blockquote` to the override.
- **Links** (content, cross-refs `@fig`/`@tbl`/`@eq`, citations, TOC, references) — two problems:
  (1) the brand's `typography.link.color` (link-teal) **never reaches `--bs-link-color`** under Quarto
  1.9.38 — it stays the Quarto default **#2a76dd (4.43:1, fails AA)**; (2) a white-tuned teal drops to
  **4.28:1** once a link wraps inline `code` (grey code bg). Set `$link-color: #33666B` in a new
  `scss:defaults` block (passes on white 6.4, inline-code 5.8, code cell 5.5) and updated the
  `_brand.yml` `link-teal` palette entry to #33666B so the file stays the source of truth.

**Verified 0 real violations** across every HTML page (`index`, `setup`, both lab indexes,
`penguins-report`, Day-2 `projects` index). `_brand.yml` still parses non-empty under `LC_ALL=C`
(ASCII-clean). Navbar fit-checked with a screenshot.

**Residual axe flags — not real / left as-is:**
- *Callout collapse toggles + FontAwesome callout icons* — reported with **empty fg/bg** (axe can't
  resolve the callout header's semi-transparent background). A direct computed-style probe shows the
  icons are body-ink `#222` on a light tint (~13:1) — **false positives**.
- *`.at` syntax token* (`#657422`) on the grey code-cell bg (`#eceef1`) = **4.43:1** — the `arrow`
  highlight theme is tuned for white; `brand.md § 4` says don't fight highlight colours via the
  palette. Left as-is (would need a white code-cell bg to fix — a bigger visual call).

**Potential Quarto issues to report** (flagged for cderv; verify against 1.10.x first — 1.10.16 is out
and I couldn't install it here, the release download is off-scope for this session's proxy):
1. **`typography.link.color` (brand) doesn't reach HTML `$link-color`** under 1.9.38 — links render the
   default #2a76dd, not the brand link colour. Highest-value; may already be fixed in 1.10.
2. **Default `arrow` highlight tokens are sub-AA on the default code-cell background** (`.at` = 4.43 on
   #eceef1) — a shipped-theme contrast gap, not brand-specific.
3. **Quarto's own `axe:` feature emits false-positive contrast violations** on callout toggles / icons
   (semi-transparent header bg → axe can't resolve it) — more axe-core than Quarto, but Quarto's
   integration surfaces it.

### Fix dark syntax-highlight leaking into light mode + soften venue-presuming wording — 2026-07-21

Spotted from a screenshot: the command word in shell blocks (e.g. `quarto` in `quarto check` on the
Setup page) rendered **bold cyan on white**. Diagnosed via computed styles (Chromium): it's the
**dark "alternate" highlight sheet leaking into light mode**, not the brand and not tokenization.
Using `brand` makes Quarto ship a dark highlight sheet even on this light-only site
(quarto-cli **#13450**); its rules leak for token classes the light (arrow) theme leaves colorless —
exactly `.ex` (external command) and `.bu` (builtin), which arrow-light never colors while arrow-dark
does (quarto-cli **#14299**). Fixed with a scoped override in `theme-html.scss`
(`code span.ex, code span.bu { color: inherit; font-weight: inherit; }`) — verified back to plain
body ink (`#003B4F`, normal weight). Slides are unaffected (revealjs ships only the single light
sheet). A subagent searched upstream (no exact duplicate; best filed as a repro on #13450) and drafted
a full MRE-backed issue: `.claude/archive/issues/2026-07-21-quarto-dark-highlight-leak.md` (not filed —
human to decide comment-on-#13450 vs new). Highlighting **cannot** be brand-themed (confirmed via
deepwiki): `_brand.yml` only reaches `monospace-block.background-color`; token colors come from KDE
`.theme` files via `highlight-style`.

**Doc-audit sync** (capturing the session's learnings forward, not just in this record): added
**`rules/brand.md § 4`** (the highlight leak + "highlighting isn't brand-themed" + the
`theme-html.scss` fix), widened that rule's `paths:` to also surface on `theme-html.scss`/`theme.scss`
edits, and updated the `CLAUDE.md` brand one-liner. Added a portable **distribution note** to
`multi-day-workshop-scaffold.md § 4` (`use_course` + `.gitattributes export-ignore` and its
clone/web limit) and a §5 cross-ref to the highlight caveats. The venue-presuming / over-certain
wording principle stays enforced via `workshop-reviewer-language` (no house-style duplication needed).

Also a small **wording pass** (`837760e`): softened venue-presuming / over-certain phrasing —
`setup.qmd`'s "do it at home, not on conference Wi-Fi" → a neutral "before you arrive" (the venue is a
well-connected university); the font pre-warm note now rests on caching, not a predicted slow network;
the Day-2 publish note drops "can't build synchronously anyway". Added an **over-certain /
venue-presuming claims** check to `workshop-reviewer-language` so the pattern is caught in review.
Added a **pak** install option alongside `install.packages()` in the no-renv path (`c2e7b3a`).

### No companion package + setup.qmd clarity pass + `_brand.yml` locale fix — 2026-07-21

Decided **against** a tuto-style r-universe companion package for RaukR (`the tracker`, deferred with
a scoping plan `.claude/plans/2026-07-21-companion-package-scoping.md`): the tuto's wins (binary-deps
auto-pull, scratch-folder starters) are muted here — 8 small P3M packages, labs authored in-place, and
content destined for the NBIS site. Instead, sharpened the **`use_course()`** path in `setup.qmd`
(a "Setup at a glance" orientation + a "what it does" walk verified against usethis v3.2.1 source).

Then ran a **`student-participant` agent** over `setup.qmd`
(`review-2026-07-21-setup-walkthrough.md`). It surfaced a genuine content bug: the Day-1 Typst
pre-warm (`sample-typst.qmd`) failed under a **C/POSIX locale** because **`_brand.yml` had non-ASCII
chars** (middle-dot in the brand name, em-dashes/§ in comments) that `read_brand_yml()` can't parse
there — emptying the palette so `pal("teal_lighter")` passed a raw string to `gt`. This is the same
locale gotcha documented in the tuto repo (`sandbox-setup.md` / `preparatifs.qmd`); their French
content forced a documented locale note, but our English content let us fix it at the source —
**`_brand.yml` is now ASCII-only** (verified `teal_lighter → #D1E5E6` under `LC_ALL=C`, clean render
under POSIX, freeze regenerated). Also fixed two `setup.qmd` doc errors it caught: a
`quarto::quarto_version()` call for a package we don't install (dropped — `quarto check` covers it),
and a mismatched `quarto check` failure quote. Commit `a72e2b8`.

### `.gitattributes` export-ignore — keep dev scaffold out of the `use_course()` ZIP — 2026-07-21

Christophe flagged that `use_course()` would dump all of `.claude/` into every participant's folder.
Verified against usethis v3.2.1 source (`R/course.R`): `use_course()` downloads
`github.com/<repo>/zipball/HEAD` (git-archive), and `tidy_unzip()`'s strip list is only
`.Rproj.user/.Rhistory/.RData/.git/__MACOSX/.DS_Store` — **`.claude/` is not stripped**, so it shipped.
Fix: added **`.gitattributes`** marking `.claude`, `.vscode`, `_publish.yml`, and itself `export-ignore`.
`git archive` (which powers the zipball) honours `export-ignore`, so those are stripped from the served
ZIP + "Download ZIP" button while staying versioned. Proved end-to-end with a plain `git archive HEAD`
(no flags = GitHub's exact machinery): the three are absent, all content (slides/labs/`renv.lock`/
`_brand.yml`/`_extensions`/`justfile`) present. **Caveat:** affects archives only, not `git clone` — the
setup.qmd clone path still delivers `.claude/`, but `use_course()` (the recommended path) is now clean.
Part of the cleanup-before-public work (strand `the tracker`).

### Lab presentation panel → applied: fontawesome icons + callout thinning + use_course — 2026-07-21

Christophe questioned whether our callout-heavy lab format is right. Ran a **5-lens panel** (cognitive /
participant / technique / design + a distribution survey) comparing NBIS-2025/2026 vs ours (reports
`review-2026-07-21-labformat-*` + `-materials-distribution`; a fontawesome-aware `design-bis`). **Unanimous:
keep the callout/"Challenge" spine — NBIS's 590-760-line prose buries the tasks (its Tasks box sits at
line 592/759); ours is idiomatic and *more* portable.** Christophe flagged that fontawesome IS committed
in the NBIS tree — verified (FA Free 6.5.2), which dissolved the "avoid `{{< fa >}}`" stance. Decision doc:
`.claude/archive/plans/2026-07-21-lab-ux-decisions.md`.

Applied ("yes go"): **vendored `quarto-ext/fontawesome`** into `_extensions/`; re-skinned **both** labs
with a verified 4-glyph icon scheme (Tasks `clipboard-list`; "You should see" → light `appearance="simple"`
+ `circle-check` — fixes the two-solid-blue-boxes-kill-color-meaning defect; Hint `lightbulb`;
**Troubleshooting → real `## H2`** so it enters the TOC, wrapping a collapsed tip + `wrench`); de-boxed the
Day-2 top double-callout; rescued inverted-emphasis lines; documented the scheme in `project-context.md`.
**`setup.qmd`** now leads with `usethis::use_course("cderv/raukr-2026-quarto")` (git clone demoted) —
Jenny-Bryan-canonical, no auth. Both labs re-rendered, icons verified in HTML. Upstream integration =
**content PR, not git subtree** (our content spreads across their tree + a net-new Day-2 deck). Deferred
(strands): download buttons (blocked on repo-public `the tracker`), the sync-script, solution-timing.

### Applied the 6 lab-copy fixes from the live /run-labs — 2026-07-21

On go-ahead, applied all six (strand `the tracker`, closed). Day 2: reworked the Scope `renv::restore()`
line to "done Setup? you're ready; else `install.packages(...)`" (kills the renv-from-`starter/` error),
turned the Task-4 index-link step into an observation ("`index.qmd` **already** links…"), and dropped
the redundant `theme_brand_ggplot2()` mention from "You should see" (kept it in Troubleshooting). Day 1:
same Scope rework, neutralized the starter-specific Citations wording (Tasks 2 & 4 → "your document"),
and added an inline `unknown font family` heads-up at Task 6 (pointing to the Troubleshooting box that
covers it). Both labs re-rendered (exit 0); `_freeze/` refreshed.

### First live `/run-labs all` — both labs run zero-blocker; 6 copy findings — 2026-07-21

Ran the harness for real (student-participant agents, isolated worktrees, HEAD `69b5e9a`). **Both labs
completed end-to-end with ZERO blockers** and produced correct artifacts: Day-1 → `my-report.html` +
a branded Typst `my-report.pdf`; Day-2 → a `_site/` matching the solution (diff clean; only divergences
were the *intended* Ship-it steps the solution omits). Validated three harness residuals live: the
**Day-1 no-`starter/` (authored-from-scratch) path works**, **friction reports archive correctly**
(`review-2026-07-21-labrun-{quarto,quarto-projects}.md`), and **worktree isolation kept all render
churn out of the working tree**. Reports committed.

Six real (non-blocking) copy findings → strand `br-9…` (lab-copy polish). Sharpest: the Day-2 Scope
`renv::restore()` line still misleads — `starter/` has no renv project, so a literal run errors "no
package called renv"; my earlier alignment edit fixed the package *naming* but not this. Not auto-fixed
(per `/run-labs` triage discipline — recommend + file, await go-ahead).

### Lab-scope alignment + lab-runner harness (student-participant agent + /run-labs) — 2026-07-21

**Alignment:** the two lab Scope callouts (`labs/quarto/index.qmd:16`, `labs/quarto-projects/index.qmd:27`)
named only the code packages and leaned on "run `renv::restore()` once"; added a note that restore also
installs the `knitr`/`rmarkdown` engine + a pointer to the **Setup page** and its `quarto check`. Dropped
the stale "`pak` is not used here" aside. Both labs re-rendered (exit 0); `_freeze/` refreshed.

**Harness (strand `the tracker`):** built the runner the prototype proved out —
- `.claude/agents/student-participant.md` — the DOING counterpart to the reviewer panel: a
  project-novice persona, hard rules (follow only the lab page; forbidden solution/slides/web; run
  every render for real; log tagged friction), writes a dated friction report.
- `.claude/scripts/lab-run.sh` — `setup`/`diff`/`clean`. Uses a **git worktree** (real checkout: full
  structure + committed `_freeze/` + `solution/` to diff, isolated churn) and **pre-installs the
  content packages into the default R library** — the fix for the prototype's step-zero failure
  (renders from `starter/` run with renv INACTIVE, so they need the packages in the default lib, which
  the sandbox lacks; a real participant has them globally). Smoke-tested: from the worktree's
  `starter/`, `gt`/`dplyr`/`rmarkdown` all resolve.
- `.claude/commands/run-labs.md` — orchestration mirroring `/start-workshop`: isolate → student does
  the lab → diff vs solution → triage (separate real findings from harness artifacts) → clean → archive.

### Past-content sweep: raukr-2025 back-check + setup-page harvest → setup.qmd +`quarto check` — 2026-07-21

Cloned NBIS 2025+2026 and all five cderv Quarto repos; two background agents surveyed them.
**(1) Teaching back-check:** NBIS-2026 ≈ 2025 (near-verbatim; nothing dropped) — the existing
2026-vs-ours comparison already covers 2025, and **Parameters** stays our one gap (`the tracker`).
Recorded in `prior-art-inventory.md` § *raukr-2025 back-check*. **(2) Setup-page harvest:** the
premise "we don't have a setup page" was **wrong** — `setup.qmd` exists and is the *strongest* of any
page reviewed (it already names `knitr`+`rmarkdown` explicitly, which no NBIS-2025/2026 or cderv page
does, and pre-warms Typst fonts). The prototype's step-zero failure was an isolation artifact (its
temp copy never saw the page). Added the one genuinely missing piece: **`quarto check`** as the
primary readiness step in `setup.qmd` (renders a knitr test doc → catches the exact `no package
called 'rmarkdown'` failure). Strand `the tracker` retitled/updated; residual = point the lab Scope
callouts at the Setup page + drive the new Day-1 checkpoint through it.

### Verified slot times → +90 min; adopt "Option A" (extra → hands-on + Day-1 setup) — 2026-07-21

Christophe spotted longer slots on the program. **Verified against the authoritative source:** the
NBIS schedule isn't hardcoded — `home_schedule.qmd` pulls it live from a public Google Sheet
(`…/1Tu0gQd320zSrZzngNXjGpJ3N8IiGMfbKBvAuUHIftiY`, sheet `schedule-vertical`); fetched it as CSV. It
confirms **Day 1 = 90 + 60 (150 min)**, **Day 2 = 90 + 90 (180 min)** — **+90 min** vs our recorded
2×60/day. (Aside: the sheet misspells the presenter as "Christoph".)

Decision **Option A** (recommended over Christophe's floated "1h30 teach / 1h lab", which would
invert our ~2:1 hands-on ratio): pour the extra time into **hands-on + a Day-1 setup checkpoint**,
not lecture. Updated `project-context.md` § Event (verified times + the decision) and reworked
`topic-store.md` § Time budget to **90/60/90/90** — new 10-min **Day-1 setup checkpoint**, hands-on
30 → ~45-50/part, concept+demo held at ~18-20 (beat-lock ceilings STAND, noted in the Day-2
beat-lock). Day-1 Part 2 (Citations→Typst) is the only part that didn't grow — keep it a clean
60-min payoff, pre-load its framing at the end of Part 1.

### Adopt pak — the "pak KO" note was stale; wire sysreqs self-heal into the hook — 2026-07-21

Empirically retested pak in the sandbox and it **works**: `pak::pkg_install("praise")` fetched
metadata + a P3M binary through the proxy cleanly, so the long-standing *"pak's bundled libcurl
ignores `CURL_CA_BUNDLE`"* claim **no longer reproduces** (pak 0.11.0). Two side-findings: the
sandbox runs as **`root` with passwordless `sudo`** (the SessionStart "an administrator can install
these" message = us), and pak's **system-requirements** API is fully live here — `pkg_sysreqs()`,
`sysreqs_check_installed()`, and `sysreqs_fix_installed()`. Ran the last one for real: it executed
`apt-get -y install libnode-dev libcurl4-openssl-dev libuv1-dev pandoc libxml2-dev` and the recheck
shows all four previously-missing libs now installed.

Adapted the repo to use pak (renv.lock stays the pinning source of truth — pak's value here is
sysreqs + a working installer, not replacing renv):

- **Corrected the stale guidance** in `CLAUDE.md`, `references/project-context.md`,
  `references/sandbox-setup.md` (the ⚠️ warning → ✅, + new **§ 2.1 System requirements via pak**),
  `references/topic-store.md` (dropped the "(`pak` KO)" parenthetical). Left the
  `review-2026-07-07-build-gap.md` "(pak KO)" untouched — immutable review snapshot, accurate for
  its date.
- **Hook self-heal:** `session-start.sh` gains **step 5** — installs pak (P3M binary) and runs
  `pak::sysreqs_fix_installed()`, so a fresh sandbox auto-installs the -dev libs + pandoc that
  *source* installs need. renv's binary restore (step 4) still needs none; the step is non-fatal and
  doesn't touch the pinning path. `bash -n` clean.

Why it matters for the student/teacher-agent plan: removes the "source installs may fail" caveat —
a lab-running agent that installs anything off the binary path now gets a clean auto-fix instead of a
cryptic compile error.

### NBIS coverage comparison + Parameters gap surfaced — 2026-07-21

Fresh clone-and-diff of `NBISweden/raukr-2026`@`main` against our current built material (Christophe's
ask: "how do we compare vs what they cover"). Wrote the dated snapshot to `prior-art-inventory.md`
§ *NBIS vs ours — coverage comparison (2026-07-21)*: shape (their one-arc lecture vs our four ~1h
parts), what each side covers that the other doesn't, and the shared-but-modernized set. Confirmed
their dataset is still `iris` + `%>%`, RStudio-first. **Upstream is static since 2026-07-03** (the organizer
Francis's June–July burst, incl. the 07-01 "Added typst" commit; nothing in the last 17 days) — our
07-06 audit still current.

**Surfaced gap:** Parameters is the only topic NBIS teaches as a full hands-on (`labs/quarto:471-599`)
that we dropped to **zero** — planned as a Day-2 MENTION in `topic-store.md` but never built.
Christophe's lean: add as a **lab exercise, likely Day 1**, not the Day-2 project lab. Filed study
strand **braid `the tracker`** (placement, CLI-override tension, iris→penguins re-skin) — not built
this session, deliberately deferred to a study pass.

### Fixverify cycle — panel verification of the 2026-07-20 fix batch + residue fixes — 2026-07-21

Pushed the session branch `claude/code-review-sync-h6uj17` (the remote had been deleted; local held
all the work) so cderv can preview and push feedback. Then ran the four-reviewer panel as a scoped
**verification pass** (tag `fixverify`) on the delta since the last panel (703e19d fix batch +
356e840 doc audit). **0 P0 anywhere; every 2026-07-20 fix independently confirmed correct as
landed** — technique verified the braced-inline migration end-to-end in built HTML with an
empirical escape-semantics matrix, full render exit 0, `_freeze/` byte-clean, 9/9 changed slides
fit. Reports `review-2026-07-21-fixverify-*.md`. Applied the recommended set on go-ahead:

- **P1 · "(the sane default)" residue** (3 reviewers) — the `#freeze` YAML comment still asserted
  the "default" claim the 2026-07-20 P1 fix removed from the prose one line below. Dropped the
  parenthetical (`slides/quarto-projects/index.qmd:285`); presenter note "the sane default" → "the
  sane setting" (:332).
- **P1 · "vs" → "versus"** (`labs/quarto-projects/index.qmd:91`) — house convention, the repo's
  only drift.
- **P2 · CI gloss placement** (all 4 reviewers) — moved to CI's first on-slide use (`#freeze`
  bullet), removed from `#freeze-workflow`. The full gloss overflowed the already-tight slide
  (751/720); recovered by shortening to "*(the automated build)*" + "that document's" → "its".
  Fit-check 720/720.
- **P2 · `freeze: true` nickname** unified to "the CI mode" (deck note, matching the lab hint).
- **P2 · "with within-page" tongue-twister** → em-dash list on the Day-2 outcomes slide.
- **P2 · `slides.md` §5 caveat** — the single-brace-executes rule assumes an executable cell
  exists; in a markdown-engine (no-cell) doc the braced form renders literally (technique proved
  it empirically).

Deferred: long lab sentence split (subjective); lab's first bare "CI" (:24, never blocks);
pre-existing "behaviour" ×2 in `quarto-doc-sources.md`. Both touched files re-rendered; changed
slides fit-checked 720/720; `_freeze/` staged. Side note banked: `gt`'s random HTML id makes
"render leaves `git status` clean" flaky by design — two reviewer renders churned only that id
(freeze hash unchanged); restored rather than committed.

### Doc/context audit after the long session (on `main`) — 2026-07-20

End-of-session sweep of all `.claude/` docs/rules/references/skills/agents against the session's
decisions (audit agent, read-only). Fixed 1 🔴 cluster + 6 🟠 + a 🟡 tidy:
- **🔴 `topic-store.md` still told the author to write "capstone" into participant-facing copy**
  (running-order rule 6 `:394`, budget-table content `:324`, tie-in `:401`) — contradicted the
  `project-context.md` guard, a regression seed. Reworded to "team project / its project"; aligned
  the two phase labels (`:315`/`:324`) and the wet-lab tie-in → "a collaborator who won't open R".
- **🟠 `project-context.md` § Content patterns** absorbed three durable lessons that had lived only in
  the language agent / `slides.md`: (a) **presenter logistics stay in `::: notes`** (room-killer
  lesson, Slides list); (b) **braced `` `{r} ` `` is the inline idiom** + double-brace escape, with the
  `sample-typst.qmd` exception (Both list); (c) **keep it reusable** beyond bioinformatics (generic
  on-slide, domain flavor in notes).
- **🟠 `topic-store.md`** legacy `` `r ` `` inline-form guidance (`:81`, `:218`) → braced `` `{r} ` ``.
- **🟠 `quarto-doc-sources.md`** — flagged Context7 can be disconnected (it was, all session); lead
  with quarto.org as the authoritative fallback + DeepWiki, matching the technique agent.
- **🟠 `sandbox-setup.md`** — documented the `sample-typst.qmd` `gt` `check_named_colors` live-render
  failure masked by committed `_freeze/` (can't re-freeze it in-sandbox).
Skipped (🟡): the vendored `quarto-authoring` skill (closed via project-context instead); the
`bioinformaticians` persona line in pedagogue/beginner (accurate, not domain-locking the material).
**In sync, no change:** multi-day rule + scaffold registration, all four adapted agents, `slides.md §5`,
the `project-context.md` capstone guard, no hardcoded slide counts.

### Review cycle 2026-07-20 — triage + fixes (0 P0; small P1 set) — 2026-07-20

Ran the full four-reviewer panel (commit 6a910a5); reports in `.claude/archive/reviews/review-2026-07-20-*.md`.
**No P0 anywhere** — every reviewer green, and all this session's prior fixes independently verified
clean. The new agent checks (multi-day sweep, jargon/reusability, overflow, false-callback, doc
fallbacks) all fired. Applied the recommended batch (all 4 P1 + the cheap cross-reviewer P2 clusters):

- **P1 · inline-code display bug** (beginner) — `slides/quarto/index.qmd` `#anatomy`/`#inline-code`
  showed `knitr::inline_expr(...)` literally instead of the inline expression. Fixed **and** migrated
  to the **portable braced form** `` `{r} nrow(penguins)` `` (Christophe's call; verified vs quarto.org
  — it "works across all three engines", preferred over legacy `` `r …` ``). Migrated the labs too
  (`starter.qmd`, `penguins-report.qmd`). **Gotcha discovered:** the braced form executes *even inside
  a display code block / double-backtick span* — to show it literally you need the **double-brace**
  escape `` `{{r}} …` `` (banked in `slides.md` §5). `sample-typst.qmd` reverted (its `_freeze/` can't
  refresh in-sandbox — a `gt` `check_named_colors` error on live execution, unrelated to the edit).
- **P1 · `freeze: auto` "the default"** (technique) — it isn't (Quarto default = no freeze). Reworded
  to "the sane setting to adopt" (`slides/quarto-projects/index.qmd:288`).
- **P1 · reusability** (language) — "wet-lab collaborator" → "a collaborator who won't open R" (`:417`);
  "for a research audience" trimmed from a Day-1 outcome (`slides/quarto/index.qmd:40`). *(Pedagogue
  had defended the latter as the artifact's reader; went with the trim — cleaner + reusable.)*
- **P2 clusters** — DevOps jargon: CI glossed on first slide appearance (`#freeze-workflow`), "the
  runner" → "in CI" (deck + lab), coined "hard-freeze" → "CI mode"; Day-2 outcome "cross-references"
  → "within-page cross-references"; lab `_brand.yml` flow-mapping → block form (house idiom); dead
  example anchor `analysis.qmd#sec-model` → page link; `wifi` → `Wi-Fi` (`setup.qmd`).
- **Deferred** (presenter-judgment P2s, non-blocking): Figures beat-sheet density, two note-less Day-1
  slides, Part-1 pacing length, `#citations` density, "think in deltas" title.

All touched executable `.qmd` re-rendered + fit-checked 720/720; `_freeze/` staged.

### Adapt the other 3 reviewers to this session's rules — 2026-07-20

Followed the language-reviewer update by auditing pedagogue / technique / beginner against the rules
built this session. Additive edits:
- **pedagogue** — added a **Multi-day sequencing** check (item 10) pointing at
  `.claude/rules/multi-day-sequencing.md`: later days read as follow-ups (bridge, recap structural
  slides, widen-not-re-introduce), every "you saw this yesterday" callback is true (repeat may
  originate on the earlier day → narrow there), teasers paid off, and labs = beneficial-rep-not-
  duplication. It had *zero* multi-day coverage before.
- **technique** — Context7 has been disconnected all session, so codified the verification fallback:
  Context7 *if available* → **quarto.org** (docs + `llms.txt`) via WebFetch (source of truth) →
  **Deepwiki** (`quarto-dev/quarto-web`/`quarto`) for "how is X actually used". Added `WebFetch` +
  `mcp__Deepwiki__ask_question` to its tools, and a **slide-overflow** check (per `slides.md` /
  `slide-shot.mjs`, incl. horizontal-clip + fragment/aside collision).
- **beginner** — added a **false-callback** check (a Day-2 "as on Day 1" for something Day 1 never
  taught makes a returning participant doubt their memory) + event-jargon example ("team project" not
  "capstone").

### Adapt language reviewer with this session's register lessons — 2026-07-20

Before running the language reviewer, checked it against this session's conventions. It already
inherits the `project-context.md` guard (so it flags "capstone" and knows "team project"), but didn't
encode two lessons. Added to `workshop-reviewer-language.md`:
- **Jargon & reusability check** — flag unglossed terms the cohort may not know *and* domain-locked
  framing that hurts reuse ("bioinformatics compute" → "compute"); fix-pattern = generic on-slide,
  domain example as a `::: notes` localization cue. Plus a domain-jargon grep hint.
- **Presenter logistics leaking onto a slide** — flag format/classroom rationale in a slide body
  (the "room-killer" case); state format positively on-slide, move the *why* to notes.
- Softened the hardcoded "bioinformaticians" register line to note the reuse-beyond-bioinformatics goal.

### Drop "capstone" jargon → "team project" (participant-facing) — 2026-07-20

Christophe questioned "everything your **capstone** needs" — "capstone" is **US-academic jargon** the
RaukR international life-science cohort may not use. It's the RaukR end-of-school **team project**
(project-context.md:34 already calls it "team project (capstone)" and says gesture toward "your
project"). Swapped all **6** participant-facing uses to "team project" / "your project":
- Day-2 deck: opening note ("your team project's site"), relevance note ("the team project is many
  pages"), Part-2 section note ("how your team ships its project"), wrap-up ("everything your **team
  project** needs").
- Day-1 deck: "your **team-project** write-up".
- Day-1 lab: "manuscript / **team-project** path".
Added a guard in `project-context.md`: participant-facing term is "team project" / "your project", keep
"capstone" to internal notes only. Re-rendered both decks + Day-1 lab; visible slides (`#wrap-up`,
`#report-to-article`) fit-checked 720/720.

### Publishing slide — move classroom-logistics rationale off the slide — 2026-07-20

Christophe flagged the `#publishing` watch-me callout for narrating *teacher logistics* to the room:
"A live `quarto publish gh-pages` for 40 laptops (GitHub auth, a repo, conference Wi-Fi) is a
**room-killer**…". Surfacing the presenter's format-choice reasoning on-slide reads as an apology and
isn't participant learning content. Reframed the callout to state the format **positively** and keep
only the genuine technical fact: "You do the `render` + `output-dir` half; I'll **show** the publish
step on a ready-made repo — it needs a GitHub login and builds **asynchronously** (push, then wait for
the green check)." Moved the 40-laptops / Wi-Fi / room-killer rationale into `::: notes` (presenter
decides privately). Principle: *format-choice logistics belong in speaker notes, not the slide body.*
Fit-check 720/720.

### Split freeze into concept + workflow slides (freeze: true, render-on-demand) — 2026-07-20

Christophe wanted a dedicated slide for the **real-world freeze workflow** — the one used on
**quarto.org**: `freeze: true` + re-render individual pages on demand (`quarto render <file>`), noting
that `freeze: auto` would let the build itself compute a not-yet-frozen page. Verified end-to-end
(Context7 still disconnected → used quarto.org + the quarto-web repo + Deepwiki):
- `freeze: true` = "never re-render during project render"; single/incremental renders **always
  execute** — so you refresh a frozen page by rendering that file directly. (quarto.org
  `docs/projects/code-execution.html`.)
- quarto.org itself runs **`freeze: true`** — confirmed in `quarto-dev/quarto-web/_quarto.yml`; via
  Deepwiki, contributors `quarto render <file>` locally and commit `_freeze/`, enforced by a
  `check-freeze.sh` git hook (the *same* discipline this workshop repo uses); CI publishes with
  `render: false`. A `production` profile can set `freeze: false` to force full re-execution.

Split slide 12 into two: **#freeze** keeps the concept (cache-vs-freeze + the `auto` default, now
ending in a teaser); new **#freeze-workflow** ("you hold the trigger") shows `freeze: true`, the
`quarto render <file>` refresh, the edit→render→commit loop, and the `auto` contrast — with the
quarto.org anchor on-slide. Deck 18 → 19 slides. Both fit-checked 720/720 with `--all-fragments`.

### Freeze slide — generic motivation + sharpened cache-vs-freeze — 2026-07-20

Christophe: (a) drop the **bioinformatics** framing on the freeze slide (`#freeze`) — prefer generic
"Compute can be slow" for **reuse** beyond a life-science audience; (b) sharpen the cache-vs-freeze
contrast along three axes he named. Verified all three vs quarto.org (`docs/projects/code-execution.html`
+ `docs/computations/caching.html`; Context7 MCP is disconnected, quarto.org is the authority) — all
**confirmed**:
1. `cache` is the **computation engine's**, not Quarto's — Quarto defers to *knitr* (R) / *Jupyter
   Cache*.
2. `freeze` is **Quarto's own** mechanism, *not* about compute — it controls *whether/when* a document
   re-executes.
3. `freeze` is **project-only** (a single-file render always executes); `cache` works in a **single
   document** too.

Changes on `#freeze`:
- Motivation genericized: "Bioinformatics compute is slow … 20-minute alignment" → "Compute can be
  slow … 20-minute model fit"; the domain example moved to a `::: notes` **localization cue** ("a
  sequence alignment, a long MCMC, a big simulation") so the presenter can still hit a bio note live.
- Rewrote the two contrast bullets to the engine-vs-Quarto / single-doc-vs-project-only axis; trimmed
  the redundant trailing paragraph; moved the CI gloss + `freeze: true` refresh recipe to notes.
- Fit was tight — the richer bullets overflowed (751); recovered the line by moving the two
  parentheticals to notes. Re-rendered, fit-check 720/720 with `--all-fragments`.

### Cross-day LAB dedup sweep — reps vs duplication — 2026-07-20

Christophe: sweep the **labs** too, but with a different lens — in a lab, *re-practicing* a skill is
beneficial, so hunt **duplication** (same task, same outcome, no new dimension), not repetition.
Ran a lab-lens agent over both labs. **Verdict: no P0 duplication** — the Day-2 lab ships the
penguins figure/table/margin content pre-authored in `starter/`, so every participant action lands
on the project/website/ship layer Day 1 never touched. `_brand.yml` is a textbook beneficial rep
(actually *first authored* on Day 2, at project scope, dimension stated 3×). One P1 tightened:
- **Website Challenge stretch cross-ref** (`labs/quarto-projects/index.qmd:87`): the within-page
  `@tbl-means` rep read as "do a cross-ref again" because its new dimension (within-page resolves,
  cross-page doesn't) lived only in the *paired* link edit. Reframed the step as an explicit
  **within-page vs across-page** contrast ("resolves *because both live on one page* … across pages
  there is no auto-numbering — that's a *book* feature"). Re-rendered lab, staged `_freeze/`.

Method banked: `multi-day-sequencing.md` **§9** (labs hunt duplication not repetition; same
task+outcome = cut, same skill+new scale = keep; make the added dimension explicit on the step;
ship earlier-day content pre-authored). Scaffold §3 + checklist updated with the lab lens.

### Cross-day repeat sweep + codified the method — 2026-07-20

After the brand-slide fix, Christophe asked for a **full Day-1-vs-Day-2 repeat sweep** and to bank
the method. Ran a research agent holding both decks + the sequencing rule; classified every Day-2
content slide repeat/partial/clean. **Verdict: repetition is not systemic** — the heavy-overlap
slides (`#brand`, `#freeze`, `#xrefs`) are already proper widens with matched teasers, and the
framing slides (`## Learning Outcomes`, `## How today works`) are already trimmed to recaps. Two
P1s found and fixed:
- **`#xrefs` false callback:** "`@fig-`, `@tbl-`, `@sec-`, `@eq-` … exactly as on Day 1" — but Day 1
  only teaches `@fig-`/`@tbl-`/`@eq-` (`slides/quarto/index.qmd:186,217`); `@sec-` is never taught.
  Dropped `@sec-` from the callback and introduced it as new ("Section headings work the same way
  with `@sec-`"), where it now pays off in the `analysis.qmd#sec-model` example below.
- **`#metadata` un-callbacked re-teach:** "set defaults wide, override narrow" is Day-1's
  header-vs-cell precedence (`#execution`, line 398). Added a callback intro ("Yesterday a header set
  the defaults and a cell overrode them — `_metadata.yml` is that same idea, one scope wider"), tied
  the precedence line back ("Same narrow-wins rule, now across files"), and added the `::: notes`
  don't-re-teach cue the slide previously lacked.
Both re-rendered + fit-checked 720/720.

**Method codified** so the next multi-day build inherits it:
- `multi-day-sequencing.md` gained **§7** (the repeat often originates on the *earlier* day — narrow
  the setup, don't contort the later slide) and **§8** (run a discrete cross-day dedup sweep, both
  directions, with a fresh agent holding both decks).
- `multi-day-workshop-scaffold.md` §3 gained the two traps and §7 checklist gained a "cross-day dedup
  sweep" step.

### `_brand.yml` slide reframed to project scope — de-duplicated vs Day 1 — 2026-07-20

Christophe flagged that the Day-2 `#brand` slide was **repeating Day 1** ("HTML, revealjs, Typst
read `_brand.yml` natively" + the R-side `theme_brand_ggplot2()` block + the "plot won't inherit"
gotcha are all on Day 1's `slides/quarto/index.qmd:596` brand slide). Directive: **Day 2 must
complement, not repeat.** Ran a research agent (quarto.org/docs/authoring/brand.html + brand-yml
spec + our cloned prior decks; Context7 MCP was disconnected so quarto.org was the authority).

Verified the one genuinely-Day-2 angle — **project scale** — and reframed the whole slide to it:
- Title "One brand → **the whole project**" (was "→ everything").
- Callback intro: "You wrote `_brand.yml` yesterday to brand one **Typst PDF**" → new beat is
  **auto-discovery** at the project root (alongside `_quarto.yml`), no `brand:` line in any page.
- Bullets: every page + deck inherits from one root file · a page added later is branded on render,
  nothing to wire up · per-page **escape hatch** (`brand: false` opts out, `brand: other.yml`
  redirects) — the last is genuinely project-scoped and advanced-audience-appropriate.
- **Dropped** (Day-1-owned, moved to "if asked" notes): the "read natively" bullet, the R-side
  code block, the `theme_brand_*()` plot gotcha.
- Notes carry the precision caveat: "every page/deck" = every *supported-format* output (html,
  revealjs, typst, dashboard) — don't say "every output".
Re-rendered, fit-check 720/720 with `--all-fragments`, no clip.

**Sequencing debt — RESOLVED same session.** Narrowed Day 1's brand slide
(`slides/quarto/index.qmd:596`) so it no longer talks about a project: intro is now "One
`_brand.yml` carries your palette + fonts to the **Typst PDF** you just built — and to the **plots
and tables** inside it" (was "every output — site, slides, and the Typst PDF"). Kept the document
`{.yaml}` block form in sync with Day 2. Added a **speaker-note teaser** ("Tomorrow the *same* file
will brand a whole project") — project language stays off the Day-1 slide body but sets up Day 2's
"you wrote this yesterday" callback as a matched setup→payoff pair (multi-day-sequencing rule #4).
Re-rendered Day 1, fit-check 720/720.

### `_brand.yml` slide — block YAML instead of inline flow-mappings — 2026-07-20

Christophe: prefer YAML block (multiline) syntax over inline `key: { subkey: … }` flow-mappings
**when the slide has room**. On the `#brand` slide the left `_brand.yml` block had vertical
headroom to spare, so expanded `palette: { teal: "#4C979F" }` → `palette:` / `teal: "#4C979F"`
and `base: { family: Albert Sans }` → `base:` / `family: Albert Sans`. Now 10 lines, one value
per line — reads as you'd actually write the file. Re-rendered, fit-check 720/720 with
`--all-fragments`, no clip.

### Websites slide rewrite (4-agent research + review) — 2026-07-20

Christophe flagged the Day-2 "Websites — pages & navigation" slide (`#websites`) as unclear — cramped
intro, and "Each page is a normal `.qmd`:" not informative. Ran a 4-agent parallel pass: a
research/synthesis agent (mined our prior decks — `user2024-tutorial`, `raukr-2025`, `rr-2023`,
`typst-rr-2026` — plus NBIS `labs/quarto-site` and quarto.org docs) and three focused reviewers
(technique / pedagogue / beginner). (Prior-art repos shallow-cloned to the scratchpad; Context7 MCP
was **not** available this session — confirmed the model against quarto.org directly.)

Unanimous, applied:
- **Cut "Each page is a normal `.qmd`:"** — filler for this cohort *and* its colon mis-pointed (it
  sat above the `website:` **config** block, not a page).
- **Intro reframed** to the load-bearing idea + a within-deck callback: "You already set
  `type: website` — that makes the folder a **site**: its pages share one navbar and sidebar. You
  describe that navigation once, and Quarto builds it:" (colon now correctly points at the config).
- **`filename="_quarto.yml"`** added to the `website:` block (was untagged after the `_metadata.yml`
  slide — beginner's real trap; slides rule #4).
- **Accuracy fix:** "real output, not static HTML" → "real R output, not hand-written HTML" (a Quarto
  site *does* deploy as static HTML via `output-dir: _site`; what executes is the source).
- **Repurposed, not just cut:** the right column now leads "Each page renders on its own" — the
  independence fact that primes the **next** slide (`#xrefs`, which depends on per-page rendering).
- Kept navbar + `sidebar: contents: auto` (the "declare, don't enumerate" beat) and the Listings
  aside. Fit-checked with `--all-fragments`.

Reviewer reports were lightweight inline micro-reviews (single slide), returned in-session, not
archived as full `/start-workshop` panel snapshots.

**Follow-up (same session):** on Christophe's call, removed the right-column ggplot. A generic
penguin boxplot demonstrating "pages compute" is off-topic on a *navigation* slide and a Day-1-owned
point; house pacing (`workshop-pacing.md`) also says the live demo carries the payoff (the notes
already render the nav live). Slide is now single-focus and single-column: intro → `_quarto.yml`
`website:` block → `. . .` `contents: auto` payoff → Listings aside. The removed cell was the deck's
only executable output; re-verified the slide's claims against **Context7** (`quarto-dev/quarto-web`,
now restored) — `type: website` + navbar/sidebar, `output-dir: _site` static output, per-page render
all confirmed.

### Day-2 phantom slide fix + follow-up reframing + multi-day sequencing rule — 2026-07-20

Working the Day-2 (`slides/quarto-projects`) deck live with Christophe serving locally off the
`claude/tutorial-branch-setup-couv8q` branch.

- **Phantom empty slide 2 fixed.** The `TODO(logos)` HTML comment sat between the setup chunk and the
  first `##` — any top-level block before the first slide-level heading becomes its own (blank) leading
  slide. Moved the note into the YAML front-matter as a comment. Deck 19 → 18 slides.
- **Reframed Day 2 as a follow-up to Day 1** (same cohort, a day later): trimmed *How today works* to a
  "same shape as yesterday" recap; opened *Learning Outcomes* with a Day-1 bridge; reframed the
  `_brand.yml` slide as "you met this file yesterday for the PDF — same file now does the site + slides"
  (Day 1 already teaches `_brand.yml` fully); picked up Day 1's explicit **freeze** teaser. All four
  slides fit-checked at 1280×720.
- **New path-scoped rule `multi-day-sequencing.md`** (`slides/**`, `labs/**`) captures the "later days
  are follow-ups" logic — widen scope don't re-introduce, recap recurring structure, bridge in the
  opening, pay off teasers in sync, verify callbacks against the earlier deck. Registered in CLAUDE.md.
- **New reference `multi-day-workshop-scaffold.md`** — a portable skeleton + spin-up checklist for the
  next multi-day workshop (directory layout, per-day deck skeleton, build/freeze/renv, brand, the review
  loop). Registered in CLAUDE.md.

### FABLE claim-verifier pass + triage fixes — 2026-07-17

Ran a one-off **Fable** claim-verifier subagent (prompt-only, not archived as a review) against the
content at `5353347`. It extracted ~90 checkable technical claims and verified each against upstream
ground truth — `cderv/quarto-cli` schemas, `cderv/quarto-web` docs, Deepwiki, Context7, R 4.5 NEWS.
**Nothing refuted;** two version/environment caveats and one wording nit surfaced. Applied all three:

- **Quarto floor 1.8 → 1.9** (`_quarto.yml` `quarto-required`, `setup.qmd`, `index.qmd`,
  `slides/quarto/index.qmd`, `labs/quarto/index.qmd`). Reason: Typst margin/article layout (marginalia,
  changelog-1.9 #13879) is what the Day-1 Citations payoff uses — it doesn't exist on the old 1.8 floor.
- **palmerpenguins fallback** dropped from the main `setup.qmd` requirement (the "(noted per exercise)"
  promise was never delivered and the long column names break every `bill_len`-based snippet); moved to
  a collapsed `.callout-warning` carrying a `rename()` shim for anyone truly stuck on R < 4.5.
- **Math-subscript wording** softened in the deck note + lab stretch — "renders as a subscript
  (silently)" → "may render as a subscript (depending on the math renderer)" (mechanism unverifiable
  across MathJax/LaTeX/Typst; the escape advice itself is correct and kept).

Re-rendered the two executable decks under the provisioned toolchain (R 4.6.1, Quarto 1.9.38); both
`_freeze/` entries back in sync.

### Presenter-notes review panel + triage fixes — 2026-07-17

Ran the four-reviewer panel (`/start-workshop`, scope tag `notes`) against the drafted-and-polished
`::: notes` at `99563e1` — the first time any reviewer graded the notes themselves (every prior cycle
saw the pre-notes deck). Reports: `review-2026-07-17-notes-{technique,pedagogue,beginner,language}.md`,
archived in `8e21abd`. **No blocking defect.** Convergent finding across three reviewers: Day-1 Part-2's
two live slides (Citations, Branding) still had no beat-sheet — the last tail of the old pedagogue P1-1.

Applied the recommended triage set (all P0/P1 + correctness-flavoured P2s), notes-and-one-bullet only:

- **Citations + Branding beat-sheets** added on Day-1 Part-2 (Do/Say/Helpers each) — closes the gap
  all three student/teacher lenses flagged; Day-1 note blocks 19→21.
- **Marker P0 (language):** three `Say:` lines that were really stage-instructions re-marked `Frame:`
  ("give the room the map", "the list is deltas…", "foreground the CI story") so a mid-flow glance
  can't read them aloud as gibberish.
- **Callout count (technique, factual):** "Four types" → **five** (added `caution`) in the note *and*
  the on-slide bullet.
- **Day-2 helper cue (beginner):** your-turn-1 Helpers now leads with the `cd starter/` cwd trap (the
  one that strands everyone) instead of link-relativity, and names `solution/` as the fallback.
- **Correctness P2s:** freeze "tell" reframed from per-cell to per-document (matches the cache-vs-freeze
  teaching); publishing note keeps `quarto publish gh-pages` (renders locally) distinct from GitHub
  Actions (no R on runner); `#|`-placement added to the `?@` prefix trap; "where's my PDF?"
  output-location cue added.
- **Language copy batch:** US spelling in spoken quotes (`labelled`/`colour`), `Helpers cue`→`Helpers`,
  verbatim `Say:` lines quoted, one buried Say+Do split, four unmarked blocks given markers.

Deferred (subjective/symmetry, non-blocking): Figures beat-sheet density trim, note-less concept slides,
marker-vocabulary consolidation, "the lead"→"default". Both decks re-rendered (Quarto 1.9.38 + R 4.6.1);
`_freeze/` staged; ledger rows flipped to applied.

### Presenter-notes spoken-script polish + ledger reconciliation — 2026-07-17

Working branch `claude/tutorial-feedback-kxyoh4`. Picked up the open "feedback" thread and found the
substantive item wasn't actually open: the presenter `::: notes` that the 2026-07-12 pedagogue **P1-1**
and language **B1–B3** flagged had been drafted in `4ca2a05` (2026-07-12 15:43) — *after* those reviews'
`88d48cf` baseline — so the reviews graded the pre-notes deck and the ledger's "pending (author)" was
lag, not real work. No reviewer had ever assessed the *drafted* notes, so this was a spoken-script polish
pass (plan `2026-07-17-presenter-notes-polish.md`), notes only — no on-slide content changed.

- **Rewrote the two weakest blocks.** Day-1 *Running & editing* was pure slide-reorg meta (nothing to
  say or do) → a marked **Do** (`quarto preview` live, show the reload) + **Say** beat. Day-1 *Positron*
  buried a screenshot-capture TODO mid-script → Say/Do markers with the capture TODO demoted to a
  parenthetical authoring note.
- **Made the Say/Do marker discipline (B2) consistent** across every note block: Day-1
  *What-you-can-build* / *Layouts* / *Typst* / *How-today-works* and Day-2 *brand* / *cross-refs* /
  *How-today-works* were unmarked stage-directions → now carry **Say / Do / Frame / Pre-flight / Helpers**
  markers so a glance-down can't misread a stage-direction as a line.
- **Plain-languaged the B3 tail:** "shock-absorber" → "trim-first".
- **Re-rendered both decks** (Quarto 1.9.38 + R 4.6.1) for the freeze discipline; staged `_freeze/`.
- **Reconciled the bookkeeping:** the 2026-07-12 pedagogue + language ledger rows flipped
  ⏳ pending → ✅ applied (crediting `4ca2a05` for the draft + this pass for the polish), and a
  2026-07-17 cycle added to `.claude/archive/reviews/README.md`.

### Review-feedback pass — slide reworks, accessibility, lab-logic 7-agent review + fixes — 2026-07-15

Working branch `claude/code-review-feedback-y5fa6q`. Two threads.

- **Day-1 deck reworks** (from cderv's slide-by-slide feedback): split "Callouts & inline code" into
  two one-point slides; added an Article-Layout "Learn more" link on Layouts; reworked "One source →
  many formats" to one line-number-free block showing the multi-format list + per-format map +
  shared top-level options; added a dedicated **Execution** slide (`execute:` defaults vs `#|`
  override) and un-crammed Running & editing; corrected the **visual-editor** claim (built into
  RStudio; in Positron *and* VS Code via the Quarto extension — verified vs quarto.org, twice);
  dropped in a Quarto-docs Positron screenshot as placeholder (credited on-slide) for the image TODO.
- **Accessibility (WCAG AA).** The lab "Goal:" blockquotes rendered teal-light text (~1.7:1) — Quarto
  colours blockquote text from `$secondary`; no `$blockquote-color` var exists (checked vs
  quarto-cli), so `theme-html.scss` overrides the element with `$body-color`/`$primary` (no
  `!important`). Links were `link-teal #79B1B7` (~2.4:1) → darkened to **#3C7C83** (~4.8:1) via the
  brand palette (`typography.link.color` → `$link-color`, the single-source lever confirmed vs
  quarto-web), fixing labs + slides together.
- **Lab-logic review (7-agent panel).** Ran three student personas + three teacher lenses + one
  technique render pass against both cycles to answer: is prez→lab→prez→lab clear; are the exercises
  clear/well-placed; anything unanswered at the lab. Verdict: architecture right, exercises
  exemplary, labs render clean (0 P0). Report: `review-2026-07-15-lab-logic-flow.md`.
- **Fixes applied** (four file-partitioned editing agents, plan
  `2026-07-15-lab-logic-fixes.md`): "How today works" roadmap slide on both decks + follow-along
  stop cue + surfaced break (structure *visibility*); the **Day-2 working-directory /
  nested-`_quarto.yml` trap** (`cd starter/` first, corrected output claim, troubleshooting entry);
  two Day-1 slide under-teaches (broken `@tbl-summary` demo → add `tbl-cap`; margin-layout syntax on
  its slide); Typst Render-button routes + font pre-warm; plus P2 polish (deep-link anchors, stretch
  reword, visible freeze timestamp, fig-alt/refs explanations). All four files re-rendered clean.

### Day-1 deck — Typst diagram, RaukR house type scale, `typst-render` deploy hardening — 2026-07-13

Live-preview review pass on the Day-1 deck (`slides/quarto/index.qmd`).

- **Engine diagram → Typst.** Converted the "How it all works" flowchart from Mermaid to a fletcher
  `{typst}` diagram via `quarto-typst-render` — on-brand teal SVG, crisp/sized, no Chrome. Moved the
  knitr/R-Markdown aside into `::: notes` to declutter. Full recipe + every gotcha (knitr passthrough,
  `//|` options, fletcher 0.5.8 pin, `output-directory`, package vendoring, freeze churn) is in the
  new reference **`typst-render-diagrams.md`**.
- **Type scale → RaukR house.** The deck was on Quarto's **40px** revealjs default — never a
  deliberate choice. Verified against the sources: **NBIS `raukr-2026` house = 27px**, Christophe's own
  `raukr-2025` = 36px. Set `theme.scss` to the house **27px** + heading ramp + code `0.7em` (numbers
  only, not their CC BY-NC-SA SCSS). Fixes overflow on the denser slides **without shrinking content**.
  See `project-context.md` § stack.
- **Deploy hardening.** `typst-render: output-directory: typst-figures` so SVGs publish from a real
  folder, not the gitignored `.quarto/` cache (which 404s online); gitignore `**/typst-figures/`.
  Package vendoring (`package-path: /_typst-packages`, ≈688K, pattern from `tuto-quarto-typst-rr-2026`)
  **recommended** for offline builds — not yet applied.
- **Copy.** Index intro reworded ("have met" → "have used … before"); slide-4 closing line clarified
  ("Start native" → "all from one plain-text `.qmd` you write directly").
- Explored `raukr-2025-quarto` + `tuto-quarto-typst-rr-2026` (throwaway clones) to ground the font
  and diagram decisions — both confirm reduce-the-font and validate fletcher 0.5.8 + vendoring.

### `justfile` — target-based `publish` (GitHub Pages + Posit Connect Cloud) — 2026-07-13

Replaced the single hard-wired `publish: render → quarto publish gh-pages` recipe with a
**target-dispatched** one, ported from `tuto-quarto-typst-rr-2026`: `just publish gh` → GitHub
Pages, `just publish connect` → Posit Connect Cloud. A private `_publish target` recipe does the
dispatch via just's **native conditional** (not a shebang), so it stays a single cross-platform
`quarto publish …` call and honours `.claude/rules/justfile.md`; an unknown target fails with a
helpful `error(...)`. Added `publish-only <target>` for publishing without a rebuild.

- **`gh` works out of the box**; `connect` needs a **one-time interactive** `quarto publish
  posit-connect-cloud` from a real machine first, to create the content and write the reused
  destination into `_publish.yml` (not yet present in this repo — `--no-prompt` can't bootstrap it).
- **No `pretuto` profile this time** (the tuto repo had one; deliberately skipped here).
- Docs synced: `.claude/CLAUDE.md` build line now shows `publish <target>`.

### Whole-arc STATUS-CONFIRMATION pass — all four reviewers (4 reports) — 2026-07-12

Ran the reviewer panel as a **readiness check** over the entire two-day arc (not a build cycle) to
independently confirm the "content-complete and arc-verified" claim, and to give **speaking / presenter
delivery** its first dedicated review — prior cycles audited written copy but never read the `::: notes`
as a spoken script. **All four confirmed ready; 0 P0 across the board.**

- **Reproducibility proven at-machine.** The technique pass ran a full `quarto render` (Quarto 1.9.38 +
  R 4.6.1): **exit 0, all 11 targets** (decks + HTML pages + dashboard + branded Typst PDF), and
  `git status` **clean afterward** — the versioned `_freeze/` is drift-free. This closes the standing
  "would a clean end-to-end render pass today" question. Prior structural fixes (freeze semantics,
  cross-refs book-vs-website) both confirmed still held; open strands (Positron screenshot, logos)
  confirmed to **degrade gracefully** (no 404s, no leaked commented markdown).
- **Two cheap P1s fixed this pass:**
  - **Stale landing-page notice (technique P1-1):** `index.qmd` still declared the site "under
    construction — the pages below are skeletons." False and participant-visible on the live site during
    the session → **removed**.
  - **Missing clone step (beginner P1):** nothing on the participant path told people to `git clone` the
    repo, yet the whole hands-on depends on it (`references.bib`, `apa.csl`, `starter/`, `solution/` all
    live only in the clone). → added a **"Get the materials"** block (clone command + repo URL) to
    `setup.qmd`, ahead of the `renv::restore()` "from the repo root" step.
- **The substantive open finding is a single theme — presenter/spoken notes — left for cderv (authorial).**
  Pedagogue P1-1 and language B1-B3 converge: the `::: notes` cover framing + Your-turn hand-offs but say
  nothing about the **live-demo ("Our turn") beats** that carry the teaching, and there is **no re-entry
  cue after the 1-hour inter-part gap** (each day is two 1h parts, not a continuous 2h). Notes also mix
  "say this" vs "do this" with no marker and carry a little internal-reviewer jargon. Cheap to close (a few
  `::: notes` lines per live-demo slide + a one-line re-entry cue per Part 2), but it needs the presenter's
  own voice, so it's **surfaced, not auto-actioned**. This is the one gap between "content-complete +
  render-verified" (true) and "scripted for a confident live delivery" (not yet). Deferred P2s: writing nit
  (`fig-alt` "vs"→"versus"), Day-1 Part-2 unnamed cut-first beat, setup TODO comment, `→`/`WYSIWYM`
  read-aloud house-calls. Four dated reports in `.claude/archive/reviews/`; dispositions in the ledger.

  **Follow-up (same day):** drafted the presenter notes the pass called for — a **Say / Do / Helpers /
  Timing** convention across the live-demo beats (Day 1: Markdown / Figures / Tables & math / Callouts;
  Day 2: Why-a-project / Websites / Freeze), a "welcome back" re-entry note on each Part 2 divider, and
  spoken hand-off lines on all four Your-turn slides (Day-2's second had none); plain-languaged the three
  internal-jargon notes. Then cleared the cheap deferred **P2s**: `fig-alt` "vs"→"versus" (language A1),
  removed the stale `setup.qmd` DESCRIPTION TODO comment (technique P2-1), added a Part-2 cut-first Timing
  note on the Day-1 title-block slide (pedagogue P2-1 — the last unnamed shock-absorber), and set
  PDF-not-page expectation on the `sample-typst.qmd` link (beginner P2). Executable files re-rendered;
  `_freeze/` restaged. Left by choice: the `→`/`WYSIWYM` read-aloud house-calls (language B5/B6 —
  presenter-preference). Merged to `main` (`26dc7be`).

### Day-2 review — Dashboards demo + whole-arc panels (2 cycles, 8 reports) — 2026-07-08

Ran the reviewer panel twice: once **scoped to the new Dashboards demo** (tag `dashboard`) and once
across the **whole Day-2 arc** (tag `day2-arc`) — deck + lab + starter + solution + dashboard read as
one ~2h experience. **0 P0 across all eight reports.** Two P1s (both cheap) + a P2 cluster; all of the
recommended set fixed in one pass, deck/lab/dashboard re-rendered green, freeze re-staged.

- **P1 — dead safety-net link (arc-technique, also arc-beginner):** the lab's `[solution/](solution/)`
  link **404s on the rendered site** — `starter/`/`solution/` carry their own `_quarto.yml`, so they're
  nested projects excluded from the parent build, and the anti-stranding link dies exactly when a
  behind participant clicks it. Demoted to a code-styled `` `solution/` `` "open the folder in your
  cloned repo" path (matching how `starter/` was already written). A true whole-arc catch — invisible
  to per-file review, only a cross-artifact + rendered-site pass exposed it.
- **P1 — US spelling (both language reviewers):** `millimetres`→`millimeters` in a dashboard fig-alt.
- **P2 cluster fixed:** deck→dashboard link `.html`→`.qmd` (so Quarto validates + rewrites it like every
  other cross-file link) + opens in a new tab; `::: notes` presenter cue on the cut-able Demos slide;
  self-teaching comments in the dashboard source (`##`=row/`###`=column, each cell = a `.card`, icon =
  any bootstrap-icons name); `_metadata.yml` noted as "not needed in today's flat project"; a clause that
  the first single-file render lands `.html` next to source (the *project* render fills `_site/`); deck
  `custom.scss` marked "(your own, optional)"; `tbl-cap` added to the starter/solution `tbl-means`;
  "Book **versus** website"; killed a "break in between" redundancy.
- **Deferred (defensible):** collaborator-facing artifact re-title (subjective); two presenter-script
  nuances (unscripted Part-1→break bridge, your-turn-2 freeze-half weighting).

The technique panel also **proved** (against compiled HTML, not asserted) that the dashboard compiles to
the intended 2-row/2-valuebox/1-card/1-tabset layout and that `_brand.yml` teal is baked into the page
CSS — discharging the long-standing technique P2-5 ("budget the layout model or it's an underwhelming
single-plot page"). Eight dated reports in `.claude/archive/reviews/`; dispositions in the ledger.
**Day 2 is now content-complete and arc-verified, matching Day 1.**

### Day-2 Dashboards demo — static `format: dashboard` page built (the tracker) — 2026-07-08

Built the one deferred Day-2 DEMO artifact: `labs/quarto-projects/dashboard.qmd`, a self-contained
**static** `format: dashboard` penguins page (no Shiny/OJS backend — opens as plain HTML anywhere).
Deliberately exercises the **full layout model** the technique review flagged (scope P2-5: a dashboard
that's only `format: dashboard` + one plot "lands as an underwhelming single-plot page"): **2 rows ·
2 valueboxes** (species count / penguins measured, computed from data) **· 1 `.card` plot** (body-mass
boxplot) **· 1 tabset** (bill scatter / means table). Runs on base-R `penguins` + `dplyr`/`ggplot2`
(already in renv); every plot has `fig-alt`.

**Brand carries via the project `_brand.yml`** — the dashboard *chrome* (teal header, Albert Sans,
teal/teal-light valueboxes) picks up the brand automatically (dashboards are a supported brand format).
Plots keep ggplot's **default fills**: the RaukR brand is monochrome teal and can't separate three
species by hue (the same constraint the Day-1 payoff figure hit) — so the layout, not plot color, is
the teach. **Visually verified** (Playwright/Chromium screenshot of `_site/`): all four layout pieces
render, tabset switches, valueboxes show 3 / 342.

**Wired in:** added to the `_quarto.yml` `render:` list (a full build validates it); the Day-2 deck's
"Demos — if time" slide now carries a real **[See one]** link to the rendered page (`../../labs/
quarto-projects/dashboard.html`) — so the tail beat can *open* a polished dashboard rather than build
one live (the placement stays cut-able, per running-order rule 1). Deck re-rendered (prose edit → fresh
freeze); dashboard `_freeze/` staged. Both green.

### WP4 — Day-2 lab authored + reviewed; freeze P0 fixed in deck too (the tracker) — 2026-07-08

Authored `labs/quarto-projects/index.qmd` (two challenges — **Website** then **Ship it** — mirroring
the Day-1 lab shape: Scope → Tasks → You-should-see → Hint → Solution → Troubleshooting → Session),
plus a **shipped starter** (`starter/{index,analysis}.qmd` — raw pages) and a **completed reference
project** (`solution/` — the pages + `_quarto.yml` + `_brand.yml`). Renders green, `_freeze/` staged.
This also **resolves the WP3 deck's beginner P0** — the deck's two Your-turn slides now land on a real,
completable lab.

**Panel (V2, all four):** reports `review-2026-07-08-wp4-lab-*`. The important catch was a **technique
P0 that also lived in the deck**: I'd taught `freeze: auto` as "edit prose → code skips", but Quarto's
freeze is **per source file** (the repo's own `check-freeze.sh` says so), so `auto` re-executes on *any*
change including prose. Fixed in **both** lab and deck, in lock-step:

- **`auto`** now correctly = "re-execute a document only when its **source** changes"; the lab demo is
  **render-twice-with-no-edit → the cell is skipped** (the honest, observable signal); `true` = never
  re-execute on a project build (the CI mode). `cache` (knitr, per-cell) vs `freeze` (per-doc) sharpened.
- **Rule-2 fix (pedagogue):** shipped `solution/` so Part 2 opens from a ready known-good project, not
  a rebuild-from-the-solution; the Website Solution now points there (killing an inert Tasks-dup).
- **beginner:** target figure aligned to the starter's default theme; clarified branding themes the
  site chrome, not the plot; added a baseline-render step. **language:** Challenge named consistently.
- **deck follow-up:** Your-turn callouts now name the Challenges (rule 9); freeze slide corrected.

V0/V1 green after fixes (both re-rendered, re-skin clean, fig-alt present). **Day-2 deck + lab are now
content-complete and panel-clean.** Remaining Day-2 strands: Dashboards / Positron demos (DEMO-tier).

### WP3 — Day-2 deck authored + reviewed (the tracker) — 2026-07-08

Authored `slides/quarto-projects/index.qmd` from the beat-lock — the first real Day-2 content, now
that the toolchain works on web. Follows the locked running order (Part 1: why-a-project / websites /
cross-refs / `_brand.yml`; Part 2: freeze / publishing; demos tail), re-skinned to base-R penguins +
`|>`, matching the Day-1 house style (setup chunk, `. . .` fragments, Follow-along/Your-turn callouts,
`::: notes`, jargon glosses). Renders **revealjs** green, `_freeze/` staged. Logo block left as a
TODO placeholder (brand otherwise works) rather than blocking on the deferred logos strand.

**Panel (V2, all four `workshop-reviewer-*`):** reports `review-2026-07-08-wp3-deck-*`. **0 P0 on the
deck's own content**; the one P0 (beginner) is the Your-turn slides pointing at the still-skeleton lab
— an arc dependency resolved by building WP4 next, not a deck defect. All deck P1s + cheap P2s fixed:

- **`freeze: auto`** now shown as the default (`true` reframed as the hard-freeze/CI variant) — the
  beginner's silent-trap catch; **CI** glossed at first use; dropped a cross-ref callout hedge.
- **Follow-along** callouts added at both parts' first live beat (rule 9 was half-realized).
- Language: "one letter apart" (false for cache/freeze) → "easily confused"; a leaked stage-direction
  → "Extra topics, if we have time"; "chunk"→"cell"; +Wi-Fi / "hands-on part" / "precedence top-down".
- Correctness: `library(brand.yml)` added so the R-side brand snippet runs; `contents: auto` glossed;
  `renv::init()` noted.

V0/V1 green after the fixes (re-skin clean, no unresolved xrefs, fig-alt present, both transitions
marked). Committed with freeze staged. **Next in the run:** WP4 lab (`the tracker`), which resolves
the beginner P0.

### R 4.6.1 via rig — the "R 4.3.3" mystery was a broken PPA (the tracker) — 2026-07-08

The second render blocker (base-R `datasets::penguins` needs **R ≥ 4.5**; sandbox had **4.3.3**) is
**fixed**, and the root cause was a surprise: a **broken third-party apt source**. The `ondrej/php`
PPA changed its `Label`, which makes `apt-get update` **exit 100** — so the session-start hook's
update silently failed, the **CRAN repo never got indexed**, and R fell back to Ubuntu universe's
stale **4.3.3**. (`apt-cache policy` confirmed r-base-core only resolving from `noble/universe`.)

**Fix (rig, per the suggestion):** `apt-get update --allow-releaseinfo-change` to clear the label
change, then install R via **rig** — `rig.r-pkg.org` (apt) + the Posit R-builds CDN, both
**non-GitHub**, so unaffected by the github-scoping proxy. `rig add release && rig default release`
→ **R 4.6.1** (exactly what `renv.lock` wants; the lock's R is 4.6.1). renv restored the 63-package
library as **P3M noble binaries in 22 s**. Verified end to end: `data(penguins)` → 344 rows with the
project columns (`bill_len`/`bill_dep`/`flipper_len`/`body_mass`), and a penguins → knitr → **Typst
PDF** render succeeds. With the label fix, the CRAN-apt path *also* now resolves 4.6.x (kept as fallback).

- **`session-start.sh` § 1** rewritten: `--allow-releaseinfo-change` (the load-bearing fix) → **rig**
  (primary, non-GitHub) → CRAN apt (fallback). `bash -n` clean. Installs current R (≥ 4.5 guard via
  `sort -V`) instead of Ubuntu's r-base.
- **`sandbox-setup.md` §§ 1–2** updated (rig strategy + the broken-PPA root cause; the R ≥ 4.5 caveat
  flipped to ✅ resolved).

**Net effect:** the *entire* render chain now works on web — Quarto (Cloudsmith `.deb`, prior entry)
+ R 4.6.1 (rig) + penguins + Typst. Closed **the tracker**; **un-deferred** the render-dependent Day-2
strands (lab `the tracker`, Dashboards `the tracker`, Positron `the tracker`) — they're workable now.
The Day-2 deck `the tracker` remains separately blocked on brand/logos.

### Quarto installs on web after all — Posit Cloudsmith fallback (the tracker) — 2026-07-08

The "Quarto can't install in the web sandbox" blocker (the tracker) is **fixed**, and the root
cause was *not* a blanket github.com egress block. github.com is reachable; the Claude-Code-on-the-web
GitHub proxy **scopes github.com to the session's source repos**, so `quarto-dev/quarto-cli` returns
`403 {"message":"…not enabled for this session. Use add_repo…"}`. And `add_repo` can't fetch it either
— v1 blocks **cross-tier** adds (session owner is `cderv`, so only `cderv/*` is addable, not `quarto-dev/*`).

**The fix (thanks to the Cloudsmith pointer):** pull the **same official `.deb` from Posit's
Cloudsmith CDN** — `dl.posit.co/public/open/deb/.../quarto_${QV}/quarto-${QV}-linux-amd64.deb` — a
**non-GitHub** host that isn't proxy-scoped. Verified end to end: HTTP 200, identical 138 MB binary,
clean `apt install`, standard `/usr/local/bin/quarto` layout, and `quarto check` green — pandoc, bundled
**Typst**, and the **knitr R engine** all OK.

- **`session-start.sh`** now installs Quarto in three tiers, first that works wins: **GitHub `.deb`**
  (canonical, for local/unscoped) → **Posit Cloudsmith `.deb`** (same binary, non-GitHub — the one that
  succeeds on web) → **conda-forge via micromamba** (`micro.mamba.pm` + `conda.anaconda.org`, repackaged
  bundle, needs a `QUARTO_*` PATH wrapper) as last resort. `bash -n` clean.
- **`sandbox-setup.md` § 1** rewritten accordingly (the old "GitHub is Quarto's only source / widen the
  policy" note was wrong — Cloudsmith + conda-forge are non-GitHub sources).

**Second gap this uncovered — R version.** The content uses base-R `datasets::penguins` (**R ≥ 4.5**),
but the sandbox's CRAN-apt install lands **R 4.3.3**, where `data(penguins)` errors. So Quarto is now
fine, but **re-rendering executable penguins content still fails at the R chunk** until R is ≥ 4.5
(markdown-only pages are unaffected; the committed Day-1 `_freeze/` came from an R ≥ 4.5 machine). Filed
as **the tracker** (P1) and documented in `sandbox-setup.md § 2`. The render-dependent Day-2 strands
(lab, Dashboards, Positron demos) stay deferred — now gated on the **R** strand, not Quarto.

### Day-2 CORE beat-lock — Part 1/Part 2 running order + timings (the tracker) — 2026-07-07

Locked the Day-2 running-order spine so **WP3 (Day-2 deck)** has a concrete beat sheet to build
against. Added **§ Day-2 CORE beat-lock — per-part, per-beat** to `topic-store.md` (right under the
per-part time budgets): each confirmed CORE beat assigned to Part 1 or Part 2 with a per-beat
concept+demo minute split (Part 1: Why-a-project 5 · Website 6 · Cross-refs 3 · `_brand.yml` 4;
Part 2: Freeze&caching 8 · Publishing 7), DEMOs kept in the cut-able post-payoff tail.

**Review (scoped, agents as needed):** ran the **pedagogue** + **technique** reviewers on the lock
(beginner/language skipped — no learner-facing prose yet). Reports
`review-2026-07-07-day2lock-{pedagogue,technique}.md`. **0 P0, 3 P1 — all fixed:**

- **(technique) Cross-refs "resolve project-wide" was a book claim inside a website beat.** In a
  website, numbered `@fig-`/`@sec-` do **not** resolve across pages (that's a `type: book` feature) —
  a live "Our" demo would surface a broken `?@fig-`. Reworded to "resolve **within a page**; cross-page
  = links + navbar/sidebar," with a ⚠️ not-a-website-feature note + verify-at-the-machine flag.
- **(pedagogue) Zero-slack sums** (18/18, 15/15 re-hid the overload the budget exists to expose).
  Reframed 18/15 as a **ceiling**, target ~16/~13, and **named the per-part shock-absorber** (Cross-refs
  in Part 1; the `renv.lock` slide in Freeze for Part 2) so overrun trims a known place, not the payoff.
- **(pedagogue) 8-min Freeze beat overloaded** (4 concepts + renv, all pre-payoff). Named **`renv.lock`
  as the cut-first sub-item** so the 8 min protects the load-bearing cache-vs-freeze scenario.

Also folded the low-risk **technical-correctness P2s** (they'd otherwise break a live demo): the
`_brand.yml` beat now says **show the `theme_brand_*()` call** (plots render grey without it), and the
Freeze beat pins **`freeze: true`** for the "CI renders without R" claim to actually hold. Reconciled a
stale, self-contradictory `_brand.yml` DEMO-table note ("runs in Part 1" *and* "in the Part-2 tail") to
**locked to Part 1**. Remaining P2s (in-window trim guidance beyond the named absorber) left for review.
Markdown-only change (no `_freeze/` touched); `quarto` unavailable this session so no render was needed.

### braid backlog seeded; sync works from web sessions — 2026-07-07

`braid sync` **reaches `wss://sync.web3sider.dev` from a remote Claude-Code-on-the-web session**
after all — the earlier "sync client bypasses the egress proxy, so run braid locally" assumption
no longer holds (verified this session). Consequences:

- **Seeded the initial backlog into the skein** from the sandbox: epic `the tracker` *RaukR 2026
  Quarto sessions — build* + 16 children (the paste-once script from the backlog plan). `waits-for`
  ordering verified — scaffold + both Part1/Part2 locks are `ready`; the decks/labs are `blocked`
  behind brand + locks; brand itself waits on scaffold + logos.
- **Archived the seed plan** → `.claude/archive/plans/2026-07-06-braid-backlog.md`, its header
  rewritten to "SEEDED — do not re-run" (a second run would duplicate every strand).
- **Corrected the stale docs:** the braid note in `CLAUDE.md § Environment` now says sync works from
  web and points at the seeded epic + core loop, instead of "unreachable — run locally."

### Visual review of the Day-1 output — 2026-07-07

Rendered and actually **looked at** the Day-1 output (branded Typst PDF via `pdftoppm`→PNG; the
revealjs deck + HTML pages via a Playwright/Chromium screenshot of `_site/`). Two real issues that
only a visual pass could catch — both fixed and re-verified on screen:

- **Payoff figure — species were near-indistinguishable.** `sample-typst.qmd`'s branded scatter
  mapped Adelie→`primary` and Gentoo→`link_teal` — two almost-identical teals, so only Chinstrap
  stood out. The RaukR brand is monochrome teal, so three categories can't separate by hue alone:
  now distinguished by **shape *and* a dark/mid/light spread** (`code_blue`/`primary`/`secondary`) —
  colorblind-safe and readable in grayscale. The heaviest-penguin label is now bold `foreground`.
- **Brand font had no fallback → serif on load failure.** Quarto emits the brand font as bare
  `Albert Sans` (a Google font) with no generic family, so if it fails to load (offline / flaky room
  wifi at the event) deck and site drop to the browser default **serif**. Added a defensive
  system-**sans** fallback: `theme.scss` for the reveal deck (`--r-main-font`/`--r-heading-font`) and
  a new `theme-html.scss` for the site (wired via `format: html: theme: [default, theme-html.scss]`).
  Albert Sans still leads, so a successful load is unchanged; a failed load now degrades to sans, not
  Times. Verified by rendering offline — deck and lab both fall back to clean sans.
- The Typst PDF payoff otherwise renders exactly as intended (Albert Sans, teal `gt` table, resolved
  APA citations); confirmed on screen. (Playwright/screenshot tooling is git-ignored.)

### Day-1 integrated arc review — 2026-07-07

Ran the 4-reviewer panel on the **whole Day-1 arc as one ~2h experience** (deck + lab + starter +
`penguins-report` + `sample-typst`) — a cross-artifact pass for seams/coherence/timing, distinct
from the per-file WP1/WP2 reviews. **0 P0.** The arc was authored as a genuine unit (technique
live-verified the spine + brand-color path agree across all five files). Fixed the seam-level
findings (all re-rendered green, freeze consistent):

- **Layouts over-promise** (pedagogue + beginner): the deck said "you'll build these live in the lab"
  for five layout ideas the lab only exercises one of (margin) → softened to name margin explicitly.
- **Terminology unified** (language): standardized on **cell** across deck + lab (kept "chunk" only
  in the R Markdown-migration aside); deck captions "vs."→"versus"; "front matter"→"YAML header";
  "body markdown"→"body Markdown".
- **One label, one idiom** (technique): the deck's means-table label `tbl-mean`→`tbl-summary` (what
  every delivered file uses); the `summarise` idiom unified to modern `.by = species` across the lab
  solution and all three worked files (was `group_by() |> … .groups = "drop"`).
- **Small adds:** a capstone clause in the lab Scope; a "reference, not a checklist" note on the
  worked-solution pointer; an author replace-nudge; a Part-2 "Follow along … or open the starter";
  a "Learn more" links line closing the deck.
- Four dated reports (`review-2026-07-07-day1-arc-*.md`) + dispositions in the ledger. Deferred (all
  defensible): document-title drift, repeated Typst gloss, Part-1 breadth (already budget-fit).

### WP2 — Day-1 lab authored (`labs/quarto/index.qmd` + starter) — 2026-07-07

The Day-1 **hands-on**: the lab the deck's two "Your turn" slides send participants to. Built from
the reskinned penguins progression (user2024 Ex4/Ex5) + the typst-2026 Typst exercise + the NBIS
troubleshooting callout. Passed V0 (both docs render green as HTML, `_freeze/` staged), V1, V2 (the
4-reviewer panel — **0 P0**), V3 (budget: the equation is a marked *stretch* task so the core
figure+table+margin land inside 30 min).

**Added**
- `labs/quarto/index.qmd` — the full lab (was a TODO skeleton): scope callout → setup chunk → a
  collapsed Rmd-migration aside (not the opener, rule 4) → **Authoring Challenge** (figure + table +
  margin + `{#eq-}` math cross-refs → HTML) → **Citations Challenge** (add `@gorman2014` + a title
  block → branded Typst PDF), each with a task list, an embedded/visible success criterion, a
  collapsible hint, a folded `#| code-fold`/`#| eval: false` solution, then a Troubleshooting callout
  and the `<details>` Session block. Challenge names match the deck (rule 9).
- `labs/quarto/starter.qmd` — the **shipped Part-2 starter** (rule 2): a complete, known-good Part-1
  report (figure/table/margin/equation, no citations) so anyone stranded by the between-parts gap
  can still do the Citations Challenge. Renders clean to HTML *and* to a branded Typst PDF.
- `_quarto.yml` render list widened for the starter.

**Review panel (V2) — 0 P0; 4 P1 + P2 polish fixed**
- Pre-seeded the `gt` skeleton so the exercise is the `tbl-`/`@ref` **cross-reference mechanic**, not
  `gt` plumbing (pedagogue); told participants to **create the file inside `labs/quarto/`** so
  Part-2's relative `bibliography:`/`csl:`/`_brand.yml` resolve (beginner); gave the equation task
  its **escaped** LaTeX and warned about the silent `bill_len` underscore-subscript trap (beginner);
  "separated"→"separate" (language). Plus: typed the Tasks callout (a11y), a title-block task
  (manuscript rule 6), a prose-cross-ref example, a gt/Typst font-warning troubleshooting line, an
  `author:` placeholder nudge, editor-vs-rendered-page link wording, and a duplicate-sentence nudge.
- Four dated reports in `.claude/archive/reviews/review-2026-07-07-wp2-lab-*.md`; dispositions in the
  ledger. **Day 1 (deck + lab) is now content-complete.**

### WP1 — Day-1 deck authored (`slides/quarto/index.qmd`) — 2026-07-07

The first authored teaching content: the **Day-1 "Introduction to Quarto" deck**, built from the
`raukr-2025-quarto` base + the useR!-2024 aspiration hook + the NBIS engine-mermaid slide, but
**rebuilt focused and self-contained** — live base-R `penguins` code (`echo: true`) instead of the
~40 screenshots the 2025 tour depended on. Two parts: **Part 1 Basics → land an HTML doc**, **Part 2
Citations → Typst**. Passed V0 (renders green as **revealjs**, `_freeze/` staged), V1 (re-skin /
portability / fig-alt / jargon-gloss), V2 (the 4-reviewer `/start-workshop` panel — **0 P0**), and
V3 (time-budget fit).

**Added**
- `slides/quarto/index.qmd` — the full deck (was a TODO skeleton). `## Learning Outcomes` open →
  "What you can do now" close; mode-marker callouts at the live transitions only; the penguins arc
  from WP0 carried through (same columns, same `bill_len × bill_dep` figure, same `_brand.yml`).
  Covers: what Quarto *is* (aspiration reframe, not "Rmd++"), the engine mermaid ("how it all
  works"), `.qmd` anatomy + hash-pipe, Markdown deltas (figures, cross-refs, a `gt` table, `{#eq-}`
  math, inline code, callouts), article layouts (+ the revealjs caveat), one-source→many-formats,
  a merged running/editing DEMO (CLI + Positron), then Citations (`.bib`/`@ref`/CSL) → title block →
  Typst → `_brand.yml`, each part ending on a lab "Your turn".

**Review panel (V2) — first pass on authored content, 0 P0**
- **6 P1 fixed** in this commit: Part-1 talk overflowed the budget → folded the Execution-options +
  Positron slides into **one** "Running & editing" DEMO (V3 cut from the list, not the exercise);
  named the Part-2 lab handoff ("Citations Challenge", matching the lab) and reframed it to a
  **shipped Part-2 starter** (nobody stranded by the between-parts gap); **glossed Typst on first
  use**; added a **visible setup chunk** at the "Follow along" callout so a type-along participant's
  first chunk doesn't fail; "labelled"→"labeled".
- **P2 polish folded in:** equation code now matches its rendered output; `cache`→`freeze` gloss;
  WYSIWYM spelled out; `theme_brand_*` attributed to the `brand.yml` package; "Pandoc + Lua"→
  "Pandoc"; zero-install caveat; Oxford commas; Part-2 "Follow along" marker; Your-turn presenter
  notes; the payoff artifact front-loaded onto the Learning Outcomes slide.
- Four dated reports in `.claude/archive/reviews/review-2026-07-07-wp1-slides-*.md`; dispositions in
  the review ledger.

**Notes**
- Prior-art re-cloned to the **scratchpad** (out of the project tree) so `quarto render` doesn't
  walk into them (same reason as WP0).

### WP0 — shared Day-1 assets + Typst/citations de-risk — 2026-07-07

First content-phase work package (`.claude/plans/2026-07-07-content-plan.md` § 1-2): build the
shared assets both days draw on, and **prove the Day-1 Citations → Typst payoff renders end-to-end**
before authoring the deck/lab around it. Passed V0 (render green, `_freeze/` staged) + V1
(smoke-tests, run as parallel verifier sub-agents). No deck/lab teaching content yet — that's WP1/WP2.

**Added (all under `labs/quarto/`)**
- **`references.bib`** — 6 entries, keystone **Gorman et al. 2014, *PLoS ONE*** (the paper behind
  `penguins` — citing it makes the running doc a real manuscript) + horst2020, R core, ggplot2, gt,
  knitr. Build-fresh (the prior art had only `bibliography:` keys, no `.bib`).
- **`apa.csl`** — APA 7th (mainstream author-date), from the citation-style-language project.
- **`penguins-report.qmd`** — the **running Day-1 HTML document**: re-skin of the keystone
  `new-penguins-full-example-corrected.qmd` onto base-R `penguins` (columns `bill_len`/`bill_dep`/…,
  `|>`, US English, `palmerpenguins` dropped as the data source). Carries the authoring value-adds
  (figures + `fig-alt`, cross-refs, a `gt` table, margin content, a `{#eq-}` equation) and cites
  `@gorman2014`. Renders **HTML and `--to typst`** with citations + cross-refs resolved.
- **`sample-typst.qmd`** — the **branded Typst PDF payoff**: the Star Wars Typst technique re-skinned
  to penguins + the RaukR brand. `format: typst` (no LaTeX), project `_brand.yml` styling **plus the
  R-side brand** (`theme_brand_gt`/`theme_brand_ggplot2` via the `brand.yml` package reading the same
  `_brand.yml`), and citations. Renders a 2-page branded PDF.

**Proven (the risk-register's thinnest asset — § 7 risk 2)**
- **Typst + citations path works.** With `csl: apa.csl` set, Quarto emits Typst-native
  `#set bibliography(style: "apa.csl")` + `#bibliography("references.bib")` — the CSL↔Typst-native
  handoff — and both PDFs resolve in-text cites to `(Gorman et al., 2014)` / `(Horst et al., 2020)`
  with a formatted References section, no `?@`/raw-`@key` markers.
- **Google-font brand carries into Typst.** Confirmed via DeepWiki + render: Quarto downloads the
  brand's Google fonts (Albert Sans / Fira Mono) and passes them to Typst via `--font-path`, so the
  branded PDF uses **Albert Sans** as the main font — no vendoring needed. (Residual `sans-serif` /
  emoji font warnings come from `gt`'s table fallback stack and are cosmetic.)

**Changed**
- **Deps:** added `brand.yml`, `ggrepel`, `prismatic` to `DESCRIPTION` `Imports:` and `renv.lock`
  (for the R-side branding); mirrored on `setup.qmd`. Fixed `_brand.yml` — removed the non-standard
  `color.link` role (link color lives under `typography.link.color`) so the strict `brand.yml` R
  package can read it.
- **`_quarto.yml` `render:`** widened to build the two new sample docs (plan § 7 risk 1 — a new
  supporting `.qmd` silently won't build otherwise).
- **`.gitignore`** — ignore per-doc render artifacts written next to source (`**/*_files/`,
  `**/*.typ`, root `/site_libs/`); the canonical frozen copies live under `_freeze/`.

**Notes / follow-ups**
- Prior-art repos cloned to the **scratchpad** (out of the project tree) rather than gitignored
  repo-root dirs: at repo root Quarto's website scan walks into them and tries to render their
  `.qmd` (e.g. NBIS `slides/ai/` needs `library(emo)`), breaking `quarto render`.
- The freeze hook (`check-freeze.sh`) only guards `execute-results/html.json`; `sample-typst.qmd`
  freezes to `typ.json`, so the hook currently **skips** it (freeze verified consistent by hand). A
  hook patch to also check `typ.json` was drafted but **permission-denied** this session — left as a
  follow-up.
- Minor bib polish applied for the Typst-native reader (which parses `.bib` itself, unlike pandoc):
  dropped a `\emph{}` macro that leaked verbatim, brace-protected `{{PLoS ONE}}`, switched an entry
  to `@manual` to drop a stray date comma.

### Freeze-staleness guard — 2026-07-07

- **`_freeze/` stays versioned**, and a `PreToolUse(Bash)` hook keeps it honest:
  `.claude/hooks/check-freeze.sh` **blocks a `git commit`** when a staged `.qmd`'s MD5 no longer
  matches its committed `_freeze/**/execute-results/*.json` hash (Quarto's freeze hash = MD5 of the
  LF-normalized source; verified against Quarto 1.9.38). Pure-markdown pages are skipped; the
  backstop is a full `quarto render` at end of session. A deliberately small, commit-only
  adaptation of the two-file/commit+push pattern from another repo. Rule documented in
  `CLAUDE.md § Build`.

### Quarto project scaffolded — 2026-07-07 (skeletons; renders green)

The Phase-3 scaffold from the plan: a working Quarto **website** that renders green, carrying the
decided RaukR look and the NBIS-mirroring tree. Plan: `.claude/archive/plans/2026-07-07-quarto-scaffold.md`.

**Added**
- **`_brand.yml`** — the RaukR house look at project level (teal palette + Albert Sans / Fira Mono,
  Google Fonts). Verified applied to both the revealjs theme and the site (Bootstrap) CSS. No logo
  block yet (assets still TODO).
- **`_quarto.yml`** — `type: website`, `lang: en`, `quarto-required: ">=1.8.0"`, `freeze: auto`,
  html defaults (toc-right, number-sections, lightbox), navbar for the two days + Setup. A scoped
  `project: render:` list keeps repo meta-docs (`CHANGELOG.md`, `.claude/**`) out of the build.
- **`theme.scss`** — thin reveal layer (flat `border-radius: 0`, dotted background) over the brand.
- **`justfile`** — `render` / `preview` / `clean` / `publish` (confirm-guarded gh-pages).
- **Pages:** `index.qmd` (programme + links), `setup.qmd` (prerequisites).
- **Skeletons (front-matter + house structure + TODO markers; no teaching content yet):**
  `slides/quarto/`, `slides/quarto-projects/` (revealjs, Learning Outcomes → beats → "What you can
  do now", callout mode-markers at the two transitions); `labs/quarto/`, `labs/quarto-projects/`
  (scope callout → live base-R `penguins` chunk → `## … Challenge` w/ folded solution → `<details>`
  Session block).

**Decided (flagged, non-blocking)**
- **Topic-folder names** (the one "still open" item): `slides/quarto/` + `labs/quarto/` (Day 1,
  exact NBIS match) and `slides/quarto-projects/` + `labs/quarto-projects/` (Day 2).
- **Format-per-doc** avoids the multi-format conflict: project defaults to `format: html`; each deck
  overrides with `format: revealjs` in its own front-matter (replace, not `_metadata.yml` merge).
- **Profiles deferred** (single profile for now) — the full/pre-workshop split waits for content.

**Changed — environment (R packages via renv)**
- **R dependencies are pinned with [renv](https://rstudio.github.io/renv/).** Added `renv.lock`
  (61 packages), `renv/activate.R`, `renv/settings.json`, a project `.Rprofile`, and a `DESCRIPTION`
  that declares the top-level deps (`knitr`, `rmarkdown`, `ggplot2`, `dplyr`, `gt`). The snapshot is
  **explicit** (`snapshot.type: explicit`) — driven by `DESCRIPTION` `Imports:`, so the lock holds
  exactly the intended packages + their transitive deps, not whatever happens to be installed.
- **Hook step 4** now runs `renv::restore()` (was a one-off `install.packages`). Two sandbox-specific
  fixes make it fast + correct, both documented in `sandbox-setup.md § 2`:
  - **P3M binaries via an explicit platform URL.** The lock records the platform-neutral
    `cran/latest`; the hook passes `.../cran/__linux__/noble/latest` to `restore()` so P3M serves
    pre-built noble binaries (no compilation, no `-dev` libs). Needed because renv's automatic
    PPM→binary rewrite relies on a status probe the **egress proxy blocks** — without the override
    renv falls back to compiling from source.
  - **Project `.Rprofile` sources `~/.Rprofile` first**, so the proxy CA bundle + repos survive the
    profile shadowing (R reads only one user profile) and renv can fetch behind the proxy.
- **`setup.qmd`** now tells participants to `renv::restore()` (with a plain-`install.packages`
  fallback). Keep `DESCRIPTION` + the hook + `setup.qmd` in sync as content pulls in more packages.

### Planning locked — 2026-07-07 (pre-content; no `.qmd` authored yet)

A full day of reviewer panels + decisions turned the draft triage into an applied plan. Details
and provenance: `.claude/references/{topic-store,project-context,prior-art-inventory}.md` and the
review ledger `.claude/archive/reviews/README.md`.

**Decided**
- **Running dataset:** base-R `datasets::penguins` (R ≥ 4.5, zero-install), held through the whole
  arc; palmerpenguins fallback + `basepenguins` for R < 4.5. R floor raised to **≥ 4.5**.
- **License:** content **CC BY 4.0** + code **MIT** (same split as Christophe's other materials);
  `LICENSE.md` added. Compatible with folding into the NBIS site (CC BY-NC-SA).
- **Repo layout:** **mirror the NBIS convention** (`slides/<topic>/`, `labs/<topic>/`) so the
  material folds back into their site as a drop-in; portability rules documented (built-in
  shortcodes incl. `{{< meta >}}` OK, extension shortcodes/absolute paths avoided, project-level
  brand).
- **Delivery convention:** mode markers = **built-in callouts at the two live transitions only**
  ("Follow along" / "Your turn → the lab Challenge"); **no bespoke CSS class**, no per-slide "My
  turn" badge; `## Learning Outcomes` open / "What you can do now" close; countdown presenter-side.

**Triage (topic-store) — confirmed & revised**
- **v2 (scope panel):** Day-1 Part 2 slimmed to *Citations → Typst*; Parameters/Shortcodes →
  MENTION; Day-2 `_brand.yml` → Part 1; Publishing live-CI → watch-me DEMO (the one P0: live
  publish is a 40-laptop auth cliff); per-part **time budget** filled; **Running-order rules** added.
- **Layouts** sharpened to the organizer's five terms (pages/outset/inset/columns/panels) mapped
  to distinct Quarto features, verified against the docs.
- **v3 (coverage audit):** folded in the cheap manuscript-relevant absences — Day 1: math
  equations (CORE-delta), Authors/Affiliations title block, inline code / callouts / Word /
  conditional-content / diagrams (MENTIONs); Day 2: renv (2nd reproducibility leg), `_metadata.yml`
  promoted, **Books DEMO→MENTION**, website-tools bundle, `quarto add` verb, Manuscripts signpost.

**Reuse strategy**
- **NBIS harvest map** (line-level): reuse the parameterized-report + website labs, drop the
  git-first opener / chunk-options detour / stale format table.
- **Build-gap:** Day-1 ~80% / Day-2 ~60% reuse; **only 4 true build-fresh items** (Citations
  segment, Dashboards, Positron×Quarto, Interactivity demo). Corrected the plan: a complete EN
  Day-2 deck already exists (`user2024-tutorial` `3-projects.qmd`); the R-side `_brand.yml`
  branding already ships & is tested (typst-2026 book).

### Fixed
- `workshop-reviewer-beginner` agent frontmatter: unquoted the `description:` so the agent
  registers (a leading quote broke YAML parsing).

### Still open (not blocking content build)
- Names for the two topic folders (`slides/<topic>/`); RaukR + NBIS/SciLifeLab logo assets.

### Next
- **Author Day 1 content** into the skeletons: deck from `raukr-2025-quarto`, lab from
  `user2024-tutorial-quarto`, re-skinned onto base-R `penguins`; add the Citations→Typst payoff
  (build-fresh) per `topic-store.md`. Then run `/start-workshop` for the first content review.
- Later: Day 2 content (deck base = `user2024-tutorial` `3-projects.qmd`), profiles split when the
  pre-workshop share is needed, logo assets + dual corner logos.

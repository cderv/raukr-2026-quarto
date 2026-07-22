# Review — Presenter `::: notes` (technique lens)

- **Cycle:** `notes` · **Date:** 2026-07-17 · **Reference commit:** `99563e1`
- **Reviewer:** technique (Quarto-core lens)
- **Scope:** the spoken script in `::: notes` blocks across both decks —
  `slides/quarto/index.qmd` (Day 1) and `slides/quarto-projects/index.qmd` (Day 2).
  Labs, `_brand.yml`, and `dashboard.qmd` consulted where a note makes a checkable claim.
- **Tooling:** Quarto 1.9.38 (`quarto --version`), R 4.6.1. Claims cross-checked against
  Quarto changelog/docs via Context7 (`/quarto-dev/quarto-cli`).

## Overall verdict

The spoken script is technically sound and, in several places, impressively precise — the
subtle claims that usually trip presenters (CSL fallback under Typst, `freeze: auto` vs
`true`, `output-location: column` being revealjs-only, `convert_chunk_header()`, the
"no R on the runner" CI story) are stated correctly and match the labs. I found **no P0 and no
blocking technical error**: every `Do:` beat describes behavior that will actually happen as
narrated. Three low-severity issues remain — one plain factual count (callout types), and two
granularity/scope imprecisions that could mislead a roaming TA. All are quick fixes to spoken
lines, none touch the render.

Counts: **P0 = 0 · P1 = 1 · P2 = 2.**

---

## 🔴 P0 — blocking technical bug

None. Every note's `Do:`/`Say:` beat corresponds to real Quarto behavior; no narrated command,
flag, or live-reload claim is false.

---

## 🟠 P1 — fix before the event

### P1-1 · "Four types" of callouts is wrong — there are five
`slides/quarto/index.qmd:286` (note), echoing the slide body at `slides/quarto/index.qmd:188`.

> **Say:** "Four types — note / tip / warning / important — same syntax, different colour."

Quarto ships **five** callout types: `note`, `tip`, `warning`, **`caution`**, `important`
(verified against Quarto 1.9 docs — `styles-callout.html` lists `caution` explicitly). The
script drops `caution` and asserts a specific count aloud. To this audience (some already know
Quarto), a wrong number is a small credibility ding from a Posit/Quarto maintainer, and it is a
one-word fix.

**Fix:** either name all five (`note / tip / warning / caution / important`) or hedge the count
("several types — note, tip, warning, caution, important"). Align the slide-body list at line 188
at the same time so the spoken line and the bullet agree.

---

## 🟡 P2 — nice-to-have / robustness

### P2-1 · Freeze "tell" is described at the wrong granularity (cell vs document)
`slides/quarto-projects/index.qmd:362`

> **Helpers:** the tell that freeze is working is the *second* render skipping the slow cell — point people at it.

`freeze` operates **per document**, not per cell — which is exactly the contrast this very deck
teaches two slides earlier (`slides/quarto-projects/index.qmd:300`: "cache = per *cell*, within a
doc; freeze = per *document*"). With `freeze: auto`, the observable tell on a project re-render is
that the **whole page is not executed** (no execution progress/messages for that document; the
render is near-instant) — there is no per-cell "skip" indicator; that framing belongs to `cache`.
A TA repeating "watch the slow cell skip" reimports the cache mental model the slide just worked to
separate.

**Fix:** "the tell is that the *second* render doesn't re-execute the page at all (no chunk output
scrolls by) — its slow compute is served from `_freeze/`."

### P2-2 · "No R on the runner" can over-generalize to `quarto publish gh-pages`
`slides/quarto-projects/index.qmd:349` (note) pointing the presenter at the slide bullet
`slides/quarto-projects/index.qmd:340-341`.

> - `quarto publish gh-pages` and **GitHub Actions** automate it, rendering from the committed `_freeze/` with **no R on the runner**.
>
> **Say:** foreground the CI *story* …

The "no R on the runner" property belongs to the **GitHub Actions** path only. `quarto publish
gh-pages` **renders locally** (with R) and pushes the result to the `gh-pages` branch — it is not a
no-R path. The note tells the presenter to "foreground the CI story," which is right, but if that
is narrated over the combined bullet it can leave the room believing `quarto publish gh-pages`
itself needs no R. This is a slide-body conflation the note endorses rather than a note-only error,
so it is P2.

**Fix (spoken framing):** keep the two distinct — "`quarto publish gh-pages` renders here and
pushes; **GitHub Actions** is the one that rebuilds from committed `_freeze/` with no R on the
runner." (No slide edit strictly required if the presenter draws the line aloud.)

---

## ✅ Technical choices validated

Checks I ran and the claims that hold:

- **CSL fallback under Typst is correct** — `slides/quarto/index.qmd:608`: "a missing `csl:` falls
  back to Typst's native style." Verified: for `format: typst`, Quarto delegates bibliography
  rendering to Typst's native `#bibliography()` via `biblio.typ` (CSL support added in Quarto 1.6;
  `citeproc` is *optional* for Typst, per changelog 1.9 "brand fonts applied when `citeproc: true`
  is used with Typst"). So with no CSL, Typst's default style does apply — this subtle claim is
  right, and it does not contradict the lab (which sets `csl: apa.csl` explicitly).
- **`freeze: auto` vs `freeze: true` narration** — `slides/quarto-projects/index.qmd:291,296,301`:
  "re-runs a page only when *that page* changed" / "`freeze: true` never re-executes on a project
  build (refresh by rendering the file directly)." Matches Quarto's documented semantics (freeze
  governs *global project* render; a direct single-file render always executes).
- **`knitr::convert_chunk_header()`** — `slides/quarto/index.qmd:140` and lab `labs/quarto/index.qmd:40`
  agree; the function exists and does the `{r, opt=val}` → `#|` migration as narrated.
- **`output-location: column` is revealjs-only** — `slides/quarto/index.qmd:225`: correctly framed
  as a presentation placement, explicitly *not* the article margin layout. Consistent with the
  settled prior fix.
- **Unresolved cross-ref renders `?@…`** — `slides/quarto/index.qmd:224,462`; the `fig-`/`tbl-`/`eq-`
  prefix trap and the `?@` symptom are accurate and match the lab troubleshooting
  (`labs/quarto/index.qmd:256`).
- **Google-font fetch needs first-render network** — `slides/quarto/index.qmd:608` matches the lab
  (`labs/quarto/index.qmd:261`, "network on the first render (Quarto fetches the Google fonts once)").
- **Dashboard region walk-through is accurate** — `slides/quarto-projects/index.qmd:394-398` claims
  "two valueboxes across the top, a card with the boxplot, and a two-tab panel." `dashboard.qmd`
  confirms exactly that: `## Row {height="20%"}` with two `#| content: valuebox` cells, a card with
  the body-mass boxplot, and `### Column {.tabset}` with two tabs (Bill scatter / Mean measurements).
- **`theme_brand_*()` claim** — `slides/quarto-projects/index.qmd:239-240`: "a plot won't inherit it
  until you add `theme_brand_*()`" is correct (brand.yml is two mechanisms, one file) and the helper
  note's `install.packages("brand.yml")` (not pak) matches the lab (`labs/quarto-projects/index.qmd:28`).
- **Cross-page xrefs don't auto-number on a website** — `slides/quarto-projects/index.qmd:200-202`
  pre-flight is correct; a website renders each page independently, so use Markdown links + nav, and
  book is the project type for global numbering.
- **Reconvene times** — both Day-1 and Day-2 "back at 15:30" (`slides/quarto/index.qmd:461`,
  `slides/quarto-projects/index.qmd:257`) match the schedule (Part 2 starts 15:30 after the ~1h gap).
- **Execution demo** — `slides/quarto/index.qmd:399-403`: header `execute: {echo: false}` hides all
  code, a per-cell `#| echo: true` brings one back; "dashes not dots, `false` not `FALSE`" is exactly
  right.
- **Inline-code reproducibility** — `slides/quarto/index.qmd:301`: "the number updates when the data
  does" is a true statement about knitr inline expressions.
- **Math subscript trap** — `slides/quarto/index.qmd:267`: escaping `bill\_len` inside bare `$$…$$`
  is correct and matches the lab warning.

---

## 📝 Evolution since the previous review

This is the first technique pass focused specifically on the `::: notes`. Relative to the
`4ca2a05` draft → `99563e1` spoken-script polish:

- The **live-demo beat-sheets** (`Do:`/`Say:` on every live slide) are technically faithful — I
  could not find a `Do:` step that narrates a command or flag that won't behave as written. That is
  the high-value property for a maintainer-led live session and it holds.
- The **re-entry / "Welcome back"** notes on both Part-2 dividers make no stale technical claim.
- The **handoff lines** with reconvene times and the **Helpers** cues are accurate and lab-consistent
  (bib-key exact match, cross-ref prefix trap, `install.packages` not `pak`, first-render network).
- Previously settled facts (visual editor in RStudio/Positron/VS Code, `output-location: column`
  revealjs-only, Typst bundled ≥ 1.4 targeting ≥ 1.8, publishing watch-me by design) are all still
  narrated correctly — none regressed.

The only residue is the callout-count (P1) and the two granularity/scope imprecisions (P2) above —
all spoken-line tweaks, none affecting the render.

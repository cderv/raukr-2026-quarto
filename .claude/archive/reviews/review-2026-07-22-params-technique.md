# Technique review — `params` cycle (ref commit bee98ea, 2026-07-22)

Reviewer: workshop-reviewer-technique · Quarto 1.9.38 (installed) · R/knitr engine
Scope: the parameterized-report exercise (braid the tracker) — `labs/quarto/penguins-by-species.qmd`,
the `{#sec-parameters}` bonus in `labs/quarto/index.qmd`, and the `-P` bullet on
`slides/quarto/index.qmd`, plus their consistency with surrounding Day-1 material.

## Overall verdict

Technically sound and correctly wired. Every syntax claim the brief asked me to verify holds up under
a real render: `#| output: asis` + `cat()` produces a genuine numbered H2, `!expr` evaluates in **both**
`fig-cap` and `fig-alt`, `-P species:Adelie` (colon form) is correct current CLI, and — the one I most
expected to bite — shipping a parameterized doc in a `freeze: auto` website project causes **no** stale
artifact, because an explicit single-file `quarto render <file> -P …` always re-executes and honors the
override (verified empirically against the committed Gentoo freeze). No P0. The one substantive issue is
an idiom regression: the new reference doc uses the legacy inline `` `r …` `` form the 2026-07-21 cycle
migrated away from, diverging from both its sibling reports. Everything else is P2 polish.

## 🔴 P0 — blocking technical bug

None.

## 🟠 P1 — fix before the event

**`labs/quarto/penguins-by-species.qmd:19` and `:42` — legacy inline `` `r …` `` instead of the braced
house form.** The file writes `` `r params$species` `` (line 19) and `` `r nrow(one)` `r params$species` ``
(line 42). The house idiom (project-context.md:190-192, slides.md §5) mandates the braced
`` `{r} expr` `` form, and the legacy→braced migration is a *settled* fix (on the do-not-re-flag list).
This is not a re-flag of that migration: it is a **new** file authored fresh in the legacy form, so it
reintroduces exactly the pattern the migration removed. Its two neighbours already use the braced form —
`penguins-report.qmd:34-35` (`` `{r} nrow(penguins)` ``) and `starter.qmd:30-31` — so this doc is the
odd one out in its own directory. Both forms render identically under knitr (hence P1, not P0), but this
is copyable teaching material a participant reads next to the braced siblings, so the wrong idiom
propagates. Fix: `` `{r} params$species` `` and `` `{r} nrow(one)` `` (the doc has executable cells, so
the braced form executes — verified).

## 🟡 P2 — nice-to-have / robustness

- **`labs/quarto/penguins-by-species.qmd` — no `## Session {.appendix .unnumbered}` close.** The house
  rule (project-context.md:177) says *every* lab/report ends with the Session appendix; both siblings do
  (`penguins-report.qmd:132`, `starter.qmd:91`), this one does not. Likely a deliberate "keep the param
  demo minimal" choice — but if kept, it is a visible divergence from the house pattern and the two files
  it sits beside. Decide explicitly.

- **`labs/quarto/penguins-by-species.qmd:28` — `cat("## ", params$species, "at a glance\n")` emits a
  double space** (`cat`'s default `sep = " "` → `##  Gentoo  at a glance`). Cosmetically harmless (HTML
  collapses whitespace; the H2 renders correctly), but `cat("##", params$species, "at a glance\n")` or
  `sep = ""` is cleaner if a sharp-eyed participant copies it. Same string appears in the lab task
  (`index.qmd:276`).

- **`labs/quarto/index.qmd:279-282` — the `!expr` task teaches it only for `fig-cap`, not `fig-alt`.**
  The reference doc correctly parameterizes both (`penguins-by-species.qmd:34-35`), and the house rule is
  "always add `fig-alt`". Since this snippet is the one participants copy, consider showing the `fig-alt:
  !expr …` line alongside so the always-alt habit travels with the `!expr` lesson.

- **`!expr` is a knitr-engine feature (robustness note, not a defect).** It evaluates because these cell
  options are handed to knitr; it would silently not work under the jupyter engine. Fine for this
  all-R/knitr session — flagging only so the caption/alt `!expr` idiom isn't later lifted into a
  jupyter-engine doc and quietly break.

## ✅ Technical choices validated

- **`#| output: asis` + `cat("## …")` → a real, numbered heading.** Rendered HTML:
  `<h2 data-number="1" … data-anchor-id="adelie-at-a-glance"><span class="header-section-number">1</span>
  Adelie at a glance`. It is a genuine ATX heading, and with the project's `number-sections: true` it is
  numbered ("1"). Directly answers the brief's question. (Minor observation, not a finding: it is the
  doc's only `##`, so a single-species report shows one lone "1 … at a glance" — correct, if slightly
  unusual to see a solitary section number.)
- **`!expr` in both `fig-cap` and `fig-alt` under knitr — works and is documented, not fragile.** Both
  evaluated in the render (`-P species:Adelie` produced an alt-text string reading "…for Adelie penguins…"
  and a matching caption). This is the standard knitr `!expr` YAML tag applied to cell options; not an
  undocumented hack.
- **`-P species:Adelie` (colon form) is correct current syntax.** Confirmed by render and by
  quarto.org/docs/computations/parameters.html (`quarto render document.ipynb -P alpha:0.2 -P ratio:0.3`;
  repeat `-P` per parameter — matches the hint at `index.qmd:302`). The "must have defaults" framing
  (`index.qmd:289,301`) is sound and matches the docs' guidance and this exact setup (the doc is rendered
  once with defaults in the site).
- **No website-project / freeze conflict — the concern I most expected to be real is not.** The doc is
  `format: html` only, in the render list, rendered once with the `Gentoo` default → a legitimate,
  non-misleading artifact. Critically: with the committed **Gentoo** freeze in place and `execute:
  freeze: auto` global, I ran `quarto render labs/quarto/penguins-by-species.qmd -P species:Adelie` and
  got **Adelie** output (`data-anchor-id="adelie-at-a-glance"`, "Adelie penguins had both…"). `freeze`
  only short-circuits *whole-project* renders; an explicit single-file render always executes, so the
  lab's CLI workflow honors `-P` for every participant. No stale-freeze trap.
- **`fig-alt` present on the new figure** (`penguins-by-species.qmd:35`) — house rule satisfied; it also
  tracks the parameter.
- **Slide `-P key:value` bullet is accurate and not overclaiming** (`slides/quarto/index.qmd:457-458`):
  "override a document *parameter* … (Optional bonus in today's lab.)" — correct, scoped, points at the
  lab. Fit-checked the `## Running & editing` slide: `{scrollH:720, clientH:720}` (no vertical overflow),
  and the screenshot shows no horizontal clip on the code block or the `-P key:value` inline. Speaker-note
  cue ("Params (MENTION, cut-first)") keeps it off the critical path per house style.
- **Consistency with surrounding material:** `dplyr`/`ggplot2` are both in the setup page
  (`setup.qmd:121,132`) so the doc runs on a participant machine; `data(penguins)` matches the base-R
  approach of the sibling reports; the literal-syntax escape ` ```{{r}} ` in lab step 3
  (`index.qmd:273`) correctly shows the braced cell literally (slides.md §5); the `.callout-note
  icon=false` + `{{< fa clipboard-list >}} Tasks` scheme matches the vendored-fontawesome lab icon
  convention.

## 📝 Evolution since the previous review

This cycle closes the last Day-1 coverage gap (parameters) cleanly. The reference doc is genuinely
tested — the asis heading, dual `!expr`, and CLI override all survive a real render and a `-P` override,
and the freeze/website interaction that could easily have shipped a misleading artifact was got right
(single-file render bypasses freeze). The lab bonus is well-structured (Tasks / You should see / Hint,
correct `{{r}}` escape) and correctly framed as optional/self-service. The only regression against the
now-settled house baseline is the legacy inline `` `r …` `` in the new file (P1) — the same idiom the
2026-07-21 cycle spent effort migrating away from elsewhere, so worth catching before it lands in the
NBIS tree next to the braced siblings.

---
Checks run: `quarto render labs/quarto/penguins-by-species.qmd` (default + `-P species:Adelie`), rendered
HTML inspection (heading number, fig-alt, species propagation), freeze-vs-`-P` interaction test with the
committed Gentoo freeze restored, `quarto render slides/quarto/index.qmd` + `slide-shot.mjs` fit-check of
`#running`, cross-file inline-idiom / Session-block / package-availability greps. Working tree left clean.
Source confirmed via quarto.org/docs/computations/parameters.html.

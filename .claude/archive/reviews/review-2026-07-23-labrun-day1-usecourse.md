# Lab-run review — Day-1 Intro lab, from a real `use_course()` download

- **Date:** 2026-07-23
- **Reviewer:** labrun participant-sim (project-novice persona; fluent R/dplyr/ggplot2, first Quarto *project*)
- **Source of instructions (only):** `labs/quarto/index.qmd`
- **Work dir:** unpacked `raukr-2026-quarto-exercises/day1-intro/` (the `use_course()` "Desktop" tree)
- **Toolchain:** Quarto 1.9.38, R present, content packages on library path.
- **Artifacts produced:** `my-report.html`, `my-report.pdf` (branded Typst), `penguins-by-species.html` (×3 species). All renders exit 0.

## Verdict

A real beginner can finish this lab solo, including the Typst payoff and the parameterized bonus — I hit **zero blockers** and produced every expected artifact. The unpacked tree matches the prose almost perfectly: `day1-intro.Rproj`, `references.bib`, `apa.csl`, `_brand.yml`, `starter.qmd`, `penguins-by-species.qmd`, `sample-typst.qmd` are all present exactly where the lab says, and everything renders "right next to your files" as promised. The one place the room would briefly fragment is **Authoring Task 4** ("Put the species counts in the margin") — it is the only task that supplies *no code* while every neighbour does, so a less dplyr-fluent participant has to invent `count(species)` with no cue. Secondary, softer friction: the exact YAML placement of `axe:` is left to inference, and the download-button URLs point at a not-yet-created repo (harmless because the files ship locally, but they'd 404 if clicked today).

## Friction log (in order)

1. **Setup / orientation** · Read Scope + "working in `day1-intro/`" callout, listed the folder. · All named files present (`references.bib`, `apa.csl`, `_brand.yml`, `starter.qmd`, `penguins-by-species.qmd`, `sample-typst.qmd`, `day1-intro.Rproj`). Tree matches prose exactly. · `worked-fine` · The framing is accurate to what you actually see.

2. **Authoring T1 — create `my-report.qmd`, `format: html` + setup cell** · Copied the given setup cell verbatim, added title/author. · Rendered clean; `data(penguins)` + the NA-filter worked with base-R penguins, no palmerpenguins needed. · `worked-fine` · Copy-paste-ready.

3. **Authoring T2 — `fig-bill` scatter + `@fig-bill`** · Added labelled cell with `fig-cap`/`fig-alt`, referenced in prose. · Renders as live "Figure 1" link, no `?@`. · `worked-fine` · The label/`@ref` mechanic is spelled out clearly.

4. **Authoring T3 — `tbl-summary` gt table + `@tbl-summary`** · Pasted the provided `gt()` snippet, added `tbl-cap`. · "Table 1" resolves. · `worked-fine` · Providing the gt plumbing and asking only for the cross-ref mechanic is the right call for this audience.

5. **Authoring T4 — species counts in the margin** · Task says *only* "Put the species counts in the margin with the cell option `#| column: margin`" — **no code given**. I inferred `penguins |> count(species)`. Rendered with `column-margin` class in the margin. · `had-to-infer` · This is the single task that hands you an option but not the one line of R that produces the thing being placed — every other task gives its code. A dplyr-fluent R user recovers instantly; a shakier participant stalls on "what *are* the species counts, exactly?" One example line (`penguins |> count(species)`) in the task or Hint would remove the guess.

6. **Authoring T5 (stretch) — display equation `@eq-ratio`** · Pasted the exact `$$…$$ {#eq-ratio}` block with escaped underscores. · "Equation 1" resolves. · `worked-fine` · The pre-emptive "escape the underscores" note is genuinely helpful — I'd have been bitten otherwise.

7. **Accessibility box — `fig-alt`, `scale_color_okabe_ito()`, `axe: {output: document}`** · Added all three. The box says "add `axe: {output: document}` under `format: html`" but not the exact indentation; I inferred the flow-map goes as a key of `html:`. Rendered and the `axe-check` / "Accessibility" WCAG widget appeared on the page with **no extension install**. · `had-to-infer` (placement) → `worked-fine` (result) · Two small beginner unknowns the prose doesn't pre-empt: (a) *where exactly* `axe:` nests, and (b) whether `axe` needs `quarto add` (it doesn't — it's built in to 1.9). A one-line "no extension needed" and a shown YAML stub would settle both.

8. **Authoring T6 — render HTML** · `quarto render my-report.qmd`. · `Output created: my-report.html`, landed in `day1-intro/`, all three cross-refs live, margin populated, axe report present. · `worked-fine` · Matches the "You should see" checkpoint exactly.

9. **Citations T1–T4 — bibliography/csl, `@gorman2014`, References div, author block** · Added `bibliography: references.bib` + `csl: apa.csl`, replaced `author:` with the name/affiliation block, added `## References {.unnumbered}` + `::: {#refs}`. Note: the Authoring tasks never ask you to write the "…Palmer Station, Antarctica." sentence, so continuing my own doc I had to **add** it — the lab's "Find (or add)" wording correctly anticipates this. · `worked-fine` · The "(or add)" hedge is doing real work; keep it.

10. **Citations T5 — render HTML, confirm citation** · Rendered. · In-text "(Gorman et al., 2014)" + full APA reference list, no `?@gorman2014` / `[?]`. · `worked-fine` · Exactly the promised checkpoint.

11. **Citations T6 — Typst PDF (CLI route)** · `quarto render my-report.qmd --to typst`. · Built `my-report.pdf` (128 KB, exit 0). Got the predicted stack of `warning: unknown font family: …` — and crucially they were only the **gt default sans-serif/emoji stack** (`system-ui`, `Segoe UI`, emoji), *not* the brand fonts, so Albert Sans/Fira Mono resolved silently. · `worked-fine` · The Troubleshooting box pre-explaining these warnings is the reason this wasn't a panic moment — without it a beginner absolutely reads a wall of red `warning:` as failure. The heads-up in Task 6 + the box is well placed. (Caveat: I couldn't eyeball the palette — no PDF viewer in this env — so I verified via build success + font-warning analysis, not by eye.)

12. **Bonus — parameterized `penguins-by-species.qmd`** · Took the lab's "fastest path": rendered the shipped file with `-P species:Adelie`, `-P species:Chinstrap`, and bare (default). · Each HTML is exclusively its species (Adelie→only Adelie, Chinstrap→only Chinstrap, default→only Gentoo); exit 0 each. · `worked-fine` · The "render the shipped file first, build-it-yourself is optional" framing is the right on-ramp; the `-P name:value` checkpoint is unambiguous.

13. **Migrated-prose spot-checks (per launch brief)** · Output locations ("lands right next to your files" / PDF "right next to its source in `day1-intro/`") — **accurate**, confirmed for `.html` and `.pdf`. Day-folder framing / `.Rproj` — **accurate**. **Download-button URLs** point at `raw.githubusercontent.com/cderv/raukr-2026-quarto-exercises/main/…`; the HTML comment admits the repo "goes live once created", so these would **404 today**, but the files all ship locally so a participant never needs them — low risk, worth a note. **Reset story**: the lab has **no reset/"start over" section at all** — nothing in `index.qmd` tells a participant how to get back to a clean `day1-intro/` if they mangle `starter.qmd`/`penguins-by-species.qmd` in place. · `ambiguous` · Not blocking, but the "reset story" the brief asked about is simply absent from the lab prose.

## Tag counts

- `worked-fine`: 9
- `had-to-infer`: 2 (margin code; `axe:` placement/extension question)
- `ambiguous`: 1 (dead download URLs + absent reset story)
- `undefined-term`: 0
- `error-recovered`: 0
- `BLOCKER`: 0

## Top improvements (ranked, with the lab's actual wording)

1. **`labs/quarto/index.qmd` § Authoring Challenge, Task 4** — the lab says only:
   > "Put the species counts in the **margin** with the cell option `#| column: margin`."
   Every other Authoring task ships its R; this one doesn't. Add the one line (e.g. in the task or the Hint): `penguins |> count(species)`. It's the only spot where a non-dplyr-fluent participant has to invent the *content*, not just the mechanic.

2. **`labs/quarto/index.qmd` § Accessibility box (`Make it accessible`)** — the bullet:
   > "add `axe: {output: document}` under `format: html`, re-preview, and a WCAG report appears on the page"
   leaves two beginner unknowns: the exact YAML nesting and whether `axe` needs `quarto add`. Show the two-line YAML stub in place and add "(built in to Quarto 1.9 — no extension to install)". It worked for me only because I inferred both.

3. **`labs/quarto/index.qmd` § (whole page) — add a short "reset / start over" note.** There is currently **no** guidance for recovering a clean `day1-intro/` after editing the shipped `starter.qmd` / `penguins-by-species.qmd` in place. Given the lab tells people to edit those shipped files directly ("open `day1-intro/starter.qmd` … and add the citations to that"), a one-line reset story (re-download, or `git checkout`, or "work on a copy") would save a stuck participant.

4. **`labs/quarto/index.qmd` § download buttons (Authoring + Bonus)** — the three `raw.githubusercontent.com/cderv/raukr-2026-quarto-exercises/main/…` buttons **404 until the repo is public**. The prose already says the files "ship locally", so consider softening the button copy to "(also in your `day1-intro/` folder)" so a participant who clicks and gets a 404 isn't confused — or gate the buttons on the repo going live.

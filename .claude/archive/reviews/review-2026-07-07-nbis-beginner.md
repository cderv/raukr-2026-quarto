# Beginner walkthrough — NBIS RaukR 2026 Quarto material (reuse triage)

**Date:** 2026-07-07
**Reviewer persona:** advanced R user / life-science researcher, fluent tidyverse, occasional
R Markdown, dabbled in Quarto, never built a project or touched `_brand.yml` / extensions /
presentations. English fine; undefined jargon trips me. No Stack Overflow in the room.
**Target walked:** NBIS `raukr-2026` (main) — `slides/quarto/index.qmd`,
`labs/quarto/index.qmd`, `labs/quarto-site/index.qmd`. **Not** our material — this is a
reuse-vs-leave verdict on the inherited NBIS content.

---

## Overall verdict

The **website lab is the strongest asset** — a real, buildable, step-by-step project with two
honest publishing paths; I could mostly do it solo, and it's the closest thing here to
something that engages me. The **slide deck and the general lab are pitched below me for
their first ~60%** (what a chunk is, basic markdown, YAML string types) and are structured as
*reference walls*, not guided hands-on: the general lab has only **two** actual "Tasks" and no
success criteria, so I'd tune out through the boring middle and then miss the one exercise
that matters. Two things would genuinely block me on the day: the website lab **opens on
`git clone git@github.com…`** with no SSH-key setup (fails silently for anyone without keys),
and **citations are essentially absent** from the whole deck — the one thing a manuscript
audience actually came for. `iris` is everywhere and reads as a toy to me. Net: **keep the
website lab's spine, the engine mermaid, the troubleshooting box, and the parameterized-report
exercise; drop the "what is Quarto/markdown/a chunk" front-matter and the `%>%`/dated bits.**

---

## 🔴 Would block or lose me — drop or fix before reuse

**1. Website lab opens on a GitHub/SSH cliff.**
`labs/quarto-site/index.qmd:22-40` — the very first section is "GitHub", and step one is:
> "copy the SSH URL of the repository" … `git clone git@github.com:username/site.git`
If my SSH keys aren't set up on this laptop (very likely in a fresh workshop environment),
that command fails with a permission error and I'm dead in the water on step one — no HTTPS
fallback offered, no mention of `gh auth` or key setup. This is the single most likely
room-killer in the material. If reused, either start from a local folder (no GitHub until the
publish step) or give an HTTPS/`gh` path with a pre-flight.

**2. The general lab is a reference wall, not a lab — I can't tell if I "did it right."**
`labs/quarto/index.qmd` is ~600 lines of *prose describing features* with inline rendered
examples, but the only thing asking me to **do** something is one callout at `:592-599`:
> "Try to create a new report for the species **versicolor**" / "convert the document to PDF
> using Latex (`format: pdf`) and Typst (`format: typst`)"
There are no checkpoints, no "your output should look like X", and (unlike the house style)
**no `code-fold` solution blocks** to check myself against. Solo, under workshop pressure, I'd
read passively, glaze over, and arrive at the one Task with no scaffolding. Reuse the *report
exercise* (below), but rebuild the surrounding material as guided steps with explicit success
criteria — don't reuse the walkthrough shape.

**3. Citations are missing from the deck — the thing my audience came for.**
The slides (`slides/quarto/index.qmd`) never teach citations/`.bib`/`@ref`/CSL at all; Typst
gets **one throwaway line** (`:149-153`). For people who write manuscripts, that's the missing
rung. The deck spends slides on YAML multiline-string syntax (`:262-287`) and markdown bold
(`:398-462`) but nothing on the manuscript payoff. Don't inherit this priority ordering.

---

## 🟠 Reuse only after fixing

**`iris` in every single example** (slides `:191, :349, :358, :660-733`; general lab `:276-428,
:471-568`; website lab `:250`). As a life scientist it reads as a toy — flower petals, nothing
molecular, nothing I'd recognize from my own work. It's *familiar* (a mild plus), but it never
makes me lean in. Penguins is marginally better but still a toy; a small real -omics-shaped
table (counts / a DE-results frame with gene, log2FC, padj) would actually engage me and let
cross-refs/captions carry real meaning. (Our plan already says penguins — I'd push one step
further toward something bio-flavored for at least the payoff exercise.)

**`%>%` (magrittr pipe) throughout the deck** — `slides:660, :673-678`. To a 2026 "level-up"
audience this signals dated material on sight; I write `|>`. Any lifted slide needs this
swapped or it undercuts the "modern" framing.

**RevealJS section of the general lab is prose-only with an assumed starter.**
`labs/quarto/index.qmd:613-714` says "Now, we will convert the report to a presentation" but
then just *lists* revealjs features — there's no step-by-step and no starter file; it assumes I
still have "the report" from the previous section in a convertible state. If I didn't finish
the report exercise, I have nothing to convert. Needs a shipped starter and actual steps.

**`_brand.yml` treatment is too thin to learn from.**
`labs/quarto-site/index.qmd:413-433` introduces `_brand.yml` as just a colors+fonts block with
no explanation of *what it unifies* (site + slides + plots) or why it beats Bootswatch. As the
person who's never touched it, I finish the section not understanding what I gained. Fine as a
seed; needs the "one file → consistent everything" story we plan to add.

**Placeholder persona is inconsistent — I'd trust the material less.**
Website lab: title is **Jane Doe** (`:90, :346`) but the subtitle is "Welcome to **Michelle's**
world of code!" (`:347`) and the About links point to **`github.com/mlogan`** /
`bsky.app/profile/mlogan.dev` / `michelle-logan-dev` (`:131-137`). Three identities in one
persona. When I copy-paste this as my template I have to hunt down which name is "real."

**The PDF-via-LaTeX Task is a time-sink trap.**
General lab `:592-599` asks me to "convert the document to PDF using Latex (`format: pdf`)".
If TinyTeX isn't installed that triggers a multi-minute install (or a cryptic failure) mid-
session. Lead with Typst (no install) as we plan; make LaTeX-PDF the optional path.

**Undefined dataset + missing font in a copyable example.**
General lab `:293-303`: the ggplot example uses `dfr4` (never defined anywhere) and
`base_family = "Gidole"` (a font nobody has installed). It's `eval: false` so it won't error,
but if I copy it to try it, it breaks and I don't know why. Confusing artifact lifted from some
other deck.

---

## 🟡 Minor

- **Typos on a chunk-options slide:** `slides:516` "", `:517` "supresses". On a slide
  I'd re-read later, these stick out.
- **Dated version string:** `slides:787-789` shows `quarto --version` → `1.4.549`. Reads as
  stale next to a 2026 deck (context notes it's illustrative, but a learner won't know that).
- **Appendix slides after the closing slide.** `slides:821` is the "Thank you! / Questions?"
  slide, then `:835-879` ("Compared to Rmd", "Output formats" table) come *after* it. Revising
  the PDF later, I'd think the deck ended and miss them — or be confused why content follows the
  goodbye.
- **Broken-ish link:** `slides:480` RMarkdown link is malformed —
  `…authoring_pandoc_markdown.html%23raw-tex#pandoc_markdown` (encoded `#` plus a second
  anchor). Won't land where intended.
- **`stringr` loaded, never used.** General lab `:31` loads `library(stringr)` but I don't see
  it used anywhere in the lab — an unnecessary "did I need to install this?" moment.
- **External iframe dependency.** General lab `:477, :619` embed
  `royfrancis.github.io/quarto-exp/…` live — needs internet and a third-party site staying up
  for the exercise reference to render.
- **"Pandoc" undefined on slide 1** (`slides:10` "built on Pandoc"). Minor for me, but it's the
  first noun and it's never glossed.

---

## ✅ What worked — KEEP this

- **The "How it all works" engine mermaid** — `slides:535-562`. This is the one slide that made
  something click for me: seeing `.qmd → knitr/jupyter engine → markdown → Pandoc/Lua render →
  {html, pdf, docx…} → publish` finally explained *what Quarto actually is as a system* vs
  R Markdown. Keep this (modernize labels). Best asset in the deck.
- **The Troubleshooting callout** — general lab `:603-611`. Exactly the self-rescue list I need
  with no Stack Overflow in the room (YAML indentation, missing package, image paths, cross-ref
  labels, PDF-fails-try-HTML-first). Reuse this pattern in every lab.
- **The progressive YAML build-up** — general lab `:43-146`. Three versions of the same header,
  simple → complex, each with a screenshot and a plain-language line-by-line ("`code-fold: true`
  Folds the code and reduces clutter"). Good scaffolding; I could follow it and predict the
  effect.
- **The parameterized-report exercise** — general lab `:471-599`. The single strongest hands-on
  here: subset a dataset by a `params$name`, dynamic titles/captions via `!expr`, cross-refs,
  swap the parameter at the CLI (`-P name:versicolor`), even per-species photos. This is a
  *real* pattern I'd use (re-run a report per sample). Keep the mechanic; re-skin off iris.
- **The website lab's overall spine** — `labs/quarto-site/index.qmd`. Genuinely buildable:
  `_quarto.yml` → navbar → about → blog posts → listing → home → styling → freeze → publish.
  It reads like a real project, not a feature tour. Fix the SSH opener and persona names and
  this is reusable close to as-is.
- **Two honest publishing paths** — website lab `:456-513` gives both `quarto publish gh-pages`
  *and* the manual `docs/` + Pages-settings route. I appreciated not being locked into the
  auth-heavy path (matches our plan to make live-publish a watch-me).
- **The patchwork blog post** — website lab `:221-295`. A concrete, realistic "arrange plots"
  post with executable chunks and figure captions/labels — the kind of thing I'd actually write.
- **The "Example websites" gallery + "Learning more"** — website lab `:515-593`. Great after-
  the-workshop springboard: dozens of real Quarto sites by tier (simple/intermediate/advanced)
  plus qmd4sci and Mine's workshop. This is what I'd open at home to redo it. Keep.

---

## 📝 Evolution since previous review

n/a — this is a walkthrough of NBIS's inherited material for a reuse decision, not a re-review
of our own content (no prior baseline for this target).

---

### One-line reuse bottom line

**Keep:** website-lab spine (fix SSH + persona), the engine mermaid, the troubleshooting box,
the progressive-YAML scaffold, the parameterized-report exercise (re-skin off iris),
patchwork post, and the resources gallery. **Leave/rewrite:** the "what is Quarto / markdown /
a chunk" slide front-matter, the reference-wall shape of the general lab, `%>%` and the dated
version bits, and the citations-absent priority ordering.

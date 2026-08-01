# RaukR 2026 · Quarto

> Two Quarto sessions at [**RaukR 2026**](https://nbisweden.github.io/raukr-2026/) — the *Advanced
> R for Bioinformatics* summer school (Visby, Gotland; NBIS / SciLifeLab / Uppsala University),
> **10–11 Aug 2026**.

Two afternoon sessions on writing and publishing with **Quarto**, for an audience that already
writes R and has met R Markdown or Quarto. The angle is *what Quarto is as a system*, and how to go
from a single document to a whole project you can publish — not "what is a code chunk".

- **Instructor:** Christophe Dervieux ([Posit](https://posit.co/) — R Markdown / Quarto)
- **Day 1 · Mon 10 Aug — Introduction to Quarto:** the single document — authoring, layout, and the
  modern output story (incl. Typst).
- **Day 2 · Tue 11 Aug — Quarto projects:** beyond one file — websites, config, publishing, tips & tricks.

Each day is **two parts with a gap** (150 min on Day 1, 180 on Day 2), and each part reaches a
hands-on payoff. The running
example is the base-R `penguins` dataset (R ≥ 4.5), held through the whole arc.

## The site

This repository is a [Quarto website](https://quarto.org/docs/websites/) project; the rendered
slides, labs, and setup page are its output. Once published it will live at
<https://cderv.github.io/raukr-2026-quarto/> — the material is still being authored, so pages may
change up to the school.

## Before you arrive

The sessions are hands-on — come with a working toolchain. In short: **R ≥ 4.5**, **Quarto ≥ 1.9**
(the Typst article layout used on Day 1 landed in 1.9), and an editor with Quarto support ([Positron](https://positron.posit.co/),
VS Code, or RStudio). Typst — the modern PDF path used on Day 1 — ships *inside* Quarto, so there is
nothing extra to install.

Full instructions, including how to recreate the exact R environment, are on the **Setup** page
(`setup.qmd`, rendered on the site above). This repo pins its R dependencies with [renv](https://rstudio.github.io/renv/):

```r
renv::restore()   # recreate the environment from renv.lock
```

## Programme

| Day | Session | Slides | Lab |
|-----|---------|--------|-----|
| **Mon 10 Aug** | Introduction to Quarto — authoring, layout, and the output story (incl. Typst) | `slides/quarto/` | `labs/quarto/` |
| **Tue 11 Aug** | Quarto projects — websites, config, publishing, tips & tricks | `slides/quarto-projects/` | `labs/quarto-projects/` |

## What's in this repo

```
index.qmd · setup.qmd     Home page and setup instructions
slides/quarto/            Day 1 — Introduction to Quarto (revealjs deck)
slides/quarto-projects/   Day 2 — Quarto projects (revealjs deck)
labs/quarto/              Day 1 lab, with exercise files and demos
labs/quarto-projects/     Day 2 lab, with a starter and a worked solution
exercises/                Generated participant files (see below) — never hand-edited
tools/                    R scripts that generate and publish the exercises repo
_quarto.yml · _brand.yml  Website config and branding
justfile                  Build entry point
```

The exercises run on the base-R `penguins` dataset, with solutions available in each lab.

**Participant materials live in a separate repo.** `labs/` is the source of truth here.
`just exercises` regenerates the `exercises/` files via `tools/sync-exercises.R`, and
`just publish-exercises` mirrors it to
[`cderv/raukr-2026-quarto-exercises`](https://github.com/cderv/raukr-2026-quarto-exercises),
the repo participants download with `usethis::use_course()`. Never hand-edit `exercises/`.
A CI drift-guard enforces that it matches `labs/`.

## How this was built

The teaching is Christophe's: what belongs in two afternoons, what an experienced-R audience can
skip, which Quarto claims are safe to make on stage.

Drafting and review were LLM-assisted, session by session and directed throughout. The working
setup is in the open under `.claude/`: path-scoped gotchas that bite when editing (`rules/`),
reference notes on the Quarto techniques used here (`references/`), a four-lens review panel and
an agent that walks the labs as a first-time participant (`agents/`, `commands/`), the Quarto bug
reports this material turned up (`upstream-issues/`), and two Claude Code hooks (sandbox setup,
and a commit block on a stale `_freeze/`). Useful if you're adapting this workshop.

## Building it

The [`justfile`](justfile) is the build entry point (run `just` for the list):

```sh
just render     # render the whole site to _site/
just preview    # live preview with auto-reload
just clean      # remove build artifacts
just publish gh # render, then publish to GitHub Pages (or: just publish connect)
```

`_freeze/` is versioned: after editing an executable `.qmd`, re-render it (`quarto render <file>`)
and commit the refreshed freeze so the site builds on CI without re-running R.

## Prior art

This material builds on Christophe's earlier Quarto talks and tutorials, updated for 2026:
[RaukR 2025](https://github.com/cderv/raukr-2025-quarto),
[useR! 2024 tutorial](https://github.com/cderv/user2024-tutorial-quarto),
[RR 2023](https://github.com/cderv/tuto-quarto-rr-2023), and
[RR 2026 (Typst)](https://github.com/cderv/tuto-quarto-typst-rr-2026).

## License

See [`LICENSE.md`](LICENSE.md). In short:

- **Content** — text, slides, exercises, pages, figures: [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
- **Code** — scripts, build config, authoring tooling: [MIT](LICENSE.md#mit-license-code).

This content is authored so it can later be folded into the NBIS RaukR site; how that material
relates to this one (CC BY-NC-SA, referenced not vendored) is covered in [`LICENSE.md`](LICENSE.md).

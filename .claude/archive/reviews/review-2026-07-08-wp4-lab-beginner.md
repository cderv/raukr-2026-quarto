# Day-2 Lab (WP4) — Beginner review

**Reviewer role:** experienced R user, new to Quarto *projects*. Did Day 1 yesterday.
**Scope:** `labs/quarto-projects/index.qmd` + shipped `starter/` (index.qmd, analysis.qmd).
**Date:** 2026-07-08 · branch `claude/goal-command-wx5go6` (uncommitted, working tree).
**Explicitly not re-flagged:** deck, Day-1 lab, scope/triage, missing logos, sandbox-only renv.

## Overall verdict

I make it through both parts. The single strongest thing about this lab is that the
"`_quarto.yml` goes **inside `starter/`**" point — the one I was most likely to get wrong — is
hammered home four separate times (task, hint, solution comment, troubleshooting), so I never
guess. "Render the whole folder vs. one page" is clearly explained, the Solution doubles as a
between-parts safety net, and the starter genuinely renders on its own. **No P0.** The one real
snag: the "Your analysis figure looks like this" target plot is styled with `theme_minimal()`,
but the shipped `analysis.qmd` figure is **not** — so my output won't match the picture I'm told
to check against, and I can't tell if I succeeded. That plus a stretch task that's already been
done for me are the things I'd fix before the day.

---

## 🔴 P0 — blocking for the event

None. I can complete the Website Challenge and the Ship-it Challenge as written.

---

## 🟠 P1 — fix before the event

**1. The "You should see" target figure doesn't match what the starter produces — I can't
confirm success.**
`index.qmd:88` says *"Your analysis figure looks like this:"* and renders a target
(`index.qmd:99-102`) with `theme_minimal(base_size = 12)` — clean white background.
But the figure I actually render lives in `starter/analysis.qmd:20-22` and has **no
`theme_minimal`** — it's the default ggplot **grey** background:
```r
ggplot(penguins, aes(species, body_mass, fill = species)) +
  geom_boxplot(show.legend = FALSE) +
  labs(x = NULL, y = "Body mass (g)")   # ← no theme_minimal()
```
So the primary "did it work?" checkpoint of the whole first challenge shows me a plot I cannot
reproduce. As a beginner I'll assume I broke something (or that brand should have restyled the
plot — see P2.6) and burn time chasing a non-bug. Fix: either add `theme_minimal(base_size = 12)`
to `starter/analysis.qmd` so the outputs match, or drop it from the target, or caption the target
"illustrative — your grey default is fine."

---

## 🟡 P2 — nice-to-have

**2.1 Stretch task 4 is already done in the shipped starter.**
`index.qmd:78-80` (stretch): *"On `analysis.qmd`, cross-reference the figure within that page
(`@fig-…`)."* But `starter/analysis.qmd:25` already contains
`@fig-mass shows that Gentoo penguins are clearly the heaviest`. When I open the file the cross-ref
is already there and already resolves. The imperative wording ("cross-reference the figure") makes
me think I'm supposed to *add* one and hunt for where. Reframe as "**notice** that `analysis.qmd`
already cross-references its figure with `@fig-mass`; confirm it renders as *Figure 1*."

**2.2 `execute: freeze: auto` placement isn't pinned down — a likely YAML paste error.**
`index.qmd:162-166` tells me to "Add freeze to `starter/_quarto.yml`" and shows:
```yaml
execute:
  freeze: auto
```
but never says *where*. My `_quarto.yml` currently ends with `format:` → `html:` → `theme: cosmo`,
so the natural (wrong) move is to paste `execute:` indented under `format:`. Given YAML is
indentation-sensitive (as the Troubleshooting itself warns), one line: "add `execute:` at the
**top level**, not nested under `format:`" would save the classic 5-minute debug.

**2.3 No "render the baseline first" step.**
The callouts *claim* the pages "already render on their own" (`index.qmd:32`, `:157`) but never
have me actually render one before I start editing project config. If something in my setup is off,
I'd rather discover it on `quarto render analysis.qmd` (one file) than blame my brand-new
`_quarto.yml`. A one-liner — "first, `quarto render analysis.qmd` to confirm your setup, *then*
add `_quarto.yml`" — de-risks the opening.

**2.4 "Watch the log; no compute" is a weak success signal for freeze.**
`index.qmd:167-168` / `:177-179` tell me to prove freeze by watching the log for the cell being
"skipped." In practice Quarto doesn't print a loud "SKIPPED" line, so as a beginner I stare at the
log unsure. The concrete, confirmable signals are already in the lab but under-sold: **`starter/_freeze/`
appears after the first render** (`index.qmd:186`) and the **second render finishes near-instantly
with no package-loading messages**. Point me at those instead of "watch the log."

**2.5 The workshop repo already has its own `_quarto.yml` + `_brand.yml` at its root.**
I confirmed a website `_quarto.yml` and a `_brand.yml` at the repo root
(`/home/user/raukr-2026-quarto/_quarto.yml`, `_brand.yml`). The lab says "Open that folder
[`starter/`] in your editor," which avoids the problem — but if I open the *whole* cloned repo in
Positron/RStudio and hit the **Render** button on `starter/analysis.qmd` *before* creating
`starter/_quarto.yml`, project detection walks up to the **repo-root** `_quarto.yml`, whose
`render:` list doesn't include the starter → confusing no-op or wrong output dir. A one-line nudge
("open **just** the `starter/` folder, or `cd starter/` in a terminal") would harden the "nearest
`_quarto.yml`" story the hint (`index.qmd:107-108`) relies on.

**2.6 "themed in teal with Albert Sans" right before the plot implies the plot should go teal.**
`index.qmd:85-87` ("themed in teal with Albert Sans") sits immediately above the figure, so I
expect the **boxplot** to turn teal after `_brand.yml`. It won't — brand only touches page chrome
(navbar/headings) unless I use `theme_brand_ggplot2()`. The Troubleshooting does clarify this
(`index.qmd:214-215`), but the "You should see" block should say plainly "the **navbar and
headings** go teal; the **plot stays default** unless you opt into `theme_brand_ggplot2()`."

**2.7 Flow-style YAML in `_brand.yml` is error-prone to hand-type.**
`index.qmd:138-143` uses `palette: { teal: "#4C979F" }` and
`fonts: [{ family: Albert Sans, source: google }]` — flow braces/brackets, unlike the block style
everywhere else in the lab. Copy-paste is fine; but if I retype it (as beginners do to "learn it")
a missing brace breaks the build. Minor — consider block style for consistency.

---

## ✅ What reassures me (beginner's-eye clarity)

- **The "`_quarto.yml` inside `starter/`" point is unmissable** — task (`index.qmd:48`), hint
  (`:107`), solution comment (`:121`), troubleshooting (`:211`). This was my #1 fear and it's
  fully de-risked.
- **Whole-folder vs. one-page is explicit.** `index.qmd:112-113`: "`quarto render` with no file
  argument builds the whole project; `quarto render index.qmd` builds one page." No guessing.
- **The Solution is also a continuity bridge.** `index.qmd:155-157` — "If you didn't finish it …
  drop those two files into `starter/` and you're ready." I can fall behind in Part 1 and still
  start Part 2 from a known-good state. Exactly right for a 40-person room.
- **The Troubleshooting callout (`index.qmd:207-221`) is genuinely useful** — YAML indentation,
  "No project," brand-not-applied, plots needing `theme_brand_ggplot2()`, "freeze didn't skip,"
  missing package. It anticipates the real failure modes.
- **Starter is minimal and actually renders standalone** — `starter/index.qmd` is pure markdown;
  `starter/analysis.qmd` is a small knitr doc on base-R `datasets::penguins` (I confirmed the
  columns `bill_len`/`bill_dep`/`body_mass` exist), so no data download and it builds before I
  touch anything.
- **`output-dir: _site` is consistent** across task, "You should see," hint and Solution — I always
  know the deliverable is `starter/_site/`.
- **Freeze *is* confirmable** — `_freeze/` appearing (`index.qmd:186`) is a solid, visible proof
  even if the log message is subtle (see 2.4).

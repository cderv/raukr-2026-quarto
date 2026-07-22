# Notes-cycle review — roaming-TA / newcomer seat (2026-07-17)

_Fictional stance: experienced R + tidyverse, life-science, dabbled in R Markdown but never built a
Quarto project — this cycle wearing the **helper's hat**. Question isn't "can I finish?" but "if I'm
the TA the presenter waves over, do the `::: notes` (esp. the new **Helpers:** cues) let me rescue a
stuck participant fast, and does anything the presenter is scripted to say/do leave a state the
participant then can't reproduce?" Walked the participant path in order:
`setup.qmd` → Day 1 slides + lab (+ `starter.qmd`) → Day 2 slides + lab (+ `starter/`, `solution/`)._
Reference commit `99563e1`, scope tag `notes`.

## Overall verdict

As a helper I'm well-equipped: the two traps that actually strand people — the Day-2 `cd starter/`
cwd trap and the "where did my output land" confusion — are documented to the hilt in the lab bodies,
and every **Your turn** slide carries a concrete, actionable **Helpers:** cue. The re-entry after the
1-hour gap is genuinely solid on both days: each Part-2 opens with a one-line "Welcome back" recap and
each lab's *Starting point* callout hands a drifted participant a known-good file (`starter.qmd` /
`solution/`), so nobody is stranded. Continuity on the fragile citation beat is airtight — I verified
the `gorman2014` key exists and the starter's sentence matches the insertion instruction verbatim, and
I verified the lab's subtle "a fresh doc renders next to source" claim is *correct*. Two gaps keep this
from a clean bill: the Day-1 **Citations "Follow along" slide has no `::: notes` at all** — the single
most fragile live beat is unscripted for a helper — and the Day-2 Your-turn-1 Helpers cue names the
*secondary* trap (link paths) instead of the *primary* one (`cd starter/`). No P0s.

## 🔴 P0 — blocking for the event

None. Every file the notes lean on exists, the citation key resolves, output lands where the lab says,
and the re-entry safety nets are real paths.

## 🟠 P1 — fix before the event

**1. The Day-1 Citations "Follow along" slide has no presenter notes at all — the most fragile live
beat is unscripted.** `slides/quarto/index.qmd:488-525` (the `## Citations` slide) opens with a
`::: {.callout-note title="Follow along"}` — "Back in your editor — we add citations to the Part-1
document (or the lab's `starter.qmd`)" — i.e. the presenter live-adds `bibliography: references.bib` +
`csl: apa.csl` + `[@gorman2014]`. This is the exact moment two traps first bite live: the `.bib` path
resolves **relative to the `.qmd`** (so it only works if the follow-along doc lives in `labs/quarto/`
next to `references.bib`), and the `@key` must match. Yet the slide carries **no `::: notes`** — no
`Do:`/`Say:`/`Helpers:`. Contrast Part 1, where *every* follow-along beat (Markdown-content, Figures,
Tables, Math, Callouts, Inline code) has a scripted note. The trap is only picked up much later, at the
**Your turn 2** handoff (`slides/quarto/index.qmd:606-609`). As a helper I'd want the cue *at the
live-intro beat*, because that's where a follower who typed `bibliography: references.bib` in a scratch
doc sitting somewhere other than `labs/quarto/` gets a silent `[?]` and I have to diagnose it. Add a
`::: notes` with **Do:** "the `.bib` path is relative to the doc — your follow-along file must sit in
`labs/quarto/` next to `references.bib`/`apa.csl`" and **Helpers:** "the `@key` must match; a `[?]`
means either a wrong key or `bibliography:` not set."

**2. Day-2 Your-turn-1 Helpers cue names the wrong "most common trap."**
`slides/quarto-projects/index.qmd:258`: *"most common trap is `output-dir` vs the page paths — links
are relative to the source, not `_site`."* But link-relativity only bites participants who attempt the
**stretch** (the cross-page Markdown link). The trap that strands *everyone* — because everyone renders
— is running `quarto render` from the **repo root** instead of `cd starter/`, which rebuilds the whole
workshop site into the repo's `_site/` and ignores their new `starter/_quarto.yml`. The lab itself
treats *this* as THE trap: a whole paragraph (`labs/quarto-projects/index.qmd:42-48`) plus two
troubleshooting bullets (`:205-209`). A TA who reads only this cue will check the participant's `href:`
paths when the real question is "are you inside `starter/`?" Lead the cue with the cwd trap:
*"first thing to check — are they `cd`'d into `starter/`? A render from the repo root rebuilds the
workshop site into the repo `_site/`, not their project."*

## 🟡 P2 — nice-to-have

**3. Day-1 Your-turn-1 Helpers cue misses the symptom-twin of the prefix trap.**
`slides/quarto/index.qmd:462` names only the cross-ref prefix (`fig-`/`tbl-`/`eq-`) and duplicate
labels as the source of a stray `?@`. But a `?@` just as often comes from **misplaced `#|`** — the
hash-pipe options must be the *contiguous first lines* of the cell with no blank line or code above
them; drop a blank line and `#| label: fig-bill` silently becomes a comment and the ref breaks. A
helper told only "check the prefix" will stare at a correct `fig-` prefix and miss the real cause. Add:
"…and the `#|` lines are the very top of the cell, no blank line above the code."

**4. Day-1 "Branding the PDF" slide has no `::: notes`.** `slides/quarto/index.qmd:572-596` introduces
`theme_brand_ggplot2()` / `theme_brand_gt()` — the "a plot won't inherit the palette from the file
alone" trap — but carries no note. Day 2's twin brand slide flags exactly this
(`slides/quarto-projects/index.qmd:234` + notes `:238-243`). Lower severity here because Day-1's brand
payoff ships pre-built in `sample-typst.qmd` rather than being built live by participants, but a
one-line note would let a helper answer "why is my plot still default-colored?" without improvising.

**5. Day-1 Your-turn-2 Helpers cue omits the "where's my PDF?" question it will actually field.**
`slides/quarto/index.qmd:608` covers key/network/csl, but not the output-location split the lab body
flags at `labs/quarto/index.qmd:200-201`: rendering the shipped `starter.qmd` (which *is* in the root
`_quarto.yml` render list) writes the PDF under `_site/…`, while a brand-new doc renders **next to its
source**. A drifted participant who opened `starter.qmd` and then hunts for the PDF next to it won't
find it. This distinction lives only in lab prose, not the helper cue — worth a half-line so a TA can
answer it from the cue.

**6. Minor wording: Day-2 Your-turn-1 note calls the Part-2 fallback a "known-good starter project."**
`slides/quarto-projects/index.qmd:258`: *"The lab ships a known-good starter project so anyone behind
can open Part 2 clean."* The Part-2 fallback is actually `solution/` (a finished Part-1 site);
`starter/` is where they *do* the work. A helper skimming the cue might point a stuck participant at
`starter/` (unfinished) rather than `solution/`. Name `solution/` explicitly.

## ✅ What reassures me (helper's-eye clarity)

- **The two strand-you traps are over-documented in the right place.** The Day-2 cwd trap has a full
  paragraph (`labs/quarto-projects/index.qmd:42-48`), a slide aside (`slides/quarto-projects/index.qmd:94-97`),
  and troubleshooting bullets — as a TA I can resolve it in ten seconds.
- **Re-entry after the 1-hour gap is real, not a gesture.** Both Part-2 "Welcome back" notes
  (`slides/quarto/index.qmd:470`, `slides/quarto-projects/index.qmd:266`) give a one-line recap and
  refuse to re-teach; both labs' *Starting point* callouts (`labs/quarto/index.qmd:158-163`,
  `labs/quarto-projects/index.qmd:140-143`) point a drifted participant at a shipped known-good file.
  Someone who checked out during Part 1 can rejoin cleanly.
- **The citation beat's continuity is airtight.** `gorman2014` exists in `references.bib:6`; the
  starter's sentence "…collected at Palmer Station, Antarctica." (`starter.qmd:30-31`) matches the
  lab's insertion instruction (`labs/quarto/index.qmd:172-174`) word-for-word; the `author: "Your name"`
  line the task tells them to replace (`labs/quarto/index.qmd:184`) exists at `starter.qmd:4`. Nothing
  for a helper to reconcile.
- **The lab's "renders next to source" claim is correct — I tested it.** A fresh `.qmd` not in the root
  render list rendered to `labs/quarto/<name>.html` *next to its source*, while listed files go to
  `_site/`. The authors got a genuinely subtle Quarto behavior right; the Day-1 lab (`:200-201`) is
  accurate and I won't have to walk it back at a laptop.
- **Every hands-on Your-turn slide has a Helpers cue** naming a concrete, actionable trap — this cycle's
  addition lands. The freeze "visible tell" (`cat(format(Sys.time()))`) plus its cue
  (`slides/quarto-projects/index.qmd:362`, "the tell is the *second* render skipping the slow cell —
  point people at it") is a pass/fail I can literally point a finger at.
- **Live demos are sequenced so the presenter can't poison participant state.** The `execute:`/`echo:
  false` live demo (`slides/quarto/index.qmd:398-405`) sits *after* the "Eyes up — no need to type
  along" boundary (`:307`), so the presenter suppressing echo on the shared doc never propagates into a
  participant's followed-along file.

## 📝 Evolution since the previous review

- **The clone-step P1 from `review-2026-07-12-status-beginner.md` is fixed** and I did not re-encounter
  it: `setup.qmd:26-36` now carries a "Get the materials" block with the URL and `git clone`, ahead of
  the `renv::restore()` step that assumes it. As a helper, "did you clone the repo?" is now answerable
  from the setup page.
- **The Helpers: cues are new this cycle and are the right idea** — they turn the notes from a
  presenter-only script into something a roaming TA can act on. Every Your-turn slide has one. The gaps
  above are about *coverage* (a couple of follow-along beats and the two cues that point at the
  secondary trap), not about the concept, which is sound.
- **Already-solid before this cycle and still solid:** the cwd/nested-`_quarto.yml` trap handling, the
  glossing of scary vocabulary at first use, and the folded self-check solutions all held. Nothing that
  was fixed in prior cycles has regressed in the notes.

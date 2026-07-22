# Review 2026-07-08 — Dashboards DEMO (pedagogue)

**Reviewer:** workshop-reviewer-pedagogue (adult-learning / instructional-design lens)
**Reference commit:** `9abf90f` (2026-07-08)
**Scope (this cycle only):** the new Day-2 Dashboards DEMO —
`labs/quarto-projects/dashboard.qmd` (static `format: dashboard` penguins page) and the
"Demos — if time" bullet + `[See one]` link in `slides/quarto-projects/index.qmd`. Judged
only as a **post-payoff, cut-able watch-me DEMO**. Not re-litigating already-decided choices
(post-payoff placement, static/no-server, default plot fills, not-a-hands-on-exercise,
Shinylive/OJS as links).

---

## Overall verdict

Pedagogically ready as a demo — no blockers. The addition lands exactly at the intended
altitude: "here's a modern output you *could* make," not a teach-it beat. It sits **after** the
"What you can do now" wrap-up and after the sacred 30-min render payoff, and is structurally
**incapable of over-running** — one incremental bullet plus a link to a *prebuilt* page, no
dedicated slide, no live build. Layout coverage (2 rows with a 20/80 split, 2 valueboxes, a
card, a tabset) is rich enough to not look underwhelming yet small enough for a ~2-min flash in
the ~5-min tail, and the artifact renders clean. The only gaps are in-room-support polish
(presenter cue, link-target flow, artifact self-framing), all P2.

---

## 🔴 P0 — blocking for the event

None.

---

## 🟠 P1 — fix before the event

None.

---

## 🟡 P2 — nice-to-have

- **No `::: notes` on the "Demos — if time" slide** (`slides/quarto-projects/index.qmd:316`).
  The immediately-preceding Publishing slide carries presenter notes (`:293`), but the
  cut-able tail — the exact place where a tiring end-of-Day-2 presenter improvises — has none.
  A one-line cue would de-risk the flash: *which* four regions to name (rows / valueboxes /
  card / tabset), keep it **watch-me** (do not build live), and "cut this bullet first if under
  ~5 min left." Low stakes (Christophe authored it and knows Quarto cold), hence P2 — but it is
  the one in-room-support gap.

- **`[See one]` is a plain in-deck link** (`slides/quarto-projects/index.qmd:325`). Clicking it
  mid-presentation navigates the revealjs browser tab *away* from the deck; returning means
  browser-back, which can drop the presenter out of fullscreen / lose the slide position. For a
  watch-me flash, opening in a new tab (`[See one](...){target="_blank"}`) keeps the deck put
  and makes the demo a clean tab-toggle. Small flow friction, but it hits at the moment of
  live use.

- **The artifact frames itself as a teaching demo, not as the promised collaborator output**
  (`labs/quarto-projects/dashboard.qmd:2-3`: title "Penguins dashboard", subtitle "RaukR 2026 ·
  Day 2 — Dashboards demo"). The slide promises "share results with a **wet-lab collaborator**"
  (`:324`), but the page's own header reads as internal/meta. A collaborator-facing title
  (e.g. a survey-summary framing) would let the artifact *self-illustrate* the tie-in the moment
  it opens, rather than leaning entirely on the presenter's spoken bridge. Very minor altitude
  nit — a static dashboard is a layout, not prose, so this is genuinely optional.

---

## ✅ Pedagogical strengths confirmed

- **Correct running-order placement (rule 1).** The demo sits after "What you can do now"
  (`:303`) and after the sacred "Your turn" render payoff (`:296`) — timing pressure trims the
  tour, never the hands-on. The wrap-up mirroring the objectives comes *before* the cut-able
  segment, so the objectives-close survives a timing cut (matches `workshop-pacing.md` "put the
  wrap last so it survives an optional cut").

- **Genuinely cut-able and cannot compete for time.** It is one bullet inside a shared
  `::: {.incremental}` list of three demos (`:320-329`) — no dedicated slide, no code
  walkthrough, no live build. It structurally *cannot* balloon into a teach-it beat. This is the
  exact restraint the scope asked for.

- **Right altitude + correct "open prebuilt vs build live" call.** Opening a static prebuilt
  page is the right timing decision: building valueboxes + a tabset live would eat well past the
  ~5-min tail and invite mid-demo errors in front of a spent audience. Watch-me a finished
  artifact = "here's what's possible," which is all this slot should promise.

- **Layout coverage hits the target set without bloat.** Rows with an explicit 20%/80% height
  split (`:25,:47`), two valueboxes with distinct colors/icons (`:27-45`), a card (the boxplot
  column, `:49-57`), and a `.tabset` column pairing a scatter and a `kable` table (`:59-79`).
  This directly answers the topic-store risk (technique P2-5: "budget the layout model or it
  lands as an underwhelming single-plot page") — four distinct layout ideas, none over-taught.

- **Tie-in stated explicitly (rule 8).** "share results with a wet-lab collaborator" is on the
  bullet (`:324`), giving the "why do I care" hook for the new output.

- **Jargon glossed inline (rule 7).** "(static — no server)" on the link (`:325`) and the OJS /
  Shinylive parenthetical definitions (`:326-328`) leave no undefined term in the tail.

- **The artifact builds clean.** Renders to `_site/labs/quarto-projects/dashboard.html` with a
  committed freeze — the "here's what you could make" flash won't embarrass the presenter with a
  broken page. `fig-alt` present on both plots (`:53,:63`).

---

## 📝 Evolution since the previous review

This is a **net-new addition** — there is no prior dashboard-specific pedagogue review to diff
against. It cleanly discharges a risk the earlier triage already anticipated: `topic-store.md`
DEMO note + coverage audit flagged that Dashboards must "budget the layout model or it lands as
an underwhelming single-plot page" (technique P2-5, confirmed 2026-07-07) — the shipped artifact
answers that with four layout regions rather than a lone plot. The placement also honors the
2026-07-07 running-order rules already in the tree (rule 1 post-payoff, rule 8 tie-in, rule 7
gloss). Nothing regressed; the three P2s are additive polish, not fixes to prior work.

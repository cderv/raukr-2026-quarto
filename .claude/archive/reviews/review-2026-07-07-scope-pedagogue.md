# Scope review — Pedagogue lens — 2026-07-07

**Reference commit:** 715d3ec · **Cycle:** pre-content scope (programme / triage / pacing).
No slides or labs exist yet — the "material" reviewed here is the triage and pacing in
`topic-store.md`, `prior-art-inventory.md`, `project-context.md`, `workshop-pacing.md`.
This is the **first review** in the archive (no predecessor to diff against).

---

## Overall verdict

The scope thinking is genuinely strong and unusually self-aware for a pre-content stage: the
audience calibration ("skip what is a chunk", migration de-emphasized, citations promoted for a
manuscript-writing crowd) is right, and the four `~1h`-part arcs each have a real hands-on
payoff (HTML → Typst on Day 1; website → publish on Day 2). The blocking pedagogical risk is
**not direction but load**: the CORE+DEMO lists per part exceed what the committed ~2:1 ratio
can hold in ~55 effective minutes, and the one artifact that would expose this — the §
*Proposed time budget* — is entirely `_TODO_`, so the overload is currently invisible. Two
parts in particular (Day-1 Part 2 and Day-2 Part 2) are demo-heavy enough that the *payoff*
exercise (Typst; publish) risks being the thing that gets compressed — the worst possible place
to run out of clock. Fix that by doing a concrete minute-level budget *before* authoring and
demoting a few items from CORE/DEMO to protect the exercise. Two reuse traps (a
migration-first first exercise; a dataset switch at the Typst climax) should be caught now,
while it costs nothing.

---

## 🔴 P0 — blocking for the event

**None.** The event is a month out and no content is committed; nothing here blocks. The load
findings below are P1 because they should gate authoring, not because they block the event
today.

---

## 🟠 P1 — fix before the event (here: before authoring)

### P1-1 · The time budget is blank, and it is hiding a CORE overload
`topic-store.md:137-149` — every cell in § *Proposed time budget* is `_TODO_`. This is the
single most load-bearing pedagogy artifact and it is empty, so the per-part CORE lists have
never been checked against the clock. When you fill it, the ~2:1 commitment
(`workshop-pacing.md:19-26`) gives roughly **~18-20 min talk+demo + ~30-35 min hands-on** per
~55-min part. Against that ceiling:

- **Day-1 Part 2** (`topic-store.md:54-72`) asks the ~18-20 min demo window to carry Citations
  concept + Parameters demo + Shortcodes demo + Typst concept, while the ~30-35 min hands-on
  carries *two* "Your turn" exercises (Citations + Typst). Four demo topics in ~18 min ≈
  4-5 min each — and Typst, the emotional payoff and the single hardest genuinely-new thing,
  gets a sliver. **This is the clearest overload.**
- **Day-2 Part 2** (`topic-store.md:101-118`) pairs two CORE (Freeze/caching, Publishing —
  the freeze-vs-cache distinction is itself subtle, line 108) with *three* DEMO (Interactivity,
  Dashboards, `_brand.yml`). A part that must end with everyone publishing their site cannot
  also tour three demos first without eating the payoff.

**Action:** write the minute-level budget per part now, as the gating test for CORE. If a part
can't fit its list at 2:1, cut from the list, not from the exercise.

### P1-2 · Protect the payoff exercises by demoting the crowding items
Concretely, so the budget above closes:
- **Day-1 Part 2:** keep Citations + Typst as the two exercises; move **Parameters** and
  **Shortcodes** (`topic-store.md:70-71`) to "if time / resources", or fold Shortcodes into a
  single 3-min quick-win demo. Parameters is a *from-scratch* build (`prior-art-inventory.md:92`)
  with no reusable asset and only DEMO value — it is the first thing to drop, not the thing that
  squeezes Typst.
- **Day-2 Part 2:** move `_brand.yml` (`topic-store.md:118`) up into Day-2 **Part 1** — it is
  project *config/structure*, so it fits "build & structure a project" and lightens the ship
  part. Place **Dashboards** and **Interactivity** *after* the publish payoff so they can be cut
  live without amputating the climax.

Rule to encode: in each day, the second part's payoff exercise is sacred; DEMOs live *after* it
in the running order so timing pressure trims the tour, never the hands-on.

### P1-3 · Don't make the first Day-1 hands-on a *migration* exercise
`prior-art-inventory.md:121` recommends forking the penguins arc **Ex3 → Ex4 → Ex5**. Ex3 is
"Convert `.Rmd` → `.qmd` (hash-pipe, `convert_chunk_header()`)" (`prior-art-inventory.md:44,
line 3 of the catalogue`). But the framing explicitly de-emphasizes migration to a "quick
reassurance, not the spine" (`topic-store.md:33-35`, `78`). Opening the first "Your turn" on a
conversion task makes the audience's first independent activity the *least* new thing for them —
directly against the calibration. **Action:** start Day-1 hands-on at **Ex4 (authoring
value-adds)** — the "strongest single asset" per the inventory (`prior-art-inventory.md:45`) —
and demote conversion to a 2-min "if you have Rmd baggage, here's the move" demo.

### P1-4 · Don't switch datasets at the Typst climax
The Day-1 lab arc is the penguins progression, but the Typst finale is proposed to lift the
**Star Wars** Typst lab (`prior-art-inventory.md:51-57, 122-124`). Introducing a new dataset at
the payoff moment forces a context re-establish exactly when cognitive budget should go to the
*new* thing (Typst output), not to re-reading what the data is. Note the inventory also has a
**penguins** Typst demo (Ex5, `prior-art-inventory.md:46`). **Action:** keep one dataset
through the whole Day-1 arc — lift the Typst *technique* and `_brand.yml` styling from the Star
Wars lab, but re-skin it onto penguins so the climax changes only the output, not the subject.

### P1-5 · Name the capstone-transfer moment; it's currently implicit
The capstone hook is asserted once ("Feeds their capstone team project", `topic-store.md:37`)
but never placed in the programme. Adult learners commit when the transfer is explicit and
*timed to the relevant skill*. **Action:** designate concrete hook points —
- Day-2 **Publishing**: "this is how your team publishes the capstone" (strongest, most
  motivating; `topic-store.md:109`).
- Day-1 **Citations + Typst**: "this is your manuscript path" (`topic-store.md:62-63`).

Day 1 as a whole reads more "do the single document well" (feature-framed) than
"build toward your project"; it needs at least one explicit transfer callout so it isn't a
capability tour with a to-do implied but never stated.

### P1-6 · The inherited opening hook is reassurance-framed; reframe for "level up"
The through-line across the source decks is *"Quarto unifies + extends R Markdown, no new tech
to learn, rmarkdown not deprecated"* (`prior-art-inventory.md:24-25`). That is a **beginner-
reassurance** opening. This audience was told they're here to reach "a more advanced level"
(`project-context.md:22-23`); an opening that reassures "nothing new to learn" under-sells and
mis-sets the frame. **Action:** if `raukr-2025-quarto` is forked as the deck base
(`prior-art-inventory.md:117-119`), rewrite the first 2-3 slides from reassurance
("it's just Rmd+") to aspiration ("here's what you can now build that you couldn't before") —
Typst, brand-consistent sites, one-command publish. This is the reuse-pedagogy-fights-framing
risk the brief asked me to flag.

---

## 🟡 P2 — nice-to-have

- **Each part needs a fallback starter for the gap.** Day-X Part 2 building on Part 1's artifact
  is fine within one afternoon, but the between-parts gap will strand anyone who didn't finish.
  `workshop-pacing.md:34-36` mandates progressive-with-fallback; make it explicit that each Part
  2 ships a known-good starting artifact so the gap can't break the arc. (Scope-level note,
  cheap to bake into the structure now.)
- **"Document types" may be a DEMO, not a CORE.** In Day-1 Part 1 (`topic-store.md:61`) it's the
  fourth CORE alongside Markdown, Layouts, and the What-is-Quarto hook. As "1 source → many
  formats" it's a natural *show*, not a *do*; consider DEMO so Part 1's single exercise
  (author + land HTML with layout) keeps its air.
- **Commit each part to learner-framed objectives + a "what you can do now" close.**
  `workshop-pacing.md:59-64` states the principle; the budget reserves 5 min recap
  (`topic-store.md:147`) but there's no whole-day wrap. Encode: each of the 4 parts opens with
  "by the end you'll be able to…" and closes mirroring it; each day ends with a terminal
  wrap-up that survives if a segment is cut.
- **Citations exercise scaffolding.** It's a fresh build (`prior-art-inventory.md:69, 93-94`)
  and multi-part (`.bib` + `@ref` + CSL). Keep the load on citation *syntax*: ship the `.bib`
  pre-populated so nobody spends "Your turn" hand-authoring bibliography entries.

---

## ✅ Pedagogical strengths confirmed

- **Audience calibration is applied consistently.** "Skip what is a chunk" is honored end to
  end: Execution options → DEMO "show deltas" (`topic-store.md:69`), deep chunk tour → STORE
  (`topic-store.md:86`), migration de-emphasized (`topic-store.md:33-35, 78`). No over-teaching
  of basics in the triage itself.
- **Every part reaches a hands-on payoff and none ends mid-thought at the design level.** HTML
  (D1P1) → Typst (D1P2) → website (D2P1) → publish (D2P2). The two payoff *placements* —
  Typst as Day-1 climax, live publish as Day-2 climax — are pedagogically sound: both are
  visible, shareable, high-motivation endpoints.
- **The scope artifact is honest about its own gaps** (Citations weak, Parameters/Dashboards/
  Interactivity to build fresh — `prior-art-inventory.md:90-97`) and about which reused assets
  carry beginner debt (`prior-art-inventory.md:99-114`). That candor is exactly what prevents a
  feature-tour drift.
- **"Slots are upper limits, land fewer things well"** is stated repeatedly
  (`topic-store.md:13-14, 139`, `project-context.md:18-19`) — the right instinct; the P1s above
  are about making the triage actually obey it.
- **The My/Our/Your-turn spine and ~2:1 ratio are already the committed reference**
  (`workshop-pacing.md`, `project-context.md:103-104`), and the richest reusable source
  (`typst-2026`) already teaches in that rhythm (`prior-art-inventory.md:34-35`).

---

## 📝 Evolution since the previous review

First pedagogue review — no predecessor to diff. Baseline recorded: **direction is sound,
calibration is right, payoffs are well placed; the open risk is load, and the missing minute-
budget is what hides it.** The next review should check (1) that § *Proposed time budget* is
filled per part and passes the 2:1 test, (2) that Day-1 Part 2 and Day-2 Part 2 shed the
crowding DEMOs so the payoff exercises survive, and (3) that the migration-first first-exercise
and the Typst dataset-switch were caught before authoring.

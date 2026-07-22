# Beginner review — Day-2 deck "Quarto projects" (WP3)

- **Date:** 2026-07-08
- **Reviewer:** workshop-reviewer-beginner (fictional participant — experienced R user, did Day 1, brand-new to Quarto *projects*)
- **Target:** `slides/quarto-projects/index.qmd` (revealjs) + paired lab `labs/quarto-projects/index.qmd`
- **Branch/state:** `claude/goal-command-wx5go6`, working tree, uncommitted
- **Out of scope (not re-flagged):** Day-1 deck, scope/triage decisions, missing logos (known TODO)

---

## Overall verdict

As a walk-through of the *concepts*, this deck is genuinely good: the hard vocabulary (`output-dir`, listings, freeze, OJS) is glossed on first use, precedence is spelled out without jargon, and the freeze-vs-renv and website-vs-book distinctions are motivated, not asserted. I could follow every slide with the presenter in the room. The **one thing that would sink my afternoon is the lab both "Your turn" slides send me to — it is a pure skeleton of TODOs**, so the ~60 min of hands-on has nowhere to land as of today. Two smaller things would quietly mislead me *after* the room empties: `freeze: true` is taught as the default with a payoff ("the code didn't run") that will bite me when I edit *code* and nothing updates, and "CI" is used a full part before it's defined. Fix the lab and the `freeze` framing and this is a strong session.

---

## 🔴 P0 — blocking for the event

### P0-1 — Both "Your turn" slides route to an empty lab; the hands-on cannot start
`slides/quarto-projects/index.qmd:195-200` and `:279-284` send me to the Lab:

> "Head to the **[Lab](../../labs/quarto-projects/index.qmd)**: turn a set of `.qmd` into a navigable, **branded website**…"

But `labs/quarto-projects/index.qmd` is entirely placeholder:

> `labs/quarto-projects/index.qmd:20-25` — "## Website Challenge … TODO — task description (state the target artifact)."
> `labs/quarto-projects/index.qmd:37-42` — "## Ship it Challenge … TODO — task description".

There is no task, no starter `.qmd` set, no packages list (`labs/…:13` "TODO: state the required packages"). The deck's own speaker note **promises a starter that doesn't exist yet**:

> `slides/quarto-projects/index.qmd:204` — "The lab ships a known-good starter project so anyone behind can open Part 2 clean."

For this audience, hands-on is ~60–70 min of the slot. If the lab isn't filled by 11 Aug, the two "Your turn" transitions collapse into 40 laptops staring at "TODO". This is clearly work-in-progress (TODO markers everywhere), but it is the single blocking gap for running the day, so it goes here rather than being silently assumed known.

---

## 🟠 P1 — fix before the event

### P1-1 — `freeze: true` taught as the default; the celebrated payoff is a silent trap for edited *code*
`slides/quarto-projects/index.qmd:224-230`:

> `freeze: true        # never re-execute at project render; use committed _freeze/`
> "render → edit prose → re-render → **the code didn't run.**"

The teach is "edit *prose*", but `freeze: true` also won't re-run when I edit the **code** — I'll change my analysis, re-render, see the old figure, and lose 20 minutes hunting a bug that isn't there. The sane default that most real projects want is **`freeze: auto`** (re-execute only when the source chunk changes), which is never mentioned. From a beginner's "what do I put in my own `_quarto.yml`" standpoint, `true` is the surprising choice and `auto` is the one I'd want — please show `auto` as the default and frame `true` as the "hard-freeze / never run" variant, or at minimum add one line naming `auto`.

### P1-2 — "CI" used a whole part before it's defined
First appearance `slides/quarto-projects/index.qmd:219`:

> "It's what lets **CI render the site without R at all**."

The gloss only lands later, on the Publishing slide `:265-266`:

> "**GitHub Actions** (**CI** — a build that runs on every push)".

On the Freeze slide (Part 2's opener) "CI" is an undefined acronym doing load-bearing work ("without R at all" is the whole punchline). Revising from the freeze slide alone, I can't cash the claim. Move or duplicate the one-line gloss to line 219.

### P1-3 — Cross-ref callout hedge undercuts the one clear rule
`slides/quarto-projects/index.qmd:150-153`. The main text is admirably clear — websites don't auto-number across pages, books do. Then the callout ends:

> "A **website** keeps per-page numbering. **(Verify on your Quarto build before relying on it live.)**"

For a beginner this hedge reads as "…so maybe it *does* sometimes work across pages?" It turns a clean either/or (book = global numbering, website = per-page) into something I now distrust. If the presenter needs a private reminder to test it live, put it in `::: notes`, not on the slide. Drop the parenthetical or say concretely *what* to verify.

---

## 🟡 P2 — nice-to-have

### P2-1 — `theme_brand_ggplot2()` example won't run as typed
`slides/quarto-projects/index.qmd:179-184` shows `library(ggplot2)` then `theme_brand_ggplot2()`, but there is no `library()` for the brand package and no install on the slide — the `install.packages("brand.yml")` note lives only in `::: notes` (`:191`). If I type this along or copy it while revising, I get "could not find function `theme_brand_ggplot2`". One visible setup line (or a "needs the brand.yml package — see lab" aside) would close it.

### P2-2 — renv slide assumes renv is already initialized
`slides/quarto-projects/index.qmd:242-245` shows `renv::snapshot()` / `renv::restore()` as the two verbs. In *my own* fresh project those error/prompt until `renv::init()` has run once. For "redo this at home", a half-line noting the one-time init would save a confusing first attempt.

### P2-3 — `sidebar: contents: auto` — "auto" not explained
`slides/quarto-projects/index.qmd:111-112`. The navbar items are explicit and clear; `contents: auto` is magic I can't picture (what does it list, in what order?). One phrase — "auto = build the sidebar from the files in the folder" — would match the care taken elsewhere.

### P2-4 — Shinylive named but not glossed (OJS and htmlwidget are)
`slides/quarto-projects/index.qmd:308-309`. "htmlwidget" gets "pure R and self-contained" and "OJS" gets "(Observable JS — a browser-side, non-R path)", but "**Shinylive**" arrives bare next to them. It's a cut-able demo tail, so minor, but the asymmetry stands out precisely because the other two are handled so well.

---

## ✅ What reassures me (beginner's-eye clarity)

- **`output-dir` glossed inline the moment it appears** — `:68` "the folder the built site lands in (`_site` by default); publish *that*." No faith required.
- **Precedence stated in plain words, no "front matter" jargon** — `:92` "**document header** > `_metadata.yml` > `_quarto.yml`. Set defaults wide, override narrow."
- **Listings and OJS glossed on first mention** — `:132`, `:309`.
- **cache-vs-freeze contrast is motivated, not asserted** — `:213-220` opens with the real pain ("re-run a 20-minute alignment") and calls them "two tools, one letter apart". That framing sticks.
- **Publishing honestly de-risked** — `:268-272` explicitly makes `quarto publish gh-pages` a watch-me demo, keeping the GitHub-auth/wifi cliff off my hands-on path. Exactly the call I'd want.
- **The book question is answered before I ask it** — `:150-152` "Project-wide numbering is a *book*"; I'd have wondered "why can't I get Figure 3.2 across pages?" and here's the reason.
- **Bookended objectives** — `## Learning Outcomes` (`:28`) ↔ "What you can do now" (`:286`), both tied to the capstone; I know what I was promised and can check it off.
- **Deck ↔ lab vocabulary aligns** — Part-1 Your-turn → "Website" work, Part-2 → "Ship it"; the slide words match the lab's `## Website Challenge` / `## Ship it Challenge` headings (once the lab is filled).

---

## 📝 Evolution since the previous review

No prior beginner review of this deck exists (WP3 is newly authored), so this is a baseline. What is already strong from the start: the disciplined gloss-on-first-use habit, the motivated freeze/renv split, and the honest watch-me framing of publishing — all of which spared me the "take it on faith" moments that usually trip a projects-newcomer.

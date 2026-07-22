# NBIS RaukR 2026 Quarto material — reuse assessment (pedagogue lens)

**Date:** 2026-07-07
**Reviewer:** workshop-reviewer-pedagogue (repurposed: reuse triage, not our-material review)
**Sources assessed** (throwaway clone of `NBISweden/raukr-2026`, `main`):
- `slides/quarto/index.qmd` (879 lines — deck, the prior instructor, *"Literate programming with Quarto"*)
- `labs/quarto/index.qmd` (759 — general lab)
- `labs/quarto-site/index.qmd` (593 — website lab)

**Yardstick:** `topic-store.md` (triage + running-order rules + time budget), `project-context.md`
(advanced life-science audience, 2×2×1h), `workshop-pacing.md` (My/Our/Your, ~2:1 hands-on).

**Severity = reuse verdict:** 🔴 don't inherit (wrong for our audience) · 🟠 reuse only after
reframing · 🟡 minor · ✅ adopt as-is (good pedagogy).

---

## Overall verdict

This is a a reference tour rather than a hands-on workshop — pitched at a first-contact beginner and
built as a topic-by-topic catalogue rather than a My/Our/Your-turn arc with hands-on payoffs. For
our "level-up" crowd, roughly the first half of both the deck and the general lab is
insulting-or-boring basics (what is YAML, what is bold, what is a chunk, the Render button, an
RMarkdown detour). There is **no learner objective, no wrap-up mirroring objectives, no progressive
exercise chain, and a badly inverted hands-on ratio** (the general lab runs ~590 reference lines
before its first task). But three assets are genuinely good and worth lifting: the **parameterized
`iris`-report scaffold** (real artifact, re-skins cleanly to penguins), the lab's **Troubleshooting
callout**, and the **website-build arc + curated example gallery** in `quarto-site`. Take the
scaffolds, leave the spine and the framing.

Counts: 🔴 6 · 🟠 6 · 🟡 3 · ✅ 6

---

## 🔴 Don't inherit — wrong for our audience

**1. The deck has no arc, no objectives, no payoff — it's a flat catalogue.**
`slides/quarto/index.qmd` marches installation → notebook → PDF → presentation → anatomy → YAML →
markdown → RMarkdown → rendering → parameters → projects → interactive → publish → terminal →
extending. There is no "by the end you'll be able to…", no My/Our/Your rhythm, no timed exercise, no
"what you can do now" wrap-up (the close is only *Thank you!/Questions?*, `index.qmd:821-833`). It
also shows **outputs (PDF `:132`, Presentation `:165`) before the audience has seen what a document
even is (anatomy `:174`)** — arc inverted. Don't inherit the spine; our topic-store already replaces
it with an aspiration-first, payoff-anchored structure.

**2. The YAML-as-a-language slide is pure beginner tutoring.** `index.qmd:236-318` teaches "Yet
Another Markup Language", 2-space indentation, strings, multiline literal/folded, arrays, dictionary
arrays. This is a config-syntax primer for people who already write `_targets.R` and package
DESCRIPTION files. Cut entirely; gloss YAML in one line if at all.

**3. Basic-Markdown and chunk-option teaching.** Deck `index.qmd:398-475` (headings, italic, bold,
strikethrough) and `:500-523` (`eval`/`echo`/`warning`/`message` explained from zero); lab
`labs/quarto/index.qmd:148-196` (italic/bold/blockquote) and `:252-363` (what a chunk is, the
options table). topic-store is explicit: *"skip what-is-a-code-chunk"*. Teach Markdown/execution as
**deltas**, fast. Don't inherit the from-zero versions.

**4. RMarkdown detour + Render-button-first framing.** Deck `index.qmd:477-498` ("RMarkdown = Markdown
+ embedded R chunks") and the Rendering slide leading with *"Interactively using the Render button"*
(`:525-533`); lab mirrors it (`labs/quarto/index.qmd:437` — "clicking the 'Render' button"). Wrong
frame twice over: topic-store teaches **native `.qmd` from the start** and treats Rmd as a 2-min
reassurance, and our audience drives from the terminal/CLI, not a GUI button. Leave behind.

**5. The Rmd-comparison dump closes the deck on the wrong note.** `index.qmd:835-853` ("Compared to
Rmd") and `:855-879` (the `html_document`→`html` output-formats table). topic-store marks *"Rmd
legacy comparison dump → STORE"*. Ending a level-up deck on "here's how it maps to the thing you're
leaving" is exactly the reassurance frame we're rejecting (running-order rule 5). Keep at most the
`toc_depth`→`toc-depth` hyphen note as a one-liner.

**6. Website lab opens on a GitHub/SSH cliff.** `labs/quarto-site/index.qmd:22-42` makes step one
"create a GitHub repo, clone via SSH" — *before any Quarto*. This is precisely the beginner-panel P0
in topic-store (live GitHub auth for ~40 people on conference wifi = room-killer) and it front-loads
the riskiest plumbing ahead of the actual learning target. Don't inherit the ordering: publishing is
a **watch-me demo at the end**, and the hands-on opens from a shipped starter, not `git clone`.

---

## 🟠 Reuse only after reframing

**1. Deck opening: reassurance → aspiration.** `index.qmd:8-92` introduces Quarto as a bulleted
feature list ("command-line tool… supports many IDEs… numerous output formats"). Bones fine, frame
wrong for "level up". Rewrite the first 2-3 slides to *"here's what you can now build"* — branded
Typst PDF, cite-able manuscript, one-command site (running-order rule 5, topic-store).

**2. The parameterized-report scaffold — lift the bones, move the topic.**
`labs/quarto/index.qmd:471-590` is the **strongest single asset**: recreate a real report (live
iframe preview `:476-479`), dynamic param'd title/captions, species **photos** keyed by param
(`:555-569`), a Tasks callout (`:592-599`). Genuinely good hands-on shape. Two reframes: (a)
topic-store **demotes Parameters to Day-2 MENTION**, so use this scaffold for the *authoring/layout*
payoff and treat the `-P` override as a Day-2 aside; (b) re-skin `iris`→penguins (see 🔴/✅ on iris)
— note penguins also has 3 species with photos, so the "photo per species" trick transfers 1:1.

**3. Website-build arc — reorder and re-frame from "personal blog" to "capstone/lab site".** The
`quarto-site` spine (project → settings → about → blog → listing → home → styling → freeze → publish)
is a coherent progressive build (rare in this material). But it's framed as Jane Doe's personal blog
(hiking, recipes, `index.qmd:144-147`) and puts Git/publish first. Reframe to the **team capstone /
lab site** (topic-store running-order rule 6, "name the capstone transfer"), and move publishing to
the end as watch-me.

**4. Styling: lead with `_brand.yml`, not Bootswatch.** `labs/quarto-site/index.qmd:397-408`
teaches Bootswatch first, `_brand.yml` second (`:413-433`) and calls it "relatively recent". Our
story makes `_brand.yml` the spine (one file → site+slides+plots) and Bootswatch a footnote
(topic-store: *"Deep Bootswatch theming → STORE, superseded by `_brand.yml`"*). Invert the order and
the emphasis. The `_brand.yml` snippet itself is a usable starting point.

**5. Freeze section — good motivation, needs the 2-render scenario made explicit.**
`labs/quarto-site/index.qmd:443-454` leads with the right motivation ("avoid running code that takes
a long time") and does hint the demonstration ("rerun `quarto render`, notice chunks not executed").
That matches topic-store's *"value only shows across 2 renders"* framing — but tighten it into the
crisp `cache` vs `freeze` contrast and the "CI renders without R" payoff we committed to (technique
P2-1, beginner P1-4). Reusable bones.

**6. The "How it all works" engine diagram — reframe, don't re-teach.**
`index.qmd:543-562` mermaid (input → knitr/jupyter/markdown engine → pandoc → outputs) is a good
mental model, but it's dated (`.rnw`, Confluence, `.rmd` co-equal with `.qmd`) and it's shown as a
passive "how it works" slide. Keep the engines→pandoc→many-outputs idea as the **hook** ("one source,
many outputs"), drop the legacy branches.

---

## 🟡 Minor

**1. Literate-programming / Knuth history.** `index.qmd:76-92` speaker notes are a rich Knuth
digression. Fine as presenter background, but don't spend live minutes on 1984 history with a
level-up room — one sentence max on slide.

**2. "Rendering a page" as a setup-check.** `labs/quarto-site/index.qmd:44-53` (render blank
`index`, add `Sys.Date()` chunk to confirm R works) is reasonable but belongs in a **pre-workshop
install mini-test** (workshop-pacing), not live class time.

**3. Session `<details>` block + Tasks callout are house idioms already captured.** Lab
`labs/quarto/index.qmd:748-759` and `:592-599` — already documented in project-context § Content
patterns; nothing new to extract, just consistency confirmed.

---

## ✅ Adopt as-is (good pedagogy)

**1. The Troubleshooting callout.** `labs/quarto/index.qmd:603-611` anticipates the five most common
render failures (YAML indentation, missing package, image path, `tbl-`/`fig-` label, PDF/TeX) and
tells the learner how to self-correct. This is exactly the **autonomy / self-correction** support our
model wants for a roaming-TA room. Adopt the pattern verbatim (re-target per exercise).

**2. The Tasks callout pattern.** `labs/quarto/index.qmd:592-599` (`{{< fa clipboard-list >}}
**Tasks**`) is a clean, scannable "Your turn" marker — good seed for our mode-marker convention.

**3. Parameterized-report scaffold structure.** (Also under 🟠-2.) As a *hands-on artifact design* —
real preview + dynamic captions + per-value photo — it's the best exercise shape in the set. Adopt
the shape, change the topic-placement and the dataset.

**4. Website progressive-build arc.** `quarto-site` genuinely builds page-on-page (about → blog →
listing → home) — the progressive-exercise property our other material lacks. Adopt the sequence.

**5. Curated example-website gallery.** `labs/quarto-site/index.qmd:515-585` (Simple/Intermediate/
Advanced tiers, many real Quarto sites incl. Bioconductor blog `:544`). Excellent "what to explore
next" resource — drop onto our Day-2 resources page largely as-is.

**6. "Learning more" pointers.** `labs/quarto-site/index.qmd:587-593` (Quarto for Scientists,
Çetinkaya-Rundel's quarto-jsm24) — good curated close.

---

## 📝 On the `iris` dataset (asked specifically)

**Pedagogically, `iris` hurts more than it helps for this room — replace with penguins/life-science,
but the NBIS scaffolds re-skin trivially.** iris is (a) tiny and overexposed — for an audience that
does bioinformatics daily it signals "toy tutorial", undercutting the level-up frame; (b)
non-life-science (flower morphometrics), so **transfer to their actual work is weaker** than a
dataset that looks like assay/sample data; (c) it carries the well-known Fisher/eugenics provenance
baggage that a life-science summer school may not want centered. It's used pervasively — deck
`:189-197, :329-359, :660-664, :691-733`; lab `:276-284, :370-428, :471-590`; site lab `:250-268`.

The good news for reuse: the two scaffolds worth lifting map onto penguins with **no structural
change** — penguins also has 3 species (Adelie/Chinstrap/Gentoo) with photos, so the
per-species-photo parameterized report (`labs/quarto/index.qmd:555-569`) and the ggplot examples
transfer 1:1. This is exactly topic-store running-order rule 3 ("one dataset through the Day-1 arc…
re-skin onto penguins — the climax changes the output, not the subject"). Verdict: **change the
subject, keep the scaffolds.**

---

## What to leave behind entirely (summary)

- YAML-as-a-language slide (`slides:236-318`)
- From-zero Markdown + chunk-option teaching (`slides:398-475, :500-523`; `lab:148-196, :252-363`)
- RMarkdown detour + Render-button-first (`slides:477-533`; `lab:437`)
- Rmd-comparison/output-formats dump (`slides:835-879`)
- GitHub/SSH-first opening of the website lab (`site:22-42`)
- The general lab's ~590-line reference runway before its first task — its read-along structure is
  the opposite of "starter files, short timed exercises". Take the Report/Troubleshooting islands,
  discard the walkthrough scaffolding around them.

---

## Cross-cutting pedagogical gaps (present in all three files)

Named once so they aren't re-flagged per file:
- **No learner-framed objectives** ("By the end you'll be able to…") anywhere.
- **No wrap-up mirroring objectives** ("what you can do now").
- **No My/Our/Your-turn rhythm, no timed exercises** — everything is My-turn slides or read-along
  reference; the labs are reference documents, not focused independent exercises.
- **Inverted hands-on ratio** — far from the ~2:1 our pacing model targets.
- **Exercises don't build on each other** in the general lab (the one Tasks box is isolated);
  `quarto-site` is the exception (genuinely progressive).

These are not "fix the NBIS files" items — they're the reason our topic-store rebuilds the spine
rather than inheriting it. The reuse call stands: **lift the scaffolds and the gallery, rebuild the
arc.**

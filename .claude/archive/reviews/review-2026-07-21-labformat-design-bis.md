# Lab format — information-design re-review (`-bis`): icons on the table

**Date:** 2026-07-21
**Lens:** same as the first pass — how the page *reads* (mass, color/weight semantics, emphasis economy, TOC) — re-run with one new fact.
**New fact:** the **fontawesome** Quarto extension is available and portable (committed in `NBISweden/raukr-2026` at `_extensions/quarto-ext/fontawesome/` v1.2.0; `quarto add quarto-ext/fontawesome` vendors it here). So `{{< fa … >}}` in a callout **title** or an asset link is now a real option that renders in our standalone build *and* folds natively into the NBIS site (which already uses `{{< fa clipboard-list >}} Tasks`, `{{< fa download >}}`).
**Prior review:** `review-2026-07-21-labformat-design.md` — headline: keep the "Challenge" callout spine but *thin the palette* (demote "You should see", promote Troubleshooting to an H2, rescue inverted emphasis).
**Files re-read:** OURS `labs/quarto/index.qmd`, `labs/quarto-projects/index.qmd`; NBIS `labs/quarto/index.qmd` (l.592 `{{< fa clipboard-list >}} Tasks`), `labs/quarto-site/index.qmd` (download-button idiom, l.153/213/303/340).

---

## Delta vs the first review — the one-line answer

**Icons do not change the verdict; they change the implementation of the *demotion*.** The core diagnosis stands: the labs' scanning problem is **visual mass / weight**, not **box identity** — and an icon is an *identity* device, not a *weight* device. So icons cannot license "keep more boxes." What they **do** change: they make the thinning **lossless**. They resolve the single open choice the first review left dangling (demote "You should see" to `appearance="simple"` *or* to a plain `>` blockquote) decisively in favor of **icon'd `appearance="simple"`** — because the icon carries the "expected-output checkpoint" semantic that a bare blockquote throws away when you strip the fill.

Point by point against the prior recommendation:

| Prior rec | Does fontawesome change it? |
|---|---|
| 1. Keep **Tasks** as the one full blue box | **Stands, enhanced.** Add `{{< fa clipboard-list >}}` to its title — matches NBIS, marks the action. |
| 2. **Demote "You should see"** to a lighter device | **Stands. Choice resolved:** `appearance="simple"` **with a `{{< fa circle-check >}}` icon**, *not* a bare blockquote. The icon is now the reason the demotion loses no meaning. |
| 3. Break the day-2 **double-box open** (Scope + Starting point) | **Stands unchanged.** Icons don't touch mass; still open on baseline prose, still demote "Starting point" to simple. Icon can ride the demoted box. |
| 4. Promote **Troubleshooting to `## H2`** for the TOC | **Stands.** Orthogonal to icons (a navigation fix). Optional `{{< fa wrench >}}` in the body — but **keep the H2 heading text plain** (an icon in an `##` renders *into the TOC entry* on the right rail; that's noise in the exact place we're trying to make navigable). |
| 5. **Rescue** "*a reference, not a checklist*" from skippable prose | **Stands unchanged.** A prose-emphasis problem; icons are irrelevant to it. |

Nothing in the prior review is *reversed*. One item (§2) is *sharpened*, two (§1, §4) gain an optional enhancement, two (§3, §5) are untouched.

## Why icons can't rescue the box — the mass-vs-identity split

The twin-blue-box complaint (`quarto/index.qmd:52-87`, `quarto-projects/index.qmd:57-109`) had **two** causes, and an icon addresses only the weaker one:

- **Cause A — weight/mass (the dominant one):** two solid-blue fills stacked read as *one heavy block*; the eye's "this is a wall of emphasis" reaction is preattentive and fires on **fill**, before it ever resolves the small glyph in the title. An icon is drawn once, top-left, at ~1em — it **relabels** the two boxes, it does not **lighten** them. Put a clipboard on box one and a check on box two and you still have two heavy blue blocks. Cause A is untouched.
- **Cause B — kind-collision (the weaker one):** Tasks (do-this) and "You should see" (check-this) are different *categories* wearing the same blue. Here the icon genuinely helps: clipboard ≠ check is a real category signal. But B was never the reason a bench reader's eye glazes; A was.

So icons fix the symptom that mattered least and leave the one that mattered most. That is the whole case for why "icons let us keep the box" fails.

## Where icons genuinely earn their place — on the *lightened* device

The inverse is the real insight. When you **remove the fill** from "You should see" (the §2 demotion), a plain `>` blockquote loses the thing the fill was doing: signaling "this is the expected-output checkpoint, a distinct kind." A `::: {.callout-note appearance="simple"}` with `{{< fa circle-check >}}` in the title keeps that signal alive with **no added weight** — icon + left-rule, no box. Now three channels agree, exactly the "color and interaction agree" pattern the first review praised for the gold-collapse hints:

- **weight** — heavy (Tasks) vs light (You should see): the mass fix
- **icon** — clipboard vs check: the kind fix
- **position** — still right after Tasks: the workflow fix

That's a *stronger* differentiation than the prior review's blockquote fallback, and it's strictly downstream of thinning, not a substitute for it. **Icons are the tool that makes "fewer/lighter boxes" safe to execute** — they are how you shed weight without shedding meaning.

## Color-blind a11y — a genuine, if narrow, win

Real win, honestly scoped. Our cross-hue distinction (blue `note` vs gold `tip`) is already among the CVD-safer pairs, so icons add little *there*. The win is **within-hue**: Tasks and "You should see" are **both blue** — no color channel distinguishes them for *anyone*, CVD or not. An icon is a non-color channel that separates them regardless of vision. So the a11y argument is real but it argues for icons **exactly where two same-colored callouts sit together**, not for icons everywhere.

## Thin the *icon* palette too — the saturation trap

The first review's whole thesis — emphasis inflation means nothing is emphasized — applies to the icon channel verbatim. An icon on all ~10 callouts/page recreates the twin-blue problem one layer up: uniform glyphs stop distinguishing. Icons earn their keep as a **type-marker vocabulary** (one fixed glyph per callout *type*, used consistently → a learnable legend), and lose it as **per-instance decoration**. The discipline: a type gets a glyph **only if it has a confusion partner or a functional affordance.** Orientation boxes that appear once with no twin (Scope, Starting point) don't need one.

## Recommended icon scheme

**Gets an icon (meaning-bearing):**

| Callout | Glyph | Rendered as | Why |
|---|---|---|---|
| **Tasks** | `clipboard-list` | full blue `note`, `## {{< fa clipboard-list >}} Tasks` | the action; **matches NBIS** for fold-in |
| **You should see** | `circle-check` | **`appearance="simple"`** (demoted), `{{< fa circle-check >}}` in title | checkpoint semantic that the lost fill used to carry |
| **Hint** | `lightbulb` | gold `tip` + `collapse="true"` (unchanged) | universal hint glyph; agrees with the collapse affordance |
| **Troubleshooting** | `wrench` | in the **body** only, H2 text left plain | fix-it marker; keep it out of the H2 so the TOC entry stays clean |

**No icon (restraint — avoid saturation):** **Scope**, **Starting point**, and the **"Coming from R Markdown?"** aside — each appears once, has no confusion partner, and orienting boxes read fine plain. (If you want *one* orientation glyph, `bullseye` on Scope is defensible; default is none.)

**Asset links — adopt the affordance, honestly scoped.** NBIS's `{{< fa download >}}` on `btn-primary` buttons is a clear affordance win *for genuine downloads* (their `.webp` assets). Ours are **mixed**: `starter.qmd`/`penguins-report.qmd` open a source or a rendered page (navigation, not download), while `sample-typst.qmd` "opens the rendered PDF" (a real grab). Use `{{< fa file-pdf >}}` (or `arrow-up-right-from-square`) for the PDF-open link and reserve `{{< fa download >}}` for anything that's actually a file to save — don't slap `download` on links that just navigate, or the icon lies about the affordance.

**NBIS fold-in:** matching `clipboard-list` for Tasks is the one high-value alignment — NBIS has already established clipboard = Tasks, so sharing it means a participant flipping between our lab and the NBIS site meets the same marker, and if our page is ever embedded there the action-marker is identical. Low cost, real consistency payoff. The other glyphs needn't match NBIS (NBIS barely uses title icons beyond Tasks).

## Steelman both sides (as asked)

**"Icons let us keep more boxes."** Strongest form: a unique glyph gives each box an identity label, so the reader no longer leans on color alone; clipboard-vs-check *is* glanceable once learned; it adds a CVD-safe non-color channel; it matches NBIS; and the type-set is small and recurring, so the glyphs become a legend, not chrome. — **Why it still loses:** every one of those is an *identity/labeling* benefit. The lab's failure is *mass/rhythm* ("wall of boxes," "emphasis before a baseline"), a fill property the glyph doesn't touch. Relabeling two heavy blocks leaves two heavy blocks. It solves the wrong axis.

**"Icons are lipstick; the fix is still fewer/lighter boxes."** Strongest form: the disease is emphasis inflation; bolting a decorative channel onto every box inflates further; the real fixes (demote, open on prose, H2 Troubleshooting) are all weight/structure and icons touch none; and icon-on-everything just recreates twin-blue in the glyph channel. — **Where it's too harsh:** on a *demoted, fill-less* device the icon isn't decoration — it's the sole surviving carrier of the semantic the fill used to hold; strip the blue and a bare blockquote goes mute, an icon'd simple callout still speaks. Plus the download/PDF affordance is functional, not cosmetic. So icons aren't lipstick *when applied to the thinned device*; they're what keeps thinning from losing meaning.

**Synthesis:** both are right about different things. "Lipstick" wins the *strategy* (thin, don't add); "keep more boxes" contributes the *tool* (icons) that the winning strategy needs to execute cleanly. Icons ride *with* the palette-thinning, not against it.

## Revised recommendation

**Unchanged verdict: HYBRID — keep the boxes, thin the palette, restore the outline.** fontawesome does not move it. Execute the prior five steps as written, with three icon-era refinements:

1. **Tasks stays the one full blue box** — add `{{< fa clipboard-list >}}` (NBIS-matched).
2. **"You should see" is still demoted** — to `appearance="simple"` **with `{{< fa circle-check >}}`** (this is the resolution of the prior review's simple-vs-blockquote choice; pick the icon'd simple callout, *not* the blockquote — the icon is why the demotion loses nothing).
3. **Troubleshooting → `## H2`** as before; `{{< fa wrench >}}` optional in the **body**, **not** in the heading (keeps the TOC entry clean).
4. **Hint** unchanged (`lightbulb` + collapse); **Scope / Starting point / Rmd-aside get no icon**; **PDF/file links** get `file-pdf`/`download` per the affordance, honestly.
5. **Thin the icon palette** like the color palette: type-markers only, never per-instance decoration — four glyphs total across the lab, not one per callout.

**Net:** same as the prior review's net (one loud Tasks box + a light checkpoint + a collapsed gold hint + a real `## Troubleshooting` in the TOC), now with a four-glyph type vocabulary that adds a CVD-safe channel, aligns Tasks with NBIS, and — the actual reason to adopt icons — lets the "You should see" demotion shed weight **without** going semantically silent.

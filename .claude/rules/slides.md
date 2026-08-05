---
paths:
  - slides/**/*.qmd
---

# Rule — Quarto revealjs slide-authoring craft

Concrete patterns distilled from content-feedback rounds on the RaukR decks
(`slides/quarto/`, `slides/quarto-projects/`). The full house style lives in
`project-context.md § Content patterns`; this file is the short list of
technical gotchas that keep biting. When you **edit** a slide, apply these; when
you **review**, check for them.

## 1. Fit-check every changed slide — overflow is invisible in source

revealjs silently overflows the 720 px-tall frame: a slide with too much content
just clips, and you cannot see it in the `.qmd`. Layout bugs — the closing-slide
overlap, a too-dense slide — are only caught by looking. After changing a slide,
render and screenshot it headless at native deck size:

```
quarto render slides/quarto/index.qmd
node .claude/scripts/slide-shot.mjs <abs path to _site/…/index.html> <anchor-id> out.png
```

**`slide-shot.mjs` only runs in the web sandbox.** It imports Playwright from a hardcoded
`/opt/node22/…` path, so on a normal machine it dies with `ERR_MODULE_NOT_FOUND` before it opens
anything. Off-sandbox, use **`agent-browser`** (on the PATH; `npx agent-browser` also works) against a
locally served copy of the built site. `file://` is not worth fighting:

```sh
simple-http-server.exe --nocache -i -p 8899 _site      # from the repo root
agent-browser open "http://localhost:8899/slides/<deck>/index.html"
agent-browser wait --fn "window.Reveal && window.Reveal.isReady()"
# then pipe a heredoc to `agent-browser eval --stdin` that walks the anchors
agent-browser close
```

Two things that bite in that eval: it has **no top-level `await`**, so wrap the whole script in an
`(async () => { … })()` that returns the result, and `Reveal.slide(…)` needs a short settle before
you measure. Reveal reports slide geometry in **deck** coordinates (720), not viewport pixels, so the
window size does not matter and there is no need to resize anything.

**Force the fragments rather than stepping them.** `Reveal.nextFragment()` reports nothing left to
advance when a slide was already visited, which silently turns the fragment check into the initial
state (a false pass, see the second bullet below). Add the `visible` class to every `.fragment` on the
slide instead, then measure.

Navigate by **anchor id** (`## Title {#anchor}` → the helper opens `#/anchor`) —
robust, because raw slide indices drift as slides are added or moved. Use an
**absolute** `file://` path to the built HTML. The helper prints
`{scrollH, clientH}`: **pass = `scrollH === clientH`** (both 720 for a full
slide; equal-and-smaller for a `.center` slide). `scrollH > clientH` = overflow
→ split the slide or trim it. (Sandbox specifics: the helper imports the
preinstalled Playwright at `/opt/node22/…` and Chromium at `/opt/pw-browsers`.)

**`scrollH`/`clientH` is a *vertical* check — it passes falsely on two failures
you must eyeball the screenshot for:**

- **Horizontal clip inside a column.** A code block in a `::: {.column}` (or any
  narrow container) overflows *sideways* when a line is longer than the column —
  Quarto shows a scrollbar and the line's tail is unreadable, but both heights
  stay equal so the check reports pass. Keep code lines short enough for the
  column (drop long inline comments, shorten values), or give the block more
  width / go full-width. Watch the long trailing `# comment`.
- **Overlap that only appears once fragments are revealed.** Re-run with
  **`--all-fragments`**: an `::: {.incremental}` list or a `. . .` paragraph
  grows the body as it reveals and can collide with a bottom-anchored
  `::: aside` — invisible at the initial fragment state, and again a false pass
  because asides are absolutely positioned (they don't count toward `scrollH`).
  If a revealed body and an aside fight for the bottom, cut one (the relevance
  beat often already lives in `::: notes`).

## 2. `.center` slides: keep a footer line in normal flow, not in an `aside`

On a `{.center}` slide (opening/section/closing) an `::: aside` is positioned
relative to the slide and **overlaps** the vertically-centered body. Put a small
footer/contact line in a plain block instead, so it stays in **normal flow**.
Keep centered slides short so the block stays centered without overflowing.
(This is the fix for the closing-slide overlap.)

> **Corrected 2026-08-03 — `.smaller` on a div does nothing.** This section used
> to say "use `::: {.smaller}` … just smaller type". The normal-flow half is the
> real fix; the type half is false. Every `.smaller` rule in the built revealjs
> theme is scoped to the **slide or deck** (`.reveal .slides section.smaller`,
> `.reveal.smaller .slides section`), so a `<div class="smaller">` matches
> nothing and renders at full body size. Verified against
> `_site/site_libs/revealjs/dist/theme/quarto-*.css`. To shrink one line, use
> `[text]{style="font-size:0.5em"}`; to shrink a whole slide, `smaller: true`.

> **This is a `.center`-slide rule only.** On an ordinary slide `::: {.aside}` is
> correct and is what the decks use. Overlap there is a *sizing* problem, not an
> aside problem: an `.r-stretch` image expands into the aside's zone (asides are
> absolutely positioned, so they never count toward the `scrollH` check in § 1).
> Constrain the image (`{height="440px"}`) and keep the aside.

## 3. `code-line-numbers` for progressive reveal of one block

When a slide walks through the *parts* of a single code block (what the YAML
does, then the prose, then the executable cell), don't split it into separate
blocks — highlight it in steps:

````
```{.yaml code-line-numbers="|1-4|6|8-13"}
````

Leading `|` = the first step shows the whole block with **nothing** highlighted;
each `|`-separated group is the next reveal. Use it when the teaching point is
"here is each piece in turn". A plain block is fine when there's nothing to walk
through — don't add highlighting for its own sake.

## 4. `filename` to label a code block as a named file

When a block *is the contents of a specific file*, tag it so learners know where
it goes:

````
```{.yaml filename="_brand.yml"}
```{.bibtex filename="references.bib"}
````

Works on **non-executable** blocks too (filename tab in HTML; bold label in
other formats). Use it whenever the snippet maps to a real file on disk — it
answers the silent "…and where does this go?". **Don't** use it for a generic
fragment that isn't a whole file.

## 5. Show literal Quarto markup as a code block, not inline

Div / structural syntax mentioned in prose (`::: {#refs} :::`, fenced divs,
shortcodes) must be a fenced **code block**, never inline and never left as
actual markup. Written inline, `::: {#refs} :::` either renders as an empty div
or reads as prose; as a code block it is unambiguously the literal thing the
learner should type.

**Inline executable expressions are the exception — a code block is *not* enough.**
The portable house form is the **braced** `` `{r} expr` `` (preferred over the legacy
knitr `` `r expr` `` — quarto.org: it "works across all three engines"). Quarto expands
it **even inside a display code block** (```` ```markdown ````, ```` ```{.markdown} ````)
and even inside a double-backtick span — so those escapes do **not** show it literally,
they run it (you get the *number*). To show the literal syntax, escape with **double
braces**: `` `{{r}} nrow(x)` `` renders the literal `` `{r} nrow(x)` `` (the inline analog
of the ```` ```{{r}} ```` block escape). Caveat: all of this assumes the document has at
least one executable cell — in a markdown-engine (no-cell) document the braced form renders
literally and never executes. Rule of thumb: **single brace = executes** (use
where you want the value), **double brace = literal** (use where you're teaching the
syntax). Always render-and-look — the wrong one silently prints "342" where you meant to
show `` `{r} …` ``.

## 6. Consecutive code blocks need spacing — already in `theme.scss`

Two code blocks back-to-back collapse into one box (only a hairline between
them). `theme.scss` carries an `@each` adjacency rule that gives stacked blocks
`margin-top`, and it covers **all three** wrappers Quarto emits depending on
features: `div.sourceCode` (plain), `.code-copy-outer-scaffold`
(line-numbered / copy button), `.code-with-filename` (filename tab). So: just
stack the blocks — **don't** hand-insert `<br>`. And any new SCSS that targets
code blocks must cover all three wrappers, or it will silently miss the
line-numbered / filename variants.

## 7. Teaching a cell option? Show it with `#| echo: fenced`

When a slide's teaching point **is a cell option** (`#| label: tbl-`, `#| fig-cap:`,
`#| column: margin`, …) and you use a **live executable cell** to get the real
figure/table, the default echo betrays you: it shows the *source lines* but
**strips the `#|` options**, so the one line the slide is about never appears in
the rendered code. (This bit the Day-1 Tables slide — it taught "a `#| label: tbl-`
makes it referenceable" while showing code with no label in it.)

Fix: add **`#| echo: fenced`** to the cell. It renders the fenced delimiters +
the `#|` options + the code, *and still runs the cell* — so you get the visible
options **and** the live output. Quarto drops the `echo: fenced` line itself from
the display, so there's no meta-noise (you don't see the option that turned this
on). This is the tool when you want **both** the options and live output; the
plain **non-executable display block** (```` {.markdown} ````/```` {.r} ```` with
escaped `` `{{r}}` ``, §5) also shows options but produces **no** output — use
that when there's nothing to run.

**Constraint — fenced grows the block both ways, so fit-check (§1):**

- **Vertical:** every option becomes a line. Fine on a minimal cell (Tables:
  2 options + 3 short lines fits 720/720).
- **Horizontal (the sneaky one):** an option *value* can be long — a full
  `fig-alt` sentence, an `!expr` caption — and clips sideways in a narrow
  container, a false pass on the height check. The Figures slide is the
  cautionary case: 6 options incl. a long `fig-alt`, in a half-width
  `output-location: column`. **Prefer fenced on the *minimal* demo cell**
  (Tables) and budget for a rewrap on the busy one.

> **Updated 2026-08-05 — "left plain on purpose" is no longer the answer.** This
> section used to end the Figures case with "left plain on purpose". The
> *constraint* above is real and measured; that *conclusion* was one option too
> early. **Fold the long value** and it fits: on `#figures`, `#| echo: fenced` +
> `fig-alt` as a two-line `>-` block + dropping `fig-width`/`fig-height` gives
> 720/720 with no horizontal clip. Measured alternatives, so nobody re-runs them:
> options as-is + fenced → clips sideways mid-sentence; folded `fig-alt` while
> keeping `fig-width`/`fig-height` → `scrollH` 751 > 720; a one-line `fig-alt`
> under ~60 chars also fits, but shortening real alt text to make a slide fit is
> the wrong trade on a deck that teaches accessibility.

**A stripped-echo cell is fine under watch-me and is a defect under Follow
along.** The mode label changes whether the code block is correct. Default echo
shows the source lines and drops every `#|`, so on a slide the room is told to
copy from, the options the slide *teaches* are exactly what the copy button
omits — paste it, write `@fig-bill`, get `?@fig-bill`. That is what made the
Figures slide a P0 once a Follow-along callout landed two slides above it.
**Test:** a code block on a Follow-along slide must copy to something that can
be pasted and rendered as-is. Check the clipboard payload, not the source —
Quarto's copy button reads the rendered `<code>` element, so what you wrote and
what a participant gets are different strings.

**Labs are different:** in a hands-on exercise the participant *types* the options
themselves, so they already see them — `echo: fenced` is for a **reader who isn't
writing the code** (a slide, or a non-interactive worked reference). Don't reach
for it in exercise steps.

## 8. A YAML block on a slide is never validated — render it once yourself

Slide code blocks are **non-executable display blocks** (`{.yaml}`, `{.bash}`).
Quarto renders the deck happily whatever is inside them, so a header that would
fail on a participant's machine ships looking perfect. The fit-check in § 1 will
not catch it either: it measures pixels, not syntax.

The case that got through: the Day-1 formats slide taught

```yaml
format: [html, typst]     # render several at once
```

for months. Quarto **rejects** it — *"The value `[html, typst]` is of type an
array"*, `ERROR: Validation of YAML front matter failed`. `format:` takes a
string or a mapping, never a sequence. The working form is

```yaml
format:
  html: default
  typst: default
```

**The near-miss is worse than the error.** Reaching for a flow mapping instead —
`format: {html, typst}` — raises **no error at all** and silently renders HTML
only, so the deck looks right, the render looks right, and the participant just
never gets their PDF. And an empty block mapping is rejected a third way:

```yaml
format:      # ERROR: Field "typst" has empty value but it must instead be an object
  html:
  typst:
```

`default` is not decoration, it is the required value.

So: **never eyeball slide YAML — render it.** That is one command:

```bash
python3 .claude/scripts/check-yaml-blocks.py
```

It extracts every ```` ```yaml ```` block from `slides/**` and `labs/**`, writes each
into a throwaway project in the shape its `filename=` claims (front matter,
`_quarto.yml`, `_metadata.yml`, `_brand.yml`), renders it, and separates schema
failures from missing-asset noise. Run it after touching any config block.

Same discipline for a shown **command** — check that the *slide's own setup*
doesn't already make it redundant. That's the other half of the same failure: that
slide set `format: typst` in the header and then ran
`quarto render report.qmd --to typst`, teaching that you need both.

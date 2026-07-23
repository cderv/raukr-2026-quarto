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

## 2. `.center` slides: use `.smaller`, not `aside`, for a footer line

On a `{.center}` slide (opening/section/closing) an `::: aside` is positioned
relative to the slide and **overlaps** the vertically-centered body. For a small
footer/contact line use `::: {.smaller}` instead — it stays in normal flow, just
smaller type. Keep centered slides short so the block stays centered without
overflowing. (This is the fix for the closing-slide overlap.)

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
  `output-location: column`, so fenced clips the `fig-alt` line. Left plain on
  purpose. **Prefer fenced on the *minimal* demo cell** (Tables), not the busy one.

**Labs are different:** in a hands-on exercise the participant *types* the options
themselves, so they already see them — `echo: fenced` is for a **reader who isn't
writing the code** (a slide, or a non-interactive worked reference). Don't reach
for it in exercise steps.

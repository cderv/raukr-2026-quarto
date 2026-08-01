# `.appendix` headings are numbered as ordinary body sections and consume body section numbers

> Draft bug report for `quarto-dev/quarto-cli`. Reduced from a real workshop lab that ends with a
> `## Session {.appendix}` block. **NOT filed — verify against a released 1.10.x first** (this
> sandbox is pinned to 1.9.38 and cannot install 1.10; note that the code path below is unchanged on
> the `main` clone at 2026-07-22, so the behavior is expected to persist).

## Bug description

In a single HTML document with `number-sections: true`, a heading carrying the `.appendix` class
(the [HTML appendix feature](https://quarto.org/docs/authoring/appendices.html)) is numbered as an
**ordinary body section**, continuing the body count — e.g. `## Session {.appendix}` renders as
"**3** Session". It does **not** become unnumbered, and it does **not** get the "Appendix A/B"
lettering that book/manuscript appendices receive.

Worse, because the appendix heading is counted in the same sequence as body headings, an `.appendix`
heading placed **before** a later body section makes that body section's number **skip** — the
appendix silently consumes a number out of the body sequence.

The documented workaround is to add `.unnumbered`, but that has to be remembered on every appendix
heading, and a reader of the body sees a gap in the numbering with no explanation.

## Steps to reproduce

`repro.qmd`:

````markdown
---
title: "Appendix numbering repro"
format: html
number-sections: true
---

## First body section

## Second body section

## Session {.appendix}

## Another appendix {.appendix .unnumbered}
````

Render with `quarto render repro.qmd` and inspect the `<h2>` elements.

## Expected behavior

An `.appendix` section, being conceptually an appendix, should **not take a number from the body
section sequence**. Reasonable options: treat `.appendix` like `.unnumbered` by default, or apply
appendix lettering ("Appendix A", "Appendix B") as book appendices already do. Either way, the two
real body sections should remain **1** and **2**, and no body number should be consumed by the
appendix.

## Actual behavior

The appendix heading gets a normal body section number, and `.unnumbered` is the only escape:

```html
<h2 ...><span class="header-section-number">1</span> First body section</h2>
<h2 ...><span class="header-section-number">2</span> Second body section</h2>
<h2 class="anchored quarto-appendix-heading"><span class="header-section-number">3</span> Session</h2>
<h2 class="anchored quarto-appendix-heading">Another appendix</h2>
```

`## Session {.appendix}` → "**3** Session" (body-style number). Only `{.appendix .unnumbered}`
suppresses it.

### Body numbering skips when an appendix heading precedes a body heading

`plain.qmd` (interleaved, `appendix-style: plain` — same result with `default`):

````markdown
---
title: "Appendix plain style"
format:
  html:
    number-sections: true
    appendix-style: plain
---

## Body one

## Appendix mid {.appendix}

## Body two

## Appendix end {.appendix}
````

Rendered headings:

```html
<h2 ...><span class="header-section-number">1</span> Body one</h2>
<h2 ...><span class="header-section-number">3</span> Body two</h2>
<h2 class="quarto-appendix-heading"><span class="header-section-number">2</span> Appendix mid</h2>
<h2 class="quarto-appendix-heading"><span class="header-section-number">4</span> Appendix end</h2>
```

The two real body sections are numbered **1** and **3** — number 2 was consumed by "Appendix mid".
After the appendix filter relocates the appendix headings to the container at the end of the
document, they also read out of order there (2, then 4).

## Root cause hypothesis

Two independent, non-interacting mechanisms handle "appendix":

1. **Section numbering** — `src/resources/filters/crossref/sections.lua`. Every heading that is not
   `.unnumbered` increments `crossref.index.section[level]` and is numbered. The special
   "Appendix" lettering is gated on **file-level** metadata, not the heading class:

   ```lua
   local appendix = (level == 1) and currentFileMetadataState().appendix
   if appendix then
     -- prepend "Appendix" + delimiter
   ```

   `currentFileMetadataState().appendix` is set for book/manuscript appendix **files**
   (`crossref.startAppendix`, initialized in `crossref/index.lua`), and the lettering itself
   (`string.char(64 + …)`) lives in `crossref/format.lua`. In a single HTML doc the `.appendix`
   **class** never sets this flag, and the headings are `##` (level 2, not level 1), so the branch
   is never taken — the heading is numbered as a plain body section and consumes a body number.

2. **HTML appendix placement** — `src/format/html/format-html-appendix.ts` is a post-render DOM pass
   that finds `.quarto-appendix-heading` elements and **moves** them into the appendix container. It
   never inspects or rewrites section numbers, and it explicitly bails out for books
   (`format.metadata.book || … // It never makes sense to process the appendix when we're in a book`).

So the class-based HTML appendix feature and the metadata-based appendix numbering are completely
disjoint: the class relocates the heading visually but the body number was already baked in by the
crossref filter, and the lettering path is unreachable from the class. A fix would likely live in
`sections.lua` — e.g. treat an `.appendix`-class heading as not participating in body numbering
(skip it like `.unnumbered`, or route it through the appendix-lettering branch).

## Docs / prior art

- <https://quarto.org/docs/authoring/appendices.html> documents `.appendix` purely as "add this
  section to the Appendix that appears at the end" and `appendix-style: default|plain|none`. It says
  nothing about how `.appendix` sections interact with `number-sections`, so the numbering behavior
  is at least undocumented.
- No existing `quarto-dev/quarto-cli` issue found for "appendix" + "number-sections" (searched
  2026-07-22). No mention in the 1.9 or 1.10 changelogs.

## Environment

```
quarto --version : 1.9.38
pandoc (bundled) : 3.8.3
OS               : Linux x86_64
```

Code path confirmed unchanged on a shallow clone of `main` at commit `663c449` (2026-07-22), i.e.
1.10-dev — so re-render the two MREs above on a released 1.10.x before filing to confirm it still
reproduces.

---

## Prior-art check (2026-08-01) — ALREADY TRACKED, do not file

Searched `quarto-dev/quarto-cli`. **This is already filed, by cderv:**

- **#10418** "[Appendix] `number-sections: true` also number the custom appendix" (cderv, 2024-07-30)
  — **closed as a duplicate of #9995**.
- **#9995** "`number-sections: True` misbehaves slightly when appendix sections are present"
  (GuillaumeDehaene, 2024-06-13) — **open**, labels `bug` / `html` / `triaged-to`,
  **milestone v1.11**. Covers both halves of this draft: `.appendix` headings numbered as ordinary
  body sections, *and* the resulting gap/skip in the body sequence.
- Also open and adjacent: **#10419** "[Appendix] `appendix-style: plain` does not keep header
  number" (cderv).

**Action:** do not open a new issue. The only thing worth doing is adding the MRE below as a comment
on #9995 if it sharpens the report; otherwise this draft is spent.

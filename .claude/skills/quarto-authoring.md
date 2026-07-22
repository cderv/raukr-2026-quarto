---
name: quarto-authoring
description: >
  Writing and authoring Quarto documents (.qmd), including code cell options,
  figure and table captions, cross-references, callout blocks (notes, warnings,
  tips), citations and bibliography, page layout and columns, Mermaid diagrams,
  YAML metadata configuration, and Quarto extensions. Also covers converting and
  migrating R Markdown (.Rmd), bookdown, blogdown, xaringan, and distill projects
  to Quarto, and creating Quarto websites, books, presentations, and reports.
metadata:
  author: Mickaël Canouil (@mcanouil)
  version: "1.2"
  source: https://github.com/posit-dev/skills/tree/main/quarto/quarto-authoring
license: MIT
---

# Quarto Authoring

> This skill is based on Quarto CLI v1.9.36 (2026-03-24).

## When to Use What

Task: Write a new Quarto document
Use: Follow "QMD Essentials" below, then see specific reference files

Task: Add cross-references
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/cross-references.md

Task: Configure code cells
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/code-cells.md

Task: Add figures with captions
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/figures.md

Task: Create tables
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/tables.md

Task: Add citations and bibliography
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/citations.md

Task: Add callout blocks
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/callouts.md

Task: Add diagrams (Mermaid, Graphviz)
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/diagrams.md

Task: Control page layout
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/layout.md

Task: Use shortcodes
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/shortcodes.md

Task: Add conditional content
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/conditional-content.md

Task: Use divs and spans
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/divs-and-spans.md

Task: Configure YAML front matter
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/yaml-front-matter.md

Task: Find and use extensions
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/extensions.md

Task: Apply markdown linting rules
Use: https://github.com/posit-dev/skills/blob/main/quarto/quarto-authoring/references/markdown-linting.md

### Migration (only when converting an existing project)

Do NOT read these references when writing new Quarto documents.
Only read the one matching the source format when the user explicitly asks to convert or migrate an existing project.

- R Markdown (.Rmd) to Quarto: references/conversion-rmarkdown.md
- bookdown project: references/conversion-bookdown.md
- xaringan slides: references/conversion-xaringan.md
- distill article: references/conversion-distill.md
- blogdown site: references/conversion-blogdown.md

## QMD Essentials

### Basic Document Structure

```markdown
---
title: "Document Title"
author: "Author Name"
date: today
format: html
---

Content goes here.
```

A Quarto document consists of two main parts:

1. **YAML Front Matter**: Metadata and configuration at the top, enclosed by `---`.
2. **Markdown Content**: Main body using standard markdown syntax.

### Divs and Spans

Divs use fenced syntax with three colons:

```markdown
::: {.class-name}
Content inside the div.
:::
```

Spans use bracketed syntax:

```markdown
This is [important text]{.highlight}.
```

### Code Cell Options Syntax

A code cell starts with triple backticks and a language identifier between curly braces.
Code cells are code blocks that can be executed to produce output.

Quarto uses the language's comment symbol + `|` for cell options. Options use **dashes, not dots** (e.g., `fig-cap` not `fig.cap`).

- R, Python: `#|`
- Mermaid: `%%|`
- Graphviz/DOT: `//|`

````markdown
```{r}
#| label: fig-example
#| echo: false
#| fig-cap: "A scatter plot example."

plot(x, y)
```
````

Common execution options:

| Option    | Description       | Values                    |
| --------- | ----------------- | ------------------------- |
| `eval`    | Evaluate code     | `true`, `false`           |
| `echo`    | Show code         | `true`, `false`, `fenced` |
| `output`  | Include output    | `true`, `false`, `asis`   |
| `warning` | Show warnings     | `true`, `false`           |
| `error`   | Show errors       | `true`, `false`           |
| `include` | Include in output | `true`, `false`           |

Set document-level defaults in YAML front matter:

```yaml
execute:
  echo: false
  warning: false
```

### Cross-References

Labels must start with a type prefix. Reference with `@`:

- Figure: `fig-` prefix, e.g., `#| label: fig-plot` -> `@fig-plot`
- Table: `tbl-` prefix, e.g., `#| label: tbl-data` -> `@tbl-data`
- Section: `sec-` prefix, e.g., `{#sec-intro}` -> `@sec-intro`
- Equation: `eq-` prefix, e.g., `{#eq-model}` -> `@eq-model`

````markdown
```{r}
#| label: fig-plot
#| fig-cap: "A caption for the plot."
plot(1)
```

See @fig-plot for the results.
````

### Callout Blocks

Five types: `note`, `warning`, `important`, `tip`, `caution`.

```markdown
::: {.callout-note}
This is a note callout.
:::

::: {.callout-warning}

## Custom Title

This is a warning with a custom title.

:::
```

### Figures

```markdown
![Caption text](image.png){#fig-name fig-alt="Alt text"}
```

Subfigures:

```markdown
::: {#fig-group layout-ncol=2}
![Sub caption 1](image1.png){#fig-sub1}

![Sub caption 2](image2.png){#fig-sub2}

Main caption for the group.
:::
```

### Tables

```markdown
::: {#tbl-example}

| Column 1 | Column 2 |
| -------- | -------- |
| Data 1   | Data 2   |

Table caption.
:::
```

### Citations

```markdown
According to @smith2020, the results show...
Multiple citations [@smith2020; @jones2021].
```

Configure in YAML:

```yaml
bibliography: references.bib
csl: apa.csl
```

## Common Workflows

### Creating an HTML Document

```yaml
title: "My Report"
author: "Your Name"
date: today
format:
  html:
    toc: true
    code-fold: true
    theme: cosmo
```

### Creating a PDF Document

```yaml
title: "My Report"
format:
  pdf:
    documentclass: article
    papersize: a4
```

### Creating a RevealJS Presentation

```markdown
---
title: "My Presentation"
format: revealjs
---

## First Slide

Content here.

## Second Slide

More content.
```

### Setting Up a Quarto Project

Create `_quarto.yml` in the project root:

```yaml
project:
  type: website

website:
  title: "My Site"
  navbar:
    left:
      - href: index.qmd
        text: Home
      - href: about.qmd
        text: About

format:
  html:
    theme: cosmo
```

## Resources

- [Quarto Documentation](https://quarto.org/docs/)
- [Quarto Guide](https://quarto.org/docs/guide/)
- [Quarto Extensions](https://quarto.org/docs/extensions/)
- [Community Extensions List](https://m.canouil.dev/quarto-extensions/)

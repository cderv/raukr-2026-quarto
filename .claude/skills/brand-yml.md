---
name: brand-yml
description: >
  Create and use brand.yml files for consistent branding across Shiny apps and Quarto documents.
  Use when working with brand styling, colors, fonts, logos, or corporate identity in Shiny or
  Quarto projects.
metadata:
  author: Garrick Aden-Buie (@gadenbuie)
  version: "1.0"
  source: https://github.com/posit-dev/skills/tree/main/brand-yml
license: MIT
---

# brand.yml Skill

Create and use `_brand.yml` files for consistent branding across Shiny applications and Quarto documents.

## What is brand.yml?

brand.yml is a YAML-based format that translates brand guidelines into a machine-readable file usable across Shiny and Quarto. A single `_brand.yml` file defines:

- **Colors** - Palette and semantic colors (primary, success, warning, etc.)
- **Typography** - Fonts, sizes, weights, line heights
- **Logos** - Multiple sizes and light/dark variants
- **Meta** - Company name, links, identity information

## File Naming Convention

- **Standard name**: `_brand.yml` (auto-discovered by Shiny and Quarto)
- **Custom names**: Any name like `company-brand.yml` (requires explicit paths)
- **Location**: Typically at project root, or in `_brand/` or `brand/` subdirectories

## Decision Tree

1. **Creating a new _brand.yml file?** -> Follow "Creating brand.yml Files"
2. **Using brand.yml in Shiny for R?** -> See reference: shiny-r.md
3. **Using brand.yml in Shiny for Python?** -> See reference: shiny-python.md
4. **Using brand.yml in Quarto?** -> See "Using with Quarto" below
5. **Modifying existing _brand.yml?** -> Follow "Modifying Existing Files"
6. **Troubleshooting integration?** -> Follow "Troubleshooting"

Full references at: https://github.com/posit-dev/skills/tree/main/brand-yml/references

## Creating brand.yml Files

### Step 1: Gather Information

Collect brand information:
- **Colors**: Primary, secondary, accent colors with hex values
- **Fonts**: Font families and where they're sourced (Google Fonts, local files, etc.)
- **Logos**: Logo file paths or URLs for different sizes
- **Company info**: Name, website, social links (optional)

### Step 2: Build the File Incrementally

**Minimum viable _brand.yml:**

```yaml
color:
  palette:
    brand-blue: "#0066cc"
  primary: brand-blue
  background: "#ffffff"

typography:
  fonts:
    - family: Inter
      source: google
      weight: [400, 600]
  base: Inter
```

**Add colors as needed:**

```yaml
color:
  palette:
    brand-blue: "#0066cc"
    brand-orange: "#ff6600"
    brand-gray: "#666666"
  primary: brand-blue
  secondary: brand-gray
  warning: brand-orange
  foreground: "#333333"
  background: "#ffffff"
```

**Add typography details:**

```yaml
typography:
  fonts:
    - family: Inter
      source: google
      weight: [400, 600, 700]
      style: [normal, italic]
    - family: Fira Code
      source: google
      weight: [400, 500]
  base:
    family: Inter
    size: 16px
    line-height: 1.5
  headings:
    family: Inter
    weight: 600
  monospace: Fira Code
```

**Add logos:**

```yaml
logo:
  small: logos/icon.png
  medium: logos/header.png
  large: logos/full.svg
```

**Add meta information:**

```yaml
meta:
  name: Company Name
  link: https://example.com
```

### Best Practices

- All fields are optional - only include what's needed
- Use hex color format: `"#0066cc"`
- Prefer simple syntax (strings over objects) when possible
- Use lowercase names with hyphens: `brand-blue`, `success-green`
- Include `https://` in all URLs
- Define colors/fonts before referencing them

## Using with Quarto

- **Automatic discovery**: Place `_brand.yml` at project root with `_quarto.yml`
- **Supported formats**: HTML, dashboards, RevealJS, Typst PDFs
- **Theme layering**: Use `brand` keyword to control precedence

Quick example (document):

```yaml
---
title: "My Document"
format:
  html:
    brand: _brand.yml
---
```

Quick example (project in `_quarto.yml`):

```yaml
project:
  brand: _brand.yml

format:
  html:
    theme: default
```

### Typst-specific notes

In Typst documents, brand variables are exposed as:
- `brand-color.primary`, `brand-color.secondary` etc.
- `brand-logo-images` for logo access
- Works with `format: typst` when `_brand.yml` is present

## Modifying Existing Files

1. **Read the current file** to understand existing structure
2. **Maintain consistency** with existing naming patterns
3. **Preserve references** - if other colors/elements reference a name, update consistently
4. **Test integration** - verify changes apply correctly in Shiny/Quarto

## Common Patterns

### Light/Dark Mode Colors

```yaml
color:
  primary:
    light: "#0066cc"
    dark: "#3399ff"
  background:
    light: "#ffffff"
    dark: "#1a1a1a"
  foreground:
    light: "#333333"
    dark: "#e0e0e0"
```

### Logo Variants

```yaml
logo:
  images:
    logo-dark: logos/logo-dark.svg
    logo-white: logos/logo-white.svg
    icon: logos/icon.png
  small: icon
  medium:
    light: logo-dark
    dark: logo-white
```

### Color Aliases

```yaml
color:
  palette:
    navy: "#003366"
    ocean-blue: "#0066cc"
    sky-blue: "#3399ff"
    brand-blue: ocean-blue     # Alias
    blue: sky-blue             # Bootstrap color name
  primary: brand-blue
```

Include Bootstrap color names when possible (blue, indigo, purple, pink, red, orange, yellow, green, teal, cyan, white, black) for consistency.

## Troubleshooting

### Brand Not Applying (Quarto)
- Verify `_brand.yml` is at project root
- Ensure `_quarto.yml` exists for project-level branding
- Try explicit path in document frontmatter
- Check theme layering order if using custom themes

### Colors Not Matching
- Ensure hex colors have quotes: `"#0066cc"` not `#0066cc`
- Verify color names match palette definitions exactly
- Check semantic colors reference valid palette names

### Fonts Not Loading
- Verify Google Fonts spelling and availability
- Ensure `source: google` or `source: bunny` is specified
- For Typst: Check font cache with `quarto typst fonts`

## Key Principles

- **Start simple**: Begin with colors and one font family
- **Keep it concise**: Only include fields directly relevant to the brand
- **Prefer standard names**: Use Bootstrap color names when possible
- **Use automatic discovery**: Name file `_brand.yml` for auto-detection
- **Test across targets**: Verify brand applies correctly in all intended formats

# Colorblind-safe palettes in ggplot2 — best practice & recipes

How we colour categorical/continuous ggplot graphics in this workshop so they stay readable for
colour-blind participants (and in greyscale/print). This is the **raster-side counterpart** to the
HTML contrast work (axe can't see inside a plot PNG — worklog 2026-07-22): the page's colours are
checked by axe, but a plot's colours are on us. First relevant to the Day-1 `penguins-report.qmd`
scatter (bill length vs depth, coloured by species). Researched 2026-07-22.

## The rule of thumb (decision order)

1. **Categorical / discrete → Okabe-Ito.** The de-facto scientific standard colour-blind-safe
   qualitative palette (8 hues). Recommended by *Nature Methods*, the default in Wilke's
   *Fundamentals of Data Visualization*, and **shipped in base R >= 4.0** — zero dependency.
2. **Continuous / ordered / many groups → viridis** (esp. `cividis`, tuned for red-green CVD).
   Perceptually uniform, print- and greyscale-safe, and **already built into ggplot2**.
3. **Publication-grade qualitative sets → Paul Tol** (via `khroma`: `bright`/`vibrant`/`muted`/
   `high-contrast` are all CVD-safe) or **rcartocolor's `Safe`** palette.

Two rules underneath all of them:

- **<= 8 colours.** Beyond ~8 categories no palette stays reliably distinguishable — bin, facet, or
  highlight-the-few-that-matter instead of adding hues.
- **Encode redundantly.** Also map `shape =` / `linetype =`, or label series directly, so the graph
  survives total colour loss or a B&W printout. (`penguins-report.qmd` already maps `shape = species`
  — keep that alongside any colour scale.)

## Okabe-Ito — the 9 colours

`#000000` black · `#E69F00` orange · `#56B4E9` sky blue · `#009E73` bluish green · `#F0E442` yellow ·
`#0072B2` blue · `#D55E00` vermillion · `#CC79A7` reddish purple · `#999999` grey.

Ways to use it, zero-dependency first:

```r
# 1. Zero dependency -- base R >= 4.0 (grDevices). Named vector of 9.
okabe_ito <- palette.colors(palette = "Okabe-Ito")
ggplot(...) + scale_colour_manual(values = unname(okabe_ito))

# 2. ggthemes -- its "colorblind" scale IS Okabe-Ito (8-colour)
ggthemes::scale_colour_colorblind()

# 3. Dedicated packages (self-documenting for a teaching doc)
ggokabeito::scale_colour_okabe_ito()
see::scale_color_okabeito()          # easystats
```

## Other categorical options

```r
# Paul Tol via khroma -- richer, all CVD-safe, ships CVD-simulation tools
khroma::scale_colour_bright()        # 7; also _vibrant(), _muted() (9), _highcontrast()

# ColorBrewer / CARTO
scale_colour_brewer(palette = "Dark2")                 # built into ggplot2 (Set2, Paired also ok)
rcartocolor::scale_colour_carto_d(palette = "Safe")    # 12-colour CVD-safe qualitative
```

## Continuous / sequential (built into ggplot2)

```r
scale_colour_viridis_c()                       # default viridis
scale_colour_viridis_c(option = "cividis")     # tuned for red-green CVD specifically
scale_colour_viridis_d()                       # discrete variant -- good when groups > 8
```

## Verify, don't trust — simulate CVD on the *actual* figure

```r
colorblindr::cvd_grid(my_plot)                 # renders under deutan/protan/tritan
colorspace::cvd_emulator()                     # interactive; also deutan()/protan()/tritan()
khroma::plot_scheme(..., colours = TRUE)       # + blindness simulation
dichromat::dichromat(cols)
```

## Recipe for the penguins scatter (3 species)

With 3 groups any option is safe; the dependency-light, defensible choice for a scientific workshop
is **Okabe-Ito**, kept alongside the existing `shape = species` for double encoding:

```r
ggplot(penguins, aes(bill_len, bill_dep, colour = species, shape = species)) +
  geom_point(alpha = 0.8) +
  scale_colour_manual(values = unname(palette.colors(palette = "Okabe-Ito")[2:4])) +
  # or, no manual slicing + self-documenting: ggokabeito::scale_colour_okabe_ito()
  labs(x = "Bill length (mm)", y = "Bill depth (mm)", colour = "Species", shape = "Species") +
  theme_minimal(base_size = 12)
```

`[2:4]` skips black (index 1) so the species get orange / sky-blue / bluish-green — three of the
most-distinct Okabe-Ito hues. **Dependency note:** using `ggokabeito`/`see`/`khroma`/`ggthemes`/
`rcartocolor` means adding it to `DESCRIPTION` `Imports:` → install → `renv::snapshot()`. The base-R
`palette.colors()` route needs nothing (R >= 4.0), which the workshop already requires.

## Sources

- Okabe-Ito scale (easystats/see): <https://easystats.github.io/see/reference/scale_color_okabeito.html>
- ggokabeito: <https://archive.linux.duke.edu/cran/web/packages/ggokabeito/refman/ggokabeito.html>
- ggthemes colorblind (= Okabe-Ito): <https://jrnold.github.io/ggthemes/reference/colorblind.html>
- khroma (Paul Tol & Crameri): <https://packages.tesselle.org/khroma/> · Tol vignette:
  <https://cran.r-project.org/web/packages/khroma/vignettes/tol.html>
- rcartocolor (incl. `Safe`): <https://jakubnowosad.com/rcartocolor/>
- R Color Theory / designing for colour-blind readers: <https://r-statistics.co/R-Color-Theory-ggplot2.html>
- "Coloring in R's Blind Spot", R Journal 2023: <https://journal.r-project.org/articles/RJ-2023-071/>
- Andrew Heiss, Color palettes (Data Viz with R): <https://datavizf24.classes.andrewheiss.com/resource/colors.html>

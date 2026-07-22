# --- figure (cross-referenced) ---
#| label: fig-bill
#| fig-cap: "Bill length versus depth, colored by species."
#| fig-alt: "Bill depth versus length for three penguin species; species form separate clusters."
ggplot(penguins, aes(bill_len, bill_dep, color = species, shape = species)) +
  geom_point(alpha = 0.8) +
  scale_color_okabe_ito() +   # colour-blind-safe (see the Accessibility box)
  labs(x = "Bill length (mm)", y = "Bill depth (mm)")

# --- species counts, in the margin ---
#| label: counts
#| column: margin
penguins |> count(species, name = "n") |> knitr::kable()

# --- summary table (cross-referenced) ---
#| label: tbl-summary
#| tbl-cap: "Mean measurements per species."
penguins |>
  summarise(bill_len = mean(bill_len), bill_dep = mean(bill_dep),
            body_mass = mean(body_mass, na.rm = TRUE), .by = species) |>
  gt() |>
  fmt_number(c(bill_len, bill_dep), decimals = 1) |>
  fmt_number(body_mass, decimals = 0)

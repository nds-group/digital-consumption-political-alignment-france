# Commune-level analytical tables (SHIPPED — the reproduction entry point)

`df_data_europe_{year}_{window}.csv` — one row per commune (INSEE code), for each
election year (`2019`, `2024`) and time-of-day window. These are the inputs to the
Dirichlet regression (`scripts/`) and the analysis notebooks.

- **Rows:** 4,102 urban and suburban communes of metropolitan France.
- **`year`:** `2019` and `2024` European (parliamentary) elections.
- **`window`:** `full` (all day) plus four time-of-day windows used for the sensitivity
  analysis — `07_13`, `07_20`, `13_20`, `20_07` (hours, e.g. `20_07` = 20:00–07:00).
  `full` is the primary table; the windows reproduce the time-of-day robustness checks.

## Columns
- `insee` — commune identifier (INSEE code).
- `*_votes` — vote share per party / coalition (the compositional response), e.g.
  `LFI_votes`, `RN_votes`, `Ren_coal_votes`, ..., `others_votes`.
- Socioeconomic predictors — `median_income`, `unemployment_ratio`, and age brackets
  `pop_0_14 ... pop_90`.
- `*_srca` — scaled revealed comparative advantage of each mobile service in the
  commune (22 services in 2019; 27 in 2024, which adds TikTok). This is the mobile
  digital-consumption signal.

## What is NOT here (by design)
- The raw mobile-network traffic that produces the `_srca` values is **confidential
  operator data (under NDA)** and is not released. These tables are aggregated to the
  commune level and contain no base-station or individual information.
- Two vote-derived ideology scores (`polarization_dalton`, `ideology`) are intentionally
  omitted from the released tables.

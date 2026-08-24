# INSEE socioeconomic data (PUBLIC — not shipped, re-downloadable)

The INSEE "dossier complet" per commune (income, unemployment, age structure), used by
notebook `00` to build the socioeconomic predictors that appear in the shipped
`data/dirichlet/df_data_europe_*` tables.

Expected layout (as read by the notebooks):
- `2019/dossier_complet.csv`
- `2023/dossier_complet.csv`  (used for the 2024 election year)

## Source
INSEE — Dossier complet (commune level):
https://www.insee.fr/fr/statistiques/  (search "dossier complet", export by commune).
Freely redistributable by INSEE; ~1.5 GB, so fetched rather than committed.

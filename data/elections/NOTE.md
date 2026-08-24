# Election results (PUBLIC — not shipped, re-downloadable)

Official commune-level results of the 2019 and 2024 European (parliamentary) elections,
used by notebook `02` to build the `*_votes` compositional response in the shipped
`data/dirichlet/df_data_europe_*` tables.

Expected layout (as read by the notebooks):
- `communes/2019/parlamentary_election/resultats-definitifs-par-commune.xls`
- `communes/2024/parlamentary_election/resultats-definitifs-par-commune.csv`

## Source
Official commune-level results, published on data.gouv.fr:
- 2019 European elections:
  https://www.data.gouv.fr/datasets/resultats-des-elections-europeennes-2019?resource_id=cac2692c-67af-4bcb-9921-eca33e7f1ead
- 2024 European elections (9 June 2024):
  https://www.data.gouv.fr/datasets/resultats-des-elections-europeennes-du-9-juin-2024?resource_id=ed34e007-582b-4108-b117-25ab138ec33e

Freely redistributable (French Ministry of the Interior / data.gouv.fr); fetched rather
than committed.

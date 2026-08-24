# Commune cartography (PUBLIC — not shipped, re-downloadable)

Commune boundary shapefiles and the urban/suburban/rural classification, used by the
provenance notebooks (`00`–`02`) and the prediction-map figures.

- **`communes_urban_rural.csv` — SHIPPED.** Per-commune urbanization class
  (`insee,type`), following the INSEE grille de densité (e.g. "urbain densité
  intermédiaire", "rural autonome peu dense"). Covers all metropolitan communes.
- `2024/COMMUNE.shp` (+ `.dbf/.shx/.prj`) — commune polygons, **not shipped** (large),
  re-downloadable below.

## Source
IGN ADMIN EXPRESS (commune boundaries): https://geoservices.ign.fr/adminexpress
INSEE urban-unit / commune typology: https://www.insee.fr/ (zonages) and
https://www.data.gouv.fr/. Files are large (~1.6 GB) and freely redistributable by the
producers, so they are fetched rather than committed here.

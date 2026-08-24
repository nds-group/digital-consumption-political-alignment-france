# Boundary GeoJSON (SHIPPED — small public geometries for the map figures)

Outline geometries used by the map-plotting cells of notebooks `03` and `07`:
- `france.geojson` — metropolitan France outline.
- `region-ile-de-france.geojson` — Île-de-France region.
- `Paris.geojson`, `Lyon.geojson`, `Toulouse.geojson`, `Metz.geojson`, `Orleans.geojson`
  — city outlines for the per-city sRCA / prediction maps.

Public administrative boundaries (IGN / OpenStreetMap-derived), small enough to ship
directly. Detailed commune polygons (large) are fetched separately — see `../carto/NOTE.md`.

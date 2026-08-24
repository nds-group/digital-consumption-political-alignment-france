# Party / coalition metadata (PUBLIC — not shipped, re-downloadable)

Party and coalition descriptions and their left–right positioning, used by notebook `01`
to map lists onto the political-spectrum figure and to define the party/coalition groups
behind the `*_votes` columns.

- **`political_parties_description_europe_{2019,2024}.json` — SHIPPED.** The per-election
  party/coalition dictionary: full name, head of list, seats, `%votes`, left–right score
  (`lr_score`), and plotting metadata (color/symbol). Keys match the `*_votes` column
  prefixes in the shipped commune tables (e.g. `LFI`, `RN`, `RE_coal`).
- **`parlgov_parties_france_{2019,2024}.csv` — SHIPPED.** ParlGov `view_party` exports
  filtered to the French lists: party names, left–right position (`left_right` /
  `lr_score`), party family, and (2019) vote share and seats. These are the source of the
  `lr_score` used in the JSON dictionaries above. Notebook `01` writes these files.
- The raw ParlGov/edition exports (`view_election_2024_editions_all.csv`,
  `view_party_2024.csv`) are **not shipped**; notebook `01` derives the shipped files
  from them.

## Source
Party positioning from ParlGov (https://www.parlgov.org/) and the Chapel Hill Expert
Survey (https://www.chesdata.eu/). Small, freely redistributable; re-derive with
notebook `01` from the source exports.

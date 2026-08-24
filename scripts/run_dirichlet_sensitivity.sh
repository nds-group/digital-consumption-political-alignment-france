#!/usr/bin/env bash
# Run the per-window Dirichlet fit-stats for both elections.
# Output: data/dirichlet_sensitivity/<year>/<window>/df_parameters_fit.csv
# Override the R binary if needed:  RSCRIPT=/path/to/Rscript ./run_dirichlet_sensitivity.sh
set -u
RSCRIPT="${RSCRIPT:-Rscript}"
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
RFILE="$DIR/scripts/Dirichlet_regression_sensitivity.R"
LOG_DIR="$DIR/data/dirichlet_sensitivity/logs"
mkdir -p "$LOG_DIR"

YEARS=(2019 2024)
WINDOWS=(20_07 07_20 07_13 13_20 full)

for year in "${YEARS[@]}"; do
  for window in "${WINDOWS[@]}"; do
    echo "================= ${year} | ${window} ================="
    "$RSCRIPT" "$RFILE" "$year" "$window" 2>&1 | tee "$LOG_DIR/fit_${year}_${window}.log"
  done
done
echo "ALL DONE -> data/dirichlet_sensitivity/<year>/<window>/df_parameters_fit.csv"

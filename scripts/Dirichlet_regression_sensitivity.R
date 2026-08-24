#!/usr/bin/env Rscript
# ============================================================================
# Time-of-day sensitivity: Dirichlet regression fit statistics (LogLik/AIC/BIC)
# per (year, time-window). Reads the per-window CSVs produced by notebook 9.1,
# fits the same 11 predictor sets as notebook 11, and writes a fit-stats table.
#
# Usage:  Rscript 11-Dirichlet_regression_sensitivity.R <year> <window>
#   e.g.  Rscript 11-Dirichlet_regression_sensitivity.R 2019 20_07
# ============================================================================
suppressMessages(library("DirichletReg"))

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) stop("usage: Rscript ...sensitivity.R <year> <window>")
year   <- args[1]
window <- args[2]

args_full <- commandArgs(trailingOnly = FALSE)
script_path <- sub("^--file=", "", args_full[grep("^--file=", args_full)])
WORKING_DIR <- normalizePath(file.path(dirname(script_path), ".."))  # repo root
DATA_DIR    <- file.path(WORKING_DIR, "data")
# keep sensitivity outputs fully separate from the real dirichlet/ results
OUT_DIR     <- file.path(DATA_DIR, "dirichlet_sensitivity", year, window)
dir.create(OUT_DIR, showWarnings = FALSE, recursive = TRUE)

infile <- file.path(DATA_DIR, "dirichlet", sprintf("df_data_europe_%s_%s.csv", year, window))
cat(sprintf("[%s | %s] reading %s\n", year, window, infile))
df <- read.csv(infile, sep = ",", header = TRUE)   # spaces/+/- in names -> dots

# --- columns (derived, not hard-coded) -------------------------------------
vote_cols <- grep("_votes$", colnames(df), value = TRUE)   # parties + others
apps_cols <- grep("_srca$",  colnames(df), value = TRUE)   # all sRCA apps (the "mobile" set)
social_cols <- c("median_income", "unemployment_ratio",
                 "pop_0_14", "pop_15_29", "pop_30_44", "pop_45_59", "pop_60_74")  # drop 75_89, 90 (collinearity)

inter <- function(full) intersect(full, apps_cols)         # keep only apps present this year
social_media <- inter(c("Facebook_srca","Instagram_srca","LinkedIn_srca","SnapChat_srca",
                        "Twitter_srca","Twitch_srca","TikTok_srca"))
news <- inter(c("NewsPaper_srca","Sports.News_srca","DailyMotion_srca","NewsMag_srca",
               "Google.News_srca","TV5MONDE_srca"))
messaging <- inter(c("WhatsApp_srca","Apple.iMessage_srca","Signal_srca","Discord_srca","Telegram_srca"))
streamming <- inter(c("Youtube_srca","Spotify_srca","CanalPlus_srca","Netflix_srca","Apple.Music_srca",
                     "Disney._srca","Apple.Video_srca","Molotov.TV_srca","Pluto.TV_srca"))

cat(sprintf("  %d vote components, %d apps, %d communes\n", length(vote_cols), length(apps_cols), nrow(df)))

# --- response (compositional vote shares) ----------------------------------
Y <- DR_data(df[, vote_cols])

# --- predictor sets (name -> RHS) ------------------------------------------
rhs <- list(
  intercept                    = "1",
  pop                          = paste(c("pop_0_14","pop_15_29","pop_30_44","pop_45_59","pop_60_74"), collapse = " + "),
  unemployment                 = "unemployment_ratio",
  income                       = "median_income",
  income_unemployment_pop      = paste(social_cols, collapse = " + "),
  social_media                 = paste(social_media, collapse = " + "),
  news                         = paste(news, collapse = " + "),
  messaging                    = paste(messaging, collapse = " + "),
  streamming                   = paste(streamming, collapse = " + "),
  apps                         = paste(apps_cols, collapse = " + "),
  income_unemployment_pop_apps = paste(c(social_cols, apps_cols), collapse = " + ")
)
model_order <- c("intercept","pop","unemployment","income","apps",
                 "income_unemployment_pop","social_media","news","messaging",
                 "streamming","income_unemployment_pop_apps")

# --- fit + collect stats (tryCatch so one failure does not abort the batch) -
res <- data.frame(model = character(), n_parameters = integer(),
                  LogLik = numeric(), AIC = numeric(), BIC = numeric(),
                  stringsAsFactors = FALSE)
for (name in model_order) {
  str_formula <- paste("Y ~", rhs[[name]])
  cat(sprintf("  fitting %-30s ", name))
  m <- tryCatch(
    DirichReg(formula = as.formula(str_formula), df, control = list(iterlim = 1000, tol1 = 1e-5)),
    error = function(e) { cat("FAILED:", conditionMessage(e), "\n"); NULL })
  if (is.null(m)) {
    res <- rbind(res, data.frame(model = name, n_parameters = NA,
                                 LogLik = NA, AIC = NA, BIC = NA))
  } else {
    res <- rbind(res, data.frame(model = name, n_parameters = m$npar,
                                 LogLik = round(logLik(m)[1], 2),
                                 AIC = round(AIC(m), 2), BIC = round(BIC(m), 2)))
    cat(sprintf("npar=%d  LogLik=%.0f  AIC=%.0f  BIC=%.0f\n",
                m$npar, logLik(m)[1], AIC(m), BIC(m)))
    # Save fitted (in-sample predicted) vote shares for the two models needed to
    # compute the predictive-R2 / correlation gain in notebook 11.1 (same metric as
    # the main results). Only the full model and the socioeconomic baseline are needed.
    if (name %in% c("income_unemployment_pop_apps", "income_unemployment_pop")) {
      pred <- as.data.frame(fitted(m))
      colnames(pred) <- vote_cols
      write.csv(pred, file.path(OUT_DIR, sprintf("df_prediction_%s.csv", name)),
                row.names = FALSE)
    }
  }
}

res$year   <- year
res$window <- window
outfile <- file.path(OUT_DIR, "df_parameters_fit.csv")
write.csv(res, outfile, row.names = FALSE)
cat(sprintf("[%s | %s] saved -> %s\n\n", year, window, outfile))

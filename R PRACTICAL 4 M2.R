# Load required library
library(dplyr)

# Read the CSV file (User must select the file when running this)
df <- read.csv(file.choose(), stringsAsFactors = FALSE)

# --- Data Cleaning Fix (Robust Method using Column Index) ---
# This ensures columns '4s' (Column 5) and '6s' (Column 6) are numeric,
# preventing errors if they contain text (like '-').
df[, 5] <- as.numeric(df[, 5]) # Column '4s'
df[, 6] <- as.numeric(df[, 6]) # Column '6s'

# Ensure Runs and BF are numeric (safe practice)
df$Runs <- as.numeric(df$Runs)
df$BF <- as.numeric(df$BF)
# ------------------------------------------------------------

# View data
print("--- Data Head ---")
print(head(df))

# ---------------------------------------------
# One-Sample t-test
# ---------------------------------------------

# Null Hypothesis (H0): The mean runs scored in a fastest fifty (mu) is 60.

print("--- One-Sample t-test for Runs Scored ---")
# Testing if the mean Runs is significantly different from a hypothesized 60 runs
t_test_runs <- t.test(df$Runs, mu = 60)
print(t_test_runs)


# Null Hypothesis (H0): The mean balls faced (BF) in a fastest fifty (mu) is 35.

print("--- One-Sample t-test for Balls Faced (BF) ---")
# Testing if the mean BF is significantly different from a hypothesized 35 balls
t_test_bf <- t.test(df$BF, mu = 35)
print(t_test_bf)
# Load required library
library(dplyr)

# Read the CSV file (User must select the file when running this)
# stringsAsFactors = FALSE is safer for reading data
df <- read.csv(file.choose(), stringsAsFactors = FALSE)

# --- Data Cleaning Fix (Ensure Numeric Columns) ---
# This ensures Runs, BF, 4s, and 6s are numeric for calculations.
df$Runs <- as.numeric(df$Runs)
df$BF <- as.numeric(df$BF)
df[, 5] <- as.numeric(df[, 5]) # Column '4s'
df[, 6] <- as.numeric(df[, 6]) # Column '6s'
# ------------------------------------------------------------

# View data
print("--- Data Head ---")
print(head(df))

# ---------------------------------------------
# Create required categorical variable (BF Group)
# ---------------------------------------------

# BF Group: High / Low BF (Replaces Volume_Group)
# High BF means a slower innings for a given score (above median BF)
median_bf <- median(df$BF, na.rm = TRUE)
df$BF_Group <- ifelse(df$BF > median_bf,
                      "High BF (Slower Innings)", 
                      "Low BF (Faster Innings)")

# ---------------------------------------------
# Independent two-sample t-test
# ---------------------------------------------

# Null Hypothesis (H0): The mean Runs scored in High BF innings is equal to 
# the mean Runs scored in Low BF innings.

print("--- Independent Two-Sample t-test for Runs (High vs. Low BF Group) ---")
# Compare Runs (~ Runs Scored) between the two BF groups
t_test_independent <- t.test(Runs ~ BF_Group, data = df)
print(t_test_independent)
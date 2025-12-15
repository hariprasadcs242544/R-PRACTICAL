# Load required library
library(dplyr)

# Read the CSV file (User must select the file when running this)
# stringsAsFactors = FALSE is safer for reading data
df <- read.csv(file.choose(), stringsAsFactors = FALSE)

# --- Data Cleaning Fix (Ensure Numeric Columns) ---
# Ensure Runs and BF are numeric (essential for t-test)
df$Runs <- as.numeric(df$Runs)
df$BF <- as.numeric(df$BF)

# Clean 4s and 6s using index (5th and 6th columns) to prevent 'not numeric' errors
# 4s is column 5; 6s is column 6
df[, 5] <- as.numeric(df[, 5]) 
df[, 6] <- as.numeric(df[, 6]) 
# ------------------------------------------------------------

# View data
print("--- Data Head ---")
print(head(df))

# ---------------------------------------------
# Paired Two-Sample t-test
# ---------------------------------------------

# We compare Runs (df$Runs) and Balls Faced (df$BF) within the same innings (row).

print("--- Paired t-test: Runs vs. Balls Faced (BF) ---")

# Compares the mean of the differences (Runs - BF) against zero.
# The 'paired = TRUE' argument is critical.
t_test_paired <- t.test(df$Runs, df$BF, paired = TRUE)
print(t_test_paired)

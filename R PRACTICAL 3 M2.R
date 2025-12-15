# Load required library
library(dplyr)

# Read the CSV file (User must select the file when running this)
df <- read.csv(file.choose(), stringsAsFactors = FALSE)

# --- Data Cleaning Fix (Robust Method using Column Index) ---
# This ensures '4s' (Column 5) and '6s' (Column 6) are numeric, preventing 
# previous errors. It's safe to include this.
df[, 5] <- as.numeric(df[, 5]) # Column '4s'
df[, 6] <- as.numeric(df[, 6]) # Column '6s'
# ------------------------------------------------------------

# View data
print("--- Data Head ---")
print(head(df))

# ---------------------------------------------
# Create required categorical variables for Cross-Tabulation
# ---------------------------------------------

# 1. Runs Group: High / Low Runs (based on median Runs)
# We ensure the Runs column is numeric before calculating the median
df$Runs <- as.numeric(df$Runs) 
median_runs <- median(df$Runs, na.rm = TRUE)
df$Runs_Group <- ifelse(df$Runs > median_runs, 'High Runs', 'Low Runs')

# 2. Balls Faced Group: High / Low BF (based on median BF)
# We ensure the BF column is numeric before calculating the median
df$BF <- as.numeric(df$BF)
median_bf <- median(df$BF, na.rm = TRUE)
df$BF_Group <- ifelse(df$BF > median_bf, 'High BF', 'Low BF')

# ---------------------------------------------
# Cross-tabulation using table()
# ---------------------------------------------

print("--- Cross-Tabulation: Runs Group vs. Balls Faced Group ---")
# Rows = Runs Group, Columns = BF Group
print(table(df$Runs_Group, df$BF_Group))

# Cross-tabulation with totals
print("--- Cross-Tabulation with Row & Column Totals ---")
print(addmargins(table(df$Runs_Group, df$BF_Group)))

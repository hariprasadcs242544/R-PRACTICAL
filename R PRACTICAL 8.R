# Load necessary libraries
library(dplyr)
library(tidyr)

# ==============================================================================
# 1. CREATE AND IMPORT DATASET
# ==============================================================================

# IMPORTANT: Using your provided file path and the correct file name.
# 'na.strings = ""' tells R to treat empty spaces as NA (Missing Values).
cricket_df <- read.csv("D:/HariS126/Fastest Fifties - 2018.csv", na.strings = c("", "NA"))

print("--- 1. Original Data (First 6 Rows) ---")
print(head(cricket_df))

# Check how many NAs are in each column
print("--- Count of Missing Values per Column ---")
# If '4s' and '6s' were renamed by R, they will appear as 'X4s' and 'X6s' here.
print(colSums(is.na(cricket_df)))

# ==============================================================================
# 2. METHOD A: REMOVE MISSING VALUES (na.omit)
# ==============================================================================
# This is the "nuclear option". If a row has even ONE missing value, it is deleted.

clean_omit <- na.omit(cricket_df)

print("--- 2. Data after na.omit() ---")
print(paste("Original rows:", nrow(cricket_df)))
print(paste("Rows remaining:", nrow(clean_omit)))
print(head(clean_omit))


# ==============================================================================
# 3. METHOD B: REPLACE MISSING VALUES (replace_na)
# ==============================================================================
# This is the "surgical option". We fill missing values with logical defaults.
# Strategy:
# 1. Venue: Fill missing with "Unknown Venue" (Categorical)
# 2. X4s, X6s: Fill missing with 0 (Assumption: Numeric, No data = 0 boundaries)
# 3. Runs: Fill missing with the Median Runs (Median is often preferred over Mean for runs/scores)

# Calculate median runs (ignoring NAs) to use for filling
median_runs <- median(cricket_df$Runs, na.rm = TRUE)

clean_replace <- cricket_df %>%
  replace_na(list(
    Venue = "Unknown Venue",
    X4s = 0,             # Assuming R renamed '4s' to 'X4s'
    X6s = 0,             # Assuming R renamed '6s' to 'X6s'
    Runs = median_runs
  ))

print("--- 3. Data after replace_na() ---")
print(head(clean_replace))

# Verify no NAs exist in the columns we cleaned
print("--- Remaining NAs after replacement ---")
print(colSums(is.na(clean_replace)))
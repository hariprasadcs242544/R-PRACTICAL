# Install the necessary packages if you haven't already
# install.packages("dplyr") 

library(dplyr)
# library(readr) # Not needed if using base R's read.csv

# =========================================================================
# *** CRITICAL: Set the working directory (optional, but highly recommended) ***
# You must ensure 'Fastest Fifties - 2018.csv' is in this folder, 
# or use the full path.
# setwd("C:/Your/File/Path/Here") 
# =========================================================================

# --- 1. Load your specific CSV file using Base R ---
# This is the most compatible way to load the file.
# Note: It creates column names X4s and X6s.
fastest_fifties <- read.csv("Fastest Fifties - 2018.csv") 

# FIX 1: Convert the data frame to a tibble for full dplyr compatibility
fastest_fifties_tbl <- as_tibble(fastest_fifties)

# Quick look to confirm the data loaded correctly
cat("--- Head of Data ---\n")
print(head(fastest_fifties_tbl))
cat("\n--- Data Structure (Note X4s and X6s) ---\n")
print(str(fastest_fifties_tbl))

# ==========================================
# Method 1: Using subset() (Base R) - Adjusted for X4s/X6s
# ==========================================

# Example 2: Multiple Conditions (Runs > 50 AND 6s > 3)
low_sixes_high_score_subset <- subset(fastest_fifties_tbl, Runs > 50 & X6s > 3) 
cat("\n[Method 1] Rows with Runs > 50 and 6s > 3:", nrow(low_sixes_high_score_subset), "\n")


# ==========================================
# Method 2: Using filter() (dplyr package) - FIX APPLIED
# ==========================================

# Example 1: Single Condition (Using Pipe Operator |>)
# Adapted for you: Filter for 'BF' (Balls Faced) less than 25 (a very fast fifty)
low_bf_filter <- fastest_fifties_tbl |>
  filter(BF < 25)

cat("\n[Method 2] Number of rows with BF < 25:", nrow(low_bf_filter), "\n")
print(summary(low_bf_filter$BF))


# Example 2: Multiple Conditions (Comma-Separated = AND)
# Adapted for you: 'Runs' > 80 AND '4s' > 8
# FIX 2: Using the corrected column name X4s instead of 4s
high_runs_high_fours_filter <- fastest_fifties_tbl |>
  filter(Runs > 80, X4s > 8)

cat("\n[Method 2] Rows where Runs > 80 and 4s > 8:", nrow(high_runs_high_fours_filter), "\n")
print(head(high_runs_high_fours_filter))


# Example 3: Checking for Values in a Set (%in%)
# Adapted for you: Filter where 'Player' is exactly "KL Rahul" or "Ishan Kishan"
player_filter <- fastest_fifties_tbl |>
  filter(Player %in% c("KL Rahul", "Ishan Kishan"))

cat("\n[Method 2] Number of rows with specific players:", nrow(player_filter), "\n")
print(head(player_filter))

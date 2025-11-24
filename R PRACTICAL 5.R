# Load the dplyr package
library(dplyr)

# --- ASSUMPTION: Data Loading ---
# We assume 'fastest_fifties' is loaded correctly. 
# We'll use read.csv to match the previous fix's column names (like X4s, X6s).
fastest_fifties <- read.csv("Fastest Fifties - 2018.csv") 


# ==========================================
# Example 1: Sorting by a Single Variable (Ascending)
# ==========================================
# Original Logic: Sort by 'volume' (lowest to highest)
# Adapted for you: Sort by 'BF' (Balls Faced) to find the absolute fastest fifties.

# Sort by BF (Balls Faced) in ascending order (lowest to highest)
fifties_by_speed <- fastest_fifties |> 
  arrange(BF)

cat("--- Top 5 Fastest Fifties (Lowest BF) ---\n")
# Check the first 5 rows—the lowest BF values should be at the top.
print(head(fifties_by_speed, 5))


# ==========================================
# Example 2: Sorting by a Single Variable (Descending)
# ==========================================
# Original Logic: Sort by 'high' price (highest to lowest)
# Adapted for you: Find the rows with the highest scores ('Runs').

# Sort by RUNS in descending order (highest to lowest)
fifties_by_score <- fastest_fifties |> 
  arrange(desc(Runs))

cat("\n--- Top 5 Highest Individual Scores ---\n")
# Check the first 5 rows—the highest Run values should be at the top.
print(head(fifties_by_score, 5))


# ==========================================
# Example 3: Sorting by Multiple Columns
# ==========================================
# Original Logic: Sort by 'high' (ascending), then by 'volume' (descending).
# Adapted for you: Sort first by 'BF' (Ascending, fastest scores first), and for ties, sort by 'Runs' (Descending, highest score for that speed).

# 1. Primary Sort: BF (Ascending, Lowest Balls Faced first)
# 2. Secondary Sort (Tie Breaker): Runs (Descending, Highest score first)
fifties_multi_sort <- fastest_fifties |> 
  arrange(BF, desc(Runs))

cat("\n--- Top 5 Sorted by Speed (BF) then Score (Runs) ---\n")
# The results show lower BF first, but if BF is equal, the higher Run score comes first.
print(head(fifties_multi_sort, 5))


# ==========================================
# Example 4: Combined Filter and Sort (Chaining Operations)
# ==========================================
# Original Filter: filter(high > 69.50, volume > 300)
# Adapted Filter: filter for a high score (> 80 Runs) AND high power hitting (> 5 Sixes).
# Sorting: Then, sort those results by 'X6s' (Sixes) in descending order to see the most powerful knocks first.

# Filter for high Runs and high 6s, then arrange by 6s
power_knocks_sorted <- fastest_fifties |> 
  filter(Runs > 80, X6s > 5) |> 
  arrange(desc(X6s))

cat("\n--- Top Power Knocks (Runs > 80 & 6s > 5, Sorted by 6s) ---\n")
# Check the columns for confirmation
print(power_knocks_sorted |> head(5))


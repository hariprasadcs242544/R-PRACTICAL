library(dplyr)

# ==============================================================================
# 1. SETUP: Import Data (Manual Selection)
# ==============================================================================

# Select your Cricket CSV file (Fastest Fifties...)
print("--- ACTION: Please select your CRICKET CSV file ---")
cricket_df <- read.csv(file.choose())

print("--- 1. Original Data (First 6 Rows) ---")
print(head(cricket_df))

# ==============================================================================
# 2. IDENTIFYING DUPLICATES (Same Player, Same Runs, Same Match)
# ==============================================================================
# This checks if a player has the exact same record twice (Data Entry Error?)

duplicates_report <- cricket_df %>%
  # We group by the main columns to check for identical entries
  group_by(Player, Runs, Against, Match.Date) %>%
  count() %>%
  filter(n > 1)

print("--- 2. Duplicate Report (Rows appearing more than once) ---")
print(duplicates_report)

# ==============================================================================
# 3. HANDLING DUPLICATES: Exact Matches
# ==============================================================================
# Scenario: Remove rows where EVERY column is identical.
# (e.g. If the file has the same match row copied twice)

clean_exact <- cricket_df %>%
  distinct()

print("--- 3. Removed Exact Duplicates (distinct) ---")
print(paste("Original Rows:", nrow(cricket_df)))
print(paste("Cleaned Rows:", nrow(clean_exact)))

# ==============================================================================
# 4. HANDLING DUPLICATES: Unique Players Only (.keep_all = TRUE)
# ==============================================================================
# Scenario: We want a list of UNIQUE PLAYERS.
# Yusuf Pathan appears multiple times (Rows 0, 18, 25...).
# We only want his name to appear ONCE in this list.

unique_players <- cricket_df %>%
  distinct(Player, .keep_all = TRUE)

print("--- 4. Unique Players List (Partial Duplicates removed) ---")
# This will show Yusuf Pathan only once (the first time he appears)
print(head(unique_players))

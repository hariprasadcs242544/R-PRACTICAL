# 7. Selecting and dropping variables using select() in R
# ==============================================================================
# 1. IMPORT DATASET
# ==============================================================================
library(dplyr)

# *** IMPORTANT: UPDATE FILE PATH HERE ***
# Placeholder: Use the file name from your screenshot, but you must replace 
# "path/to/your/file/" with your actual directory path, e.g., 
# "D:/HariS126/Fastest Fifties - 2018.csv"
cricket <- read.csv("path/to/your/file/Fastest Fifties - 2018.csv")

print("--- Original Dataset (First 3 rows) ---")
print(head(cricket, 3))

# ==============================================================================
# 2. SELECTING VARIABLES (Keeping Columns)
# ==============================================================================

# Method A: Select specific columns by name
# Scenario: We only want the Player Name, Runs scored, and the Opponent (Against)
selected_cols <- cricket 
  select(Player, Runs, Against)

print("--- Selected Specific Columns ---")
print(head(selected_cols, 3))

# Method B: Select a range of adjacent columns
# Scenario: Select everything from 'Player' to '4s'
range_cols <- cricket 
  select(Player:4) 
# Note: The column name '4s' is used exactly as it appears in the Excel data.

print("--- Selected Range of Columns (Player through 4s) ---")
print(head(range_cols, 3))

# Method C: Select using helper functions
# Scenario: Select columns that start with "P" (POS, Player)
starts_with_p <- cricket 
  select(starts_with("P"))

print("--- Selected columns starting with 'P' (POS, Player) ---")
print(head(starts_with_p, 3))

# ==============================================================================
# 3. DROPPING VARIABLES (Removing Columns)
# ==============================================================================
# We use the minus sign (-) to remove variables

# Method A: Drop a single specific column
# Scenario: Remove the 'Venue' column
dropped_one <- cricket 
  select(-Venue)

print("--- Dataset with 'Venue' dropped ---")
print(names(dropped_one)) # Printing names to verify it's gone

# Method B: Drop multiple columns
# Scenario: Remove '6s' and 'BF' (Balls Faced)
dropped_multiple <- cricket
  select(-6, -BF)
# Note: The column name '6s' is used exactly as it appears in the Excel data.

print("--- Dataset with '6s' and 'BF' dropped ---")
print(names(dropped_multiple))

# Method C: Drop a range of columns
# Scenario: Remove everything from '4s' to 'Match_Date'
dropped_range <- cricket 
  select(-(4:MatchDate))

print("--- Dataset with range '4s' to 'Match_Date' dropped ---")
print(names(dropped_range))


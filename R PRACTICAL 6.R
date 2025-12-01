# ==========================================
# Pract 6. Merge and Append (Adapted for Cricket Data)
# ==========================================

library(dplyr) # Loads the necessary library for data manipulation

# ------------------------------------------
# 1. SETUP: Load Your Actual Data
# ------------------------------------------

# *** UPDATED TO USE YOUR FILE PATH ***
cricket_data <- read.csv("D:/HariS126/Fastest Fifties - 2018.csv")

# Use head() on the loaded data to show the first few rows were successfully read
print("--- Main Data Loaded (First 6 Rows) ---")
print(head(cricket_data))

# Prepare subsets for the APPEND example:
# Batch 1: First 5 records
batch_1 <- head(cricket_data, 5) 
# Batch 2: Next 5 records (Rows 6 through 10)
# Note: Ensure your CSV has at least 10 rows for this to work perfectly.
batch_2 <- cricket_data[6:10, ]

# Dataset 3: Team Names Table (To practice Merging)
# This table includes common team abbreviations from your data
team_lookup <- data.frame(
  Against = c("CSK", "MI", "KKR", "DC", "RCB", "SRH", "PBKS", "RR"),
  Full_Team_Name = c("Chennai Super Kings", "Mumbai Indians",
                     "Kolkata Knight Riders", "Delhi Capitals", 
                     "Royal Challengers Bangalore", "Sunrisers Hyderabad", 
                     "Punjab Kings", "Rajasthan Royals")
)

# ------------------------------------------
# 2. APPEND (Stacking Rows)
# ------------------------------------------
# Goal: Combine two different sections of the main dataset vertically.
final_player_list <- bind_rows(batch_1, batch_2)

print("--- Appended Data (Rows 1-10 combined) ---")
print(final_player_list)


# ------------------------------------------
# 3. MERGE (Joining Columns)
# ------------------------------------------
# Goal: Add a new column (Full_Team_Name) to the main dataset by matching
# the common column 'Against' (the team abbreviation).
merged_data <- merge(cricket_data, team_lookup, by = "Against", all.x = TRUE)

print("--- Merged Data (Full Team Names Added) ---")
# Using head() to keep the output clean, showing the new 'Full_Team_Name' column
print(head(merged_data))


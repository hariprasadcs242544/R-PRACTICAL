library(dplyr)
library(tidyr)

# ==============================================================================
# 1. SETUP: Import the Dataset (Modified for 'Fastest Fifties - 2018.csv')
# ==============================================================================

# FIX 1: Updated file path to match the 'Fastest Fifties - 2018.csv' file
df <- read.csv("D:/HariS126/Fastest Fifties - 2018.csv", na.strings = c("", "NA"))

# Check the actual column names after import
print("--- Actual Column Names ---")
print(names(df))

# PRE-CLEANING:
# We fill missing Runs, BF, and boundaries with 0.
df_clean <- df %>%
  mutate(
    Runs = replace_na(Runs, 0),
    BF = replace_na(BF, 0),
    
    # FIX 2: Assuming R renamed '4s' and '6s' to 'X4s' and 'X6s'
    X4s = replace_na(X4s, 0),
    X6s = replace_na(X6s, 0)
  )

print("--- Cleaned Baseline Data ---")
print(head(df_clean))

#==============================================================================
# 2. METHOD A: ARITHMETIC CALCULATIONS
#==============================================================================
# Scenario: Calculate the 'Strike Rate'.
# Formula: (Runs / Balls Faced) * 100
# IMPORTANT: Use ifelse to prevent division by zero (BF = 0)

df_calc <- df_clean %>%
  mutate(
    # Handle division by zero: if BF is 0, SR is 0; otherwise, calculate SR.
    Strike_Rate = ifelse(
      BF == 0,
      0,
      round((Runs / BF) * 100, 2)
    )
  )

print("--- Method A: Arithmetic Results (Strike Rate) ---")
print(head(df_calc %>% select(Player, Runs, BF, Strike_Rate)))

#==============================================================================
# 3. METHOD B: CONDITIONAL LOGIC (ifelse)
#==============================================================================
# Scenario: Label the inning based on speed and boundaries.
# Logic 1: If Strike Rate is extremely high (> 250), it's "Savage".
# Logic 2: If they hit 7 or more 6s, they are a "Maximum Hitter".

df_logic <- df_calc %>%
  mutate(
    Inning_Type = ifelse(Strike_Rate > 250, "Savage", 
                         ifelse(Strike_Rate > 200, "Explosive", "Standard")),
    
    # FIX 3: Updated to use X6s here
    Player_Badge = ifelse(X6s >= 7, "Maximum Hitter", "Solid Striker")
  )

print("--- Method B: Logic Results (Labels) ---")
print(head(df_logic %>% select(Player, Strike_Rate, Inning_Type, X6s, Player_Badge)))

#==============================================================================
# 4. METHOD C: TEXT TRANSFORMATION (paste)
#==============================================================================
# Scenario: Create a short sentence summary for a news report.
# Format: "[Player] hit [Runs] runs off [BF] balls against [Against]"

df_text <- df_calc %>%
  mutate(
    Match_Summary = paste(Player, "hit", Runs, "runs off", BF, "balls against", Against)
  )

print("--- Method C: Text Transformation ---")
print(head(df_text$Match_Summary))

#==============================================================================
# 5. ALL TOGETHER (The Standard Workflow)
#==============================================================================

final_dataset <- df_clean %>%
  mutate(
    # Recalculate SR with safety check
    Strike_Rate = ifelse(BF == 0, 0, round((Runs / BF) * 100, 2)),
    
    # Check if a player scored a high-impact knock (High SR AND High Runs)
    Is_High_Impact = ifelse(Runs > 60 & Strike_Rate > 200, TRUE, FALSE),
    
    Report = paste0(Player, " (SR: ", Strike_Rate, ", ", X6s, " Sixes)")
  )

print("--- Final Combined Dataset ---")
print(head(final_dataset %>% select(Player, Report, Is_High_Impact)))
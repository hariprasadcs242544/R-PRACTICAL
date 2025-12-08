library(dplyr)
library(tidyr)

# ======================================================================
# 1. IMPORT BOTH CSV FILES
# ======================================================================

print("Select FIRST cricket CSV (Most Dot Balls...)")
dotballs_df <- read.csv(file.choose())     # 150 rows

print("Select SECOND cricket CSV (Fastest Fifties...)")
fifties_df <- read.csv(file.choose())      # 107 rows


# ======================================================================
# 2. CLEAN + PROPER COLUMN NAMES FOR BOTH DATASETS
# ======================================================================

# ---- CSV 1: Most Dot Balls ----
dotballs_clean <- dotballs_df %>%
  rename(
    POS = POS,
    Player = Player,
    Overs = Ov,
    Runs = Runs,
    Wickets = Wkts,
    Maidens = Maid,
    Dot_Balls = Dots,
    SR = SR,
    Against = Against,
    Venue = Venue
  ) %>%
  mutate(
    Category = "Dot Balls"
  ) %>%
  select(Player, Runs, SR, Against, Venue, Category)


# ---- CSV 2: Fastest Fifties ----
# Fix header row: V1..V9 ??? proper names
names(fifties_df) <- c("POS","Player","Runs","BF","Fours","Sixes",
                       "Against","Venue","MatchDate")

fifties_clean <- fifties_df %>%
  mutate(
    SR = (Runs / BF) * 100,
    Category = "Fastest Fifties"
  ) %>%
  select(Player, Runs, SR, Against, Venue, Category)


# ======================================================================
# 3. COMBINE BOTH DATASETS (Now same columns)
# ======================================================================

combined_data <- bind_rows(dotballs_clean, fifties_clean)

print("--- Combined Data Summary ---")
print(paste("Dot Balls Rows:", nrow(dotballs_clean)))
print(paste("Fifties Rows:", nrow(fifties_clean)))
print(paste("Total Combined Rows:", nrow(combined_data)))

print("--- Combined Data Preview ---")
print(head(combined_data))
print(tail(combined_data))


# ======================================================================
# 4. OPTIONAL: Save final combined CSV
# ======================================================================
write.csv(combined_data, "Combined_Cricket_Data.csv", row.names = FALSE)


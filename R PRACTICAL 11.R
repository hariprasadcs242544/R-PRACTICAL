library(dplyr)
library(tidyr)

# =====================================================================
# 1. LOAD AND CLEAN FASTEST FIFTIES DATA
# =====================================================================

file_path <- "D:/haris126/Fastest fifties.csv"
Fastest_Fifties <- read.csv(file_path, header = TRUE)

# Fix column names because your CSV uses V1, V2 ... but actual names are inside row 1
colnames(Fastest_Fifties) <- c("POS", "Player", "Runs", "BF", "X4s", "X6s", 
                               "Against", "Venue", "MatchDate")

# Clean data
ipl_data_clean <- Fastest_Fifties %>%
  mutate(
    Runs = as.numeric(Runs),
    BF   = as.numeric(BF),
    X4s  = as.numeric(X4s),
    X6s  = as.numeric(X6s),
    FiftyID = row_number(),
    Strike_Rate = (Runs / BF) * 100
  ) %>%
  filter(!is.na(BF) & Runs >= 50) %>%
  select(FiftyID, Player, Runs, BF, Strike_Rate, X4s, X6s, Against, Venue)

print("--- 1. Cleaned Data ---")

print(head(ipl_data_clean))

# =====================================================================
# 2. PIVOT LONGER (4s and 6s)
# =====================================================================

long_boundaries <- ipl_data_clean %>%
  pivot_longer(
    cols = c(X4s, X6s),
    names_to = "BoundaryType",
    values_to = "Count"
  )

print("--- 2. Long Boundary Data ---")
print(head(long_boundaries))

# =====================================================================
# 3. PIVOT WIDER (Reverse)
# =====================================================================

wide_boundaries <- long_boundaries %>%
  pivot_wider(
    names_from = BoundaryType,
    values_from = Count
  )

print("--- 3. Wide Boundaries Reconstructed ---")
print(head(wide_boundaries))

# =====================================================================
# 4. PLAYER vs OPPONENT SR MATRIX
# =====================================================================

opponent_avg_sr <- ipl_data_clean %>%
  group_by(Player, Against) %>%
  summarise(
    Avg_Strike_Rate = mean(Strike_Rate),
    .groups = "drop"
  )

opponent_pivot <- opponent_avg_sr %>%
  pivot_wider(
    names_from = Against,
    values_from = Avg_Strike_Rate,
    values_fill = NA
  )

print("--- 4. Player vs Opponent Strike Rate Pivot ---")
print(head(opponent_pivot))

# Load necessary libraries
library(dplyr) # Required for the count() function

# Use file.choose() to open a dialog box so you can manually select the CSV file.
df <- read.csv(file.choose(), stringsAsFactors = FALSE)

# --- Check Column Names ---
print("--- Column Names in the Dataframe ---")
print(names(df))

# --- 2. Frequency Tables (Opponent Distribution) ---
print("--- 2. Frequency Tables (Opponent Distribution) ---")

# A. Using Base R table()
# Good for: Simple counts of a categorical variable (Against team)
print("A. Base R table() for Opponent Teams:")
opponent_counts <- table(df$Against)
print(opponent_counts)

# B. Using dplyr::count()
# Good for: Dataframe output (easier to use in plots later)
print("B. dplyr::count() for Opponent Teams (Dataframe):")
opponent_df <- df %>% count(Against)
print(opponent_df)
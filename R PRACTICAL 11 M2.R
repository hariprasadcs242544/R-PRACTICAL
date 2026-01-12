# Load ggplot2 library
library(ggplot2)

# Load the data manually
data <- read.csv(file.choose())

# Clean column names (R often adds dots for spaces or symbols)
# '4s' and '6s' usually become 'X4s' and 'X6s'
# 1. HISTOGRAM
# We use 'binwidth' to group the runs.
ggplot(data, aes(x = Runs)) +
  geom_histogram(binwidth = 2, fill = "steelblue", color = "white") +
  labs(
    title = "Distribution of Runs (2016 Season)",
    x = "Runs Scored in an Over",
    y = "Frequency (Count)"
  ) +
  theme_minimal()
# Get top 5 players by their total appearances in this list
top_players <- names(sort(table(data$Player), decreasing = TRUE)[1:5])
subset_data <- data[data$Player %in% top_players, ]

# 2. BOX PLOT
ggplot(subset_data, aes(x = Player, y = Runs, fill = Player)) +
  geom_boxplot(outlier.color = "red", outlier.shape = 8) +
  # Adding 'jitter' allows you to see the individual data points on the box
  geom_jitter(width = 0.2, alpha = 0.5) +
  labs(
    title = "Runs Consistency: Top 5 Frequent Players",
    subtitle = "Horizontal line is the Median; Red dots are potential outliers",
    x = "Player Name",
    y = "Runs Scored"
  ) +
  theme_light() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# 1. Load the library
library(ggplot2)

# 2. Load your data (Select the CSV file when the window opens)
data <- read.csv(file.choose())

# 3. Filter for only the first 5 rows
top_5 <- head(data, 5)

# 4. Create the Scatter Plot
# We map 'Player' to 'color' to ensure each of the 5 points gets a different color
ggplot(top_5, aes(x = Econ, y = Wkts, color = Player)) +
  geom_point(size = 6) +
  # Add labels to the points
  geom_text(aes(label = Player), vjust = -1.5, size = 4) +
  # Assign 5 specific professional colors
  scale_color_manual(values = c("red", "blue", "green", "orange", "purple")) +
  # Add report labels
  labs(
    title = "Economy vs Wickets: Top 5 Bowlers",
    subtitle = "Points visualized with distinct colors",
    x = "Economy Rate (Econ)",
    y = "Total Wickets (Wkts)"
  ) +
  # Clean theme for a professional look
  theme_minimal() +
  # Extend the y-axis slightly so labels don't get cut off
  expand_limits(y = max(top_5$Wkts) + 2)

# --- 2. PIE CHART ---
# In R, columns starting with numbers (like 4w) are imported as X4w
# We filter for players who actually have at least one 4-wicket haul
pie_data <- subset(data, X4w > 0)

pie_chart <- ggplot(pie_data, aes(x = "", y = X4w, fill = Player)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  labs(title = "Distribution of 4-Wicket Hauls",
       fill = "Player") +
  theme_void()

print(pie_chart)

# --- 3. HIGH-LOW CHART (Error Bar / Range Chart) ---
# We sort by Wickets descending and take the top 10
top_10 <- head(data[order(-data$Wkts), ], 10)

high_low_chart <- ggplot(top_10, aes(x = reorder(Player, -Wkts), y = Avg)) +
  geom_point(size = 3, color = "red") +
  # geom_errorbar needs a ymin and ymax to create the 'high-low' look
  geom_errorbar(aes(ymin = Avg - 2, ymax = Avg + 2), width = 0.2) +
  labs(title = "Average Performance Range (Top 10 Bowlers)",
       x = "Player",
       y = "Bowling Average") +
  theme_minimal() +
  # Rotates the names so they don't overlap on the X-axis
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

print(high_low_chart)


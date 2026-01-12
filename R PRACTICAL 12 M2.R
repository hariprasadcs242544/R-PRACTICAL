# Load the data
data <- read.csv(file.choose())
# 1. Select only numeric columns for correlation
# Columns like 'Player', 'Against', and 'Venue' are excluded
numeric_data <- data[, sapply(data, is.numeric)]

# 2. Remove the 'POS' column if it exists, as it is just an index
numeric_data <- numeric_data[, !(names(numeric_data) %in% c("POS"))]

# 3. Generate the correlation matrix using cor()
cor_matrix <- cor(numeric_data, use = "complete.obs")

# 4. Print the matrix to the console
print(cor_matrix)
library(ggplot2)
library(reshape2) # Required to 'melt' the matrix for ggplot

# Convert the matrix into a format ggplot understands
melted_cor <- melt(cor_matrix)

# Create the Heatmap
ggplot(data = melted_cor, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white", 
                       midpoint = 0, limit = c(-1,1)) +
  theme_minimal() +
  labs(title = "Correlation Heatmap of Player Stats",
       x = "", y = "", fill = "Correlation")


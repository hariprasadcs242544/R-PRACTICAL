print("Name: S126 Hariprasad")

# 1. Manually select your CSV file from your computer
# This opens a file explorer window. Locate your file and click 'Open'.
data <- read.csv(file.choose())

# 2. Perform the One-Way ANOVA
# Formula format: numeric_variable ~ categorical_variable
anova_result <- aov(Runs ~ Against, data = data)

# 3. View the ANOVA summary table
summary(anova_result)

# 4. Preview the first few rows of the data
head(data)

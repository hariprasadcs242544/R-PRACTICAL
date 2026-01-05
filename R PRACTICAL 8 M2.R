print("Name: S126 Hariprasad")

# 1. Select the 'Most Runs - 2020.csv' file manually
data <- read.csv(file.choose())

# 2. Prepare the data
# Convert '100' and '50' columns into Factors (Categories) for ANOVA
# This allows us to see if having a 100 or a 50 significantly impacts total Runs
data$Has_100 <- as.factor(ifelse(data$X100 > 0, "Yes", "No"))
data$Has_50 <- as.factor(ifelse(data$X50 > 0, "Yes", "No"))

# 3. Perform Two-Way ANOVA
# Aim: Test if total 'Runs' are affected by scoring a Century and/or a Half-Century
anova_result <- aov(Runs ~ Has_100 * Has_50, data = data)

# 4. View the ANOVA table results
summary(anova_result)

# 5. Preview the processed data
head(data[, c("Player", "Runs", "Has_100", "Has_50")])

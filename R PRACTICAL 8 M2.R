print("Name: S126 Hariprasad")

# Use file.choose() to select your CSV file manually
data <- read.csv(file.choose())

# Perform Two-Way ANOVA
# Formula: numeric ~ category1 + category2
# This tests the effect of both 'Against' and 'Venue' on 'Runs'
anova_result <- aov(Runs ~ Against + Venue, data = data)

# View the ANOVA table results
summary(anova_result)

# Preview the dataset
head(data)
print("Name: S126 hariprasad")

# 1. Use file.choose() to manually select your 'Fastest Fifties - 2022' CSV file
data <- read.csv(file.choose())

# 2. Create a contingency table for the two categorical variables
# We compare the opponent team (Against) with the stadium (Venue)
table_data <- table(data$Against, data$Venue)

# 3. Perform the Chi-square test
chisq_result <- chisq.test(table_data)

# 4. View the results (Chi-square value, degrees of freedom, and p-value)
chisq_result

# 5. Preview the first few rows of the data
head(data)
# Ensure library is loaded
library(writexl)

# 1. Choose file and run model
data <- read.csv(file.choose())
model <- lm(Runs ~ Dots, data = data)

# 3. Perform Linear Regression Analysis
# Aim: Predicting 'Runs' based on 'Dots'
model <- lm(Runs ~ Dots, data = data)

# 4. Show the statistical summary in the console
summary(model)

# 5. Create the results object (FIX: This defines results_df)
# We extract the coefficients table from the model summary
results_df <- as.data.frame(summary(model)$coefficients)

# 6. Plotting the results
plot(data$Dots, data$Runs, 
     main = "Regression: Dots vs Runs",
     xlab = "Dots Bowled", 
     ylab = "Runs Conceded", 
     pch = 16, col = "darkgreen")

# Add the regression line
abline(model, col = "red", lwd = 2)

# 7. Save the results to an Excel file
# (FIX: results_df is now defined, so this will work)
write_xlsx(results_df, "Regression_Results.xlsx")


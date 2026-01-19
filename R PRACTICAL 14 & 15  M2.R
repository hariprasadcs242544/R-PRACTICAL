# 1. Load the required library for Excel export
library(writexl)

# 2. Select and read your 'Most Sixes' CSV file
file_path <- file.choose()
data <- read.csv(file_path)

# 3. Create a binary outcome (This is necessary for Logistic Regression)
# 1 = Success (Runs > 80), 0 = Failure (Runs <= 80)
data$High_Score <- ifelse(data$Runs > 80, 1, 0)

# 4. Perform Logistic Regression Analysis
# We predict the probability of a High_Score based on 6s hit
logit_model <- glm(High_Score ~ X6s, data = data, family = "binomial")

# 5. Show the summary in your console for viva answers
summary(logit_model)

# 6. Plot the results (This shows the graph in RStudio)
plot(data$X6s, data$High_Score, 
     main = "Logistic Regression: Sixes vs High Score",
     xlab = "Number of Sixes", 
     ylab = "Probability of High Score (0 to 1)", 
     pch = 16, col = "darkblue")

# Add the logistic sigmoid curve
curve(predict(logit_model, data.frame(X6s = x), type = "response"), 
      add = TRUE, col = "red", lwd = 2)

# 7. Exporting results into external files
# Save the Graph as a PDF (This captures what is on your screen)
dev.copy(pdf, "Logistic_Sixes_Plot.pdf")
dev.off() 

# Extract coefficients and save to Excel
# Ensure the Excel file is CLOSED before running this!
results_df <- as.data.frame(summary(logit_model)$coefficients)
write_xlsx(results_df, "Logistic_Results.xlsx")

# Save results to CSV
write.csv(results_df, "Logistic_Results.csv")

print("Logistic Regression Complete! PDF, Excel, and CSV files have been saved.")
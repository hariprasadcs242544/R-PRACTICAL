# Load the psych library, which contains the 'describe' function
library(psych)

# Use file.choose() to open a dialog box so you can manually select the CSV file.
df <- read.csv(file.choose(), stringsAsFactors = FALSE)

# --- Data Cleaning Fix (Robust Method) ---
# FIX: Use column index (position) to access the '4s' (5th) and '6s' (6th) columns 
# to ensure R correctly converts them to numeric, avoiding naming issues.

# Column 5 (4s)
df[, 5] <- as.numeric(df[, 5])
# Column 6 (6s)
df[, 6] <- as.numeric(df[, 6])
# ----------------------------------------

print("--- Column Names in the Dataframe ---")
print(names(df))
print("--- Dataframe Head ---")
print(head(df))


print("--- 1. Base R Summary Statistics ---")

print("Summary of Runs Scored:")
summary(df$Runs)

print("Summary of Balls Faced (BF):")
summary(df$BF)

# Summary of 4s should now work
print("Summary of 4s (Fours):")
summary(df$four) 


print("--- 2. Detailed Statistics (psych::describe) ---")

print("Detailed Description of Runs Scored:")
describe(df$Runs)

print("Detailed Description of Balls Faced (BF):")
describe(df$BF)

# Detailed description of 6s should now work
print("Detailed Description of 6s (Sixes):")
describe(df$six)

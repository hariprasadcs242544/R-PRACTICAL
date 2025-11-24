install.packages(c("readr", "psych"))

library(readr)    # For efficient data reading
library(psych)    # For descriptive statistics

my_data <- read.csv("Fastest.Fifties.csv")

# View the first few rows
head(Fastest.Fifties)

# View the last few rows
tail(Fastest.Fifties)

# Get the dimensions (rows and columns)
dim(Fastest.Fifties)

# Get the dimensions (rows and columns)
cat("Dimensions (Rows, Columns): ", dim(Fastest.Fifties), "\n")

# Get the structure (variable types and number of observations)
str(Fastest.Fifties )


# See a summary of the dataset
summary(Fastest.Fifties)

# Get the column names
names(Fastest.Fifties)
cat("Column Names: ", names(Fastest.Fifties), "\n")

# Use the 'psych' package for more detailed descriptive statistics
# 'describe()' provides: n, mean, sd, median, trimmed mean, mad, min, max, range, skew, kurtosis, and se.
describe(Fastest.Fifties)



# MES 503 Coding Exercise: Functions in R
# Kayla Blincow
# 10/6/2026

#------------------------------------------------------------------------------
# INTRODUCTION

# A function in R is a reusable piece of code that performs a specific task. 
# Functions can take inputs, perform some operation on those inputs, and return an 
# output. You have already used many built-in R functions, such as mean(), sum(), 
# and ggplot().
# 
# You can also write your own functions. This is especially useful when you find 
# yourself copying and pasting the same—or very similar—code repeatedly to perform a 
# repetitive task. Instead of rewriting the code each time, you can turn it into a 
# function and then simply call the function whenever you need it.
# 
# Writing your own functions can make your code shorter, easier to read, less 
# repetitive, and less prone to errors. If you need to change how the task is 
# performed later, you only have to update the function once rather than finding and 
# changing every copy of the code.

#------------------------------------------------------------------------------

# Take a look at the code for a function in base R:
aov

# We aren't going to go through this line by line to see what's going on, but 
# you should understand that all of the built in functions we have been using 
# have code underlying them that allows them to perform a specific task.

#------------------------------------------------------------------------------

# You can write your own functions!

# For example:
square_number <- function(x) {
  x^2
}

square_number(x = temperature)
# [1] 25

square_number(10)
# [1] 100

# Here, x is the input argument, x^2 is the calculation the function performs, and the 
# result is the output. Once the function is created, you can use it with 
# different numbers without having to rewrite the calculation.


#------------------------------------------------------------------------------

# The coding exercise from last week relied on a function that I wrote: mysteryfunction()
# The code for that function is included below.

# Take some time to consider what it was you did last week in the context of 
# the code underlying the function. What do each of the arguments mean?

mysteryfunction <- function(arg1, arg2, arg3, arg4, arg5){
  # Generate points for a smooth math-based smile curve (parabola)
  smile_x <- seq(-0.4, 0.4, length.out = arg1)
  smile_y <- 2 * (smile_x)^2 - 0.4  # y = ax^2 + c
  
  smile_data <- data.frame(x = smile_x, y = smile_y)
  
  ggplot() +
    # Face Outline (Using a single large point)
    annotate("point", x = 0, y = 0, size = 95, color = arg2) +
    # Eyes
    annotate("point", x = c(-0.3, 0.3), y = c(0.2, 0.2), size = arg3, color = "#2C3E50") +
    # Smile Curve
    geom_path(data = smile_data, aes(x = x, y = y), color = "#2C3E50", size = arg4, lineend = "round") +
    # Greeting Text
    annotate("text", x = 0, y = arg5, label = "Super Job!", 
             size = 7, fontface = "bold", color = "#2C3E50") +
    # Format constraints
    coord_fixed(xlim = c(-1.2, 1.2), ylim = c(-1.1, 1.1)) +
    theme_void()
}

# Try implementing the function putting reasonable values in for the arguments.
#WRITE CODE HERE

mysteryfunction(arg1 = 50, arg2 = "hotpink", arg3 = 5, arg4 = 3, arg5 =1)

#------------------------------------------------------------------------------
# SIDE NOTE: Using {{ }} with ggplot() Functions

# When you write a function that creates a ggplot, you may want the user to 
# specify which variable should be plotted. This is where the {{ }} syntax 
# becomes useful.

# Normally, ggplot() uses unquoted column names, like this:
marine_data <- read.csv("Week 8/reefwater.csv")

ggplot(marine_data, aes(x = temperature, y = oxygen)) +
  geom_point()

# We might try writing a function to repeat this plot that looks like this:

plot_relationship <- function(data, xvar, yvar) {
  ggplot(data, aes(x = xvar, y = yvar)) +
    geom_point()
}

plot_relationship(marine_data, temperature, oxygen)
#OOPS! We get an error message!

# Inside a function, R needs a way to understand that the variable supplied to 
# the function should be treated as a column in the dataset. Wrapping the function 
# argument in double curly braces, {{ }}, tells ggplot() to use the column that 
# was supplied as the argument.

#For example:
  
plot_relationship <- function(data, x, y) {
    ggplot(data, aes(x = {{x}}, y = {{y}})) +
      geom_point()
  }

# Now we can use the function with different variables:
plot_relationship(marine_data, temperature, oxygen)
plot_relationship(marine_data, salinity, oxygen)
plot_relationship(bb, Bluebonnets, Fertilizer)

# The {{ }} syntax is particularly useful when writing tidyverse functions that 
# work with column names. It allows us to write a single function that can be 
# reused with many different variables without having to type the plotting code 
# repeatedly.



#-------------------------------------------------------------------------------

# Consider the code below:

# We want to calculate the mean, standard deviation,
# minimum, and maximum for several environmental variables.

# Temperature
temp_mean <- mean(marine_data$temperature, na.rm = TRUE)
temp_sd <- sd(marine_data$temperature, na.rm = TRUE)
temp_min <- min(marine_data$temperature, na.rm = TRUE)
temp_max <- max(marine_data$temperature, na.rm = TRUE)

# Salinity
salinity_mean <- mean(marine_data$salinity, na.rm = TRUE)
salinity_sd <- sd(marine_data$salinity, na.rm = TRUE)
salinity_min <- min(marine_data$salinity, na.rm = TRUE)
salinity_max <- max(marine_data$salinity, na.rm = TRUE)

# Dissolved oxygen
oxygen_mean <- mean(marine_data$oxygen, na.rm = TRUE)
oxygen_sd <- sd(marine_data$oxygen, na.rm = TRUE)
oxygen_min <- min(marine_data$oxygen, na.rm = TRUE)
oxygen_max <- max(marine_data$oxygen, na.rm = TRUE)

# Turbidity
turbidity_mean <- mean(marine_data$turbidity, na.rm = TRUE)
turbidity_sd <- sd(marine_data$turbidity, na.rm = TRUE)
turbidity_min <- min(marine_data$turbidity, na.rm = TRUE)
turbidity_max <- max(marine_data$turbidity, na.rm = TRUE)


#------------------------------------------------------------------------------
# Student Challenge

# Your task: Simplify the code above by Writing a function that calculates the 
# mean, standard deviation, minimum, and maximum for a numeric variable.

# Your function should:
# - Take a numeric vector as its input.
# - Calculate the mean, standard deviation, minimum, and maximum.
# - Return all four values.
# - Use na.rm = TRUE so that missing values do not cause problems.

# Use your function to calculate the summary statistics for temperature, 
# salinity, oxygen, and turbidity.

# Hint: Your function should have a structure something like this:
summarize_variable <- function(x,y) {

  results <- data.frame(variable = y,
             mean = NA,
             sd = NA,
             min = NA,
             max = NA)
  
  
    for(i in 1:ncol(x)){
    results$mean[i] <- mean(x[,i], na.rm = TRUE)
    results$sd[i] <- sd(x[,i], na.rm = TRUE)
    results$min[i] <- min(x[,i], na.rm = TRUE)
    results$max[i] <- max(x[,i], na.rm = TRUE)
    }
  results
}

# Then you should be able to do something like:
summarize_variable(x=marine_data[,2:5], y = names(marine_data)[2:5])


# Bonus Challenge:# Bonus Challenturbidityge:
# Modify your function so that it returns a data frame with four rows and five 
# columns: variable, mean, sd, min, and max.


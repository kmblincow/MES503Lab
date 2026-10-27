# MES 503 Coding Exercises: Closing the loop on dates/times and functions in R
# Kayla Blincow
# 10/20/2026


#clear your workspace
rm(list = ls())

#load packages
library(tidyverse) 

#### FUNCTIONS ####
marine_data <- read.csv("Week 8/reefwater.csv")

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

summarize_variable <- function(x){
  mean_var <- mean(x, na.rm = T)
  sd_var <- sd(x, na.rm = T)
  min_var <- min(x, na.rm = T)
  max_var <- max(x, na.rm = T)
  c(mean = mean_var, sd = sd_var, min = min_var, max = max_var)
}
summarize_variable(marine_data$turbidity)



# Bonus Challenge:# Bonus Challenge:
# Modify your function so that it returns a data frame with four rows and five 
# columns: variable, mean, sd, min, and max.
summarize_variable <- function(x,y) {
  
  results <- data.frame(variable = y,
                        mean_var = NA,
                        sd_var = NA,
                        min_var = NA,
                        max_var = NA)
  
  
  for(i in 1:ncol(x)){
    results$mean_var[i] <- mean(x[,i], na.rm = TRUE)
    results$sd_var[i] <- sd(x[,i], na.rm = TRUE)
    results$min_var[i] <- min(x[,i], na.rm = TRUE)
    results$max_var[i] <- max(x[,i], na.rm = TRUE)
  }
  results
}

summarize_variable(x=marine_data[,2:5], y = names(marine_data)[2:5])




####DATES!####

# Let's work with some real data Sommer shared with me!

# These data include observations of humpback whale calls on a single glider 
# expedition around St. Croix. Each row of data represents a confirmed humpback
# call and includes timestamps for the start of the call, the end of the call, and 
# the middle of the call (av_datetime_UTC). There is also information on the glider 
# location, and the oceanographic conditions experienced at that location.


#read in the data
whales <- read.csv("Week 9/calc_humpback_points_p26920.csv")



# Use the date/time wrangling skills above to address the following questions,
# create a visual for each:
# 1. How many days did this glider expedition last? (no visual needed)
# 2. Does the number of humpback calls differ based on the hour of the day?
# 3. Which date had the highest number of humpback calls? What day of the week 
# (i.e. Saturday? Sunday? Monday?) was that date? Create a visual showing call
# count by date with the bars colored based on the day of the week.



# EXTRA CHALLENGE 1:
# Does the number of humpback calls recorded during nighttime hours differ from
# daytime hours? 

# NOTE: The timing of sunset/sunrise depends on the time of the year and location 
# on the earth. You can use the functions in the suncalc package to determine the
# timing of sunset/sunrise from these data.


# EXTRA CHALLENGE 2:
# What was the longest stretch of time between humpback call observations? 
# What was the average length of time between humpback call observations?






# STARTING HINT: Does R know your date/time columns are dates/times?
whales$av_datetime_UTC <- ymd_hms(whales$av_datetime_UTC)
whales$start_datetime_UTC <- ymd_hms(whales$start_datetime_UTC)
whales$end_datetime_UTC <- ymd_hms(whales$end_datetime_UTC)


# Q1
range(whales$end_datetime_UTC)[2] - range(whales$end_datetime_UTC)[1] 

# Q2
whales$hour <- hour(whales$av_datetime_UTC)

ggplot(whales, aes(x = hour)) +
  geom_bar()

# Q3
whales$date <- date(whales$av_datetime_UTC)
ggplot(whales, aes(x = date, fill = wday(date, label = T, abbr = F))) +
  geom_bar() +
  labs(x = "Date", y = "Call Count", fill = "Day of the Week")


# EXTRA CHALLENGE 1
library(suncalc)
suntimes <- whales |> select(date, av_latitude_DD, av_longitude_DD) |> 
  rename(date = date, lat = av_latitude_DD, lon = av_longitude_DD)
sunlight <- getSunlightTimes(data = suntimes, keep = c("sunrise", "sunset"))
whales$sunset <- sunlight$sunset
whales$sunrise <- sunlight$sunrise


whales$DN <- ifelse(whales$av_datetime_UTC < whales$sunset & whales$av_datetime_UTC > whales$sunrise,
                    "D", "N")


ggplot(whales, aes(x = hour, fill = DN)) +
  geom_bar()

ggplot(whales, aes(x = DN, fill = DN)) +
  geom_bar()

# EXTRA CHALLENGE 2
whales <- arrange(whales, start_datetime_UTC)
whales$timesincelast <- NA
for(i in 2:nrow(whales)){
  whales$timesincelast[i] <- difftime(whales$start_datetime_UTC[i], 
                                      whales$end_datetime_UTC[i-1],
                                      units = "secs")
}

#longest length of time between calls
range(whales$timesincelast, na.rm = T)[2] #in seconds
range(whales$timesincelast, na.rm = T)[2]/60 #in minutes
range(whales$timesincelast, na.rm = T)[2]/86400 #in days

#average length of time between calls
mean(whales$timesincelast, na.rm = T)




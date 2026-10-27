# MES 503 -ANOVA in R + Data Wrangling Exercise
# Kayla Blincow
# 9/29/2026


# The purpose of this script is to practice data wrangling, especially joins, 
# and ANOVAs. 

# clear my workspace
rm(list =ls())

# load packages
library(tidyverse)
library(car) # Levene's Test function is in this package (you might need to install)
library(learnr) # you might need to install

# JOINS DEMO

#Create two separate data files
squid_data <- tibble(
  squid_id = 1:30,
  site_id = rep(c("S01", "S02", "S03", "S04", "S05"), each = 6),
  mantle_length = c(
    18, 21, 20, 19, 22, 20,
    25, 27, 24, 26, 28, 25,
    21, 23, 22, 24, 20, 22,
    30, 32, 29, 31, 33, 30,
    25, 27, 26, 28, 24, 26
  )
)

squid_data

site_data <- tibble(
  site_id = c("S01", "S02", "S03", "S04", "S05"),
  habitat = c(
    "Coral Reef",
    "Seagrass",
    "Mangrove",
    "Rocky Reef",
    "Sandy Bottom"
  )
)

site_data

# In squid_data we have measurements of individual squid, including mantle 
# length and the site where each squid was captured.
# However, we do NOT have the habitat type in this dataset.

# In site_data, each row represents one sampling site. These data tell us what 
# habitat each site represents.

# The datasets have one variable in common: site_id
# We can use site_id to connect the datasets.

squid_joined <- left_join(
  squid_data,
  site_data,
  by = "site_id"
)

squid_joined
#Notice that habitat has now been added to squid_data...

# YOU SHOULD ALWAYS CHECK THAT THE JOIN WORKED

# How many observations did we start with?
nrow(squid_data)

# How many observations do we have after the join?
nrow(squid_joined)

#These should be the same for a successful left join.

#Check how many squid we have from each habitat
count(squid_joined, habitat)

# Check for missing habitat information
sum(is.na(squid_joined$habitat))

#If this returns 0, every squid was successfully matched to a habitat.




#-----------------------------------------------------------------------------


# OKAY JOINS DEMONSTRATED...
# Now for the fun part.

# RUN THIS CODE! UPDATE THE FILE PATH TO WHEREVER YOU STORED mysteryfunction.R
source("Week 7/mysteryfunction.R")
#after running this you should see a new function in your environment call "mysteryfunction"

# mysteryfunction() is a mystery function that I created. In order to see what 
# it does, you need to find out the correct values to supply for it's arguments.

# There are five arguments: arg1, arg2, arg3, arg4, and arg5
mysteryfunction(arg1 = ?, arg2 = ?, arg3 = ?, arg4 = ?, arg5 = ?)

# To discover the correct values for the arguments to make the function work
# you must answer the following questions using the two mystery datasets provided.

mystery1 <- read.csv("Week 7/mysterydata1.csv")
mystery2 <- read.csv("Week 7/mysterydata2.csv")

# arg1: What value do you get if you round the highest mean measurement for each
# code up to the nearest whole number? This is the value for arg1. 

mystery1 |> group_by(code) |> summarize(mean(measurement))


# arg2: Which hue has the lowest measurement on average? This hue is the value 
# for arg2. You should use a join, and make sure to put the hue in quotes. 

mystery <- left_join(mystery1, mystery2)
mystery |> group_by(code) |> summarize(mean(measurement))


# arg3: What is the first degrees of freedom value provided in the ANOVA summary 
# table for measurement ~ hue? Multiply that value by 2. This is the value for arg3.
summary(aov(measurement~hue, data = mystery))


#arg4: What is maximum value for the score data? Divide that value by 2. This is 
# the value for arg4.
max(mystery$score)/2

# arg5: There is one pair of hues that is not significantly different. Multiply
# the difference in the means of these two groups by -1. This is the value for arg5.
TukeyHSD(aov(measurement~hue, data = mystery)) #-0.8



mysteryfunction(arg1 = 100, arg2 = "mediumpurple1", arg3 = 6, arg4 = 2.5,
                arg5 = -0.8)

# MES 503 Week 5 Lab - t tests and data wrangling
# This script includes a coding exercise designed to build your understanding of 
# t-tests while also learning more about data wrangling

# Created by Kayla Blincow 9/15/2026
#------------------------------------------------------------------------------


#### INTRODUCTION
# Today we will learn how to:
# 1. Perform a t-test in R
# 2. Interpret the results of a t-test
# 3. Create new variables using mutate()
# 4. Calculate summaries using group_by() and summarise()
# 5. Combine data wrangling and statistical analysis

# An important idea for today:
# DATA WRANGLING and STATISTICAL ANALYSIS are connected.

# Before we can perform a statistical test, we often need to make sure
# that our data are structured and filtered appropriately.


# ------------------------------------------------------------------------------
# BACKGROUND: MANGROVE SEEDLING GROWTH
# ------------------------------------------------------------------------------

# Mangrove forests provide important ecosystem services, including shoreline
# stabilization, habitat for juvenile fishes and invertebrates, carbon storage,
# and protection from storms.

# Mangrove seedlings may experience different environmental conditions depending
# on where they grow. For example, seedlings near the shoreline may experience
# greater exposure to waves, flooding, salinity, and physical disturbance than
# seedlings growing farther inland.

# In this exercise, we will use a hypothetical dataset to investigate whether
# mangrove seedling height differs between two habitat zones:

# 1. Shoreline: seedlings growing near the water's edge
# 2. Inland: seedlings growing farther inland within the mangrove forest

# Our motivating research question is:
# Do mangrove seedlings differ in height between shoreline and inland zones?

#### OUR DATA ####

# Our dataset includes measurements from 30 hypothetical mangrove seedlings.

# Variables include:
# seedling_id: unique identifier for each seedling
# site: mangrove study site
# species: mangrove species
# zone: shoreline or inland habitat zone
# height_cm: seedling height in centimeters
# leaf_number: number of leaves on the seedling
# stem_diameter_mm: stem diameter in millimeters
# salinity_ppt: water salinity in parts per thousand
# light_percent: percentage of available sunlight


# These data are hypothetical but designed to represent plausible ecological
# measurements.



# ------------------------------------------------------------------------------
# SET UP R AND LOAD PACKAGES
# ------------------------------------------------------------------------------

# Clear the current R environment.
rm(list = ls())

# Load the tidyverse package 
# (this loads the whole tidyverse at once and is a great shorthand for when you 
# know you'll be using multiple tidyverse packages, like ggplot2 and dplyr)

# If you have not installed tidyverse, run this first:
# install.packages("tidyverse")

library(tidyverse)

# ------------------------------------------------------------------------------
# LOAD OUR DATA AND CHECK IT OUT
# ------------------------------------------------------------------------------

# Import your CSV file.
# Update the file path below so that R can find your data.

mangroves <- read.csv("FILL IN FILE PATH")

# View the first six rows of the dataset.
# FILL IN CODE HERE
head(mangroves)

# View the structure of the dataset.
# FILL IN CODE HERE
str(mangroves)


# ------------------------------------------------------------------------------
# PART 1: EXPLORE THE DATA
# ------------------------------------------------------------------------------

# Before conducting a statistical test, it is important to explore the data.

# Create a visual depicting seedling height in each habitat zone.
#WRITE CODE HERE
ggplot(mangroves, aes(x = zone, y = height_cm)) +
  geom_jitter(width = 0.1, height = 0, alpha = 0.8) +
  geom_boxplot(alpha = 0.5) +
  labs(
    title = "Mangrove Seedling Height by Habitat Zone",
    x = "Habitat zone",
    y = "Seedling height (cm)"
  ) +
  theme_minimal()



# ------------------------------------------------------------------------------
# PART 2: Do A t-TEST
# ------------------------------------------------------------------------------

# A t-test is used to compare the means of two groups.

# In this example, we want to determine whether mean seedling height differs
# between shoreline and inland mangrove seedlings.

# Our hypotheses are:

# Null hypothesis: Mean seedling height is the same in shoreline and inland zones.
# Alternative hypothesis: Mean seedling height differs between shoreline and inland zones.


# The general syntax for a two-sample t-test is:
# t.test(response variable ~ explanatory variable, data = dataset)

# What is our response variable?
# WRITE YOUR ANSWER HERE

# What is our explanatory variable?
# WRITE YOUR ANSWER HERE

# Do the test!
height_test <- t.test(height_cm ~ zone, data = mangroves)

#look at the test results:
height_test

# Important parts of the output include:
# t: The calculated t-statistic.
# df: The degrees of freedom associated with the test.
# p-value: The probability of obtaining results at least as extreme as those observed
# if the null hypothesis were true.
# confidence interval: A range of plausible values for the difference between group means.
# sample estimates: The mean height for each habitat zone.

# How can we extract the p-value from the test object?
# WRITE CODE HERE
height_test$p.value

# How about the estimated means?
height_test$estimate

# ------------------------------------------------------------------------------
# PART 3: INTERPRET THE t-TEST
# ------------------------------------------------------------------------------

# Use the t-test output answer the following questions:
# 1. Do you reject or fail to reject the null hypothesis? Why?
# 2. Which habitat zone has taller seedlings on average?
# 3. Write a biological interpretation of the result.


# Remember that a statistically significant difference does not automatically
# demonstrate that habitat zone caused the difference. Other variables, such
# as salinity, light availability, flooding, nutrient availability, or site
# characteristics, may also influence seedling growth.



# ------------------------------------------------------------------------------
# PART 4: SUMMARIZE THE DATA TO CONTEXTUALIZE THE TEST
# ------------------------------------------------------------------------------

# A statistical test provides information about whether groups differ, but we
# should also calculate descriptive statistics to understand the size and
# direction of the difference.

# This is where data wrangling and the group_by()/summarize() functions come in!

# Take a look at the code below and try to think about what you think it will do
# BEFORE running it.
mangroves |>
  group_by(zone) |>
  summarise(
    sample_size = n(),
    mean_height = mean(height_cm),
    standard_deviation = sd(height_cm),
    minimum_height = min(height_cm),
    maximum_height = max(height_cm)
  )

# The grouped summary tells us:
# 1. How many seedlings were measured in each zone.
# 2. The average seedling height in each zone.
# 3. How variable seedling height was within each zone.
# 4. The smallest and largest observations in each zone.


# ------------------------------------------------------------------------------
# PART 5: REPORTING t-TEST RESULTS
# ------------------------------------------------------------------------------

# If we were writing these results in a paper it would look like this:
# Mangrove seedlings growing farther inland were taller on average than those 
# growing near the shoreline. Mean height was 58.8 ± 5.06 cm (Mean ± SD) for inland seedlings 
# compared with 42.3 ± 4.06 cm for shoreline seedlings. An two-sample 
# t-test indicated that height differed significantly between the two zones 
# (t = 9.87, df = 26.7, p< 0.001).


# ------------------------------------------------------------------------------
# PART 6: USING group_by() AND summarise()
# ------------------------------------------------------------------------------

# The group_by() function tells R to perform calculations separately for each
# level of a grouping variable.

# The summarise() function calculates summary statistics.

# These functions are often used together.

# Calculate the mean seedling height for the entire dataset.
mangroves |>
  summarise(
    mean_height = mean(height_cm)
  )

# Calculate the mean seedling height separately for each habitat zone.
mangroves |>
  group_by(zone) |>
  summarise(
    mean_height = mean(height_cm)
  )

# Calculate several summary statistics for each habitat zone.
mangroves |>
  group_by(zone) |>
  summarise(
    sample_size = n(),
    mean_height = mean(height_cm),
    standard_deviation = sd(height_cm),
    mean_leaf_number = mean(leaf_number),
    mean_salinity = mean(salinity_ppt),
    mean_light = mean(light_percent)
  )

# We can also group by more than one variable.
mangroves |>
  group_by(site, zone) |>
  summarise(
    sample_size = n(),
    mean_height = mean(height_cm),
    mean_leaf_number = mean(leaf_number),
    .groups = "drop"
  )

# The .groups = "drop" argument removes the grouping after summarising.

# ------------------------------------------------------------------------------
# YOUR TURN: PRACTICE WITH group_by() AND summarise()
# ------------------------------------------------------------------------------

# Complete the following tasks:

# 1. Calculate the mean stem diameter for each habitat zone.

# 2. Calculate the mean number of leaves for each mangrove species.

# 3. Calculate the mean salinity and mean light availability for each site.

# 4. Calculate the minimum, maximum, and mean seedling height for each species
# and habitat zone combination.

# 5. Calculate the mean leaf density for each habitat zone.


# ------------------------------------------------------------------------------
# PART 6: USING mutate() TO CREATE NEW VARIABLES
# ------------------------------------------------------------------------------

# The mutate() function creates new variables or modifies existing variables.

# For example, we can convert seedling height from centimeters to meters.
mangroves <- mangroves |>
  mutate(
    height_m = height_cm / 100
  )

# View the updated dataset.
head(mangroves)

# We can also calculate the number of leaves per centimeter of seedling height.
mangroves <- mangroves |>
  mutate(
    leaf_density = leaf_number / height_cm
  )
# View the new variables--what's the code below doing?
mangroves |>
  select(seedling_id, height_cm, height_m, leaf_number, leaf_density)

# We can use ifelse() inside mutate() to create categories.
mangroves <- mangroves |>
  mutate(
    height_class = ifelse(
      height_cm >= 50,
      "Tall",
      "Short"
    )
  )

# View the height categories.
mangroves |>
  select(seedling_id, height_cm, height_class)

# ------------------------------------------------------------------------------
# YOUR TURN: PRACTICE WITH mutate()
# ------------------------------------------------------------------------------

# Complete the following tasks:

# 1. Create a new variable called diameter_cm that converts stem diameter fro-m
# millimeters to centimeters.

# 2. Create another variable called leaves_per_meter that calculates the number
# of leaves per meter of seedling height.

# 3. Create a categorical variable called salinity_category:
# "High" if salinity_ppt is greater than or equal to 30
# "Low" if salinity_ppt is less than 30

# 4. Use select() to display the variables needed to check your work.


# ------------------------------------------------------------------------------
# YOUR TURN: COMPLETE AN ANALYSIS COMBINING DATA WRANGLING AND A t-TEST
# ------------------------------------------------------------------------------
# Research question:
# Does leaf density differ between shoreline and inland black mangrove seedlings?

# Complete the following workflow:
# 1. Use filter() to create a dataset containing only black mangroves.
# 2. Use select() to retain the variables needed for the analysis.
# 3. Use mutate() to calculate leaf density (number of leaves/seedling height)
# 4. Use group_by() and summarise() to calculate the mean leaf density for each
#    habitat zone.
# 5. Create a boxplot showing leaf density by habitat zone.
# 6. Conduct a t-test comparing leaf density between shoreline and inland zones.
# 7. Interpret the result in ecological terms.

# Your interpretation should include:
# - The mean leaf density in each group.
# - The direction of the difference.
# - Correct reporting of the t test.
# - Whether the result is statistically significant.
# - What the result may suggest about mangrove seedling growth.






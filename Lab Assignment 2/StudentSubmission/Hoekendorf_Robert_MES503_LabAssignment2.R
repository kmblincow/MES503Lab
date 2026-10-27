# MES 503 Lab Assignment 2
# Exploring correlation and t-tests with TCRMP data

# 9/15/2026
# Created by Kayla Blincow (with help from ChatGPT)
# ------------------------------------------------------------------------------

# INSTRUCTIONS

# Complete this script as you work through the assignment.
#
# - Replace every "# FILL IN" section with your own code or written response.
# - Comment your code so that someone else can follow your workflow.
# - Do not delete the research questions or prompts.
# - Your script should run from beginning to end without errors.
# - Save this script as: LastName_FirstName_MES503_LabAssignment2.R
# - Submit your completed script to Brightspace by the deadline.

#### SCENARIO

# TCRMP LIONFISH DATA

# In the USVI, the Territorial Coral Reef Monitoring Program (TCRMP) conducts
# annual to semi-annual monitoring to assess multiple aspects of reef health,
# including fish communities. TCRMP fish census methods include a combination of
# belt transects and roving diver surveys. TCRMP has been reporting the abundance
# and biomass of lionfish since they were first encountered in 2011. As of 2022,
# TCRMP has monitoring data for 34 sites: 10 mesophotic reefs (> 30 m depth),
# 13 nearshore reefs (~10 m), and 11 offshore reefs (~15 m).

# The data used in this assignment are real TCRMP data that have been summarized
# to include information on lionfish observed at monitoring sites on St. Croix
# and St. Thomas from 2011 to 2022.

# VARIABLES:
# Location     - TCRMP monitoring site
# SampleYear   - Year data were collected
# TotalCount   - Total number of lionfish observed across all transects conducted
#                at each site, each year
# ntrans       - Number of belt transects conducted at each site, each year
# Biomass      - Total biomass of lionfish observed at each site, each year
# Code         - Three-character identifying code for the TCRMP monitoring site
# Island       - Island where the site is located (STT, STX)
# ReefComplex  - Type of reef (mesophotic, nearshore, offshore)
# Depth        - Average depth at the monitoring site


#### PART 1: SET UP YOUR SCRIPT & GET TO KNOW YOUR DATA

# Write code to clear your workspace, load necessary packages and import your
# data file.

# FILL IN CODE

rm(list = ls())
# install.packages("tidyverse")
# install.packages("dplyr")
# install.packages("ggplot2")
library(tidyverse)
library(dplyr)
library(ggplot2)

tcrmp_data <- read.csv("C:/Users/rober/OneDrive/Desktop/MMES/MES-RMT/MES503LAB/TCRMP_Lionfish.csv")

# Explore your newly imported dataset.

# FILL IN CODE

head(tcrmp_data)
str(tcrmp_data)
names(tcrmp_data)
unique(tcrmp_data$ntrans)
mean(tcrmp_data$ntrans)

# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

# FILL IN WRITTEN ANSWER HERE

# Some sites have more transects (ntrans), so analysis will need to take into
# account when considering TotalCount and Biomass as it may be lower in relation
# to other sites when considering transect counts. There's also no mention of
# site size so some of these may be near total samples of smaller reefs (populations) 
# vs small sample sizes of large reefs (atleast not mentioned in methodology).
# Some locations also have more years sampled than others


#### PART 2: CORRELATION

# RESEARCH QUESTION:
# Is there a relationship between depth and total lionfish biomass observed at
# each site (across all years)?

# To address this question you must:
# 1. Complete necessary data wrangling tasks 
# 2. Test for a correlation between the variables of interest. 
# 3. Create a visual of the relationship that includes appropriate axis labels,
#    units, an informative title, and the p-value and correlation coefficient
#    from your correlation test.
# 4. Intepret the results of your correlation test and visual. What does it mean
#    statistically? What does it mean ecologically?

# HINT: The original dataset contains multiple observations for each monitoring
# location because sites were sampled across multiple years.To answer this 
# research question, we want ONE observation per location.

# FILL IN CODE

depth_mass <- tcrmp_data |> # Creates a new data frame
  group_by(Location) |>  # groups all location data
  summarise(sum_biomass = sum(Biomass), # sum all biomass for each location
            site_depth = mean(Depth)) #could also use first(Depth)

depth_mass_cor <- cor.test(depth_mass$site_depth, depth_mass$sum_biomass)
# correlation test assigned to a variable
ggplot(depth_mass, aes(x = site_depth,
                       y = sum_biomass)) +
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) + # trend line with standard error
  theme_minimal() +
  labs(
    x = "Site Depth (m)",
    y = "Total Lionfish Biomass g/100m^2",
    title = paste( # concatenate 
      "Depth & Total Lionfish Biomass    r =",
      round(depth_mass_cor$estimate, 2), #rounds r to 2 decimals
      ", p", format.pval(depth_mass_cor$p.value, digits = 2, eps = 0.001)
    ) # format p value , eps is smallest p value it'll display
  )

# FILL IN WRITTEN ANSWERS

# There is a positive correlation (r=0.72) between sample location depth and the 
# total recorded lionfish biomass and is statistically significant (p<0.001) which
# means we can reject the null hypothesis that depth and total lionfish biomass
# are not correlated. As depth of the sample location increases, the
# total observed lionfish biomass also increases. This suggests that deeper water
# reef ecosystems could be likely to contain lionfish or more favorable to
# support lionfish, however correlation does not imply causation and other variables
# among these sites could play a bigger role in predicting inhabiting lionfish biomass
# Further, sites were not sampled an equal number of years so total biomass
# may represent differences in sampling effort rather than depth alone.


#### PART 3: T-TEST

# RESEARCH QUESTION:
# In cases where multiple lionfish were observed, did they tend to occur at
# higher density on St. Thomas or St. Croix?

# To address this question you must:
# 1. Complete the necessary data wrangling tasks.
# 2. Create a preliminary visualization comparing lionfish density between the
#    two islands. Do you notice anything you might need to address?
# 3. Check the assumptions of the t-test, and state whether your assumptions are
#    met or violated. If they are violated, research what you can do, and implement
#    a fix. Document what you did and why--include a visualization if appropriate.
# 4. Conduct a t-test that addresses the research question.
# 5. Create a visual to accompany your statistical test that includes appropriate
#    axis labels, units, an informative title, and the p-value and test statistic
#    from your t-test.
# 6. Provide a written interpretation of your results. Write your t-test results
#    as you would if you were presenting them in a peer-reviewed paper. Also 
#    include an ecological interpretation of your results. 


# Use the information below to prepare your data:
# - An observation of MULTIPLE lionfish means that TotalCount is greater than 1.
# - Density = TotalCount / Number of Transects
# - Density is expressed in units of fish/100 m^2.
# - Consider how your statistical interpretation might need to change if you 
#   change your data as a result of assumption violations.

# FILL IN CODE HERE

#####################################################
# Data Wrangling

island_density_data <- tcrmp_data |> # new data frame
  group_by(Island) |>  # Group for island density calculation
  filter(TotalCount > 1, # Remove all instances where 1 or less fish was observed
  ) |>
  select(-Code, # decided to remove unneeded columns this time
         #-Location,
         -Biomass,
         -ReefComplex,
         -Depth,
         -SampleYear) |> 
  mutate(density = TotalCount / ntrans, # add column for density
         island_density = mean(density)) # not needed but I kept for my own viz

##################################################
# Data Viz

ggplot(island_density_data, aes(x = density)) +
  geom_histogram() +
  facet_wrap(~ Island) +
  labs(
    x = "Lionfish Density",
    y = "# Recordings",
    title = "Normal Distribution Visualization (Prelim Test)"
  )

# documentation says shapiro.test low p-value indicates nonnormal distribution
# Source: https://www.datanovia.com/learn/biostatistics/assumptions/normality-test-in-r

shapiro.test(island_density_data$density[island_density_data$Island == "STT"])
# data is significantly non-normal p = 3.76 * 10^-8
shapiro.test(island_density_data$density[island_density_data$Island == "STX"])
# data is significantly non-normal p = 1.15 * 10^-6

###################################################
# Data Transformation

island_density_data <- island_density_data |>
  mutate(density_log = log(density))
# island_density_data$density_log <- log(island_density_data$density)

Means_Island <- island_density_data |> # Used for write up
  group_by(Island) |> # Island grouping for calculations
  summarize(mean_density = mean(density), # mean of densities
            mean_log_density = mean(density_log), # mean of log-transformations
            exp(mean(density_log))) # exponential, explained on next line
            # back-transforms mean log-density to the geometric mean (fish/100m^2)

# Means_Island$`exp(mean(density_log))`[1] / Means_Island$`exp(mean(density_log))`[2]
# used to calculate ratio (difference between means)

###################################################
# Data Viz x 2

ggplot(island_density_data, aes(x = density_log)) +
  geom_histogram() +
  facet_wrap(~ Island) +
  labs(
    x = "Log Lionfish Density",
    y = "# Recordings",
    title = "Normal Distribution Visualization (Prelim Log Test)"
  )

shapiro.test(island_density_data$density_log[island_density_data$Island == "STX"])
# data is still significantly non-normal in distribution p = .015
# log reduced skew substantially
shapiro.test(island_density_data$density_log[island_density_data$Island == "STT"])
# data is still significantly non-normal in distribution p = .0265
# log reduced skew substantially

####################################################
# t - test

# previous histogram showed variance was not equal
t_test <- t.test(density_log ~ Island, data = island_density_data, var.equal = FALSE)


####################################################
# Plot


ggplot(island_density_data, aes(x = Island,
                                y = density_log,
                                fill = Island)) +
  geom_boxplot() +
  geom_jitter(width = 0.1, alpha = 0.35) +
  # stat_summary(fun = mean, geom = "point", shape = 22, size = 4, fill = "white") +
  # decided against showing the mean on these
  theme_bw() +
  scale_x_discrete(labels = c("St. Thomas", "St. Croix")) +
  guides(fill = "none") + #removes Legend
  labs(
    x = "Island",
    y = "Log-Transformed Lionfish Density (fish/100m^2)",
    title = paste("Lionfish Density per Island,    t =",
                  round(t_test$statistic, 2), #rounds r to 2 decimals
                  ", p =", format.pval(t_test$p.value, digits = 2, eps = 0.001)
    ) 
  )

# mean(tcrmp_data$Depth[tcrmp_data$Island == "STT" & tcrmp_data$TotalCount > 1])
# mean(tcrmp_data$Depth[tcrmp_data$Island == "STX" & tcrmp_data$TotalCount > 1])
# used in write up

# FILL IN WRITTEN ANSWERS HERE

# 6. Provide a written interpretation of your results. Write your t-test results
#    as you would if you were presenting them in a peer-reviewed paper. Also 
#    include an ecological interpretation of your results. 

#   Study results found a significant difference in lionfish density
# between St Thomas (STT) & St Croix (STX) according the the recorded data.
# Mean lionfish density of locations sampled in STT with more than one lionfish
# sighting was 1.06 fish/100m^2 while STX was 0.392 fish/100m^2 
# (mean difference = 0.668 fish/100m^2). Density calculated as total lionfish counted 
# per sample site divided by the number of total 100m^2 transects represented as
# fish / 100m^2. 

#   Density data was log-transformed before running a t-test
# comparing means of log(fish/100m^2) between the two islands St. Thomas (STT),
# & St. Croix (STX). Welch's T-test results were statistically significant
# t(110.99) = 5.99, p-value = 2.68 x 10^-8. Mean log-transformed 
# lionfish densities were -0.318 for STT and -1.06 for STX (mean 
# difference = .74 log units). Transforming the mean log-densities using 
# R exponential function and ratioing exp(−0.318) / exp(−1.058) yielded
# a value of 2.09, indicating lionfish density at locations with multiple 
# sightings was 2.09 times higher on St. Thomas than locations on St. Croix meeting
# the same criteria.

# A possible ecological explanation for the data is that Lionfish favor
# deeper reef environments while the locations sampled on St. Thomas were
# at greather depth than those sampled on St. Croix. The mean depth of the
# t-test analyzed locations at STT was approx. 3.1m deeper than those sampled
# at STX. A correlation between depth and lionfish biomass was shown previously
# (r=0.72, p<0.001) though correlation does not imply causation and biomass is 
# a different metric of measurement than that tested with the t-test. Other factors
# could better explain the trend such as lionfish culling being more prevalent on STX.


# Sources for log & log analysis
# 1.) https://www.datanovia.com/learn/biostatistics/assumptions/normality-test-in-r
# 2.) https://towardsdatascience.com/log-link-vs-log-transformation-in-r-the-difference-that-misleads-your-entire-data-analysis/



#### FINAL CHECK

# Before submitting, make sure you have:

# DATA & CODE
# [ ] Successfully imported the data.
# [ ] Explored and checked your data before beginning your analyses.
# [ ] Completed all required data wrangling.
# [ ] Added comments that explain important steps in your workflow.

# ANALYSIS
# [ ] Addressed each research question.
# [ ] Considered the assumptions relevant to your statistical analyses.
# [ ] Researched and documented how you addressed any violated assumptions.

# VISUALIZATIONS
# [ ] Created all required visualizations.
# [ ] Included appropriate axis labels, units, and titles.
# [ ] Customized your visualizations appropriately.
# [ ] Made sure your visualizations accurately represent your data.

# INTERPRETATION
# [ ] Reported the important results from your statistical analyses.
# [ ] Provided statistical interpretations of your results.
# [ ] Connected your results back to the research questions.
# [ ] Provided ecological interpretations where appropriate.

# FINAL SCRIPT
# [ ] Answered all written questions and prompts.
# [ ] Included citations or links for any outside resources you used.
# [ ] Checked that your script runs from beginning to end without errors.
# [ ] Saved your script using the required filename.

# SAVE YOUR SCRIPT AND SUBMIT TO BRIGHTSPACE!

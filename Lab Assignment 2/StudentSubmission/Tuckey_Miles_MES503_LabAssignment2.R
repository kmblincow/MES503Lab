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

#Clear Workspace:
rm(list = ls())

#Load Packages:
library(tidyverse)

#Import Data File:
lionfish <- read.csv("TCRMP_Lionfish.csv")

# Explore your newly imported dataset.

#Looking at the first 6 rows
head(lionfish)

#Looking at the structure
str(lionfish)

# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

# There are 352 observations of 9 variables (5 discrete and 4 continuous)
#lionfish counts were recorded at a site even if it was 0 and sampling occurred from 2011 to 2022.
#The number of transects was inconsistent across sites and years



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

lionfish.cor <- lionfish |>
  group_by(Location)|> #Grouping by Location to assist next step
  summarize(Avg.Biomass = mean(Biomass), #Summarizing the average total biomass and depth for each location
            Avg.Depth = mean(Depth))

Depth_Biomass_cor <- cor.test(lionfish.cor$Avg.Depth, lionfish.cor$Avg.Biomass) #Depth v Biomass Correlation test
#They are significantly correlated (low p value)!

ggplot(data = lionfish.cor, aes(x = Avg.Depth, y = Avg.Biomass)) +
  geom_point() + #Plotting the correlation between average total lionfish biomass and average depth across sites
  labs(x = "Average Depth (m)", #Labelling axes and including p and r values
       y = "Average Total Biomass (g/100 m^2)", 
       title = "Depth and Total Lionfish Biomass Relationship Across Sites", 
       subtitle = paste("p = ", format.pval(Depth_Biomass_cor$p.value, digits = 2, eps = 0.001), " r = ", round(Depth_Biomass_cor$estimate, 2))) +
  theme_classic() + #making it look pretty
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

# The correlation test and visual show that the lionfish Average Total Biomass (g/100 m^2) of sites is significantly (p = <0.001) correlated to the Average Depth (m) of sites statistically. This relationship has a positive correlation coefficient (r = 0.81), meaning that Average Total Biomass (g/m^2) appears to increase as Average Depth (m) increases.





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

lionfish_density <- lionfish |>
  filter(TotalCount > 1) |> #Filtering out cases where 1 or less lionfish were observed
  mutate(Density = TotalCount/ntrans, #Dividing total fish count by number of transects to calculate Density
         log_Density = log(Density)) #Using log() to make density have a normal distribution for t test

ggplot(lionfish_density, aes(x = Density, fill = Island)) + #Creating graph of density to see distribution
  geom_histogram() + #Using histogram so y-axis is frequency
  facet_wrap(~ Island, nrow = 1, scales = "free") + #Creating separate graphed section for each Island
  theme_classic() #Making it look pretty
#t-test assumptions violated, not all data is normally distributed
#Logging density should normalize the distribution (added to previous mutation)
#source: https://en.wikipedia.org/wiki/Log-normal_distribution

ggplot(lionfish_density, aes(x = log_Density, fill = Island)) + #Creating graph of density to see distribution
  geom_histogram() + #Using histogram so y-axis is frequency
  facet_wrap(~ Island, nrow = 1, scales = "free") + #Creating separate graphed section for each Island
  theme_classic() #Making it look pretty
#gorgeous (maybe) normal distribution :)

Density_ttest <- t.test(log_Density ~ Island, data = lionfish_density) #Completing Lionfish Density ttest
#Significant difference in lionfish density (Low p value)! 

ggplot(lionfish_density, aes(x = Island, y = Density, fill = Island)) + #Plotting Density x Island
  geom_violin(width = 1, alpha = 0.5) + #Creating Violin graph to show Density distribution between Islands
  geom_jitter(width = 0.04, aes(color = Island)) + #Jittering data points to better visualize distribution
  scale_color_manual(values = c(hcl.colors(2, palette = "Geyser"))) + #Coloring data points
  scale_fill_manual(values = c(hcl.colors(2, palette = "Geyser"))) + #Coloring Violins
  labs(x = "Island", #Labelleing axes and adding p and t values
       y = "Lionfish Density (fish/100m^2)", 
       title = "Lionfish Density between St. Thomas and St. Croix",
       subtitle = paste("p = ", format.pval(Density_ttest$p.value, digits = 2, eps = 0.001), 
                        " t = ", round(Density_ttest$statistic, 2))) +
  theme_classic() + #Making it look pretty
  theme(plot.title = element_text(hjust = 0.5, face = "bold"), legend.position = "none")

# Welch's two-sample t-test indicated a significant difference in lionfish density between St. Thomas and St. Croix populations (t(df) = 5.99(111); p < 0.001). Distribution of the Violin Plots suggests that lionfish appeared in greater density around St. Thomas than around St. Croix per 100 meter squared volume of water.



#### FINAL CHECK

# Before submitting, make sure you have:

# DATA & CODE
# [X] Successfully imported the data.
# [X] Explored and checked your data before beginning your analyses.
# [X] Completed all required data wrangling.
# [X] Added comments that explain important steps in your workflow.

# ANALYSIS
# [X] Addressed each research question.
# [X] Considered the assumptions relevant to your statistical analyses.
# [X] Researched and documented how you addressed any violated assumptions.

# VISUALIZATIONS
# [X] Created all required visualizations.
# [X] Included appropriate axis labels, units, and titles.
# [X] Customized your visualizations appropriately.
# [X] Made sure your visualizations accurately represent your data.

# INTERPRETATION
# [X] Reported the important results from your statistical analyses.
# [X] Provided statistical interpretations of your results.
# [X] Connected your results back to the research questions.
# [X] Provided ecological interpretations where appropriate.

# FINAL SCRIPT
# [X] Answered all written questions and prompts.
# [X] Included citations or links for any outside resources you used.
# [X] Checked that your script runs from beginning to end without errors.
# [X] Saved your script using the required filename.

# SAVE YOUR SCRIPT AND SUBMIT TO BRIGHTSPACE!

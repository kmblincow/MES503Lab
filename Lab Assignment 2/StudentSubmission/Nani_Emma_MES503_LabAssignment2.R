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

# clear env, load tidyverse, import TCRMP_Lionfish.csv
rm(list = ls())
library(tidyverse)
TCRMP_Lionfish <- read.csv("Week5/TCRMP_Lionfish.csv")

# Explore your newly imported dataset.

head(TCRMP_Lionfish)
str(TCRMP_Lionfish)


# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

      # The column names are all capitalized except for one col.
      # Depth has no unit!! Probably implied its meters though
    



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



# Average biomass across all years by site
TCRMP_Lionfish <- TCRMP_Lionfish %>% 
  group_by(Location) %>% 
  mutate(Mean_biomass = mean(Biomass))

# Test correlation of depth and mean biomass
Depth_Biomass_cor <- cor.test(TCRMP_Lionfish$Mean_biomass, 
                              TCRMP_Lionfish$Depth, 
                              method = "pearson")


# Plot Depth and Mean biomass by site
ggplot(TCRMP_Lionfish, aes(Mean_biomass, Depth)) +
        geom_point() +
        labs(x = "Mean Biomass (g/100m^2)", y = "Depth (m)",
             title = "Relationship between Lionfish Biomass and Depth",
             subtitle =  paste("correlation coefficient =", 
                          round(Depth_Biomass_cor$estimate, 2),
                          ", p =", format.pval(Depth_Biomass_cor$p.value, 
                          digits = 2, 
                          eps = 0.001))) +
        scale_y_log10()

# Written answers
# Based on the visual and the results from the correlation test, there is a substantial relationship between lionfish biomass and depth. The correlation coefficient is reported as 0.77, indicating a strong positive relationship between the two variables. Additionally, the p-value is reported as less than 0.001 which is statistically significant. I added a log transformation in order to scale the plot and make it more readable. Ecologically, we can infer that the invasive lionfish are being hunted out of the shallow waters which has been decreasing their overall size. Larger lionfish are able to live to sexual maturity at deeper depths where they don't face as much fishing pressure.






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




# Calculate density of lionfish by island
#Log transform density to normalize it
TCRMP_Lionfish_density <- TCRMP_Lionfish %>% 
                            group_by(Island) %>% 
                            filter(TotalCount > 1) %>% 
                            mutate(logDensity = log10(TotalCount/ntrans))


# Plot lionfish density by island
ggplot(TCRMP_Lionfish_density, aes(Island, logDensity, color = Island)) +
    geom_boxplot() +
    geom_jitter(alpha = .5) +
    labs(title = "log(Density) of Lionfish by Island",
          y = "log(Density)")



# Run t-test and save values
t.test_results <- t.test(logDensity ~ Island, 
                         data = TCRMP_Lionfish_density)

test_stat <- t.test_results$statistic
p_value <- t.test_results$p.value


# Create visualization
ggplot(TCRMP_Lionfish_density, aes(Island, logDensity, fill = Island)) +
        geom_boxplot() +
        geom_jitter() +
        labs(title = "T-test Results of Lionfish Density by Island",
             y = "log(Density)",
             subtitle = paste("Test statistic = ", round(t.test_results$statistic, 3),
                              ", p-value =", format.pval(t.test_results$p.value, 
                                digits = 2, 
                                eps = 0.001))) +
        scale_fill_manual(values = c("lightblue", "lightyellow")) +
        theme(legend.position = "none")
  

# Written answers
# We reject the null hypothesis, concluding there was a significant difference between log lionfish densities across islands (t(df)= 5.987(110.99); p = 2.67e-08. Since there was not a normal distribution in the original data which violates t-test assumptions, a logarithmic transformation was applied to the lionfish densities.Ecologically this means that there are more populations of lionfish occupying space on STT likely due to a combination of factors regarding their habitat preference and fishing pressures as an invasive species.

# Citations:
# https://r-graph-gallery.com/boxplot.html 



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

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

library(tidyverse)

# Explore your newly imported dataset.

# FILL IN CODE

TCRMP <- read.csv("Week_5/TCRMP_Lionfish.csv")

head(TCRMP)

# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

# FILL IN WRITTEN ANSWER HERE
str(TCRMP)
  #This monitoring was collected at the same site for multiple years so it is important to note that the sites will have multiple observations assigned to it.



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
# 4. Intepret the results of your correlation test and visual. What does it mean statistically? What does it mean ecologically?

# HINT: The original dataset contains multiple observations for each monitoring
# location because sites were sampled across multiple years.To answer this 
# research question, we want ONE observation per location.

# FILL IN CODE
TCRMP_Site <- TCRMP |>
  group_by(Location)|>
  summarize(
    mean_depth = mean(Depth),
    mean_biomass = mean(Biomass)) 

depth_biomass_corr_test <- cor.test(TCRMP_Site$mean_depth, TCRMP_Site$mean_biomass, method ="pearson")

depth_biomass_corr_test
  #t = 7.4369, df = 29, p-value = 3.398e-08, cor = 0.8099511 


  ggplot(TCRMP_Site, aes(x = mean_depth, y = mean_biomass)) +
  geom_point(size = 2) +
  labs(x = "Depth (m)",
       y = "Biomass (g/100m^2)",
    title = paste("Relationship Between Depth and Total Lionfish Biomass",
    "r=", round(depth_biomass_corr_test$estimate, 2),
    ", p=", format.pval(depth_biomass_corr_test$p.value, digits = 2, eps = 0.001)))+
    theme_classic()+
    theme(plot.title = element_text(hjust = 0.5, face = "bold"),
          panel.border = element_rect(color = "black", fill = NA, linewidth = 1))
    
  

# FILL IN WRITTEN ANSWERS
  #There is a significant positive relationship seen between depth and lionfish biomass (r=0.810, p <= 0.001). The correlation is close to 1 meaning the relationship between the two is strong. Deeper depths recorded higher biomass but that does not mean they caused them. The two variables just have a high correlation. 




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
    # 1. CONSIDER INDEPENDENCE
    # 2. NORMALITY
    # 3. EQUAL VARIANCE
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
# FILL IN WRITTEN ANSWERS HERE
  
  Multiple_Fish <- TCRMP |>
    filter(TotalCount >1)
   
  Multiple_Fish <- Multiple_Fish|>
    mutate(Density = TotalCount / ntrans)

    # 2. NORMALITY
  ggplot(Multiple_Fish, aes(x= Density, fill = Island))+
    geom_histogram()+
    facet_wrap(~ Island)+
    labs(
      x= "Island",
      y= "Density (fish/100 m^2)",
      title = "Lionfish Density Per Virgin Island")+
    theme_bw()+
    theme(plot.title = element_text(hjust = 0.5, face = "bold"),
          panel.border = element_rect(color = "black", fill = NA, linewidth = 1)) 
        
  #right skewed
    #How to fix 
     #log(Density)
  #https://online.stat.psu.edu/stat505/Lesson02 
  #https://stats.oarc.ucla.edu/sas/webbooks/reg/chapter1/regressionwit -saschapter-1-simple-and-multiple-regression/ 
  
  # 3. EQUAL VARIANCE
  ggplot(Multiple_Fish, aes(x= Island, y = Density))+
    geom_boxplot()+
    labs(
      x= "Island",
      y= "Density (fish/100 m^2)",
      title = "Lionfish Density Per Virgin Island"
    )
  #unequal variance 
  
  
  
?t.test()
  
Density_test <- t.test(log(Density) ~ Island, data = Multiple_Fish)

Density_test

Multiple_Fish |>
  group_by(Island)|>
  summarise(mean_density = mean(Density),
            sd_density = sd(Density))

ggplot(Multiple_Fish, aes(x= Island, y = Density))+
  geom_boxplot()+
  labs(
    x= "Island",
    y= "Density (fish/100 m^2)",
    title = paste("Lionfish Density Per Virgin Island",
    "t =", round(Density_test$statistic, 2),
    ", p=", format.pval(Density_test$p.value, digits = 2, eps = 0.001)))+
  theme_classic() +
theme(plot.title = element_text(hjust = 0.5, face = "bold"),
      panel.border = element_rect(color = "black", fill = NA, linewidth = 1)) 


  #After log transforming the density data because of right skewed data, the cases that had more than one lionfish observation tended to have higher density at St Thomas. Mean density was -0.318 ± 1.07 fish/100m^2 (Mean ± SD) for St Thomas compared to -1.058 ± 0.225 fish/100m^2 for St Croix. A two-sample t-test with the log transformed data indicated that lionfish density differed significantly between the two islands  (t = 5.987, df = 111, p< 0.001).These results entail that observations were multiple lionfish present had higher density at St Thomas than St Croix. This could be do to the continental shelf and how it surrounds St Thomas allowing more dispersal into the area. There also could be more lionfishing occurring on St Croix.

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

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

rm(list = ls())
library(tidyverse)
library(ggplot2)
lionfish <- read_csv("TCRMP_Lionfish.csv")

# Explore your newly imported dataset.

view(lionfish) #opens full dataset
head(lionfish) #shows first 6 rows of data
tail(lionfish) #shows last 6 rows of data
str(lionfish) #shows structure of data

# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

# You want to check the rows and columns to see if R imported the dataset correctly. Look to see if you are working with strictly continuous data, or a mix of continuous and categorical data.


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

TCMRP_sites <- lionfish |> 
  group_by(Location) |>
  mutate(Mean_biomass = mean(Biomass)) # pulls data from lionfish and calls it TCRMP_sites in the environemnt. groups it by location. makes a new column (mutate) called Mean_biomass that has the mean biomass for each year.

Cor_BiomassDepth <- cor.test(TCMRP_sites$Mean_biomass, TCMRP_sites$Depth, method = "pearson") # tells us p-value, confidence intervals and correlation value (again)
Cor_BiomassDepth$p.value

ggplot(data = TCMRP_sites, aes(x = Mean_biomass, y = Depth)) +
  geom_point(color = "palevioletred") +
  labs(x = "Mean Lionfish Biomass (g/100m^2)", y = "Site Depth (m)", title = "Relationship between Depth and Biomass of Lionfish in USVI", subtitle = "p-value = 1.358931e-70, cor = 0.771062") + # labels the axes, title, and adds value of p and cor.test
  theme_get() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"), plot.subtitle = element_text(hjust = 0.5)) # centers title and subtitle

# Statistically, this relationship is positively correlated (0.771062). The correlation is fairly strong but not very strong as 0.7 is closer to 1 than to 0 but is not the highest it could be. All of this means that sites with greater mean lionfish biomass tend to be found deeper. The small p-value (1.358931e-70) shows us that there is likely a relationship between depth and lionfish biomass, and that it would be extremely unlikely for us to get the relationship we did if there was no actual linear relationship between our variables.
# Visually, the scatterplot generally agrees with the correlation test. The points generally have a positive trend, where mean lionfish biomass increases with site depth from left to right. There are some outliers, or data that is not perfectly in line with the trend. These are what are likely contributing to the relatively strong (~0.7) and not extremely strong (>0.9) correlation.
# Ecologically, the results may indicate that mean lionfish biomass and depth are associated with one another at the USVI study sites. One possible reason for this relationship, ecologically, could be that deeper habitats have more habitat complexity, and therefore more prey availability, leading to bigger lionfish. More statistical tests, besides just correlation would need to be done to prove an actual relationship, but, based on this data, deeper sites tend to support bigger lionfish.


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

Many_fish <- lionfish |> 
  group_by(Island) |> 
  filter(TotalCount > 1) |> 
  mutate(Density_many_fish = log10(TotalCount/ntrans)) # pulls data from lionfish and calls it Many_fish in the environemnt.only takes data points with more than 1 fish; groups by Island, makes a new column (mutate) called Density_many_fish that has the density of fish per island calculated by dividing TotalCount by number of transects. log10 balances / normalizes the data so it isn't so condensed.

ggplot(Many_fish, aes(x = Island, y = Density_many_fish, fill = Island)) + #puts Island on the X-axis, and density of lion fish on the Y-axis.
  geom_boxplot() + 
  geom_jitter(alpha = 0.5) + #shows the points spread out, with some transparency
  labs(x = "Study Island", y = "log(Density) of Lionfish (fish/100 m^2)", title = "log(Density) of Lionfish on St. Thomas and St. Croix, USVI") +
  theme_get() + theme(plot.title = element_text(hjust = 0.5, face = "bold")) #some customizations

ggplot(Many_fish, aes(x = Density_many_fish, fill = Island)) + #colors bars by island
  geom_histogram() + 
  facet_wrap(~ Island) + #separates islands into their own histograms within the same graph
  labs(title = "Density of Lionsish on St. Thomas and St. Croix", x = "Island", y = "Number of Lionsfish") # names axes, title

t_test_results <- t.test(Density_many_fish ~ Island, data = Many_fish) #runs t-test on this data

ggplot(Many_fish, aes(x = Island, y = Density_many_fish, fill = Island)) +
  geom_boxplot() + 
  geom_jitter(alpha = 0.6) +
 #makes a boxplot
  labs(title = "Lionfish Density by Island with t-Test Results", x = "Island", y = "log(Density) of Lionsfish (fish/100m^2)",
       subtitle = paste("Test Statistic = ", round(t_test_results$statistic, 3),
                        "p-value = ", format.pval(t_test_results$p.value, digits = 2, eps = 0.001))) + #puts the test statistic in the subtitle rounded to 3 sig figs; puts the p-value in the subtitle rounded to 2 sig figs, specifies if the number is less than 0.001 to just write that instead (threshold of 0.001)
  scale_fill_manual(values = c("hotpink", "palegreen")) +
  theme_get() + theme(plot.title = element_text(hjust = 0.5, face = "bold"), plot.subtitle = element_text(hjust = 0.5)) +
  theme(legend.position = "none") # some customizations that color the boxes, center the title and subtitle, and remove the legend
  
# In my first visualization, all of the data for each island was clumped and very small at the bottom of the graph, making it very hard to see actual difference or what the data even looked like. In order to address this, I scaled the data up by log10 which spreads out the small numbers and makes them more balanced / easier to read and interpret. I also created a histogram so I could better see the skew of the data. When I ran the t-Test, my assumptions were met, so I did not need to change anything.
# link to website I used to help with the log scaling: "ggplot2 Axis Limits & Scales in R" from Datanovia - https://www.datanovia.com/learn/data-visualization/ggplot2/axis-limits-scales 

# We reject the null hypothesis, concluding there was a significant difference between lionfish densities across islands (t(df) = 5.987(110.99); p = 2.38e-06). These results mean that there are more lionfish living in waters around St. Thomas, as compared with St. Croix. Ecologically, there could be many reasons for this, including high habitat complexity, more food availability, and/or a lack of predators around St. Thomas. Fishing may also be a bigger factor in St. Croix compared to St. Thomas, leading to smaller populations of lionfish in STX.

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

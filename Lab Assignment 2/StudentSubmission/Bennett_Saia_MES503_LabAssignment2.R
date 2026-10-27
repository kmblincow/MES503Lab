# MES 503 Lab Assignment 2
# Exploring correlation and t-tests with TCRMP data

# 9/15/2026
# Created by Kayla Blincow (with help from ChatGPT)
# ------------------------------------------------------------------------------

# INSTRUCTIONS

# Complete this script as you work through the assignment.

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

TCRMP_Lionfish <- read.csv("Week 5/TCRMP_Lionfish.csv")

# Explore your newly imported dataset.

head(TCRMP_Lionfish)

str(TCRMP_Lionfish)


# 1. Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

# 1. The are a few columns that say "col_character()" which tells R to read a specific data column as text (character strings). There is also that fact that there are multiple value for a single sight over the years. Between 2011-2022. 




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
# 4. Interpret the results of your correlation test and visual. What does it mean
#    statistically? What does it mean ecologically?

# HINT: The original dataset contains multiple observations for each monitoring
# location because sites were sampled across multiple years.To answer this 
# research question, we want ONE observation per location.

TCRMP_Summarized <- TCRMP_Lionfish |> #assigns every subsequent code to a name  in the environment and then begins the code by starting with the dataset
                        group_by(Location) |> #arranges the rows so all the locations of the same name are together
                        summarise( 
                                  mean_depth = mean(Depth),
                                  mean_biomass = mean(Biomass)
                                  ) #finds the mean depth and biomass for each location

cor.test(TCRMP_Summarized$mean_depth, TCRMP_Summarized$mean_biomass) #does a correlation test 
Lionfish_cor <- cor.test(TCRMP_Summarized$mean_depth, TCRMP_Summarized$mean_biomass) #assigns correlation test to the phrase "yt_snap"

Lionfish_cor$p.value # pull out just the p-value
Lionfish_cor$estimate # pull out just the correlation coefficient

ggplot(data = TCRMP_Summarized, aes(x = mean_depth, y = mean_biomass))+ #assigns the proper x,y, and Location categorization to all following code
  geom_point(size = 3) + #applies points and changes the size 
  labs(title = paste ("Depth and Biomass of St. Thomas and St. Croix Lionfish", 
                      paste("r =", round(Lionfish_cor$estimate, 2),
                            ", p =", format.pval(Lionfish_cor$p.value, digits = 2, eps = 0.001)), 
                      sep = "\n"),
       x = "Mean Depth", y = "Mean Biomass") + #defines the proper titles for all graph elements. I also added a line to the title for the p-value and coefficient and rounded them 
  theme_bw() + #start with a clean built-in theme
  theme(plot.title = element_text(hjust = 0.5, face = "bold"), #center + bold the title
        panel.border = element_rect(color = "black", fill = NA, linewidth = 1)) # adds a black frame


# FILL IN WRITTEN ANSWERS
# Visually it seems there is a gradual positive correlation between depth and biomass. Statistically the correlation is .81 which confirms that the relationship is positive and that there us a strong interaction as it is close to 1! Ecologically this could mean lion fish are larger at deeper depths to accommodate colder temperatures.





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

Island_Count <- select( #this assigns all following code to a name in the environment 
  filter(TCRMP_Lionfish, 
         TotalCount > 1), #this starts with the original dataset then pulls all rows where the value in the "TotalCount" column is greater than 1 
  TotalCount, Island, ntrans) |> # this pulls the specified columns from the original dataset
  mutate(Density = TotalCount / ntrans) # this adds a new column called "Density" by dividing "TotalCount and ntrans
  
#Skewed Data Graphs:
ggplot(Island_Count, aes(x = Density, fill = Island)) + #assigns the proper x,y, and any specifications like "fill" and "color" to all following code
  geom_histogram() + #makes the graph a histogram 
  facet_wrap(~ Island) + #divides the graph by whatever specified variable in this case by Island
  labs( title = "Density and Fish Count on STT and STX", 
    x = "Density",
    y = "Number of Lionfish"
  ) #defines the proper titles for all graph elements.

ggplot(Island_Count, aes(x = Island, y = Density)) + #assigns the proper x,y, and any specifications like "fill" and "color" to all following code
  geom_boxplot() + #makes the graph a boxplot
  labs( title = "Density on STT and STX",
    x = "Island",
    y = "Lionfish Density"
  ) #defines the proper titles for all graph elements.

t.test(Density ~ Island, data = Island_Count) #runs a t-test

#Final Graphs:
Island_Count$log_Density <- log(Island_Count$Density) # adds a new column and transforms the right skewed data by logging the response variable

head(Island_Count) #pulls the first 6 rows from the specifieed dataset

Lionfish_T <- t.test(log_Density ~ Island, data = Island_Count) #runs a t-test and assigns to name in environment 


ggplot(Island_Count, aes(x = log_Density, fill = Island)) + #assigns the proper x,y, and any specifications like "fill" and "color" to all following code
  geom_histogram() + #makes the graph a histogram
  facet_wrap(~ Island) + #divides the graph by whatever specified variable in this case by Island
  labs(title = paste ("Log_Density and Fish Count on STT and STX", 
                      paste("r =", round(Lionfish_T$statistic, 2),
                            ", p =", format.pval(Lionfish_T$p.value, digits = 2, eps = 0.001)), 
                      sep = "\n"),
       x = "Log_Density", y = "Number of Observations") #defines the proper titles for all graph elements. I also added a line to the title for the p-value and statistic and rounded them 

ggplot(Island_Count, aes(x = Island, y = log_Density)) + #assigns the proper x,y, and any specifications like "fill" and "color" to all following code
  geom_boxplot() +
  labs(title = paste ("Log_Density on STT and STX", 
                      paste("r =", round(Lionfish_T$statistic, 2),
                            ", p =", format.pval(Lionfish_T$p.value, digits = 2, eps = 0.001)), 
                      sep = "\n"),
       x = "Island", y = "Lionfish Log_Density") #defines the proper titles for all graph elements. I also added a line to the title for the p-value and statistic and rounded them 


# FILL IN WRITTEN ANSWERS HERE

# After doing the data wrangling of the first two histogram and box-plot graphs I noticed the data is positively right skewed. Meaning it does not have a normal distribution, therefore violating our t-test assumptions. To fix this one must transform the respose variable with log() function. 

# After logging and creating new histogram and bosplot graphs you can clearly seeing a significant mean difference in log_density between st. thomas and st. croix. So in the interest of a paper I would write the following: Lionfish density differed significantly between St. Thomas (STT) and St. Croix (STX). A Welch’s two-sample t-test on log-transformed density indicated that mean density was higher on STT than on STX. On the original density scale, mean lionfish density was 1.06 on STT compared with 0.39 on STX. Ecologically this could be explained by resource abundance on St. Thomas or even topographical reef protection. On St. Thomas isles, bays and reefs are more protected from wave disruption due to island shape in comparison to St. Croix.

# References: 
  # - AlmaBetter. (2026, January 9). 3 best ways to handle right skewed data. https://www.almabetter.com/bytes/articles/3-best-ways-to-handle-right-skewed-data
  #  -OpenAI. (2026). ChatGPT (GPT-5.6 Luna) [Large language model]. https://chatgpt.com/


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

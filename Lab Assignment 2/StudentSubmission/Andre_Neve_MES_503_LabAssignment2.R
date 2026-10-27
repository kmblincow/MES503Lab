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

lion <- read.csv("TCRMP_Lionfish.csv")

# Explore your newly imported dataset.

head(lion)
str(lion)

# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

# Some locations simply have a count of 0.




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

# want biomass and depth per location

unique(lion$Location) #damn 31 locations (too many idk)
  

site_data <- lion |> 
  group_by(Location) |> 
  summarise( Depth_m = first(Depth), 
             Total_Biomass = sum(Biomass, na.rm = T) ) #consolodating the data

str(site_data) #viewing the dataset

cor_test <- cor.test( site_data$Depth_m, 
                      site_data$Total_Biomass, method = 
                        "pearson") #statistical analysis


r_value <- cor_test$estimate
p_value <- cor_test$p.value

ggplot(data = site_data, 
       mapping = aes( x = Total_Biomass, y = Depth_m)) +
  geom_point() + geom_smooth(method = "lm") +
  labs(x = "Total Biomass",
       y = "Depth (m)", 
       title = "Total Biomass and Depth of Lionfish") +
  annotate( "text", x = Inf, y = Inf, label = paste0( "R = ", round(r_value, 3), "\np = ", format.pval(p_value, digits = 3) ), hjust = 1.1, vjust = 1.5, size = 5 ) + theme_classic() #visualization

# FILL IN WRITTEN ANSWERS
# There is a positive correlation between the two variables, which are statistically significant, given that p= 5.99^-6. Visually, this correlations isn't as strong, however, with an apparent leveling off of depth around 40 meters. 


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

isl_lion <- lion[ lion$Island == "STT" | lion$Island == "STX", ] #Isolating the 
# STT and STX lionfish data.

many_fish <- lion |>
  filter(TotalCount > 1) |>
  mutate( Density = TotalCount / ntrans ) # Getting rid of the no fish data,
# and setting up the density parameters.

table(many_fish$Island)
# Looking at the island data.


many_fish |> 
  group_by(Island) |>
  summarise( n = n(),
             Mean = mean(Density),
             Median = median(Density),
             SD = sd(Density),
             Minimum = min(Density),
             Maximum = max(Density) ) # Getting some statistics.

t.test(data = many_fish, x = "Density", y = NULL,
               alternative = c("two.sided"),
               mu = 0, paired = FALSE, var.equal = FALSE,
               conf.level = 0.95, )

# crying_face <- .OnO. (This took so long to figure out.)

isl_test <- cor.test( many_fish$TotalCount,
                      many_fish$Density,
                      method = "pearson") # Finding p value.


r_isl_value <- isl_test$estimate
p_isl_value <- isl_test$p.value # Saving to environment.

ggplot(data = many_fish, 
       mapping = aes(y = Density, 
                     x = Island,
                     color = Island)) +
       geom_violin() +
  labs( x = "Island", y = "Lionfish Density", title = "Lionfish Density per Island") +
  theme_bw() +
annotate( "text", x = Inf, y = Inf, 
          label = paste0( "R = ",
                          round(r_isl_value, 3),
                          "\np = ", 
                          format.pval(p_isl_value, digits = 3) ),
          hjust = 1.1, 
          vjust = 1.5, 
          size = 5 ) + 
          theme_classic() 

# A violin plot and statistical analysis, I believe.



# Lionfish appear to have a higher density around St Thomas, than St Croix.
# While they both have highest numbers of low density sites, St Thomas reaches 
# densities almost six times higher than St Croix, in its most populated areas. 
# If I was able to produce a t.test I imagine it would have supported this 
# analysis. The P value, however, shows this is significant, with a value of 
# <2^-16, and R= 0.858. Ecologically, this means that St Thomas feels much more 
# impact from the invasive lionfish than St Croix. They are likely out competing
# The native population for food and such. Conservation efforts should be
# concentrated primary around St Thomas. 


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

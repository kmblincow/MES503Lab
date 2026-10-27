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
library(ggplot2)
library(tidyverse)
library(dplyr)
tcrmp <- read.csv("Lab 2/TCRMP_Lionfish.csv")


# Explore your newly imported dataset.

head(tcrmp)
str(tcrmp)
nrow(tcrmp)
ncol(tcrmp)
colnames(tcrmp)


# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

#It would be important to note which variables are #categorical and which are
#continuous.You do not want to confuse numbers that are #categories with numbers that are continuous data.



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

tcrmp |> 
  count (Location) |>
  arrange(desc(n))

tcrmp_site <- tcrmp |>
  group_by(Location) |>
  summarise(
    Depth = mean(Depth, na.rm = TRUE),
    TotalBiomass = sum(Biomass, na.rm = TRUE)
  )

ggplot(tcrmp_site, aes (x = Depth, y = TotalBiomass)) +
  geom_point() +
  labs (
    x = "Depth (m)",
    y = "Total Lionfish Biomass (g/100m^2)",
    title = "Relationship Between Depth and Lionfish Biomass"
  ) + theme_classic()

cor_test <- cor.test(
  tcrmp_site$Depth,
  tcrmp_site$TotalBiomass,
  method = "pearson"
)
 cor_test
 
 ggplot (tcrmp_site, aes(x = Depth, y = TotalBiomass)) +
   geom_point () +
   geom_smooth(method = "lm", se = FALSE) +
   labs (
     x = "Depth (m)",
     y = expression ("Total Lionfish Biomass (g/100 m"^2*")"), title = "Relationship Between Depth and Lionfish Biomass",
     subtitle = "Pearson's r = 0.716, p < 0.001") +
   theme_classic()



#Statistically: The Pearson's correlation test showed a #significant positive relationship between site depth and #total lionfish biomass (r=0.716, p < 0.001), indicating #that deeper monitoring sites generally had greater total #lionfish biomass. However, the scatter plot graph did show #variation in biomass particularly on deeper sites as well #as a few high-biomass observations.

#Ecologically: The results suggest that lionfish biomass may #be greater at deeper reef sites within the TCRMP monitoring #locations. This could indicate that deeper reef habitats #support greater lionfish biomass; however,this correlation #alone could not determine why this pattern occurs or #establish depth as the cause.



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
# - Consider how your statistical interpretation might need #to change if you 
#   change your data as a result of assumption violations.

tcrmp_density <- tcrmp |>
  filter(TotalCount > 1) |>
  mutate(Density = TotalCount/ntrans)

head(tcrmp_density)

table(tcrmp_density$Island)

ggplot(tcrmp_density, aes(x = Island, y = Density)) +
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs (
    x = "Island",
    y = expression("Lionfish Density (fish/100m"^2*")"),
    title = "Lionfish density on St. Thomas and St. Croix"
  ) +
  theme_classic()

# The preliminary graph shows unequal sample size between #the two islands as well St. Thomas having a greater #variability in lionfish density and several high-density #observations. 

table(tcrmp_density$Island)

ggplot(tcrmp_density, aes( x= Density)) +
  geom_histogram(bins = 10) +
  facet_wrap (~ Island) +
  labs(
    x = expression("Lionfish Density 9fish/100 m"^2*")"),
    y = "Frequency",
    title = "Distribution of Lionfish Density by Island") +
  theme_classic()

#The histograms show that lionfish density is strongly right #-skewed for both islands rather than approximately normally #distributed. Most observations occur at low densities, with #a small number of much nigher density values. The normality #assumption of the t-test appears to be violated. 

tcrmp_density <- tcrmp_density |>
  mutate(logDensity = log(Density))

ggplot(tcrmp_density, aes(x = logDensity)) +
  geom_histogram(bins = 10) +
  facet_wrap(~Island) +
  labs(
    x = "Log-transformed Lionfish Density",
    y = "Frequency",
    title = "Distribution of Log-Transforned Lionfish Density by Island"
  ) +
  theme_classic()



ggplot(tcrmp_density, aes(x = Island, y = logDensity)) +
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(
    x = "Island",
    y = "Log-transformed lionfish density",
    title = "Log-Transformed Lionfish Density on St. Thomas and St. Croix"
  ) +
  theme_classic()

tcrmp_density |>
  group_by(Island) |>
  summarise(
    n = n(),
    variance = var(logDensity)
  )

t_test <- t.test(logDensity ~ Island,
                 data = tcrmp_density,
                 var.equal = FALSE)

t_test

# Preliminary graphs illustrated that the groups had #unequal sample sizes (STT n = 72; STX n = 41). The raw #density data were strongly right-skewed,indicating that the #normality assumption was not met. #Density was therefore #log-transformed, which substantially #reduced the skew in #both groups. After transformation, STT #still had a greater #variance (0.705) than STX (0.224). #Because the assumption #of equal variance was not met and #sample sizes were #unequal, Welch's two-sample t-test was #used. Welch's 
#t-test does not assume equal population #variances.



ggplot(tcrmp_density, aes(x = Island, y = logDensity)) +
  geom_boxplot() +
  geom_jitter(width = 0.1) +
  labs(
    x = "Island",
    y = "Log-transformed lionfish density",
    title = "Lionfish Density on St. Thomas and St. Croix",
    subtitle = "Welch's t-test: t(111) = 5.99, p < 0.001"
  ) +
  theme_classic()


#Statistically: Lionfish density differed significantly #between St. Thomas and St. Croix. mean Log-transformed #lionfish density was significantly higher on St. Thomas #than on St. Croix (Welch's two-sample t-test: t(111) = 5.99
#, p < 0.001). These results indicate that among #observations in which multiple lionfish were recorded, #lionfish tended to occur at higher denisties on St. Thomas #than on St. Croix.

#Ecologically: These results suggests that wehn multiple #lionfish were encountered at TCRMP monitoring sites, they #tended to occur at higher densities on St. Thomas than on
#St. Croix. This may reflect the differences in lionfish #populations or reef conditions between the islands; however #, this analysis does not identify the ecological mechanisms #responsible for the observed difference. 

#Sources
#https://r-coder.com/log-exp-r/

#West, R. M. (2021). Best practice in statistics: The use of #log transformation. Annals of Clinical Biochemistry #International Journal of Laboratory Medicine, 59(3), #162–165. https://doi.org/10.1177/00045632211050531


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

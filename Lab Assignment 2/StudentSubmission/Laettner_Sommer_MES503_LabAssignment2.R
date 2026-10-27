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

install.packages("tidyverse")

library(tidyverse)

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

install.packages("tidyverse")

library(tidyverse)

lionfish <- read.csv("Week 6/TCRMP_Lionfish.csv")

getwd()
list.files()
head (lionfish)
tail(lionfish)
# Explore your newly imported dataset.

# FILL IN CODE

# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

# there are some sites that have different counts of trasnects, so some sights have more. also 31 unique and a measure for biomass but im not sure what else 
# I am supposed to notice out of the ordinary

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

lionfish |>
  group_by(Location) |>
  summarise (
Depth = mean(Depth),
Biomass = sum(Biomass))

lionfishbiomassmean <- 
  lionfish |>
  group_by(Location) |>
  summarise (
    Depth = mean(Depth),
    Biomass = sum(Biomass))


cor(lionfishbiomassmean, lionfishbiomassmean)
cor.test(lionfishbiomassmean$Biomass, lionfishbiomassmean$Depth, method = "pearson")

lionfish_cor <-cor.test(lionfishbiomassmean$Biomass, lionfishbiomassmean$Depth, method = "pearson")

lionfish_cor$p.value
lionfish_cor$estimate

ggplot(data= lionfishbiomassmean,
       mapping = aes(x = Biomass,
                     y = Depth,
                     )) +
                     geom_point() +
  labs(title = "biomass vs depth",
       x = "Biomass(grams/100m^2)",
       y = "Depth(meters)") +
  geom_point() + #scatterplot of points
  labs(subtitle = paste("r =", round(lionfish_cor$estimate, 2),
                     ", p =", format.pval(lionfish_cor$p.value, digits = 2, eps = 0.001)))
      
       
       
# FILL IN WRITTEN ANSWERS

#my p value is 5.9 e -06 so it was statistically significant because it is much less than 0.05
# my r = 0.716
#Because it is positive, the two variables increase together.
#Because it is fairly close to +1, this is a strong positive correlation.


#### PART 3: T-TEST

# RESEARCH QUESTION:
# In cases where multiple lionfish were observed, did they tend to occur at
# higher density on St. Thomas or St. Croix?

# To address this question you must:
# 1. Complete the necessary data wrangling tasks.
# 2. Create a preliminary visualization comparing lionfish density between the
#    two islands. Do you notice anything you might need to address?
#### PART 3: T-TEST

# RESEARCH QUESTION:
# In cases where multiple lionfish were observed, did they tend to occur at
# higher density on St. Thomas or St. Croix?

# To address this question you must:
# 1. Complete the necessary data wrangling tasks.

islanddensity <- lionfish |>
  filter(TotalCount > 1) |>
  mutate(
    density = TotalCount / ntrans
  )

# 2. Create a preliminary visualization comparing lionfish density between the
#    two islands. Do you notice anything you might need to address?

ggplot(islanddensity, aes(x = Island, y = density)) +
  geom_boxplot() +
  labs(
    x = "Island",
    y = "Lionfish density (fish/100 m²)",
    title = "Lionfish Density on St. Thomas and St. Croix"
  )

## The preliminary visualization shows that lionfish density appears higher on
# St. Thomas than on St. Croix. The data also appear right-skewed, with some
# higher-density observations on St. Thomas. Normality should be
# checked before conducting the t-test, and a log transformation is needed.

# 3. Check the assumptions of the t-test, and state whether your assumptions are
#    met or violated. If they are violated, research what you can do, and implement
#    a fix. Document what you did and why--include a visualization if appropriate.

ggplot(islanddensity, aes(x = density)) +
  geom_histogram(bins = 10) +
  facet_wrap(~ Island) +
  labs(
    x = "Lionfish density (fish/100 m²)",
    y = "Count",
    title = "Distribution of Lionfish Density by Island"
  )


# The original density data were right-skewed, so a log transformation
# was used to reduce skewness and improve normality.

islanddensity <- islanddensity |>
  mutate(
    log_density = log(density)
  )


# Examine the transformed distributions.

ggplot(islanddensity, aes(x = log_density)) +
  geom_histogram(bins = 10) +
  facet_wrap(~ Island) +
  labs(
    x = "Log-transformed lionfish density",
    y = "Count",
    title = "Log-Transformed Lionfish Density by Island"
  )


# Check normality of the transformed data.

shapiro.test(
  islanddensity$log_density[islanddensity$Island == "STT"]
)

shapiro.test(
  islanddensity$log_density[islanddensity$Island == "STX"]
)


# both Shapiro-Wilk results:

# Both Shapiro-Wilk tests were significant:
# St. Thomas: W = 0.9614, p = 0.0265
# St. Croix: W = 0.9303, p = 0.0147
# Both p-values are below 0.05, indicating that normality was violated.
# Because the original data were right-skewed, a log transformation was used
# to reduce the right-skewness of the distributions. The transformed data
# were still slightly non-normal. Because the sample sizes were reasonably
# large, a Welch's t-test was used, which is a moderate departure
# from normality.



# 4. Conduct a t-test.

t_test <- t.test(
  log_density ~ Island,
  data = islanddensity
)

t_test


# 5. Create a visual to accompany your statistical test that includes appropriate
#    axis labels, units, an informative title, and the p-value and test statistic
#    from your t-test.

# Visualize the results.

ggplot(islanddensity, aes(x = Island, y = log_density)) +
  geom_boxplot() +
  geom_jitter(width = 0.1, alpha = 0.5) +
  labs(
    x = "Island",
    y = "Log-transformed lionfish density (fish/100 m²)",
    title = "Lionfish Density on St. Thomas and St. Croix",
    subtitle = paste0(
      "Welch's t-test: t = ",
      round(t_test$statistic, 2),
      ", p = ",
      signif(t_test$p.value, 3)
    )
  )


# 6. Provide a written interpretation of your results. Write your t-test results
#    as you would if you were presenting them in a peer-reviewed paper. Also 
#    include an ecological interpretation of your results. 

#A Welch’s t-test showed that log-transformed lionfish density differed significantly between St. Thomas and St. Croix, t(111) = 5.99, p < 0.001. Mean log-transformed lionfish density was higher on St. Thomas (-0.318) than on St. Croix (-1.058).
#Ecologically, these results suggest that lionfish density was higher on St. Thomas than St. Croix in this dataset. This difference may reflect differences in habitat, prey availability, environmental conditions, or fishing pressure between the islands.


# Use the information below to prepare your data:
# - An observation of MULTIPLE lionfish means that TotalCount is greater than 1.
# - Density = TotalCount / Number of Transects
# - Density is expressed in units of fish/100 m^2.
# - Consider how your statistical interpretation might need to change if you 
#   change your data as a result of assumption violations.

# # Prepare the data by keeping observations with multiple lionfish
# and calculating lionfish density.

islanddensity <- lionfish |>
  filter(TotalCount > 1) |>
  mutate(
    density = TotalCount / ntrans
  )

# Log-transform density to reduce right-skewness before conducting
# the statistical test.

islanddensity <- islanddensity |>
  mutate(
    log_density = log(density)
  )


# WRITTEN ANSWER:
# Observations with multiple lionfish (TotalCount > 1) were used to
# calculate lionfish density as TotalCount divided by the number of
# transects. Density was expressed as fish/100 m^2. Because the density
# data were right-skewed, a log transformation was used to reduce
# skewness before comparing the two islands. The Welch's t-test showed
# that lionfish density differed significantly between St. Thomas and
# St. Croix, with higher density on St. Thomas (t(111) = 5.99, p < 0.001).


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

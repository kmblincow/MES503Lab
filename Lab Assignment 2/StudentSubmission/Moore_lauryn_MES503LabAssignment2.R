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
# Explore your newly imported dataset.

# FILL IN CODE

Lionfish <- read.csv("Week Five/TCRMP_Lionfish.csv")
print(Lionfish)


# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

# FILL IN WRITTEN ANSWER HERE
#when I am looking at the data set I can see that across all years there are multiple
#observations at different sites. Meaning that the locations are not organized 
#according to their sample year, they are grouped together within one row. Another thing
#is that biomass is different at each site, which also isn't grouped by its year. 
#I will have to organize the data to ensure that the columns and rows are in more distinct positions.



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
#summing the biomass for each location
Lionfish_dataset <- Lionfish |>
  group_by(Location) |>
  summarize(Depth = first(Depth), total_biomass_g = sum(Biomass))

#corrlation test
lionfish_cor <- cor.test(Lionfish_dataset$Depth, Lionfish_dataset$total_biomass_g,
                                                  method = "pearson")
#displaying the p-value and correlation coefficient
lionfish_cor$estimate
lionfish_cor$p.value

#creating the final plot of the correlation 
ggplot(Lionfish_dataset, aes(x= Depth, y= total_biomass_g))+
  geom_point()+
  labs(x= "Depth_M",
  y= "Total_Biomass_g", 
  title = "Depth Vs Total Lionfish Biomass",
  subtitle = paste0("t = ", round(lionfish_cor$estimate, 2),
                    ", p = ", format.pval(lionfish_cor$p.value, digits = 3)),)
# FILL IN WRITTEN ANSWERS
#Statistically the value calculated by the correlation test suggests that there is a relationship
#between Depth and The total biomass observed across each site across all years. 
#This can be inferred because the p-value is smaller than 0.05. and the correlation coefficient
#is close to one. 

#Ecologically this could mean that depth might have a relationship with Total_Biomass.
#The statistics suggest that the deeper you go the more biomass is observed at each 
#site across all years. There are multiple factors like the deeper you go the less human 
#interaction you get.



#### PART 3: T-TEST

# RESEARCH QUESTION:
# In cases where multiple lionfish were observed, did they tend to occur at
# higher density on St. Thomas or St. Croix?

# To address this question you must:
# 1. Complete the necessary data wrangling tasks.
# 2. Create a preliminary visualization comparing lionfish density between the
#    two islands. Do you notice anything you might need to address?*****
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
#Creating and isolating the density, then creating a preliminary plot
Lion_density <- Lionfish |> 
              filter(TotalCount > 1) |> 
              mutate(density = TotalCount/ ntrans)
ggplot(Lion_density, aes(x= Island, y= density))+
  geom_boxplot()+
  labs(title = "Preliminary Lionfish Density by Island",
       x = "Island", y = "Density (fish/100 m²)")

#test for normality
ggplot(Lion_density, aes(x = density)) +
  geom_histogram(bins = 10) +
  facet_wrap(~ Island) +
  labs(
    x = "Island",
    y = "Density"
  )

#test for unequal variances
ggplot(Lion_density, aes(x= Island, y= density))+
  geom_boxplot()+
  labs(title = "Preliminary Lionfish Density by Island",
       x = "Island", y = "Density (fish/100 m²)")

#transforming the data using log
lionfish_density <- Lion_density |>
  mutate(logdensity = log(density)) 
names(lionfish_density)

#conducting the t.test
density_t.test <- t.test(logdensity ~ Island, data = lionfish_density)
print(density_t.test)

#printing the p-value and t.test statistic
density_t.test$p.value
density_t.test$statistic

#plotting the t.test
ggplot(lionfish_density, aes(x= Island, y=logdensity))+
  geom_boxplot()+
  labs(title = "Log-Transformed Density on St. Thomas and St. Croix ",
       subtitle = paste0("t = ", round(density_t.test$statistic, 3),
                         ", p = ", format.pval(density_t.test$p.value, digits = 3)),
     x = "Island", y = "Density (fish/100 m²)")

#calculating the standard deviation and isolating by island
Lionfish_sdSTX <- sd(lionfish_density$logdensity[lionfish_density$Island == "STX"])
print(Lionfish_sdSTX)

Lionfish_sdSTT <- sd(lionfish_density$logdensity[lionfish_density$Island == "STT"])
print(Lionfish_sdSTT)

# FILL IN WRITTEN ANSWERS HERE

#A two sample t-test was performed to compare Lion fish density in St.Thomas and St. Croix.
#There was a significant difference in Densities between St.Thomas, and St.Croix  
#group one St. Thomas (M = -0.3182808, SD = 0.8394878 and group2 St.Croix -1.0576060, SD = 0.4731644; 
#df = 97.611, [t = 5.838, p-value = 6.917e-08. The two medians don't overlap meaning that the typical values
#seen from each data set are significantly different from each other.

#Ecologically this means that there is a significant difference in lion fish population in St.Thomas than in St. Croix.
#The population of fish on St.Thomas can be observed using the bar graph to have a larger density of lionfish
#on st.Thomas than on st.croix. This could occur by a multitude of things, lack of predators in St.Thomas, to lack of prey in st.croix 




#### FINAL CHECK

# Before submitting, make sure you have:

# DATA & CODE
# [ yes] Successfully imported the data.
# [ yes] Explored and checked your data before beginning your analyses.
# [ yes] Completed all required data wrangling.
# [ yes] Added comments that explain important steps in your workflow.

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

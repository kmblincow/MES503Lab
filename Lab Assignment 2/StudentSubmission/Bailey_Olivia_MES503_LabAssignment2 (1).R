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

rm(list= ls())
library(dplyr)
library(tidyverse)

# Explore your newly imported dataset.

library(readxl)
Lionfish <- read_excel("~/UVI/CodeLab/Week 6/Lionfish.xlsx") #this is my correlation test

# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

str(Lionfish)
head(Lionfish)

#Yes,there are 6 differnt locations, from 2011 to 2022. The data surveyed was total count, biomass, the island the site was on, the reef complex, and the depth. 


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

part2 <- Lionfish |> 
  select(Location, Biomass,Depth, SampleYear) |> 
group_by(Location, Depth) |> 
  summarize(mean_biomass=mean(Biomass, na.rm = TRUE))
#this is where i seperated the important columns for the test and made a new data file to keep things organized
part2cor<- cor.test (part2$mean_biomass, part2$Depth, method= "pearson") #this is my correlation test

part2cor$p.value
# i wanted to do this to pull out just the P value, which is very small at 1.73e-25
part2cor$estimate
# i wanted to do this to pull out just the correlation value, which is 0.517, telling me its kind of correlated. 
  
  ggplot(data = part2, 
         mapping = aes(x = Depth, y = mean_biomass, color = factor(Location)))+ #i needed to use factor so that i could assign individual colors to each year, originally i was getting colors and a legend that was continuous, but this didnt make sense to me as i veiw each year as a seperate data point
    geom_point(size = 2, alpha = 0.7) +
    geom_smooth(method = "lm", color = "black") + #for the linear regression line
    labs(title = "Lionfish Biomass at Depth", 
         subtitle = paste("r = ", round(part2cor$estimate, 2), " p = ", 
         format.pval(part2cor$p.value, digits = 2, eps = 0.001)), 
  x = "Depth (m)", 
  y = "Biomass (g)", 
  color = "Location")+
  theme_bw()

#There is a significant relationship between depth and biomass with a p value of p < 0.001, and there is a positive correlation with r=0.5173. As depth increases, so does lionfish biomass. This may be because in the USVI, lionfish are hunted for sport, particularly by free divers and scuba divers. Sport fishers are not able to get very deep, where these bigger fish may be retreating to. Lionfish may also spawn in shallower reef areas, which may be why there are more counts but less biomass in the shallower depths. 
  
  #lionfish spawining info: https://marinescienceodyssey.org/lionfish-deep-versus-shallow-reefs-in-curacao/n
  #lionfish hunting info: https://www.islandrootscharters.com/charter-blog/lionfish-invasion-usvi-bvi 

#_______________________________________________________________________________
#### PART 3: T-TEST

# RESEARCH QUESTION:
# In cases where multiple lionfish were observed, did they tend to occur at
# higher density on St. Thomas or St. Croix?
  
# okay, so we need a data set with TOTALCOUNT is over 1, DENSITY, and ISLAND
  
# To address this question you must:
# 1. Complete the necessary data wrangling tasks.
  
 part3 <-Lionfish |> 
   filter(Lionfish$TotalCount>1,) |> 
  mutate(Density = TotalCount/ntrans) |> 
   select(TotalCount,Density,Island)
 
# 2. Create a preliminary visualization comparing lionfish density between the two islands. Do you notice anything you might need to address?
 
 ggplot(part3, aes(x = Density)) +
   geom_histogram(bins = 10) +
   facet_wrap(~Island) +
   labs(
     x = "Lionfish Density)",
     y = "Count") + 
   theme_bw()
 #oh no! this data looks very skewed to the left. This tells me the data may not normal, and I will have to do some changing of the data in order to do a t test. 
# 3. Check the assumptions of the t-test, and state whether your assumptions are met or violated. If they are violated, research what you can do, and implement a fix. Document what you did and why--include a visualization if appropriate.
 
 #INDEPENDANCE
 #i can not determine independence from just the data set, so I will assume it is independant.
 
 #NORMALITY
 ggplot(part3, aes(x = Density)) +
   geom_histogram(bins = 10) +
   facet_wrap(~Island) +
   labs(
     x = "Lionfish Density)",
     y = "Count") + 
   theme_bw()
 #the data sets do not appear to be normally distributed, they are left skewed, i will certainly need to check t test assumptions.
 
 #EQUAL VARIANCE
 ggplot(part3, aes(x = Island, y = Density)) +
   geom_boxplot() +
   scale_y_log10() + #helen and emma taught me this
   labs(
     x = "Island",
     y = "Density ")
 #there is unequal variance, so the t test im using can not be assuming equal variance
 
# 4. Conduct a t-test that addresses the research question.
part3m<- part3 |> 
  mutate(logdensity=log(Density)) #I needed to make a new column with log density, which will help make the data normal again.I learned this from Lauryn and Rob. I also confirmed with this website https://rpubs.com/StatsResource/Log_Transformation 

lionfish_test<-t.test(logdensity~Island, data = part3m) #I ran the t test with the new log density column! 

lionfish_test
# p = very small
#STT mean = -0.318
#STX=-1.058

# 5. Create a visual to accompany your statistical test that includes appropriate axis labels, units, an informative title, and the p-value and test statistic from your t-test.


ggplot(part3m, aes(x= Island, y = logdensity, fill = Island))+
         geom_boxplot()+
labs(title = "Lionfish Density across St. Thomas and St. Croix", 
     subtitle = paste("t = ",round(lionfish_test$statistic,2),"p =",
                      format.pval(lionfish_test$p.value, digits = 3, eps = 0.001)), 
     x = "Island", 
     y = "Density (Fish/100m^2)", 
     color = "Location")+
  theme_bw()

# 6. Provide a written interpretation of your results. Write your t-test results as you would if you were presenting them in a peer-reviewed paper. Also include an ecological interpretation of your results. 

part3m |> 
  group_by(Island) |> 
  summarize(sd_density = sd(Density)) #i needed to make a new group by in order to get the island sd seperately 
#SD STT = 1.07, SD STX = 0.226

#St. Croix had a significantly lower density than St. Thomas.A two sample t-test was performed to compare Lionfish Density in islands St. Thomas and St. Croix. 
#There was a significant difference in Lionfish density between St. Thomas(M = -0.0318, SD = 1.07) and St. Croix(M=-1.058, SD=  0.226); t(df) = 5.9871, p = p<0.001. St.Thomas has more shallow habitat than St. Croix, due to its shallow and expansive underwater shelf. St. Croix has less shallow underwater shelf, which quickly drops off to uninhabitable habitat for lionfish. Because of this, lionfish in St Croix may need to stay shallower, possibly explaining why there are not as many fish in St. Croix in comparison to St. Thomas. 
#I got the information about the shelf from https://climatechangevi.wordpress.com/physical-setting/ 

#I got this publishable prompt from statology


# Use the information below to prepare your data:
# - An observation of MULTIPLE lionfish means that TotalCount is greater than 1.
# - Density = TotalCount / Number of Transects
# - Density is expressed in units of fish/100 m^2.
# - Consider how your statistical interpretation might need to change if you 
#   change your data as a result of assumption violations.




#### FINAL CHECK

# Before submitting, make sure you have:

# DATA & CODE
# [ x] Successfully imported the data.
# [ x] Explored and checked your data before beginning your analyses.
# [x ] Completed all required data wrangling.
# [x ] Added comments that explain important steps in your workflow.

# ANALYSIS
# [x ] Addressed each research question.
# [ x] Considered the assumptions relevant to your statistical analyses.
# [ x] Researched and documented how you addressed any violated assumptions.

# VISUALIZATIONS
# [x ] Created all required visualizations.
# [x ] Included appropriate axis labels, units, and titles.
# [x] Customized your visualizations appropriately.
# [x] Made sure your visualizations accurately represent your data.

# INTERPRETATION
# [x] Reported the important results from your statistical analyses.
# [x] Provided statistical interpretations of your results.
# [x] Connected your results back to the research questions.
# [x ] Provided ecological interpretations where appropriate.

# FINAL SCRIPT
# [x] Answered all written questions and prompts.
# [x] Included citations or links for any outside resources you used.
# [x] Checked that your script runs from beginning to end without errors.
# [x} Saved your script using the required filename.

# SAVE YOUR SCRIPT AND SUBMIT TO BRIGHTSPACE!

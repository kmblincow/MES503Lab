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
#data file

rm(list = ls()) #clear workspace
library(ggplot2) #visualize data
library(dplyr) #wrangle data
#OR library(tidyverse)to load all at once

lionfish <- read.csv("C:/Users/desti/OneDrive/Documents/MES503L(Stats)/Lab assignment 2/TCRMP_Lionfish.csv")
#load csv and create object "lionfish"

# Explore your newly imported dataset.

head(lionfish) #view first 6 rows of data
str(lionfish) #look at structure of data
view(lionfish)#look at table
# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

#There are two continuous, dependent variables (Depth, Biomass)while other variables are Categorical, 
#Independent,& Discrete(Ex: SampleYear,Code,Island,etc)this will be important for correlation tests and 
#visualization of the data as correlation only occurs between two dependent variables and
#will influence which plots we use (scatter).




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



lionfish2<- #create object of resulting data table
  lionfish |> #use data lionfish and then
  select(Location,SampleYear,Biomass,Depth)|>#select variables of interest
  group_by(Location)|> #group by location
  summarize(mean_biomass=mean(Biomass),mean_depth=mean(Depth))#create 2 new columns mean_biomass
#and mean_depth across all years by taking mean of biomass and mean depth
  
#Run pearson's correlation test between mean depth & mean biomass

  lionfish_cor<- cor.test(lionfish2$mean_depth,lionfish2$mean_biomass, method="pearson")

#create a visual
ggplot(data=lionfish2,aes(x=mean_depth,y=mean_biomass,color=Location))+#use data lionfish2
  #create a scatterplot with mean_depth on x and mean_biomass on y
  geom_point(size = 4, alpha = 0.4)+ #change size and transparency of points
  theme_bw()+#change theme
  labs(x="Average Depth(m)",y="Average Lionfish Biomass",color="Monitoring Site",#create labels on x&y and legend
       title="Lionfish Depth and Biomass across TCRMP Sites")+ 
  annotate("text", x=50,y=150,label="p<0.001")+#add text to plot, pvalue and r values 
  annotate("text",x=50,y=125,label="r=0.81")

       
#Discussion
#There is a significant(p<0.05),strong & positive(r=.809) relationship between lionfish biomass and depth across
#all years and TCRMP sites. Specifically, you are more likely to see a higher biomass of lionfish
#the deeper you get. The wide confidence minimum (63.9)and maximum (90.5)suggests less precision and certainty
#in the data and small (or uneven in this case)sample sizes which may be due to differing number of transects at each
#location, possibly influencing the number of observations. It is also important to note that biomass does not equal 
#quantity. For example, at Coal Shoal East in 2012, 3 lionfish had a total biomass of 115.6 and in 2011 at Bank Red Hind FSA,	
# 3 fish had a total biomass of 52.9, both recorded at similar depths, influencing the mean biomass across these years.





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



#data wrangling
lionfish3<- #create object "lionfish3" from resulting data table
  lionfish|> #use data "lionfish" and then
select(TotalCount,ntrans,Island)|> #select relevant columns
  filter(TotalCount>1)|> #select row Total Count and only print values higher than 1
  mutate(Lionfish_Density=(TotalCount/ntrans/100))|> #Create a new column
  #Lionfish_Density by dividing TotalCount/ntrans by 100 to get m^2
  group_by(Island)#group by variable of interest

#preliminary visualization
ggplot(data=lionfish3,aes(x=Island,y=Lionfish_Density))+
  geom_boxplot()
#There is some overlap in the data between islands. 
#There is more variance in STT,resulting in a skewed and non-normal distribution.

#The assumptions of a normal distribution and equal variance are violated

#Fix those violations by taking log of lionfish density to result in a more normal distribution
lionfish3<- lionfish|> #replacing object lionfish3
  select(TotalCount,ntrans,Island)|> 
  group_by(Island)|> 
  filter(TotalCount>1)|>
  mutate(Lionfish_Density_log=log10(TotalCount/ntrans))

#conduct t test and create object of results
#Use Welch's t-test for unequal variance
Lionfish_T<- t.test(Lionfish_Density_log~Island,data=lionfish3)

#create visual
ggplot(data=lionfish3,aes(x=Island,y=Lionfish_Density_log,fill=Island))+
  geom_boxplot()+
  labs(x="Island",y="Lionfish Density",#create labels on x&y & title
       title="Lionfish Density on St.Thomas(STT) and St.Croix(STX)",
       subtitle=paste("t=",round(Lionfish_T$statistic,2),"p=",
                      format.pval(Lionfish_T$p.value,digits=3,eps=0.001)))
#create subtitle of pvalue and test statistic, rounding to 3 and 2 digits respectfully.

#explanation
#A two sample t-test was performed to compare lionfish density in St.Thomas and St.Croix.
#There was a significant (p<0.05) difference in lionfish density between St.Thomas (M=-0.138)and
#St.Croix (M=-0.459);t=5.987,(df)=111,p=<0.001. A fairly tight confidence interval(0.215,0.427)
#suggests certainty in the data.There were unequal variances and sample sizes between
#groups. The number of transects varies between islands, possibly contributing to the variance in the data.

#T test reporting format from statology.com



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

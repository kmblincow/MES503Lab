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
rm(list=ls(1))

library(ggplot2)
library(dplyr)
lionfish <- read.csv("Wk 5/TCRMP_Lionfish.csv")

# Explore your newly imported dataset
head(lionfish)#first 6 rows
str(lionfish)# summary of dataset
View(lionfish) #displays dataset table
unique(lionfish$Location)# displays specific values of column
                         # Location (in this case, names of sites)
unique(lionfish$Island)# displays specific islands surveyed


# Is there anything about the structure of the dataset that you think is
# important to understand before beginning the analyses?

# It is important to know what type of dataset it is (ex. data frame, list, etc), 
# number of variables as well as sample size (number of observations)
# and the type of data the variables are (ex. characters-categorical, numbers-continuous).
# Knowing the type of data the variables are, you are able to know what type of tests or plots
# you would need to determine correlation and significance. It
# is also important to know the names of the variables so that using your functions,
# you are writing the names exactly how its written in the dataset.



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

# Depth and Total Biomass
lionfish_cor1 <- lionfish |>
  select(Depth, Biomass, Location, SampleYear)|> #isolates specific columns
  group_by(Location, Depth)|> #groups data by specific variables
  summarize(total_biomass= sum(Biomass), .groups= "drop")
# summarize is taking a function like sum, mean, etc and making a new column,
# with those values. It allows you to use multiple functions for in one line of code.
  correlation_biomass<-cor.test(lionfish_cor1$Depth, #pearson correlation test
                                lionfish_cor1$total_biomass,
                                 method= "pearson")
  p_biomass<- correlation_biomass$p.value #assign name for p-value
  r_biomass<- correlation_biomass$estimate #assign name for correlation value
  print(correlation_biomass)# print cor test
  
  ggplot(data= lionfish_cor1, aes(x= Depth, y= total_biomass, color= Location))+
    geom_point(size= 2, alpha=.7)+ 
    geom_smooth(method = "lm", color= "black")+ #adds line
    labs(x= "Depth (m)", y= "Total Biomass",
         title = "The Relationship between Depth and the Total Biomass of Lionfish 
         in the US Virgin islands")+
    annotate("text", x = 50, y = 3500, label= "r= 0.71, p= < 0.01",#add extra text on graph
           color= "black")+
    theme_classic()+
    theme(plot.title= element_text(hjust= 0.5, face= "bold"),
          legend.position = "bottom",
          axis.title = element_text(size= 10))
   

# Statistically there is a strong positive relationship between total biomass 
# and depth. This means that there is a strong correlation between 
# the two variables.We would reject the null hypothesis that states that there is no
# relationship. While there may be other confounding factors that are influencing
# this relationship, the correlation test and visual is showing that as one variable
# increase, the other variable increases as well.The p-value being less than 0.05, 
# tells us that the probability of our results happening randomly is less than 5%.
# Ecologically this means that the size of lionfish are related to what depth they 
# are found. Larger fish are found in deeper waters while smaller fish tend to stay in
# shallower waters.In reality, this would make sense. Smaller fish in general
# tend to be juveniles and stay in shallower waters/ habitats like seagrass and mangrove
# habitats for protection from predation. While bigger fish tend to shift to deeper
# water due to more food availability.So in ecological terms, this relationship matches 
# what we see in other populations. 
 

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
  lionfish_count <- lionfish|>
    filter(TotalCount > 1)|> # filtering dataset to only show Total count rows
                            #  that are greater than 1
    select(TotalCount, ntrans, Island, SampleYear)|> #isolating columns Total count,
                                         # number of transects, island and sample yr
    group_by(Island) |> # group by island, STT or STX
    mutate(density= TotalCount / ntrans) # create a new column using that equation
                                        # and name it density

      
  ggplot(lionfish_count, aes(x= Island, y= density, fill= Island))+
    geom_boxplot()+
    scale_y_log10()# even out spread of data
  # this plot shows variance of data
  ggplot(lionfish_count, aes(x = density, fill = Island)) +
    geom_histogram(bins = 10) +
    facet_wrap(~ Island) +
    labs( x = "Island",
          y = "Density")
  #this plot is to test normality 
  
# 3. Based on the visuals above the data is not normally distributed and has
# unequal variance. The boxplot was used to test the variability of the data and  
# there was more variability in St. Thomas than St. Croix. The histogram was used
# to test for normalcy. The historgam was skewed, so it is not a 
# normal distribution.Meaning the assumptions were not met. In order to fix this 
# problem you use the log function so that it approaches a normal distribution by 
# increasing the spread of the data. 
  
 log_density <- lionfish_count |>
   mutate(logdensity= log(density))
 
 ggplot(log_density, aes(x = logdensity, fill = Island)) +
   geom_histogram(bins = 10) +
   facet_wrap(~ Island) +
   labs( x = "Island",
         y = "Density (Log)")
 #log of density to even out spread of data
 t_stat <- t.test(logdensity ~ Island, data= log_density)# assume equal variance 
                                                      # because of log function
 t_stat
 
 ggplot(data= log_density, aes(x= Island, y= logdensity, fill= Island))+
   geom_boxplot()+ 
   labs(x= "Island", y= "Log Density (g/100m^2)", fill= "Island",
        title = "The Density of lionfish between St. Thomas and St. Croix, USVI")+
     theme_classic()+
   theme(plot.title= element_text(hjust= 0.5, face= "bold"),
         legend.position = "right",
         axis.title = element_text(size= 10))
 
#6. There is a significant difference in the density of lionfish between St.
 # Thomas and St. Croix. St. Thomas had a higher density than St. Croix, as shown
 # in the figure. It was taken into account that the initial dataset was skewed so a log function 
 # was used to make the dataset fit a normal distribution better. Then a welches t test was performed
 # and further proved that there was a statistically significant difference in denisties between 
 # the two districts(t(29)=5.51, p< 0.001). Based on our results, we reject the null hypothesis.
 # These results shows that St. Thomas had a significantly higher number of fish present than St. Croix. 
 # This would imply that St. Thomas has a higher number of lionfish present or a higher number of
 # lionfish aggreagating in one area. This difference could be attributed to the higher number of sample
 # sites St. thomas had compared to St. Croix.
 # However, it would be interesting to see if this difference is related to the habitat, through
 # further research. St. Thomas and St. Croix have different topographies. On the northern side of St. Croix, it has extensive reef legdes,
 # that may allow them to spread out more. While St. Thomas has more macroalgal and hard bottom
 # habitats. So they may cluster more in the fewer reef habitats that its has .
 # The presence of lionfish can also be altered by depth. St. Croix has far deeper drop offs 
 # especially on the northern side of the island. They could be in deeper water that divers would be limited to collect data.
 # Increasing the number of sites sampled in St. Croix could help strengthen our understanding 
 # of this relationship as well as including other confounding factors in the study design like habitat.
 # Lionfish derbies and lionfish culling events are also more popular in St. Croix, which may be something
 # that affects the population but this cannot be drawn from the data and is just an suggestion.
 
 
# citation for log scale function: https://r-statistics.co/ggplot2-Log-Scale.html

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

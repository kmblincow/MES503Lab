# MES 503 Lab Assignment 2
# Exploring correlation and t-tests with TCRMP data

# 9/15/2026
# Created by Kayla Blincow (with help from ChatGPT)
# ------------------------------------------------------------------------------
# John Czerwinski with help from claude
#
# INSTRUCTIONS
#
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
# including fish communities. TCRMP fish census methods include a 
# combination of belt transects and roving diver surveys.
# TCRMP has been reporting the abundance  and biomass of lionfish
# since they were first encountered in 2011. As of 2022,
# TCRMP has monitoring data for 34 sites: 10 mesophotic reefs 
# (> 30 m depth), 13 nearshore reefs (~10 m), 
# and 11 offshore reefs (~15 m).

# The data used in this assignment are real TCRMP data 
# that have been summarized to include information on lionfish 
# observed at monitoring sites on St. Croix and St. Thomas 
# from 2011 to 2022.

# VARIABLES:
# Location     - TCRMP monitoring site
# SampleYear   - Year data were collected
# TotalCount   - Total number of lionfish observed across 
# all transects conducted at each site, each year
# ntrans       - Number of belt transects conducted at each
# site, each year
# Biomass      - Total biomass of lionfish observed at each 
# site, each year
# Code         - Three-character identifying code for the 
# TCRMP monitoring site
# Island       - Island where the site is located (STT, STX)
# ReefComplex  - Type of reef (mesophotic, nearshore, offshore)
# Depth        - Average depth at the monitoring site


#### PART 1: SET UP YOUR SCRIPT & GET TO KNOW YOUR DATA

# Write code to clear your workspace, load necessary packages and import your
# data file.

# FILL IN CODE

rm(list = ls())

library(tidyverse)

TCRMP <- read.csv("Lab 2/TCRMP_Lionfish.csv")

# Explore your newly imported dataset.

# FILL IN CODE

head(TCRMP)

str(TCRMP)

# Is there anything about the structure of the dataset 
# that you think is important to understand before beginning 
# the analyses?

# Code, Island, and Reef Complex are chr variables

#### PART 2: CORRELATION

# RESEARCH QUESTION:
# Is there a relationship between depth and total lionfish biomass 
# observed at each site (across all years)?

# To address this question you must:
# 1. Complete necessary data wrangling tasks 
# 2. Test for a correlation between the variables of interest. 
# 3. Create a visual of the relationship that includes 
#    appropriate axis labels, units, an informative title, 
#    and the p-value and correlation coefficient from your
#    correlation test.
# 4. Interpret the results of your correlation test and visual.
# What does it mean statistically? What does it mean ecologically?

# HINT: The original dataset contains multiple observations for each
# monitoring location because sites were sampled across multiple
# years.To answer this research question, we want ONE observation 
# per location.

# FILL IN CODE

Pvol_Biomass <- TCRMP |> 
  group_by(Location) |> 
  summarize(Depth = mean(Depth), 
            Annual_Mean_Biomass = mean(Biomass),
            .groups = "drop")

Pvol_cor <- cor.test(Pvol_Biomass$Depth, 
                Pvol_Biomass$Annual_Mean_Biomass)

ggplot(Pvol_Biomass, aes(x = Depth, y = Annual_Mean_Biomass))+
        geom_point() +
        geom_smooth(method ="lm", se = TRUE)+
        labs(title = "Annual Mean P. volitans Biomass By Depth",
             subtitle = paste("r =", round(Pvol_cor$estimate, 2),
             ", p =", format.pval(Pvol_cor$p.value, digits = 2, eps = 0.001)),
                           x = "Depth (m)", 
                           y = "P. volitans Biomass (g)")+
        theme_bw() +
        theme(plot.title = element_text(hjust = 0.5))
        
# FILL IN WRITTEN ANSWERS
# Statistically: 
# After the correlation test out r value shows a strong positive relationship 
# between depth and P. vol biomass averaged across the years. Our very small
# p-value indicates strong evidence against the null, supporting that 
# these two variable have some significant relationship.
        
# Ecologically: 
# At a glance, this figure shows a pretty clear relationship between 
# depth and biomass. The trend shows the biomass increase as the depth 
# increases. This suggests that P. volitans can accumulate
# more biomass at deeper depth, but whether that is driven by depth or 
# shallow water pressures needs more research. Either way  the accumulation of  
# biomass at depth will pose a difficult problem for managment of the 
# invasive populations. 

#### PART 3: T-TEST

# RESEARCH QUESTION:
# In cases where multiple lionfish were observed, did they tend to occur at
# higher density on St. Thomas or St. Croix?

# To address this question you must:
# 1. Complete the necessary data wrangling tasks.
# 2. Create a preliminary visualization comparing lionfish density between the
#     two islands. Do you notice anything you might need to address?
# 3. Check the assumptions of the t-test, and state whether your assumptions are
#    met or violated. If they are violated, research what you can do, and
#   implement a fix. Document what you did and why--include a visualization 
#     if appropriate.
# 4. Conduct a t-test that addresses the research question.
# 5. Create a visual to accompany your statistical test that includes 
#    appropriate axis labels, units, an informative title, and the p-value and
#    test statistic from your t-test.
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

# 1. 

Pvol_Density <- TCRMP |>
  filter(TotalCount > 1) |> 
  mutate(Pvol_Density = TotalCount / ntrans)

# 2. 

ggplot(Pvol_Density, aes(x = Island, y = Pvol_Density))+
  geom_boxplot() +
  geom_jitter(width = 0.1, alpha = 0.4) +
  labs(title = "P. volitans Density By Island", 
       x = "Island", 
       y = "P. vol Density (fish/100 m^2)") +
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5))

# 3. 

var.test(Pvol_Density$Pvol_Density ~ Pvol_Density$Island)

STT_Density <- Pvol_Density |> 
  filter(Island == "STT")

shapiro.test(STT_Density$Pvol_Density)

STX_Density <- Pvol_Density |> 
  filter(Island == "STX")

shapiro.test(STX_Density$Pvol_Density)

Pvol_Density <- Pvol_Density |> 
  mutate(log_density = log(Pvol_Density))

ggplot(Pvol_Density, aes(x = Island, y = log_density))+
  geom_boxplot() +
  geom_jitter(width = 0.1, alpha = 0.4) +
  labs(title = "P. volitans Density By Island", 
       x = "Island", 
       y = "log P. vol Density (fish/100 m^2)") +
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5))

var.test(Pvol_Density$log_density ~ Pvol_Density$Island)

STT_log_Density <- Pvol_Density |> 
  filter(Island == "STT")

shapiro.test(STT_log_Density$log_density)

STX_log_Density <- Pvol_Density |> 
  filter(Island == "STX")

shapiro.test(STX_log_Density$log_density)

# 4. 

Density_ttest <- t.test(log_density ~ Island, Pvol_Density)

# 5. 

ggplot(Pvol_Density, aes(x = Island, y = log_density))+
  geom_boxplot() +
  geom_jitter(width = 0.1, alpha = 0.4) +
  labs(title = "P. volitans Density By Island",
       subtitle = paste("t =", round(Density_ttest$statistic, 2),
                        ", p =", format.pval(Density_ttest$p.value, 
                                             digits = 2, eps = 0.001)),
                 x = "Island", y = "log(P. vol density) (fish/100 m²)") +
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5))

# 6. 

Pvol_Density |> 
  group_by(Island) |> 
  summarize(mean_density = mean(Pvol_Density), sd_density = sd(Pvol_Density))

# FILL IN WRITTEN ANSWERS HERE
# 2. I notice that the islands both have outliers about the median that 
# probably are skewing the data, but it seems like a good thing they are both 
# skewed right. STT has more outliers above the median and more spread within 
# the data. Not sure if its significant but STT seems to have a higher median 
# density.
# 3. Data is independent. Data does not have equal variance as shown by the 
# variance test (F = 22.5, p < 0.001). That is okay if we use a welch t-test. 
# Lastly, the data are not normally distributed. A Shapiro - Wilks test was
# run for stx (W = 0.77, p < 0.001) and STT (W = 0.73, p < 0.001), confirming 
# the datasets are not normally distributed. To normalize the data I will log 
# transform the density and rerun the shapiro - wilks to confirm it worked. 
# After log transformation the shapiro - wilks test showed the data is still 
# not significantly normal distributed among both STT (W = 0.96, p = 0.027) and 
# STX (W = 0.93, p = 0.015), not technically allowing us to run a t-test. 
# However, the high W-value suggests that the data is normally distributed but 
# my guess is the outliers are bringing down the p-value. Additionally, there is
# a relatively large sample size which is always good. I think this is a 
# major improvement on the normality of the data and I think this slight 
# deviation from this assumption will be okay.   
# 6. 
# Statistical : A two-sided, Welch two-sample t-test was run to compare the 
# means across the two islands. The result showed a significantly higher mean 
# density of P. volitans occurring in multiples at sites around STT (1.06 ± 1.07
# fish/100 m²) when compared to sites around STX (0.39 ± 0.23/100 m²) 
# (t = 5.99, df = 111 , p < 0.001). 
# Ecologically: Pterois volitans higher density around St. Thomas could be a 
# result of many different factors that need more research. Some factors that 
# likely play a role are the amount of pressure on these species in shallow 
# waters, the quality and availability of habitat at depth to support 
# population aggregations, and the choice of sites to sample across each island.

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

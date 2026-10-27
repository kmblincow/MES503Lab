# MES 503: Linear Regression in R
# Giant Sea Bass Bulk Stable Isotopes (data from Blincow et al. (2022))
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# BIOLOGICAL CONTEXT
# ------------------------------------------------------------------------------

# Giant Sea Bass are a recovering critically endangered species found in Southern
# California, USA and Baja California, Mexico. They are generalist predators that
# are chiefly associated with kelp forest habitats. The increasing numbers of these
# high-level predators has implications for kelp forest systems.

# One way to learn about what things are eating is by using stable isotopes. When
# organisms eat things, they carry elemental signatures of their prey in their tissues.
# Carbon13 differs based on the type of primary producer that is generating it
# and is relatively conserved as you much up the food chain. Nitrogen15 increases
# as you move up the food chain, because organisms preferentially use N14 first.
# Predators end up loading the heavier N15 isotope because there's less and less
# N14 available to them.


# ------------------------------------------------------------------------------
# OUR RESEARCH QUESTIONS
# ------------------------------------------------------------------------------

# 1. Is there a relationship between the total length of fish and N15 values in
# their tissues? 

# 2. Is there a relationship between the total length of fish and the C13 values 
# in their tissues?


# ------------------------------------------------------------------------------
# DATA
# ------------------------------------------------------------------------------

# This is real data that I collected during my PhD.
# Each row of this dataset represents a tissue sample taken from a GSB. In many 
# cases multiple tissue samples were taken from each fish, so there individual
# fish might have multiple rows of data associated with them that vary based on 
# tissue type.


# The data includes:
# ArtID - unique identifier for each fish
# N15 - the delta N15 value measured in a tissue sample
# C13 - the delth C13 value measured in a tissue sample
# TotalLength - the total length (cm) of the fish
# HeadLength - the head length (cm) of the fish 
# StandardLength - the standard length (cm) of the fish
# CatchSite - the location where the fish was caught
# Latitude - approximate latitude of the location where the fish was caught
# Longitude - approximate longitude of the location where the fish was caught
# TissueType - the type of tissue used to generate the bulk isotope values (fin clip or gill tissue)
# Year - the year the fish was caught
# Season - the season the fish was caught
# Month - the month the fish was caught
# Notes - notes regarding the sample


# ------------------------------------------------------------------------------
# STEP 1: SET UP OUR WORKSPACE
# ------------------------------------------------------------------------------

#clear our workspace
rm(list = ls())

#load our packages
library(tidyverse) # recall this loads all the tidyverse packages at once

#load our data (make sure to update the file path based on your file set up)
gsb <- read.csv("Week 6/GSBisotopes.csv")



# ------------------------------------------------------------------------------
# STEP 2: BASIC DATA EXPLORATION
# ------------------------------------------------------------------------------

# Before fitting a statistical model, we should understand our data.

# Look at the first six rows.
#INSERT CODE HERE

# Look at the structure of your data
#INSERT CODE HERE

# What is the mean total length of the fish sampled? Minimum TL? Maximum TL?
# REMEMBER: Individual fish might have duplicate rows.
#INSERT CODE HERE

# Do we have a wide range of sizes represented?


# ------------------------------------------------------------------------------
# STEP 2: BASIC DATA WRANGLING
# ------------------------------------------------------------------------------

# We do not want to have individual fish represented more than once, this would 
# lead to non-independence in our samples.

# To avoid these issues of non-independence, let's only retain data for the the
# tissue type that was most commonly sampled.

# To do this: 
# 1. Identify which tissue type is most commonly sampled.
# 2. Create new data object that is only includes data associated with that tissue
# type.

#INSERT CODE HERE


# ------------------------------------------------------------------------------
# STEP 3: Visualize Q1: Is there a relationship between total length and N15?
# ------------------------------------------------------------------------------

# Create a visual that will allow you the set up your expectation for whether 
# total length influences the delta N15 of GSB tissues?

#INSERT CODE HERE

# Do you think a relationship exists?

#INSERT ANSWER HERE


# ------------------------------------------------------------------------------
# STEP 4: LINEAR REGRESSION
# ------------------------------------------------------------------------------

# Create our model object using lm(response ~ explanatory, data = dataobject).

m1 <- lm(N15 ~ TotalLength, data = gsb) #INSERT CODE HERE

  
  
#ASSUMPTION TESTING
# The main assumptions we will consider are:
#
# 1. Linearity
# 2. Approximately normally distributed residuals
# 3. Constant variance of residuals
# 4. No observations that exert extreme influence on the model

# Check our assumptions by plotting the model object
plot(m1)
# Make sure to hit ENTER/RETURN in the console to view all the plots


#THE FIRST DIAGNOSTIC PLOT
# The first diagnostic plot shows residuals versus fitted values.
plot(m1, which = 1)

# We would like to see:
# - residuals scattered around zero;
# - no obvious curved pattern;
# - approximately similar spread across the range of fitted values.

# A curved pattern can suggest that the relationship is not adequately
# described by a straight line.

# A funnel-shaped pattern can suggest that the variance changes across the
# range of fitted values.


#THE SECOND DIAGNOSTIC PLOT
# The Q-Q plot provides a visual assessment of residual normality.
plot(model, which = 2)

# If the residuals are approximately normally distributed, the points should
# fall reasonably close to the reference line.

# Perfect agreement is not expected, especially with real ecological data.


#THE THIRD DIAGNOSTIC PLOT
# The third diagnostic plot is Scale-Location which is also used to assess 
# constant variance. 
plot(model, which = 3)

# You want to see a fairly even vertical spread of points across the x-axis, with
# the red trend line approximately horizontal.


#THE FOURTH DIAGNOSTIC PLOT
# Cook's distance can help identify observations that have a strong influence
# on the fitted model.
plot(model, which = 4)

# An observation with a large Cook's distance deserves investigation.

# IMPORTANT:
# An influential observation is not automatically a "bad" observation.
# Ecological systems can contain legitimate extreme observations.

# We should investigate why an observation is unusual before deciding what to
# do with it.



#NOTE! You might sometimes see folks testing assumptions using statistical tests.
# For example, the Shapiro-Wilk test will test for the normality of your residuals.
# I have included code below to do this, but you should still always look at the 
# visuals during assumption testing as statistical assumption testing is often
# overly conservative and kind of weird in terms of the theory of statistics.

# The null hypothesis of the Shapiro-Wilk test is:
# H0: The residuals are normally distributed.
# A small p-value provides evidence against normality.

shapiro.test(residuals(m1))

# INTERPRETATION:
# If p > 0.05:
# There is not strong statistical evidence that the residuals differ from a
# normal distribution.

# If p < 0.05:
# There is statistical evidence that the residuals differ from a normal
# distribution.

# IMPORTANT:
# A non-significant Shapiro-Wilk test does NOT prove that the residuals are
# perfectly normal. Likewise, a significant result does not automatically
# mean that the regression is unusable.
#
# Always examine the Q-Q plot as well.



#EVALUATING YOUR MODEL
# Look at the summary of our model object
summary(m1)

# Using the summary output, answer these questions:
# 1. What is the estimated slope of the relationship?
# 2. Is the slope significantly different than 0?
# 3. Is the overall linear regression model significant? How do you know? What
# is the test statistic?

#INSERT ANSWER HERE


# Write the results of this model based on the reporting formula:
# There was a significant relationship between [independent variable] and 
# [dependent variable] (R2 = [R2 value], F(df regression, df residual) = 
# [F-value], p = [p-value]).
# [independent variable] significantly predicted [dependent variable] 
# (β = [β-value], p = [p-value]).

#INSERT ANSWER HERE



# ------------------------------------------------------------------------------
# STEP 5: ADD THE REGRESSION LINE TO THE FIGURE
# ------------------------------------------------------------------------------

# We can add the fitted regression line to our scatterplot using geom_smooth().
# method = "lm" tells ggplot2 to fit a linear model.

ggplot( #INSERT CODE HERE
  ) +
  geom_point() +
  geom_smooth(method = "lm") 

# The shaded region represents uncertainty around the estimated regression
# line.


# ------------------------------------------------------------------------------
# STEP 6: INTERPRET THE RESULTS
# ------------------------------------------------------------------------------

# Given that N15 typically increases with increasing trophic level, what does
# your analysis tell you about Giant Sea Bass?




# ==============================================================================
# YOUR TURN: USE LINEAR REGRESSION TO ADDRESS THE SECOND RESEARCH QUESTION
# ==============================================================================

# QUESTION: Is there a relationship between the total length and C13?
# (use only the most common tissue type again)

# 1. Create a visual to set up your expectation.
# 2. Create the model object.
# 3. Check your model assumptions.
# 4. Evaluate your model based on the summary output.
# 5. Add your regression line to your visual.
# 6. Intepret the results in the context of the system. (Recall, C13 is conserved
# across trophic levels. Low C13 values are typically associated with phyotplankton-
# based primary production, high C13 values are typically associated with kelp-based
# primary production).


#INSERT CODE HERE
#INSERT ANSWERS HERE




# ==============================================================================
# YOUR TURN — EXTRA CHALLENGE
# ==============================================================================

# Recreate the figure shown on the slides (use only the most common tissue type).
gsb2 <- filter(gsb, TissueType == "Fin") |> drop_na(TotalLength)

gsb2$Stage <- "Transition"

gsb2[gsb2$TotalLength < 56,]$Stage <- "Immature"
gsb2[gsb2$TotalLength > 90 ,]$Stage <- "Mature"


gsb2$Stage <- factor(gsb2$Stage,
                     levels = c("Mature",
                                "Transition",
                                "Immature"),
                     labels = c("Mature (TL > 90 cm)",
                                "Transition (56 cm < TL < 90 cm)",
                                "Immature (TL < 56 cm)"))
ggplot(gsb2, aes(x = C13, y = N15, color = Stage,
                 shape = Stage)) +
  geom_point(size = 2.5) + 
  scale_color_viridis_d() +
  labs(x = expression(delta~" "^15~N), 
       y = expression(delta~" "^13~C)) +
  theme_classic() +
  theme(legend.position = "top")


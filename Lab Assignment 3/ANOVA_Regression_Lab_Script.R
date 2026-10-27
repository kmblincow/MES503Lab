############################################################
# LAB: ANOVA AND LINEAR REGRESSION
#
# Research scenario:
# You are investigating variation in a biological response
# among sampling locations. You collected observations from
# three sites and two habitat types at each site.
#
# Your initial question is:
#   Does the response differ among sites or habitats?
#
# After investigating the ANOVA results, you will examine
# whether an environmental variable may help explain the
# pattern you observed.
############################################################

# ==========================================================
# PART 1: SET UP YOUR WORKSPACE
# ==========================================================

# Load the packages you need.
# You will probably need:
# tidyverse
# car

library(tidyverse)
library(car)

# Import the three CSV files.
# You will need to determine the appropriate function/code.

# observations <- 
# environment <- 
# site_info <- 


# ==========================================================
# PART 2: GET TO KNOW THE DATA
# ==========================================================

# Before doing any statistical tests, inspect your datasets.

# 1. What are the observations in each dataset?
# 2. What does each row represent?
# 3. What variables are categorical?
# 4. What variables are continuous?
# 5. How many observations are there from each site?
# 6. How many observations are there from each habitat?

# Use appropriate functions to investigate the structure
# and dimensions of the datasets.


# ==========================================================
# PART 3: DATA WRANGLING
# ==========================================================

# Your datasets contain information that belongs together,
# but it is currently stored in separate tables.
#
# Use a dplyr join to combine the observations with the
# environmental measurements using sample_id.
#
# Then join the site metadata using site.
#
# Do not simply recreate the final dataset manually.

# Your final dataset should contain at least:
# sample_id
# site
# habitat
# response
# temperature_C
# depth_m
# location_type
# management_zone


# ==========================================================
# PART 4: FILTERING AND SUMMARIZING
# ==========================================================

# Imagine that your research question focuses on samples
# collected at depths shallower than 10 m.
#
# Use filter() to create a dataset containing only those
# observations.

# filtered_data <-


# Now use group_by() and summarize() to calculate the
# sample size, mean response, and mean temperature for
# each site.

# site_summary <-


# Questions:
#
# 1. Which site has the highest mean response?
# 2. Which site has the highest mean temperature?
# 3. Do the patterns in response and temperature look similar?
#
# Create an appropriate visualization of the response among
# sites and habitats before conducting your ANOVA.


# ==========================================================
# PART 5: TWO-WAY ANOVA
# ==========================================================

# Research question:
#
# Does the biological response differ among sites and/or
# habitats, and is there an interaction between site and
# habitat?
#
# Conduct a two-way ANOVA with:
#
#   response = response variable
#   site     = categorical predictor
#   habitat  = categorical predictor
#
# You will need to decide how to write the model.

# anova_model <-


# Examine the ANOVA results.

# Questions:
#
# 1. Is there evidence that response differs among sites?
# 2. Is there evidence that response differs between habitats?
# 3. Is there evidence of a site × habitat interaction?
#
# For each term, report the appropriate test statistic,
# degrees of freedom, and p-value.


# ==========================================================
# PART 6: CHECK ANOVA ASSUMPTIONS
# ==========================================================

# Before interpreting your ANOVA, evaluate its assumptions.
#
# Consider:
#   - independence
#   - normality of residuals
#   - homogeneity of variance
#
# Use appropriate diagnostic plots and/or statistical tests.

# Questions:
#
# 1. Do the residuals appear approximately normally distributed?
# 2. Is there evidence of unequal variance among groups?
# 3. Based on your diagnostics, do you think the ANOVA is
#    appropriate for these data?


# ==========================================================
# PART 7: INTERPRETING THE SITE EFFECT
# ==========================================================

# Your ANOVA suggests that response differs among sites.
#
# But remember:
#
#   A significant site effect does NOT tell us why sites differ.
#
# Look back at your site summary and visualization.
#
# What other variable appears to change systematically among
# the three sites?
#
# Formulate a new hypothesis:
#
# "Variation in ______ may explain variation in response."


# ==========================================================
# PART 8: LINEAR REGRESSION
# ==========================================================

# Test your new hypothesis using linear regression.
#
# Your response variable should remain the biological response.
# Choose the continuous environmental variable that you think
# could explain the response.

# regression_model <-


# Examine the model summary.

# Questions:
#
# 1. What is the direction of the relationship?
# 2. What does the slope mean in the context of the study?
# 3. Is the relationship statistically significant?
# 4. How much variation in the response is explained by
#    the predictor?
#
# Create a scatterplot with:
#   - the raw observations
#   - the fitted regression line
#   - informative axis labels
#   - an informative title


# ==========================================================
# PART 9: CHECK REGRESSION ASSUMPTIONS
# ==========================================================

# Evaluate the assumptions of your linear regression.
#
# Consider:
#   - linearity
#   - normality of residuals
#   - constant variance
#   - influential observations
#
# Use diagnostic plots and/or appropriate tests.


# ==========================================================
# PART 10: CONNECTING THE TWO ANALYSES
# ==========================================================

# Think carefully about what happened in the two analyses.
#
# Your ANOVA found that:
#
#   response differed among ______.
#
# Your second categorical variable:
#
#   did / did not significantly affect response.
#
# The interaction:
#
#   was / was not significant.
#
# Your regression found that:
#
#   response was ______ related to ______.
#
# Questions:
#
# 1. Why can a categorical variable such as site be significant
#    in an ANOVA even when it is not necessarily the mechanism
#    causing the response to differ?
#
# 2. How does the regression help explain the site pattern?
#
# 3. Based on these data, would it be reasonable to conclude
#    that "site causes changes in response"? Why or why not?
#
# 4. What additional analysis or experiment could help distinguish
#    a true site effect from an environmental variable associated
#    with site?


# ==========================================================
# PART 11: FINAL RESULTS
# ==========================================================

# Write a short results paragraph that:
#
# 1. Describes the pattern in the raw data.
# 2. Reports the two-way ANOVA results.
# 3. Reports the regression results.
# 4. Explains how the regression changes your interpretation
#    of the site effect.
#
# Do not simply say "p < 0.05, therefore significant."
# Interpret the results in ecological terms.

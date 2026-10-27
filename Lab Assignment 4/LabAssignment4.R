# MES 503 Lab Assignment 4
# 10/20/2026
# Created by Kayla Blincow (with help from ChatGPT)
# ------------------------------------------------------------------------------


# INSTRUCTIONS

# Complete this script as you work through the assignment.
#
# - Replace every "# FILL IN" section with your own code or written response.
# - Comment your code so that someone else can follow your workflow.
# - Do not delete the research questions or prompts.
# - Your script should run from beginning to end without errors.
# - Save this script as: LastName_FirstName_MES503_LabAssignment4.R
# - Submit your completed script to Brightspace by the deadline.


################################################################################

# SCENARIO:
# For this lab assignment you will be using the 'storms' dataset.
# This dataset is the NOAA Atlantic hurricane database best track data, 
# https://www.nhc.noaa.gov/data/#hurdat. The data includes the positions and
# attributes of storms from 1975-2022. Storms from 1979 onward are measured 
# every six hours during the lifetime of the storm. Storms in earlier years 
# have some missing data.

# Learn more about the data here:
?storms

## Research Questions:

# 1. Has the number of named storms each year increased through time? 
# - Create a visual depicting the relationship and run a statistical test.
# - Report the results as you would in a peer-reviewed journal article.

# 2. How has the length of the storm season changed through time?
# - The length of storm season is measured as the time between the first record 
#   and last record of any storm each year. 
# - Create a visual depicting the relationship and run a statistical test.
# - Report the results as you would in a peer-reviewed journal article.

# 3. How has the lifetime of storms changed through time?
# - Lifetime is measured as the time between the first and last record of a 
#   storm in the dataset.
# - Create a visual depicting the relationship and run a statistical test.
# - Report the results as you would in a peer-reviewed journal article.

# 4. For storms that reached hurricane status, can we predict the diameter of 
# hurricane-force winds at the first observation of each storm's maximum recorded 
# wind speed using wind speed, pressure, and latitude?
# - Create a visual depicting the relationship and run a statistical test.
# - Report the results as you would in a peer-reviewed journal article.

# HINTS/THINGS TO NOTE!
# - Name is a not a unique identifier, as storm names get reused across years.
# - Not all storms make it to hurricane level! If a question is specifically 
# asking about hurricanes, make sure to only include data associated with hurricanes.
# - Make sure to evaluate the assumptions for any statistical test you do.
# - You might want to spend some extra time getting to know the dataset before
# jumping in. Do you know what each row represents? Why are there multiple rows
# for a single storm? Where are there missing values? How might that influence
# your interpretation?


################################################################################

# clear your workspace
#FILL IN CODE HERE

# load the necessary packages
#FILL IN CODE HERE

# load the data
storms <- dplyr::storms



# The rest is up to you!


################################################################################
# FINAL CHECKLIST
# Before submitting your assignment, make sure you have completed each item.


# RESEARCH QUESTION 1: NUMBER OF NAMED STORMS
# [ ] Created a dataset with the number of unique named storms per year.
# [ ] Created a visualization showing the relationship between year and number of storms.
# [ ] Ran an appropriate statistical test to evaluate the relationship.
# [ ] Evaluated the assumptions of the statistical test.
# [ ] Reported and interpreted the results in peer-reviewed journal article style.

# RESEARCH QUESTION 2: LENGTH OF THE STORM SEASON
# [ ] Identified the first and last storm records for each year.
# [ ] Calculated the length of each year's storm season.
# [ ] Created a visualization showing how storm season length changes through time.
# [ ] Ran an appropriate statistical test to evaluate the relationship.
# [ ] Evaluated the assumptions of the statistical test.
# [ ] Reported and interpreted the results in peer-reviewed journal article style.

# RESEARCH QUESTION 3: STORM LIFETIME
# [ ] Calculated storm lifetime as the time between the first and last
#     observation for each storm.
# [ ] Created a visualization showing how storm lifetime changes through time.
# [ ] Ran an appropriate statistical test to evaluate the relationship.
# [ ] Evaluated the assumptions of the statistical test.
# [ ] Reported and interpreted the results in peer-reviewed journal article style.

# RESEARCH QUESTION 4: PREDICTING HURRICANE-FORCE WIND DIAMETER
# [ ] Identified storms that reached hurricane status.
# [ ] Identified the maximum recorded wind speed for each storm.
# [ ] Retained the first observation when the maximum wind speed occurred more
#     than once for a given storm and year.
# [ ] Created visualizations to explore relationships among wind speed, pressure,
#     latitude, and hurricane-force wind diameter.
# [ ] Fit a model to predict hurricane-force wind diameter using appropriate
#     explanatory variables.
# [ ] Interpreted the estimated regression coefficients and model fit.
# [ ] Evaluated the regression assumptions using diagnostic plots.
# [ ] Considered whether a response transformation was appropriate, if needed.
# [ ] Reported and interpreted the results in peer-reviewed journal article style.

# COMMUNICATING RESULTS
# [ ] Included appropriate axis labels, units, and informative titles on plots.
# [ ] Included relevant statistical results in each written interpretation.
# [ ] Distinguished statistical significance from the strength or practical
#     importance of a relationship.
# [ ] Explained the direction and meaning of each relationship in the context
#     of the research question.

# FINAL REVIEW
# [ ] Added comments explaining the purpose of each major step.
# [ ] Answered all research questions and retained the original prompts.
# [ ] Ran the entire script from beginning to end without errors.
# [ ] Saved the completed script as:
#     LastName_FirstName_MES503_LabAssignment4.R
# [ ] Submitted the completed script to Brightspace.
################################################################################

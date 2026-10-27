# MES 503 Lab Assignment 3
# 10/6/2026
# Created by Kayla Blincow (with help from ChatGPT)
# ------------------------------------------------------------------------------


# INSTRUCTIONS

# Complete this script as you work through the assignment.
#
# - Replace every "# FILL IN" section with your own code or written response.
# - Comment your code so that someone else can follow your workflow.
# - Do not delete the research questions or prompts.
# - Your script should run from beginning to end without errors.
# - Save this script as: LastName_FirstName_MES503_LabAssignment3.R
# - Submit your completed script to Brightspace by the deadline.


################################################################################

# Research scenario:
# Researchers measured the feeding/clearance rate of scallops at three 
# coastal sites (A, B, and C) and in two habitat types (sand and reef). 
 
# There are 3 different data files:

# scallop_observations.csv - records of clearance rate of scallops sample from 
# different sites/habitats

# environmental_data.csv - records of local environmental data collected while measuring
# clearance rates (specifically depth and temperature)

# site_metadata.csv - records of general characteristics of each site

# Your initial research question is:
#   Does the clearance rate of scallops differ among sites and/or habitats?


################################################################################

# ==============================================================================
# PART 1: SET UP YOUR WORKSPACE
# ==============================================================================

# Write code to clear your workspace, load necessary packages and import your
# data file.

# FILL IN CODE HERE

# Explore your newly imported datasets.

# FILL IN CODE HERE

# Is there anything about the structure of the datasets that you think is
# important to understand before beginning the analyses? Are there any common 
# variables between your datasets that  might be used to combine them?

# FILL IN WRITTEN ANSWER HERE




# ==============================================================================
# PART 2: DATA WRANGLING
# ==============================================================================

# Your datasets contain information that belongs together, but it is currently 
# stored in separate tables.
#
# Use joins to generate a single dataset that combines all three data files.

# Your final dataset should contain at least:
# sample_id
# site
# habitat
# response
# temperature_C
# depth_m
# location_type
# management_zone

# FILL IN CODE HERE



# Use your data wrangling skills to answer the following questions:
#
# 1. Which site has the highest mean clearance rate?
# 2. Which site has the highest mean temperature?
# 3. Which site has the highest mean depth?
# 4. Do you notice any patterns?

# FILL IN WRITTEN ANSWER HERE



# ==============================================================================
# PART 3: ADDRESS YOUR INITIAL RESEARCH QUESTION
# ==============================================================================

# Research question:
#
# Does the clearance rate of scallops differ among sites and/or habitats, and 
# is there an interaction between site and habitat?

# Step 1: Visualize your data! 
# Create a visual that will help you establish an expectation for the answer to
# your research question.

# FILL IN CODE HERE


# Step 2: Conduct a statistical analysis!
# This should include an evaluation of the assumptions of the test you choose to
# use and any relevant post-hoc tests.

# FILL IN CODE HERE


# Step 3: Interpret the results of your statistical analysis!
# Report the results of your test(s) as you would in a peer-reviewed journal, 
# including a publication quality visual. Make sure to explicitly answer your
# research question and provide an ecological interpretation of your results. 
# (IMPORTANT: Do not overstate your results, report only what is appropriate 
# given the data you have.)

# FILL IN CODE/WRITTEN ANSWER HERE


# ==============================================================================
# PART 4: DIGGING DEEPER INTO YOUR RESULTS
# ==============================================================================

# Your statistical test above should suggest that clearance rates differ among sites.
#
# But remember:
#
#   A significant site effect does NOT tell us why sites differ.


# Explore the environmental variables measured across sites using visuals.

# FILL IN CODE HERE


# Is there another variable that appears to change systematically among
# the three sites?

# Formulate a new hypothesis:
# "Variation in ______ may explain variation in clearance."

# FILL IN WRITTEN ANSWER HERE


# ==============================================================================
# PART 5: ADDRESS YOUR NEW HYPOTHESIS
# ==============================================================================

# Test your new hypothesis using a statistical analysis.


# Step 1: Visualize your data! 
# Create a visual that will help you establish an expectation.
# FILL IN CODE HERE


# Step 2: Conduct a statistical analysis!
# This should include an evaluation of the assumptions of the test you choose to
# use and any relevant post-hoc tests.

# FILL IN CODE HERE


# Step 3: Interpret the results of your statistical analysis!
# Report the results of your test(s) as you would in a peer-reviewed journal, 
# including a publication quality visual. Make sure to explicitly answer your
# research question and provide an ecological interpretation of your results. 
# (IMPORTANT: Do not overstate your results, report only what is appropriate 
# given the data you have.)

# FILL IN CODE/WRITTEN ANSWER HERE



# ==============================================================================
# PART 6: CONNECTING THE TWO ANALYSES
# ==============================================================================

# Think carefully about what happened in the two analyses.
#
# Questions:
#
# 1. Why can a categorical variable such as site be significant even when it is 
#    not necessarily the mechanism causing the response to differ?
#
# 2. How does your second analysis help explain the site pattern?
#
# 3. Based on these data, would it be reasonable to conclude that "site causes 
#    changes in clearance rates"? Why or why not?
#
# 4. What additional analysis or experiment could help distinguish a true site 
#    effect from an environmental variable associated with site?


# FILL IN WRITTEN ANSWERS HERE


# ==============================================================================
# ==============================================================================
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


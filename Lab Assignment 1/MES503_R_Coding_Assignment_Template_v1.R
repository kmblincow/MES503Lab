# MES 503 R Coding Assignment
# Exploring Ecological Data with ggplot2
# Created by Kayla Blincow
# ------------------------------------------------------------------------------

# INSTRUCTIONS
# Complete this script as you work through the assignment.
# - Replace every "# FILL IN" section with your own code or written response.
# - Comment your code so that someone else can follow your workflow.
# - Do not delete the research questions or prompts.
# - Your script should run from beginning to end without errors.
# - Save this script as: LastName_FirstName_MES503_DataVisualization.R


#### PART 1: SET UP YOUR SCRIPT ####

# Load the packages you will need.
# You should only need ggplot2 for this assignment.

library(ggplot2)


# Import your CSV file.
# Update the file path below so that R can find your data.

data <- read.csv("FILL IN FILE PATH")


# Take a look at your data.
# Use head() to display the first six rows.

# FILL IN CODE


# What variables are included in this dataset?
# Which two variables are categorical?
# Which three variables are continuous/numerical?

# WRITE YOUR ANSWER HERE


# How many observations are included in the dataset?

# FILL IN CODE


# What ecological question do you think this dataset could help investigate?

# WRITE YOUR ANSWER HERE


# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# WRITE YOUR ANSWER HERE



#### PART 2: VISUALIZATION 1 — DESCRIBE THE DATA ####

# RESEARCH QUESTION:
# How are observations distributed among sampling sites?


# Create a visualization showing the number of observations from each sampling site.
#
# HINT:
# Think about the type of plot we used in Week 2 to count observations
# within each locality.
#
# Your plot should:
# - use an appropriate ggplot2 geometry;
# - clearly identify the sampling sites;
# - have informative axis labels;
# - include an informative title;
# - include at least TWO customization elements from Exercise 3.

# FILL IN CODE



# INTERPRETATION
#
# 1. Which site has the largest sample size?
# 2. Which site has the smallest sample size?
# 3. Are sample sizes approximately equal among sites?
# 4. How might differences in sample size influence your ability to compare sites?

# WRITE YOUR ANSWERS HERE



#### PART 3: VISUALIZATION 2 — COMPARE GROUPS ####

# RESEARCH QUESTION:
# Does body size differ among habitat types?


# Create a visualization that allows you to compare the distribution of body size
# among habitat types.
#
# You may choose an appropriate boxplot or violin plot.
#
# Your plot should:
# - clearly identify the habitat categories;
# - clearly identify the body-size variable;
# - include appropriate labels;
# - include an informative title;
# - use at least TWO customization elements from Exercise 3.

# FILL IN CODE



# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# WRITE YOUR ANSWERS HERE



#### PART 4: VISUALIZATION 3 — INVESTIGATE A RELATIONSHIP ####

# RESEARCH QUESTION:
# Is body size related to reproductive output?


# Create a visualization investigating the relationship between body size
# and reproductive output.
#
# Your plot should:
# - use an appropriate visualization for two continuous variables;
# - include a categorical variable using an aesthetic such as color or shape;
# - include appropriate axis labels;
# - include an informative title;
# - use at least TWO customization elements from Exercise 3.
#
# HINT:
# Think about the scatterplots you created in Week 1.

# FILL IN CODE



# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Do the different groups appear to follow the same pattern?
# 4. Are there any unusual observations or potential outliers?
# 5. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# WRITE YOUR ANSWERS HERE



#### PART 5: DEVELOP YOUR OWN ECOLOGICAL QUESTION ####

# Now you will use R more independently.
#
# Develop your own ecological question using the dataset.
#
# Your question must:
# - involve at least two variables;
# - investigate a relationship or difference;
# - be answerable using a visualization;
# - involve an ecological interpretation.


# STEP 1: STATE YOUR QUESTION

# Research Question:

# WRITE YOUR QUESTION HERE



# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________________________ because __________________________.

# WRITE YOUR PREDICTION HERE



# STEP 3: CREATE YOUR VISUALIZATION

# Create an appropriate ggplot2 visualization to investigate your question.
#
# Your plot must:
# - use an appropriate geometry;
# - use appropriate variables;
# - have informative axis labels;
# - have an informative title;
# - include at least THREE customization elements from Exercise 3.

# FILL IN CODE



# STEP 4: INTERPRET YOUR VISUALIZATION
#
# Write a short interpretation of your visualization.
#
# Your interpretation should:
# - describe the major pattern you observe;
# - explain whether the results support your prediction;
# - identify important variation or unusual observations;
# - provide a possible ecological explanation for the pattern.

# WRITE YOUR INTERPRETATION HERE



#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

# WRITE YOUR ANSWER HERE



# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# WRITE YOUR ANSWER HERE



# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# WRITE YOUR ANSWER HERE



# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# WRITE YOUR ANSWER HERE



# 5. LIMITATIONS
#
# Identify one limitation of this dataset or your analysis.
#
# What is one additional piece of information, variable, or analysis that would
# help you better understand the ecological relationship you investigated?

# WRITE YOUR ANSWER HERE



#### FINAL CHECK ####

# Before submitting, make sure you have:
#
# [ ] Imported the CSV successfully.
# [ ] Included code for exploring the dataset.
# [ ] Created all four required visualizations.
# [ ] Customized your visualizations.
# [ ] Answered all interpretation questions.
# [ ] Developed your own ecological question.
# [ ] Made a prediction before creating your own visualization.
# [ ] Answered all critical-thinking questions.
# [ ] Added comments to explain your code.
# [ ] Checked that your script runs from beginning to end without errors.
#
# SAVE YOUR SCRIPT BEFORE SUBMITTING!

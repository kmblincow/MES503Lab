# MES 503 Lab Assignment 1
# Exploring Ecological Data with ggplot2
# 8/26/2026 
# Created by Kayla Blincow (with help from ChatGPT)
# ------------------------------------------------------------------------------

# INSTRUCTIONS
# Complete this script as you work through the assignment.
# - Replace every "# FILL IN" section with your own code or written response.
# - Comment your code so that someone else can follow your workflow.
# - Do not delete the research questions or prompts.
# - Your script should run from beginning to end without errors.
# - Save this script as: LastName_FirstName_MES503_LabAssignment1.R
# - Submit your completed script to Brightspace by the deadline.


#### SCENARIO ####
# We are biologists interested in yellow-tail snapper populations on a protected
# island in the Caribbean. We sample four different sites across the island and
# gather data on different variables associated with the environment and take 
# samples of yellow-tail snapper individuals.

# The yellowtail_snapper.csv file contains the data we collected.
# (NOTE: this is a generated dataset, it is not real)

# The variables included are:
# site (shr) - Site on island 
# habitat (chr) - Type of habitat
# sex (chr) - sex of fish individual collected
# depth_m (num) - depth where fish individual was collected
# length_cm (num) - length of fish individual collected
# mass_g (int) - mass of fish individual collected 
# gonadosomatic_index (num) - gonadosomatic index of fish individual collected (percent) 
# algae_cover (num) - estimated algae cover where fish individual was collected (percent)
# fish_density (num) - estimated fish density where fish individual was collected (ind/100 m^2)


#### PART 1: SET UP YOUR SCRIPT & GET TO KNOW YOUR DATA ####

# Load the packages you will need.
# You should only need ggplot2 for this assignment.

library(ggplot2)


# Import your CSV file.
# Update the file path below so that R can find your data.

ytsnap <- read.csv("Lab 1/yellowtail_snapper.csv")


# Take a look at your data.
# Use a function to display the first six rows.

# FILL IN CODE

head(ytsnap)

# How many observations are included in the dataset?
# Which variables are categorical?
# Which variables are continuous?

# FILL IN WRITTEN ANSWERS HERE
# 240 obs. Categorical: Site, Habitat, Sex 
# Continuous: Depth(m), length(cm), mass(g), gonadosomatic index, 
# algal cover, and fish density


# What ecological question do you think this dataset could help investigate?
# FILL IN WRITTEN ANSWER HERE

# There are a couple but the first that comes to mind is if larger fish have a larger gonadosomatic index. Ie. are larger fish more important for stocking the population

# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# FILL IN WRITTEN ANSWER HERE

# I would choose Mass(g) as the predictor variable and gonadosomatic index is the response variable. In fish usually the larger fish have the ability to produce larger broods of offspring. My thinking is there is a good chance yellowtail follow this pattern. Meaning that I expect larger fish to have a larger gonadosomatic index. 



#### PART 2: VISUALIZATION 1 — DESCRIBE THE DATA ####

# RESEARCH QUESTION:
# How are observations distributed among sampling sites?


# Create a visualization showing the number of observations from each habitat type.
#
#
# Your plot should:
# - use an appropriate ggplot2 geom;
# - clearly identify the habitats;
# - have informative axis labels;
# - include an informative title;
# - include at least TWO customization elements from Week 3's lab.

# FILL IN CODE

ggplot(data = ytsnap, mapping = aes(x = habitat, fill = habitat))+
  geom_bar()+
  labs(x = "Habitat", y = "Yellowtail Count", fill = "Habitat")

# INTERPRETATION

# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# FILL IN WRITTEN ANSWERS HERE
# 1. Coral Reefs
# 2. Rubble
# 3. No, the sample sizes are not equal or approximately equal 
# 4. The is more samples from Coral Reefs and Seagrass which could skew the data away from rubble habitats. Meaning this could lead to a type II error if rubble is too small to detect true difference or could falsely show significant relationship.

#### PART 3: VISUALIZATION 2 — COMPARE GROUPS ####

# RESEARCH QUESTION:
# Does body size differ among habitat types?

# Create a visualization that allows you to compare the distribution of body size among habitat types.
#
# Your plot should:
# - clearly identify the habitat categories;
# - clearly identify the body-size variable;
# - include appropriate labels;
# - include an informative title;
# - use at least TWO customization elements from Week 3's lab.

# FILL IN CODE

ggplot( data = ytsnap, mapping = aes(x = habitat, y = mass_g, fill = habitat))+
  geom_violin() + 
  labs(x = "Habitat", y = "Fish Mass (g)", fill = "Habitat") +
  scale_fill_manual(values = c("Purple","Pink","Darkgreen"))

# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# FILL IN WRITTEN ANSWERS HERE
# 1. Coral Reefs
# 2. Coral Reefs
# 3. Yes, each habitat type has fish that overlap in size to other habitats
# 4. Yes, Coral Reefs have observations much higher than the
# average 
# 5. I would conclude that habitat does not cause a difference in body size. 



#### PART 4: VISUALIZATION 3 — INVESTIGATE A RELATIONSHIP ####

# RESEARCH QUESTION:
# Is body size related to reproductive output?


# Create a visualization investigating the relationship between body size
# and gonadosomatic index (a metric of reproductive output).
#
# Your plot should:
# - use an appropriate visualization for two continuous variables;
# - include a categorical variable using an aesthetic such as color or shape;
# - include appropriate axis labels;
# - include an informative title;
# - use at least TWO customization elements from Week 3's lab.


# FILL IN CODE

ggplot(ytsnap, mapping = aes(x = mass_g , y = gonadosomatic_index, color = sex))+
         geom_point(size = 0.75, alpha = 0.6) +
  labs(title = "Reproductive Output Across Sixe Gradient In Yellowtail Snapper",
 x = "Mass (g)", y = "Gonadsomatic Index", color = "Sex") +
  scale_colour_manual(values = c("Female" = "darkred", "Male" = "navyblue"))
  theme_bw 
  

# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# FILL IN WRITTEN ANSWERS HERE
# 1. It looks like overall there is a relatively strong positive relationship
# 2. Positive
# 3. Potentially but nothing very dramatic. A few smaller fish have higher
# fecundity than expected and one female is very large but not having 
# the expected reproductive output
# 4. I would say it is a useful predictor. It can be clearly seen that 
# larger fish have an greater ability to reproduce 


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

# FILL IN YOUR QUESTION HERE

# Is there a higher density of fish at deeper sampling sites?

# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that as depth increases so will fish density because the fish will 
# utilize structure especially on reefs.


# STEP 3: CREATE YOUR VISUALIZATION

# Create an appropriate ggplot2 visualization to investigate your question.
#
# Your plot must:
# - use an appropriate geometry;
# - use appropriate variables;
# - have informative axis labels;
# - have an informative title;
# - include at least THREE customization elements from Week 3's lab.

# FILL IN CODE

ggplot(ytsnap, aes(x = depth_m, y = fish_density, color = site)) +
    geom_point(size = 2, alpha = 0.75) +
    labs(title = "Fish Density Across Depth", x = "Depth (m)",
         y = "Fish Density", color = "Site") +
    scale_color_manual(values = c("purple","blue","green","red"))+
    theme_bw()
  
# STEP 4: INTERPRET YOUR VISUALIZATION
#
# Write a short interpretation of your visualization.
#
# Your interpretation should:
# - describe the major pattern you observe;
# - explain whether the results support your prediction;
# - identify important variation or unusual observations;
# - provide a possible ecological explanation for the pattern.

# FILL IN YOUR INTERPRETATION HERE

# This graph shows a positive relationship between depth and fish density.
# The overall trend is the deeper the water the denser the fish population. 
# My results support my prediciton but it is hard to say if there is actually
# any type of correlation between them. It is likely that there are differences 
# at each site that account for the variation in fish density more than depth.
# It is possible that the deeper sites have healthier coral coverage due to 
# reduced thermal stress , allowing the snapper to survive in denser populations
# because they have more habitat and/or healthier habitat. 

#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

# FILL IN WRITTEN ANSWER HERE#

# Not at all. Take my final graph looking at fish density across depth. It shows
# a strong positive relationship, however I don't think depth directly impacts
# fish densities. When you break it down by site there are clear groupings. 
# this indicated to me that the reefs themselves might have more of an impact
# on fish densities than the solely the depth of the fish.
  
# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# FILL IN WRITTEN ANSWER HERE
  
# The first ones that come to my mind would be the site or the habitat. For 
# example, my final graph when broken down by site shows clear groupings. 
# It is likely that there are significant factors at each site that make 
# it more or less likely to be a good habitat for yellowtail. These things 
# could be the protection, structure, and habitat quality. It can just look 
# like depth is driving the fish density but I believe it is more likely
# site specific habitat quality driving the variation. 

# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# FILL IN WRITTEN ANSWER HERE

# It is important because sample sizes can skew data if not accounted for. 
# If there was one site that only had 2 fish collected but they were very large
# the data would show that site being home to the largest fish. In reality, 
# that sites true state might be having smaller fish but because the sample size
# is so small we can accuratley detect the true state. 

# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# FILL IN WRITTEN ANSWER HERE

# I think my last graph is the most interesting. Initially, it looks like depth 
# is driving the variation in fish densities. I believe this is a misconception
# because when grouped by site there is a clear grouping difference. The real 
# driver of fish density across these four sites is likely the site-specific 
# health of the habitat. The deeper habitats are likely more buffered from stress
# leading to healthier reefs that can sustain greater densities of fish. This 
# still sounds like depth is a control, but I believe if there were shallow reefs
# as healthy as the deep reefs we would see similar fish densities. 


#### FINAL CHECK ####

# Before submitting, make sure you have:
#
# [X] Imported the CSV successfully.
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
# SAVE YOUR SCRIPT AND SUBMIT TO BRIGHTSPACE!

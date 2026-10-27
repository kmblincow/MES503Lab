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
# We are biologists interested in yellowtail snapper populations on a protected
# island in the Caribbean. We sample four different sites across the island and
# gather data on different variables associated with the environment and take 
# samples of yellowtail snapper individuals.

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

ytsnap <- read.csv("yellowtail_snapper.csv")


# Take a look at your data.
# Use a function to display the first six rows.

head(ytsnap)

# How many observations are included in the dataset?
#     There are 9 different observations included in the dataset

# Which variables are categorical?
#     Three variables are categorical: site, habitat, and sex

# Which variables are continuous?
#     Six variables are continuous: depth_m, length_cm, mass_g, gonadosomatic_index, algae_cover, and fish_density


# What ecological question do you think this dataset could help investigate?

# How does the type of habitat effect the size of yellow tail snapper?


# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# The variable mass_g could be the response to the habitat variable because more productive habitats such as coral reefs could cause yellow tail snapper to grow larger/heavier than in other environments.



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

ggplot(data = ytsnap, aes(x = habitat, fill = site)) +
  geom_bar() + #Creating bar graph
  scale_fill_manual(values = c(hcl.colors(4, palette = "YlGnBu"))) + #manual color scale
  labs(title = "Yellow Tail Snapper Observations Per Habitat", 
       x = "Habitat", 
       y = "Number of Observations", 
       fill = "Site") +
  theme_classic() + #Creating a cleaner graph appearance
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))



# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# Coral Reefs have the largest sample size, while Rubble has the lowest sample size.
# The sample sizes are not equal among habitats since Coral Reefs have over double the number of observations as Rubble.
#Differences in sample size can lead to Higher variability in the results which could end up with an inaccurate conclusion drawn from the data if it is not taken into account.


#### PART 3: VISUALIZATION 2 — COMPARE GROUPS ####

# RESEARCH QUESTION:
# Does body size differ among habitat types?


# Create a visualization that allows you to compare the distribution of body size
# among habitat types.
#
#
# Your plot should:
# - clearly identify the habitat categories;
# - clearly identify the body-size variable;
# - include appropriate labels;
# - include an informative title;
# - use at least TWO customization elements from Week 3's lab.

ggplot(data = ytsnap, aes(x = habitat, y = length_cm, fill = habitat)) +
  geom_violin(alpha = 0.6) + #Creating violin graph to show fish length distribution
  geom_jitter(height = 0, width = 0.1, alpha = 0.6) + #adding scatter points to show sample size
  scale_fill_manual(values = c(hcl.colors(4, palette = "YlGnBu"))) + #manual color scale
  labs(title = "Yellow Tail Snapper Habitat Body Sizes", 
       x = "Habitat", 
       y = "Body Length (cm)", 
       fill = "Habitat") +
  theme_classic() + #Creating a cleaner graph appearance
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))



# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# Coral Reefs tend to have the largest individuals on average
# Seagrass habitats show the greatest amount of variation in body size
# The majority of body length distributions overlap among habitats
# The Seagrass habitat had a couple low outliers that could negatively skew the data, but the sample size was relatively high enough to offset it.
# Based on the visualizations, habitat may have a slight effect on differences in body size, but the trend is not distinct enough to be considered causal since there is a substantial amount of distribution overlap.



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


#Body length graph
ggplot(data = ytsnap, aes(x = length_cm, y = gonadosomatic_index)) +
  geom_point(alpha = 0.7, size = 3, aes(color = sex)) + #Creating scatter due to 2 continuous variables
  geom_smooth(method = "lm", color = "black") + #Linear regression to make trend line
  scale_color_manual(values = c(hcl.colors(2, palette = "RdBu"))) + #manual color scale
  labs(title = "Reproductive Output of Yellow Tail Snapper Sizes", 
       x = "Body Length (cm)", 
       y = "Gonadosomatic Index", 
       color = "Sex") +
  theme_classic() + #Creating a cleaner graph appearance
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))

#Body weight graph
ggplot(data = ytsnap, aes(x = mass_g, y = gonadosomatic_index)) +
  geom_point(alpha = 0.7, size = 3, aes(color = sex)) + #Creating scatter due to 2 continuous variables
  geom_smooth(method = "lm", color = "black") + #Linear regression to make trend line
  scale_color_manual(values = c(hcl.colors(2, palette = "RdBu"))) + #manual color scale
  labs(title = "Reproductive Output of Yellow Tail Snapper Sizes", 
       x = "Mass (g)", 
       y = "Gonadosomatic Index", 
       color = "Sex") +
  theme_classic() + #Creating a cleaner graph appearance
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))


# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# As Body length increases, the Gonadosomatic Index increases as well (Positive relationship between body size and reproductive output)
# The relationship is positive
# There is a decent amount of variability, but no clear outliers. Males tend to have larger reproductive output.
# Body size appears to be a good predictor of reproductive output because there is a large sample size with a clear positive trend. I would definitely check the relationship using body mass instead of length to see if it has a more significant relationship though.



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

# How does yellow tail snapper density differ with depth?



# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________________________ because __________________________.

# I predict that yellow tail snapper density will decrease with depth because there is less productivity and food in deeper waters.



# STEP 3: CREATE YOUR VISUALIZATION

# Create an appropriate ggplot2 visualization to investigate your question.
#
# Your plot must:
# - use an appropriate geometry;
# - use appropriate variables;
# - have informative axis labels;
# - have an informative title;
# - include at least THREE customization elements from Week 3's lab.

ggplot(data = ytsnap, aes(x = depth_m, y = fish_density)) +
  geom_point(alpha = 0.7, size = 3, aes(color = habitat)) + #Creating scatter due to 2 continuous variables
  geom_smooth(method = "lm", color = "black") + #Linear regression to make trend line
  scale_color_manual(values = c(hcl.colors(4, palette = "YlGnBu"))) + #manual color scale
  labs(title = "Yellow Tail Snapper Density with Depth", 
       x = "Depth (m)", 
       y = "Fish Density", 
       color = "Habitat") +
  theme_classic() + #Creating a cleaner graph appearance
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))



# STEP 4: INTERPRET YOUR VISUALIZATION
#
# Write a short interpretation of your visualization.
#
# Your interpretation should:
# - describe the major pattern you observe;
# - explain whether the results support your prediction;
# - identify important variation or unusual observations;
# - provide a possible ecological explanation for the pattern.

# Yellow Tail Snapper fish density increases as depth increases (positive relationship), which is the opposite of my prediction.
# There is a decent amount of variability, but a large enough sample size to still indicate a strong trend, with little to no outliers or unusual observations.
# A possible explanation for this trend is that there is a decent amount of vertical mixing in this location causing an increasingly productive environment up to 30 m due to cycling of nutrients and plankton throughout the water column. I believe that if the graph continued to greater depths, we would see a drop off in the fish density a little bit past the picnocline.



#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

# Observing a relationship between two variables does not mean that one variable causes the other. For example, an earlier visualization showed coral reef habitats having a greater body length on average, but this may not have anything to do with the habitats themselves. It could be because of a more specific variable such as algae cover or depth that happens to be different between habitats sampled or due to a larger coral reef sample size skewing results slightly.



# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# Algae Cover could be a confounding variable for the relationship I observed between habitat and body length. Algae cover provides nutrients that may support the growth and development of yellow tail snapper and differs between locations, so if a certain habitat had more or less algae, it could influence the body length relationship shown in the visualization more than the habitats themselves.



# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# Groups with a low number of observations like Rubble habitats tend to have greater variability in the data because outliers have a much greater effect on data trends. If this is not taken into account by calculating standard deviation/variance and displaying error bars on graphs, it can be easy to draw false conclusions.



# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# The pattern from my visualizations I find particularly interesting is that yellow tail snapper fish density has a positive relationship with depth all the way down to 25 m. I hypothesize that the ecological mechanism explaining this pattern of high fish density at depth is vertical mixing. This is because vertical mixing causes cycling of nutrients and plankton throughout the water column making the zone of highest productivity deeper the more mixing there is, which the snapper take advantage of at this location.




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
# SAVE YOUR SCRIPT AND SUBMIT TO BRIGHTSPACE!

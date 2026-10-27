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
# site (chr) - Site on island 
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

ytsnap <- read.csv("Lab 1 assignment/yellowtail_snapper.csv")


# Take a look at your data.
# Use a function to display the first six rows.

head (ytsnap)

str(ytsnap)

# How many observations are included in the dataset?

# Which variables are categorical?

# Which variables are continuous?


# FILL IN WRITTEN ANSWERS HERE
#240 observations
#Site, Habitat, and Sex
#Depth, length, Mass, Gonadosomatic index, algae cover, and fish density


# What ecological question do you think this dataset could help investigate?

# FILL IN WRITTEN ANSWER HERE
#Does the habitat in which a yellowtail snapper is found influence the size of the fish?

# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# FILL IN WRITTEN ANSWER HERE
#Habitat type can be used as a predictor whether rubble, seagrass, or coral reef.
#Mass of the yellowtail snappers could be a response.
#My reasoning would be that depending on the habitat type more prey would be available as
#yellow tail snappers are carnivores. It could be that the fish that they eat would be more
#prevalent in one habitat than another allowing them to consume more nutrients and grow to
#bigger sizes.


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
ggplot (data = ytsnap, aes(x = habitat, y = mass_g, color = habitat)) + 
  geom_boxplot() +
  labs (x = "Habitat Type", y = "Mass (g) of Yellowtail Snappers", title = 
          "Yellowtail Snapper Weight to Habitat Type") +
  theme_bw() +
  theme (plot.title = element_text(hjust = 0.5, face = "bold"),
         legend.position = "none",
         axis.title = element_text(size = 12, face = "bold"))

# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# FILL IN WRITTEN ANSWERS HERE
#1. Coral reefs have the largest sample size.
#2. Seagrass has the smallest sample size. 
#3. No, they are not
#4. A skewed sample size could cause one habitat to be smaller or larger than it actually is due to a higher amount or lower amount of samples, which in turn gives you incorrect statistics of the population parameters,

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

# FILL IN CODE

ggplot (data = ytsnap, aes(x = habitat, y = length_cm, fill = habitat)) + 
  geom_boxplot() +
  scale_fill_manual(values = c ("coral", "grey","green")) +
  labs (x = "Habitat Type", y = "Length (cm) of Yellowtail Snappers", title = 
          "Yellowtail Snapper Size to Habitat Type") +
  theme_bw() +
  theme (plot.title = element_text(hjust = 0.5, face = "bold"),
         legend.position = "none",
         axis.title = element_text(size = 12, face = "bold"))


# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# FILL IN WRITTEN ANSWERS HERE
#1. Coral reefs seem to have the largest individuals on average.
#2. I would say coral reefs also hav ethe greatest variation.
#3. Yes, they all overlap each other.
#4. The sample size for coral reefs is bigger than rubble and seagrass which could influence results.
#5. No, all of the boxplots for this data overlap each other so I would not confidently conclude that habitat causes #differences in body size.

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

ggplot (data = ytsnap, aes (x = length_cm, y = gonadosomatic_index, color = habitat)) +
  geom_point(size = 3, alpha = 0.6) +
  labs (x = "Body Size (cm)", y = "Gonadosomatic Index", 
        title = "Yellowtail Snapper Size in Relation to Gonadosomatic Index", color = "Habitat Type") + 
  scale_color_manual(values = c("coral", "grey", "green")) +
  theme (plot.title = element_text( hjust = 0.5, face = "bold"),
         legend.position = "right", 
         axis.title = element_text(size = 12, face = "bold"),
         legend.title = element_text( size = 12, face = "bold"))


# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# FILL IN WRITTEN ANSWERS HERE
#1. There is a trend that shows that the larger the fish the more reproductive output it has.
#2. I think the relationship is positive.
#3. There are two one for the seagrass habitat which is the only one very close to zero on both axis es and then one for coral #reefs being the only one on the 40 mark although it is not the highest on the index scale. 
#4. Yes, looking at the graph you can tell there is a positive relationship between the two as when body size increased
#the gonadosomatic index looks to increase as well. 


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

#Are yellowtail snappers in denser populations smaller or larger in size?

# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________________________ because __________________________.

# FILL IN YOUR PREDICTION HERE
#I predict that denser populations of yellowtail snappers are larger in size because larger schools would have more protection from predators and feed more effectively. 


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

ggplot (data = ytsnap, mapping = aes (x = fish_density, y = length_cm, color = site)) +
  geom_point(alpha = 0.6, size = 3) +
  labs (x = "Fish Density", y = "Length (cm)", title = "Yellowtail Snapper Fish Density and Length (cm) by Site", color = "Site") +
  theme (plot.title = element_text(hjust = 0.5, size = 16, face = "bold"),
         legend.position = "right",
         axis.title = element_text (size = 12, face = "bold"),
         legend.title = element_text (size = 12, face = "bold"))




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

#I do not observe any kind of relationship between fish density and length of fish. My prediction of the fish density and the length of yellowtail snappers having a relationship which may have been attributed to predator prevention and good foraging habits were not supported by the results of my visual. The scatter plot has a high variance across the graph making it extremely difficult to find a relationship. However,there could be a relationship between fish density and the site the data was received from, which was not the intention of this visual. Although there was great overlap with some sites, a small pattern could be noticed where the sites Fringing reef and Patch Reef showed smaller fish density compared to South reef which had higher fish density. This could be due to the type of habitats that those sites have. Yellowtail snapper may prefer coral reefs as a habitat and South Reef may have mainly coral reefs. 
#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

# FILL IN WRITTEN ANSWER HERE

#1. A relationship between two variables does not necessarily mean that one variable causes the other. In my visual comparing yellowtail snapper gonadosomatic index and body size in cm, there seems to be a positive relationship between the two variables; however, there could be other factors that may cause one variable or both like nutrient intake or low predation rates. 


# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# FILL IN WRITTEN ANSWER HERE

#2. In the relationship of habitat type and mass in grams, I think sex could be a confounding factor. Some fish tend to be smaller or larger depending on sex mostly due to reproduction dynamics. If more female yellowtail snapper weight data was taken and it turns out they may larger or smaller in nature, that could influence the results of the data. 


# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# FILL IN WRITTEN ANSWER HERE

#3. If one group has way more observations than another, it would not reflect the true populatiion parameters.

# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# FILL IN WRITTEN ANSWER HERE

#4. I found it interetsing that in my visualization showing the relationship between gonadosmatoc index and body size that yellowtail snappers from coral reefs were all above 20 cm in length; in comparison, rubble and seagrass habitats did fall below that margin and barely had individuals past 30 cm. I think that could be because coral reefs may have more nutrient options for yellowtail snappers allowing them to get to bigger size. 



#### FINAL CHECK ####

# Before submitting, make sure you have:
#
# [x] Imported the CSV successfully.
# [x] Included code for exploring the dataset.
# [x] Created all four required visualizations.
# [x] Customized your visualizations.
# [x] Answered all interpretation questions.
# [x] Developed your own ecological question.
# [x] Made a prediction before creating your own visualization.
# [x] Answered all critical-thinking questions.
# [x] Added comments to explain your code.
# [x] Checked that your script runs from beginning to end without errors.
#
# SAVE YOUR SCRIPT AND SUBMIT TO BRIGHTSPACE!
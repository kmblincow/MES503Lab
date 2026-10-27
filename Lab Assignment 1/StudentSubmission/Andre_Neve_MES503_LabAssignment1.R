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

ytsnap <- read.csv("yellowtail_snapper (1).csv")


# Take a look at your data.
# Use a function to display the first six rows.

head(ytsnap)


# How many observations are included in the dataset?
# Which variables are categorical?
# Which variables are continuous?

# 240 observations, site, habitat, and depth are categorical, depth, length, index, algae, and density are continuous


# What ecological question do you think this dataset could help investigate?

# The population makeup and habits of yellow tail snapper for things like conservation and such.


# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# length could be used as a predictor for sex, as females seem to be significantly smaller than the males. Im not sure how easy it is to sex the fish it could be the other way around.



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

ggplot(data = ytsnap, 
mapping = aes(x= habitat, y = , 
              color = )) +
  geom_bar(size = 3, alpha = .6) + 
  labs(x = "habitat",
       y = "number") +
  theme_bw()+ 
  labs(title="Yellowtail Snapper Habitat Ocurrances")



# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# 1. coral reef
# 2. Rubble
# 3. no they vary quite a bit.
# 4. the larger sample sizes will have more significance with its data and results.



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

ggplot(data = ytsnap, 
mapping = aes(x= habitat, y = mass_g, 
              color = habitat)) +
  geom_violin(size = 3, alpha = .6) + 
  labs(x = "habitat",
       y = "mass (g)") +
  theme_bw()+ 
  labs(title="Body Size of Yellowtail Snapper by Habitat")



# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# 1. Coral Reef
# 2. Coral reef
# 3. Yes, rubble and seagrass are almost the same.
# 4. While the coral reef has a wide range, getting much larger than the other two habitats, the other two habitat are almost the same as far as mass distribution goes.
# 5. I think that there may be more resources that allow the fish to grow bigger at the reef, but don't have enough information to say its not just something like "fish migrate to reefs at a certain age. 



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


ggplot(data = ytsnap, 
mapping = aes(x= mass_g, y = gonadosomatic_index, 
              color = sex)) + 
  geom_point(size = 3, alpha = .6) + 
  labs(x = "Mass (g)",
       y = "Reptroduction") +
  theme_light()+ 
  labs(title="Reproduction of Yellowtail Snapper by Mass (g)")


# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# 1. There appears to be a positive correlation between body mass and reproduction. The males appear to have a steeper slope than females, which appear to level off around 4.
# 2. The correlation is positive.
# 3. The largest fish (F) has a lower reproductive rate than the ongoing slope as a whole would suggest, but is on trend for the female slope.
# 4. Yes, there is a clear correlation between the two variables. 



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

# Are certain hbaitats more likely to house male or female individuals? 



# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________________________ because __________________________.

# I predict that there will not be a significant difference because that would indicate high levels of movement between the habitats which I dont believe would be there due to specificity of the populations.



# STEP 3: CREATE YOUR VISUALIZATION

# Create an appropriate ggplot2 visualization to investigate your question.
#
# Your plot must:
# - use an appropriate geometry;
# - use appropriate variables;
# - have informative axis labels;
# - have an informative title;
# - include at least THREE customization elements from Week 3's lab.


yt_fem <- filter(ytsnap, sex == "Female")
yt_male <- filter(ytsnap, sex == "Male")

ggplot(data = yt_fem, 
       mapping = aes(x= habitat, y = , 
                     color = habitat)) +
  geom_bar(size = 3, alpha = .6) + 
  labs(x = "habitat",
       y = "number") +
  theme_bw()+ 
  labs(title="Female Yellowtail Snapper Habitat Ocurrances")
ggplot(data = yt_male, 
       mapping = aes(x= habitat, y = , 
                     color = habitat)) +
  geom_bar(size = 3, alpha = .6) + 
  labs(x = "habitat",
       y = "number") +
  theme_bw()+ 
  labs(title="Male Yellowtail Snapper Habitat Ocurrances")
# I know this is two graphs but im not sure how to ge them together at the moment. It still works though I think.


# STEP 4: INTERPRET YOUR VISUALIZATION
#
# Write a short interpretation of your visualization.
#
# Your interpretation should:
# - describe the major pattern you observe;
# - explain whether the results support your prediction;
# - identify important variation or unusual observations;
# - provide a possible ecological explanation for the pattern.

# It would appear that there are more female fish in the sea grass, male fish in the coral, and about equal amounts in the rubble. They do support my prediction in there being different amounts of each sex at each habitat. The Rubble habitat, however, shows equal amounts of both sexes, indicating no gender specific preferences. This could indicate some sort of physical evolution preference, like perhaps sexual dimorphism makes it easier for makes to survive in the bright coral and females in the sea grass. 



#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

# It does not necessarily indicate causation. variables like depth and sex if they happen to be correlated, are not at all able to influence the other, as sex is genetically determined not based on things like water pressure.



# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# Fish density and reproduciton may be confounding. Are there more fish because they reproduce a lot, or does high density allow for high reproduciton? I dont think this particular example affects the relationship I looked at but perhaps maybe the Sex confounds with the habitat.



# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# Higher numbers of individuals increases significance of the dataset and decreases randomization.



# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# I find the difrence between fecundity in males and females based on size interesting. the Males seem to continue on upwards indefinatly while the females level off. This could be because eggs are more energenically taxing to produce, limiting female reproduction, or it could be that the males also grow larger and it would take a larger dataset with larger males to see a leveling off.
# Males level off on their reproduction at masses that are harder to attain than females do, resulting in a seemingly linear continuation of fecundity.




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

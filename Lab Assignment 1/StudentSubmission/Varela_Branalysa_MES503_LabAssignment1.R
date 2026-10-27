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

ytsnap <- read.csv("Week_3/yellowtail_snapper.csv")



# Take a look at your data.
# Use a function to display the first six rows.

head(ytsnap)

# How many observations are included in the dataset?
# Which variables are categorical?
# Which variables are continuous?

# FILL IN WRITTEN ANSWERS HERE
  #240 observations, 9 variables
  #Site, habitat, sex are categorical
  #Depth_m, length_cm, mass_g, gonadosomatic_index, algae_cover, fish_density are continuous

# What ecological question do you think this dataset could help investigate?

# FILL IN WRITTEN ANSWER HERE
  #Does site influence yellowtail snapper body size?

# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# FILL IN WRITTEN ANSWER HERE
  #One variable that could potentially be used as a predictor could be site. Each site on the island differs in resources, predators, and environmental disruption . 
  #One variable that could be used as a response is mass_g since you could compare body mass to see if they differ from site to site.

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
ggplot(data = ytsnap, aes(x = habitat, fill = habitat)) +
  geom_bar()+
  scale_fill_manual(values = c("#FF6392",
                                "#FFE45E",
                                 "#7FC8FC")) +
labs(title = "Number of Observations From Each Habitat Type", x = "Habitat Type", y = "Yellowtail Snapper Count",
     fill = "Habitat") + 
  theme_classic() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))+
  theme(legend.position = "none")

  #Counted how many obervations came from each habitat
  #Changed the color of bars with scale_fill_manual
  #Put title in bold and placed in the middle with theme(plot.title = element_text(hjust = 0.5, face = "bold"))
  #Got rid of legend with theme(legend.position = "none")

# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# FILL IN WRITTEN ANSWERS HERE
  #1. Coral Reef has the largest sample size
  #2. Rubble has the smallest sample size.
  #3. The sample sizes are not equal among habitats.
  #4. Since the observations are not equal you cannot accurately compare habitats because it will be bias towards one habitat than to another.


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
ggplot(data = ytsnap, aes( y= mass_g,
                                      fill = habitat)) +
  geom_boxplot(alpha = 0.6)+
  labs(title = "Yellowtail Body Size based on Habitat Type", y = "Body Mass",
       fill = "Habitat") + 
  theme_bw() +
  theme(legend.position = "none")+
  facet_wrap(~ habitat)

  #Assessed if body size was influence by habitat
  #Faded color of boxes with geom_boxplot(alpha = 0.6)
  #Separate habitat type bars into 3 plots with facet_wrap(~ habitat)

# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# FILL IN WRITTEN ANSWERS HERE
  #1. Coral Reef seem to have the largest individuals.
  #2. Coral Reef showed the greatest amount of variation in body size
  #3. There are overlap distributions among habitats.
  #4.Yes there is a high distribution for coral reefs due to outliers
  #5. No, because the distribution is not too far off to make that conclusion and we don't know if the data is significant.


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
ggplot(data= ytsnap, aes(x = mass_g, y= gonadosomatic_index, 
                         color = sex)) + 
  geom_point(shape = 17, size = 2)+
  scale_color_manual(values =c("#ADC178", "#F4ACB7"))+
  labs(title = "Relationship Between Body Size and Reproductive Output", x= "Body Mass", y= "Reproductive Output", color= "sex") +
  theme_bw()

  #Evaluated if body size and reprodutive output were correlated
  # Changed shape and size of points with geom_point(shape = 17, size = 2)
  #changed color of points with scale_color_manual(values =c("#ADC178", "#F4ACB7"))+

# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# FILL IN WRITTEN ANSWERS HERE
  #1. Larger body mass seems to correlate to having larger reproductive output.
  #2. The relationship is positive.
  #3. Yes, there are a few outliers.
  #4. Yes, because there is a clear positive trend shown and if you were given a mass you can somewhat predict the general area it could land for reproductive output.


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
  #Does the depth sampled influence how many yellowtail snappers are found?


# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
  #I predict that ____________________ because _________________.

# FILL IN YOUR PREDICTION HERE
  #I predict that there will be more yellowtial snappers at low depths because yellowtail snappers are found in the Caribbean and these reefs thrive in shallow water to receive sunlight.


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
ggplot(data= ytsnap, aes(x = depth_m, y= fish_density,
                         color = sex)) + 
  geom_point(shape = 15, size = 2.5, alpha = 0.8)+
  scale_color_manual(values =c("#BE95C4", "#c6ac8f"))+
  labs(title = "Fish Density based on Depth", x= "Depth (m)", y= "Fish Density") +
  theme_classic()

  #Determined fish density was due to depth.
  #Changed point shape, size, color, and how much it was faded with geom_point(shape = 15, size = 2.5, alpha = 0.9)) +   scale_color_manual(values =c("#BE95C4", "#c6ac8f"))

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
  #There is a positive trend with depth and fish density 
  #The results do not support my prediction. There was more observations at higher depths but lower depths seem to have higher fish density.
  #There are no outliers.
  #There could be more yellowtail snappers at lower depths since many fish go to lower depths in search for food and avaiod predators.


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
  #No not exactly two variables can show a relationship because they are related due to conditions. Algae cover and fish density can show a relationship not because one causes the other but because of a certain condition like habitat or depth.

# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# FILL IN WRITTEN ANSWER HERE
  #Sex could potentially confound other variables like body mass. Males tend to be larger than females so if you find more males at a certain site or habitat it is going to have a higher average body size.


# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each group when interpreting your visualizations?

# FILL IN WRITTEN ANSWER HERE
  #Having more observations allows you to get closer to a true representation of the population. If you have different numbers of observations for each group then one may have a better representation of the population than the other so you can't accurately compare them.


# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# FILL IN WRITTEN ANSWER HERE
  #I think it was interesting to see there were more yellowtail snappers at coral reef habitats. This could be caused due to coral reefs possibly being a more preferred nursery area for yellowtail snappers. 
    #There is a higher fish density at coral reefs because they might be more preferred nursery ground for yellowtail snappers. 


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

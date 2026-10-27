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

ytsnap <- read.csv("Week Three/yellowtail_snapper.csv")


# Take a look at your data.
# Use a function to display the first six rows.

# FILL IN CODE
head(ytsnap)

# How many observations are included in the dataset?
# Which variables are categorical?
# Which variables are continuous?

# FILL IN WRITTEN ANSWERS HERE
#1. 240
#2. site, habitat, sex, and fish density
#3. depth_m, length_cm, mass_g, gonadosomatic_index

# What ecological question do you think this dataset could help investigate?
# FILL IN WRITTEN ANSWER HERE
#Does fish density have an impact on algae cover.

# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# FILL IN WRITTEN ANSWER HERE
#algae_cover (num) - estimated algae cover where fish individual was collected (percent)Response
# fish_density (num) - estimated fish density where fish individual was collected (ind/100 m^2)Predictor

#### PART 2: VISUALIZATION 1 — DESCRIBE THE DATA ####

# RESEARCH QUESTION:
# How are observations distributed among sampling sites?

print(ytsnap)
ggplot(data = ytsnap, aes(x = site,
                               fill = site)) +
  geom_bar()+
  labs(x = "Site", y = "yellowtail Count",
       fill = "site") + 
  theme_classic()
#the number of observations by location/site seemed like much of the same.

# Create a visualization showing the number of observations from each habitat type.
# Your plot should:
# - use an appropriate ggplot2 geom;
# - clearly identify the habitats;
# - have informative axis labels;
# - include an informative title;
# - include at least TWO customization elements from Week 3's lab.

# FILL IN CODE
ggplot(data = ytsnap, aes(x = habitat,
                                      fill = habitat))+
  geom_bar()+
  labs(title = "Number of Observations from each Habitat", x = "Habitat", y = "Yellowtail Count",
       fill = "Habitat") +
  theme_classic()
# Using habitat gave me a better depiction of the number of observations taken.

# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# FILL IN WRITTEN ANSWERS HERE
#1. coral reefs
#2. Rubble
#3. no, they are quite variable
#4. The difference in sample sizes can cause a bias when determining the difference in algal cover, 
#when the same number of fish aren't from each habitat.



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
ggplot(data = ytsnap, aes(x= habitat, y= mass_g, 
                               colour = habitat)) +
  geom_point(size = 3, #make our points bigger
             alpha = 0.6)+
  scale_color_manual(values = c("Coral Reef" = "darkorange", #assign a color to each level
                                "Rubble" = "cyan4",
                                "Seagrass" = "purple3"))
  labs(title = "Distribution of Body Size Among Habitat Type",
       x= "Habitat", y = "mass_g", 
       fill= "Habitat")+
  theme_bw()
# I used the colors to decipher between habitat differences. By resizing the points
# and their opacity you can really visualize the difference in the fish masses.
# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# FILL IN WRITTEN ANSWERS HERE
#1. Coral reefs
#2. Coral reefs
#3. Yes, there is overlap
#4. Yes, particularly the one above 5000g
#5. No, Habitat has no influence on the body size of organisms. This is because much
#of the data overlaps and there isn't much visual variation.


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
  ggplot(data = ytsnap, aes(x= mass_g, y= gonadosomatic_index, 
                            colour = habitat)) +
    geom_point(size = 3, #make our points bigger
               alpha = 0.6)+
    scale_color_manual(values = c("Coral Reef" = "darkorange", #assign a color to each level
                                  "Rubble" = "cyan4",
                                  "Seagrass" = "purple3"))
  labs(title = "Body size VS Gonadosomatic index",
       x= "Mass_g", y = "Gonadosomatic_index", 
       fill= "Habitat")+
    theme_bw()
# I used the colors to decipher by habitat to see which fish were often bigger and
# had larger gonads.
  
# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# FILL IN WRITTEN ANSWERS HERE
#1. The relationship is positive, as body size increases, usually gonadosomatic sizes increase as well.
#2. The relationship is Positive
#3. The data does look slightly unusual, There are a few outliers.
#4. Based on the visualization the data would be a good predictor of reproductive output
#   the data is mostly linear with little variation. 


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

# Research Question: How does fish density vary between each site/location?


# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that site effects fish density because resources may be different
# in each location.

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

ggplot(data = ytsnap, aes(x= site, y= fish_density, 
                          color = sex,)) +
  geom_boxplot()+
  labs(title = "Effect of site on fish density",
       x= "Site", y = "Fish_density") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold")) +
  facet_wrap(~ site)
#Customization's are bold, center, and facet wrap.

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
# 1. the major pattern that I can observe is that there is a large fish density in
# the south reef. The results support my prediction because fish density is 
# different in each site. The patchy reef is the only one with a lot of variation
# you can see this because of the points that are drastically above or below the 
# mean. This pattern could be caused by the 

ggplot(data = ytsnap, aes(x = algae_cover,
                               fill = site)) +
  geom_histogram()+
  labs(x = "algal_cover", y = "site",
       fill = "site") + 
  theme_classic()  
# I tried a code to visualize whether there is actually a site specific difference
# in agal cover. The association with fish density and site seemed important so i 
# wanted to try and confirm my prediction.
#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this data set to explain your answer.

# FILL IN WRITTEN ANSWER HERE
# In order to test whether a variable is really a independent or dependent variable
# you will need to run tests testing their correlation. Just because there seems
# to be a relationship doesn't mean that's the cause. Always investigate further.

# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the data set that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# FILL IN WRITTEN ANSWER HERE
# The variable that could possibly be a confounding factor is the temperature in 
# each habitat. This is because maybe some fish prefer a different temperature and
# they gravitate to a certain habitat, directly effecting fish density. 


# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# FILL IN WRITTEN ANSWER HERE
# It is important to consider the number of observations in each group to ensure
# that the data remains unbiased, so that it is a proper reflection of the sample
# population.


# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# FILL IN WRITTEN ANSWER HERE

# the pattern that I found most interesting was the fact that sex almost determined 
# size. Sexual dimorphism, a large fish may be favored by the females and become 
#often selected for.


#### FINAL CHECK ####

# Before submitting, make sure you have:
#
# [ ] Imported the CSV successfully.
# [ ] Included code for exploring the data set.
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

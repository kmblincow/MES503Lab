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

ytsnap <- read.csv("week 3/yellowtail_snapper.csv")


# Take a look at your data.
# Use a function to display the first six rows.

# FILL IN CODE
head(ytsnap)

# How many observations are included in the dataset? 240 obs
# Which variables are categorical? site, habitat, sex
# Which variables are continuous? depth, length, mass, gonadsomatic index, algae cover

# FILL IN WRITTEN ANSWERS HERE
# 240 
# site, habitat, sex
#  depth, length, mass, gonadsomatic index, algae cover, density

# What ecological question do you think this dataset could help investigate?

# If yt snapper on this island prefer a certain depth, temp or habitat based on density data.


# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# depth could be a predictor and fish density could be a response. We could use this data set to see at what depth the fish density is highest/lowest 



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
        aes(x = habitat, fill = habitat)) +
           geom_bar() +
           labs(x = "Habitat", y = "number of observations") + 
           theme_bw()+  
labs(title  = "Number of yt snapper in each habitat type")  +
  scale_fill_manual(values = c("Coral Reef" = "pink", #assign a color to each level
                                "Rubble" = "lightblue",
                                "Seagrass" = "lavender")) +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))
 


# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# coral reef
# rubble
# no
# differences in sample size can effect the reliability, accuracy, and statistical power of comparisons between habitats.



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

ggplot(data = ytsnap, aes(x = habitat, y=length_cm, fill=habitat)) +
  geom_boxplot() +                          
  geom_jitter(width=0.2, color="black") +   
  scale_fill_brewer(palette = "Pastel2") +  
  labs(title = "Distribution of Body Size Across Habitat Types",
       x = "Habitat Type",
       y = "Body Size (cm)") +
  theme_minimal() +                          # Clear and readable theme
  theme(axis.text.x = element_text(angle = 15, hjust = 1))  # Rotate x-axis labels for readability

# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# FILL IN WRITTEN ANSWERS HERE
# coral reef
# seagrass
# no
# no
# I mean not really because the boxplot are relatively close together so we cant conclude that habitat makes a big difference with this alone

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

ggplot(
  data = ytsnap,
  mapping = aes(
    x = length_cm,
    y = gonadosomatic_index,
    color = habitat,
    shape = habitat
  )
) +
  geom_point(size = 3, alpha = 0.7) +
  geom_smooth(
    aes(group = habitat),
    method = "lm",
    se = FALSE
  ) +
  scale_color_manual(
    values = c(
      "Coral Reef" = "darkorange",
      "Rubble" = "cyan4",
      "Seagrass" = "magenta"
    )
  ) +
  scale_shape_manual(
    values = c(
      "Coral Reef" = 16,
      "Rubble" = 17,
      "Seagrass" = 15
    )
  ) +
  labs(
    title = "Relationship Between Body Size and Gonadosomatic Index",
    x = "Body Size (cm)",
    y = "Gonadosomatic Index",
    color = "Habitat",
    shape = "Habitat"
  ) +
  theme_minimal()


# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# FILL IN WRITTEN ANSWERS HERE
# 1 as body size increase so does reproductive output
# 2 positive
# 3 no
# 4 yes because we can see that after about 25 cm reporductive output starst to increase alot


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

# Does the distribution of male and female individuals differ among coral reef, rubble, and seagrass habitats?



# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that ___the distribution of males and females will differ among habitats___ because __different habitats may provide different food resources, shelter, or environmental conditions that could influence where individuals are found.________________________.

# FILL IN YOUR PREDICTION HERE
# I predict that ___the distribution of males and females will differ among habitats___ because __different habitats may provide different food resources, shelter, or environmental conditions that could influence where individuals are found.________________________.


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



ggplot(data = ytsnap, aes(x = habitat, fill = sex)) +
  geom_bar(position = "dodge") +
  facet_wrap(~ site) +
  labs(
    title = "Distribution of Males and Females Across Habitats at Each Reef",
    x = "Habitat Type",
    y = "Number of Individuals",
    fill = "Sex"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

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
#The visualization shows that the distribution of males and females varies among habitat types and
#between North Reef and South Reef. Coral reef and rubble habitats contain both males and females, while seagrass also contains both sexes in the South Reef observations. 
#The number of individuals is not evenly distributed among habitats, with some habitats containing more observations than others. These results generally support my prediction that habitat use may differ between males and females. One possible ecological explanation is that males and females may use different habitats because of
#differences in food availability, shelter, competition, or reproductive behavior. However, because the number of observations differs among habitat and reef groups, the patterns should be interpreted cautiously.
#



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

# 1. Association vs. Causation

#No, observing a relationship between two variables does not mean that one variable causes the other. For example, if the visualization shows that males and females occur in different proportions among habitats, this demonstrates an association between sex and habitat, but it does not prove that habitat causes an individual to be male or female. Other factors, such as body size, food availability, shelter, age, or reproductive behavior, could influence habitat use. Therefore, the relationship observed in the dataset does not establish causation.

# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# FILL IN WRITTEN ANSWER HERE

#Reef location could potentially be a confounding variable in the relationship between habitat and sex. North Reef and South Reef may have different environmental conditions, such as differences in food availability, habitat quality, depth, or other ecological factors. If the proportion of males and females differs between the two reefs, these differences could influence the apparent relationship between sex and habitat. Therefore, reef location should be considered when interpreting the relationship between habitat and sex.

# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# FILL IN WRITTEN ANSWER HERE

#It is important to consider the number of observations in each group because groups with small sample sizes may not accurately represent the overall population. A pattern observed from only a few individuals could be caused by random variation and may not reflect a true ecological pattern. Unequal sample sizes can also make comparisons between groups misleading. Therefore, the number of observations in each habitat and reef should be considered when interpreting the visualization.

# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# FILL IN WRITTEN ANSWER HERE


# One interesting pattern is that the distribution of males and females differs among some habitat types. One possible ecological mechanism is that males and females may have different habitat preferences because of differences in their resource needs or behaviors. For example, one sex may prefer habitats with greater food availability or more shelter, while the other may use habitats that provide better conditions for reproduction. This is a possible hypothesis that could explain the observed pattern, but the dataset alone cannot determine whether this mechanism is responsible.

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

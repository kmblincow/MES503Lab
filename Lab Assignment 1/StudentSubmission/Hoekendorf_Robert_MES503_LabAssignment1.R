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

ytsnap <- read.csv("C:/Users/rober/OneDrive/Desktop/MMES/MES-RMT/MES503LAB/yellowtail_snapper.csv")

# Take a look at your data.
# Use a function to display the first six rows.\
head(ytsnap)
str(ytsnap)
plot(ytsnap)

# How many observations are included in the dataset?
# Which variables are categorical?
# Which variables are continuous?

###############################################################################
# 240 observations of 9 variables, 3 categorical (site, sex, habitat)
# & 6 continuous variables (depth, length, mass, g_index, algae cover, fish_density)


# What ecological question do you think this dataset could help investigate?

# Are depth and the density of Yellowtail Snapper correlated? 

# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# Predictor: Depth (m)
# Response: Fish Density (ind/100m^2)
# Depth can be used to predict density of yt snapper and compared to other factors
# such as habitat or algae_cover

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

ggplot(data = ytsnap, 
       aes(x = habitat, 
           fill = habitat)) +
  geom_bar() +
  geom_text(
    stat = "count",
    aes(label = after_stat(count)),
    vjust = -0.5, #adjusts text display vertically
    size = 3
  ) +
  scale_fill_manual(values = c("Coral Reef" = "pink",
                                "Seagrass" = "lightgreen",
                                "Rubble" = "orange")) +
  theme(plot.title = element_text(hjust = 0.5, face = "bold")) +
  labs(title = "Yellowtail Snapper Counts by Habitat Type", 
       x = "Habitat", 
       y = "Observation Count") + 
  scale_y_continuous(limits = c(0, 125))

# for my own notes, geom_bar() will count for me while geom_col() requires
# and input for the y

# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?

############Answer######################
# 1: Coral Reef has largest sample size, 2: Rubble has smallest sample size
# 3: Sample sizes are not approximately equal as Reef is significantly greater
# than Rubble
# 4: Differences in sample size discourages total sample analysis. Rather
# ratios would be needed. E.g you could not look at total individuals in each 
# habitat showing a certain parameter, it would need to be % of inidivuals in 
# each habitat sampled.
########################################

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
ggplot(data = ytsnap,
       mapping = aes(x = habitat,
                     y = mass_g,
                     color = habitat)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.15) +
  scale_color_manual(values = c("Coral Reef" = "red",
                                "Seagrass" = "darkgreen",
                                "Rubble" = "orange"))+
  labs(x = "Habitat",
       y = "Mass (grams)",
       title = "Yellowtail Snapper Mass by Habitat Type",
       color = "Habitat") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = "right",
        axis.title = element_text(size = 14))



# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# FILL IN WRITTEN ANSWERS HERE
# 1. Coral Reef
# 2. Coral Reef, but it also has the largest sample size
# 3. Yes the distributions overlap
# 4. There are outliers that are much 'heavier' in Reef and Seagrass as well as 
# 5. No I would not say habitat causes differences in body size, it could be 
# correlated but it is not causation

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
ggplot(data = ytsnap,
       mapping = aes(x = mass_g,
                     y = gonadosomatic_index,
                     color = sex)) +
  geom_point(size = 3, alpha = 0.65) +
  geom_smooth(method = "lm", se = TRUE) + # I hope not showing standard error is OK
  scale_color_manual(values = c("Male" = "blue",
                                "Female" = "red")) +
  labs(x = "Mass (g)",
       y = "Gonadosomatic Index (%)",
       title = "Snapper Gonadosomatic Index related to Mass",
       color = "Sex") +
  theme_bw() + 
  theme(plot.title = element_text(hjust = 0.5, face = "bold"), 
        legend.position = "right", 
        axis.title = element_text(size = 12), 
        panel.grid.minor = element_blank()) +
  facet_wrap(~ sex)


# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# FILL IN WRITTEN ANSWERS HERE

#1. I'm not sure about reproductive output but Gonadosomatic index increases as
# mass increases
#2. Positive
#3. There seems to be much higher variance on the male data with individuals that
# have much larger GSI to body weight, and a couple outliers on both sex
# where the GSI is much lower than the trend
#4. Based on purely the visualization it could be a fair assumption if you were
# measuring reproductive output purely on GSI(gonad size by body mass). HOWEVER,
# I would not confidently say so as reproductive output has more factors than
# just gonad size as far as I know.


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


# STEP 1: Do yellowtail snapper prefer to inhabit deeper waters?

# Research Question: Is yellowtail snapper density higher in areas of greater
# depth

# FILL IN YOUR QUESTION HERE

# Is yellowtail snapper density higher in deeper water


# STEP 2: Yellowtail snapper density is greater at depth rather than in shallow

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________________________ because __________________________.

# I predict that fish density of yellowtail snapper is greater in areas
# with greater depth because they feed on small fish and zoo plankton
# which are generally at a maximum where they can benefit from upwelling
# while still being in the photic zone



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
ggplot(data = ytsnap,
       mapping = aes(x = depth_m,
                     y = fish_density,
                     color = habitat)) +
  geom_point(size = 3, alpha = 0.65) +
  geom_smooth(method = "lm", se = TRUE) +
  facet_wrap(~ habitat) +
  labs(x = "Depth (m)",
       y = "Fish Density",
       title = "Relationship Between Yellowtail Snapper Fish Density and Depth",
       color = "Habitat") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.title = element_text(size = 12),
        panel.grid.minor = element_blank())
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

# The trend shown in the graph is a consistent increase in fish density as depth
# increases in all habitats. The results support my prediction that fish density
# would increase as depth increases. There is a recognizable variation in seagrass
# habitats where a few individuals have extremely low surrounding fish density 
# in low depths which could skew the data to have a more aggressive slope of 
# the trend line but it doesn't seem to be skewed when compared over all 3
# habitats. I propose the explanation for this trend is that heterotrophs and
# autotrophs exist in lower densities towards the surface due to lower biomass
# and the 'local maximum' shown in some marine environments occurs between 20-80m
# where autotrophs and heterotrophs can both exist with inputs from upwelling.

# WORK TO BE DONE BB

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
ggplot(data = ytsnap,
       mapping = aes(x = depth_m,
                     y = algae_cover,
                     color = sex)) +
  geom_point(size = 3, alpha = 0.65) +
  geom_smooth(method = "lm", se = TRUE) +
  facet_wrap(~ habitat) +
  labs(x = "Depth (m)",
       y = "algae cover",
       title = "Example Graph for Association vs Causation",
       color = "sex") +
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        axis.title = element_text(size = 12),
        panel.grid.minor = element_blank())

# Observing a relationship (or trend) between two variables does not indicate
# causation, especially when you have a small sample size in relation to 
# the population. For example if you plot algaecover by depth and use male/female
# data to seperate the data you can see differences in algae_cover by depth in the
# male / female samples. However these fish live in the same environment sampled
# and there should be no difference in environment sampled between male/female.


# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# Habitat could influence the relationship between depth and fish density of 
# yellowtail snapper. I tried to examine it in my graph but environmental conditions
# that could be favorable in one habitat at depth could be less favorable in
# another. For example one habitat could be more productive and favorable for 
# the snapper than another so it would have higher densities despite insufficient
# depth



# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# The number of observations should be considered because insufficient sample
# sizes are more likely to produce misleading results or statistical errors 
# Furthermore unequal group sizes in sample visualizations
# could produce trends if confounding
# variables are not accounted for (such as habitat type)


# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# I found it interesting that I wasn't able to find any clear patterns with algae_cover.
# I figured it would be a big driver of optimal habitat or yellowtail size but I
# was unable to find such a relationship. I hypothesize that yellowtail snapper is a
# poor predictor of yellowtail snapper habitat because it is influenced by
# environmental factors not found in this dataset such as food abundance. 


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

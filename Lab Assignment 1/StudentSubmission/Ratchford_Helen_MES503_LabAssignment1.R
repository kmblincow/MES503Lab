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

library(ggplot2) #installs the plot package


# Import your CSV file.
# Update the file path below so that R can find your data.

ytsnap <- read.csv("yellowtail_snapper.csv") #reads the csv file for the yellowtail data while also making it an easily find-able object in the environment calld ytsnap.


# Take a look at your data.
# Use a function to display the first six rows.

head(ytsnap) # shows first five rows of ytsnap.

# How many observations are included in the dataset?
# Which variables are categorical?
# Which variables are continuous?

# There are 240 observations in this dataset. Categorical variables in this dataset are site, habitat, and sex. Continuous variables in this dataset are depth (in meters), length (in centimeters), mass (in grams), gonadosomatic index, algae cover, and fish density.


# What ecological question do you think this dataset could help investigate?

#How does the ratio of males to females, along with total fish density, change across different habitats?


# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# Habitat could be used as a predictor because it is being changed and you can change it in an experiment on purpose. It can also, later and with more data, be used as a predictor for what will happen with the response variable you measure. A potential response variable is length of fish because it can be influenced by another variable like habitat or fish sex. It can be changed continuously depending on another variable and therefore can be a response variable.


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

ggplot(data = ytsnap, aes(x = habitat)) + # makes a plot, uses the data from ytsnap and makes the x-axis be habitat (coral reef, rubble, & seagrass)
         geom_bar(fill = "lightpink", color = "palevioletred") + # makes a bar graph (which doesn't need a y variable), fills each bar in lightpink, and outlines each bar in palevioletred
         labs(title = "Distribution of Yellowtail Observations across Habitats", x = "Habitat Type", y = "Number of Observations") + # makes labels for the title, the x-axis, and the y-axis.
         theme_get() + # This is my favorite background theme.
  theme(plot.title = element_text(hjust = 0.5, face = "bold", color = "palevioletred")) + # this centers the plot title, makes it bold, and colors it palevioletred.
  theme(axis.title.x = element_text(face = "bold", color = "palevioletred"),
    axis.title.y = element_text(face = "bold", color = "palevioletred")) # this makes the x and y axes bold and colors them palevioletred. I used the code for the plot title to do the axis titles as well! I like pink! - Helen

# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# Coral reefs have the largest sample size. Rubble has the smallest sample size. Sample sizes are not very equal among habitats. More samples from one habitat may skew results and give false significant results for one habitat while the others, with less data, could be should insignificant when they are. They just don't have enough information to be able to come to solid conclusions about significance.



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

ggplot(data = ytsnap, aes(x = habitat, y = length_cm)) + 
  geom_boxplot(fill = "lightblue", color = "royalblue") +
  geom_jitter(width = 0.2, size = 1.5, alpha = 0.4, color = "dodgerblue") + # gives some variation in the dots, to see then better
  labs(title = "Comparison of Yellowtail Body Length Across Habitats", x = "Habitat Type", y = "Length of Fish (cm)") + # labels the titles
  theme_get() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", color = "dodgerblue")) +
  theme(axis.title.x = element_text(face = "bold", color = "dodgerblue"),
        axis.title.y = element_text(face = "bold", color = "dodgerblue")) + # adjusts all the titles, bolds them, and makes them dodgerblue.
  theme(legend.position = "none") # makes it so there is no legend


# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# Coral reefs look to have the largest individuals on average. Though it is hard to tell, seagrass appears to have the greatest amount of variation in body size compared to the other two habitats. The distributions definitely overlap among habitats. Some of the seagrass measurements seem unusually smaller than the rest. Plus, it is now very clear that there are way more observations in the coral reef, which may influence where it is in comparison to the other habitats on this plot. Based only on this visual it is likely that certain habitats may cause differences and some may not, meaning that habitat overall does not cause differences in body size. I say this because seagrass and coral reefs are not very different from each other considering the median line; the same goes for rubble and seagrass. However based on the fact that the median line of rubble is below the coral reef bed, there could be some significance.



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


ggplot(data = ytsnap, aes(x = length_cm, y = gonadosomatic_index, color = sex, shape = sex)) + #tells graph that sex will be denoted by different colors and shapes
  geom_point(size = 2.5) + # makes points a bit bigger than normal
  labs(title = "Yellowtail Body Size and Reproductive Output Based on Sex", x = "Length of Fish (cm)", y = "Gonadosomatic Index", color = "Sex", shape = "Sex") +
  scale_color_manual(values = c("Female" = "hotpink","Male" = "dodgerblue")) +
  scale_shape_manual(values = c("Female" = 16, "Male" = 17)) + # denotes actual colors and shapes for female and male fish
  theme_get() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold", color = "palevioletred")) +
  theme(axis.title.x = element_text(face = "bold", color = "palevioletred"),
        axis.title.y = element_text(face = "bold", color = "palevioletred"))

# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# Overall, as body size increases gonadosomatic index, and therefore, reproductive output increase as well.This is similar for both males and females. This seems to be a positive relationship, especially for males. There are some fish that look to be outliers, like the female fish at 40cm. This seems to be a very large fish, but does not have a greater GSI than the other 30cm female fish. I would say that body size could be useful in predicting reproductive output, but in conjunction with other data. For female fish, the correlation is not as strong as males (lots of clumping of points), meaning it could be a good general indicator but could use other data to help strengthen it, like body mass etc. With males there is a stronger correlation (visually, as points are more spread out), and could indicate a stronger positive relationship that could be a good predictor for GSI.



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

# Does varying algae cover affect Yellowtail fish mass in grams?


# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________________________ because __________________________.

# I predict that algae cover will have an effect on fish mass because the algae will negatively affect the community supply of nutrients. Areas with more algae will likely have lower oxygen levels, less food, and limited sunlight. These factors can stunt the growth of the fish or just attract smaller fish overall, leading a negative relationship between fish mass and algae cover.

# STEP 3: CREATE YOUR VISUALIZATION

# Create an appropriate ggplot2 visualization to investigate your question.
#
# Your plot must:
# - use an appropriate geometry;
# - use appropriate variables;
# - have informative axis labels;
# - have an informative title;
# - include at least THREE customization elements from Week 3's lab.

  ggplot(data = ytsnap, aes(x = algae_cover, y = mass_g, color = sex, shape = sex)) +
    geom_point(size = 2.5) + # made the points a little bigger than they were
    labs(title = "Relationship between Yellowtail Body Mass and Algae Cover", x = "Algae Cover (%)", y = "Fish Mass (g)", color = "Sex", shape = "Sex") + # adds both color and shape to the same "Sex" legend
    scale_color_manual(values = c("Female" = "#9FE817","Male" = "#40633D")) + #custom colors I made with a hex code generator
    scale_shape_manual(values = c("Female" = 17, "Male" = 19)) +
    theme_get() +
    theme(plot.title = element_text(hjust = 0.5, face = "bold", color = "forestgreen")) +
    theme(axis.title.x = element_text(face = "bold", color = "forestgreen"),
          axis.title.y = element_text(face = "bold", color = "forestgreen")) +
    theme(legend.position = "right") # put the legend to the right the graph

# STEP 4: INTERPRET YOUR VISUALIZATION
#
# Write a short interpretation of your visualization.
#
# Your interpretation should:
# - describe the major pattern you observe;
# - explain whether the results support your prediction;
# - identify important variation or unusual observations;
# - provide a possible ecological explanation for the pattern.

# Based on my visualization, there is a weak negative correlation between algae cover and fish mass (g). It is negative because as algae cover increases, fish mass decreases. It is week because there is a lot of clumping and not a clear straight line through the points. The pattern is the same for both male and female fish. This data does support my hypothesis, however, it is weak support due to the negative relationship being very close to no effect.There appear to be a few fish that were much bigger or much smaller than other fish but aside from the big variation and slight negative slope of the relationship, there seems to be nothing unusual. It is likely that algae cover does affect fish size but only by a little. Ecologically speaking, there are likely other factors that contribute to nutrients in the water that help to compensate for those taken out of the water by algae. Similarly, fish can move around, unlike corals, so they may be less affected by smothering or light limitation leading to a more even relationship.


#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

#No, just because there is a visual relationship does not always mean that one variable is causing the other. In many cases it could be a coincidence, a correlation of some sort, or there could even be a secret third factor that is affecting the other two variables.In my example from plot #5, there is a weak negative relationship between algae cover and fish body mass. This is just a relationship and despite my potential explanation, we cannot know for sure with statistical tests. The results could be impacted by other factors like depth of the habitat, or a data point not collected in this dataset, like life stage of the fish. Controlling for other factors such as these could show if algae cover actually does have a statistical relationship with Yellowtail body mass.


# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

#Depth (m) could be a confounding factor in the relationship between fish length (cm) and habitat type (see part 3). This factor can affect both of the variables in this part, independently of one another. Shallow habitats tend to include coral reefs, while seagrass and rubble are located (usually) a bit deeper. Meanwhile, at deeper depths there is less food and nutrient presence, as well as more pressure and cold temperatures. These variables are likely to cause smaller fish at deeper depths. Further, more nutrient availability, and less pressure, at shallower depths will likely result in bigger fish. This relationship that depth has independently on each variable in this part, can cause shallower habitats, like reefs, to show bigger fish compared to the other habitats despite the actual effect being by depth and not habitat type.



# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# It is important to consider the number of observations in each group because varying levels of data can skew data to a false conclusion. Having more data in one group and less in the other could increase the error in the smaller group even if a 'relationship' is shown. When comparing groups with uneven observations you may see extreme relationships due to limited observations in one group resulting in chance correlations when there is no actual relationship. On the other hand, real relationships could be missed in these situations as well. This can happen when there isn't enough data in one group to properly show that there is a relationship.

# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

#One pattern I think is interesting is the relationship between gonadosomatic index and length of fish. Further, it is intriguing that according to this graph, this relationship is not influenced by sex.
# Hypothesis: Greater lengths of fish will positively correlate with greater gonadosomatic indexes in Yellowtail fish because bigger body size allows for more energy that can be put towards reproductive purposes. Additionally, there is more space in fish with greater body sizes for gametes, like eggs in females and sperm in males, thereby (potentially) leading to higher gonadosomatic indexes in these fish, compared to smaller fish.


#### FINAL CHECK ####

# Before submitting, make sure you have:
#
# [X] Imported the CSV successfully.
# [X] Included code for exploring the dataset.
# [X] Created all four required visualizations.
# [X] Customized your visualizations.
# [X] Answered all interpretation questions.
# [X] Developed your own ecological question.
# [X] Made a prediction before creating your own visualization.
# [X] Answered all critical-thinking questions.
# [X] Added comments to explain your code.
# [X] Checked that your script runs from beginning to end without errors.
#
# SAVE YOUR SCRIPT AND SUBMIT TO BRIGHTSPACE!

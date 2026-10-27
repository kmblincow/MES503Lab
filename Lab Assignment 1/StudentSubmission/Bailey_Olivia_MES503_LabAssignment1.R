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
# Which variables are categorical?
# Which variables are continuous?

str(ytsnap)
# there are 240 variables
# site, habitat, and sex are categorical 
# depth, length, mass, gonadosomatic index, algae cover, and fish density are continuous 

# What ecological question do you think this dataset could help investigate?

# this data set could help investigate a lot of ecological questions! all this information provides data on yellow tail snapper ecology. it could investigate the difference between male and females, how algae cover may effect habitat selection, habitat selection and site based on fish density, if depth effects their habitat selection, if male and females like to spend time together or not, the maturity of fish and how that may impact some of their preferences based on the gonadosomatic index...


# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# i think that habitat could be used as a predictor and a response could be fish density.I know that fish can be particular of where they like to hang out, often based on food availability and cover/ nooks and crannies to hide in. If there is a more favorable area for these needs, such as a coral reef, there may be a higher density in fish. In less favorable areas, such as perhaps rubble, there may be a lower density in fish. 



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

ggplot(data = ytsnap, mapping = aes(x = habitat, 
                     fill = habitat)) +
  geom_bar() + 
  scale_fill_manual(values = c("Coral Reef" = "coral2",
                                "Rubble" = "darkslategray",
                                "Seagrass" = "darkgreen")) + 
  #I added the colors that I felt represented the different sites best, which will help me grasp the data throughout the project
  labs(x = "Habitat Type",
       y = "Number of Observations",
    title = "YT Snapper Observations per Habitat Type",
    fill= "Habitat Type")+
  theme_bw()+
  theme(plot.title = element_text (face = "bold"),
        legend.position = "bottom", 
        axis.title = element_text(size = 12, face= "bold"),
        panel.grid.minor = element_blank()) 

# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# 1.The coral reef habitat has the largest sample size
# 2.The rubble habitat had the smallest sample size
# 3.The sample sizes are not equal among habitats. 
# 4.Different sample sizes could skew results/ differences between habitats. It is difficult to compare when there are differences in samples, because the group with less samples may not be represented as well and could introduce bias as a group with more samples. 



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
       mapping = aes(x = habitat,
                     y = mass_g,
                     fill = habitat)) + 
  geom_boxplot()+
  geom_jitter(alpha = 0.4)+
  #jitter! I think this good to add to this plot to show the range
  scale_fill_manual(values = c("Rubble" = "darkslategray",
                                "Seagrass" = "darkgreen",  
                                "Coral Reef" = "coral2")) +
  labs (x= "Habitat Type", 
        y = "Body Mass (g)", 
        title = "YT Snapper Size in Different Habitats", 
        fill = "Habitat Type")+
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.position = "bottom", 
        axis.title = element_text(size = 12, face= "bold"),
        panel.grid.minor = element_blank()) 



# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# 1. The coral reef habitat appears to have the largest individuals
# 2. Coral reefs also had the greatest variation in body size. 
# 3. The distrubutions do overlap. 
# 4. The only observation I can see that may skew data is the outlier in the coral reef habitat. It appears as though there was once huge fish they recored, in comparison to the other fish in this study. This outlier may be making the coral reef fish average be much bigger. 
# 5. Based on only my observation, I would say that there is no difference in body size based between habitats. This is because I look to see where the standard error bars lay, and I see they are overlapping with other groups. 



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
       mapping = aes(x = gonadosomatic_index,
                     y = mass_g,
                     color = habitat))+ 
  geom_point()+ 
  geom_smooth(method = "lm") +
  # this is how to add the line and grey bar around the line to fully understand the direction the data is trending in
  scale_color_manual(values = c("Rubble" = "darkslategray",
                               "Seagrass" = "darkgreen",  
                               "Coral Reef" = "coral2")) +
  labs (x= "Gonadosamatic Index", 
        y = "Body Mass (g)", 
        title = "YT Snapper Body Size and Reproductive Output", 
        color = "Habitat Type")+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
      legend.position = "bottom", 
      axis.title = element_text(size = 12, face= "bold"),
      panel.grid.minor = element_blank()) 
# i think a boxplot with jitter is the best way to present this data. A box plot will show the median and range, and a jitter will show how this data would be dispersed. I thought about using a violin plot, but I didnt feel like it the important parts of a data set as well, such as the median and quartiles, to fully understand how the data is spread. 


# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

#1. There appears to be a strong positive linear relationship between gonadosomatic index and body size. 
#2. Positive. What this means is that it appears as body size increases, so does reproductive output. 
#3. There are some outliers, specifically in the coral reef fish, which have a higher body mass
#4. Based on my visualization, I would expect body size to be a good indicator of reproductive output. 



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

# Is there is a relationship between habitat type and the gonadosomatic index?



# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that gonadosomatic index will be highest in coral reef habitat, and lowest in rubble because a high gonadosmatic index could predict readiness to spawn, and fish may want to spawn in areas with a high amount of resources, such as a coral reef, in comparison to an area with a low amount of resources, such as the rubble habiat. 


# STEP 3: CREATE YOUR VISUALIZATION

# Create an appropriate ggplot2 visualization to investigate your question.
#
# Your plot must:
# - use an appropriate geometry;
# - use appropriate variables;
# - have informative axis labels;
# - have an informative title;
# - include at least THREE customization elements from Week 3's lab.

ggplot(data = ytsnap, aes(x = habitat,
                          y = gonadosomatic_index,
                          fill = habitat)) + 
  geom_boxplot()+ 
  geom_jitter(alpha = 0.4, width = 0.15) +
  scale_fill_manual(values = c("Rubble" = "darkslategray",
                                "Seagrass" = "darkgreen",  
                                "Coral Reef" = "coral2")) +
  labs(x = "Habitat Type", y = "Gonadosomatic Index",
       fill = "Habitat Type",
       title = "Reproductive Status of YT Snapper in Different Habitats") + 
  theme_bw() +
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.position = "bottom", 
        axis.title = element_text(size = 12, face= "bold"),
        panel.grid.minor = element_blank()) 



# geom_boxplot()# STEP 4: INTERPRET YOUR VISUALIZATION
#
# Write a short interpretation of your visualization.
#
# Your interpretation should:
# - describe the major pattern you observe;
# - explain whether the results support your prediction;
# - identify important variation or unusual observations;
# - provide a possible ecological explanation for the pattern.

# The coral reef, rubble, and sea grass sights have similar distributions, but the coral reef site does have the highest median gonadosomatic index. I think the coral reef sites have the highest gonadosamtic index, agreeing with my hypothesis, because of the high amount of nutrients and habitability of coral reefs. The coral reef site also had the only outlieers, which were very high, which I think supports my hypothesis as well. The rubble site has the lowest median gonadosomatic index, which also agrees with my hypothesis! I think this is because rubble does not provide the resources fish may want to give their offspring the best chance possible of survival, so therefor, fish with a high gonadosomatic index are not going to rubble sites to reproduce. The sea grass sight interestingly had the widest range. I think this may be because sea grass sights nutrient availability is highly variable, so sometimes if fish are able to find a habitable area for 


#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.
plot(ytsnap)

# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

# Just because there is a relationship between two variables does not mean that one another causes eachother, however, they could be. For example, in this data set, length and mass look to be correlated, but really they are just associated because as a fish gets longer it does get heavier. On the other hand, fish density increases as depth increases, fish density increasing is probably caused by depth increasing in this case.



# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# Depth could be a confounding factor in the reproductive status of fish in coral reef, rubble, and seagrass habitats. Depth probably varies for all of these habitats, and if the yellow tail snapper prefers to spawn in a shallower or deeper area, their gonadosomatic index may change based on what depth they are at. 



# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# The number of observations tells you how powerful your statistic may be. If there are few observations, you may not be representing what is actually going on. The more observations, the more confident once can be when interpreting their visualizations. 



# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# Its interesting to me how much the body sizes vary based on habitat type. Yellow tail snapper body size may be highest in coral reefs due to the abundance of nutrients and hiding structures. 




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

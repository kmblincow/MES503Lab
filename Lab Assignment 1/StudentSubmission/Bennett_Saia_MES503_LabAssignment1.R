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

library(ggplot2) #loads the necessary packages for running this code


# Import your CSV file.
# Update the file path below so that R can find your data.

ytsnap <- read.csv("Week 3/yellowtail_snapper.csv") #assigns the dataset to the phrase "ytsnap"


# Take a look at your data.
# Use a function to display the first six rows.

 head(ytsnap) #gives us the first 6 rows in our dataset


# 1. How many observations are included in the dataset?
# 2. Which variables are categorical?
# 3. Which variables are continuous?

 #Answers
# 1. There are 240 observations 
# 2. site, habitat, and sex
# 3. depth, length, mass, gonadosomatic index, algae cover, fish density


# What ecological question do you think this dataset could help investigate?
 
#Answer:
# How does algae cover relate to yellow-tail snapper density across sites, and how is algae cover associated with reproductive condition as measured by gonadosomatic index?


# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

 #Answers:
# Predictor - Algae Cover
# Response - Fish Density
# This is because we are testing to see if fish density changes (responds) to fluctuations 
# in algae cover




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


 ggplot(data = ytsnap, aes(x = habitat, fill = habitat) )+ #assigns the proper x,y, and habitat categorization to all following code
   geom_bar() + #makes the plot a bar graph
   labs(title = "Number of Yellowtails Per Habitat",
        x = "Habitats", y = "Number of Observations", fill = "Habitats") +  #defines the proper titles for all graph elements
   scale_fill_manual(values = c("Coral Reef" = "coral1",
                                "Rubble" = "darkgoldenrod",
                                "Seagrass" = "olivedrab4")) + #appoints colors to the habitats
   theme_bw() + #start with a clean built-in theme
   theme(plot.title = element_text(hjust = 0.5, face = "bold"), #center + bold the title
         panel.border = element_rect(color = "black", fill = NA, linewidth = 1), # adds a black frame
         legend.position = "none") #takes away the legend



# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# 1. The Coral Reef Habitat
# 2. The Rubble Habitat
# 3. No they are not quite equal, Rubble and Seagrass have the closest sample sizes 
# however, the gaps are still quite wide between sample sizes.
# 4. It can create bias make it harder to distinguish a pattern from random variation between samples.



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

 ggplot(data = ytsnap, aes(x = habitat, y = mass_g, fill = habitat) )+ #assigns the proper x,y, and habitat categorization to all following code
   geom_boxplot() + geom_point() + #makes the graph a boxplot and add points 
   labs(title = "Body Mass Distribution Among Habitats",
        x = "Habitats", y = "Body Mass(g)") + #defines the proper titles for all graph elements
   scale_fill_manual(values = c("Coral Reef" = "coral1",
                                "Rubble" = "darkgoldenrod",
                                "Seagrass" = "olivedrab4")) + #assigns colors to each habitat
   theme_bw() + #start with a clean built-in theme
   theme(panel.border = element_rect(color = "black", fill = NA, linewidth = 1), # adds a black frame
         legend.position = "none") #takes away the legend
 
 
# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# 1. The Coral Reef habitat
# 2. All three habitats seem to have similar variance, however, due to the outlier in and the wide range of sizes in the coral reef habitat I would say the coral reef has the most variance.
# 3. Yes there is overlap.
# 4. The Rubble and Sea grass Habitats seem to have similarly sized fish however, the coral reef habitat fish seem much larger in size.
# 5. No, I would not assume habitat has something to do with size. Visually my first thought would be that there is a correlation given the much larger fish in the coral reef habitat however, after noting the overlap between all three samples I can't conclude that it's habitat affecting distribution or the larger sample size in coral reefs causing the disparity. 



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


 ggplot(data = ytsnap, aes(x = mass_g, y = gonadosomatic_index, color = habitat))+ #assigns the proper x,y, and habitat categorization to all following code
   geom_point() + # adds points to the graph
   labs(title = "Yellowtail Snapper Body Mass and Gonadosomatic Index",
        x = "Body Mass(g)", y = "Gonadosomatic Index", color = "Habitats") + #defines the proper titles for all graph elements
   scale_color_manual(values = c("Coral Reef" = "coral1",
                                "Rubble" = "darkgoldenrod",
                                "Seagrass" = "olivedrab4")) + #assigns colors to each habitat
   theme_bw() + #start with a clean built-in theme
   theme(panel.border = element_rect(color = "black", fill = NA, linewidth = 1),#applies a border
         panel.grid.minor = element_blank())#remove minor grid-lines

 

# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# 1. The relationship seems to be direct and linear. As body mass increases GSI increases
# 2. There is a positive relationship
# 3. There seems to be at least one outlier existing at over 5000 grams.
# 4. I do think that body size would be a good predictor of reproductive output. 
# There is some variability but the majority of points across all three habitats overlap with a 
# relatively continuous positive relationship.



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

# Is body size related to algae cover across habitat sites?



# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________________________ because __________________________.

# I predict that body size and algae cover will have a negative relationship or correlation,
# because algae cover reduce food resources that reef organisms need to grow.  



# STEP 3: CREATE YOUR VISUALIZATION

# Create an appropriate ggplot2 visualization to investigate your question.
#
# Your plot must:
# - use an appropriate geometry;
# - use appropriate variables;
# - have informative axis labels;
# - have an informative title;
# - include at least THREE customization elements from Week 3's lab.
 
 cor.test(ytsnap$algae_cover, ytsnap$mass_g) #does a correlation test 
 ytsnap_cor <- cor.test(ytsnap$algae_cover, ytsnap$mass_g) #assigns correlation test to the phrase "yt_snap"
 
ytsnap_cor$p.value # pull out just the p-value
ytsnap_cor$estimate # pull out just the correlation coefficient

 
  ggplot(data = ytsnap, aes(x = algae_cover, y = mass_g, color = habitat, shape = habitat))+ #assigns the proper x,y, and habitat categorization to all following code
   geom_point(size = 3) + #applies points and changes the size 
   labs(title = paste ("Yellowtail Snapper Body Mass and Algae Cover", 
        paste("r =", round(ytsnap_cor$estimate, 2),
              ", p =", format.pval(ytsnap_cor$p.value, digits = 2, eps = 0.001)), 
        sep = "\n"),
        x = "Algae Cover", y = "Body Mass(g)", color = "Habitats", shape = "Habitats") + #defines the proper titles for all graph elements. I also added a line to the title for the p-value and coefficient and rounded them 
   scale_color_manual(values = c("Coral Reef" = "coral1",
                                 "Rubble" = "darkgoldenrod",
                                 "Seagrass" = "olivedrab4")) + #assigns colors to each habitat
   scale_shape_manual(values = c(20, 18, 20)) + #gives ives each habitat a shape
   theme_bw() + #start with a clean built-in theme
   theme(plot.title = element_text(hjust = 0.5, face = "bold"), #center + bold the title
         panel.border = element_rect(color = "black", fill = NA, linewidth = 1)) # adds a black frame
 

# STEP 4: INTERPRET YOUR VISUALIZATION
#
# Write a short interpretation of your visualization.
#
# Your interpretation should:
# - describe the major pattern you observe;
# - explain whether the results support your prediction;
# - identify important variation or unusual observations;
# - provide a possible ecological explanation for the pattern.

# There does seem to be a slight negative trend for this plot at first glance! However, after a closer look it varies greatly between habitat and there isn't much overlap. Therefore I can assume there is no relationship and my prediction is not supported. Although there is variability among each habitat there are clear boundaries. Based on that observation alone I believe the p-value will be significant, although, I don't anticipate the significance being very high due to variance. Ecologically this non relationship could be explained by that fact that too much algae blocks sunlight and hinders growth along the habitat floor and lowers visibility. This reduces food resources for fish populations in the reef. However, algae cover can also be nutrient rich and strengthen the food web. So to summarize the algae could have equal positive and negative effect on the ecosystem and therefore no direct effect or relationship on body mass. 


#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

# No, observing a relationship between two variables does not mean that one variable causes the other. For example, my visualization examines the relationship between body mass and algae cover. Even if the visualization shows a correlation between these variables, I cannot conclude that algae cover causes differences in body mass. Other factors, such as habitat, depth, food availability, or fish age, could influence body mass and algae cover. Therefore, it is important not to state that algae cover is a driving factor of body mass based only on an observed relationship. Further exploration would be needed to determine whether algae cover has a causal effect on body mass.



# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.


#In the graph, "Yellowtail Snapper Body Mass and Algae Cover" habitat could be a confounding factor. Considering organisms need food to grow larger the difference between habitats observed in the graph could be attributed to resource abundance, so if there is easier or more abundant resources in the coral reef habitat that may be why theyy are larger that the other habitats.  



# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# This is because a larger sample size might be more representative of the population while a smaller sample size is highly susceptible to variability and skew due to outliers when observing patterns. 

# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# In the “Yellowtail Snapper Body Mass and Gonadosomatic Index Visualization,” I found it interesting that body mass and gonadosomatic index appeared to have a positive correlation. One possible ecological mechanism is that larger yellowtail snapper may have more energy available to invest in reproduction, resulting in larger gonads relative to their body size. This could mean that as yellowtail snapper grow and have greater access to food and energy, they may be able to allocate more resources toward reproduction. However, this is only a hypothesis, and other factors such as age, season, food availability, or environmental conditions could also influence gonadosomatic index.



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

 
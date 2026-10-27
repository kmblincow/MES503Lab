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

ytsnap <- read.csv("Wk 3/yellowtail_snapper.csv")


# Take a look at your data.
# Use a function to display the first six rows.

head(ytsnap)
str(ytsnap) # gives a summary of dataset and the type of data in dataset

# How many observations are included in the dataset? 
# Which variables are categorical?
# Which variables are continuous? 

# There are 240 observations in this dataset
# The categorical variables are site, habitat and sex
# The continuous variables are depth, mass, algal cover, fish density and 
#       gonadosomatic index


# What ecological question do you think this dataset could help investigate?

#  Fish density is usually associated with high coral cover and lower algal cover
# With the general decline in coral abundance and increase in algal cover 
# due to increasing temperatures and nutrient output, does it impact fish 
# density. 


# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# Algal cover as a predictor and fish density as a response. Does Fish density is 
# usually associated with high coral cover and lower algal cover. With coral
# cover declining and algal cover increasing, does it impact fish aggregation?


#### PART 2: VISUALIZATION 1 — DESCRIBE THE DATA ####

# RESEARCH QUESTION:
# How are observations distributed among sampling sites?


# Create a visualization showing the number of observations from each habitat type.
#

# Your plot should:
# - use an appropriate ggplot2 geom;
# - clearly identify the habitats;
# - have informative axis labels;
# - include an informative title;
# - include at least TWO customization elements from Week 3's lab.

ggplot(data= ytsnap, aes(x= habitat,fill= habitat))+
  geom_bar()+ 
  scale_fill_manual(values = c("Seagrass"= "lightgreen", 
                               "Coral Reef"= "coral1", 
                               "Rubble"= "cadetblue"))+
  #scale_fill_manual allows you to manually assign colors to the variables
  # that you want to single out. If this was a scatter plot I
  # I would use scale_color_manual and change fill= "Habitat Types" to 
  # color= "Habitat Types"
  labs(x= "Habitat Type",y= "Number of Observations", fill= "Habitat Type", 
       title = "Sample Sizes (n) of Various Habitat Types")+
    #labels the axes,legend, and title 
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
                                  legend.position = "right")
    #plot.title is used to adjust the font size and the positioning
    # of the legend on the figure
    #scale_fill_manual allows you to manually assign colors to the variables
    # that you want to single out. If this was a scatter plot I
    # I would use scale_color_manual and change fill= "Habitat Types" to 
    # color= "Habitat Types"
  
# INTERPRETATION
#
# 1. Which habitat has the largest sample size? 
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# 1. Coral Reef has the largest sample size
# 2. Rubble has the smallest sample size
# 3. No, they are not equal, they each have different sample sizes
# 4. It will impact the accuracy of your data because there is more variation.



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

ggplot(data= ytsnap, aes(x= habitat,y= mass_g, fill= habitat))+
  geom_boxplot()+ 
  scale_fill_manual(values = c("Seagrass"= "green", 
                               "Coral Reef"= "coral1", 
                               "Rubble"= "cadetblue"))+
    labs(x= "Habitat Type",y= "Fish Weight (g)", fill= "Habitat Type", 
         title = "Yellowtail Weight Distributions Among Different Habitats")+
  
  geom_jitter(alpha= .10, height= 0, width = .1)+
    theme_bw()+
    theme(plot.title = element_text(hjust = 0.5, face = "bold"),
          legend.position = "right",
          axis.title = element_text(size = 11))
  #adjusts font size on axis#shows the points on the graph
  #and spreads them out on the plot, alpha adjusts the
  # transperency and height/ weight adjust whether the points are
   # moving horizontally or vertically

# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# 1. Coral reefs appears to have larger individuals
# 2. There was more variation in coral reefs habitats 
#     (more points distributed along the y axis)
# 3. Yes there is overlap among all of the habitats
# 4. There is one outlier in the coral reef habitat that is more than 5000g 
#   which can skew the data and have influence on the mean
#   (it can make it look like the average is larger than it actually is 
#    in the natural population)
# 5. No, since they all intersect/overlap, there is no significant 
#    difference in fish weights across different habitats


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

#plot(ytsnap$gonadosomatic_index,ytsnap$mass_g)
#plot(ytsnap$gonadosomatic_index,ytsnap$length_cm)

# I used the plot function to get a quick visual of the relationship
# between the gonadosomatic index and mass and length to see if one is more 
# useful than the other. But they both are relatively similar

ggplot(data= ytsnap, aes(x= length_cm,y= gonadosomatic_index, color = sex))+
geom_point()+ 
  scale_color_manual(values = c("Male"= "navy", 
                                "Female"= "red"))+
  labs(x= "Length (cm)",y= "Gonadosomatic Index", color= "Sex", 
       title = "The Reproductive Output of Male and Female Yellowtail Snapper in 
       Relation to their Total Mass")+
  theme_bw()+
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.position = "bottom",
        axis.title = element_text(size = 9))
 
cor.test(ytsnap$length_cm,ytsnap$gonadosomatic_index)
# used to find the correlation value to confirm that there is a relationship
# and if its positive or negative. I got r= 0.521, so its a strong
# positive relationship


# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# 1.There is a positive relationship between body size and reproductive output,
#    as the mass increases the reproductive output increases as well. Neither 
#    of the variables drives the other, but they are correlated. 
# 2.It is Positive
# 3.There are a couple outliers. In the females,there is a data point where the 
#   the individual was very large, but had a relatively "low" reproductive output,
#   almost as if there is a cap or limit for female output. While there was 
#   more variability and spread in the males, the female reproductive output
#   didn't pass 3.5. 
# 4. Yes, size is a good predictor of reproductive output, because there is a 
#    strong correlation between the two variables, specifically length and 
#     and reproductive output. The plot shows a trend, as length increases, 
#     the fish tends to have a higher reproductive output. Using this 
#    information, you can link size to sexually maturity. 
#    You can predict that the smaller fish will have low reproductive output,
#    while bigger fish will have a higher output. It also tells you that larger 
#    females will likely have a lower output than large males because they have 
#    a cap.
#   Size is a good indicator and with more research you could potentially
#    link size with the age of a fish. And managers can use this to regulate the 
#    harvest of juveniles or older/ larger fish that tend have higher 
#    reproductive outputs

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

# Does algal cover influence fish abundance

# Is there an association between fish abundance and algal cover 
#  across different habitats?


# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________ because ______________

# I predict that there will be a negative relationship with fish density and
# algal cover because fish density will decrease as algal cover increases.

# STEP 3: CREATE YOUR VISUALIZATION

# Create an appropriate ggplot2 visualization to investigate your question.
#
# Your plot must:
# - use an appropriate geometry;
# - use appropriate variables;
# - have informative axis labels;
# - have an informative title;
# - include at least THREE customization elements from Week 3's lab.

cor.test(ytsnap$fish_density,ytsnap$algae_cover, method = "pearson")
# ran a pearson correlation test to confirm and get a corelation and p-value
ytsnap_alagae_fish_density<-cor.test(ytsnap$fish_density,ytsnap$algae_cover,                                     method= "pearson")
ytsnap_alagae_fish_density$estimate
ytsnap_alagae_fish_density$p.value
# r= 0.0326, p= 0.6146
#assign a name to cor.test, then extracted the correlation value and p-value

ggplot(data= ytsnap, aes(x= fish_density,
                         y= algae_cover, 
                         color = habitat))+
  geom_point(size= 2, alpha= .7)+ 
  scale_color_manual(values = c("Seagrass"= "green",
                                "Coral Reef"= "coral1",
                                "Rubble"="cadetblue"))+
  labs(x= "Fish Density",y= "Algal Cover", color= "Habitat Type", 
       title = "The Relationship between Fish Abundance and Algal Cover Across
       Different Habitats") +
       annotate("text", x= 30, y= 85, label= "r = 0.03, p = 0.61", 
                  color= "black", size= 3)+ # add text to plot
  theme_classic()+
  theme(plot.title = element_text(hjust = 0.5, face = "bold"),
        legend.position = "right",
        axis.title = element_text(size = 11))
  

# STEP 4: INTERPRET YOUR VISUALIZATION
#
# Write a short interpretation of your visualization.
#
# Your interpretation should:
# - describe the major pattern you observe;
# - explain whether the results support your prediction;
# - identify important variation or unusual observations;
# - provide a possible ecological explanation for the pattern.

# There are no major patterns, the points are completely scattered which tells
# us that there is no correlation and no relationship between Fish density and 
# algae coverage. I would accept the null hypothesis that there is no relationship,
# which does not support my prediction that it would have a negative correlation.
# I thought it would impact abundance because fish usually prefer "healthy"
# reefs, which is usually characterized as having less algal cover. But this data
# shows that whether algal cover is high or low, it doesn't impact their abundance.

#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

# No, observing a relationship between two variables do not mean that one causes
# the other, it is just noting that there is an association. There are other 
# confounding factors that could influence the variables. For example, after
# using the plot() function, I noticed there was a positive relationship bewteen
# depth and fish density. This tells us that there were higher populations of 
# yellowtail in deeper water. However, that doesn't mean we can conclude that they
# prefer deeper water or if that is always the case. This data could have been 
# collected during a spawning seasons where snapper species are known to aggregate
# and move to deeper water. In order to say that one variable drives the other
# it would be better to do a controlled experiment where you can elimiante outside 
# factors.


# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# As stated before, seasonality or time of the year the data was collected
# could be a confounding factor. This could influence there density, the sex ratio,
# as well depth and reproductive output. It would likely show higher densities of fish
# at deeper depths because of aggregations. It could impact the ratio of males to females
# it may have more of one sex than it would naturally have in a community because
# of spawning habits. 



# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# It is important to consider the sample size because having too much variance 
# or a small sample size can skew the data. This can cause us to draw incorrect
# conclusion about the natural population. For example, in this dataset,
# they collected more samples from coral reef habitats than seagrass and rubble.
# While this can be a reflection of the natural population and the fish may prefer 
# coral reef habitats over others, it could also be a coincidence. If that was the 
# case the data may be skewed in the favor of the coral reef habitats. 
# Also in general,having a small sample size or too much variance can lead to 
# a Type II error, where you state that there is no relationship when in reality 
# there is. 


# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# I found that the figure showing the reproductive output for males and females 
# in relation to their size to be the most interesting. The trend seems to support
# the hypothesis that both in both males and females, as they get bigger, their 
# reproductive output increases. But I found it interesting that the males 
# seemed like they could have a higher reproductive output than the females.
# The females reproductive output tapered off at 3.5 while the males had more
# variation in their outputs. This pattern shows us that there is a potential
# difference in female reproductive patterns to men. Its possible that females
# have a lower reproductive output because more energy is expended to produce eggs
# than it is for sperm. 




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

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


ytsnap <- read.csv("Lab assignment 1/yellowtail_snapper.csv")
#create an object "ytsnap" of yellowtail_snapper.csv from folder "Lab assignment 1"


# Take a look at your data.
# Use a function to display the first six rows.

# FILL IN CODE

head(ytsnap)
#head pulls first 6 rows of yellowtail_snapper.csv, now object ytsnap

# How many observations are included in the dataset? 
# Which variables are categorical?
# Which variables are continuous?

# FILL IN WRITTEN ANSWERS HERE
# 240 observations
# Site,habitat,sex
#depth,mass,length,gonadsomatic index, algae cover, fish density

# What ecological question do you think this dataset could help investigate?

# FILL IN WRITTEN ANSWER HERE
#What factors influence yellowtail snapper size and density?


# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

# FILL IN WRITTEN ANSWER HERE
#Algae cover may influence fish density, fish eat algae




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

ggplot(data=ytsnap,aes(x=habitat, fill=site))+
  geom_bar()+ #create bar graph
  labs(x="Habitat Type",y="Fish Density",title="Yellowtail Snapper Density by Habitat Type")+
  #add labels to axes and title
  scale_color_manual(values=c("North Reef"="red","South Reef"="blue3",
                              "Fringing Reef"="coral","Patch Reef"="magenta"))+
  #fill bars by site
  theme_bw()+ #change theme
  theme(plot.title = element_text(hjust = 0.5, face = "bold"))#bold title and center


# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


# FILL IN WRITTEN ANSWERS HERE
# 1. Coral Reef
# 2. Rubble
# 3. No
# 4. It may skew the data to one habitat type (coral reefs)


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
ggplot(data=ytsnap,mapping=aes(x=habitat, y=length_cm, fill=habitat))+
  geom_boxplot()+ #create boxplot
  labs(x="Habitat Type",y="Fish Body Size(cm)",title="Yellowtail Snapper Size in Different Habitats",
       fill="Habitat")+ #add labels to axes, title, and legend
  scale_fill_manual(values=c("Coral Reef"="plum4","Rubble"="lightgreen","Seagrass"="lightsalmon1"))+
  #color boxplot by habitat type
    theme_bw()+ theme(legend.position = "bottom")#change theme and move legend to bottom


# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

# FILL IN WRITTEN ANSWERS HERE
# 1.Coral reef
# 2.Seagrass
# 3.Yes, around 26 cm
# 4.Yes, Seagrass habitat has an observation at ~5cm
# 5.No, each habitat has overlap and roughly fits a range of 20-30 cm


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
ggplot(data=ytsnap,mapping=aes(x=length_cm,y=gonadosomatic_index,color=sex))+ #create scatter plot
  geom_point(size = 2, alpha = 0.3)+ #change plot size and transparency
  labs(x="Fish Size(cm)",y="Gonadosomatic Index",color="Sex",
       title="Yellowtail Snapper Size and Gonadosomatic Index")+ #add labels to axes, title, legend
  scale_color_manual(values=c("Male"="cornflowerblue","Female"="deeppink"))
#color by sex

# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.

# FILL IN WRITTEN ANSWERS HERE
# 1.A correlated positive relationship
# 2.Positive
# 3.No
# 4.Yes, most data fall within similar ranges and the relationship looks to be positive and linear


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
#How does algae cover influence Yellowtail Snapper size?


# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________________________ because __________________________.

# FILL IN YOUR PREDICTION HERE
# I predict that sites with higher algal cover will have larger fish because fish eat algae


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
ggplot(data=ytsnap,mapping=aes(x=algae_cover,y=length_cm,color=habitat))+ 
  geom_point(alpha=0.4,size=2)+#create scatter plot, change point size and transparency
labs(x="Algal Cover",y="Fish Size(cm)",color="Habitat Type",
     title="Yellowtail Snapper Size and Algal Cover in Various Habitats")+#add labels
scale_color_manual(values=c("Rubble"="orange1","Coral Reef"="royalblue1","Seagrass"="seagreen2"))+
  #color points by habitat type
  theme_bw()+ 
  theme(plot.title = element_text(face = "bold"), #bold title
                    legend.position = "bottom", #legend on bottom
                    axis.title = element_text(size = 12))#change axes text size

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
#Fish size is negatively impacted by algae cover.Data fall within a similar range with no
#unusal observations or outliers. There is overlap between habitat type. Yellowtail snapper 
#utilize ecological structures like reefs or rocks to hide and use in other ways. Algae tend to
#outcompete everything around it, so where there is more algae there are less fish as they have
#fewer spaces to live and fewer nutrients available.


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

#No. In the case of habitat type and fish size, it can be assumed that all habitats will have a 
#similar size of fish while the algal cover and fish size visualization demonstrates that 
#there is a range in fish size throughout habitats, influenced by other factors.

# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

# FILL IN WRITTEN ANSWER HERE
#Sex can be a confounding factor. On the fish size and gonadosomatic index visualization, larger
#fish tend to have a larger gonadosomatic index.But,even larger females have a smaller gonadosomatic
#index than males (see 40 cm female observation w/ gonadosomatic index of 3.5). And males that are
#about 30-35 cm long have the highest gonadosomatic indexes.

# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

# FILL IN WRITTEN ANSWER HERE

#A larger sample size may incorrectly reflect stronger or weaker relationships because there is
#more data to interpret which may lead to more plots.

# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

# FILL IN WRITTEN ANSWER HERE
#I find the relationship between habitat type and fish size interesting.Habitat type may influence
#fish density but other factors like sex and algae cover may better influence fish size.



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

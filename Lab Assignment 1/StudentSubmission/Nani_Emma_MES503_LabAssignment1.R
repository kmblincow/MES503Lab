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

ytsnap <- read.csv("Week4/yellowtail_snapper.csv")


# Take a look at your data.
# Use a function to display the first six rows.

head(ytsnap)

# How many observations are included in the dataset?
# Which variables are categorical?
# Which variables are continuous?

    # 240 observations are within the dataset
    # The categorical variables are site, habitat, and sex
    # The continuous variables are depth_m, length_cm, mass_g,       gonadosomatic_index, algae_cover, and fish_density
    

# What ecological question do you think this dataset could help investigate?

    # How do environmental characteristics of sites influence the population structure of yellowtail snappers



# Identify one variable that could potentially be used as a predictor
# and one variable that could be used as a response.
# Explain your reasoning.

      # Predictor variable: habitat
      # Response variable: fish_density
      # I chose these two because a species may have a preference for a habitat that it likes most. The habitat stays constant either being coral, rubble, or seagrass, but the fish density may change based on preferences. Using the fish_density variable and comparing it with different habitats, we can see whether yellowtail snapper has a certain preference for coral, rubble, or seagrass. 







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

      # customization elements from week3 lab --> custom colors and bold/aligned title

ggplot(ytsnap, aes(x = habitat, fill = habitat)) +
         geom_bar() +
            labs(x = "Habitat", 
                 y = "Observation Count", 
                 title = "Habitat Type Observations of Yellowtail Snapper", 
                  fill = "Habitat Type") +
          theme_bw() +
          theme(plot.title = element_text(hjust = 0.5, face = "bold")) +
          scale_fill_manual(values = c("orange", "darkblue", "lightgreen"))


# INTERPRETATION
#
# 1. Which habitat has the largest sample size?
# 2. Which habitat has the smallest sample size?
# 3. Are sample sizes approximately equal among habitats?
# 4. How might differences in sample size influence your ability to compare habitats?


      # 1. The coral reef habitat has the largest sample size
      # 2. The rubble habitat has the smallest sample size
      # 3. Sample sizes are not equal across habitats
      # 4. Since there isn't equal representation across habitats, it introduces bias towards the coral reef habitat. Coral reef habitats have a much higher observation count than rubble or seagrass.











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


      # customization elements --> custom colors, bold/aligned title, facet wrap by habitat


ggplot(ytsnap, aes(x = habitat, y = length_cm, fill = habitat)) +
    geom_boxplot() +
    geom_jitter(alpha = 0.4) +
    labs(x = "Habitat Type", 
         y = "Fish Body Length (cm)", 
         title = "Fish Body Length by Habitat Type") +
    theme(legend.position = "none", 
          plot.title = element_text(hjust = 0.5, face = "bold")) +
    scale_fill_manual(values = c("orange", "lightblue", "lightgreen")) +
    facet_wrap(~ habitat, scales = "free_x")
  


# INTERPRETATION
#
# 1. Which habitat appears to have the largest individuals on average?
# 2. Which habitat shows the greatest amount of variation in body size?
# 3. Do the distributions overlap among habitats?
# 4. Are there any observations that appear unusual or potentially influential?
# 5. Based only on your visualization, would you conclude that habitat causes
#    differences in body size? Why or why not?

      # 1. The coral habitat has the largest individuals on average
      # 2. The seagrass habitat seems to have the greatest amount of variation in body size only because of the outliers towards the bottom and large whiskers
      # 3. The distributions overlap among all three habitats
      # 4. The coral reef habitat has an outlier around 40cm that may influence the upper whisker. Seagrass also has outliers around a length of 5cm that could be pulling down the median
      # 5. I would not conclude that the habitats cause differences in body size because the whiskers overlap between the habitats and because the coral reef habitat has a difference in sample size which could bias the data.










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



      # customization elements --> bold/aligned title and p-value

# run correlation test between variables
ytsnap_cor <- cor.test(ytsnap$length_cm, ytsnap$gonadosomatic_index, 
                       method = "pearson")

# check p-value
ytsnap_cor$p.value


# Plot Part 4 
ggplot(ytsnap, aes(gonadosomatic_index, length_cm, color = sex)) +
      geom_point() +
      geom_smooth(method = "lm") +
      labs(x = "Gonadosomatic Index", 
           y = "Fish Length (cm)",
           title = paste("Body Size and Gonadosomatic Index by Fish Sex" ,
                          ", p =", format.pval(ytsnap_cor$p.value, 
                            digits = 2, eps = 0.001))) +
      theme_bw() +
      theme(plot.title = element_text(hjust = 0.5, face = "bold"))


# INTERPRETATION
#
# 1. Describe the overall relationship between body size and reproductive output.
# 2. Does the relationship appear positive, negative, or absent?
# 3. Are there any unusual observations or potential outliers?
# 4. Based on your visualization, would you expect body size to be a useful
#    predictor of reproductive output? Explain your reasoning.



      # 1. There is a strong positive linear relationship between body size and reproductive output between both sexes. As fish get larger, their gonadosomatic index increases.
      # 2. The relationship is positive for both sexes.
      # 3. The observations seem to stop for the females once they reach a gonadosomatic index of ~3.6, while the males have gonadosomatic indexes as large at ~4.9 on the right end of the graph.
      # 4. I would expect body size to be a good indicator of reproductive output since there's a strong positive linear trend for both sexes and is statistically significant with a p-value of <0.001. Especially since fish  reach an age of sexual maturity which correlates with fish size.






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
      # How does fish density change across coral, seagrass, and rubble habitats?


# STEP 2: MAKE A PREDICTION

# Before creating your visualization, make a prediction.

# Prediction:
# I predict that __________________________ because __________________________.

      # I predict that the coral habitats will have the highest density because coral reefs house the most physical structure and prey that yellowtail snappers feed on. 


# STEP 3: CREATE YOUR VISUALIZATION

# Create an appropriate ggplot2 visualization to investigate your question.
#
# Your plot must:
# - use an appropriate geometry;
# - use appropriate variables;
# - have informative axis labels;
# - have an informative title;
# - include at least THREE customization elements from Week 3's lab.

      # customization elements from week 3 --> custom colors, alpha, removed legend


# violin plot
ggplot(ytsnap, aes(habitat, fish_density, fill = habitat)) +
      geom_violin() + 
      geom_boxplot(width = 0.1, color = "navy", alpha = 0.3) +  #added boxplot
      labs(x = "Habitat", 
           y = "Fish Density", 
           title = "Fish Density by Habitat", 
           fill = "Habitat") +
      scale_fill_manual(values = c("lightpink", "violet", "lightblue")) +
      theme_bw() +
      theme(legend.position = "none")



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
      # In my visualization, I found that the distribution of fish density across habitats seems to be relatively similar to one another. I overlaid a boxplot on top of the violin plots for each habitat to observe the median and found little variation. Rubble has the highest median and the most even density distribution while seagrass and coral reef begin to taper off at around 25. The coral habitat actually had the highest frequency at a low density compared to coral and seagrass, disproving my hypothesis. Although rubble had the most even distribution, there were no fish density's past 34 while coral and seagrass had maximums at 38-39. Based on this plot and other exploratory plots, I found that algae cover is very low in coral reefs compared to rubble and seagrass which may be the cause of why fish density isn't higher in reefs. 




#### PART 6: CRITICAL THINKING ####

# Answer each question in complete sentences.


# 1. ASSOCIATION VS. CAUSATION
#
# One or more of your visualizations may show a relationship between two variables.
# Does observing a relationship between two variables mean that one variable
# causes the other?
#
# Use an example from this dataset to explain your answer.

      # Observing a relationship between two variables does not mean that one variable causes another. Oftentimes there are biological factors that coincide and may initially appear as a relationship. We saw this in the body size and gonadosomatic index plot where length and gonadosomatic index had a positive linear relationship. Fish length itself doesn't necessarily cause gonadosomatic index to increase, but as a fish matures into adulthood, it weighs more and gets bigger as it reaches sexual maturity, causing the gonadosomatic index to increase since that equation is based upon weight of the gonads and weight of the fish. 


# 2. CONFOUNDING VARIABLES
#
# Identify one variable in the dataset that could potentially confound one of
# the relationships you investigated.
#
# Explain how this variable could influence the relationship you observed.

      # Gonadosomatic index is measured by weight of the gonads and mass of the fish. This could be a confounding variable because there may be sexual dimorphism, creating a GSI that isn't taking the two sexes into account. In the plot with GSI and fish length, I had to color by sex so that the relationship could be more clear. Otherwise, without specifying the sex, it looked like a weak positive relationship. 


# 3. SAMPLE SIZE
#
# Why is it important to consider the number of observations represented in each
# group when interpreting your visualizations?

      # It is important to consider the number of observations represented in each group because there may be bias which creates results that are not necessarily true. There is an uneven number of habitat type observations with coral reef being the highest and rubble being almost half of the reef observations influencing the results. 


# 4. ECOLOGICAL MECHANISMS
#
# Choose one pattern from your visualizations that you find particularly
# interesting.
#
# What ecological mechanism could potentially explain this pattern?
#
# Your explanation should be a hypothesis rather than a claim that you have proven.

      # I hypothesize that in the fish body length vs habitat type plot, the coral reef habitat has the largest average body lengths because reefs have the most abundance of food and shelter, thus the fish can grow larger. 



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

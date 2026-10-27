# MES 503 -ANOVA in R
# Kayla Blincow
# 9/29/2026

# ANOVA IN R
# The purpose of this script is to demonstrate how to perform an ANOVA in R.
# This is meant to accompany the lecture material related to one-way ANOVAs.

# clear my workspace
rm(list = ls())

# load packages
library(tidyverse)
library(car) # Levene's Test function is in this package (you might need to install)

# SCENARIO: 
# We have been told by local harvesters that land crabs grow bigger depending on
# where they are found on the island. We want to see if this is true. We go out 
# to three of the most used areas for capturing land crabs (West End, Magens Bay,
# Compass Point), capture 10 crabs each, and measure them.


# load data (update file path based on your own computer file organization)
crabs <- read.csv("Week 7/crabdata.csv")


####STEP 1: GET TO KNOW THE DATA####
# What is the first thing you do in any analysis???
# VISUALIZE YOUR DATA
# WRITE CODE HERE
ggplot(crabs, aes(x = CaptureLocation, y = CarapaceLength,
              fill = CaptureLocation)) +
  geom_boxplot(width = 0.1) +
  geom_jitter(alpha = 0.5, width = 0.1) +
  geom_violin(alpha = 0.2) +
  theme_bw() +
  theme(legend.position = "none")

# What are you expectations regarding whether there are differences in crab size
# across sites?

####STEP 2: CREATE THE MODEL OBJECT####

# format: modelobject <- aov(Response ~ Explanatory, data = dataobject)
#WRITE CODE HERE
m1 <- aov(CarapaceLength ~ CaptureLocation, data = crabs)


####STEP 3: CHECK THE ASSUMPTIONS####
#check assumptions visually
#WRITE CODE HERE
plot(m1)

# What do you make of the diagnostic plots?



# How would I statistically test for normality?
# What is your null hypothesis?
#WRITE CODE HERE
shapiro.test(residuals(m1))

# Do we statistically meet the assumption of normality?

# There is a function to statistically test the assumption of equal variance in
# ANOVAs as well: Levene's Test. This is a very conservative test, so ALWAYS 
# pair this test with diagnostic plots.

# Null hypothesis: The group variances are approximately equal.
leveneTest(m1)

####STEP 4: EVALUATE THE MODEL SUMMARY####

#How do we look at the summary of our model object?
#WRITE CODE HERE
summary(m1)

#What do you make of the output? 



####STEP 5: POST HOC TEST####

# We can run a Tukey's HSD test to determine where the differences in crab size
# lie across sites.

?TukeyHSD() 

#What do we need to type to run the Tukey's test?
#WRITE CODE HERE
TukeyHSD(m1)

# What do you make of the results?


####STEP 6: VISUALIZE DATA WITH MODEL RESULTS####

# Create a ggplot that displays the data and uses letters to signify significant
# differences between groups.

#WRITE CODE HERE
ggplot(crabs, aes(x = CaptureLocation, y = CarapaceLength,
                  fill = CaptureLocation)) +
  geom_boxplot(width = 0.1) +
  geom_jitter(alpha = 0.5, width = 0.1) +
  geom_violin(alpha = 0.2) +
  annotate("text", label = "a", x = c(1, 2), y = c(14, 14)) +
  annotate("text", label = "b", x = 3, y = 25) +
  theme_bw() +
  theme(legend.position = "none")

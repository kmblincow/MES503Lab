# MES 503 Week 2 Lab - Intro to R Projects & More Data Viz
# This script includes a coding exercise designed to build your understanding of 
# how to use ggplot2 to create data visualizations.

# Created by Kayla Blincow 8/25/2026
#------------------------------------------------------------------------------



####INTRODUCTION####

# In an exceptionally dense island population of Hermann's tortoises in Lake 
# Prespa in North Macedonia, sexually coercive males dramatically overnumber 
# females, inflict severe copulatory injuries and put them at risk of fatal falls 
# from the island plateau's sheer rock faces. Harassed females are emaciated, 
# reproduce less frequently, produce smaller clutches and have lower annual 
# survival rates compared to females from a neighbouring mainland population. 
# Sixteen years of capture-recapture data reveal an ongoing extinction event and 
# predict that the last island female will die in 2083.

# Data from Arsovski et al. (2026) Ecology Letters



# BEFORE WE GET STARTED...

# What is your current working directory?
getwd()



####SET UP MY SCRIPT####

#load my packages (it's good practice to load all the packages you will be using
# in your script at the beginning)
library(ggplot2) #our data viz package

#load my data (from csv file saved on your computer)
#NOTE! YOU WILL HAVE TO UPDATE THE FILE PATH (THING IN QUOTES) TO WHATEVER YOUR 
#FILE STRUCTURE IS ON YOUR COMPUTER STARTING FROM YOUR WORKING DIRECTORY!!!!!
clutch_size <- read.csv("Week 2/clutch_size_cleaned.csv")

#take a look at our data
# How would we look at the first six rows of our newly uploaded dataframe?

####FILL IN CODE HERE####
head(clutch_size)

####LET'S CREATE SOME VISUALS####

# Our goal is to view our data to set up our expectations of what we think 
# statistical analysis will reveal regarding the following questions:

# 1. How many individuals from each locality are represented in these data?
# 2. Which locality has the oldest tortoise individuals on average?
# 3. Which locality has the largest tortoise individuals on average?
# 4. Do older individuals tend to have larger clutch sizes?
# 5. Do larger individuals tend to have larger clutch sizes?

# I'll help you get started with the first question...
# 1. How mnay individuals from each locality are represented in these data?
ggplot(data = clutch_size, aes(x = locality, fill = locality)) +
  geom_bar() +
  labs(x = "Locality", y = "Tortoise Count") + #what's this do?
  theme_bw()  #what's this do?
  

#Some follow up questions...
# How do you think I could match my legend title to the x axis label?
# How might the sample sizes from the different localities influence my analysis?


# Let's work through the second question together...
# 2. Which locality has the oldest tortoise individuals on average?

####FILL IN CODE HERE####
ggplot(data = clutch_size, aes(x = locality, y = age)) +
  geom_boxplot() +
  geom_jitter(width = 0.05, height = 0, alpha = 0.5, size = 2) +
  theme_bw()

ggplot(data = clutch_size, aes(x = locality, y = age)) +
  geom_violin()

ggplot(data = clutch_size, aes(x = locality, y = age, fill = locality)) +
  geom_violin(alpha = 0.2) +
  geom_jitter(width = 0.05, height = 0, alpha = 0.5, size = 2) +
  theme_bw()

#Some follow up questions...
# 

# You should work independently or in pairs to try to create visuals that
# address the final three questions.

# 3. Which locality has the largest tortoise individuals on average?
ggplot(data = clutch_size, aes(x = locality, y = body_mass_grams, fill = locality)) +
  geom_boxplot() +
  geom_jitter(width = 0.05, height = 0, alpha = 0.5, size = 2) +
  theme_bw()

ggplot(data = clutch_size, aes(x = locality, y = straight_carapace_length_mm, fill = locality)) +
  geom_boxplot() +
  geom_jitter(width = 0.05, height = 0, alpha = 0.5, size = 2) +
  theme_bw()


# 4. Do older individuals tend to have larger clutch sizes?
ggplot(data = clutch_size, aes(x = age, y = eggs, color = locality)) +
  geom_point() +
  geom_smooth(method = "lm")

# 5. Do larger individuals tend to have larger clutch sizes?
ggplot(data = clutch_size, aes(x = body_mass_grams, y = eggs, color = locality)) +
  geom_point() 

ggplot(data = clutch_size, aes(x = straight_carapace_length_mm, y = eggs, color = locality)) +
  geom_point() 

# Follow up questions:
# Can you identify a potential confounding factor if you were trying to see if
# locality predicts clutch size?

# If you were to choose between age and body mass as a predictor for clutch size
# which one would you select? Why?

# Can you think of a way to combine body mass and carapace length into a single 
# metric?

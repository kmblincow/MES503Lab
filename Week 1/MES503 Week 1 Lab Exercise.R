# MES 503 Week 1 Lab - Intro to R & Making Your First Visualization
# This script includes a coding exercise designed to introduce you to the 
# R/RStudio coding environment and explore how we can use code to generate 
# data visualizations.

# Created by Kayla Blincow 8/18/2026
#------------------------------------------------------------------------------


####INTRODUCTION####

# Welcome to R and RStudio!

#Some things to know:
# - this is an R script file! It's a way for you to write/edit code without 
#   running it
# - hashtags create "comments", this is basically a mechanism for you to write
#   notes. Whatever is written after a hashtag will not be executed if you "run"
#   your script file.
# - YOU SHOULD COMMENT EARLY AND OFTEN!
# - to "run" code, you can hit the "Run" button above or hit Crtl+Enter (PC) or 
#   Cmd + Return (Mac)

# Let's try running our first bit of code! Move your cursor to the line below 
# and run it!
1+1


# What happened?
#WRITE NOTES HERE

# Let's try another one...
"I love St. Thomas!"

# What happened?
#WRITE NOTES HERE

#Let's try another one...
I love St. Thomas!

# What happened?
#WRITE NOTES HERE

# Let's try running multiple lines at once! Highlight all the lines below and 
# run them!
apple <- 2
pear <- 5
apple + pear

# What happened?
#WRITE NOTES HERE


# Let's try running code the uses and function.
sample(1:10, 3, replace = FALSE)

# What happened?
#WRITE NOTES HERE

# If you wanted to store your randomly generated three numbers what might you do?
#WRITE CODE/NOTES HERE


# We will continue exploring the fucntionality of R throughout the semester, but 
# for your first introduction I want you to do something a little more fun...




####YOUR FIRST DATA VISUALIZATION####

# load necessary packages
# install.packages("ggplot2")
library(ggplot2)
#install.packages("palmerpenguins")
library(palmerpenguins)

# create an object to house our data
peng <- penguins

# look at the first six rows of the data
head(peng)

# Thoughts? What do the columns mean? What variables are being measured? Is there
# a relationship you'd like to explore?

# The code below creates a visual that will show us the relationship between 
# flipper length and body mass by species. Spend some time looking at the code 
# and draw what you think the resulting plot will look like before running it.

#create our visualization using ggplot2
ggplot( #call the ggplot function to create a plot
  data = penguins, #specify the object containing our data
  mapping = #tell ggplot which parts of our data we want to use
    aes(x = flipper_length_mm, #put flipper length on the x axis
        y = body_mass_g, #put body mass on the y axis
        color = species)) + #color elements by species
  geom_point() #tell R we want to plot points (scatterplot)

# YOUR TURN
# Adjust the code below to create a plot that shows the relationship between 
# bill length and body mass by species.
# (HINT: You might want to refer back to your column names to ensure you are
# inputting the right variable names, and don't forget about commas!)

ggplot(data = #FILLMEIN
         mapping = aes(x = #FILLMEIN
                         y = #FILLMEIN
                         color = #FILLMEIN
         )) +
  geom_point()

# Based on your plots, do you think flipper length or bill length is better at
# predicting body mass? Which species do you think is the largest on average?
#WRITE YOUR ANSWER HERE


####More ggplot2 use cases####
# Run the code in this section to see how visualizations can help us get answers 
# to research questions related to the penguins data set.

# *Research Question: What is the distribution of bill depth measurements?*
  
# We can use a histogram to plot distributions of numerical variables. Notice we 
# only need to provide an x variable, as the histogram by default will plot the 
# count of observations on the y axis.

# Spend some time looking at the code below and draw what you think the 
# resulting plot will look like before running it.

ggplot(data = penguins, #use the ggplot function to make a plot and specify our data
       mapping = aes(x = bill_length_mm)) + #put bill length on the x axis
  geom_histogram() #make the plot a histogram

# We see a roughly bi-modal distribution of bill lengths across the entire data 
# set, with peaks around 38-42 mm and 45-50 mm.



# *Research Question: How does the body mass of penguins differ across islands?*

# We can use a box plot or violin plot to look for differences across categorical 
# variables.

# Spend some time looking at the code below and draw what you think the 
# resulting plots will look like before running it.

ggplot(data = penguins, #use the ggplot function to make a plot and specify our data
       mapping = aes(x = island, #put island on the x axis
                     y = body_mass_g)) + #put body mass on the y axis
  geom_boxplot() #make the plot a boxplot



ggplot(data = penguins, #use the ggplot function to make a plot and specify our data
       mapping = aes(x = island, #put island on the x axis
                     y = body_mass_g)) + #put body mass on the y axis
  geom_violin() #make the plot a violin plot

# Both of these plots show us that Biscoe Island has penguins with higher body 
# mass on average.



# *Research Question: Is the relative distribution of bill length and flipper 
# length across species conserved across both variables?*
  
# We can layer multiple geoms to get more insight into our data, as seen below.
# Notice we are also adding an argument for "color" in the aes() to specify we 
# want our geom elements to be colored based on species.

# Spend some time looking at the code below and draw what you think the 
# resulting plots will look like before running it.

ggplot(data = penguins,
       mapping = aes(x = bill_length_mm,
                     y = flipper_length_mm,
                     color = species)) + #add color element
  geom_point() + #add points
  geom_rug() #add lines along x and y axes showing distribution of points

# We see that flipper length is consistently highest for Gentoo penguins, but 
# the highest bill lengths are shared by Gentoo and Chinstrap penguins. Adelie
# penguins are consistently smallest for both morphometrics.






####FINAL EXERCISE####
# Create three visualizations addressing the following research questions:
#   
#   - Which island has the most Gentoo penguins?
#   - Do males have larger body mass on average than females?
#   - Is the relative distribution of bill length and bill depth of 
#     species conserved across both variables?
# 
# HINT: You might need to explore some other geom options, see https://r-graph-gallery.com/ggplot2-package.html

# MES 503 Week 4 Lab - Introduction to Data Wrangling
# This script includes a coding exercise designed to introduce you to
# data wrangling in R. We will learn how to find specific observations
# and variables within a dataset using both base R and the dplyr package.

# Created by Kayla Blincow 9/4/2026

# ------------------------------------------------------------------------------

#### INTRODUCTION

# So far, we have used R to import data and create visualizations.
# But what happens when the dataset contains hundreds or thousands of
# observations and we only want to look at a specific subset of the data?

# This is where DATA WRANGLING comes in!

# Data wrangling is the process of transforming, organizing, and
# extracting information from a dataset so that it is easier to analyze.

# Today we will learn how to:
# - Index specific observations
# - Filter rows based on conditions
# - Select specific columns
# - Arrange (sort) observations

# We will learn how to do these things using:

# 1. BASE R
# 2. dplyr

# There are often multiple ways to accomplish the same task in R.
# Learning both approaches will help you understand how R works and
# will make you more flexible as a programmer.

#### SET UP OUR SCRIPT

# Load the packages we will use

library(dplyr)

# We will use a hypothetical dataset containing observations of reef fish
# collected from several reefs in the Caribbean.

# Each row represents one fish.

# Variables include:
# reef          = reef where the fish was sampled
# species       = fish species
# habitat       = habitat type
# depth_m       = sampling depth in meters
# length_cm     = fish length in centimeters
# mass_g        = fish mass in grams
# sex           = sex of the fish
# grazing_rate  = estimated grazing rate


# First, create our dataset.
# Think about the code below, do you understand what's going on here?

fish <- data.frame(
  fish_id = 1:20,
  reef = c("Reef A", "Reef A", "Reef A", "Reef A", "Reef B",
           "Reef B", "Reef B", "Reef B", "Reef C", "Reef C",
           "Reef C", "Reef C", "Reef D", "Reef D", "Reef D",
           "Reef D", "Reef E", "Reef E", "Reef E", "Reef E"),
  species = c("Parrotfish", "Parrotfish", "Surgeonfish", "Wrasse",
              "Parrotfish", "Surgeonfish", "Parrotfish", "Wrasse",
              "Surgeonfish", "Parrotfish", "Wrasse", "Parrotfish",
              "Parrotfish", "Surgeonfish", "Wrasse", "Parrotfish",
              "Surgeonfish", "Parrotfish", "Wrasse", "Surgeonfish"),
  habitat = c("Reef", "Seagrass", "Reef", "Reef",
              "Reef", "Seagrass", "Mangrove", "Reef",
              "Reef", "Seagrass", "Reef", "Mangrove",
              "Reef", "Reef", "Seagrass", "Mangrove",
              "Reef", "Seagrass", "Reef", "Mangrove"),
  depth_m = c(8, 3, 12, 15, 6, 4, 2, 10, 18, 5,
              14, 3, 9, 16, 6, 2, 20, 4, 11, 3),
  length_cm = c(22.4, 18.7, 19.5, 14.2, 25.1, 21.3, 16.8, 13.9,
                23.7, 20.5, 15.6, 17.9, 27.3, 22.1, 16.4, 19.8,
                24.6, 21.7, 14.8, 20.9),
  mass_g = c(410, 275, 320, 180, 485, 365, 230, 165,
             445, 350, 210, 295, 540, 390, 225, 310,
             460, 370, 195, 355),
  sex = c("Female", "Male", "Female", "Male", "Female",
          "Male", "Female", "Female", "Male", "Female",
          "Male", "Female", "Female", "Male", "Female",
          "Male", "Female", "Male", "Female", "Male"),
  grazing_rate = c(8.2, 6.5, 5.9, 3.1, 9.4, 7.2, 4.8, 3.5,
                   6.8, 8.1, 4.2, 5.6, 10.2, 7.4, 4.5, 6.3,
                   7.8, 8.6, 3.9, 7.1)
)

# Take a look at our data
head(fish)
str(fish)

# What do you notice about the structure of this dataset?
# WRITE YOUR NOTES HERE

# How many rows are in the dataset?
nrow(fish)

# How many columns are in the dataset?
ncol(fish)

# What are the names of the columns?
names(fish)

# WRITE YOUR ANSWERS HERE




#### PART 1: INDEXING DATA USING BASE R

# One of the most fundamental skills in R is INDEXING.
# Indexing means telling R exactly which part of an object you want.
# For data frames, we can use square brackets:

# data[row, column]

# The first position specifies the ROW.
# The second position specifies the COLUMN.

# For example:
# fish[1, 2]
# means: "Give me row 1, column 2."

# Let's try it!
fish[1, 2]

# What information did R return?
# WRITE YOUR ANSWER HERE

# We can also specify both the row and column using their names.
fish[1, "species"]
# This gives us the species recorded for the first fish.

# We can select an entire row by leaving the column position blank.
fish[1, ]

# We can select an entire column by leaving the row position blank.
fish[, "species"]

# We can also use the column number.
fish[, 3]

# What variable is column 3?
# WRITE YOUR ANSWER HERE

# We can select multiple rows.
fish[1:5, ]

# And we can select multiple columns.
fish[, 2:4]

# We can combine both.
fish[1:5, 2:4]

# Take a moment to think about what the following code will return BEFORE you 
# run it.
fish[6:10, c("species", "length_cm", "mass_g")]

# What did this code return?
# WRITE YOUR ANSWER HERE

#### YOUR TURN

# Use BASE R indexing to answer the following questions.
# 1. What species is fish number 12?

#### FILL IN CODE HERE

# 2. What is the length of fish number 8?

#### FILL IN CODE HERE

# 3. What are the reef, habitat, and depth of fish number 15?

#### FILL IN CODE HERE

# 4. Display the first five fish, but only show their species, length, and mass.

#### FILL IN CODE HERE




#### PART 2: FILTERING ROWS USING BASE R

# Indexing becomes especially powerful when we combine it with logical conditions.
# For example, suppose we only want to look at fish longer than 20 cm.
# We can create a logical statement:

fish$length_cm > 20
# R returns TRUE or FALSE for every observation.

# TRUE means the observation meets our condition.
# FALSE means it does not.

# We can use this logical vector to subset our data.
fish[fish$length_cm > 20, ]

# Read this code from the inside out:
# fish$length_cm > 20 asks which fish are longer than 20 cm.
# fish[ ... , ] then returns the rows where the condition is TRUE.

# We can use other comparison operators too:
# >   greater than
# <   less than
# >=  greater than or equal to
# <=  less than or equal to
# ==  exactly equal to
# !=  not equal to

# For example, fish sampled deeper than 10 meters:
fish[fish$depth_m > 10, ]

# Or fish belonging to the Parrotfish species:
fish[fish$species == "Parrotfish", ]

# Notice that we use == rather than =
# = is generally used to assign values to arguments.
# == asks whether two things are equal.

#### YOUR TURN

# 1. Find all fish that are less than 5 meters deep.

#### FILL IN CODE HERE

# 2. Find all fish that belong to Reef C.

#### FILL IN CODE HERE




#### PART 3: FILTERING WITH MULTIPLE CONDITIONS

# What if we want to apply more than one condition?
# We can use:
# &   means AND
# |   means OR

# For example, suppose we want fish that are: longer than 20 cm AND heavier than 400 g
fish[fish$length_cm > 20 & fish$mass_g > 400, ]
# Both conditions must be TRUE.

# Now suppose we want fish that are: from Reef A OR from Reef B
fish[fish$reef == "Reef A" | fish$reef == "Reef B", ]
# Only one of the conditions needs to be TRUE.

#### YOUR TURN

# Find all fish that:
# 1. Are longer than 20 cm AND are female.

#### FILL IN CODE HERE

# 2. Are from Reef A OR Reef E.

#### FILL IN CODE HERE

# 3. Are deeper than 10 m AND have a grazing rate greater than 6.

#### FILL IN CODE HERE


#### PART 4: SELECTING COLUMNS WITH BASE R

# We have already seen how to select columns using square brackets.
# For example:
fish[, c("reef", "species", "length_cm")]

# This is useful when we only want to work with a subset of variables.

# We can also remove columns by using a negative sign.
# For example, the following removes the fish_id column:
fish[, -1]

# Or we can remove multiple columns:
fish[, -c(1, 7)]

# This removes columns 1 and 7.

#### YOUR TURN

# 1. Display only the species, habitat, and grazing_rate columns.

#### FILL IN CODE HERE

# 2. Display all columns except fish_id and sex.

#### FILL IN CODE HERE



#### PART 5: INTRODUCING dplyr

# We have now used BASE R to:
# - Select rows
# - Filter rows
# - Select columns

# These operations are extremely important.
# But you may have noticed that some of the code becomes difficult to read as 
# our questions become more complicated.

# The dplyr package provides functions designed specifically for
# manipulating data frames.

# The three functions we will learn today are:
# filter()   = select rows based on conditions
# select()   = select columns
# arrange()  = sort rows


# These functions are part of the "tidyverse" approach to working with data in R.
# (so is ggplot 2)

#### FILTERING WITH dplyr

# Let's repeat one of our previous questions:
# Which fish are longer than 20 cm?
filter(fish, length_cm > 20)

# Compare this to our base R version:
fish[fish$length_cm > 20, ]

# Both approaches give us the same basic result.

# The dplyr syntax can become easier to read as our analyses get
# more complicated.
# Multiple conditions are also straightforward.
filter(fish, length_cm > 20 & mass_g > 400)

# We can also use OR:
filter(fish, reef == "Reef A" | reef == "Reef B")

#### YOUR TURN

# Repeat the following questions using filter().
# 1. Which fish are less than 5 meters deep?

#### FILL IN CODE HERE

# 2. Which fish are female?

#### FILL IN CODE HERE

# 3. Which fish are longer than 20 cm AND heavier than 400 g?

#### FILL IN CODE HERE





#### SELECTING COLUMNS WITH dplyr

# The select() function allows us to choose columns.
select(fish, reef, species, length_cm)

# Notice that we do not need to use quotation marks around the column names.
# We can also select columns that are next to one another.
select(fish, reef:depth_m)

# We can remove columns by using a minus sign.
select(fish, -fish_id)

#### YOUR TURN

# 1. Select reef, habitat, length_cm, and mass_g.

#### FILL IN CODE HERE

# 2. Select only species, sex, and grazing_rate.

#### FILL IN CODE HERE

# 3. Remove fish_id and depth_m.

#### FILL IN CODE HERE




#### PART 6: ARRANGING DATA

# Another common data-wrangling task is SORTING our observations.

# In dplyr, we use arrange().
# For example, let's arrange our fish from shortest to longest.
arrange(fish, length_cm)
# The smallest fish should now appear at the top.

# We can arrange from largest to smallest using desc():
arrange(fish, desc(length_cm))

# We can also arrange by more than one variable.
# For example, sort first by reef and then by body length:
arrange(fish, reef, length_cm)

# R sorts by the first variable, then uses the second variable to sort 
# observations within the first variable.

#### YOUR TURN

# 1. Arrange the fish from smallest to largest by mass.

#### FILL IN CODE HERE

# 2. Arrange the fish from deepest to shallowest.

#### FILL IN CODE HERE

# 3. Arrange the fish first by species and then from largest to

# smallest body mass.

#### FILL IN CODE HERE




#### PART 7: COMBINING dplyr FUNCTIONS

# One of the most useful features of dplyr is that we can combine multiple operations.

# For example, suppose our research question is:
# "Which large parrotfish were found at depths greater than 5 m?"
# We can use filter() to identify the fish we want and select() to show only the
# variables that matter.
filter(fish,
       species == "Parrotfish",
       length_cm > 20,
       depth_m > 5)

# Notice that filter() allows us to separate multiple conditions with commas.
# This is another way of saying that ALL of the conditions must be TRUE.

# We can then use select() after filter():
select(
  filter(fish,
         species == "Parrotfish",
         length_cm > 20,
         depth_m > 5),
  fish_id, reef, depth_m, length_cm, mass_g
)

# This works, but it is starting to become difficult to read.



#### INTRODUCING THE PIPE: |>

# R provides a useful operator called the PIPE: |>
# The pipe takes the result from one function and passes it into the next function.
# You can think of it as meaning "and then"

# For example:
fish |>
  filter(species == "Parrotfish",
         length_cm > 20,
         depth_m > 5) |>
  select(fish_id, reef, depth_m, length_cm, mass_g)

# Read this from top to bottom:
# Start with fish
# ↓ AND THEN
# Filter for parrotfish longer than 20 cm and deeper than 5 m
# ↓ AND THEN
# Select the variables we want to see

# This way of writing code is extremely common in modern R.
# It allows us to write our data-wrangling workflow almost like a series of instructions.

# We can also arrange the resulting data.
fish |>
  filter(species == "Parrotfish") |>
  select(fish_id, reef, length_cm, mass_g) |>
  arrange(desc(mass_g))

# This asks:
# 1. Start with the fish dataset.
# AND THEN
# 2. Keep only parrotfish.
# AND THEN
# 3. Keep only the selected columns.
# AND THEN
# 4. Sort from largest to smallest.

#### YOUR TURN

# Use a combination of filter(), select(), arrange(), and |> to
# answer the following questions.

# RESEARCH QUESTION 1:
# Which female fish are longer than 20 cm?

# Your final result should show:
# fish_id
# reef
# species
# length_cm
# mass_g

#### FILL IN CODE HERE

# RESEARCH QUESTION 2:
# Which fish were found deeper than 10 m and had a grazing rate greater than 6?
# Arrange your results from highest to lowest grazing rate.
# Your final result should show:
# fish_id
# reef
# species
# depth_m
# grazing_rate

#### FILL IN CODE HERE

# RESEARCH QUESTION 3:
# Which parrotfish were found in seagrass habitat?
# Arrange the results from largest to smallest body mass.
# Your final result should show:
# fish_id
# reef
# habitat
# length_cm
# mass_g

#### FILL IN CODE HERE


#### PART 8: BASE R vs. dplyr

# We have now learned that there are often multiple ways to accomplish
# the same task in R.
# The goal is NOT to memorize every possible way of doing something.

# Instead, the important thing is to understand the underlying task:

# "I want these rows."

# "I want these columns."

# "I want these observations sorted this way."

# If you are unsure where to begin when you are coding try saying what you want
# in words, then translating that into code based on the skills we are learning.

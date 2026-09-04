# MES 503 Week 4 Lab Exercise - Cracking the Data Code
# This script includes a coding exercise designed to test your the data wrangling
# skills we covered in lab.

# Created by Kayla Blincow 9/4/2026

# ------------------------------------------------------------------------------



# A surprise awaits you behind the barrier of the pass code at this website:
# https://kaylablincow.shinyapps.io/CrackingTheDataCode/

# Break into 3-4 groups and work together to complete the data wrangling 
# exercises below to learn the passcode and find out the surprise.

# The first group to crack the code gets a prize!



#load the data (update with your file path)
crack <- read.csv("YOURFILEPATHHERE/crackingthedatacode.csv")



# Task 1: Sort the dataframe alphabetically in reverse based on the yel column,
# then isolate only the yel column, and extract the data in the first row. Assign
# the resulting data to an object called "pw1".

# ENTER CODE HERE TO ACCOMPLISH THE TASK
  

# Task 2: Find the twenty-fourth element in the names of the dataset columns.
# Assign the resulting data to an object called "pw2".

# ENTER CODE HERE TO ACCOMPLISH THE TASK
  
  
# Task 3: Select rows where blu6 column is 826 and the pura column is 652 then 
# find the value in the blu column. Assign the resulting data to an object 
# called "pw3".

# ENTER CODE HERE TO ACCOMPLISH THE TASK
  

# Task 4: Find the value recorded in the 787th row and the 30th column.
# Assign the resulting data to an object called "pw4".

# ENTER CODE HERE TO ACCOMPLISH THE TASK


# Task 5: Filter so the reta column is at least 0.75 , the sew14 column is at most 
# 100, the ret14 column is less than -1, the yel8 column is "lec", and the blu6 
# column doesn't exceed 500. Divide the value of the blua column by 3.
# Assign the resulting data to an object called "pw5".

# ENTER CODE HERE TO ACCOMPLISH THE TASK
  
  
  
# if you successfully completed the tasks above, the code below should give you
# the passcode
paste(pw1, pw2, pw3, pw4, pw5, sep = "")

# if you crack the code before everyone else, don't tell them what happens!
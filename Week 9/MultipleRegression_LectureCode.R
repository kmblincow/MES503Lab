#Kayla Blincow
#3/12/2023

#Multiple Regression Example

#The purpose of this script is to carry out the regression analyses covered in the
#MES504 Multiple Linear Regression Lecture.

#Scenario:
#We are fisheries biologists that are interested in learning more about the sea
#cucumber fishery in Indonesia, the world’s top producer of cukes. In particular, 
#we are interested in testing how a suite of variables influence catch per unit
#effort in cuke fisheries. 

#Our variables of interest are: depth, length of time fisher has been engaged in 
#the fishery, fisher experience metric, region


#We will begin by doing a simple linear regression, then exploring further by 
#adding more variables as we go along.




#clear my workspace
rm(list = ls())

#load packages
library(tidyverse)
library(sjPlot)
library(visreg)
library(car)


#generate data
# set.seed(1)
# 
# cpue <- runif(50, 0, 100)
# duration <- cpue/5 + rnorm(50, 10, 3)
# 
# cukes <- data.frame(
#   cpue = cpue,
#   depth = round(-cpue + 75 + rnorm(50, 50, 25)),
#   duration = round(duration),
#   experience = round(duration/2.5 + rnorm(50, 0, 0.5)),
#   fisherID = sample(1:1000, 50)
# )
# 
# cukes <- arrange(cukes, cpue) %>% 
#   mutate(region = c(rep("Sumatra", 10), rep(c("Java", "Sulawesi"), 10),
#                                rep(c("Papua", "Maluku"), 10)),)
# 
# 
# write.csv(cukes, "Week9_MultipleRegression/cukes.csv")


#load data
cukes <- read.csv("Week9_MultipleRegression/cukes.csv")

#remove weird bonus column
cukes <- cukes[,-1]


#you should all the regular things to scope your data :)



#alrighty! Let's do the thing!

#let's start by doing a simple linear regression to test the effect of depth on
#CPUE!

#always start by visualizing your data!
plot(cukes$cpue~cukes$depth)
#same as
plot(cukes$depth, cukes$cpue)

#build the model
cuke_simple <- lm(cpue ~ depth, data = cukes)

#how do I visually check my assumptions?
plot(cuke_simple)

#take a look at our model
summary(cuke_simple)

#plot our results
ggplot(cukes, aes(x = depth, y = cpue)) + geom_point() + 
  geom_smooth(method = "lm")
       

#Now let's go through the process of doing a multiple linear regression by adding
#experience and duration into the model

#visualize the data
plot(cukes$duration, cukes$cpue)
plot(cukes$experience, cukes$cpue)

#check for collinearity
cor(cukes[,2:4])
plot(cukes[,2:4])

#Duration and experience are really highly correlated, so we are going to remove
#one of them from consideration for the model. 

#Since they basically measure the same thing, it doesn't really matter, but we
#are going to select the duration variable to stick around.

cukes_mult1 <- lm(cpue ~ depth + duration, data = cukes)

#finish checking assumptions
plot(cukes_mult1)

#look at model summary
summary(cukes_mult1)

#plot model results
visreg(cukes_mult1)


#Now let's try adding a categorical variable by including region
#visualize the data
plot(as.factor(cukes$region), cukes$cpue, xlab = "Region", ylab = "CPUE")

cukes_mult2 <- lm(cpue ~ depth + duration + region, data = cukes)

#check assumptions
plot(cukes_mult2)

#check model summary
summary(cukes_mult2)

#check for overall effect of region
car::Anova(cukes_mult2)

#plot model results
visreg(cukes_mult2)


#Alright! Final Thing!

#Let's try adding an interaction... Let's say that we think duration
#interacts with region. Because some regions are associated with more marine
#related trades. Even if you haven't been in the fishery for a long time, if
#you are from these regions, you are probably pretty good at catching cukes.

#visualize the data
ggplot(cukes, aes(x = duration, y = cpue, color = region)) +
  geom_point()

cukes$region <- factor(cukes$region)
cukes_int <- lm(cpue ~ depth + duration + region + duration*region, data = cukes)

#check assumptions
plot(cukes_int)

#look at model summary
summary(cukes_int)

#that's weird!

#visualize model results using plot_model in sjPlot package
plot_model(cukes_int, type = "int") #plot interaction effects
plot_model(cukes_int, type = "eff") #plot main effects


#model selection
AIC(cuke_simple, cukes_mult1, cukes_mult2, cukes_int)
#our third model has the lowest AIC value (cukes_mult2)
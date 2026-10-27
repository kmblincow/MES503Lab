#Kayla Blincow
#10/20/2026

#ANCOVA Example

#The purpose of this script is to carry out the ANCOVA analyses covered in the
#MES504 ANCOVA Lecture.

#Scenario:
# We are researchers studying two cricket species, Oecanthus exclamationis and
# Oecanthus niveus. We want to see if the pulse rates of their songs are 
# different, because we suspect that females of the different species identify 
# mates based on pulse rate. However, song pulses are known to be affected by 
# temperature.


#clear your workspace
rm(list=ls())

#load packages
library(tidyverse)
library(performance) # will likely need to install this one
library(car)
library(emmeans) # will likely need to install this one
library(effectsize) # will likely need to install this one

# Import the  data:
crickets <- read.csv("UPDATE FILE PATH!!!/crickets.csv")


# Now let's take a look at the data:
glimpse(crickets)

#Set Species as factor
crickets$Sp <- as.factor(crickets$Sp)

# Quick Boxplot of the Pulse Rate by Species
plot(Pulse ~ Sp, data=crickets)

# Prettier Boxplot of the Pulse Rate by Species
ggplot(data = crickets, aes(x = Sp, y = Pulse)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.5) +
  labs(x = "Species", y = "Pulse Rate (Beats/min)") +
  theme_bw()


# Scatterplot of Pulse versus Temperature for both Species. 
ggplot() + 
  geom_point(aes(x=Temp,y=Pulse,colour=Sp), data=crickets)+ 
  labs(y = "Pulse Rate (Beats/min)", x = "Temperature (Deg. C)",
       color = "Species") + theme_bw()


####DO THE ANCOVA!####

# First, we need to check our assumptions...
# Extra assumption of ANCOVA is that there is homogeneity of slopes. We can test
# this sassumption to see if there is an interaction effect. The interaction term
# should NOT be statistically significant.
interaction <- aov(Pulse ~ Temp*Sp, data = crickets)
summary(interaction)

# Is there a significant interaction effect?


# Let's build the model we will actually be working with so we can check the 
# rest of the assumptions.

# When doing an ANCOVA you should put the continuous covariate BEFORE the categorical
# group. This ensure the variance explained by the covariate is removed before
# testing the group effect.






# Build the model
ancovamodel <- aov(Pulse ~ Temp + Sp, data = crickets)

# Check rest of the assumptions
plot(ancovamodel) # traditional way
check_model(ancovamodel) # using the performance package
# Assumptions look okay.

# If you wanted to check homogeneity of variance you could do Levene Test on
# ANOVA without the temperature covariate.
car::leveneTest(Pulse~Sp, data = crickets)
# What do you think?


# Take a look at our model....
# If you have an equal sample size among groups we can just use the aov() model.
# If you have unequal sample size among groups, you should use Anova(modelobject) from the
# car package, so you can specify a type III ANOVA (which adjusts how the sum
# of squares is calculated to account for unbalanced design).

# Do we have equal sample size across our groups?
# Look at the summary output of the ANCOVA model
ancovaTypeIII <- Anova(ancovamodel, type = "III")

# Compare summaries
summary(ancovamodel)
ancovaTypeIII

# Notice the difference in the sum of squares of Temperature. Type III only 
# credits variables only with what they explain after accounting for the other 
# variable (species). This a little in the weeds, but your results might change
# substantially if you have an unbalanced design.

# Regardless of how you calculate it, this tells us that there is an effect of
# species after we account for the effect of temperature.


# How do we quantify the difference between species? 
# 
# Take a look at the adjusted means (aka estimated marginal means). These are 
# the mean pulse rates of each species at the mean temperature value.
emm_species <- emmeans(ancovamodel, ~Sp) 
# These are what you should plot if you are going to plot a visual just comparing
# the species.


# Test for a pairwise significant difference
# Essentially run a Tukey's test with the adjust means (means accounting for the
# covariate). This is typically more relevant if you have more than two groups.
pairs(emm_species)


# Calculate effect size (eta squared) - a value > 0.14 would be big. 
eta_squared(ancovamodel, partial = T)

# Roughly 87% of the variance not explained by temperature is explained by species.


#REPORTING RESULTS

#Methods: We used an ANCOVA to test whether the species impacted pulse rates after
# adjusting for temperature.

#Results: There was a significant effect of species. Oe had significantly higher 
# pulse rates than On  while accounting for the covariate of temperature 
# (F(1, 28) = 187.4, p < 0.001, partial eta-squared = 0.87; Adjusted means: Oe =
# 78.4 [77.4, 79.5], On = 68.3 [67.4, 69.3]; Figure 1). 


# Plot marginal means (think about what this code is doing...)
ggplot() +
  geom_jitter(data = crickets, aes(x = Sp, y = Pulse),
              height = 0, width = 0.25, alpha = 0.5) +
  geom_point(data = as.data.frame(emm_species), aes(x = Sp, y = emmean),
             color = "purple3", size = 3) +
  geom_errorbar(data = as.data.frame(emm_species), 
                aes(x = Sp, ymin = lower.CL, ymax = upper.CL),
                width = 0.1, color = "purple3") +
  theme_bw()
  
# what if we plotted the unadjusted means?
  
  

  
  


  
  
unadjusted <- crickets |> group_by(Sp) |> 
  summarize(mean = mean(Pulse),
            lower.CL = mean - 1.96*(sd(Pulse)/sqrt(n())),
            upper.CL = mean + 1.96*(sd(Pulse)/sqrt(n())))
ggplot() +
  geom_jitter(data = crickets, aes(x = Sp, y = Pulse),
                height = 0, width = 0.25, alpha = 0.5) +
  geom_point(data = as.data.frame(emm_species), aes(x = Sp, y = emmean),
               color = "purple3", size = 3) +
  geom_errorbar(data = as.data.frame(emm_species), 
                  aes(x = Sp, ymin = lower.CL, ymax = upper.CL),
                  width = 0.1, color = "purple3") +
  geom_point(data = as.data.frame(unadjusted), aes(x = Sp, y = mean),
             color = "goldenrod", size = 3) +
  geom_errorbar(data = as.data.frame(unadjusted), 
                aes(x = Sp, ymin = lower.CL, ymax = upper.CL),
                width = 0.1, color = "goldenrod")
  theme_bw()
  

  
  
  
  
  
  
#Plot the  data with the regression lines

#This is a lot, but basically we are generating lines by predicting based on
#our model. This is the best way to plot model relationships from model objects.
newdata <- expand.grid(Sp = levels(crickets$Sp), 
                       Temp = seq(min(crickets$Temp), 
                                  max(crickets$Temp),
                                                            
                                  l = 100))
fit <- predict(ancovamodel, newdata = newdata, interval = "confidence")
fit <- data.frame(newdata, fit)
part.obs <- cbind(crickets, part.obs = fitted(ancovamodel) + resid(ancovamodel))

ggplot(fit, aes(y = fit, x = Temp, group = Sp, linetype = Sp)) + 
  geom_point(data = part.obs, 
             aes(y = part.obs, shape = Sp, color = Sp)) + 
  geom_line(aes(color = Sp)) + 
  geom_ribbon(aes(ymin = lwr, ymax = upr, fill = Sp), alpha = 0.2) +
  theme_classic() +
  labs(y = "Pulse Rate (Beats/min)", x = "Temperature (Deg. C)",
       color = "Species", fill = "Species", shape = "Species",
       linetype = "Species") 

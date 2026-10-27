# Lecture 10:
# ANCOVA Example in R
# CODE ADAPTED FROM MARILYN BRANDT

# There are two cricket species Oecanthus exclamationis and Oecanthus niveus, 
# your objective is to determine:
#   If the pulses of their songs are different
#   To determine if the covariate, Temperature, has a significant effect on 
#   cricket song pulses. 
#   If it does you will essentially be reomoving that source of variation of 
#   Temperature from the residual, and then test for differences in pulse between 
#   species.

rm(list=ls())

#load packages
library(tidyverse)
library(performance)

# First Let's import the  data:
crickets <- read.csv("Week12_ANCOVA/crickets.csv", header=TRUE)


# Now let's take a look at the data:
#Set Species as factor
#Boxplot of the Pulse Rate by Species

crickets$Sp <- as.factor(crickets$Sp)
plot(Pulse ~ Sp, data=crickets)

ggplot(data = crickets, aes(x = Sp, y = Pulse)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.5) +
  labs(x = "Species", y = "Pulse Rate (Beats/min)") +
  theme_bw()


# Scatterplot of Pulse versus Temperature for both Species. Note the use of the option "colour = " to have the dots be color coded. 
ggplot() + 
  geom_point(aes(x=Temp,y=Pulse,colour=Sp), data=crickets)+ 
  labs(y = "Pulse Rate (Beats/min)", x = "Temperature (Deg. C)",
       color = "Species") + theme_bw()
  

# Even though there are only two categories, you can still perform a one-way ANOVA. 
# We are doing this because we want to include the covariate temperature. The t-test does not allow you to account for a covariate. 
# Before performing the ANCOVA, it is a good idea to perform the one-way ANOVA without the covariate first. 



# So now perform an ANCOVA or Linear regression that tests for an interaction:
mod1 <- aov(Pulse ~ Sp*Temp, crickets)
summary(mod1)
# Not a significant interaction, so slopes are homogeneous


# So now we can continue, by removing the Interaction term but including Temperature as a main factor: 
mod2 <- aov(Pulse ~ Sp + Temp, crickets)

#check assumptions
plot(mod2)
#or prettier...
modeldiagnostics <- check_model(mod2)

png("Week12_ANCOVA/modeldiag.png",
    width = 4000,
    height = 3000, 
    res = 300)
modeldiagnostics
dev.off()

#look at the summary output
summary(mod2)


#Methods: Temperature was tested as a covariate and was found to consistently affect pulse rates in both species categories (p = 0.254), and so an ANCOVA was used to test for the effect of species on pulse rate. 

#Results: Oe had significantly higher pulse rates than On (p<0.0001) while accounting for the covariate of temperature (p<0.0001) (Figure 1). 



#Now Let's plot the  data with the regression lines

#This is a lot, but basically we are generating lines by predicting based on
#our model. This is the best way to plot model relationships from model objects.
newdata <- expand.grid(Sp = levels(crickets$Sp), Temp = seq(min(crickets$Temp), max(crickets$Temp),
                                                   l = 10))
fit <- predict(mod2, newdata = newdata, interval = "confidence")
fit <- data.frame(newdata, fit)
part.obs <- cbind(crickets, part.obs = fitted(mod2) + resid(mod2))
ggplot(fit, aes(y = fit, x = Temp, group = Sp, linetype = Sp)) + 
  geom_point(data = part.obs, 
             aes(y = part.obs, shape = Sp, color = Sp)) + 
  geom_line(aes(color = Sp)) + 
  geom_ribbon(aes(ymin = lwr, ymax = upr, fill = Sp), alpha = 0.2) +
  theme_classic() +
  labs(y = "Pulse Rate (Beats/min)", x = "Temperature (Deg. C)",
       color = "Species", fill = "Species", shape = "Species",
       linetype = "Species") 

# MES 503 Multi-way ANOVA in R
# Kayla Blincow
# 10/6/2026

# More ANOVA IN R
# The purpose of this script is to demonstrate how to perform an ANOVA in R.
# This is meant to accompany the lecture material related to one-way ANOVAs.

# clear your workspace
rm(list = ls())

#load packages
library(tidyverse)

# Make sure we all generate the same dataset
set.seed(10)

# Generate bluebonnet data
# Noodle around with this and see if you understand why this will generate the 
# data from the lecture.
bb <- data.frame(Soil = c(rep("S1", 15),
                              rep("S2", 15)),
                 Fertilizer = c(rep(c("F1", "F2", "F3"), 10))) %>% arrange(Fertilizer)

bb$Bluebonnets <- c(rnorm(5, 50, 4),
                    rnorm(5, 30, 4),
                    rnorm(5, 60, 4),
                    rnorm(5, 30, 4),
                    rnorm(5, 90, 4),
                    rnorm(5, 30, 4))

bb$group <- c(rep("S1F1", 5),
              rep("S2F1", 5),
              rep("S1F2", 5),
              rep("S2F2", 5),
              rep("S1F3", 5),
              rep("S2F3", 5))


# What do we think this is doing?
# Hint: look at how this is used in the ggplot below and check out what fun.data
# is in ?stat_summary()
data_summary <- function(group) {
  m <- mean(group)
  ymin <- m-sd(group)
  ymax <- m+sd(group)
  return(c(y=m,ymin=ymin,ymax=ymax))
}

ggplot(bb, aes(x = Fertilizer, y = Bluebonnets, color = Soil, 
               group = group)) +
  geom_jitter(width = 0.1, size = 2, alpha = 0.3) +
  stat_summary(fun.data=data_summary, size = 1) +
  scale_color_manual(values = c("#3A5311", "#75B72E")) +
  labs(y = "Bluebonnet Density (blooms/m^2)") +
  theme_bw() 

# Create a visual that shows the data for bloom density and fertilizer, and a
# separate one that shows the data for bloom density and soil.



# Do the ANOVA!
# Compare the outputs of these two different models, how are they different?
m1a <- aov(Bluebonnets ~ Soil*Fertilizer, data = bb)
m1b <- aov(Bluebonnets ~  Fertilizer + Soil + Soil:Fertilizer, 
           data = bb)

summary(m1a)
summary(m1b)

# Check the assumptions visually
plot(m1a)

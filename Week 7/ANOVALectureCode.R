#Kayla Blincow
#9/22/2023

#The purpose of this script is to make figures for the ANOVA lecture

#clear my workspace
rm(list = ls())

#load project
library(tidyverse)

#create data
d <- data.frame(CaptureLocation = c(rep("Magens Bay",10),
                                    rep("West End", 10),
                                    rep("Compass Point", 10)),
                CarapaceLength = c(rnorm(10, 10, 3),
                                   rnorm(10, 20, 2),
                                   rnorm(10, 10, 2))
                )

ggplot(d, aes(x = CaptureLocation, y = CarapaceLength,
              fill = CaptureLocation)) +
  geom_jitter(alpha = 0.5, width = 0.1) +
  geom_violin(alpha = 0.2) +
  geom_boxplot(width = 0.1, alpha = 0.7) +
  theme_bw() +
  theme(legend.position = "none")

m1 <- aov(CarapaceLength ~ CaptureLocation, data = d)
summary(m1)

TukeyHSD(m1)

ggplot(d, aes(x = CaptureLocation, y = CarapaceLength,
              fill = CaptureLocation)) +
  geom_jitter(alpha = 0.5, width = 0.1) +
  geom_violin(alpha = 0.2) +
  geom_boxplot(width = 0.1, alpha = 0.7) +
  annotate("text", label = "a", x = c(1, 2), y = c(16, 16)) +
  annotate("text", label = "b", x = 3, y = 25) +
  theme_bw() +
  theme(legend.position = "none")

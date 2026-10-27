#Kayla Blincow
#1/28/2023

#Analysis of Frequencies Lecture Companion Code!


#This script includes all the tests I ran to generate the results given in the 
#slides. It also includes the plotting code to generate the figures I shared.


#clear my workspace
rm(list = ls())

#load packages
library(tidyverse)
library(DescTools) #for G Test

#Scenario 1: 
#We sample copepods during an El Nino year, and compare against what the expected
#frequency of different copepod orders would be based on previously collected
#non-El Nino years.

#generate copepod data
copepods <- data.frame(type = c("Calanoid", 
                                "Harpacticoid",
                                "Cyclopoid",
                                "Poecilostomatoid"),
                       count = c(5741, 1265, 4522, 1195))

#Chi-Square Goodness of Fit test
#We wanted to see if our frequency distribution of copepods sampled
#during an El Nino year was the same as what we would expect given
#the known frequency distribution of copepods in non-El Nino years.

#generate expected distribution data
normal <- data.frame(type = c("Calanoid", 
                              "Harpacticoid",
                              "Cyclopoid",
                              "Poecilostomatoid"),
                     prop = c(0.6, .15, .15, .10))
normal$exp_n <- normal$prop*(sum(copepods$count))


#run the Chi-Squared Goodness of fit test
chisq.test(x = copepods$count, p = normal$prop)


#G Test for Goodness of Fit
GTest(x = copepods$count, p = normal$prop)


#make a plot
normal$dummylegend <- "ZNormal"

ggplot() +
  geom_col(data = normal, aes(x = type, y = exp_n,
                              color = dummylegend),
           alpha = 0.65) +
  geom_col(data = copepods, aes(x = type, y = count, fill = type),
           alpha = 0.65) +
  geom_segment(data = normal, aes(x = c(0.55, 1.55, 2.55, 3.55), 
                                  xend = c(1.45, 2.45, 3.45, 4.45),
                                  y = exp_n, yend = exp_n)) +
  scale_color_manual(values = "gray60") +
  labs(x = "Copepod Type", y = "Count", 
       fill = "El Nino", color = "Normal") +
  theme_bw() +
  theme(legend.position = "top",
        legend.text = element_blank())


#Scenario 2: 
#We count the number of copepods caught in deep and shallow water, as well as
#whether or not they have eggs.
#We want to know if the association between depth and occurrence of eggs is
#significant. In other words, does depth influence whether a copepod has eggs or
#not?

#generate data
shallow <- c(3817, 1272)
deep <- c(6361, 1282)

ctable <- matrix(c(shallow, deep),
                 nrow = 2, byrow = T)
rownames(ctable) <- c("shallow", "deep")
colnames(ctable) <- c("eggs", "noeggs")

ctable

#Chi-Squared Test of Independence
chisq.test(ctable, correct = F)

#plot the data
pdata <- data.frame(eggs = c("Eggs", "Eggs", "No Eggs", "No Eggs"),
                    depth = c("Shallow", "Deep", "Shallow", "Deep"),
                    prop = c(3817, 6361, 1272, 1282))

ggplot(data = pdata) +
  geom_col(aes(x = eggs, y = prop, fill = depth), position = position_dodge()) +
  labs(x = "", y = "Count", fill = "") +
  theme_bw()

#Scenario 3: 
#We do a stratified sampling design, where we sample the same number of deep and
#shallow copepods, and want to know if the population of eggs and no-eggs copepods
#are the same across depths.

#generate data
shallow <- c(1407, 3871)
deep <- c(1238, 3484)

ctable2 <- matrix(c(shallow, deep),
                 nrow = 2, byrow = T)
rownames(ctable2) <- c("shallow", "deep")
colnames(ctable2) <- c("eggs", "noeggs")

ctable2

#Chi-Squared Test of Homogeneity
chisq.test(ctable2, correct = F)

#Make a Plot
pdata2 <- data.frame(eggs = c("Eggs", "Eggs", "No Eggs", "No Eggs"),
                    depth = c("Shallow", "Deep", "Shallow", "Deep"),
                    prop = c(1407, 1238, 3871, 3484))

ggplot(data = pdata2) +
  geom_col(aes(x = eggs, y = prop, fill = depth), position = position_dodge()) +
  labs(x = "", y = "Count", fill = "") +
  theme_bw()


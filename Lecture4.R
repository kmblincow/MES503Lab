#Kayla Blincow
#8/26/2026

# Week 4: Hypothesis Testing and t tests

# The purpose of this script is to generate the lecture examples for Week 4 of
#MES503 Fall 2026. 


#clear my workspace
rm(list = ls())

#load packages
library(tidyverse)
library(gginference)
library(patchwork)

#set seed (this ensures that all randomly generated values will be consistent)
set.seed(5)


####Central Limit Theorem Demonstration####

#The Central Limit Theorem states that if you take a sample from pretty much
#any distribution and calculate the mean, then do that over and over again a
#bunch of times, the resulting distribution of means will approximate a normal
#distribution.

#Let's test that...

#First let's try sampling from a normal distribution and seeing if that's true
#visualize our normal distribution (mean of 0, sd of 10)
ggplot(data = data.frame(x = c(-100, 100)), aes(x)) +
  stat_function(fun = dnorm, n = 100, args = list(mean = 0, 
                                                  sd = 10),
                size = 1) +
  theme_bw()

#let's randomly draw 10 values from this distribution and calculate the mean
rnorm(n = 10, mean = 0, sd = 10) %>% 
  mean()

#how would we do this a bunch of times??











#like this!
normalmeans <- replicate(10000, mean(rnorm(10, 0, 10)))

#let's plot it and see what it looks like
ggplot(as.data.frame(normalmeans), aes(x = normalmeans)) +
  geom_histogram(binwidth = 1, color = "black", fill = "gray") +
  geom_density(aes(y = after_stat(count)),
               color = "darkmagenta",
               size = 2) +
  theme_bw()

#looking pretty normal! But this started as a normal distribution...
#what if we look at a different distribution??

#uniform distribution plot
ggplot(data = data.frame(x = c(-10, 10)), aes(x)) +
  stat_function(fun = dunif, n = 1000, args = list(min = -10, 
                                                  max = 10),
                size = 1) +
  theme_bw()

#let's sample from it and calculate means!
uniformmeans <- replicate(10000, mean(runif(10, -10, 10))) #notice runif()

#let's plot it and see what it looks like
ggplot(as.data.frame(uniformmeans), aes(x = uniformmeans)) +
  geom_histogram(binwidth = 1, color = "black", 
                 fill = "grey") +
  geom_density(aes(y = after_stat(count)),
               color = "darkmagenta",
               size = 2) +
  theme_bw()

#cooolllll!!! looking normal again!

#let's do one more distribution, how about an exponential distribution?

#exponential distribution plot
ggplot(data = data.frame(x = c(0, 100)), aes(x)) +
  stat_function(fun = dexp, n = 1000, args = list(rate = 1/10),
                size = 1) +
  theme_bw()

#let's sample from it and calculate means!
exponentialmeans <- replicate(10000, mean(rexp(10, 1/10))) #notice rexp()

#let's plot it and see what it looks like
ggplot(as.data.frame(exponentialmeans), aes(x = exponentialmeans)) +
  geom_histogram(binwidth = 1, color = "black", 
                 fill = "grey") +
  geom_density(aes(y = after_stat(count)),
               color = "darkmagenta",
               size = 2) +
  theme_bw()












#distributions of GSB sizes

#generate data (start with 30 samples, different means)
pre70 <- rnorm(n = 300, mean = 110, sd = 20) #pre-1970 data
post20 <- rnorm(n = 300, mean = 100, sd = 20) #post-2010 data

#write a function to draw histogram of data
makehist <- function(dat, color, main){
  ggplot(as.data.frame(dat), aes(x = dat)) +
    geom_histogram(fill = "gray50", color = "gray20") +
    geom_vline(aes(xintercept = mean(dat)),
               color = color, size = 2) +
    xlim(50,200) +
    labs(x = "GSB Size (cm)", y = "Count", title = main) +
    theme_classic()
}


makehist(pre70, "purple3", main = "pre-1970; n = 30") 
  #annotate("text", x = 150, y = 4.5, label = "mean +/- SD = 108.78 +/- 20.26") #add annotations of mean/SD based on below calculations
makehist(post20, "darkblue", main = "post-2010; n = 30") 
  #annotate("text", x = 150, y = 4.5, label = "mean +/- SD = 100.16 +/- 20.91")


mean(pre70)
sd(pre70)

mean(post20)
sd(post20)

#do the thing!
ttest <- t.test(pre70, post20, 
       alternative = "two.sided",
       paired = F,
       var.equal = T, 
       conf.level = 0.95)
#visualize it in the context of the t distribution
ggttest(ttest)

#visualize it in a normal scientific paper-y way
#combine data
gsb <- data.frame(period = c(rep("pre1970", 300), rep("post2010", 300)),
                  lngth = c(pre70, post20))
#summarize data
gsb2 <- gsb %>% group_by(period) %>% 
  summarize(mn = mean(lngth),
            s = sd(lngth), 
            CIlow = mn - qt(0.975,df = n()-1)*s/sqrt(n()),
            CIhigh = mn + qt(0.975,df = n()-1)*s/sqrt(n()))

#convert factor variable for correct order/text during plotting
gsb2$period <- factor(gsb2$period, levels = c("pre1970", "post2010"),
                      labels = c("pre-1970", "post-2010"))

#plot data
ggplot(gsb2, aes(x = period, y = mn, color = period)) +
  geom_point(size = 2) +
  geom_errorbar(aes(ymin = CIlow, ymax = CIhigh),
                width = 0.2, size = 1) +
  labs(x = "Time Period", y = "Mean Size (cm)") +
  scale_color_manual(values = c("purple", "darkblue")) +
  theme_bw() +
  theme(legend.position = "none")





#standard deviation demonstration figures
high <- data.frame(sd = "high", y = rnorm(100,0,50), x = 1:100)
low <- data.frame(sd = "low", y = rnorm(100,0,5), x = 1:100)

ggplot() +
  geom_hline(aes(yintercept = 0)) +
  geom_point(data = high, aes(x = x, y = y), color = "red") +
  geom_point(data = low, aes(x = x, y = y), color = "blue") +
  theme_bw()



ggplot(data = data.frame(x = c(-150,150)), aes(x)) +
  stat_function(fun = dnorm, n = 101, args = list(mean = mean(high$y), 
                                                  sd = sd(high$y)),
                color = "red", size = 1) +
  stat_function(fun = dnorm, n = 101, args = list(mean = mean(low$y), 
                                                  sd = sd(low$y)),
                color = "blue", size = 1) +
  theme_bw()

#confidence interval link
combo <- rbind(high, low)

qt(0.975,df=n-1)*s/sqrt(n)

pdata <- combo %>% group_by(sd) %>%
  summarize(mn = mean(y),
            s = sd(y),
            CIlow = mn - qt(0.975,df = n()-1)*s/sqrt(n()),
            CIhigh = mn + qt(0.975,df = n()-1)*s/sqrt(n()))
ggplot(pdata, aes(x = sd, y = mn, color = sd)) +
  geom_point() +
  geom_errorbar(aes(ymin = CIlow, ymax = CIhigh),
                width = 0.3) +
  scale_color_manual(values = c("red", "blue")) +
  labs(x = "Variance Level", y = "Sample Mean") +
  theme_bw() +
  theme(legend.position = "none")
  

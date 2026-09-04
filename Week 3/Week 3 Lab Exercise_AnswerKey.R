# MES 503 Week 3 Lab - Correlation + Making Visuals Pretty
# This script includes a coding exercise designed to build your understanding of 
# correlation while also learning more about customzing ggplot visuals

# Created by Kayla Blincow 9/1/2026
#------------------------------------------------------------------------------


####INTRODUCTION####

# This week we're going to work with the iris dataset, a classic dataset in R
# that was collected by Edgar Anderson and made famous by statistician Ronald
# Fisher in 1936. It contains measurements of 150 flowers from three species
# of iris (setosa, versicolor, and virginica), including the length and width
# of their petals and sepals.

# We're going to use this dataset to explore the concept of CORRELATION -
# whether and how strongly two numeric variables are related to one another -
# and to level up our ggplot2 skills by learning how to customize the look of
# our plots rather than relying on the defaults.



####SET UP MY SCRIPT####

# clear your workspace
rm(list = ls())
# WRITE NOTES ABOUT WHAT THIS DOES HERE AND WHY YOU SHOULD BE CAREFUL WITH IT.

# load necessary packages
library(ggplot2) #our data viz package

# the iris dataset comes built into R, so we don't need to read in a csv file!
# create an object to house our data
flowers <- iris

# take a look at the first six rows of the data
head(flowers)

# check out the structure of the dataset - what variables do we have, and
# what type of data is in each column?
str(flowers)

# Thoughts? What do the columns mean? How many species are there?
#WRITE NOTES HERE


####WHAT IS CORRELATION?####

# Correlation describes the strength AND direction of a relationship between
# two numeric variables. It is often summarized using a correlation
# coefficient (r), which ranges from -1 to 1:
#   - values close to  1 indicate a strong POSITIVE relationship
#     (as one variable increases, so does the other)
#   - values close to -1 indicate a strong NEGATIVE relationship
#     (as one variable increases, the other decreases)
#   - values close to  0 indicate a weak or no linear relationship

# We can calculate a correlation coefficient using the cor() function.
# Let's see how petal length and petal width are related.
cor(flowers$Petal.Length, flowers$Petal.Width)

# What happened? 
# What does the "$" notation do?
# What does this value tell you about the relationship between petal length and 
# petal width?
#WRITE NOTES HERE

# YOUR TURN
# Calculate the correlation coefficient between sepal length and sepal width.

####FILL IN CODE HERE####
cor(flowers$Sepal.Length, flowers$Sepal.Width)

# How does this value compare to the petal length/width correlation? What
# does that tell you?
#WRITE YOUR ANSWER HERE





####IS THAT CORRELATION SIGNIFICANT?####

# cor() gives us the strength/direction of a relationship, but it doesn't
# tell us whether that relationship is statistically significant, or could
# plausibly have arisen just by chance. For that, we need a hypothesis test!

# We can use cor.test() to run a Pearson's correlation test. This test
# assumes both variables are roughly normally distributed and that their
# relationship is linear. It gives us:
#   - t: the test statistic
#   - df: degrees of freedom
#   - p-value: the probability of seeing a correlation this strong (or
#     stronger) if there were truly NO relationship between the variables
#   - a 95% confidence interval for the true correlation coefficient
#   - cor: the correlation coefficient itself (same as what cor() gives you)

# Let's test whether petal length and petal width are significantly
# correlated.
cor.test(flowers$Petal.Length, flowers$Petal.Width, method = "pearson")

# What happened? Look at the p-value - using an alpha (significance
# threshold) of 0.05, would you conclude that petal length and petal width
# are significantly correlated?
#WRITE NOTES HERE

# We can also save the results of our test as an object, which lets us pull
# out specific pieces of it (handy for reporting results or adding them to
# a plot!).
petal_cor <- cor.test(flowers$Petal.Length, flowers$Petal.Width, method = "pearson")

# look at the structure of our saved test object - what pieces does it contain?
str(petal_cor)
# psst... you can also check it out in your workspace pane in the upper right corner

# pull out just the p-value
petal_cor$p.value

# pull out just the correlation coefficient
petal_cor$estimate

# YOUR TURN
# Run a Pearson's correlation test between sepal length and sepal width, and
# save the results as an object called sepal_cor.

####FILL IN CODE HERE####
sepal_cor <- cor.test(flowers$Sepal.Width, flowers$Sepal.Length)

# Is the relationship between sepal length and sepal width statistically
# significant? How does the strength (r) of this relationship compare to the
# petal length/petal width relationship?
#WRITE YOUR ANSWER HERE


# Correlation coefficients and test statistics are useful, but visualizing
# the relationship helps us understand it more intuitively (and can reveal
# patterns that a single number might hide, like non-linear relationships or
# the influence of outliers/groups).

# We can use a scatterplot to visualize the relationship between two numeric
# variables, and add the correlation coefficient AND p-value right onto our
# plot title using paste()!

ggplot(data = flowers, #specify our data
       mapping = aes(x = Petal.Length, #petal length on the x axis
                     y = Petal.Width)) + #petal width on the y axis
  geom_point() + #scatterplot of points
  labs(title = paste("r =", round(petal_cor$estimate, 2),
                     ", p =", format.pval(petal_cor$p.value, digits = 2, eps = 0.001)))
#paste() glues text together, round() rounds our correlation coefficient to
#2 decimal places, and format.pval() formats our p-value nicely (and
#handles very small p-values using the eps argument)

# NOTE: p-values very close to zero (like this one!) will often be reported
# by R as "< 2.2e-16" - this is scientific notation, and it means the p-value
# is smaller than R can precisely calculate/display, NOT that it is exactly
# zero.

# Do you notice anything weird about this visual? Try adapting the visual to 
# explore any weirdnesses you see.

#WRITE CODE HERE

ggplot(data = flowers, #specify our data
       mapping = aes(x = Petal.Length, #petal length on the x axis
                     y = Petal.Width,
                     color = Species)) + #petal width on the y axis
  geom_point() + #scatterplot of points
  labs(title = paste("r =", round(petal_cor$estimate, 2),
                     ", p =", format.pval(petal_cor$p.value, digits = 2, eps = 0.001)))


#NOTE: sometimes ggplot is a little overkill... If you want to take a quick look
#at relationships between variables you can use the Base R plot() function
plot(flowers)
#not pretty but gets the job done for taking a quick look

####CUSTOMIZING YOUR PLOTS####

# So far we've mostly used ggplot2's default settings. Now let's learn how to
# take control of the look of our plots! This is useful for making your
# figures more readable, more visually appealing, and ready for a
# presentation or publication.


###Custom Color Palettes###

# By default, ggplot2 picks colors for us. But we can define our own! There
# are a few ways to do this - here we'll use scale_color_manual() to assign
# specific colors to each species.

# Spend some time looking at the code below and draw what you think the
# resulting plot will look like before running it.

ggplot(data = flowers,
       mapping = aes(x = Petal.Length,
                     y = Petal.Width,
                     color = Species)) + #color points by species
  geom_point() +
  scale_color_manual(values = c("setosa" = "darkorange", #assign a color to each level
                                "versicolor" = "cyan4",
                                "virginica" = "purple3"))

# You can use hex codes too! (e.g. "#E69F00" instead of "darkorange")
# Try a site like https://coolors.co/ or https://r-graph-gallery.com/color-palette-finder
# if you want some inspiration for color palettes.


###Changing Shape, Size, and Alpha###

# We can also map variables to POINT SHAPE, and manually control point SIZE
# and ALPHA (transparency) to help with overplotting (when points overlap
# and become hard to distinguish).

ggplot(data = flowers,
       mapping = aes(x = Petal.Length,
                     y = Petal.Width,
                     color = Species,
                     shape = Species)) + #map shape to species too
  geom_point(size = 3, #make our points bigger
             alpha = 0.6) + #make our points 60% opaque (partially see-through)
  scale_color_manual(values = c("setosa" = "darkorange",
                                "versicolor" = "cyan4",
                                "virginica" = "purple3")) +
  scale_shape_manual(values = c("setosa" = 16, #circle
                                "versicolor" = 17, #triangle
                                "virginica" = 15)) #square

# What did changing alpha do for you here? Why might that be useful with a
# larger dataset?
#WRITE YOUR ANSWER HERE

# Note: size and alpha can also be set OUTSIDE of aes() (as we did above) when
# they apply to ALL points equally, or INSIDE of aes() if you want them to
# vary based on a variable in your data (e.g., size = Sepal.Length).

# YOUR TURN
# Modify the code below so that point SIZE varies based on Sepal.Length
# (HINT: where does size need to go if it depends on a variable?)

ggplot(data = flowers,
       mapping = aes(x = Petal.Length,
                     y = Petal.Width,
                     color = Species,
                     size = Sepal.Length)) +
  geom_point(alpha = 0.7) #FIX ME - map size to Sepal.Length


###Controlling the Theme###

# Themes control the non-data elements of your plot: background, gridlines,
# fonts, legend position, etc. ggplot2 comes with several built-in themes
# (theme_bw(), theme_minimal(), theme_classic(), theme_light()) but you can
# also customize individual elements using theme().

ggplot(data = flowers,
       mapping = aes(x = Petal.Length,
                     y = Petal.Width,
                     color = Species)) +
  geom_point(size = 3, alpha = 0.7) +
  scale_color_manual(values = c("setosa" = "darkorange",
                                "versicolor" = "cyan4",
                                "virginica" = "purple3")) +
  labs(x = "Petal Length (cm)",
       y = "Petal Width (cm)",
       title = "Petal Dimensions by Species",
       color = "Species") +
  theme_bw() + #start with a clean built-in theme
  theme(plot.title = element_text(hjust = 0.5, face = "bold"), #center + bold the title
        legend.position = "bottom", #move the legend
        axis.title = element_text(size = 12), #resize axis titles
        panel.grid.minor = element_blank()) #remove minor gridlines

# Try changing legend.position to "top", "right", "left", or "none". What
# happens? What about changing theme_bw() to theme_minimal() or
# theme_classic()?
#WRITE YOUR NOTES HERE



###Splitting Your Plot with facet_wrap()###

# So far we've used color to distinguish species within a single plot. Another
# powerful way to compare groups is to split your plot into multiple small
# "panels" - one per group - using facet_wrap(). This is often called "small
# multiples" and can make group-level patterns much easier to see than
# cramming everything into one panel.

# facet_wrap() takes a formula (using a tilde ~) telling it which variable to
# split by.

# Spend some time looking at the code below and draw what you think the
# resulting plot will look like before running it.

ggplot(data = flowers,
       mapping = aes(x = Petal.Length,
                     y = Petal.Width,
                     color = Species)) +
  geom_point(size = 2, alpha = 0.7) +
  scale_color_manual(values = c("setosa" = "darkorange",
                                "versicolor" = "cyan4",
                                "virginica" = "purple3")) +
  facet_wrap(~ Species) #split into one panel per species

# What happened? How does seeing each species in its own panel change how you
# interpret the relationship between petal length and petal width, compared
# to the single-panel version from earlier?
#WRITE YOUR NOTES HERE

# facet_wrap() has some handy arguments for controlling panel layout:
#   - nrow / ncol: control how many rows or columns of panels to use
#   - scales: by default all panels share the same axis ranges ("fixed"), but
#     you can free them up with "free", "free_x", or "free_y" if the groups
#     have very different ranges

ggplot(data = flowers,
       mapping = aes(x = Petal.Length,
                     y = Petal.Width,
                     color = Species)) +
  geom_point(size = 2, alpha = 0.7) +
  scale_color_manual(values = c("setosa" = "darkorange",
                                "versicolor" = "cyan4",
                                "virginica" = "purple3")) +
  facet_wrap(~ Species, nrow = 1, scales = "free") + #one row, each panel gets its own axis scale
  theme_bw() +
  theme(legend.position = "none") #legend is redundant now that panels are labeled

# Since each panel is already labeled by species, do we still need the color
# legend? What did setting legend.position = "none" do?
#WRITE YOUR ANSWER HERE

# YOUR TURN
# Use facet_wrap() to create a plot with one panel per species showing the
# relationship between sepal length and sepal width. Customize the point
# color, size, and alpha, and pick a theme of your choosing.


ggplot(data = flowers, aes(x = Sepal.Length, y = Sepal.Width)) +
  geom_point(color = "purple2", size = 4, alpha = 0.5) +
  theme_bw() +
  facet_wrap(~Species)


####FILL IN CODE HERE####


# YOUR TURN
# Below, build your own fully customized plot exploring the relationship
# between sepal length and sepal width by species. Include:
#   - a custom color palette (scale_color_manual)
#   - custom point shapes by species (scale_shape_manual)
#   - a point size and alpha of your choosing
#   - informative axis and legend labels (labs())
#   - at least TWO customized theme elements (theme())

ggplot(data = flowers,
         mapping = aes(x = Sepal.Length,
                         y = Sepal.Width,
                         color = Species,
                         shape = Species
         )) +
  geom_point(size = 3,
               alpha = 0.6
  ) +
  scale_color_manual(values = c("purple1", "purple4", "purple")
  ) +
  scale_shape_manual(values = c(5, 10, 15)
  ) +
  labs(x = "Sepal Length", y = "Sepal Width", color = "Species", shape = "Species"
  ) +
  theme_bw() +
  theme(legend.position = "top",
        panel.grid.minor = element_blank()
  )




####FINAL EXERCISE####
# Using the iris dataset, address the following research questions. For each
# plot, use at least one custom color palette AND one other customization
# (shape, size, alpha, or theme element) covered in this lab.
#
#   - Is sepal length correlated with petal length? Run a Pearson's
#     correlation test (report the r value AND the p-value) AND create a
#     customized scatterplot to visualize the relationship.

cor1 <- cor.test(flowers$Sepal.Length, flowers$Petal.Length)
cor1

ggplot(flowers, aes(x = Sepal.Length, y = Petal.Length)) +
  geom_point() + 
  labs(title = paste("r =", round(cor1$estimate, 2),
                     ", p =", format.pval(cor1$p.value, digits = 2, eps = 0.001)))
  

#   - Does the strength and significance of the relationship between petal
#     length and petal width differ across species? (HINT: try running
#     cor.test() separately for each species using subset() or filtering
#     your data, and use facet_wrap() to visualize each species separately)

#one way to do this... (could also use subset in a similar way)
library(dplyr)
virg <- flowers |> filter(Species == "virginica")
versi <- flowers |> filter(Species == "versicolor")
set <- flowers |> filter(Species == "setosa")

cor.test(virg$Petal.Length,virg$Petal.Width)
cor.test(versi$Petal.Length,versi$Petal.Width)
cor.test(set$Petal.Length,set$Petal.Width)
#look at outputs and compare

#another way to do this
correlations <- data.frame(species = rep(NA, length(unique(flowers$Species))),
                           r = rep(NA, length(unique(flowers$Species))),
                           p = rep(NA, length(unique(flowers$Species))))

for(i in 1:length(unique(flowers$Species))){
  species <- flowers |> filter(Species == unique(flowers$Species)[i])
  correlations$species[i] <- first(as.character(species$Species))
  correlations$r[i] <- cor.test(species$Petal.Length, 
                                species$Petal.Width)$estimate
  correlations$p[i] <- cor.test(species$Petal.Length, 
                                species$Petal.Width)$p.value
  
}

correlations


ggplot(flowers, aes(x = Petal.Length, y = Petal.Width)) +
  geom_point() +
  facet_wrap(~Species)


#   - Create a scatterplot of sepal length vs. sepal width. Does this
#     relationship look the same across the whole dataset as it does within
#     each individual species? What might explain any differences you see?
#     Is the whole-dataset relationship statistically significant?
#
# HINT: For more ggplot2 customization ideas and color palette options, see
# https://r-graph-gallery.com/ggplot2-package.html and
# https://r-graph-gallery.com/color-palette-finder

ggplot(flowers, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point()

cor.test(flowers$Sepal.Width, flowers$Sepal.Length)

####EXTRA CHALLENGE (OPTIONAL - FOR THE BRAVE)####

# Open the image "Week3_Challenge_Target_Plot.png" provided alongside this
# script. Your job is to write ggplot2 code that recreates this plot AS
# CLOSELY AS POSSIBLE, using the iris dataset.

# This is a HEATMAP showing the Pearson correlation coefficient between every
# pair of the four numeric iris variables (Sepal.Length, Sepal.Width,
# Petal.Length, Petal.Width), with the correlation value printed on each tile.

# This challenge pulls together everything from this lab (correlation,
# custom color scales) AND pushes you to look up a few new things on your
# own. Some notes to help you get there:

# 1. DATA SHAPE: the ggplot2 function for making heatmaps needs
#    "long" format data - one row per x/y/fill combination - not the wide
#    correlation matrix that cor() gives you. You'll need to:
#      a) calculate the correlation matrix for the 4 numeric variables
#         (HINT: cor() works on a whole data frame at once, not just two
#         variables - try cor(flowers[, 1:4]))
#      b) reshape that matrix into a long format data frame with columns for
#         Var1 (row variable), Var2 (column variable), and value (the
#         correlation). 

# 2. CUSTOM COLOR GRADIENT: notice the color scale is NOT a default ggplot2
#    gradient - it's a custom diverging scale (one color for negative
#    correlations, a light neutral color at zero, another color for positive
#    correlations). Look for a ggplot2 function which lets you set
#    low/mid/high colors and a midpoint.


# 3. ATYPICAL BACKGROUND: look closely at the background of the plot. There
#    are TWO background elements at play here - the background of the plot
#    PANEL (where the tiles are) and the background of the OVERALL plot
#    (everything else). Both have been changed from ggplot2's defaults using
#    theme(). 

# This is meant to be genuinely challenging! You will likely need to search
# for some of these functions on your own (try ?function_of_interest
# or a search engine) - that's an important R skill in itself. Don't worry
# about matching the EXACT colors or spacing perfectly; focus on getting the
# key structural elements right: a heatmap, a custom diverging color scale,
# a left-positioned legend, and a non-default background.

####FILL IN CODE HERE####

library(dplyr)   # install.packages("reshape2") if needed


# 1. Calculate the correlation matrix for the 4 numeric variables
corr_mat <- cor(flowers[, 1:4])

# 2. Reshape into long format for geom_tile()
corr_long <- as.data.frame(corr_mat) |>
  rownames_to_column(var = "Var1") |>
  pivot_longer(cols = -Var1,          # pivot everything except Var1
               names_to = "Var2",
               values_to = "value")

# 3. Build the heatmap
challenge <- ggplot(data = corr_long,
       mapping = aes(x = Var2, y = Var1, fill = value)) +
  geom_tile(color = "#3a3a3a", linewidth = 1) +  # dark tile borders
  geom_text(aes(label = round(value, 2)),
            color = ifelse(abs(corr_long$value) > 0.55, "white", "#1a1a1a"),
            fontface = "bold") +
  scale_fill_gradient2(low = "#1b7a72",     # teal for negative correlations
                       mid = "#f5f0e6",    # cream at zero
                       high = "#8c1c3f",   # maroon for positive correlations
                       midpoint = 0,
                       limits = c(-1, 1),
                       name = "Pearson\nCorrelation (r)") +
  labs(title = "Correlation Between Iris Flower Measurements",
       x = NULL, y = NULL) +
  theme(
    legend.position = "left",                              # legend on the left
    plot.background = element_rect(fill = "#efe6d8",        # cream page background
                                   color = NA),
    panel.background = element_rect(fill = "#3a3a3a",        # dark panel background
                                    color = NA),
    panel.grid = element_blank(),                             # no default gridlines
    axis.text.x = element_text(angle = 45, hjust = 1, color = "#2a2a2a"),
    axis.text.y = element_text(color = "#2a2a2a"),
    plot.title = element_text(face = "bold", color = "#2a2a2a", hjust = 0.5),
    axis.ticks = element_blank()
  )



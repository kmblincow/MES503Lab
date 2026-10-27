# MES 503 Coding Exercise: Dates and Times in R
# Kayla Blincow
# 10/9/2026

#------------------------------------------------------------------------------
# INTRODUCTION

# Most of the research questions you will be exploring for your theses will have
# some element of time. 

# Dates and times are weird beasts and it's important to consider how you need
# to communicate with R when you're handling them.

#------------------------------------------------------------------------------


#clear your workspace
rm(list = ls())

#load packages
library(tidyverse) 

library(lubridate) 
# FYI this is the tidyverse date package. Note this is included in library(tidyverse),
# but sometimes it's weird and you have load it separately.

#BASE R BASICS

####Base R Dates####

#let's practice with as.Date()
mydate <- "2026-01-01"
str(mydate)
mydate <- as.Date(mydate)
str(mydate)

#what if the date is in a different format?
mydate <- "01/01/2026"
str(mydate)
mydate <- as.Date(mydate)
#ack! error message!

#we need to use an additional argument in the as.Date() function to deal with this
mydate <- as.Date(mydate, format = "%m/%d/%Y")
mydate
str(mydate)

#briefly pop to pwrpt to talk about the different %x symbols for dates/times

#what if we want our date object to be in a different format? 
#perhaps for plotting?
mydate2 <- format(mydate, format = "%B %d %Y")
mydate2

#but! notice cdate2 is no longer a date object!
str(mydate2)
#so be careful!

#you can also perform simple arithmetic with date objects if needed
mydate + 1

#or generate a sequence of dates if needed
seqdate <- seq.Date(from = as.Date("2026-01-01"), by = "month", length.out = 12)
seqdate
str(seqdate)


#note: seq.Date is a little bit overkill because base R will recognize you have
#a date object if you just run seq
seq(from = mydate, by = "day", length.out = 35)


#okay so that's dates in base R, but what about times?

####Base R Times ####
#let's practice with as.POSIXct()
mytime <- "11:00:52"
str(mytime)
mytime <- as.POSIXct(mytime) #ack! error message already?!

#times get all sorts of messy..
#you basically always need to specify the format of our character string!
mytime <- as.POSIXct(mytime, format = "%H:%M:%S")
mytime
#woah.. now what the what? there's a date added on? and a random -04??
#this is because POSIXct creates a datetime object
str(mytime)

#if you do not supply a date and time zone it will automatically assume you mean
#your computer's current date/time zone (FYI: we are in UTC -04)

#this can be annoying, but luckily for us, we almost always have dates associated
#with our time records so we can combine those things as we will see later

#again we can generate a sequence if we want
seqtime <- seq.POSIXt(from = mytime, by = "sec", length.out = 30)
seqtime
str(seqtime)

#note: seq.POSIXt is a little bit overkill because base R will recognize you have
#a datetime object if you just run seq
seq(from = mytime, by = "hour", length.out = 10)


####lubridate package####
#I find all the base R functions useful for quick transformations, but they
#can get finnicky really fast... 

#Enter the lubridate package! My favorite thing for more intense date/time moments

#I am going to run through some examples that are largely adapted from this site:
#https://r4ds.had.co.nz/dates-and-times.html
#check it out if you have more questions or want to see more examples

#lubridate equivalent of base R functions
mydate <- "2026-01-01"
mydate
str(mydate)
mydate <- ymd(mydate)
str(mydate)

#different format
mydate <- "01/01/2026"
str(mydate)
mydate <- mdy(mydate)
str(mydate)


#add time component
mydt <- "01/01/2026 08:01"
str(mydt)
mydt <- mdy_hm(mydt) 
mydt #notice it defaults to UTC time zone (you can specify a different one)
str(mydt)

#let's say you want to pull out specific parts of your date time object
year(mydt)
month(mydt)
month(mydt, label = T) #creates an ordered factor
mday(mydt) #day of the month
yday(mydt) #day of the year
wday(mydt) #day of the week
wday(mydt, label = T, abbr = F) #creates an ordered factor
hour(mydt)
minute(mydt)
second(mydt)

#what if excel messed up your data and all the sudden the year is off by one year?
#let's say we actually meant 2025 instead of 2026
year(mydt) <- 2025
mydt #woohoo! it changed to 2020

#maybe our times are two hours off for some reason?
hour(mydt) <- hour(mydt) + 2
mydt

#maybe we want to update all the parts of the date/time
update(mydt, year = 2020, month = 2, mday = 21, hour = 9)
#this can be useful if you want to iterate or generate a sequence

#There might also be times when you want to round a date or time
floor_date(mydt, "week") #notice this rounded to the earliest date in the week
floor_date(mydt, "week") %>% wday(label = T) 
#which is Sunday by default (you can change this though using week_start argument)

ceiling_date(mydt, "hour") #round to the next highest hour
round_date(mydt, unit = "5 mins") # round to the nearest 5 minute increment

#additional notes:
#time zones... I find it easiest to just work in UTC because that is often the
#default, but I understand that isn't always the case
#We are in "AST" (= UTC -4). To convert from AST to UTC, you need to add 4 hours.



# Let's work with some real data Sommer shared with me!

# These data include observations of humpback whale calls on a single glider 
# expedition around St. Croix. Each row of data represents a confirmed humpback
# call and includes timestamps for the start of the call, the end of the call, and 
# the middle of the call (av_datetime_UTC). There is also information on the glider 
# location, and the oceanographic conditions experienced at that location.


#read in the data
whales <- read.csv("Week 9/calc_humpback_points_p26920.csv")



# Use the date/time wrangling skills above to address the following questions,
# create a visual for each:
# 1. How many days did this glider expedition last? (no visual needed)
# 2. Does the number of humpback calls differ based on the hour of the day?
# 3. Which date had the highest number of humpback calls? What day of the week 
# (i.e. Saturday? Sunday? Monday?) was that date? Create a visual showing call
# count by date with the bars colored based on the day of the week.



# EXTRA CHALLENGE 1:
# Does the number of humpback calls recorded during nighttime hours differ from
# daytime hours? 

# NOTE: The timing of sunset/sunrise depends on the time of the year and location 
# on the earth. You can use the functions in the suncalc package to determine the
# timing of sunset/sunrise from these data.


# EXTRA CHALLENGE 2:
# What was the longest stretch of time between humpback call observations? 
# What was the average length of time between humpback call observations?






# STARTING HINT: Does R know your date/time columns are dates/times?
whales$av_datetime_UTC <- ymd_hms(whales$av_datetime_UTC)
whales$start_datetime_UTC <- ymd_hms(whales$start_datetime_UTC)
whales$end_datetime_UTC <- ymd_hms(whales$end_datetime_UTC)


# Q1
range(whales$end_datetime_UTC)[2] - range(whales$end_datetime_UTC)[1] 

# Q2
whales$hour <- hour(whales$av_datetime_UTC)

ggplot(whales, aes(x = hour)) +
  geom_bar()

# Q3
whales$date <- date(whales$av_datetime_UTC)
ggplot(whales, aes(x = date, fill = wday(date, label = T, abbr = F))) +
  geom_bar() +
  labs(x = "Date", y = "Call Count", fill = "Day of the Week")


# EXTRA CHALLENGE 1
library(suncalc)
suntimes <- whales |> select(date, av_latitude_DD, av_longitude_DD) |> 
  rename(date = date, lat = av_latitude_DD, lon = av_longitude_DD)
sunlight <- getSunlightTimes(data = suntimes, keep = c("sunrise", "sunset"))
whales$sunset <- sunlight$sunset
whales$sunrise <- sunlight$sunrise


whales$DN <- ifelse(whales$av_datetime_UTC < whales$sunset & whales$av_datetime_UTC > whales$sunrise,
                    "D", "N")


ggplot(whales, aes(x = hour, fill = DN)) +
  geom_bar()

ggplot(whales, aes(x = DN, fill = DN)) +
  geom_bar()

# EXTRA CHALLENGE 2
whales <- arrange(whales, start_datetime_UTC)
whales$timesincelast <- NA
for(i in 2:nrow(whales)){
  whales$timesincelast[i] <- difftime(whales$start_datetime_UTC[i], 
                                      whales$end_datetime_UTC[i-1],
                                      units = "secs")
}

#longest length of time between calls
range(whales$timesincelast, na.rm = T)[2] #in seconds
range(whales$timesincelast, na.rm = T)[2]/60 #in minutes
range(whales$timesincelast, na.rm = T)[2]/86400 #in days

#average length of time between calls
mean(whales$timesincelast, na.rm = T)

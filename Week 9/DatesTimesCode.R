#Kayla Blincow
#01/18/2022


#This script presents a quick tutorial on how to work with dates and times in 
#R. It specifically covers the base R functions and the lubridate package.


#clear my workspace
rm(list = ls())

#load my packages
library(tidyverse) 
#note: I frequently code in tidyverse so I usually just load the whole suite of 
#packages using the above call--there are potential pitfalls to doing this.
#Mainly, you need to be careful that you aren't masking a base R function that 
#you intend to use (this often happens with the dplyr function filter(), which
#will mask the base R function filter() when it's loaded).

library(lubridate)

#BASE R BASICS

####Base R Dates####

#let's practice with as.Date()
cdate <- "2021-01-20"
str(cdate)
cdate <- as.Date(cdate)
str(cdate)

#what if the date is in a different format?
cdate <- "01/20/2021"
str(cdate)
cdate <- as.Date(cdate)
#ack! error message!

#we need to use an additional argument in the as.Date() function to deal with this
cdate <- as.Date(cdate, format = "%m/%d/%Y")
cdate
str(cdate)

#briefly pop to pwrpt to talk about the different %x symbols for dates/times

#what if we want our date object to be in a different format? 
#perhaps for plotting?
cdate2 <- format(cdate, format = "%B %d %Y")
cdate2

#but! notice cdate2 is no longer a date object!
str(cdate2)
#so be careful!

#you can also perform simple arithmetic with date objects if needed
cdate + 1

#or generate a sequence of dates if needed
seqdate <- seq.Date(from = as.Date("2021-01-01"), by = "month", length.out = 12)
seqdate
str(seqdate)

#notice you have to have/create an existing date object to use seq.Date
seq.Date(from = "2021-01-01", by = "month", length.out = 12) #ack! doesn't work!

seq.Date(from = cdate, by = "year", length.out = 30)

#note: seq.Date is a little bit overkill because base R will recognize you have
#a date object if you just run seq
seq(from = cdate, by = "day", length.out = 29)


#okay so that's dates in base R, but what about times?

####Base R Times ####
#let's practice with as.POSIXct()
ctime <- "11:00:52"
str(ctime)
ctime <- as.POSIXct(ctime) #ack! error message already?!

#times get all sorts of messy..
#you basically always need to specify the format of our character string!
ctime <- as.POSIXct(ctime, format = "%H:%M:%S")
ctime
#woah.. now what the what? there's a date added on? and a random -04??
#this is because POSIXct creates a datetime object
str(ctime)

#if you do not supply a date and time zone it will automatically assume you mean
#your computer's current date/time zone

#this can be annoying, but luckily for us, we almost always have dates associated
#with our time records so we can combine those things as we will see later

#again we can generate a sequence if we want
seqtime <- seq.POSIXt(from = ctime, by = "sec", length.out = 30)
seqtime
str(seqtime)

#note: seq.POSIXt is a little bit overkill because base R will recognize you have
#a datetime object if you just run seq
seq(from = ctime, by = "hour", length.out = 10)


####lubridate package####
#so I find all the base R functions useful for quick transformations, but they
#can get finnicky really fast... 

#Enter the lubridate package! My favorite thing for more intense date/time moments

#I am going to run through some examples that are largely adapted from this site:
#https://r4ds.had.co.nz/dates-and-times.html
#check it out if you have more questions or want to see more examples

#lubridate equivalent of base R functions
cdate <- "2021-01-20"
cdate
str(cdate)
cdate <- ymd(cdate)
str(cdate)

#different format
cdate <- "01/20/2021"
str(cdate)
cdate <- mdy(cdate)
str(cdate)


#add time component
cdt <- "01/20/2021 08:01"
str(cdt)
cdt <- mdy_hm(cdt) 
cdt #notice it defaults to UTC time zone (you can specify a different one)
str(cdt)

#let's say you want to pull out specific parts of your date time object
year(cdt)
month(cdt)
month(cdt, label = T) #creates an ordered factor
mday(cdt) #day of the month
yday(cdt) #day of the year
wday(cdt) #day of the week
wday(cdt, label = T, abbr = F) #creates an ordered factor
hour(cdt)
minute(cdt)
second(cdt)

#what if excel messed up your data and all the sudden the year is off by one year?
#let's say we actually meant 2020 instead of 2021
year(cdt) <- 2020
cdt #woohoo! it changed to 2020

#maybe our times are two hours off for some reason?
hour(cdt) <- hour(cdt) + 2
cdt

#maybe we want to update all the parts of the date/time
update(cdt, year = 2020, month = 2, mday = 21, hour = 9)
#this can be useful if you want to iterate or generate a sequence

#There might also be times when you want to round a date or time
floor_date(cdt, "week") #notice this rounded to the earliest date in the week
floor_date(cdt, "week") %>% wday(label = T) 
#which is Sunday by default (you can change this though using week_start argument)

ceiling_date(cdt, "hour") #round to the next highest hour
round_date(cdt, unit = "5 mins") # round to the nearest 5 minute increment

#additional notes:
#time zones... I find it easiest to just work in UTC because that is often the
#default, but I understand that isn't always the case
#we are in "AST" to convert to UTC, you need to add 4 hours
#adding/subtracting dates and times can be tricky, there are some tools in the
#lubridate package to work through that. I don't have time to cover them today
#but we can work through some examples looking at durations/intervals in another
#sesh.

####Telemetry Run Through####
#we are going to look at some real deal telemetry data now!
#this data is direct csv export from VUE from my PhD telemetry work

#load some data to play with
#*note you will have to change the file path to wherever you saved the data file
d <- read.csv("Dates_Times/SampleVUEData.csv", header = T)

#first things first... let's look at it
head(d)
str(d)

#initial thoughts?
#for me, I don't love the column names that VUE spits out, I also don't need
#most of them so I'm gonig to do some quick data cleaning
d1 <- d %>% rename(DateTime_UTC = ï..Date.and.Time..UTC.,
             Station = Station.Name) %>% 
  select(DateTime_UTC, Receiver, Transmitter, Station, Latitude, Longitude)
head(d1)

#okay let's deal with our dates!
str(d1)

#how do we convert our DateTime column from a character string to a date/time?







#here's how I would do it
d1$DateTime_UTC <- ymd_hms(d1$DateTime_UTC)


#let's say I want to create a new column that only includes the hour of the day
#that the detection occurred
#how would I do that?











#here's how I would do it
d1$Hour <- hour(d1$DateTime_UTC)
head(d1)


#let's say we only want to look at detections that occur between 8PM and midnight,
#because that's when the squid boats usually start arriving to fish for squid
#How would you filter for detections that occur after 8PM but before midnight?








#here's how I would do it
d8PM <- filter(d1, Hour >= 20 & Hour <=24)
head(d8PM)


#Okay so let's say we now want to see how many tags are detected during the 
#squid time period by month
#let's make a plot! 
#we want the x axis to have months labeled with the abbreviated month label
#and the y axis to be the number of tags detected that month
#how would you do that?








#here's how I would do that
#create a quick data summary with what we want
d8PM2 <- d8PM %>% 
  mutate(MLab = month(DateTime_UTC, label = T)) %>% 
  group_by(MLab) %>% 
  summarize(Ntags = n_distinct(Transmitter))

ggplot(d8PM2) +
  geom_col(aes(x = MLab, y = Ntags)) +
  labs(x = "Month", y = "Number of Tags") +
  theme_classic()


d

#Kayla Blincow
#7/24/2024

#TCRMP plot

#The purpose of this script is to plot the lionfish TCRMP data

#NOTE: There's a weirdness where there are some instances where lionfish were 
#counted but they report no biomass..



#clear my workspace
rm(list = ls())

#load packages
library(tidyverse)
library(patchwork)
library(rstatix)

#load data files
biomass <- read.csv("Week 5/TCRMP_LionfishRawBiomass.csv")
count <- read.csv("Week 5/TCRMP_LionfishRawCount.csv")
sites <- read.csv("Week 5/TRCRMP_sitemetadata.csv")

allfish <- read.csv("Week 5/TCRMP_Master_Fish_Census_Dec2023.csv")


#need to recalculate biomass because wrong a/b values were used
#biomass equation: W = a*TL^b, a = 0.00794, b = 3.09 
newbiomass <- count %>% pivot_longer(cols = 9:19)
newbiomass$TL <- NA
newbiomass[newbiomass$name == "X0.5",]$TL <- 2.5
newbiomass[newbiomass$name == "X6.10",]$TL <- 7.5
newbiomass[newbiomass$name == "X11.20",]$TL <- 15.5
newbiomass[newbiomass$name == "X21.30",]$TL <- 25.5
newbiomass[newbiomass$name == "X31.40",]$TL <- 35.5
newbiomass[newbiomass$name == "X41.50",]$TL <- 45.5
newbiomass[newbiomass$name == "X51.60",]$TL <- 55.5
newbiomass[newbiomass$name == "X61.70",]$TL <- 65.5
newbiomass[newbiomass$name == "X71.80",]$TL <- 75.5
newbiomass[newbiomass$name == "X81.90",]$TL <- 85.5
newbiomass[newbiomass$name == "X91.100",]$TL <- 95.5

a <- 0.00794
b <- 3.09

newbiomass$biomass <- newbiomass$value*a*(newbiomass$TL^b)

biomass <- newbiomass %>% group_by(Location, SampleYear, SampleMonth, Period, Transect) %>% 
  summarize(SppTotal = sum(biomass))

#diagnostic checks of TCRMP data
allcheck <- allfish %>% filter(Period == "Annual") %>% 
  group_by(Location, SampleYear) %>% 
  reframe(ntrans = n_distinct(Transect))


allfish$SppTotal2 <- rowSums(allfish[,9:19])
inconsistenttotals <- allfish %>% filter(SppTotal != SppTotal2)
inconsistenttotals %>% filter(str_detect(CommonName, 'ionfish'))


#NEED TO STANDARDIZE BY EFFORT--TAKE INTO ACCOUNT AREA SURVEYED EACH YEAR AND
#REPORT RESULTS BASED ON /100M2
#REMOVE GINSBURG FRINGE?


#combine things

#counts
count <- count %>% 
  group_by(Location, SampleYear) %>% 
  reframe(TotalCount = sum(SppTotal, na.rm = T))

countcombo <- right_join(count, allcheck) 
countcombo[is.na(countcombo$TotalCount),]$TotalCount <- 0
countcombo[countcombo$Location == "Jacks",]$Location <- "Jacks Bay"

countcombo <- countcombo %>% 
  filter(SampleYear > 2010) %>% 
  mutate(Density = TotalCount/ntrans)


#biomass
biomass <- biomass %>% group_by(Location, SampleYear) %>% 
  reframe(TotalBiomass = sum(SppTotal, na.rm = T))

biomasscombo <- right_join(biomass, allcheck) 
biomasscombo[is.na(biomasscombo$TotalBiomass),]$TotalBiomass <- 0
biomasscombo[biomasscombo$Location == "Jacks",]$Location <- "Jacks Bay"

biomasscombo <- biomasscombo %>% 
  filter(SampleYear > 2010) %>% 
  mutate(Biomass = TotalBiomass/ntrans)


sites <- sites %>% dplyr::select(-Latitude, -Longitude, -YearAdded)

all <- left_join(countcombo, biomasscombo)
all <- left_join(all, sites)
all <- all %>% arrange(ReefComplex, SampleYear)


all_avg <- all %>% group_by(SampleYear, ReefComplex) %>% 
  summarize(mnCount = mean(Density),
            mnBiomass = mean(Biomass))

all$ReefComplex <- factor(all$ReefComplex, levels = c("Nearshore",
                                                      "Offshore",
                                                      "Mesophotic"))
all_avg$ReefComplex <- factor(all_avg$ReefComplex, levels = c("Nearshore",
                                                      "Offshore",
                                                      "Mesophotic"))

unique(all$Island)
all |> group_by(Island) |> summarize(n())

#Are there more lionfish on average on St. Thomas or St. Croix?
t.test(filter(all, Island == "STT")$Biomass, filter(all, Island == "STX")$Biomass)



#lionfish data for the students
studentlf <- all |> select(-Density, -TotalBiomass) |> filter(Island != "STJ")

write.csv(studentlf, "Week 5/TCRMP_Lionfish.csv", row.names = F)




predbio <- read.csv("Week 5/TCRMP_PredatorRawBiomass.csv")
predcount <- read.csv("Week 5/TCRMP_PredatorRawCount.csv")

count <- predcount %>% 
  filter(SampleYear > 2010) |> 
  group_by(Location, SampleYear, CommonName) %>% 
  reframe(TotalCount = sum(SppTotal, na.rm = T))

count <- all |> mutate(CommonName = "Lionfish") |> right_join(count)
count |> group_by(CommonName) |> summarize()

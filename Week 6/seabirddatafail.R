# Kayla Blincow
# 9/22/2026

# This script is cleaning data to prepare for the linear regression lab.

#clear my workspace
rm(list = ls())

#load my packages
library(tidyverse)

#load my data
beaufort_scale <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/beaufort_scale.csv')
birds <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/birds.csv')
sea_states <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/sea_states.csv')
ships <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/main/data/2026/2026-04-14/ships.csv')


# join birds and the ships
combo <- left_join(ships, birds)

#join combo with the beuafort scale data
combo1 <- left_join(combo, beaufort_scale)


#look for a linear relationship
ggplot(filter(combo1, species_common_name == "Black-billed gull"),
       aes(x = wind_speed_knots_max, y = count)) +
  geom_point()



#calculate CPUE per month per year
yearmonCPUE <- combo1 |> filter(year(date) > 1970) |> 
  group_by(year(date), month(date), species_common_name) |> 
  summarize(n10min = n_distinct(record_id), 
            CPUE = sum(count, na.rm = T)/(n10min*10),
            mean_maxwindspeed = mean(wind_speed_knots_max, na.rm = T)) |> 
  rename(Year = `year(date)`, Month = `month(date)`)

ggplot(yearmonCPUE, aes(x = Year, y = CPUE)) +
  geom_point(aes(color = species_common_name)) +
  theme(legend.position = "none")

ggplot(filter(yearmonCPUE, species_common_name == "Cape petrel", mean_maxwindspeed >10), 
              aes(x = mean_maxwindspeed, y = CPUE)) +
  geom_point(aes(color = species_common_name)) +
  theme(legend.position = "none")

yearmonCPUE |> group_by(species_common_name) |> summarize(total = n()) |> arrange(desc(total))


CapePetrel <- filter(yearmonCPUE, species_common_name == "Cape petrel", mean_maxwindspeed >10)
m1 <- lm(CPUE~mean_maxwindspeed, data = yearmonCPUE)
summary(m1)
plot(m1)


yearmonCPUE_follow <- combo1 |> filter(year(date) > 1970, following_ship == T) |> 
  group_by(year(date), month(date), species_common_name) |> 
  summarize(n10min = n_distinct(record_id), 
            CPUE = sum(count, na.rm = T)/(n10min*10),
            mean_maxwindspeed = mean(wind_speed_knots_max, na.rm = T)) |> 
  rename(Year = `year(date)`, Month = `month(date)`)

ggplot(filter(yearmonCPUE_follow, str_detect(species_common_name, "Wandering albatross")), 
      aes(x = Year, y = CPUE)) +
  geom_point(aes(color = species_common_name)) +
  theme(legend.position = "none"

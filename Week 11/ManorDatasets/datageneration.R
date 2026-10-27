# Kayla Blincow

# 10/27/2026

# Data Generation for the Blackwater Manor Incident Exercise

# clear my workspace
rm(list = ls())

# load packages
library(tidyverse)

# Room 1: The Entrance Hall
entrancehall <- data.frame(observation_id = 101:110,
                           temperature_c = round(c(rnorm(6, 12, .1),
                                             999.9,
                                             rnorm(3, 12, .05)), digits = 1),
                           nutrients_mg_l = c(sample(c(0.7, 0.8, 0.9), 6, replace = T),
                                              0.0, 
                                              sample(c(0.7, 0.8, 0.9), 3, replace = T)),
                           size_mm = round(c(rnorm(6, 4, .1),
                                       999.9,
                                       rnorm(3, 4, .05)), digits = 1))

write.csv(entrancehall, "Week 11/ManorDatasets/wren_initial_observations.csv", row.names = F)

# Room 2: The Library
library <- data.frame(species = c(rep("Aequorea victoria", 55),
                                  rep("Pyrodinium bahamense", 84),
                                  rep("Scina borealis", 164),
                                  rep("Euprymna scolopes", 37),
                                  rep("Watasenia scintillans", 54),
                                  rep("Phrixothrix hirtus", 6)),
                      date = seq(as.Date("1920-01-01"), as.Date("1922-10-22"),
                                       length.out = 400),
                      level = rep(c(1,2,3,4,5), 80),
                      funding = rep(c("NSF", "RGB", "OKD", "RFD", "NWR"), 80),
                      notes = rep(c("Observations suggest that feeding activity increases slightly under low-intensity blue light. However, the effect appears inconsistent across tanks. Several specimens showed no measurable change in feeding frequency. Repeat the experiment with more uniform lighting before drawing conclusions.",
                                    "Specimens maintained at slightly reduced salinity remained active throughout the observation period. At the lowest salinity tested, several individuals showed reduced movement. No clear pattern emerged between salinity and the duration of observed activity. The apparatus may require recalibration.",
                                    "Light production appears to increase following mechanical disturbance. The response is brief, lasting only several seconds in most observations. I have been unable to determine whether the intensity of the response depends on colony size. Additional measurements are needed, although the luminous display is remarkable.",
                                    "Feeding rates increased when prey density was elevated, though the relationship was not perfectly consistent among specimens. Several individuals continued feeding at low prey densities, while others showed little activity even when prey was abundant. Future trials should control for differences in specimen size and prior feeding history."), 100))
                      
library <- library[sample(1:nrow(library)),]
library[library$species=="Scina borealis" & library$level == 5,]$notes <-
  "The amphipods have responded unpredictably to changes in temperature. Some groups appear to grow at an extraordinary rate, while others exposed to similar temperatures remain relatively unchanged. I initially suspected an instrument malfunction. The results have now been repeated. The temperature hypothesis remains promising, but I cannot explain the inconsistency. Further experiments are required."

library[library$species=="Scina borealis" & library$level == 5,]$date <- "1926-10-12"

write.csv(library, "Week 11/ManorDatasets/wren_research_studies.csv")

# Room 3: The Specimen Room

# Generate dates for 30 days
set.seed(503)

specimenroom <-  tibble(
  date = seq(
    from = as.Date("1926-10-01"),
    by = "day",
    length.out = 30
  ),
  
  # Moderate temperature fluctuations
  temp_c = c(
    19.5, 20.1, 19.8, 20.4, 21.0,
    20.6, 21.3, 22.0, 21.7, 22.4,
    23.1, 22.6, 23.5, 24.0, 23.6,
    24.4, 25.1, 24.7, 25.5, 26.2,
    25.8, 26.5, 26.8, 26.1, 25.6,
    26.3, 25.9, 26.4, 26.7, 26.2
  ),
  
  # Growth rate (mm/day)
  # Growth generally increases with temperature,
  # then accelerates dramatically near the end.
  growth_rate_mm_day = c(
    0.4, 0.5, 0.6, 0.5, 0.7,
    0.6, 0.8, 0.9, 0.7, 1.0,
    1.2, 1.0, 1.4, 1.6, 1.3,
    1.8, 2.1, 2.0, 2.5, 3.1,
    3.8, 4.5, 5.2, 4.8, 5.7,
    6.5, 7.8, 9.2, 12.4, 14.1
  )
)

# Inspect the dataset
print(specimenroom)

# Plot growth rate over time
ggplot(specimenroom, aes(x = date, y = growth_rate_mm_day)) +
  geom_line() +
  geom_point(aes(color = temp_c)) +
  geom_hline(
    yintercept = 10,
    linetype = "dashed"
  ) +
  labs(
    title = "The Blackwater Amphipod Experiment",
    x = "Date",
    y = "Growth Rate (mm/day)"
  ) +
  theme_minimal()

# Export the dataset to a CSV file
write.csv(specimenroom, "Week 11/ManorDatasets/wren_growth_timeseries.csv", row.names = F)


# The Laboratory
# Generate simulated experimental data for Blackwater Manor
set.seed(503)

# Create a factorial experiment:
# 2 temperature conditions x 2 nutrient treatments
# 20 replicates per combination = 80 observations

experiment <- expand_grid(
  temperature_group = c("COOL", "WARM"),
  nutrient_treatment = c("LOW", "HIGH"),
  replicate = 1:20
) %>%
  mutate(
    # Add realistic variation around two temperature conditions
    temp_c = case_when(
      temperature_group == "COOL" ~ runif(n(), 20, 22),
      temperature_group == "WARM" ~ runif(n(), 25, 27)
    ),
    
    # Assign nutrient concentrations
    # Low nutrient treatment: 1-1.5 mg/L
    # High nutrient treatment: 4-5 mg/L
    nutrient_concentration = case_when(
      nutrient_treatment == "LOW" ~ runif(n(), 1, 1.5),
      nutrient_treatment == "HIGH" ~ runif(n(), 4, 5)
    ),
    
    # Calculate growth rate.
    # Temperature and nutrients have modest individual effects,
    # but their combination produces a dramatic growth response.
    growth_rate_mm_day =
      0.6 +
      0.1 * (temp_c - 20) +
      0.15 * (nutrient_concentration - 1) +
      0.45 * (temp_c - 20) * (nutrient_concentration - 1) +
      rnorm(n(), mean = 0, sd = 0.8),
    
    # Growth rate cannot be negative
    growth_rate_mm_day = pmax(0.1, growth_rate_mm_day)
  ) %>%
  select(
    replicate,
    temperature_group,
    temp_c,
    nutrient_treatment,
    nutrient_concentration,
    growth_rate_mm_day
  )

# Inspect the first few rows
head(experiment)

# Summarize growth by experimental treatment
experiment %>%
  group_by(temperature_group, nutrient_treatment) %>%
  summarize(
    mean_growth = mean(growth_rate_mm_day),
    sd_growth = sd(growth_rate_mm_day),
    n = n(),
    .groups = "drop"
  )

ggplot(experiment, aes(x = nutrient_treatment, y = growth_rate_mm_day)) +
  geom_jitter(height = 0) +
  geom_boxplot(alpha = 0.5)

t.test(growth_rate_mm_day~nutrient_treatment, data = experiment)

laboratory <- experiment |> select(replicate, nutrient_treatment, 
                                   growth_rate_mm_day)

# Export the dataset
write.csv(laboratory, "Week 11/ManorDatasets/wren_nutrient_experiment.csv", row.names = F)

experiment <- experiment |> select(replicate, temperature_group, nutrient_treatment, growth_rate_mm_day)
write.csv(experiment, "Week 11/ManorDatasets/wren_final_experiment.csv",
          row.names = F)

m1 <- aov(growth_rate_mm_day~temperature_group + nutrient_treatment, data = experiment)
m2 <- aov(growth_rate_mm_day~temperature_group*nutrient_treatment, data = experiment)

AIC(m1, m2)

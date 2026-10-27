set.seed(123)

marine_data <- data.frame(
  site = rep(c("Reef A", "Reef B", "Reef C"), each = 10),
  
  temperature = round(rnorm(30, mean = 28, sd = 1.5), 1),
  
  salinity = round(rnorm(30, mean = 35, sd = 1), 1),
  
  oxygen = round(rnorm(30, mean = 6.5, sd = 0.8), 1),
  
  turbidity = round(rlnorm(30, meanlog = 1, sdlog = 0.5), 1)
)

# Add a few missing values
marine_data$temperature[c(5, 17)] <- NA
marine_data$salinity[c(8, 24)] <- NA
marine_data$oxygen[c(12, 29)] <- NA
marine_data$turbidity[c(3, 21)] <- NA

# Look at the data
marine_data

write.csv(marine_data, "Week 8/reefwater.csv", row.names = F)

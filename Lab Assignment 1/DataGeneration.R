# MES 503 — Generate Ecological Data Visualization Dataset
# ------------------------------------------------------------------------------
# This script generates a synthetic ecological dataset for the MES 503
# R Coding Assignment.
#
# Instructor use only — students should receive the resulting CSV, not
# necessarily this script.
# ------------------------------------------------------------------------------

# For reproducibility
set.seed(503)

# ------------------------------------------------------------------------------
# 1. SET UP THE SAMPLING DESIGN
# ------------------------------------------------------------------------------

# Number of individuals to sample from each site
n_per_site <- 60

# Create sampling sites
sites <- c("North Reef",
           "South Reef",
           "Patch Reef",
           "Fringing Reef")

# Create the basic sampling dataframe
fish <- data.frame(
  site = rep(sites, each = n_per_site)
)

# Number of observations
n <- nrow(fish)


# ------------------------------------------------------------------------------
# 2. ASSIGN HABITAT
# ------------------------------------------------------------------------------

# Each site has somewhat different habitat representation.
fish$habitat <- sample(
  c("Coral Reef", "Seagrass", "Rubble"),
  size = n,
  replace = TRUE,
  prob = c(0.50, 0.30, 0.20)
)


# ------------------------------------------------------------------------------
# 3. ASSIGN SEX
# ------------------------------------------------------------------------------

fish$sex <- sample(
  c("Female", "Male"),
  size = n,
  replace = TRUE,
  prob = c(0.50, 0.50)
)


# ------------------------------------------------------------------------------
# 4. GENERATE DEPTH
# ------------------------------------------------------------------------------

# Generate depth with some site-level differences.
# Patch Reef tends to be shallower and South Reef somewhat deeper.

site_depth_mean <- c(
  "North Reef" = 12,
  "South Reef" = 18,
  "Patch Reef" = 8,
  "Fringing Reef" = 6
)

fish$depth_m <- rnorm(
  n,
  mean = site_depth_mean[fish$site],
  sd = 3
)

# Make sure depth is biologically reasonable
fish$depth_m <- pmax(fish$depth_m, 2)
fish$depth_m <- round(fish$depth_m, 1)


# ------------------------------------------------------------------------------
# 5. GENERATE BODY LENGTH
# ------------------------------------------------------------------------------

# Fish length is influenced by habitat and depth, but with substantial
# individual-level variation.

habitat_length_effect <- c(
  "Coral Reef" = 2,
  "Seagrass" = -1,
  "Rubble" = -2
)

fish$length_cm <- (
  25 +
    habitat_length_effect[fish$habitat] +
    0.15 * fish$depth_m +
    rnorm(n, mean = 0, sd = 4)
)

# Keep lengths biologically reasonable
fish$length_cm <- pmax(fish$length_cm, 12)
fish$length_cm <- pmin(fish$length_cm, 45)

fish$length_cm <- round(fish$length_cm, 1)


# ------------------------------------------------------------------------------
# 6. GENERATE BODY MASS
# ------------------------------------------------------------------------------

# Body mass is strongly related to length, but includes individual variation.

fish$mass_g <- (
  0.85 * fish$length_cm^3 +
    rnorm(n, mean = 0, sd = 800)
)

# Make sure mass is positive
fish$mass_g <- pmax(fish$mass_g, 100)

fish$mass_g <- round(fish$mass_g)/10


# ------------------------------------------------------------------------------
# 7. GENERATE REPRODUCTIVE OUTPUT
# ------------------------------------------------------------------------------

# Reproductive output is positively related to body size.
# Females also have somewhat higher reproductive output.

sex_effect <- ifelse(
  fish$sex == "Male",
  8,
  2
)

fish$reproductive_output <- (
  0.8 * fish$length_cm +
    sex_effect +
    rnorm(n, mean = 0, sd = 5)
)

# Reproductive output cannot be negative
fish$reproductive_output <- pmax(
  fish$reproductive_output,
  0
)

fish$reproductive_output <- round(
  fish$reproductive_output,
  1
)/10

fish <- fish |> rename(gonadosomatic_index = reproductive_output)

# ------------------------------------------------------------------------------
# 8. ADD A FEW MORE ECOLOGICALLY USEFUL VARIABLES
# ------------------------------------------------------------------------------

# Algal cover varies among habitat types.
habitat_algae_mean <- c(
  "Coral Reef" = 20,
  "Seagrass" = 45,
  "Rubble" = 60
)

fish$algae_cover <- rnorm(
  n,
  mean = habitat_algae_mean[fish$habitat],
  sd = 10
)

fish$algae_cover <- pmax(fish$algae_cover, 0)
fish$algae_cover <- pmin(fish$algae_cover, 100)

fish$algae_cover <- round(
  fish$algae_cover,
  1
)


# Fish density varies among sites.
site_density_mean <- c(
  "North Reef" = 18,
  "South Reef" = 25,
  "Patch Reef" = 12,
  "Fringing Reef" = 9
)

fish$fish_density <- rnorm(
  n,
  mean = site_density_mean[fish$site],
  sd = 5
)

fish$fish_density <- pmax(
  fish$fish_density,
  1
)

fish$fish_density <- round(
  fish$fish_density,
  1
)


# ------------------------------------------------------------------------------
# 9. INTRODUCE SOME MISSING DATA
# ------------------------------------------------------------------------------

# Real ecological datasets rarely have complete observations.
# Introduce a small amount of missingness.

set.seed(504)

missing_length <- sample(
  1:n,
  size = round(0.03 * n)
)

missing_reproduction <- sample(
  1:n,
  size = round(0.05 * n)
)

missing_depth <- sample(
  1:n,
  size = round(0.02 * n)
)

fish$length_cm[missing_length] <- NA

fish$reproductive_output[missing_reproduction] <- NA

fish$depth_m[missing_depth] <- NA


# ------------------------------------------------------------------------------
# 10. ROUND / ORGANIZE VARIABLES
# ------------------------------------------------------------------------------

fish$site <- factor(fish$site)

fish$habitat <- factor(fish$habitat)

fish$sex <- factor(fish$sex)

# Reorder columns to make the dataset easier for students to understand.

fish <- fish[, c(
  "site",
  "habitat",
  "sex",
  "depth_m",
  "length_cm",
  "mass_g",
  "reproductive_output",
  "algae_cover",
  "fish_density"
)]


# ------------------------------------------------------------------------------
# 11. LOOK AT THE DATA
# ------------------------------------------------------------------------------

head(fish)

str(fish)

summary(fish)


# ------------------------------------------------------------------------------
# 12. SAVE THE DATA AS A CSV
# ------------------------------------------------------------------------------

write.csv(
  fish,
  "yellowtail_snapper.csv",
  row.names = FALSE
)

# The CSV will be saved in your current working directory.
#
# You can check your working directory with:
#
# getwd()


# ------------------------------------------------------------------------------
# END OF SCRIPT
# ------------------------------------------------------------------------------
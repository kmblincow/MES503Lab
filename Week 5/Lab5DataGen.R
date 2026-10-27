# Lab 5 activity data gen

mangroves <- data.frame(
  seedling_id = 1:30,
  site = rep(c("Site_A", "Site_B", "Site_C"), each = 10),
  species = rep(c("Red", "Black", "Red", "Black", "Red"), times = 6),
  zone = rep(c("Shoreline", "Shoreline", "Shoreline",
               "Shoreline", "Shoreline",
               "Inland", "Inland", "Inland",
               "Inland", "Inland"), times = 3),
  height_cm = c(
    42, 38, 45, 40, 44,
    57, 61, 54, 59, 63,
    35, 39, 42, 37, 41,
    52, 56, 49, 55, 58,
    47, 43, 46, 50, 45,
    64, 60, 67, 62, 65
  ),
  leaf_number = c(
    8, 7, 9, 8, 10,
    13, 15, 12, 14, 16,
    6, 8, 9, 7, 8,
    12, 13, 11, 14, 15,
    10, 9, 11, 12, 10,
    16, 15, 18, 17, 16
  ),
  stem_diameter_mm = c(
    4.2, 3.8, 4.5, 4.0, 4.4,
    5.7, 6.1, 5.4, 5.9, 6.3,
    3.5, 3.9, 4.2, 3.7, 4.1,
    5.2, 5.6, 4.9, 5.5, 5.8,
    4.7, 4.3, 4.6, 5.0, 4.5,
    6.4, 6.0, 6.7, 6.2, 6.5
  ),
  salinity_ppt = c(
    34, 35, 36, 34, 35,
    25, 24, 26, 25, 23,
    36, 37, 35, 36, 38,
    26, 25, 27, 24, 26,
    33, 34, 32, 35, 33,
    22, 24, 23, 25, 22
  ),
  light_percent = c(
    78, 82, 75, 80, 77,
    48, 52, 45, 50, 46,
    85, 81, 88, 83, 86,
    55, 50, 58, 53, 51,
    72, 75, 70, 74, 73,
    42, 45, 40, 47, 44
  )
)

write.csv(mangroves, "Week 5/mangrove.csv", row.names = F)

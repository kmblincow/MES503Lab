# ==============================================================================
# YOUR TURN — EXTRA CHALLENGE
# ==============================================================================

# Recreate the figure shown on the slides (use only the most common tissue type).
gsb2 <- filter(gsb, TissueType == "Fin") |> drop_na(TotalLength)

gsb2$Stage <- "Transition"

gsb2[gsb2$TotalLength < 56,]$Stage <- "Immature"
gsb2[gsb2$TotalLength > 90 ,]$Stage <- "Mature"


gsb2$Stage <- factor(gsb2$Stage,
                     levels = c("Mature",
                                "Transition",
                                "Immature"),
                     labels = c("Mature (TL > 90 cm)",
                                "Transition (56 cm < TL < 90 cm)",
                                "Immature (TL < 56 cm)"))
ggplot(gsb2, aes(x = C13, y = N15, color = Stage,
                 shape = Stage)) +
  geom_point(size = 2.5) + 
  scale_color_viridis_d() +
  labs(x = expression(delta~" "^15~N), 
       y = expression(delta~" "^13~C)) +
  theme_classic() +
  theme(legend.position = "top")
# Mystery data files

mystery1 <- data.frame(code = sort(rep(c(468, 493,498, 638), 50)),
                       measurement = c(rnorm(50, 20, 5),
                         rnorm(50, 40, 5),
                         rnorm(50, 40, 5),
                         rnorm(50, 100, 5)),
                       score = rep(sample(1:5, 50, replace = T), 4)
                       )

mystery2 <- data.frame(code = 1:length(colors()),
                       hue = colors())

mystery <- left_join(mystery1, mystery2)
m1 <- aov(measurement~hue, data = mystery)
summary(m1)
TukeyHSD(m1)
leveneTest(m1)

write.csv(mystery1, "Week 7/mysterydata1.csv", row.names = F)
write.csv(mystery2, "Week 7/mysterydata2.csv", row.names = F)

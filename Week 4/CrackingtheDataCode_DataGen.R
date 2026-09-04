# Generate the data for the Cracking the Data Code exercise

#Kayla Blincow
#9/4/2026


#clear my workspace
rm(list = ls())

#load my packages
library(tidyverse)

#create ze data
crack <- data.frame(sew1 = rnorm(1000, 100, 1),
                    pass2 = rep("word", 1000),
                    ret3 = rnorm(1000, 0, 1),
                    red4 = runif(1000, 0, 1),
                    grn5 = runif(1000, 0, 10),
                    blu6 = round(runif(1000, 1, 1000), digits = 0),
                    pur7 = 1:1000,
                    yel8 = c(rep("pec", 250), rep("rec", 250), rep("sec", 250), rep("lec", 250)),
                    cer9 = c(rep(1, 786), 2, rep(1, 213)),
                    wes10 = rnorm(1000, 5000, 200),
                    sew11 = rnorm(1000, 100, 1),
                    sewa = rnorm(1000, 100, 1),
                    passa = rep("word", 1000),
                    reta = rnorm(1000, 0, 1),
                    reda = runif(1000, 0, 1),
                    grna = runif(1000, 0, 10),
                    blua = round(runif(1000, 1, 1000), digits = 0),
                    pura = 1:1000,
                    yela = c(rep("pec", 250), rep("rec", 250), rep("sec", 250), rep("lec", 250)),
                    cera = c(rep(1, 786), 2, rep(1, 213)),
                    wesa = rnorm(1000, 5000, 200),
           pass = rep("word", 1000),
           ret = rnorm(1000, 0, 1),
           red = runif(1000, 0, 1),
           grn = runif(1000, 0, 10),
           blu = round(runif(1000, 1, 1000), digits = 0),
           pur = 1:1000,
           yel = c(rep("pec", 250), rep("rec", 250), rep("sec", 250), rep("lec", 250)),
           cer = c(rep(1, 786), 2, rep(1, 213)),
           wes = rnorm(1000, 5000, 200),
           sew = rnorm(1000, 100, 1),
           passt = rep("word", 1000),
           rett = rnorm(1000, 0, 1),
           redt = runif(1000, 0, 1),
           grnt = runif(1000, 0, 10),
           blut = round(runif(1000, 1, 1000), digits = 0),
           purt = 1:1000,
           yelt = c(rep("pec", 250), rep("rec", 250), rep("sec", 250), rep("lec", 250)),
           cert = c(rep(1, 786), 2, rep(1, 213)),
           west = rnorm(1000, 5000, 200),
           sew14 = rnorm(1000, 100, 1),
           pass14 = rep("word", 1000),
           ret14 = rnorm(1000, 0, 1),
           red14 = runif(1000, 0, 1),
           grn14 = runif(1000, 0, 10),
           blu14 = round(runif(1000, 1, 1000), digits = 0),
           pur14 = 1:1000,
           yel14 = c(rep("pec", 250), rep("rec", 250), rep("sec", 250), rep("lec", 250)),
           cer14 = c(rep(1, 786), 2, rep(1, 213)),
           wes14 = rnorm(1000, 5000, 200)
           )

# generate the code

#pw1: sec
crack |> arrange(desc(yel)) |> select(yel) |> head(1)


#pw2: ret
names(crack)[23]

#pw3
crack |> filter(blu6 == 826 & pura == 652) |> select(blu)

#pw4
crack[787,29]


write.csv(crack, "Week 4/crackingthedatacode.csv")

# GitHub for Fisheries Scientists
# May 25, 2021
# Justin Priest & Sara Miller
# justin.priest@alaska.gov
# sara.miller@alaska.gov




#####      DEMO SCRIPT      ####
# Data are from ADF&G Coho Collections
# Shaul et al. 2019
# Stock Status and Review of Factors Affecting Coho Salmon 
#   Returns and Escapements in Southeast Alaska
# http://www.adfg.alaska.gov/FedAidPDFs/RIR.1J.2019.12.pdf


library(tidyverse)
library(lubridate)
library(ggridges)




agedata <- read_csv("data/ADFG_smoltages_AukeBernersHughSmith.csv") %>%
  mutate(Date = ymd(as.POSIXct(Date, format = "%m/%d/%Y", tz = "US/Alaska")),
         species = "Coho Salmon",
         year = year(Date)) %>%
  rename("location" = "Location",
         "collectiondate" = "Date",
         "fw_age" = "Age",
         "length_mm" = "Length") %>%
  mutate(location = replace(location, location == "AL", "Auke Lake"),
         location = replace(location, location == "BR", "Berners River"),
         location = replace(location, location == "HS", "Hugh Smith Lake")) %>%
  dplyr::select(species, location, year, everything()) # reorder columns

agedata # View data 



### FIGURES

ggplot(agedata, aes(x = as.factor(fw_age), y = length_mm, fill = as.factor(fw_age))) + 
  geom_boxplot() +
  scale_fill_manual(values = c("#F78D71", "#B5517D", "#463075")) +
  labs(x = "Freshwater Age", 
       y = "Length (mm)") +
  facet_wrap(~location) 


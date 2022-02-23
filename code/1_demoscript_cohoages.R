# GitHub for Fisheries Scientists
# February 23, 2022
# Justin Priest & Sara Miller
# justin.priest@alaska.gov
# sara.miller@alaska.gov



#####      DEMO SCRIPT      ####
# Data are from ADF&G SEAK Coho Collections
# Shaul et al. 2019
# Stock Status and Review of Factors Affecting Coho Salmon 
#   Returns and Escapements in Southeast Alaska
# http://www.adfg.alaska.gov/FedAidPDFs/RIR.1J.2019.12.pdf


### LIBRARIES
library(tidyverse)
library(lubridate)
library(ggridges)

### DATA IMPORT
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
  facet_wrap(~location) +
  theme_light() +
  theme(
    legend.position = "none",
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.background = element_rect(fill = NA, color = NA),
    strip.text.x = element_text(color = "gray30"),
  )



densityplot <- ggplot(agedata, aes(x = length_mm, fill = as.factor(fw_age))) + 
  geom_density(alpha = 0.5) +
  scale_fill_manual(values = c("#F78D71", "#B5517D", "#463075")) +
  labs(x = "Length (mm)",
       y = "Density proportion") +
  facet_wrap(~location) +
  theme_light() +
  theme(
    legend.position = "none",
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    strip.background = element_rect(fill = NA, color = NA),
    strip.text.x = element_text(color = "gray30"),
  )
densityplot
ggsave("output/densityfig.png", densityplot, width = 6, height = 3, units = "in", dpi = 300)



# Exploratory geom_ridges plot

ggplot(agedata, aes(y = year, x= length_mm, group = year)) +
  geom_density_ridges(alpha = 0.8, fill = "#B5517D") +
  theme_light() +
  facet_wrap(~location)

I made some changes here.

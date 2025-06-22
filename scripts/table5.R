#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
# Description: need metro median scores by race and metro child pop by race, and for the 100 largest metros combined

#TODO: finish

# clear environment
rm(list=ls()); gc()

# libraries
library(RMariaDB)
library(tidyverse)
library(data.table)

# functions
source("resources/fun/SQL_load.R")

# path
HOME <- "C:/Users/bdevoe/Desktop/SQL/viz_data"


#-------------------------------------------------------------------------------
# load and merge data
#-------------------------------------------------------------------------------

# load geo ids
geo <- SQL_load(database = "COI30_2025", table_id = "COI30_TRACT_GEO_20", overwrite = F, noisily = F)
geo <- select(geo, c(metro_name, in100))
geo <- unique(geo)
rm(HOME, SQL_load)

# metro normed metro medians
metro_medians <- fread("C:/Users/bdevoe/Desktop/SQL/METROS/COI_20_metros_nat_medians/COI_20_metros_nat_medians.csv")

# metro counts
metro_count <- fread("C:/Users/bdevoe/Desktop/SQL/METROS/COI_20_metros_met_counts/COI_20_metros_met_counts.csv")

# merge data
asdf
metro_medians <- left_join(metro_medians, geo)
rm(geo)

# merged metro data
metro_merged <- left_join(metro_medians, metro_count)
rm(metro_medians, metro_count)

#-------------------------------------------------------------------------------
# process data
#-------------------------------------------------------------------------------

# filter rows to top 100 metros
metro_merged <- filter(metro_merged, in100 == 1)

# filter rows to 2023
metro_merged <- filter(metro_merged, year == "2023")

# filter out num_tracts
metro_merged <- filter(metro_merged, group != "num_tracts")

# select columns
metro_merged <- select(metro_merged, c(metro_name, year, group, median_opp_score, normed))

# pivot wide
metro_merged <- pivot_wider(metro_merged, names_from = group, values_from = median_opp_score)


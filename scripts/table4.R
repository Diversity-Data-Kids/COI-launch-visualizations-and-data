#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
# Description: metro median score gaps across race and VL-VH
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

# merge data
metro_medians <- left_join(metro_medians, geo)
rm(geo)



#-------------------------------------------------------------------------------
# process data
#-------------------------------------------------------------------------------

# filter rows to top 100 metros
metro_medians <- filter(metro_medians, in100 == 1)

# filter rows to 2023
metro_medians <- filter(metro_medians, year == "2023")

# filter out num_tracts
metro_medians <- filter(metro_medians, group != "num_tracts")

# select columns
metro_medians <- select(metro_medians, c(metro_name, year, group, median_opp_score, normed))

# pivot wide
metro_medians <- pivot_wider(metro_medians, names_from = group, values_from = median_opp_score)

# compute white gaps
metro_medians$BW_gap   <- metro_medians$white - metro_medians$black
metro_medians$AW_gap   <- metro_medians$white - metro_medians$asian
metro_medians$ApiW_gap <- metro_medians$white - metro_medians$aian
metro_medians$HW_gap   <- metro_medians$white - metro_medians$hisp


#TODO: need VL and VH median score to compute gap
#      I think we use opp_gap folder?


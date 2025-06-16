#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
# Description: nationally normed COI levels, nationally normed for the 100 largest metro areas

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

# metro normed metro percentages
metro_percentages <- fread("C:/Users/bdevoe/Desktop/SQL/METROS/COI_20_metros_nat_percentages/COI_20_metros_nat_percentages.csv")

# merge data
metro_percentages <- left_join(metro_percentages, geo)
rm(geo)


#-------------------------------------------------------------------------------
# process data
#-------------------------------------------------------------------------------

# filter rows to top 100 metros
metro_percentages <- filter(metro_percentages, in100 == 1)

# filter rows to total
metro_percentages <- filter(metro_percentages, group == "total")

# filter rows to 2023
metro_percentages <- filter(metro_percentages, year == "2023")

# select columns
metro_percentages <- select(metro_percentages, c(metro_name, year, group, high, low, missing, moderate, very_high, very_low, group_lbl, normed, in100))

#-------------------------------------------------------------------------------
# save
#-------------------------------------------------------------------------------

fwrite(metro_percentages, file = "data/output/table3.csv")


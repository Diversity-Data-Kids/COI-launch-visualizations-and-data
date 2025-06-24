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


#-------------------------------------------------------------------------------
# compute race/ethnicity gaps
#-------------------------------------------------------------------------------

# filter
metro_medians_race_gaps <- filter(metro_medians, lbl %in% c("all"))

# select
metro_medians_race_gaps <- select(metro_medians_race_gaps, c(metro_name, year, lbl, group, median_opp_score, normed))

# pivot wide
metro_medians_race_gaps <- pivot_wider(metro_medians_race_gaps, names_from = group, values_from = median_opp_score)

# compute white - r/e gaps
metro_medians_race_gaps$BW_gap   <- metro_medians_race_gaps$white - metro_medians_race_gaps$black
metro_medians_race_gaps$AW_gap   <- metro_medians_race_gaps$white - metro_medians_race_gaps$asian
metro_medians_race_gaps$ApiW_gap <- metro_medians_race_gaps$white - metro_medians_race_gaps$aian
metro_medians_race_gaps$HW_gap   <- metro_medians_race_gaps$white - metro_medians_race_gaps$hisp


#-------------------------------------------------------------------------------
# compute overall opportunity gap
#-------------------------------------------------------------------------------

# filter
metro_medians_oppgap <- filter(metro_medians, lbl %in% c("very_high", "very_low") & group == "total")

# select
metro_medians_oppgap <- select(metro_medians_oppgap, c(metro_name, year, lbl, median_opp_score, normed))

# pivot wide
metro_medians_oppgap <- pivot_wider(metro_medians_oppgap, names_from = lbl, values_from = median_opp_score)

# set missing data to 0. NOTE: for certain the only NA is a result from pivoting
#                              the lbl column. In the aggregation script a row is not
#                              recorded when a value is zero.
metro_medians_oppgap[is.na(metro_medians_oppgap)] <- 0

# compute opp gap
metro_medians_oppgap$overall_gap   <- metro_medians_oppgap$very_high - metro_medians_oppgap$very_low


#-------------------------------------------------------------------------------
# final processing and save
#-------------------------------------------------------------------------------

# merge race/ethnicity gap with overall gap
metro_medians <- full_join(metro_medians_race_gaps, metro_medians_oppgap)
rm(metro_medians_race_gaps, metro_medians_oppgap)

# save
fwrite(metro_medians, file = "data/output/table4.csv")




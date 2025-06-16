#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
# Description: 100 largest metros combined, nationally normed, COI levels by race and year

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


# aggregate over metros
metro_percentages <- metro_percentages %>%
  group_by(year, group) %>%
  summarise(
    high = mean(high, na.rm = TRUE),
    low = mean(low, na.rm = TRUE),
    missing = sum(missing, na.rm = TRUE),
    moderate = mean(moderate, na.rm = TRUE),
    very_high = mean(very_high, na.rm = TRUE),
    very_low = mean(very_low, na.rm = TRUE),
    group_lbl = first(group_lbl),
    normed = first(normed),
    .groups = "drop"
  ) %>%
  mutate(
    sort_var = case_when(
      group == "total" ~ 1,
      group == "white" ~ 2,
      group == "black" ~ 4,
      group == "hisp" ~ 3,
      group == "asian" ~ 5,
      group == "aian" ~ 6,
      group == "num_tracts" ~ 7,
      TRUE ~ NA_real_
    )
  )


#-------------------------------------------------------------------------------
# save
#-------------------------------------------------------------------------------

fwrite(metro_percentages, file = "data/output/table2.csv")



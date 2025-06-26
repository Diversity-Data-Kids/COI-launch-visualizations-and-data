#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
# Description: metro level median life expectancy for VL, for VH, and the gap (VH-VL)

# clear environment
rm(list=ls()); gc()

# libraries
library(RMariaDB)
library(tidyverse)
library(data.table)

# functions
source("resources/fun/SQL_load.R")
source("resources/fun/SQL_table_id_list.R")

# path
HOME <- "C:/Users/bdevoe/Desktop/SQL/viz_data"





# trying to find median income and outcome
tables_DDK <- SQL_table_id_list(database = "DDK")
tables_ACS <- SQL_table_id_list(database = "ACS")
# tables_COI <- SQL_table_id_list(database = "COI")
tables_COI3_2025 <- SQL_table_id_list(database = "COI30_2025")




#-------------------------------------------------------------------------------
# load and merge data
#-------------------------------------------------------------------------------

# load metrics data
metrics <- SQL_load(database = "DDK", table_id = "METRICS_10", overwrite = F, noisily = F)

metrics <- head(metrics, 100)


fwrite(metrics, "metrics.csv")

# load geo ids
geo <- SQL_load(database = "COI30_2025", table_id = "COI30_TRACT_GEO_20", overwrite = F, noisily = F)
geo <- select(geo, c(metro_name, in100))
geo <- unique(geo)
rm(HOME, SQL_load)


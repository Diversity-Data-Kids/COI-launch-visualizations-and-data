#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
# Description: metro level median life expectancy for VL, for VH, and the gap (VH-VL)

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

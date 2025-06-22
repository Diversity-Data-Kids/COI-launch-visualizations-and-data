#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
# Description: 100 metros, median income for VL, median income for VH, income gap (VH-VL)

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


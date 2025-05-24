#-------------------------------------------------------------------------------
# Header
#-------------------------------------------------------------------------------
# Description: need metro median scores by race and metro child pop by race,
#              and for the 100 largest metros combined
#
# NOTES: Cannot do anything without metro level data? Check COI db vs COI30_2025

# remove environment
rm(list=ls()); gc()

# libraries
library(RMySQL)
library(tidyverse)

#-------------------------------------------------------------------------------
# Connection
#-------------------------------------------------------------------------------
# connect to mysql database at BU as DDK_dba (database administrator)
con <- dbConnect(
  RMySQL::MySQL(),
  host='buaws-aws-cf-mysql-prod2.cenrervr4svx.us-east-2.rds.amazonaws.com',
  port=3306,
  user='DDK_dba',
  password='3RZc325sF472')


#-------------------------------------------------------------------------------
# check tables in db
#-------------------------------------------------------------------------------
dbGetQuery(con, "SHOW DATABASES;")
dbExecute( con, "USE COI30_2025;")
dbGetQuery(con, "SHOW TABLES;")


#-------------------------------------------------------------------------------
# load table and disconnect from db
#-------------------------------------------------------------------------------
dt1 <- RMariaDB::dbGetQuery(con, "SELECT * FROM COI30_TRACT_INDEX_20;")
dt2 <- RMariaDB::dbGetQuery(con, "SELECT * FROM COI30_TRACT_POP_20;")
dbDisconnect(con);rm(con)


#-------------------------------------------------------------------------------
# generate new table
#-------------------------------------------------------------------------------
# columns: metro_name, tot_score,	white_score, black_score,api_score, hisp_score
#                      total,	    white,	     black,	     api,	      hisp

# select columns
dt <- select(dt, c(geoid20,year,c5_COI_met))





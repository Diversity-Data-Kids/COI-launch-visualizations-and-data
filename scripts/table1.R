################################################################################

# Description: metro normed opportunity levels by race for 100 largest metros and all years


# libraries
library(RMySQL)
library(tidyverse)

################################################################################
rm(list=ls()); gc()
################################################################################

# connect to mysql database at BU as DDK_dba (database administrator)
con <- dbConnect(
  RMySQL::MySQL(),
  host='buaws-aws-cf-mysql-prod2.cenrervr4svx.us-east-2.rds.amazonaws.com',
  port=3306,
  user='DDK_dba',
  password='3RZc325sF472')

# show privileges of DDK_dba
dbGetQuery(con, "SHOW PRIVILEGES;")


dbGetQuery(con, "SHOW DATABASES;")
dbExecute( con, "USE COI30_2025;")
dbGetQuery(con, "SHOW TABLES;")


dt <- RMariaDB::dbGetQuery(con, "SELECT * FROM COI30_TRACT_INDEX_20;")


dbDisconnect(con);rm(con)



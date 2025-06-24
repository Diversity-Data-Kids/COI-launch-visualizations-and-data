#' @name   SQL_table_id_list
#' @title  List/return table IDs
#' @author brian devoe
#'
#' @description
#' List available tables in COI SQL database, excluding dictionary and metadata tables. Returns tables as character vector.
#'
#' @param database Name of database to connect to, character vector of length 1. Default is "DDK".


# function list tables
SQL_table_id_list <- function(database = "DDK"){

  # Connect to BU
  con <- dbConnect(MariaDB(),
                   host = "buaws-aws-cf-mysql-prod2.cenrervr4svx.us-east-2.rds.amazonaws.com",
                   port = 3306,
                   user = Sys.getenv("DDK_read_only"),
                   password = Sys.getenv("DDK_read_only_pass"))

  # Connect to database
  RMariaDB::dbExecute(con, paste0("USE ", database, ";")) # Clemens: changed this to dbExecute

  # load tables list and convert to vector
  tables <- RMariaDB::dbGetQuery(con, "SHOW TABLES;")
  tables <- tables[, 1]

  # Remove dictionary and metadata tables
  tables <- tables[!grepl("_dict", tables)]
  tables <- tables[!grepl("_metadata", tables)]

  # disconnect from server
  RMariaDB::dbDisconnect(con); rm(con)

  # return
  cat("\n")
  cat(paste0("Tables in ", database, " database:\n\n"))
  cat(paste0("  ", tables), sep="\n")
  cat("\n")

  return(as.character(tables))

}

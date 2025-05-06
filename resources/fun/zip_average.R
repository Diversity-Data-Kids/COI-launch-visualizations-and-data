#' @name  zip_average
#' @title Computes a weighted average across census tract data within ZIP codes
#' @author Yang Lu and Clemens Noelke
#'
#' @description
#' This function computes the ZIP code weighted average of census tract data.
#'
#' It takes as input a data table with a "geoid" column uniquely identifying census tracts.
#' If the data table does not contain a "year" column, it is assumed that GEOID uniquely identifies rows
#' If the data table includes a year column (type integer), it assumes that "geoid" and "year" uniquely
#' identify rows.
#'
#' The year scope of the function currently is 2012 to 2021. For these years, we currently have crosswalks
#' that link 2010 census tract to ZIP codes in the XWALKS database. For 2022+. we will need to add crosswalks
#' that link 2020 census tract to ZIP codes. Currently, the vintage option is defaults set to 10.
#' In other words, the function currently averages data for 2010 census tracts to ZIP codes as they were defined between
#' 2012 and 2021.
#'
#' @param dt  A data table containing a "geoid" and, optionally, and integer-scaled year column with four digit years
#' @param vin Census tract vintage, currently defaults to "10", for data on 2010 census tract
#' @param thr A threshold for the total ratio of the crosswalks. Default is 0.5.
#' @param wgt A threshold for the total ratio of the crosswalks. Default is 0.5.
#' @param yr  If data table does not contain a year column, this parameter is required and defines ZIP code vintage year.
#' @param lw  If lw=TRUE, remove all rows that have missing values in any of the outcome variables. The default is TRUE.
#' If lw=FALSE and more than one outcome with different missing patterns is used, then the tract-ZIP segments and threshold-specific exclusions will
#' differ from outcome to outcome.
#' @param overwrite  Default is TRUE. If FALSE and crosswalk has been downloaded exists in /data/source_data/xwalks/ folder,
#' function will load crosswalk from csv file using a dictionary (i.e., with correct types). If TRUE, function will download table from
#' SQL database and overwrite the existing csv file.

zip_average <- function(dt=NULL, vars=NULL, thr=NULL, lw=T, yr=NULL, overwrite=T, vin="10") {

  # Function specific objects, main difference between zip_average and zip_allocate
  by_cols <- c("zip", "year")
  cw_type <- "ZIP_TRACT"

  ################################################################################

  # Initial checks
  if(is.null(dt))  stop("dt parameter is required")
  if(is.null(vin)) stop("vin parameter is required")

  ################################################################################

  # Function to adjust weights and ensure they sum to one within the group
  check_one <- function(dt=NULL, by_cols=NULL, abort=T) {

    dt <- dt[, sum(wgt), by=by_cols]
    dt <- round(dt$V1, 6)
    dt <- unique(dt)
    dt <- length(dt)==1

    if (dt==FALSE) {
      if (abort==T) stop("Weights don't sum to 1.")
      else print("Weights don't sum to 1 within zip-years.")
    } else {
      # print("Weights sum to 1 within zip-years.")
    }

  }

  ################################################################################

  ### Prep data to be aggregated

  # data table
  dt <- as.data.table(dt)

  # Check/add year
  if (("year" %in% colnames(dt))) {
    years <- unique(dt$year)
  } else {
    # Check if vector year is defined
    if (is.null(yr)) stop("If the data table does not contain a year column, the 'yr' parameter is required.")
    dt$year <- as.integer(yr)
    years   <- as.integer(yr)
    check_duplicates(dt, paste0("geoid", vin))
  }

  setnames(dt, paste0("geoid", vin), "geoid")

  ################################################################################

  ### Crosswalk
  print(paste0("Loading ", cw_type, " crosswalk for"))
  print(years)

  # Load dictionary
  # print(SQL_dict("XWALKS", paste0("ZIP_XWALKS_", vin,"_dict")))

  # Load crosswalks for years, pay attention to overwrite option.
  xw <- rbindlist(lapply(  years, function(year) SQL_load("XWALKS", paste0(cw_type, "_", vin, "_", year), overwrite=overwrite, noisily=F) ))

  # Ensure that weights sum to one
  check_one(xw, by_cols)

  ####################################################################################################

  print("Averaging census tract data within ZIP codes...")

  # Checks
  if(is.null(vars)) stop("vars parameter is required")
  if(is.null(thr))  stop("thr parameter is required")
  if (any(years > 2021 | years < 2012)) stop("The year values (or yr parameter) must be between 2012 and 2021.")

  # Perform listwise deletion
  if (lw==T) dt <- na.omit(dt)

  # Results list
  dt_list <- vector("list", length(vars))

  for (vr in 1:length(vars)) {

    # Subset
    dt1 <- subset_dt(dt, c("geoid", "year", vars[vr]))

    # Drop missings
    dt1 <- na.omit(dt1)

    # Merge on crosswalk and drop tracts with missing outcomes
    dt1 <- check_merge(xw, dt1, keys = c("geoid", "year"), join_type = "inner", abort = FALSE, noisily=F)

    # Sum up weights
    dt1 <- dt1[, total_weight := sum(wgt), by=by_cols]

    # Only keep ZIPs that are at least e.g. 50% observed (thr=0.5)
    dt1 <- dt1[total_weight >= thr]
    dt1$total_weight <- NULL

    # Recompute weights
    dt1 <- dt1[, wgt := wgt / sum(wgt), by=by_cols]
    check_one(dt1, by_cols)

    # Replace vars[vr] with weighted values
    dt1 <- dt1[, (vars[vr]) := wgt * get(vars[vr])]

    # Sum up to ZIP code
    check_miss(dt1, noisily=F)
    dt1 <- dt1[, sum(get(vars[vr])), by=by_cols]
    setnames(dt1, "V1", vars[vr])

    # Store results
    dt_list[[vr]] <- dt1; rm(dt1)

  }

  # Merge all tables in dt_list on by_cols
  dt <- Reduce(function(data1, data2) check_merge(data1, data2, keys=by_cols, join_type="outer", abort=F, noisily=F), dt_list)

  # Checks
  if (lw==T) check_miss(dt, noisily=F)
  check_duplicates(dt, by_cols, noisily=F)

  # Return aggregated data table
  return(dt)

}

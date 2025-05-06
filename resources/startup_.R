################################################################################

### Global Objects

# Don't read strings as factors
options(stringsAsFactors = FALSE)

# Set seed
set.seed(1003)

# Report output
noisily <- T

# Git root directory
HOME <- dirname(getwd())

################################################################################

### Libraries

packages <- c(
  "tidyverse",
  "data.table",
  "foreach",
  "doParallel",
  "readxl",
  "ggplot2",
  "RMariaDB",
  "git2r"
)

garbage <- lapply(packages, library, character.only=TRUE)

### Functions

garbage <- lapply(list.files("resources/fun"), function(f) source(paste0("resources/fun/", f)))
rm(garbage)

### Functions

load("data/utility/StateFipsUsps.rda")

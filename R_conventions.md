### Authors : Brian DeVoe, Clemens Noelke
### This document should serve two primary purposes: 

(1) assure that production ready code coheres to a common standard for the purpose of replication and readability

(2) tutorial for new team members and research assistants as well as other contributers who are invited to work with DDK

# :large_blue_circle: 0: Data Types and Data Structures in R

### 0.1: Column Types

In R, data can be stored in various column types, each serving a specific purpose. Understanding these types is crucial for effective data manipulation and analysis. Below are the primary column types in R:

#### 0.1.1: Numeric
- **Description**: Represents numbers, including both integers and real (decimal) values.
- **Example**:
  ```r
  numeric_vector <- c(1.5, 2.7, 3.0)
  ```

#### 0.1.2: Integer
- **Description**: A subtype of numeric, represents whole numbers without decimals. In R, integers are denoted with an `L` suffix.
- **Example**:
  ```r
  integer_vector <- c(1L, 2L, 3L)
  ```

#### 0.1.3: Character
- **Description**: Represents text or string data. Each entry is enclosed in double or single quotes.
- **Example**:
  ```r
  character_vector <- c("apple", "banana", "cherry")
  ```

#### 0.1.4: Factor
- **Description**: Used to represent categorical data. Factors store unique values and have levels associated with them.
- **Example**:
  ```r
  factor_vector <- factor(c("male", "female", "female", "male"))
  ```

#### 0.1.5: Logical
- **Description**: Represents boolean values: `TRUE`, `FALSE`, or `NA` (not available).
- **Example**:
  ```r
  logical_vector <- c(TRUE, FALSE, TRUE)
  ```

#### 0.1.6: Date
- **Description**: Represents dates in the format "YYYY-MM-DD". Useful for time series analysis and date manipulation.
- **Example**:
  ```r
  date_vector <- as.Date(c("2023-01-01", "2023-01-02"))
  ```

#### 0.1.7: POSIXct and POSIXlt
- **Description**: Represent date and time. 
  - `POSIXct` is a numeric representation of the number of seconds since the origin (1970-01-01).
  - `POSIXlt` is a list representation of the date-time components.
- **Example**:
  ```r
  posixct_vector <- as.POSIXct("2023-01-01 12:00:00")
  posixlt_vector <- as.POSIXlt("2023-01-01 12:00:00")
  ```

#### 0.1.8: List
- **Description**: A flexible type that can contain elements of different types and structures, including other lists, vectors, and data frames.
- **Example**:
  ```r
  list_vector <- list(name = "Alice", age = 25, height = 5.5)
  ```

#### 0.1.9: Summary
Understanding these column types allows R users to effectively manage and manipulate their data, ensuring that analyses are conducted appropriately based on data characteristics. Selecting the right type is essential for optimal performance and accuracy in data operations.


### 0.2: Comparison of R Data Structures: `data.frame`, `data.table`, and `tibble`

In R, `data.frame`, `data.table`, and `tibble` are all data structures used for storing and manipulating tabular data. Here’s a breakdown of each:

#### 0.2.1: `data.frame`
- **Definition**: A `data.frame` is a built-in R data structure that stores data in a two-dimensional table format, similar to a spreadsheet.
- **Characteristics**:
  - **Columns** can be of different types (e.g., numeric, character, factor).
  - **Row and Column Names**: Supports row names and column names.
  - **Subsetting**: Can be indexed using integers or names.
  - **Functions**: Uses base R functions for operations, which may be less efficient with larger datasets.
  
- **Example**:
  ```r
  df <- data.frame(
    Name = c("Alice", "Bob"),
    Age = c(25, 30),
    Height = c(5.5, 6.0)
  )
  ```

#### 0.2.2: `data.table`
- **Definition**: `data.table` is an R package that extends `data.frame`, providing enhanced performance and additional functionalities, particularly for large datasets.
- **Characteristics**:
  - **Speed**: Optimized for speed, especially for large data operations.
  - **Syntax**: Uses a concise and expressive syntax for data manipulation.
  - **In-memory**: Designed for in-memory processing and can handle larger-than-memory datasets with efficient memory use.
  - **Key Features**: Supports advanced features like grouping and joins directly within the data.table framework.
  
- **Example**:
  ```r
  library(data.table)
  dt <- data.table(
    Name = c("Alice", "Bob"),
    Age = c(25, 30),
    Height = c(5.5, 6.0)
  )
  ```

#### 0.2.3: `tibble`
- **Definition**: A `tibble` is part of the `tidyverse` collection of packages and is designed to be a modern reimagining of `data.frame`.
- **Characteristics**:
  - **Printing**: Provides a cleaner print method that shows only the first few rows and columns, making it easier to read large datasets.
  - **Column Types**: Does not automatically convert strings to factors, preserving the data's original types.
  - **Subsetting**: More user-friendly, e.g., it doesn't allow partial matching on column names.
  - **Integration**: Works seamlessly with other `tidyverse` packages, making it ideal for data analysis and visualization.
  
- **Example**:
  ```r
  library(tibble)
  tb <- tibble(
    Name = c("Alice", "Bob"),
    Age = c(25, 30),
    Height = c(5.5, 6.0)
  )
  ```

#### 0.2.4: Inheritance


In R, `data.frame`, `data.table`, and `tibble` are interconnected data structures that illustrate the concept of inheritance in object-oriented programming. Understanding these relationships can help clarify their functionalities and use cases.

`data.frame`
- **Base Structure**: `data.frame` is a fundamental data structure in R used to store tabular data. It is part of base R and allows for the storage of data in a two-dimensional format where each column can be of different types (e.g., numeric, character).
- **Object Class**: When you create a `data.frame`, it belongs to the class `"data.frame"`.

`data.table`
- **Extension of `data.frame`**: `data.table` is an R package that extends the `data.frame` class. It inherits all the attributes and behaviors of `data.frame` while adding enhancements for performance and usability, particularly for large datasets.
- **Object Class**: A `data.table` is an object of class `"data.table"` but it also inherits from `"data.frame"` and `"list"`. This means that it has access to all functions applicable to `data.frame` objects.
  
##### Inheritance Hierarchy:
- `data.table` inherits from:
  - `data.frame`
  - `list`

`tibble`
- **Modern Reimagining of `data.frame`**: `tibble` is part of the `tidyverse` collection and provides a modern take on the traditional `data.frame`. It retains the core functionality of a `data.frame` but improves usability and printing, especially for large datasets.
- **Object Class**: A `tibble` is also a subclass of `data.frame` but comes with its own class `"tbl_df"` as well as `"tbl"` and `"data.frame"`. This allows it to maintain compatibility with functions expecting `data.frame` objects.

##### Inheritance Hierarchy:
- `tibble` inherits from:
  - `data.frame`
  - `list`

#### Summary of Inheritance Relationships
- **`data.frame`**: The foundational structure for tabular data.
- **`data.table`**: Inherits from `data.frame` and adds advanced features for performance, while also being a `list`.
- **`tibble`**: Inherits from `data.frame` and offers enhancements for usability and integration with the `tidyverse`, also being a `list`.

##### Example of Inheritance
You can check the class and structure of these objects in R to see their inheritance:

```r
library(data.table)
library(tibble)

# Create objects
df <- data.frame(Name = c("Alice", "Bob"), Age = c(25, 30))
dt <- data.table(Name = c("Alice", "Bob"), Age = c(25, 30))
tb <- tibble(Name = c("Alice", "Bob"), Age = c(25, 30))

# Check classes
class(df)  # Output: "data.frame"
class(dt)  # Output: "data.table" "data.frame" "list"
class(tb)  # Output: "tbl_df" "tbl" "data.frame"
```

Understanding these inheritance relationships can help users choose the most appropriate data structure for their analyses and optimize their data manipulation tasks in R.


#### 0.2.4: Summary
- **Performance**: `data.table` is best for performance with large datasets.
- **User-Friendliness**: `tibble` is designed for ease of use and clarity, especially in conjunction with `tidyverse` tools.
- **Basic Usage**: `data.frame` is the basic structure and is widely used, but may be less efficient for larger datasets or complex operations.

Each of these structures has its strengths, so the choice depends on the specific needs of your analysis and the size of your data.


# :large_blue_circle: 1: Writing and Reading Data
### 1.1: base r using Rdata format
```r
# Save the entire environment to a file
save.image(file = "my_full_environment.RData")

# Load the saved entire environment from above
load("my_full_environment.RData")

# reading and writing a specific RData file, can't omit "file ="
save(my_data, file = "my_data.RData")

# Save multiple objects
save(my_data, another_data_frame, file = "multiple_data.RData")

# Load the specific and multiple RData objects
load("my_data.RData")
```
### 1.2: data.table
```r
# The data.table library has the most efficient functions for reading and writing in .csv format (in addition to other formats).
# DDK convention is to only use csv and Rdata format when writing data. 
# For xlsx data, refer to the readxl and writexl R libraries, this should only be necessary when reading in raw data. 

# data.table read 
dt <- fread("path.csv")                                 # auto detect column type, generally not recommended
dt <- fread("path.csv", colClasses = "character")       # specify all column types as character, should be default

# set names and column types for fread function
dt <- c("character", "numeric", "integer"); names(dt) <- c("col1", "col2", "col3")
                
dt <- fread("path.csv", colClasses = dt)                # reads entire file, auto-detects type of columns not in specified
dt <- fread("path.csv", select = dt)                    # reads only selected columns with their specified types

# Reading files with a dictionary (fastest)
dt <- dict$data_type; names(dt) <- dict$column_name
dt <- fread(file_name, select=dt)

# data.table write
fwrite(dt, "path.csv")
```
# :large_blue_circle: 2: Reshape Data (pivoting from wide-to-long and long-to-wide)
```r
### Vectors defining ID columns and value columns

# ID columns
id_cols <- str_subset(names(df), "geo") # all vars with geo in the varname

# Value columns
char_cols <- str_subset(names(df), "frt") # character columns
num_cols  <- str_subset(names(df), "num") # numeric columns
val_cols  <- c(char_cols, num_cols)       # all value columns
```
### 2.1: Reshape long to wide (data.table)
```r
## data.table

# formula
frm <- paste(id_cols, collapse=" + ")               # left hand side
frm <- as.formula(paste(frm, "~ time", collapse="")) # right hand side

dcast(df, geoid + geo_name ~ time, value.var = c("num1", "num2", "num3", "frt1", "frt2") )
dcast(df, frm,                     value.var = c("num1", "num2", "num3", "frt1", "frt2") )
```
### 2.2: Reshape long to wide (tidyr)
```r
## tidyr
pivot_wider(
  df,
  id_cols = all_of(id_cols),
  names_from = time,
  values_from = all_of(value_cols),
  names_sep = ""
)
```
### 2.3: Format data for wide to long reshape
```r
## Because frt is character and num is numeric, we need to convert num to character

# Convert numeric to character using tidyr
df <- df %>% mutate_at(vars(starts_with("num")), as.character)

# Convert numeric to character using data.table
df <- df[, (num_cols) := lapply(.SD, as.character), .SDcols = num_cols]
```
### 2.4: Reshape wide to long (data.table)
```r
## data.table

# Melt df using data.table
df1 <- melt(df,
         id.vars=c(id_cols, "time"),
         measure.vars  = val_cols,
         variable.name = "variable",
         value.name    = "value"
       )
```

### 2.5: Reshape wide to long (tidyr)
```r
# tydir
df2 <- pivot_longer(
        df,
        cols = all_of(val_cols),
        names_to = "variable",
        values_to = "value"
)
```

```r
# Split variable column into two columns: variable (leading character portion) and suffix (trailing numeric portion)
df1 <- df1[, c("variable", "suffix") := tstrsplit(variable, "(?<=\\D)(?=\\d)", perl=TRUE)]

# Variable is split at the boundary between a non-digit character and a digit:
#   (?<=\\D) is a lookbehind that matches a position preceded by a non-digit (\\D).
#   (?=\\d)  is a lookahead that matches a position followed by a digit (\\d).
# perl=TRUE ensures that the regular expression is interpreted using Perl-style regex,
# which supports advanced features like lookahead and lookbehind.
```

# :large_blue_circle: 3: Renaming Columns

Renaming columns in R can be achieved using different approaches depending on the data structure. Below are examples using Base R (`data.frame`), `data.table`, and `tibble` (from the `tidyverse`).

#### 3.1 Renaming Columns in Base R (data.frame)

In Base R, you can rename columns of a `data.frame` using the `colnames()` function.

### Example:

Note that in base R, renaming columns is based on column postion, which can be risky and should not be used. 
```r
# Rename columns
colnames(df) <- c("new_col1", "new_col2")
```

#### 3.2 Renaming Columns in data.table

With the `data.table` package, you can rename columns efficiently using the `setnames()` function.

### Example:

```r
# Rename columns
setnames(dt, old = c("old_col1", "old_col2"), new = c("new_col1", "new_col2"))
```

#### 3.3 Renaming Columns in tibble (tidyverse)

In the `tidyverse`, you can rename columns using the `rename()` function from the `dplyr` package.

### Example:

```r
# Rename columns
tbl <- rename(tbl, new_col1 = old_col1, new_col2 = old_col2)
```


# :large_blue_circle: 4: Subsetting Rows and Columns
### 4.1: base r 

```r
# base r filter columns examples
# base r selecting columns examples
```
### 4.2: data.table 
```r
# tidyverse filtering columns examples
dt <- dt[string_column == "value"]                             # filter a string column to a specified value
dt <- dt[string_column %in% c("value1", "value2", "value3")]   # filter a string column for multiple values
dt <- dt[string_column != "value"]                             # filter a string column to exclude a specified value
dt <- dt[!string_column %in% c("value1", "value2", "value3")]  # filter a string column to exclude multiple values

# data.table selecting columns examples using pre-defined vector (.. identifies a vector. Otherwise, data.table would think it's a column called cols_to_select)
dt <- dt[, ..cols_to_select]
# data.table selecting columns examples using vector generated on the fly that contains pre-defined elements and hard-coded elements
dt <- subset_dt(dt, c("col1", "col2", cols_to_select))  # subset_dt is a ddkdevtools function
```
### 4.3: tidyverse filter (rows) and select (columns)
```r
# tidyverse filtering columns examples
dt <- filter(dt, string_column == "value")                             # filter a string column to a specified value
dt <- filter(dt, string_column %in% c("value1", "value2", "value3"))   # filter a string column for multiple values
dt <- filter(dt, string_column != "value")                             # filter a string column to exclude a specified value
dt <- filter(dt, string_column !%in% c("value1", "value2", "value3"))  # filter a string column to exclude multiple values

# Add script for filtering missing

dt <- filter(dt, numeric_column >= 0)  # filter a numeric column to contain values greater or equal to zero (can also use >, <, <=, ==)

# tidyverse selecting columns examples
dt <- select(dt, all_of(columns_to_select))
```
# :large_blue_circle: 5: Operations on Columns
### 5.1: base r operations on columns
```r
# base r
dt$new_var <- dt$old_var1 + dt$old_var2          # (can also use -, *, /)
```
### 5.2: data.table operations on columns
```r
### data.table
dt <- dt[, (new_var):=lapply(.SD, mean), SDcols=cols_to_select]
```
### 5.3: tidyverse operations on columns
```r
# tidyverse 
dt <- mutate(dt, new_var = old_var1 + old_var2)  # (can also use -, *, /)
```

# :large_blue_circle: 6: Conditional Replacement
### 6.1: Base R
```r
# Perform conditional replacement using subsetting
iris$Size <- NA  # Create an empty column
iris$Size[iris$Sepal.Length > 5.5] <- "Large"
iris$Size[iris$Sepal.Length <= 5.5] <- "Small"

# Perform conditional replacement using ifelse()
iris$Size <- ifelse(iris$Sepal.Length > 5.5, "Large", "Small")
```
# :large_blue_circle: 7: String Operations
### 7.1 Concatenating Strings
```r
# seprated by a given character
paste("Hello", "World", sep = " ")  # "Hello World"

# no seperation
paste0("Hello", "World")  # "HelloWorld"
```

### 7.2 Substring Extraction (using tidyverse)
```r
# Extract substring:
substr("Hello World", start = 1, stop = 5)  # "Hello"

# Example:
substring("Hello World", first = 7)  # "World"
```

### 7.3 Changing case
```r
# all to uppercase
toupper("hello")  # "HELLO"

# all to lower case
tolower("HELLO")  # "hello"

# these functions can work with vectors, here is a useful example turning all column names in a data.frame to lower
colnames(df) <- tolower(colnames(df))
```

### 7.4 String Replacement
```r
# exact match replacement
sub("World", "Everyone", "Hello World")  # "Hello Everyone"

# partial match replacement
gsub("l", "x", "Hello World")  # "Hexxo Worxd"
```

### 7.5 Pattern Matching with Regular Expressions
```r
grepl("World", "Hello World")  # TRUE

grep("World", c("Hello", "Hello World"))  # 2

regexpr("World", "Hello World")  # 7

# using stringr
str_replace("Hello World", "World", "Everyone")  # "Hello Everyone"
```

# :large_blue_circle: 8: group_by and summarise
### 8.1: dplyer (tidyverse)
```r
iris_summary <- iris %>%
  group_by(Species)  %>%                                            # group_by Species to do aggregate computation by Species        
  summarize(
    avg_sepal_length    = mean(Sepal.Length,   na.rm = TRUE),       # compute mean by Species
    sd_sepal_length     = sd(Sepal.Length,     na.rm = TRUE),       # compute standard deviate ... 
    median_sepal_length = median(Sepal.Length, na.rm = TRUE)        # compute median ...
  )
```

# :large_blue_circle: 9: merging and harmonizing data, checking missing data post merge

### 9.1: base R

### 9.2: data.table

### 9.3: tidyverse
In **tidyverse** (specifically **dplyr**), you can merge (join) data using simple functions such as 
`inner_join()`, `left_join()`, `right_join()`, and `full_join()`. These functions are intuitive, 
SQL-style, and work based on matching columns.

#### Summary of Functions:
- **`inner_join()`**: Returns rows with matching keys in both datasets.
- **`left_join()`**: Returns all rows from the left dataset, with matching rows from the right 
  dataset.
- **`right_join()`**: Returns all rows from the right dataset, with matching rows from the left 
  dataset.
- **`full_join()`**: Returns all rows from both datasets, filling in `NA` for missing matches.

#### One-Line Examples:
```r
# Load dplyr
library(dplyr)

# Example datasets
df1 <- tibble(ID = c(1, 2, 3), value1 = c("A", "B", "C"))
df2 <- tibble(ID = c(2, 3, 4), value2 = c("X", "Y", "Z"))

# Inner join (only matching rows)
inner_join(df1, df2, by = "ID")

# Left join (all rows from df1)
left_join(df1, df2, by = "ID")

# Right join (all rows from df2)
right_join(df1, df2, by = "ID");

# Full join (all rows from both df1 and df2)
full_join(df1, df2, by = "ID");
```

### 9.4 Custom DDK functions

# :large_blue_circle: 10: loops with lapply and foreach

`lapply` iterates over the elements of a list (or a vector), applying a function to each element. `function()` is the second argument and is often followed by a user-written function. Here is an example of a flattened three-level nested loop. We first define three vectors with the elements to be iterated over and then use `expand.grid()` to create a data.frame with all possible combinations of the elements in the three vectors. We then turn that into a list of vectors to loop over.

#### Create a list with each element being one of the possible combinations of vrs, mtr, and vin
```r
vrs <- c("met", "stt", "nat"); mtr <- c("ED", "HE", "SE"); vin <- c("10", "20")
res <- expand.grid(vrs, mtr, vin, stringsAsFactors=F)    # returns data frame, columns same order as vectors
res <- lapply(1:nrow(res), function(i) paste(res[i, ]))  # turns data frame into list
```

#### Iterate over the elements and stack
```r
res <- lapply(res, function(itm) my_fun(dt=dt, vrs=itm[[1]], mtr=itm[[2]]), vin=itm[[3]]))
res <- rbindlist(res)
```

#### Same, but parallelized with future_apply from the future.apply library
```r
plan(multisession) # Set up parallel execution using multisession (works on Windows), no need to stop
res <- future.apply::future_lapply(res, function(itm) my_fun(dt=dt, vrs=itm[[1]], mtr=itm[[2]]), vin=itm[[3]]))
dt <- rbindlist(res)
```

#### Combining list results with iterated merge (res is a list of data.frames/data.tables)
```r
dt <- Reduce(function(...) check_merge(..., keys = c("county_fips", "year"), join_type = "outer", abort=F), res)
```

#### Repeat with foreach, requires foreach and doParallel libraries
foreach needs a character vector with the names of the packages that should be available inside loop, e.g., `packages <- c("sf", "data.table")`
```r
cl <- makeCluster(30); registerDoParallel(cl)
reslist <- foreach(itm=res, .packages = packages) %dopar% {
  my_fun(dt=dt, vrs=itm[1], mtr=itm[2]), vin=itm[3])
}
stopCluster(cl); rm(cl)
```

# :large_blue_circle: 11: more on lapply, sapply, parallel processing

# :large_blue_circle: 12: General data cleaning practices

# :large_blue_circle: 13: Handling raw missing data and imputation

# :large_blue_circle: 14: Statistics

### 14.1: Simple Linear Regression
```r
model <- lm(Sepal.Length ~ ., data = iris)                             # Fit the linear regression model using all other variables 
model <- lm(Sepal.Length ~ Sepal.Width, data = iris)                   # Fit the linear regression model on a single variable
model <- lm(Sepal.Lnegth ~ Sepal.Width + Petal.Length, data = iris)    # Fit the linear regression model on two (or more) variables

# Summarize the model
summary(model)

# Make predictions
predicted_values <- predict(model, newdata = iris)
```

### 14.2: Lasso, Ridge, and PCA

### 14.4: Instrumental Variables Regression

### 14.5: Panel Data and Fixed Effects

### 14.6: Time Series

### 14.7: Logistic Regression

### 14.8: Random Forest

# :large_blue_circle: 15: Computation Efficiency 
### benchmarking
### why and when to avoid loops and nested loops
### matrix computation
### brief explanation of parallel processing -- refer back to previous chapter

# :large_blue_circle: 16: Spatial Data Types/Structures and Operations

# :large_blue_circle: 17: Data visualization (ggplot2, leaflet, etc.) 

# :large_blue_circle: 18: Interface with SQL and other APIs

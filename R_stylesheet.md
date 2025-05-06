# R style sheet

#### Authors : Brian DeVoe, Clemens Noelke

#### Date : 9/23/24

### Basic conventions

-   In many cases, we prefer readability over efficiency. This means writing code that uses fewer, more basic commonly used functions, and writing several lines of code rather than one complicated line. If efficiency is important, please annotate more complex expressions.

-   If space permits, place spaces around all binary operators (=, +, -, \<-, etc.) and after commas in function arguments, e.g., x = 2 instead of x=2.

-   Place a space before left parenthesis (except in a function call) and after right parenthesis.

-   Always use ← for assignment and not =

-   Keep lines under 80 characters.

-   Keep stripts under 150 lines.

-   Curly braces {}

    -   An opening curly brace should never go on its own line.

    -   A closing curly brace should always go on its own line.

    -   You may omit curly braces when a block consists of a single statement.

-   Indent code inside multiline for loops or if conditions using tab or spaces.

-   Delete objects you no longer need as soon as possible. For example, R keeps the last value of the iteration object in a for loop in the environment even after the for loop is completed

-   Rarely use ; to write two lines of code in the same line

-   Path / folder names: Only forward slashes / If you assign a pathname to vector, exclude the last forward slash, e.g., C:/COI30 instead of C:/COI30/

-   Annotation

    -   Annotate code liberally, err on the side of saying too much than too little

    -   Annotate code in-line to illustrate or inform why a specific line was written the way it was, for example. Great way to record weird R behavior requiring non-standard syntax, e.g.

````         
``` r
DT[] # Because of the previous function call, the [] is needed. Otherwise, DT wouldn’t print to the console
```
````

-   Default object names

    -   Use descriptive object names if possible, e.g., redlining_spdf

    -   **df** for data.frame

    -   **dt** for data.table

    -   **tb** for tibble

    -   **spdf** spatial data object (points, lines, raster, polygon,...), spatial data frame

    -   **mat** for matrix

    -   **vec** for vector

    -   **lst** for list

    -   **tmp** for column or object that you only need temporarily tmp_df, tmp_dt, etc. for data.frame or data.table that you only need temporarily

    -   **itm** for iterator in for loop, e.g. for (itm in 1:10). It’s better practice to use a more descriptive name. For example, if you are iterating over years, use year or yr.

    -   If you need several of those, attach running number, e.g., df1, df2, df3 (no underscores)

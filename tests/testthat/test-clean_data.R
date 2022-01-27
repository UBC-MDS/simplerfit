library(tidyverse, quietly = TRUE)

data= tibble(num_legs= c(2, 4, 8, 0),
             `num_  wings`= c('bad', 'Good', NA, 'bad'),
             `Num  specimen` = c(10, 2, 1, 8))

test_that("clean_data throws an error when the data not called with any argument",
          {expect_error(clean_data())})

test_that("clean_data throws an error when the date called with a non-dataframe arguement",
          {expect_error(clean_data("Hello"))})

test_that("Drop all rows that have a NaN in any column or not ",
          {expect_error(clean_data("NA"))})

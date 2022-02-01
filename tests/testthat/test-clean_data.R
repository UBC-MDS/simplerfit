

data <-  tidyr::tibble(num_legs= c(2, 4, 8, 0),
             `num_  wings`= c('bad', 'Good', NA, 'bad'),
             `Num  specimen` = c(10, 2, 1, 8))

testthat::test_that("clean_data throws an error when the data not called with any argument",
          {expect_error(clean_data())})

testthat::test_that("clean_data throws an error when the date called with a non-dataframe arguement",
          {expect_error(clean_data("Hello"))})

testthat::test_that("Drop all rows that have a NaN in any column or not ",
          {expect_error(clean_data("NA"))})

testthat::test_that("change extra white spaces from column names, and data to '-'",
          {expect_error(clean_data("-"))})

testthat::test_that("convert all column names to lower case",
          {expect_error(clean_data(stringr::str_detect(data,"[[:upper:]]") == FALSE))})


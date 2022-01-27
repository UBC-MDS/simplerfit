require(lattice)
library(caret)
library(readr)
library(tidyverse)
library(testthat)
library(dplyr)
library(mltools)
library(data.table)
library(gapminder)


#' Test whether test_baseline_fun can worked as expected
#'
#' @return None. the function should not throw an error
#' @export
#'
#' @examples
#' test_fit_regressor()
test_fit_regressor <- function() {
  
  data <-  gapminder
  output_function <- fit_regressor(data, target_col="gdpPercap", numeric_feats=c("year", "lifeExp", "pop"), categorical_feats <- c("continent"), cv =5)
  
  test_that("Output of function should be dataframe", {
    expect_true(any("data.frame" %in% class(results)))
  })
  test_that("The Rsqaured of linear regression is not what it should be", {
    expect_true(round(output_function[["Rsquared"]][2], 2) == 0.4)
  })
  test_that("The Rsqaured of Ridge model is not what it should be", {
    expect_true(round(output_function[["Rsquared"]][3], 2) == 0.38)
  })

  test_that('Expect customized error messages for invalid input types',{
    expect_error(fit_regressor(1 , target_col = 'gdpPercap', categorical_feats=c('continent')), 'Please input a dataframe')
    expect_error(fit_regressor(data, target_col = 1, numeric_feats=c("year", "lifeExp", "pop"), categorical_feats=c('continent')), 'Please enter a target column')
    expect_error(fit_regressor(data, target_col = 'gdpPercap', numeric_feats=c("pop"), categorical_feats=c('year')), 'Please enter a categorical_feats from non numeric column')
    expect_error(fit_regressor(data, target_col = 'gdpPercap', numeric_feats= c("continent"), categorical_feats=c('country')), 'Please enter numeric feats from numeric ones')
    })
}


test_fit_regressor()


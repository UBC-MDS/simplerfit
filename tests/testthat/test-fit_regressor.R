require(lattice)
library(caret)
library(readr)
library(tidyverse)
library(testthat)
library(dplyr)
library(mltools)
library(data.table)
library(gapminder)


# data <-  gapminder
# output_function <- fit_regressor(data, target_col="gdpPercap", numeric_feats=c("year", "lifeExp", "pop"), categorical_feats <- c("continent"), cv =5)

test_that("The Rsqaured scores are not what they should be", {
  results <- fit_regressor(gapminder, target_col="gdpPercap", numeric_feats=c("year", "lifeExp", "pop"), categorical_feats = c("continent"), cv =5)
  # expect_true(is.data.frame(results))
  expect_true(round(results[["Rsquared"]][2], 2) == 0.4)
  expect_true(round(results[["Rsquared"]][3], 2) == 0.38)
})


test_that('Expect customized error messages for invalid input types',{
  data <-  gapminder::gapminder
  expect_error(fit_regressor(1 , target_col = 'gdpPercap', categorical_feats=c('continent')), 'Please input a dataframe')
  expect_error(fit_regressor(data, target_col = 1, numeric_feats=c("year", "lifeExp", "pop"), categorical_feats=c('continent')), 'Please enter a target column')
  expect_error(fit_regressor(data, target_col = 'gdpPercap', numeric_feats=c("pop"), categorical_feats=c('year')), 'Please enter a categorical_feats from non numeric column')
  expect_error(fit_regressor(data, target_col = 'gdpPercap', numeric_feats= c("continent"), categorical_feats=c('country')), 'Please enter numeric feats from numeric ones')
})



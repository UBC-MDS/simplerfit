library(dplyr)
library(lattice)
library(caret)
library(mltools)
library(data.table)
library(testthat)
library(tidyverse)
library(gapminder)

test_that('FAILED',{
    
    gapminder <- gapminder |> dplyr::filter(continent=="Asia" | continent=="Europe")
    gapminder$country <- as.character(gapminder$country)
    gapminder$continent <- as.character(gapminder$continent)
    gapminder$year <- as.numeric(gapminder$year)
    gapminder$pop <- as.numeric(gapminder$pop)
    
    expect_error(fit_classifier(1))
    expect_error(fit_classifier(gapminder, numeric_feats = list("gdpPercap"), categorical_feats = list(), cv = 5))
    expect_error(fit_classifier(gapminder, target_col = "continent", categorical_feats = list("country"), cv = 5))
    expect_error(fit_classifier(gapminder, target_col = "continent", numeric_feats = list("gdpPercap"), cv = 5))
})


test_that('The returned value needs to be a dataframe or the ouput is incorrect', {
    
    library(gapminder)
    gapminder <- gapminder |> dplyr::filter(continent=="Asia" | continent=="Europe")
    gapminder$country <- as.character(gapminder$country)
    gapminder$continent <- as.character(gapminder$continent)
    gapminder$year <- as.numeric(gapminder$year)
    gapminder$pop <- as.numeric(gapminder$pop)

    inter <- fit_classifier(gapminder,
                            target_col = 'continent',
                            numeric_feats = list('gdpPercap'),
                            categorical_feats = list('country'),
                            cv=5)

    expect_true(is.data.frame(inter))
    expect_true(round(inter[[1]], 2) == 0.52)
    expect_true(round(inter[[2]], 2) == 1)
})



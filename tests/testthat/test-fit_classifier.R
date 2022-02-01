testthat::test_that('FAILED',{

  gapminder <- gapminder::gapminder |> dplyr::filter(continent=="Asia" | continent=="Europe")
  gapminder$country <- as.character(gapminder$country)
  gapminder$continent <- as.character(gapminder$continent)
  gapminder$year <- as.numeric(gapminder$year)
  gapminder$pop <- as.numeric(gapminder$pop)

  testthat::expect_error(fit_classifier(1))
  testthat::expect_error(fit_classifier(gapminder, numeric_feats = list("gdpPercap"), categorical_feats = list(), cv = 5))
  testthat::expect_error(fit_classifier(gapminder, target_col = "continent", categorical_feats = list("country"), cv = 5))
  testthat::expect_error(fit_classifier(gapminder, target_col = "continent", numeric_feats = list("gdpPercap"), cv = 5))
})


testthat::test_that('The returned value needs to be a dataframe or the ouput is incorrect', {

  gapminder <- gapminder::gapminder |> dplyr::filter(continent=="Asia" | continent=="Europe")
  gapminder$country <- as.character(gapminder$country)
  gapminder$continent <- as.character(gapminder$continent)
  gapminder$year <- as.numeric(gapminder$year)
  gapminder$pop <- as.numeric(gapminder$pop)

  inter <- fit_classifier(gapminder,
                          target_col = 'continent',
                          numeric_feats = list('gdpPercap'),
                          categorical_feats = list('country'),
                          cv=5)

  testthat::expect_true(is.data.frame(inter))
  testthat::expect_true(round(inter[[1]], 2) == 0.52)
  testthat::expect_true(round(inter[[2]], 2) == 1)
})
require(tidyverse)

test_that('FAILED',{

  df <- read_csv('../data/adult.csv')
  expect_error(plot_distributions(1))
  expect_error(plot_distributions(df, hist_cols = 1))
  expect_error(plot_distributions(df, hist_cols = 'abc'))
  expect_error(plot_distributions(df, bins = 'abc'))
  expect_error(plot_distributions(df, density = 1))


  # # Check if results are correct when no optional hyper-parameters are provided)
  results <- plot_distributions(df)

  test_that('Plot should use geom_bar and map x to x-axis', {
    expect_true( "GeomBar" %in% class(results$layers[[1]]$geom))
    expect_true("value" == rlang::get_expr(results$mapping$x))

  })

  test_that('The labels are not mapped correctly', {
    expect_true("count"==results$label$y)
    expect_true("value" == results$label$x)

  })

  # # Check if results are correct when density is TRUE)
  density_results <- plot_distributions(df, density=TRUE)

  test_that('Plot should use geom_bar and map x to x-axis', {
    expect_true( "GeomDensity" %in% class(density_results$layers[[1]]$geom))
    expect_true("value" == rlang::get_expr(density_results$mapping$x))

  })

  test_that('The labels are not mapped correctly', {
    expect_true("density"== density_results$label$y)
    expect_true("value" == density_results$label$x)

  })

})

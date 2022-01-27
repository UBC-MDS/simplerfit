require(tidyverse)

test_that('Invalid input types',{

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
  #
  # # Test histograms
  # expect_equal(results$hist$labels$x, "value")
  # expect_equal(results$hist$labels$y, "density")
  # expect_equal(results$hist$labels$weight, "weight")
  # expect_equal(results$hist$labels$title, "Histogram for column: Calories")
  # expect_equal(typeof(results$hist$theme) , 'list')
  #
  # # Test GGally pairplot
  # expect_equal(results$pair$byrow, TRUE)
  # expect_equal(results$pair$ncol, 4)
  # expect_equal(results$pair$nrow, 4)
  # expect_equal(results$pair$xAxisLabels[1], "Calories")
  # expect_equal(results$pair$xAxisLabels[4], "Carbohydrates")
  # expect_equal(results$pair$yAxisLabels[1], "Calories")
  # expect_equal(results$pair$yAxisLabels[4], "Carbohydrates")
  #
  # # Test correlation heat-map
  # expect_equal(results$corr$labels$title, "Correlation between the different numeric features")
  # expect_equal(results$corr$labels$y, "Feature 2")
  # expect_equal(results$corr$labels$x, "Feature 1")
  # expect_equal(results$corr$labels$fill, "value")
  # expect_equal(typeof(results$corr$theme) , 'list')
  #
  #
  # # Check if results are correct when optional hyper-parameters are provided)
  # results <- explore_numeric_columns(df, hist_cols = c('Cholesterol'), pairplot_cols = c('Calories','Carbohydrates'), corr_method = 'spearman')
  #
  # # Test histograms
  # expect_equal(results$hist$labels$x, "Cholesterol")
  # expect_equal(results$hist$labels$y, "count")
  # expect_equal(results$hist$labels$weight, "weight")
  # expect_equal(results$hist$labels$title, "Histogram for column: Cholesterol")
  # expect_equal(typeof(results$hist$theme) , 'list')
  #
  # # Test GGally pairplot
  # expect_equal(results$pair$byrow, TRUE)
  # expect_equal(results$pair$ncol, 2)
  # expect_equal(results$pair$nrow, 2)
  # expect_equal(results$pair$xAxisLabels[1], "Calories")
  # expect_equal(results$pair$xAxisLabels[2], "Carbohydrates")
  # expect_equal(results$pair$yAxisLabels[1], "Calories")
  # expect_equal(results$pair$yAxisLabels[2], "Carbohydrates")
  #
  # # Test correlation heat-map
  # expect_equal(results$corr$labels$title, "Correlation between the different numeric features")
  # expect_equal(results$corr$labels$y, "Feature 2")
  # expect_equal(results$corr$labels$x, "Feature 1")
  # expect_equal(results$corr$labels$fill, "value")
  # expect_equal(typeof(results$corr$theme) , 'list')

})

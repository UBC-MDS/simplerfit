

testthat::test_that('FAILED',{

  df <- readr::read_csv('../data/adult.csv')
  expect_error(plot_corr(1))
  expect_error(plot_corr(df, pair_cols = 1))
  expect_error(plot_corr(df, pair_cols = 'abc'))
  expect_error(plot_corr(df, corr = list('abc')))



  # # Check if results are correct when no optional hyper-parameters are provided)
  results <- plot_corr(df)

  testthat::test_that('Plot should use Ggally corr and map x to x-axis', {
    expect_true( "GeomRect" %in% class(results$layers[[1]]$geom))
    expect_true("x" == rlang::get_expr(results$mapping$x))
    expect_true("y" == rlang::get_expr(results$mapping$y))
  })






})

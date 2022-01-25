#' Fit dummy regressor and linearregression models
#'
#' @param train_df dataframe that will be used to train the model
#' @param target_col The column that needs to be classified as a string
#' @param numeric_feats The numeric columns as a list
#' @param categorical_feats The categorical columns as a list
#' @param cv The number of crossvalidation folds as an integer
#'
#' @return A data frame
#' @export
#'
#' @examples
#' fit_regressor(data, target_col = 'popularity', categorical_feats=c('genre'))
#' fit_regressor(data, target_col = 'popularity', numeric_feats = c('danceability', 'loudness'), categorical_feats=c('genre'), cv=10)
#'
#' df <- data.frame(x = c(1, 2, 4, 6, 8),y = c(3, 6, 12, 18, 24))
#' fit_regressor(df, target_col = 'y', numeric_feats='x')
#' fit_regressor(df, target_col = 'y')
fit_regressor <- function(train_df, target_col, numeric_feats= NULL, categorical_feats= NULL, cv = 5){}

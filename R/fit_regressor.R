#' Fit dummy regressor and linearregression models 
#'
#' @return A data frame
#' @export
#'
#' @examples
#' data <- read_csv("data/spotifyfeatures.csv")
#' fit_regressor(data, target_col = 'popularity', categorical_features='genre')
#' fit_regressor(data, target_col = 'popularity', numeric_feats = ['danceability', 'loudness'], categorical_feats=['genre'], cv=10)
#' 
#' df <- data.frame(x = c(1, 2, 4, 6, 8),y = c(3, 6, 12, 18, 24))
#' fit_regressor(df, target_col = 'y', numeric_feats='x')
#' fit_regressor(df, target_col = 'y')
fit_regressor <- function(){}

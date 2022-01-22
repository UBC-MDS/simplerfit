#' Fit dummy classifier and Logistic regression models 
#'
#' @param train_df dataframe that will be used to train the model
#' @param target_col The column that needs to be classified as a string
#' @param numeric_feats The numeric columns as a list
#' @param categorical_features The categorical columns as a list
#' @param cv The number of crossvalidation folds as an integer
#'
#' @return A data frame
#' @export
#'
#' @examples
#' fit_classifier(data, target_col = 'income', categorical_features=list('occupation'))
#' fit_classifier(data, target_col = 'income', numeric_feats = list('age', 'fnlwgt', 'hours.per.week', 'education.num', 'capital.gain', 'capital.loss'), categorical_feats=list('genre'), cv=10)
#' 
#' df <- data.frame(x = c(1, 2, 4, 6, 8),y = c(0, 1, 1, 0, 1))
#' fit_classifier(df, target_col = 'y', numeric_feats=list('x'))
#' fit_classifier(df, target_col = 'y')
fit_classifier <- function(train_df, target_col, numeric_feats= NULL, categorical_features= NULL, cv = 5){}

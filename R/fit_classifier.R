#' Fit dummy classifier and Logistic regression models
#'
#' @param train_df dataframe that will be used to train the model
#' @param target_col The column that needs to be classified as a string
#' @param numeric_feats The numeric columns as a list
#' @param categorical_features The categorical columns as a list
#' @param cv The number of cross validation folds as an integer
#'
#' @return A data frame
#' @export
#'
#' @examples
#' library(tidyverse)
#' fit_classifier(data, target_col = 'income', categorical_feats=c('occupation'))
#' fit_classifier(data, target_col = 'income', numeric_feats = c('age', 'fnlwgt'), categorical_feats=c('genre'), cv=10)
#'

fit_classifier <- function(train_df, target_col, numeric_feats= NULL, categorical_feats= NULL, cv = 5){}

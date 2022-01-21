#' Fit dummy classifier and Logistic regression models 
#'
#' @return A data frame
#' @export
#'
#' @examples
#' fit_classifier(data, target_col = 'income', categorical_features='occupation')
#' fit_classifier(data, target_col = 'income', numeric_feats = ['age', 'fnlwgt', 'hours.per.week', 'education.num', 'capital.gain', 'capital.loss'], categorical_feats=['genre'], cv=10)
#' 
#' df <- data.frame(x = c(1, 2, 4, 6, 8),y = c(0, 1, 1, 0, 1))
#' fit_classifier(df, target_col = 'y', numeric_feats='x')
#' fit_classifier(df, target_col = 'y')
fit_classifier <- function(train_df, target_col, numeric_feats= NULL, categorical_features= NULL, cv = 5){}

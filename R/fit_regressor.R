#' Fit dummy regressor and linear regression models
#'
#' @param train_df dataframe that will be used to train the model
#' @param target_col The column that needs to be classified as a string
#' @param numeric_feats The numeric columns as a vector character
#' @param categorical_feats The categorical columns as a vector character
#' @param cv The number of cross validation folds as an integer
#'
#' @return A data frame
#' @export
#'
#' @examples
#' fit_regressor(gapminder::gapminder, target_col="gdpPercap", numeric_feats=c("pop"), categorical_feats <- c("continent"), cv =5)
#' fit_regressor(gapminder::gapminder, target_col="gdpPercap", numeric_feats=c("year", "lifeExp", "pop"), categorical_feats <- c("continent"), cv =5)

fit_regressor <- function(train_df, target_col= NULL, numeric_feats= NULL, categorical_feats= NULL, cv = 5){

  #test for input types :
  if (!is.data.frame(train_df)){
    stop('Please input a dataframe')
  }
  if (is.null(target_col)){
    stop('Please enter a target column')
  }
  if (!is.vector(numeric_feats)){
    stop('Please enter a list for numeric columns')
  }
  if (!is.vector(categorical_feats)){
    stop('Please enter a list for categorical columns')
  }
  
  #test for input types :

  if (!all(target_col %in% colnames(dplyr::select_if(train_df, is.numeric)))){
    stop('Please enter a target column from numeric columns')
  }
  
  X_train <- train_df |> dplyr::select(-target_col)
  y_train <- train_df |> dplyr::select(target_col)
  
  # If numeric features is passed as an empty list
  if(is.null(numeric_feats)) {
    numeric_feats <- as.vector(colnames(dplyr::select_if(X_train, is.numeric)))
  } else {
    numeric_feats <- numeric_feats
  }
  if (!all(numeric_feats %in% colnames(dplyr::select_if(X_train, is.numeric)))){
    stop('Please enter numeric feats from numeric ones')
  }
  
  # If categorical features is passed as an empty list
  if(is.null(categorical_feats)) {
    categorical_feats <- as.vector(colnames(dplyr::select_if(X_train, Negate(is.numeric))))
  } else {
    categorical_feats <- categorical_feats
  }
  if (!all(categorical_feats %in% colnames(dplyr::select_if(X_train, Negate(is.numeric))))){
    stop('Please enter a categorical_feats from non numeric column')
  }

  
  # Scaling numeric columns
  X_train_numeric <- scale(X_train[numeric_feats])

  # One hot coding of categorical columns
  X_train[categorical_feats] <- lapply(X_train[categorical_feats], factor)
  X_train_categorical <- mltools::one_hot(data.table::as.data.table(X_train[categorical_feats]))

  # Combining pre-processed data
  train_preprocessed <- cbind(X_train_numeric, X_train_categorical, y_train)

  # Model
  set.seed(123)
  formula  = reformulate(".", response=target_col)

  #Dummy regressor
  model_null <- caret::train(formula , data = train_preprocessed, method = "null",
                      trControl = caret::trainControl(method = "cv", number = cv, savePredictions=TRUE))

  #Linear model
  model_lm <- caret::train(formula , data = train_preprocessed, method = "lm",
                    trControl = caret::trainControl(method = "cv", number = cv, savePredictions=TRUE))

  #Ridge
  model_ridge <- train(formula , data = train_preprocessed, method = "bridge",
                       trControl = caret::trainControl(method = "cv", number = cv, savePredictions=TRUE))

  #Result dataframe
  n <- model_null[["results"]] |>
    dplyr::select(Rsquared,RMSE)
  l <- model_lm[["results"]]  |>
    dplyr::select(Rsquared,RMSE)
  r <- model_ridge[["results"]]  |>
    dplyr::select(Rsquared,RMSE)
  models <- c("Dummy regressor", "Linear regression", "Ridge")
  results <- rbind(n,l,r)
  results <- cbind(models,results)

  return(results)

}
fit_regressor(gapminder::gapminder, target_col="gdpPercap", numeric_feats=c("year", "lifeExp", "pop"), categorical_feats = c("continent"), cv =5)




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
  if (!all(numeric_feats %in% colnames(dplyr::select_if(train_df, is.numeric)))){
    stop('Please enter numeric feats from numeric ones')
  }
  if (!all(categorical_feats %in% colnames(dplyr::select_if(train_df, Negate(is.numeric))))){
    stop('Please enter a categorical_feats from non numeric column')
  }


  if(is.null(numeric_feats)) {
    numeric_feats <- c(colnames(dplyr::select_if(train_df, is.numeric)))
  } else {
    numeric_feats <- numeric_feats
  }

  # Scaling numeric columns
  X_train_numeric <- scale(train_df[numeric_feats])

  # One hot coding of categorical columns
  train_df[categorical_feats] <- lapply(train_df[categorical_feats], factor)
  X_train_categorical <- mltools::one_hot(data.table::as.data.table(train_df[categorical_feats]))

  #y_train
  y_train <- train_df[target_col]

  # Combining pre-processed data
  train_preprocessed <- cbind(X_train_numeric, X_train_categorical, y_train)

  #create target_col
  # train_preprocessed$target_col_model <- train_preprocessed |> select(target_col)
  # train_preprocessed <- train_preprocessed |> select(-target_col)

  # Model
  set.seed(123)

  #Dummy regressor
  model_null <- caret::train(gdpPercap ~., data = train_preprocessed, method = "null",
                      trControl = caret::trainControl(method = "cv", number = cv, savePredictions=TRUE))

  #Linear model
  model_lm <- caret::train(gdpPercap ~., data = train_preprocessed, method = "lm",
                    trControl = caret::trainControl(method = "cv", number = cv, savePredictions=TRUE))

  #Ridge
  model_ridge <- train(gdpPercap ~., data = train_preprocessed, method = "bridge",
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




library(Matrix)
library(mltools)
library(readr)
library(tidyverse)
library(testthat)
library(dplyr)
library(data.table)
library(gapminder)
library(lattice)
library(caret)

#' Fit dummy regressor and linear regression models 
#'
#' @param train_df dataframe that will be used to train the model
#' @param target_col The column that needs to be classified as a string
#' @param numeric_feats The numeric columns as a vector character
#' @param categorical_feats The categorical columns as a vector character
#' @param cv The number of cross validation folds as an integer
#' @param st_seed The number of seedto setup
#' 
#' @return A data frame
#' @export
#'
#' @examples
#' library(lattice)
#' library(caret)
#' library(readr)
#' library(tidyverse)
#' library(testthat)
#' library(dplyr)
#' library(mltools)
#' library(data.table)
#' library(gapminder)
#' fit_regressor(data, target_col="gdpPercap", numeric_feats=c("pop"), categorical_feats <- c("continent"), cv =5, seed =124)
#' fit_regressor(data, target_col="gdpPercap", numeric_feats=c("year", "lifeExp", "pop"), categorical_feats <- c("continent"), cv =5, seed =124)
#' 
#' df <- data.frame(x = c(1, 2, 4, 6, 8),y = c(3, 6, 12, 18, 24))
#' fit_regressor(df, target_col = 'y', numeric_feats=c('x'))
#' fit_regressor(df, target_col = 'y')

fit_regressor <- function(train_df, target_col= NULL, numeric_feats= NULL, categorical_feats= NULL, cv = 5, set_seed = 123){
  
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
  
  if (!all(target_col %in% colnames(select_if(train_df, is.numeric)))){
    stop('Please enter a target column from numeric columns')
  }
  if (!all(numeric_feats %in% colnames(select_if(train_df, is.numeric)))){
    stop('Please enter numeric feats from numeric ones')
  }
  if (!all(categorical_feats %in% colnames(select_if(train_df, negate(is.numeric))))){
    stop('Please enter a categorical_feats from non numeric column')
  }
  
  
  if(is.null(numeric_feats)) {
    numeric_feats <- c(colnames(select_if(train_df, is.numeric)))
  } else {
    numeric_feats <- numeric_feats
  }
  
  # Scaling numeric columns
  X_train_numeric <- scale(train_df[numeric_feats])
  
  # One hot coding of categorical columns
  train_df[categorical_feats] <- lapply(train_df[categorical_feats], factor)
  X_train_categorical <- one_hot(as.data.table(train_df[categorical_feats]))
  
  #y_train
  y_train <- train_df[target_col] 
  
  # Combining pre-processed data
  train_preprocessed <- cbind(X_train_numeric, X_train_categorical, y_train)
  
  #create target_col
  # train_preprocessed$target_col_model <- train_preprocessed |> select(target_col)
  # train_preprocessed <- train_preprocessed |> select(-target_col)
  
  # Model
  set.seed(set_seed) 
  
  #Dummy regressor
  model_null <- train(gdpPercap ~., data = train_preprocessed, method = "null", 
                    trControl = trainControl(method = "cv", number = cv, savePredictions=TRUE))
  
  #Linear model
  model_lm <- train(gdpPercap ~., data = train_preprocessed, method = "lm",
                    trControl = trainControl(method = "cv", number = cv, savePredictions=TRUE))
  
  #Ridge
  model_ridge <- train(gdpPercap ~., data = train_preprocessed, method = "bridge",
                    trControl = trainControl(method = "cv", number = cv, savePredictions=TRUE))
  
  #Result dataframe
  n <- model_null[["results"]] |> 
    select(Rsquared,RMSE)
  l <- model_lm[["results"]]  |> 
    select(Rsquared,RMSE)
  r <- model_ridge[["results"]]  |> 
    select(Rsquared,RMSE)
  models <- c("Dummy regressor", "Linear regression", "Ridge")
  results <- rbind(n,l,r)
  results <- cbind(models,results)
  
  return(results)
  
}

# data <-  gapminder
# output_function <- fit_regressor(data, target_col="gdpPercap", numeric_feats=c("year", "lifeExp", "pop"), categorical_feats <- c("continent"), cv =5)



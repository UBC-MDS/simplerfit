#' Fit dummy regressor and linearregression models 
#'
#' @param train_df dataframe that will be used to train the model
#' @param target_col The column that needs to be classified as a string
#' @param numeric_feats The numeric columns as a vector character
#' @param categorical_feats The categorical columns as a vector character
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
#' fit_regressor(df, target_col = 'y', numeric_feats=c('x'))
#' fit_regressor(df, target_col = 'y')

library(caret)
library(readr)
library(tidyverse)
library(testthat)
library(dplyr)
library(mltools)
library(data.table)

fit_regressor <- function(train_df, target_col, numeric_feats= NULL, categorical_feats= NULL, cv = 5){
  
  # test_that(‘x and y should contain the same value’, {      test if the train_df is clean data or datatype
  #   expect_equal(x,y)
  # })
  
  #selecting the features and target col
  regressors = c(numeric_feats, categorical_feats, target_col)
  train_df = train_df |> 
    select(regressors)
  
  # pp_cs <- preProcess(train_df, 
  #                     method = c("center", "scale"))
  # transformed <- predict(pp_cs, newdata = train_df)
  
  
  # Scaling numeric columns
  X_train_numeric <- scale(train_df[, numeric_feats])
  
  # One hot coding of categorical columns
  train_df[categorical_feats)] <- lapply(train_df[categorical_feats], factor)
  X_train_categorical <- one_hot(as.data.table(train_df[categorical_feats]))
  
  #y_train
  y_train <- train_df[target_col] 
  
  # Combining pre-processed data
  train_preprocessed <- cbind(X_train_numeric, X_train_categorical, y_train)
  
  # Model
  set.seed(123) 
  
  #Dummyregressor
  model_null <- train(popularity ~., data = train_preprocessed, method = "null", 
                    trControl = trainControl(method = "cv", number = cv, savePredictions=TRUE))
  
  #Linear model
  model_lm <- train(popularity ~., data = train_preprocessed, method = "lm", 
                    trControl = trainControl(method = "cv", number = cv, savePredictions=TRUE))
  
  #Ridge
  model_ridge <- train(popularity ~., data = train_preprocessed, method = "bridge", 
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
print("hi")

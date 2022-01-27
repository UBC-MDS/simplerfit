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
  
  #test for input types : 

  test_that("Train_df should be a dataframe", {
    expect_true(sum(class(train_df) == "data.frame") > 0)
  })
  test_that("target_col should be a vector", {
    expect_true(is.vector(target_col))
  })
  test_that("numeric_feats type should be a vector", {
    expect_true(is.vector(numeric_feats))
  })
  test_that("Categorical_feats type should be a vector", {
    expect_true(is.vector(categorical_feats))
  })
  test_that("CV should be a integer number", {
    expect_true(is.numeric(cv))
  })
  
  
  #tests for imputs values
  
  test_that("Train dataframe should be clean", {
    expect_equal(sum(is.na(train_df)), 0)
  })
  test_that("target_col should be a column from numeric columns", {
    expect_true(all(target_col %in% colnames(select_if(train_df, is.numeric)))),
    expect_equal(length(target_col),1)
  })
  test_that("numeric_feats should be from numeric columns", {
    expect_true(all(numeric_feats %in% colnames(select_if(train_df, is.numeric))))
  })
  test_that("categorical_feats should be from non numeric columns", {
    expect_true(all(categorical_feats %in% colnames(select_if(train_df, negate(is.numeric)))))
  })
  
  
  
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

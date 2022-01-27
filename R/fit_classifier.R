#' Fit dummy classifier and Logistic regression models
#'
#' @param train_df dataframe that will be used to train the model
#' @param target_col The column that needs to be classified as a string
#' @param numeric_feats The numeric columns as a list
#' @param categorical_feats The categorical columns as a list
#' @param cv The number of cross validation folds as an integer
#'
#' @return A data frame
#' @export
#'
#' @examples
#' library(tidyverse)
#' library(caret)
#' library(mltools)
#' library(data.table)
#' data <- data.frame(x = c(1, 2, 4, 6, 8), y = c("Yes", "No", "Maybe", "Someday", "Never"), z = c(0, 1, 1, 0, 1))
#' fit_classifier(data, target_col = 'z', numeric_feats = list(), categorical_feats = list('y'), cv = 10)
#' fit_classifier(data, target_col = 'z', numeric_feats = list('x'), categorical_feats = list('y'), cv = 5)

fit_classifier <- function(train_df, target_col, numeric_feats= list(), categorical_feats= list(), cv = 5){
    
    library(dplyr)
    #install.packages("caret")
    library(caret)
    #install.packages("mltools")
    #install.packages("data.table")
    library(mltools)
    library(data.table)
    
    if (!is.data.frame(train_df)){
        stop('Please input a dataframe')
    }
    
    if (is.null(target_col)){
        stop('Please enter a target column')
    }
    
    if (!is.list(numeric_feats)){
        stop('Please enter a list for numeric columns')
    }
    
    if (!is.list(categorical_feats)){
        stop('Please enter a list for categorical columns')
    }
    
    X_train <- train_df |> select(-target_col)
    y_train <- train_df |> select(target_col)
    
    # If numeric features is passed as an empty list
    if(length(numeric_feats) == 0 ) {
        numeric_feats <- as.list(strsplit(c(colnames(select_if(X_train, is.numeric))), " "))
    } else {
        numeric_feats <- numeric_feats
    }
    
    
    # If categorical features is passed as an empty list
    if(length(categorical_feats) == 0 ) {
        categorical_feats <- as.list(strsplit(c(colnames(select_if(X_train, is.character))), " "))
    } else {
        categorical_feats <- categorical_feats
    }
    
    
    # Scaling numeric columns
    X_train_numeric <- scale(X_train[, unlist(numeric_feats)])
    
    # One hot coding of categorical columns
    X_train[, unlist(categorical_feats)] <- as.factor(X_train[, unlist(categorical_feats)])
    X_train_categorical <- one_hot(as.data.table(X_train[, unlist(categorical_feats)]))
    
    # Combining pre-processed data
    train_preprocessed <- cbind(X_train_numeric, X_train_categorical, y_train)
    
    # Model
    set.seed(123) 
    lr_model <- train(as.factor(income) ~., 
                      data = train_preprocessed, 
                      method = "glm", 
                      family = "binomial", 
                      trControl = trainControl(method = "cv", number = cv, savePredictions=TRUE))
    
    # Dummy Classifier
    lr_model_2 <- train(as.factor(income) ~., 
                        data = train_preprocessed, 
                        method = "null", 
                        trControl = trainControl(method = "cv", number = cv, savePredictions=TRUE))
    
    # Model Accuracy
    
    lr_results <- data.frame(dummy_classifier = lr_model_2$results[[2]], logistic_regression = lr_model$results[[2]])
    
    return(lr_results)
}
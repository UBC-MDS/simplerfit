library(dplyr)
library(caret)
library(mltools)
library(data.table)

test_that('FAILED',{
    
    data <- read_csv('../data/adult.csv')
    data <- na.omit(data)
    
    # Splitting data into test and train
    set.seed(123)
    index <- sample(1:nrow(data), 0.8*nrow(data))
    train_df <- data[index,] # Create the training data
    test_df <- data[-index,] # Create the test data
    
    
    expect_error(fit_classifier(1))
    expect_error(fit_classifier(train_df, numeric_feats = list("age"), categorical_feats = list(), cv = 5))
    expect_error(fit_classifier(train_df, target_col = "income", categorical_feats = list("occupation"), cv = 5))
    expect_error(fit_classifier(train_df, target_col = "income", numeric_feats = list("age"), cv = 5))
    
    
    test_that('Plot should use Ggally corr and map x to x-axis', {
        expect_true(is.data.frame(fit_classifier(train_df,
                                                 target_col = 'income',
                                                 numeric_feats = list('age', 'fnlwgt', 'hours.per.week', 'education.num', 'capital.gain', 'capital.loss'),
                                                 categorical_feats = list('occupation'),
                                                 cv=5)))
        
    })
    
})

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
#' gapminder <- gapminder::gapminder |> dplyr::filter(continent=="Asia" | continent=="Europe")
#' gapminder$country <- as.character(gapminder$country)
#' gapminder$continent <- as.character(gapminder$continent)
#' gapminder$year <- as.numeric(gapminder$year)
#' gapminder$pop <- as.numeric(gapminder$pop)
#' fit_classifier(gapminder, target_col = 'continent', numeric_feats = list('gdpPercap'), categorical_feats = list('country'), cv = 5)

fit_classifier <- function(train_df, target_col, numeric_feats= NULL, categorical_feats= NULL, cv = 5){

    formula  = reformulate(".", response=target_col)

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

    X_train <- train_df |> dplyr::select(-target_col)
    y_train <- train_df |> dplyr::select(target_col)

    # If numeric features is passed as an empty list
    if(length(numeric_feats) == 0 ) {
        numeric_feats <- as.list(strsplit(c(colnames(dplyr::select_if(X_train, is.numeric))), " "))
    } else {
        numeric_feats <- numeric_feats
    }


    # If categorical features is passed as an empty list
    if(length(categorical_feats) == 0 ) {
        categorical_feats <- as.list(strsplit(c(colnames(dplyr::select_if(X_train, is.character))), " "))
    } else {
        categorical_feats <- categorical_feats
    }


    # Scaling numeric columns
    X_train_numeric <- scale(X_train[, unlist(numeric_feats)])

    # One hot coding of categorical columns
    X_train[unlist(categorical_feats)] <- lapply(X_train[unlist(categorical_feats)], factor)
    X_train_categorical <- mltools::one_hot(data.table::as.data.table(X_train[, unlist(categorical_feats)]))

    # Combining pre-processed data
    train_preprocessed <- cbind(X_train_numeric, X_train_categorical, y_train)

    # Model
    set.seed(123)
    lr_model <- caret::train(formula,
                             data = train_preprocessed,
                             method = "glm",
                             family = "binomial",
                             trControl = caret::trainControl(method = "cv", number = cv, savePredictions=TRUE))

    # Dummy Classifier
    lr_model_2 <- caret::train(formula,
                               data = train_preprocessed,
                               method = "null",
                               trControl = caret::trainControl(method = "cv", number = cv, savePredictions=TRUE))

    # Model Accuracy

    lr_results <- data.frame(dummy_classifier = lr_model_2$results[[2]], logistic_regression = lr_model$results[[2]])

    return(lr_results)
}


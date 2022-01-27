
#' Returns correlation plot for all the columns in dataset

#' @param data a dataframe
#' @param corr type of correlation: 'spearman', 'kendall' or 'pearson'
#' @param pair_cols : a character vector od columns for which you want correlation plot
#' @return corr_plot, a ggplot chart object
#' @export
#'
#' @examples
#' library(tidyverse)
#' library(ggplot2)
#' library(dplyr)
#' data <- data.frame(age = c(1, 2, 4, 6, 8),education.num = c(3, 6, 12, 18, 24), target=c(20, 30, 12, 0, 2))
#' plot_corr(data, corr = 'pearson', pair_cols=c('age', 'education.num'))
#' plot_corr(data)

plot_corr <- function(data, corr='pearson', pair_cols=NULL){

  if (!is.data.frame(data)){
    stop('Value provided for data is not a data frame')
  }

  if (!is.null(pair_cols) & !is.vector(pair_cols, mode='character')){
    stop('Value provided for pair_cols is not a vector')
  }

  if (!is.character(corr)){
    stop('Value of density is not a boolean')
  }

  if(!is.null(pair_cols)){

    data <- data |>
      dplyr::select(pair_cols)
  }
  corr_plot <- GGally::ggcorr(data,low = "steelblue", mid = "white", high = "darkred", label=TRUE,method = c("everything", corr)) + ggtitle("Correlation between features")
  corr_plot

}

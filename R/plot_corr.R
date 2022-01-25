
#' Returns correlation plot for all the columns in dataset

#' @param data a dataframe
#' @param corr type of correlation: 'spearman', 'kendall' or 'pearson'
#' @param pair_cols : a character vector od columns for which you want correlation plot
#' @return corr_plot, a ggplot chart object
#' @export
#'
#' @examples
#' data <- read_csv("../tests/Spotify_Features.csv")
#' corr_plot(data, corr = 'pearson', pair_cols=c('age', 'education.num'))
#' corr_plot(data)

plot_corr <- function(data, corr='pearson', pair_cols=NULL){
  if(!is.null(pair_cols)){

    data <- data |>
      select(pair_cols)
  }
  corr_plot <- GGally::ggcorr(data,low = "steelblue", mid = "white", high = "darkred", label=TRUE,method = c("everything", corr) )
  corr_plot

}

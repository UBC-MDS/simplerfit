
#' Returns correlation plot for all the columns in dataset

#' @param data a dataframe
#' @param corr type of correlation: 'spearman', 'kendall' or 'pearson'
#' @return corr_plot, a ggplot chart object
#' @export
#'
#' @examples
#' data <- read_csv("../tests/Spotify_Features.csv")
#' corr_plot(data, corr = 'pearson')
#' corr_plot(data)

plot_corr <- function(data, corr='spearman'){}

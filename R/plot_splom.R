
#' Returns SPLOM plot on either all the numeric columns or the ones provided to it

#' @param data a dataframe
#' @param pair_cols list of columns for which SPLOM plot has to be generated
#' @return splom_plot, a ggplot chart object
#' @export
#'
#' @examples
#' data <- read_csv("../tests/Spotify_Features.csv")
#' splom_plot(data, pair_cols=list("loudness", "acousticness"))
#' splom_plot(data)

plot_splom <- function(data, pair_cols=NULL){}

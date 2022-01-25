
#' Returns SPLOM plot on either all the numeric columns or the ones provided to it

#' @param data a dataframe
#' @param pair_cols list of columns for which SPLOM plot has to be generated
#' @return splom_plot, a ggplot chart object
#' @export
#'
#' @examples
#' data <- read_csv("../tests/Spotify_Features.csv")
#' plot_splom(data, cols=c("loudness", "acousticness"))
#' plot_splom(data)
library(GGally)

plot_splom <- function(data, cols=NULL){
  if(!is.null(cols)){

    data <- data |>
      dplyr::select(cols)
  }

  splom_plot <- GGally::ggpairs(data |> select_if(is.numeric), progress = FALSE)
  splom_plot
}


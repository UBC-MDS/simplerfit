
#' Returns SPLOM plot on either all the numeric columns or the ones provided to it
#' @param data a dataframe
#' @param pair_cols list of columns for which SPLOM plot has to be generated
#' @return splom_plot, a ggplot chart object
#' @export
#'
#' library(dplyr)
#' library(tidyverse)
#' @examples
#' data <- data.frame(age = c(1, 2, 4, 6, 8),acousticness= c(3, 6, 12, 18, 24), loudness= c(3, 6, 12, 18, 24), target=c(20, 30, 12, 0, 2))
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


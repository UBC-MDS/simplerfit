#' Returns numerical distribution plots on either all the numeric columns or the ones provided to it

#' @param data a dataframe
#' @param bins number of bins in the histogram plot; numeric
#' @param dist_cols a list of numeric cols
#' @param class_label target col in dataframe of type character
#' @return chart_numeric, a ggplot chart object
#' @export
#'
#' @examples
#' data <- read_csv("../tests/Spotify_Features.csv")
#' plot_distributions(data, bins = 30, hist_cols=c("acousticness", "loudness"), density=TRUE)
#' plot_distributions(data, bins = 30)
#' plot_distributions(data, density=TRUE)

plot_distributions <- function(df, bins = 40, hist_cols=NULL, density=FALSE){
  if (!is.null(hist_cols)){

    data_long <-  df|>
      select_if(is.numeric) |>
      pivot_longer(hist_cols)
  }
  else{
    data_long <-  df|>
      select_if(is.numeric) |>
      pivot_longer(everything())
  }


  if(!density){
    plot_dist <- ggplot2::ggplot(data_long, ggplot2::aes(x = value))+
      ggplot2::facet_wrap(~name, scales = "free_x") +
      ggplot2::geom_histogram(bins=bins) }
  else{
    plot_dist <- ggplot2::ggplot(data_long, ggplot2::aes(x = value))+
      ggplot2::facet_wrap(~name, scales = "free_x") +
      ggplot2::geom_density(fill="green")

  }
  plot_dist
}

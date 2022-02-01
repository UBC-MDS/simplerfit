#' Returns numerical distribution plots on either all the numeric columns or the ones provided to it

#' @param data a dataframe
#' @param bins number of bins in the histogram plot; numeric
#' @param hist_cols a list of numeric cols
#' @param density target col in dataframe of type character
#' @return chart_numeric, a ggplot chart object
#' @export

#' @examples

#' data <- data.frame(age = c(1, 2, 4, 6, 8),acousticness= c(3, 6, 12, 18, 24), loudness= c(3, 6, 12, 18, 24), target=c(20, 30, 12, 0, 2))
#' plot_distributions(data, bins = 30, hist_cols=c("acousticness", "loudness"), density=TRUE)
#' plot_distributions(data, bins = 30)
#' plot_distributions(data, density=TRUE)

plot_distributions <- function(data, bins = 40, hist_cols=NULL, density=FALSE){
  

  if (!is.data.frame(data)){
    stop('Value provided for df is not a data frame')
  }

  if (!is.numeric(bins)){
    stop('Value provided for bins is not numeric')
  }

  if (!is.null(hist_cols) & !is.vector(hist_cols, mode='character')){
    stop('Value provided for hist_cols is not a vector')
  }

  if (!is.logical(density)){
    stop('Value of density is not a boolean')
  }


  if (!is.null(hist_cols)){

    data_long <-  data|>
      dplyr::select_if(is.numeric) |>
      tidyr::pivot_longer(hist_cols)
  }
  else{
    data_long <-  data|>
      dplyr::select_if(is.numeric) |>
      tidyr::pivot_longer(everything())
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

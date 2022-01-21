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
#' plot_distributions(data, bins = 30, dist_cols=list("acousticness", "loudness"), class_label="target")
#' plot_distributions(data, bins = 30)

plot_distributions <- function(data, bins = 40, dist_cols=NULL, class_label=NULL){


}

#'Clean_data
#'Load downloaded data, clean the dataset, strip extra white spaces from column names, convert column names to lower case, remove the NA rows and return clean data
#' @param  data.frame Data set to clean
#'
#' @return data A cleaned and simplified DataFrame of the relevant columns for summary and visualization
#' @export
#'
#' @examples
#' df <- clean_data(data)

clean_data <- function(data){
            if (is.null(data)) {
            stop("No argument. Please call data frame with a dataframe as the only argument")}
            if (!is.data.frame(data)) {
            stop("Please call data frame with a dataframe as the only argument")}
     clean_data
}

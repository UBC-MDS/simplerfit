
#' Clean and return dataframe
#' Loads dataframe, removes Nan rows, strips whitespaces, converts columns to lowercase and returns a clean dataframe
#' @param data : A raw dataframe
#'
#' @return data : clean dataframe
#' @export
#'
#' @examples
#' library(tidyverse, quietly = TRUE)
#' data= tibble(num_legs= c(2, 4, 8, 0), num_wings= c('bad', 'Good', NA, 'bad'),Num_specimen = c(10, 2, 1, 8))
clean_data <- function(data){

            if (is.null(data)) {
            stop("No argument. Please call data frame with a dataframe as the only argument")}

            if (!is.data.frame(data)) {
            stop("Please call data frame with a dataframe as the only argument")}

            # Drop all rows that have a NaN in any column
            data <-data|> stats::na.omit()

            # Strip extra white spaces from column names, and data
            names(data) <- gsub(" ", "_", names(data))

            # Convert colnames to lower case
            if(stringr::str_detect(data,"[[:upper:]]") == FALSE){
            names(data) <- stringr::tolower(names(data))}

       #Return clean dataframe
       data
}

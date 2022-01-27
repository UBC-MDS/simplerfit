#'Clean_data
#'Load downloaded data, clean the dataset, strip extra white spaces from column names, convert column names to lower case, remove the NA rows and return clean data
#' @param  data.frame Data set to clean
#'
#' @return data A cleaned and simplified DataFrame of the relevant columns for summary and visualization
#' @export
#'
#' @examples
#' df <- clean_data(data)

library(tidyverse, quietly = TRUE)

data= tibble(num_legs= c(2, 4, 8, 0),
             `num_  wings`= c('bad', 'Good', NA, 'bad'),
             `Num  specimen` = c(10, 2, 1, 8))



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
            if(str_detect(data,"[[:upper:]]") == FALSE){
            names(data) <- tolower(names(data))}

       #Return clean dataframe
       data
}

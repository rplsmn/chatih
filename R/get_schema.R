#' Get schema for a data source
#'
#' @param source A querychat_data_source object
#' @param ... Additional arguments passed to methods
#' @return A character string describing the schema
#' @export
get_schema <- function(source, ...) {
  UseMethod("get_schema")
}

#' @export
get_schema.default <- function(source, ...) {
  return(
    paste0(
      "Table: iris\nColumns:\n- Sepal.Length (FLOAT)\n  Range: 4.3 to 7.9\n- Sepal.Width (FLOAT)\n  Range: 2 to 4.4\n- Petal.Length (FLOAT)\n  Range: 1 to 6.9\n- Petal.Width (FLOAT)\n  Range: 0.1 to 2.5\n- Species (TEXT)\n  Categorical values: 'setosa', 'versicolor', 'virginica' \n",
      "Table: categ\nColumns:\n- Species (TEXT)\n  Categorical values: 'setosa', 'versicolor', 'virginica' \n - Location (TEXT)\n  Categorical values: 'Europe', 'USA'\n"
    )
  )
}

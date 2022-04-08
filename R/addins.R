#' Creates a Reprex of selected code (or from input) renders it and opens or downloads the Carbon
#'
#' @param ... arguments passed to [reprex::reprex]
#' @param html_preview show also reprex html result? Default is false
#' @param style should the code be styled? Default is True
#' @param url_only if only the URL should be returned without opening the browser
#'
#' @return the URL to the Carbon (invisible) or the filename (invisible)
#' @export
#'
#' @examples
#' \dontrun{
#' reprex_to_carbon_browser(input = c("   x=1:  10", "   x"))
#' # copy the following code using STRG + C or similar:
#'   a <- 1:10
#'   b <- rnorm(10)
#'   cbind(a, b)
#'   plot(a, b)
#'
#' # Then run this
#' reprex_to_carbon_browser()
#' }
reprex_to_carbon_browser <- function(..., html_preview = FALSE, style = TRUE,
                                     url_only = FALSE) {
  res <- reprex::reprex(..., venue = "r", html_preview = html_preview,
                        style = style)
  res <- paste(res[!grepl("^#' !\\[", res)], collapse = "\n")
  
  carb <- carbon$new(trimws(res))
  if (url_only) return(carb$uri)
  
  carb$browse()
  return(invisible(carb$uri))
}

#' @describeIn reprex_to_carbon_browser downloads the picture
#' @export
reprex_to_carbon_download <- function(..., file = "carbon_reprex.png", 
                                      html_preview = FALSE, style = TRUE,
                                      url_only = FALSE) {
  res <- reprex::reprex(..., venue = "r", html_preview = html_preview,
                        style = style)
  res <- paste(res[!grepl("^#' !\\[", res)], collapse = "\n")
  
  carb <- carbon$new(trimws(res))
  if (url_only) return(carb$uri)
  
  # check if the file exists, if so, increase version of the file
  while (file.exists(file)) {
    if (!grepl("-\\d+\\.(png|jpg)$", file)) { 
      file <- gsub("\\.(png|jpg)$", "-01.\\1", file)
    } else {
      nr <- as.integer(gsub("^.*-(\\d+)\\.(png|jpg)$", "\\1", file)) + 1
      file <- gsub("^(.*)-\\d+\\.(png|jpg)$", sprintf("\\1-%02i.\\2", nr), file)
    }
  }  
  
  carb$carbonate(file = file)
  return(invisible(file))
}

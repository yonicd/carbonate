#' @title Carbonate script lines to a carbon image
#' @description Main function of the package that invokes RSelenium to open
#'  a browser to the carbon.js uri, create an image and download the file.
#' @param self carbon self object
#' @param private carbon private object
#' @param file character, name of file to save image as
#' @param path character, path to save the image
#' @param code character, lines of script to make carbon image from
#' @param rD RSelenium driver
#' @param driver character, select either 'firefox' or 'chrome' driver
#' @details Script is passed to <https://carbon.now.sh/> is downloaded to the `tempdir()` and appended to the list [$carbons][carbonate::carbon-fields] using RSelenium and Chrome.
#' @return image object
#' @examples
#' if(interactive()){
#'  x <- carbon$new('x <- 1')
#'  x$carbonate()
#'  }
#' @seealso
#'  [carbon][carbonate::carbon], [rsDriver][RSelenium::rsDriver]
#' @rdname carbonate
#' @aliases carbon-carbonate carbonate
#' @importFrom magick image_read
#' @importFrom utils capture.output
#' @importFrom rtweet post_tweet
.carbonate <- function(self, private, file, path,  code, rD, driver) {
  
  this_uri <- self$uri(code = code)

  path <- normalizePath(path,mustWork = FALSE)
  
  device <- gsub("^(.*?)\\.", "", basename(file))
  
  if(!dir.exists(path)){
    message(sprintf('creating directory: %s', path))
    dir.create(path)
  }
  
  if (file.exists(file.path(path, sprintf("carbon.%s", device)))) {
    unlink(file.path(path, sprintf("carbon.%s", device)), force = TRUE)
  }
    
  if (is.null(rD)) {
    message(sprintf("starting %s session...", driver))
  
    self$start()
    rD <- self$rD
  }

  if (length(rD$client$getSessions()) == 0) {
    invisible(utils::capture.output(rD$client$open()))
  }

  on.exit({
    rD$client$close()
  }, add = TRUE)

  remDr <- rD$client

  # remDr$queryRD(
  #   ipAddr = file.path(remDr$serverURL,"session",
  #                      remDr$sessionInfo[["id"]],
  #                      "chromium/send_command"),
  #   method = "POST",
  #   qdata = list(
  #     cmd = "Page.setDownloadBehavior",
  #     params = list(
  #       behavior = "allow",
  #       downloadPath = path
  #     )
  #   )
  # )

  remDr$navigate(this_uri)
  
  asyncr(remDr,
    using = "xpath",
    value = '//*[@id="export-menu"]',
    maxiter = self$maxiter
  )

  asyncr(remDr,
    using = "xpath",
    value = sprintf('//*[@id="export-%s"]', device),
    maxiter = self$maxiter
  )

  file.timeout(private$temp_dir,device)
  
  if (file.exists(file.path(private$temp_dir, sprintf("rcarbon.%s", device)))) {
    unlink(file.path(private$temp_dir, sprintf("rcarbon.%s", device)), force = TRUE)
  }

  file.rename(file.path(private$temp_dir, sprintf("carbon.%s", device)), file.path(private$temp_dir, sprintf("rcarbon.%s", device)))

  file.rename(file.path(private$temp_dir, sprintf("rcarbon.%s", device)), file.path(path, file))

  img <- magick::image_read(file.path(path, file))

  if (self$add_tinyurl) {
    tiny_uri <- self$tiny()

    img <- magick::image_annotate(img, text = tiny_uri, gravity = self$tinyurl_location)

    magick::image_write(img, file.path(path, file))

    self$tweet_status <- sprintf("%s\nCheck out this script at \U0001f517 %s", self$tweet_status, tiny_uri)
  }

  if (self$tweet) {
    if (length(Sys.getenv("TWITTER_SCREEN_NAME")) == 0) {
      message("missing Environment Variable: 'TWITTER_SCREEN_NAME'\nskipping tweet \U0001f622")
    } else {
      self$rtweet(media = file.path(path, file))
    }
  }

  self$carbons <- append(self$carbons, img)

  print(img, info = FALSE)
}

#' @title chrome webdriver functions
#' @description Functions to open,close,set chrome webdriver
#' @param self carbon self object
#' @param private carbon private object
#' @rdname carbon_chrome
#' @aliases carbon-chrome
#' @seealso
#'  [carbon][carbonate::carbon], [chrome][wdman::chrome]

.chromeOptions <- function(self, private) {
  list(chromeOptions = list(args = self$chrome_args, prefs = self$chrome_pref))
}

#' @title gecko webdriver functions
#' @description Functions to open,close,set gecko webdriver
#' @param self carbon self object
#' @param private carbon private object
#' @rdname carbon_gecko
#' @aliases carbon-gecko
#' @seealso
#'  [carbon][carbonate::carbon], [gecko][wdman::gecko]

.firefoxOptions <- function(self, private) {
  
  append(
    RSelenium::makeFirefoxProfile(self$firefox_pref),
    list( "moz:firefoxOptions" = list(args = self$firefox_args))
  )
  
}

#' @title RSelenium webdriver functions
#' @description Functions to open,stop, stop_all RSelenium sessions
#' @param self carbon self object
#' @param private carbon private object
#' @param eCap chromeOptions passed into [rsDriver][RSelenium::rsDriver]
#' @param driver character, select either 'firefox' or 'chrome' driver
#' @rdname carbon_selenium
#' @aliases carbon-selenium
#' @seealso
#'  [carbon][carbonate::carbon]
#' @importFrom RSelenium rsDriver makeFirefoxProfile
.start <- function(self, private, eCap, driver = c("firefox", "chrome")) {
  driver <- match.arg(driver, c("firefox", "chrome"))
  if (is.null(self$cDrv)) {
    self$driver_start(driver)
  }

  self$rD <- RSelenium::rsDriver(
    browser = driver,
    verbose = FALSE,
    port = private$port,
    extraCapabilities = eCap
  )
}

#' @rdname carbon_selenium
#' @importFrom wdman gecko chrome
.driver_start <- function(self, private, driver = c("chrome", "firefox")) {
  driver <- match.arg(driver, c("chrome", "firefox"))
  self$cDrv <- switch(driver,
    chrome = wdman::chrome(port = private$port),
    firefox = wdman::gecko(port = private$port)
  )
}

#' @rdname carbon_selenium
.driver_stop <- function(self, private) {
  self$cDrv$stop()
}

#' @rdname carbon_selenium
.stop <- function(self, private) {
  self$rD$client$close()
  self$driver_stop()
}

#' @rdname carbon_selenium
.stop_all <- function(self, private) {
  self$rD$client$closeall()
  self$driver_stop()
}

#' @rdname carbon_selenium
#' @param port integer, port for the [rsDriver][RSelenium::rsDriver] to use, 
#'   if NULL then a random port is selected
.set_port <- function(self, private, port = NULL){
  if(!is.null(private$port))
    private$port
  
  if(is.null(port)){
    private$port <- .random_port(self, private)
  }else{
    private$port <- as.integer(port)
  }
}

#' @rdname carbon_selenium
.get_port <- function(self, private){
  private$port
}
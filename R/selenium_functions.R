#' @title chrome webdriver functions
#' @description Functions to open,close,set chrome webdriver 
#' @param self carbon self object
#' @param private carbon private object
#' @rdname carbon_chrome
#' @aliases carbon-chrome
#' @seealso 
#'  [carbon][carbonate::carbon], [chrome][wdman::chrome]

.chromeOptions <- function(self, private){
  
  list(args = self$chrome_args,prefs = self$chrome_pref)
  
}

#' @rdname carbon_chrome
#' @importFrom wdman chrome
.chrome_start <- function(self, private){
  self$cDrv <- wdman::chrome()
}

#' @rdname carbon_chrome
.chrome_stop = function(self, private){
  self$cDrv$stop()
}


#' @title RSelenium webdriver functions
#' @description Functions to open,stop, stop_all RSelenium sessions
#' @param self carbon self object
#' @param private carbon private object
#' @param eCap chromeOptions passed into [rsDriver][RSelenium::rsDriver]
#' @rdname carbon_selenium
#' @aliases carbon-selenium
#' @seealso 
#'  [carbon][carbonate::carbon]
#' @importFrom RSelenium rsDriver
.start = function(self, private, eCap) {
  
  
  if(is.null(self$cDrv)){
    self$chrome_start()  
  }
  
  self$rD <- RSelenium::rsDriver(browser = "chrome",
                                 verbose = FALSE, 
                                 port = 4567L,
                                 extraCapabilities = list(
                                   chromeOptions = eCap)
  )
}

#' @rdname carbon_selenium
.stop = function(self, private){
  self$rD$client$close()
  self$chrome_stop()
}

#' @rdname carbon_selenium
.stop_all = function(self, private){
  self$rD$client$closeall()
  self$chrome_stop()
}
#' @title Carbonate script lines to a carbon image
#' @description Main function of the package that invokes RSelenium to open
#'  a browser to the carbon.js uri, create an image and download the file.
#' @param self carbon self object
#' @param private carbon private object
#' @param file character, name of file to save image as
#' @param code character, lines of script to make carbon image from
#' @param rD RSelenium driver
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
.carbonate <- function(self,private,file,code,rD){
  
  if(is.null(rD)){
    message('starting chrome session...')
    self$start()
    rD <- self$rD
  }
  
  if(length(rD$client$getSessions())==0)
    invisible(capture.output(rD$client$open()))
  
  on.exit(rD$client$close(),add = TRUE)
  
  remDr <- rD$client
  
  path <- rD$client$extraCapabilities$chromeOptions$prefs$download.default_directory  
  
  device <- gsub('^(.*?)\\.','',basename(file))
  
  remDr$navigate(self$uri(code = code))
  
  Sys.sleep(2)
  
  webElem <- remDr$findElement(using = 'xpath',value = '//*[@id="toolbar"]/div[5]/div')
  
  webElem$clickElement()
  
  Sys.sleep(2)
  
  webSubElem <- remDr$findElement(using = 'xpath',value = sprintf('//*[@id="downshift-2-item-%s"]',as.numeric(device=='svg')))
  
  webSubElem$clickElement()
  
  Sys.sleep(3)
  
  file.rename(file.path(path,sprintf('carbon.%s',device)),file.path(path,sprintf('rcarbon.%s',device)))
  
  file.rename(file.path(path,sprintf('rcarbon.%s',device)),file.path(path,file))
  
  img <- magick::image_read(file.path(path,file))
  
  self$carbons <- append(self$carbons,img)
  
  print(img, info = FALSE)
  
}
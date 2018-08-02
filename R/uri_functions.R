#' @title concatenate the carbon options to a string
#' @description combine all the carbon options into a carbon.js valid string
#' @param self carbon self object
#' @param private carbon private object
#' @param code character, script to embbed into the uri
#' @return OUTPUT_DESCRIPTION
#' @rdname options
#' @aliases carbon-options
#' @seealso 
#'  [carbon][carbonate::carbon]

.options <- function(self,private,code){
  
  l <-private$map()
  
  s <- paste0(sapply(names(l),function(x) sprintf('%s=%s',x,l[[x]])),collapse = '&')
  
  code <- paste0(code,collapse = '\n')
  
  sprintf('%s&code=%s',s,self$encode(code))
}

#' @title URI constructor
#' @description Function that is called in a carbon object to construct valid uri to send to browser
#' @param self carbon self object
#' @param private carbon private object
#' @param code character, script to embbed into the uri
#' @examples 
#' x <- carbon$new('x <- 1')
#' 
#' # populate from self$code
#' x$uri()
#' 
#' # enter manually
#' x$uri(code = 'x <- y + 3')

#' @rdname uri 
#' @aliases carbon-uri
#' @seealso 
#'  [carbon][carbonate::carbon]
.uri <- function(self,private,code){
  sprintf('https://carbon.now.sh?%s',self$options(code = code))
}

#' @title open $uri to in browser window
#' @description opens the uri address in $uri in the browser window.
#' @param self carbon self object
#' @param private carbon private object
#' @examples 
#' x <- carbon$new('x <- 1')
#' if(interactive())
#'  x$browse()
#'  
#' @rdname browse
#' @aliases carbon-browse
#' @importFrom utils browseURL
#' @seealso 
#'  [carbon][carbonate::carbon]
.browse = function(self,private){
    utils::browseURL(self$uri())
}

#' @title encode uri for carbon.js
#' @description encode uri string for carbon.js. 
#'  Augmented version of than [URLencode][utils::URLencode]
#' @param self carbon self object
#' @param private carbon private object
#' @param URL character, uri string to url encode
#' @param reserved boolean, should ‘reserved’ characters be encoded?
#' @param repeated boolean, should apparently already-encoded URLs be encoded again?
#' @return character
#' @seealso [URLencode][utils::URLencode], [carbon][carbonate::carbon]
#' @rdname encode
#' @aliases carbon-encode

.encode <- function(self, private, URL, reserved, repeated){
  if (!repeated && grepl("%[[:xdigit:]]{2}", URL, useBytes = TRUE)) 
    return(URL)
  OK <- paste0("[^", if (!reserved) 
    "][!$&'()*+,;/?@#", "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz0123456789._~-", 
    "]")
  x <- strsplit(URL, "")[[1L]]
  z <- grep(OK, x)
  if (length(z)) {
    y <- sapply(x[z], function(x) paste0("%25", toupper(as.character(charToRaw(x))), 
                                         collapse = ""))
    x[z] <- y
  }
  paste(x, collapse = "")
}
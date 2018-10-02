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

.options <- function(self, private, code) {
  l <- private$map()

  s <- paste0(sapply(names(l), function(x) sprintf("%s=%s", x, l[[x]])), collapse = "&")

  code <- paste0(code, collapse = "\n")

  sprintf("%s&code=%s", s, self$encode(code))
}

#' @title URI constructor
#' @description Function that is called in a carbon object to construct valid uri to send to browser
#' @param self carbon self object
#' @param private carbon private object
#' @param code character, script to embbed into the uri
#' @examples
#' if(interactive()){
#'
#' x <- carbon$new('x <- 1')
#'
#' # populate from self$code
#' x$uri()
#'
#' # enter manually
#' x$uri(code = 'x <- y + 3')
#'
#' }
#' @rdname uri
#' @aliases carbon-uri
#' @seealso
#'  [carbon][carbonate::carbon]
.uri <- function(self, private, code) {
  sprintf("https://carbon.now.sh/?%s", self$options(code = code))
}

#' @title open $uri to in browser window
#' @description opens the uri address in [$uri][carbonate::carbon-uri] in the browser window.
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
.browse <- function(self, private) {
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

.encode <- function(self, private, URL, reserved, repeated) {
  if (!repeated && grepl("%[[:xdigit:]]{2}", URL, useBytes = TRUE)) {
    return(URL)
  }
  OK <- paste0(
    "[^", if (!reserved) {
      "][!();?"
    } , "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "abcdefghijklmnopqrstuvwxyz0123456789._~-",
    "]"
  )
  x <- strsplit(URL, "")[[1L]]
  z <- grep(OK, x)

  z <- sort(c(z, which(x %in% c("[", "]"))))

  if (length(z)) {
    y <- sapply(x[z], function(x) paste0("%25", toupper(as.character(charToRaw(x))),
        collapse = ""
      ))
    y <- gsub("%2527", "%27", y)

    x[z] <- y
  }
  paste(x, collapse = "")
}

#' @title convert carbon uri to tinyurl
#' @description convert carbon uri to tinyurl with option to attach to clipboard.
#' @param self carbon self object
#' @param private carbon private object
#' @param clip boolean, write tinyurl to clipboard, Default: FALSE
#' @details If clip is set to TRUE [write_clip][clipr::write_clip] will put the
#' tinyurl on the clipboard.
#' @return character
#' @importFrom clipr write_clip
#' @rdname tiny
#' @aliases carbon-tinyurl
.tiny <- function(self, private, clip = FALSE) {

  RET <- tinyurl(self$uri())
  
  if (clip) {
    clipr::write_clip(RET)
  }

  return(RET)
}


#' @title send tweets using carbonate outputs
#' @description wrapper for [post_tweet][rtweet::post_tweet] to send
#' tweets with media created using carbonate.
#' @param self carbon self object
#' @param private carbon private object
#' @param media magick-image object or path to image
#' @param status character, status to attach to post, Default: self$tweet_status
#' @param media_format character, type of media to tweet, Default: c('png','gif')
#' @param \dots arguments to pass to [post_tweet][rtweet::post_tweet]
#' @return outcome from rtweet
#' @details If multiple images are passed they can be either converted to a gif by
#' setting media_format to 'gif' or attached each one to the post.
#' @examples
#' \dontrun{
#' x <- carbonate::carbon$new()
#' x$carbonate(code = readLines(system.file('DESCRIPTION',package='carbonate')))
#' x$carbonate(code = 'x+2')
#'
#' # using default status value (x$tweet_status)
#' x$rtweet(system.file('figures/hex_black_small.png',package='carbonate'))
#'
#' x$rtweet(status = 'these are two pngs',media = x$carbons,media_format='png')
#' x$rtweet(status = 'this is a gif', media = x$carbons,media_format='gif')
#'
#' }
#' @seealso
#'  [image_write][magick::image_write]
#'  [post_tweet][rtweet::post_tweet]
#' @rdname rtweet
#' @aliases carbon-rtweet
#' @importFrom magick image_write
#' @importFrom rtweet post_tweet
.rtweet <- function(self,
                    private,
                    media,
                    status = self$tweet_status,
                    media_format = c("png", "gif"),
                    ...) {
  td <- file.path(tempdir(), "rtweet_media")

  mf <- match.arg(media_format)

  dir.create(td, showWarnings = FALSE)

  on.exit(unlink(td, recursive = TRUE, force = TRUE), add = TRUE)

  if (inherits(media, "magick-image")) {
    if (mf == "gif") {
      anim <- magick::image_animate(media, fps = 1)

      magick::image_write(
        image = anim,
        path = file.path(td, sprintf("img01.%s", mf)),
        format = mf
      )
    } else {
      invisible(
        lapply(seq_along(media), function(x) {
          magick::image_write(
            image = media[x],
            path = file.path(td, sprintf("img%02d.%s", x, mf)),
            format = mf
          )
        })
      )
    }

    tds <- list.files(td, full.names = TRUE)
  } else {
    tds <- media
  }

  rtweet::post_tweet(status = status, media = tds, ...)
}

#' @title convert uri to tinyurl
#' @description convert uri to tinyurl.
#' @param uri character, the uri to convert
#' @return character
#' @importFrom httr http_error content GET
#' @export
tinyurl <- function(uri){
  
  host <- 'tinyurl.com'
  
  if(!httr::http_error(host)){
    
    base <- sprintf('http://%s/api-create.php',host)
    
    uri <- httr::content(httr::GET(sprintf('%s?url=%s',base,uri)))
    
  }
  
  uri
  
}

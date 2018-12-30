# @title create rgba call for carbon
# @description combines rbga vector into a string
# @param self carbon self object
# @param private carbon private object
# @param x named character vector
# @return character
.rgba <- function(self, private, x) {
  sprintf("rgba(%s,%s,%s,%s)", x[["r"]], x[["g"]], x[["b"]], x[["a"]])
}

# @title make a unit character
# @description combines a number with a unit
# @param self carbon self object
# @param private carbon private object
# @param x numeric, value
# @param unit character, the unit
# @return character
.add_unit <- function(self, private, x, unit) {
  sprintf("%s%s", x, unit)
}

# @title map carbon R6 field to uri field
# @description map the field used in the R6 object into the uri field
#   carbon.js uses.
# @param self carbon self object
# @param private carbon private object
# @param name name of carbon R6 field
# @return character
.map_name <- function(self, private, name) {
  private$var_names[[name]]
}

# @title escape percent for carbon
# @description suffix string with %25
# @param self carbon self object
# @param private carbon private object
# @param value character, character to combine string to
.add_percent <- function(self, private, value) {
  sprintf("%s%%25", value)
}

# @title convert logical to carbon logical
# @description convert logical to lower case character
# @param self carbon self object
# @param private carbon private object
# @param value boolean, value to lower
# @return character
.convert_logical <- function(self, private, value) {
  tolower(as.character(value))
}

# @title map name to function
# @description map name of private method to constructors
# @param self carbon self object
# @param private carbon private object
# @return list
.map <- function(self, private) {
  l <- lapply(names(private$var_names), function(x) {
    val <- self[[x]]

    if (x == "template") {
      if (!self[[x]] %in% self$get_templates()) {
        stop(sprintf(
          "template not valid: %s\nUse the method get_templates() to choose a valid one",
          self[[x]]
        ))
      }

      val <- gsub("\\s", "%20", self[[x]])
    }


    if (x == "font_family") {
      val <- gsub("\\s", "%20", self[[x]])
    }

    if (x == "palette") {
      val <- gsub("[,]", "%2C", private$rgba(self[[x]]))
    }

    if (x == "line_height_percent") {
      val <- private$add_percent(self[[x]])
    }

    if (x %in% "relative_export_size") {
      val <- private$add_unit(self[[x]], unit = "x")
    }

    if (x %in% private$px_vars) {
      val <- private$add_unit(self[[x]])
    }

    if (x %in% private$logical_vars) {
      val <- private$convert_logical(self[[x]])
    }

    assign(private$var_names[[x]], value = val)
  })

  names(l) <- unlist(private$var_names)

  l
}


# https://goo.gl/jFqKfS
asyncr <- function(remDr, using, value, action = NULL, maxiter = 20) {
  elem <- NULL

  i <- 0

  while (is.null(elem) & (i <= maxiter)) {
    elem <- tryCatch({
      remDr$findElement(using = using, value = value)
    },
    error = function(e) {
      NULL
    }
    )

    Sys.sleep(0.02 * (i + 1))

    i <- i + 1
  }

  if (is.null(elem) && i >= maxiter) {
    # assuming this means timed out
    stop("attempt to fetch image from carbon servers failed, 
         please check network connectivity and try again",
      call. = FALSE
    )
  }

  elem$clickElement()
}

file.timeout <- function(path, device, maxiter = 20) {
  
  file_found <- FALSE
  
  i <- 0
  
  while (!file_found & (i <= maxiter)) {

    file_found <- file.exists(file.path(path, sprintf("carbon.%s", device)))
    
    Sys.sleep(0.02 * (i + 1))
    
    i <- i + 1
  }
  
  if (i >= maxiter) {
    # assuming this means timed out
    stop("Could not find file in download path, 
         please check network connectivity and try again",
         call. = FALSE
    )
  }
  
}

#' @importFrom yaml read_yaml as.yaml
.parse_yml <- function(self, private, yml = "~/carbon.yml", silent = FALSE) {
  if (!is.null(yml)) {
    if (file.exists(yml)) {
      y <- yaml::read_yaml(yml)

      ny <- names(y)
      idx <- which(ny %in% names(self))

      if (length(idx) > 0) {
        if ("palette" %in% ny) {
          y[["palette"]] <- check_palette_yml(x = y[["palette"]], self)
        }

        y <- check_get(y, self, silent = silent)

        ny <- names(y)
        idx <- which(ny %in% names(self))

        y <- y[idx]

        for (i in seq_along(y)) {
          self[[ny[i]]] <- y[[i]]
        }

        if (!silent) {
          cat(sprintf("Set via '%s'\n", yml), yaml::as.yaml(y), sep = "")
        }
      }
    }
  }
}

check_palette_yml <- function(x, self = self) {
  x <- unlist(x, use.names = TRUE)

  if (is.null(names(x))) {
    names(x) <- c("r", "g", "b", "a")[1:length(x)]
  }

  np <- names(x)

  x <- x[np %in% c("r", "g", "b", "a")]

  sp <- self[["palette"]]

  sp[np] <- x

  x <- sp
}

check_get <- function(y, self = self, silent = FALSE) {
  rmx <- c()

  for (x in c("template", "font_family", "windows_control_theme")) {
    if (x %in% names(y)) {
      if (!y[[x]] %in% self[[find_get(x, self)]]()) {
        y[[x]] <- NULL
        rmx <- c(rmx, x)
      }
    }
  }

  if (length(rmx) > 0) {
    if (!silent) {
      message(sprintf(
        "invalid value for the fields in the yml (ignored on load):\n%s",
        paste0(rmx, collapse = ", ")
      ))
    }
  }

  return(y)
}

find_get <- function(x, self = self) {
  names(self)[startsWith(names(self), sprintf("get_%s", gsub("_(.*?)$", "", x)))]
}

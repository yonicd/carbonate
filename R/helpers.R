# @title create rgba call for carbon
# @description combines rbga vector into a string
# @param self carbon self object
# @param private carbon private object
# @param x named character vector
# @return character
# @examples 
# x <- carbon$new()
# 
# x$rgba(x = c(r=120,g=175,b=195,a=0.4))
.rgba <- function(self,private,x){
  sprintf('rgba(%s,%s,%s,%s)',x[['r']],x[['g']],x[['b']],x[['a']])
}

# @title make a unit character
# @description combines a number with a unit
# @param self carbon self object
# @param private carbon private object
# @param x numeric, value
# @param unit character, the unit
# @return character
# @examples 
# x <- carbon$new()
# 
# x$add_unit(3,'px')
.add_unit <- function(self,private,x,unit){
  sprintf('%s%s',x,unit)
}

# @title map carbon R6 field to uri field
# @description map the field used in the R6 object into the uri field
#   carbon.js uses. 
# @param self carbon self object
# @param private carbon private object
# @param name name of carbon R6 field
# @return character
# @examples 
# x <- carbon$new()
# 
# x$map_name('palette')
.map_name <- function(self,private,name){
  private$var_names[[name]]
}

# @title escape percent for carbon
# @description suffix string with %25
# @param self carbon self object
# @param private carbon private object
# @param value character, character to combine string to
# @return OUTPUT_DESCRIPTION
# @details DETAILS
# @examples 
# \dontrun{
# if(interactive()){
#  #EXAMPLE1
#  }
# }
.add_percent <- function(self,private,value){
  sprintf('%s%%25',value)
}

# @title convert logical to carbon logical
# @description convert logical to lower case character
# @param self carbon self object
# @param private carbon private object
# @param value boolean, value to lower
# @return character
.convert_logical <- function(self,private,value){
  tolower(as.character(value))
}

# @title map name to function
# @description map name of private method to constructors
# @param self carbon self object
# @param private carbon private object
# @return list
.map <- function(self,private){
  
  l <- lapply(names(private$var_names),function(x){
    
    val <- self[[x]]
    
    if(x=='palette')
      val <- private$rgba(self[[x]])
    
    if(x=='line_height_percent')
      val <- private$add_percent(self[[x]])
    
    if(x%in%'relative_export_size')
      val <- private$add_unit(self[[x]],unit = 'x')
    
    if(x%in%private$px_vars)
      val <- private$add_unit(self[[x]])
    
    if(x%in%private$logical_vars)
      val <- private$convert_logical(self[[x]])
    
    assign(private$var_names[[x]],value = val)
    
  })
  
  names(l) <- unlist(private$var_names)  
  
  l
  
}

# https://goo.gl/jFqKfS
asyncr <- function(remDr,using,value,action = NULL,maxiter = 20){
  
  elem <- NULL
  
  i <- 0
  
  while( is.null(elem) & (i <= maxiter) ){
    
    elem <- tryCatch(
      {remDr$findElement(using = using, value = value)},
      error = function(e){NULL})

    Sys.sleep(0.02*(i+1))
    
    i <- i + 1
  }  
  
  if (is.null(elem) && i >= maxiter) {
    # assuming this means timed out
    stop("attempt to fetch image from carbon servers failed, 
         please check network connectivity and try again",
         call. = FALSE)
  }
  
  elem$clickElement()
  
}

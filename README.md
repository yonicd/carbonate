# carbonate
`R6` api for [carbon.js](https://carbon.now.sh/about)


## Installation

```r
remotes::install_github('yonicd/carbonate')
```

## Usage

### initialize new carbon object

```r
library(carbonate)
```

```r
x <- carbon$new() # default code is the clipboard

x$code <- 'x <- 1' # code can be a character object of any length
```

### open code in browser window

```r
x$browse()
```

### carbonate code directly to file

This function depends on RSelenium

```r
x$carbonate(file = 'example.png') # can be either png or svg
```

![](https://raw.githubusercontent.com/yonicd/carbonate/master/misc/example.png)


### Closing the browser

```r
x$stop()
```

### Manipulate carbon object

#### Changing the template

```r
x$get_templates()

 [1] "3024-night"            "blackboard"            "base16-dark"           "base16-light"          "cobalt"                "dracula"              
 [7] "duotone"               "hopscotch"             "material"              "monokai"               "night-owl"             "oceanic-next"         
[13] "one-dark"              "panda"                 "paraiso"               "seti"                  "solarized dark"        "solarized light"      
[19] "tomorrow-night-bright" "lucario"               "twilight"              "verminal"              "yeti"                  "zenburn"  
```

```r
x$template <- "panda"
x$carbonate(file = 'myfile.png')
```

![](https://raw.githubusercontent.com/yonicd/carbonate/master/misc/myfile.png)


### Creating gifs

All carbon outputs are collected and saved in the list `x$carbons`

printing the list will create a gif

```r
x$carbons
```

![](https://raw.githubusercontent.com/yonicd/carbonate/master/misc/preview.gif)


# carbonate
`R6` api for carbon.js


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

!()[misc/example.png]


### Closing the browser

```r
x$stop()
```

### Manipulate carbon object

#### Changing the template

```r
x$get_templates()
x$template <- "panda"
x$carbonate(file = 'myfile.png')
```

!()[misc/myfile.png]


### Creating gifs

All carbon outputs are collected and saved in the list `x$carbons`

printing the list will create a gif

```r
x$carbons
```

!()[misc/preview.gif]


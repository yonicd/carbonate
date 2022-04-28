#' @title carbon set functions
#' @description function that set the aesthetics of the carbon image output
#' @param self carbon self object
#' @param private carbon private object
#' @param template character, name of template to set [$template][carbonate::carbon-fields] to
#' @param theme character, theme to set [$theme][carbonate::carbon-fields] to
#' @param family character, font family to set [$font_family][carbonate::carbon-fields] to
#' @rdname set_carbon
#' @aliases carbon-set-fields
#' @seealso
#'  [carbon][carbonate::carbon]
.set_template <- function(self, private, template) {
  self$template <- template
}

#' @rdname set_carbon
.set_window_control_theme <- function(self, private, theme) {
  self$window_control_theme <- theme
}

#' @rdname set_carbon
.set_font_family <- function(self, private, family) {
  self$font_family <- family
}

#' @title carbon get functions
#' @description function that gets the available list of aesthetic values of fields
#' @param self carbon self object
#' @param private carbon private object
#' @rdname get_carbon
#' @aliases carbon-get-fields
#' @seealso
#'  [carbon][carbonate::carbon]
.get_windows_control_themes <- function(self, private) {
  c("none", "sharp", "bw")
}

#' @rdname get_carbon
.get_font_families <- function(self, private) {
  # c("Anonymous Pro", "Droid Sans Mono", "Fantasque Sans Mono", 
  #   "Fira Code", "Hack", "IBM Plex Mono", "Inconsolata", "Iosevka", 
  #   "JetBrains Mono", "Monoid", "Source Code Pro", "Space Mono", 
  #   "Ubuntu Mono")
  sapply(query_defaults('FONTS'),'[[',2)
}

#' @rdname get_carbon
.get_templates <- function(self, private) {
  # c("3024-night", "a11y-dark", "blackboard", "base16-dark", "base16-light", 
  #   "cobalt", "dracula", "duotone-dark", "hopscotch", "lucario", 
  #   "material", "monokai", "night-owl", "nord", "oceanic-next", "one-light", 
  #   "one-dark", "panda-syntax", "paraiso-dark", "seti", "shades-of-purple", 
  #   "solarized dark", "solarized light", "synthwave-84", "twilight", 
  #   "verminal", "vscode", "yeti", "zenburn")
  sapply(query_defaults('THEMES'),'[[',1)
}

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
  c(
    "Anonymous Pro", "Droid Sans Mono", "Fantasque Sans Mono", "Fira Code", "Monoid",
    "Hack", "IBM Plex Mono", "Iosevka", "Inconsolata", "Source Code Pro", "Ubuntu Mono"
  )
}

#' @rdname get_carbon
.get_templates <- function(self, private) {
  c(
    "3024-night", "blackboard", "base16-dark", "base16-light", "cobalt", "dracula",
    "duotone", "hopscotch", "material", "monokai", "night-owl", "oceanic-next",
    "one-dark", "panda-syntax", "paraiso", "seti", "solarized dark", "solarized light",
    "tomorrow-night-bright", "lucario", "twilight", "verminal", "yeti", "zenburn"
  )
}

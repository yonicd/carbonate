#' @title Carbon object fields
#' @description Fields that can be changed in the Carbon object
#' @param code character, script to embbed, Default: NULL
#' @param palette character, layout pallete, Default: c(r=171,g=184,b=195,a=1)
#' @param template character, layout template, Default: 'seti'
#' @param add_window_control boolean, add/remove window controls (circles on top left corner),
#'  Default: TRUE
#' @param window_control_theme character, change window control themes, Default: 'none'
#' @param language character, language, Default: 'r'
#' @param add_drop_shadow boolean, add/remove dropshadow, Default: TRUE
#' @param drop_shadow_offset_y numeric, shadow vertical offset (px), Default: 20
#' @param drop_shadow_blur_radius numeric, shadow blur radius (px), Default: 68
#' @param auto_adjust_width boolean, auto-audjust output width, Default: TRUE
#' @param padding_vertical numeric, vertical padding (px), Default: 48
#' @param padding_horizontal numeric, horizontal padding (px), Default: 32
#' @param add_line_number boolean, add/remove line numbers, Default: FALSE
#' @param font_family character, layout font family, Default: 'Hack'
#' @param font_size numeric, font size (px), Default: 14
#' @param line_height_percent numeric, relative space between lines (percent), Default: 133
#' @param square_image boolean, output image is square, Default: FALSE
#' @param relative_export_size numeric, image size in export relative to what is in
#'  the preview (1,2 or 4), Default: 1
#' @param add_watermark boolean, add official carbon.js watermark, Default: FALSE
#' @param carbons list, storage of rendered carbon images, Default: NULL
#' @param chrome_args character, arguments passed to chrome browser, Default:
#'   c('--disable-gpu', '--window-size=1280,800')
#' @param chrom_pref list, preferences passed to chrome browser, Default: 
#'   list("profile.default_content_settings.popups" = 0L,"download.prompt_for_download" = FALSE,"download.default_directory" = tempdir())
#' @param rD RSelenium Driver object
#' @param cDrv Chrome Driver object from wdman
#' @rdname carbon_fields
.carbon_fields <- function(
  code,
  palette,
  template,
  window_control_theme,
  language,
  add_drop_shadow,
  drop_shadow_offset_y,
  drop_shadow_blur_radius,
  add_window_control,
  auto_adjust_width,
  padding_vertical,
  padding_horizontal,
  add_line_number,
  font_family,
  font_size,
  line_height_percent,
  square_image,
  relative_export_size,
  add_watermark,
  carbons,
  chrome_args,
  chrom_pref,
  rD,
  cDrv
){
  NULL
}
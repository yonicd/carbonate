#' @title Carbon object fields
#' @description Fields that can be changed in the [Carbon][carbonate::carbon] object
#' @usage NULL
#' @param code character, script to embbed, Default: NULL
#' @param palette numeric, layout pallete, Default: c(r=171,g=184,b=195,a=1)
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
#' @param add_tinyurl boolean, add tinyurl link to image directing to the carbon page that
#' created the image, Default: FALSE
#' @param tinyurl_location character, string with [gravity][magick::options] value to place the annotate tinyurl
#' address on image, Default: 'southeast'
#' @param tweet boolean, tweet out the image using [post_tweet][rtweet::post_tweet]
#' @param tweet_status character, status to add to the tweet. If add_tinyurl is TRUE then
#' a link to the url will be appended to the status automatically,
#' Default: 'Created in R using the Carbonate (Package Icon)'
#' @param add_timestamp boolean, add timestamp to output filename, Default: FALSE
#' @param carbons list, storage of rendered carbon images, Default: NULL
#' @param download_path character, path to download the images, Default: tempdir()
#' @param chrome_args character, arguments passed to chrome browser, Default:
#'   c('--disable-gpu', '--window-size=1280,800')
#' @param chrome_pref list, preferences passed to chrome browser, Default:
#'   list("profile.default_content_settings.popups" = 0L,"download.prompt_for_download" = FALSE,"download.default_directory" = tempdir())
#' @param rD RSelenium Driver object
#' @param cDrv Chrome Driver object from wdman
#' @name carbon_fields
#' @rdname carbon_fields
#' @aliases carbon-fields
#' @seealso
#'  [carbon][carbonate::carbon]
NULL

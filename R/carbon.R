#' @export
carbon <- R6::R6Class(classname = 'Carbon',
                      public = list(
                        initialize = function(code = clipr::read_clip()){
                          self$code = code
                        },
                        code                         = NULL,
                        palette                         = c(r=171,g=184,b=195,a=1),
                        template                     = 'seti',
                        window_control_theme         = 'none',
                        language                     = 'r', 
                        add_drop_shadow              = TRUE, 
                        drop_shadow_offset_y         = 20, 
                        drop_shadow_blur_radius      = 68, 
                        add_window_control           = TRUE, 
                        auto_adjust_width            = TRUE, 
                        padding_vertical             = 48,
                        padding_horizontal           = 32,
                        add_line_number              = FALSE, 
                        font_family                  = 'Hack',
                        font_size                    = 14, 
                        line_height_percent          = 133,
                        square_image                 = FALSE, 
                        relative_export_size         = 1,
                        add_watermark                = FALSE,
                        set_template                 = function(template = self$get_templates()[16]){
                          self$template <- template
                        },
                        set_window_control_theme     = function(theme = self$get_windows_control_themes()[1]){
                          self$window_control_theme <- theme
                        },
                        set_font_family              = function(family = self$get_font_families()[6]){
                          self$font_family <- family
                        },
                        get_windows_control_themes   = function(){
                          c('none','sharp','bw')
                          },
                        get_font_families            = function(){
                          c('Anonymous Pro', 'Droid Sans Mono', 'Fantasque Sans Mono', 'Fira Code', 'Monoid',
                            'Hack', 'IBM Plex Mono', 'Iosevka', 'Inconsolata', 'Source Code Pro', 'Ubuntu Mono')
                        },
                        get_templates                = function(){
                          c('3024-night','blackboard','base16-dark','base16-light','cobalt','dracula',
                            'duotone','hopscotch','material','monokai','night-owl','oceanic-next',
                            'one-dark','panda','paraiso','seti','solarized dark','solarized light',
                            'tomorrow-night-bright','lucario','twilight','verminal','yeti','zenburn')
                        },
                        carbons = list(),
                        options               = function(code = self$code){
                          
                          l <-private$map()
                          
                          s <- paste0(sapply(names(l),function(x) sprintf('%s=%s',x,l[[x]])),collapse = '&')
                          
                          code <- paste0(code,collapse = '\n')
                          
                          sprintf('%s&code=%s',s,self$encode(code))
                        },
                        uri                   = function(code = self$code){
                          sprintf('https://carbon.now.sh?%s',self$options(code = code))
                        },
                        browse = function(){browseURL(self$uri())},
                        chrome_args                  = c('--disable-gpu', '--window-size=1280,800'),
                        chrom_pref                   = list(
                          "profile.default_content_settings.popups" = 0L,
                          "download.prompt_for_download" = FALSE,
                          "download.default_directory" = tempdir()
                          ),
                        chromeOptions = function(){list(args = self$chrome_args,prefs = self$chrom_pref)},
                        rD = NULL,
                        cDrv = NULL,
                        chrome_start = function(){
                          self$cDrv <- wdman::chrome()
                        },
                        chrome_stop = function(){
                          self$cDrv$stop()
                        },
                        start = function(eCap = self$chromeOptions()) {

                          if(is.null(self$cDrv)){
                            self$chrome_start()  
                          }
                          
                          
                          self$rD <- RSelenium::rsDriver(browser = "chrome",
                                                         verbose = FALSE, 
                                                         port = 4567L,
                                                         extraCapabilities = list(
                                                           chromeOptions = eCap)
                                                         )
                          },
                        stop = function(){
                          self$rD$client$close()
                          self$chrome_stop()
                          },
                        stop_all = function(){
                          self$rD$client$closeall()
                          self$chrome_stop()
                          },
                        carbonate = function(file = 'carbon.png',code = self$code,rD = self$rD,...){
                          
                          if(is.null(rD)){
                            message('starting headless browser...')
                            self$start()
                          }else{
                            invisible(rD$client$open())
                          }
                            
                          
                          remDr <- rD$client
                          
                          path <- rD$client$extraCapabilities$chromeOptions$prefs$download.default_directory  
                          
                          device <- gsub('^(.*?)\\.','',file)
                          
                          remDr$navigate(self$uri(code = code))
                          
                          Sys.sleep(2)
                          
                          webElem <- remDr$findElement(using = 'xpath',value = '//*[@id="toolbar"]/div[5]/div')
                          
                          webElem$clickElement()
                          
                          Sys.sleep(2)
                          
                          webSubElem <- remDr$findElement(using = 'xpath',value = sprintf('//*[@id="downshift-2-item-%s"]',as.numeric(device=='svg')))
                          
                          webSubElem$clickElement()
                          
                          Sys.sleep(3)
                          
                          file.rename(file.path(path,sprintf('carbon.%s',device)),file.path(path,sprintf('rcarbon.%s',device)))
                          
                          file.rename(file.path(path,sprintf('rcarbon.%s',device)),file.path(path,file))
                          
                          img <- magick::image_read(file.path(path,file))
                          
                          self$carbons <- append(self$carbons,img)
                          
                          print(img, info = FALSE)
                          
                        },
                        encode = function(URL, reserved = FALSE, repeated = FALSE){
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
                      ),
                      private = list(
                        rgba            = function(x){
                          sprintf('rgba(%s,%s,%s,%s)',x[['r']],x[['g']],x[['b']],x[['a']])
                        },
                        add_unit        = function(x,unit = 'px'){
                          sprintf('%s%s',x,unit)
                        },
                        map_name        = function(name){
                          private$var_names[[name]]
                        },
                        add_percent     = function(value){
                          sprintf('%s%%25',value)
                        },
                        convert_logical = function(value){
                          tolower(as.character(value))
                        },
                        map = function(){
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
                          
                        },
                        px_vars         = c('drop_shadow_offset_y',
                                            'drop_shadow_blur_radius',
                                            'padding_vertical',
                                            'padding_horizontal',
                                            'font_size'),
                        logical_vars    = c('add_drop_shadow',
                                            'add_window_control',
                                            'auto_adjust_width',
                                            'add_line_number',
                                            'square_image',
                                            'add_watermark'),
                      var_names = c( 
                        palette = 'bg',
                        template = 't',
                        window_control_theme = 'wt',
                        language  = 'l',
                        add_drop_shadow = 'ds',
                        drop_shadow_offset_y = 'dsyoff',
                        drop_shadow_blur_radius  = 'dsblur',
                        add_window_control = 'wc',
                        auto_adjust_width = 'wa',
                        padding_vertical = 'pv',
                        padding_horizontal = 'ph',
                        add_line_number = 'ln',
                        font_family = 'fm',
                        font_size = 'fs',
                        line_height_percent = 'lh',
                        square_image = 'si',
                        relative_export_size = 'es',
                        add_watermark = 'wm'
                      )
        )
        )
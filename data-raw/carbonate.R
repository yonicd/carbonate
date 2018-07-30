
library(RSelenium)






eCaps <- list(
  chromeOptions = list(
    args = c('--headless', '--disable-gpu', '--window-size=1280,800'),
    prefs = list(
      "profile.default_content_settings.popups" = 0L,
      "download.prompt_for_download" = FALSE,
      "download.default_directory" = getwd()
    )
  )
)  

cDrv <- wdman::chrome(check = TRUE,params = list(behavior = 'allow'))

rD <- RSelenium::rsDriver(extraCapabilities = eCaps)

rD$client$closeall()

carbonate(file = 'myfile2.png',rD = rD)

slickR::slickR(obj = c('myfile.png'),width = '75%')

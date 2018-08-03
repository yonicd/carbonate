imgurl <- 'https://www.mouthhealthy.org/~/media/MouthHealthy/Images/Articles/article_sparkling_water.jpg?h=307&la=en&w=460&hash=C5B22EB96AB5D4C5BFBDF360A745D108E2AF053F'

hexSticker::sticker(imgurl, package="carbonate", p_size=8, s_x=1, s_y=.75, s_width=.6,
                    p_color = "grey",
                    h_color = "grey",
                    h_fill = '#FFFFFF',filename="misc/hex.png")

library(magick)

magick::image_read(imgurl)%>%image_negate()%>%image_oilpaint()%>%
  magick::image_write('misc/carbonate_black.png')

hexSticker::sticker('misc/carbonate_black.png', package="carbonate", p_size=8, s_x=1, s_y=.75, s_width=.6,
                    p_color = "white",
                    h_color = "white",
                    h_fill = 'black',filename="misc/hex_black.png")

magick::image_read('misc/hex_black.png')%>%magick::image_scale('150')%>%magick::image_write('inst/figures/hex_black_small.png')
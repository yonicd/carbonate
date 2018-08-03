library(progress)

f <- function (r = 1, ...) 
{
  user <- par("usr")
  pin <- par("pin")
  sy <- user[4] - user[3]
  sx <- user[2] - user[1]
  ry <- r * sy/sx * pin[1]/pin[2]
  
  shape::getellipse(r, ry, c(0, 0), angle = 0, dr = 0.01, from = -pi, to = pi)
}

x <- f()

library(magrittr)

p <- as.data.frame(x)%>%
  dplyr::mutate(id = 1:n())%>%
  dplyr::group_by(id)%>%
  dplyr::mutate(n = norm(as.matrix(c(V1,V2)),type = 'F'))%>%
  dplyr::ungroup()%>%
  ggplot2::ggplot(ggplot2::aes(x=V1,y=V2,colour = n)) + ggplot2::geom_point() +
  viridis::scale_color_viridis(option = 'A')

p1 <- ggplot2::ggplot_build(p)

colors <- p1$data[[1]]$colour


imgurl <- 'https://www.mouthhealthy.org/~/media/MouthHealthy/Images/Articles/article_sparkling_water.jpg?h=307&la=en&w=460&hash=C5B22EB96AB5D4C5BFBDF360A745D108E2AF053F'

hex_f <- function(id,hex,imgurl){
  pb$tick()
  hexSticker::sticker(imgurl,
                      package="carbonate",
                      p_size=8, s_x=1, s_y=.75, s_width=.6,
                      p_color = hex,
                      h_color = hex,
                      h_fill = '#FFFFFF',
                      filename=sprintf("misc/hex/hex_%03d.png",id))
}

pb <- progress_bar$new(total = length(colors))

purrr::walk2(as.list(seq_along(colors)),
             as.list(colors),
             .f=hex_f,imgurl = imgurl)

x <- list.files('misc/hex',full.names = TRUE)

idx <- c(1:200,sort(sample(200:550,200,replace = FALSE)),550:630)

imgs <- magick::image_read(x[idx])%>%magick::image_scale('150')

magick::image_animate(imgs,fps = 5, dispose = "previous")

junk <- sapply(list.files(tempdir(),pattern = 'jpeg$',full.names = TRUE),unlink,force = TRUE)

file.copy(file.path(tempdir(),'preview.gif'),'tools/temp/hex.gif',overwrite = TRUE)


library(magick)

magick::image_read(imgurl)%>%image_negate()%>%image_oilpaint()%>%
  magick::image_write('misc/carbonate_black.png')

hexSticker::sticker('misc/carbonate_black.png', package="carbonate", p_size=8, s_x=1, s_y=.75, s_width=.6,
                    p_color = "white",
                    h_color = "white",
                    h_fill = 'black',filename="misc/hex_black.png")


slickR::slickR(
  obj = x[idx],
slickOpts = list(
  initialSlide = 0,
  slidesToShow = 10,
  slidesToScroll = 10,
  focusOnSelect = TRUE,
  dots = FALSE
),
height=100,width='100%')
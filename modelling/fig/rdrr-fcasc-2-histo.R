
library(dplyr)
library(ggplot2)
library(terra)


rdf <- rast("E:/Sync/@owrc/layers/DEM-OWRC23/PDEM-newcorrections/PDEM-South-D2013-OWRC23-60-HC-gradient.asc") %>%
  as.data.frame() %>%
  rename(grad = 'PDEM-South-D2013-OWRC23-60-HC-gradient')

ggplot(rdf %>% filter(grad > 0), aes(sqrt(grad))) + geom_histogram()

       
       
nrow(rdf) - nrow(rdf %>% filter(grad > 0))
nrow(rdf %>% filter(grad > 0))
min((rdf %>% filter(grad > 0))$grad)

mult = 1.25e6
a = 0.2
s = pi/2.5

ggplot() +
  # theme_bw() +
  geom_histogram(data=rdf %>% filter(grad > 0), aes(sqrt(grad)),binwidth=.025) +
  geom_curve(aes(x=.27,xend=.24,y=0,yend=.125*mult), linewidth=1) +
  geom_segment(aes(x=a,xend=a,y=0,yend=.2*mult), linewidth=1, linetype='dotted') +
  geom_segment(aes(x=0,xend=a,y=0,yend=0), linewidth=2) +
  geom_segment(aes(x=a,xend=a+1/tan(s),y=0,yend=mult), linewidth=2) +
  geom_segment(aes(x=a+1/tan(s),xend=1,y=,mult,yend=mult), linewidth=2) +
  geom_point(data=data.frame(x=c(0,a,a+1/tan(s)),y=c(0,0,mult)),aes(x,y),size=3) +
  annotate("text", label = expression(f["casc-min"]), x = .2, y = .25*mult,size=6) +
  annotate("text", label = expression(theta), x = .285, y = .125*mult,size=6) +
  coord_cartesian(x=c(NA,0.7),y=c(0,mult)) +
  # xlim(c(0,.8)) +
  labs(title='Distribution of land surface slope',
       subtitle='n = 11,313,815 (excluding flat cells)',
       x=expression("land surface slope ("*sqrt(S[0])*")"),
       y=NULL)


ggsave('modelling/fig/rdrr-fcasc-2-histo.png', width=8, height=4)

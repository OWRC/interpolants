
library(dplyr)
library(ggplot2)
library(viridis)
library(gganimate)
library(transformr)




topmodel.func0 <- function(drel,dmean,m) {
  def <- m*drel+dmean
  # L <- 1
  # k <- def/m
  return(exp(-def/m))
  # return(1/(1+exp(def/m)))
  # return(1-def/m)
  # return((1-def/m)^3)
  # return(L/(1+exp(-k*dmean))) # logistic function
}



# simple
m <- 1
drel <- 0
dmeanArr = seq(-10,10,length=101)
drelArr = seq(-10,10,length=11) # ORMGP range


# data.frame(dmean=seq(-10,10,length=101)) %>%
#   mutate(f_value=topmodel.func0(0,dmean,m)) %>%
#   ggplot(aes(dmean,f_value)) + 
#   geom_line() + 
#   geom_point(aes(x=0,y=topmodel.func0(drel,0,m))) +
#   geom_label(aes(x=0,y=topmodel.func0(drel,0,m), label=topmodel.func0(drel,0,m))) +
#   scale_y_log10()



expand.grid(dmean = dmeanArr, drel = drelArr) %>%
  mutate(f_value=topmodel.func0(drel,dmean,m)) %>%
  ggplot(aes(dmean,f_value)) + 
  geom_line(aes(group=drel, color=drel),size=1) + 
  geom_point(aes(x=0,y=topmodel.func0(drel,0,m))) +
  geom_label(aes(x=0,y=topmodel.func0(drel,0,m), label=paste0(drel, ": ",round(topmodel.func0(drel,0,m),2)))) +
  scale_color_distiller(palette = "Spectral") +
  scale_y_log10()





# original form
mArr = 10^seq(-1,log10(500),length=11)
grd <- expand.grid(dmean = dmeanArr, drel = drelArr, m = mArr) # https://stackoverflow.com/questions/37513994/two-dimensional-apply-in-r

grd$f_value <- mapply(topmodel.func0, grd$drel, grd$dmean, grd$m)


ggplot(grd, aes(dmean,f_value)) +
  geom_line(aes(group=drel, color=drel), size=1, na.rm = TRUE) +
  scale_color_viridis() + 
  labs(title='m = {closest_state}') + #, subtitle = 'Frame {frame} of {nframes}') +
  transition_states(m) +
  scale_y_log10()











ggplot(grd %>% mutate(drelm=drel*m), aes(dmean,drelm)) + 
  # geom_point(aes(color=log10(f_value))) +
  geom_raster(aes(fill=log10(f_value))) +
  # scale_fill_viridis() +
  scale_fill_distiller(palette = "Spectral") +
  labs(title='m = {closest_state}') + #, subtitle = 'Frame {frame} of {nframes}') +
  transition_states(m)






















# 3-par
topmodel.func1 <- function(dinc,d,m) {
  return(exp((dinc-d)/m))
}




dArr = seq(-1,1,length=100)
DincArr = seq(-1,1,length=100)
mArr = 10^seq(-1,1,length=101)
grd <- expand.grid(dmean = dArr, Dinc = DincArr, m = mArr) # https://stackoverflow.com/questions/37513994/two-dimensional-apply-in-r


grd$f_value <- mapply(topmodel.func1, grd$Dinc, grd$dmean, grd$m)



grd %>% filter(m==1) %>%
  ggplot(aes(Dinc,dmean)) +
  geom_raster(aes(fill=f_value), na.rm = TRUE) +
  scale_fill_viridis() +
  scale_y_log10()






grd %>% filter(m==1) %>%
  ggplot(aes(Dinc,f_value)) + 
  geom_line(aes(group=as.factor(dmean),color=dmean)) +
  scale_color_viridis()





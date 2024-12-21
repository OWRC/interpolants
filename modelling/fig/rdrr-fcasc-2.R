
library(dplyr)
library(ggplot2)

a = 0.2
s = pi/2.5


ggplot() +
  geom_curve(aes(x=.27,xend=.24,y=0,yend=.125), linewidth=1) +
  geom_segment(aes(x=a,xend=a,y=0,yend=.2), linewidth=1, linetype='dotted') +
  geom_segment(aes(x=0,xend=a,y=0,yend=0), linewidth=2) +
  geom_segment(aes(x=a,xend=a+1/tan(s),y=0,yend=1), linewidth=2) +
  geom_segment(aes(x=a+1/tan(s),xend=1,y=,1,yend=1), linewidth=2) +
  geom_point(data=data.frame(x=c(0,a,a+1/tan(s)),y=c(0,0,1)),aes(x,y),size=3) +
  annotate("text", label = expression(f["casc-min"]), x = .2, y = .25,size=6) +
  annotate("text", label = expression(theta), x = .285, y = .125,size=6) +
  coord_cartesian(x=c(NA,0.7),y=c(0,1)) +
  labs(title="Cascade factor as a function of slope", 
       linetype="alpha",
       # x=expression("land surface gradient ("*beta*")"), 
       x=expression("land surface slope ("*sqrt(S[0])*")"),
       y=expression(f["casc"]))

ggsave('modelling/fig/rdrr-fcasc-2.png', width=8, height=4)

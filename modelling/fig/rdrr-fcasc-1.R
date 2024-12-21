

library(ggplot2)



fun.0 <- function(x) 1-exp(-x*x/.0001)
fun.1 <- function(x) 1-exp(-x*x/.001)
fun.2 <- function(x) 1-exp(-x*x/.01)
fun.3 <- function(x) 1-exp(-x*x/.1)
fun.4 <- function(x) 1-exp(-x*x/1.)

ggplot(data.frame(x = 0),aes(x=x)) + # dummy dataframe
  theme(legend.position = c(0.87, 0.22),
        legend.key.width = unit(1,"in")) +
  stat_function(aes(linetype='0.0001'), fun = fun.0, linewidth=1.5) +
  stat_function(aes(linetype='0.001'), fun = fun.1, linewidth=1.5) +
  stat_function(aes(linetype='0.01'), fun = fun.2, linewidth=1.5) +
  stat_function(aes(linetype='0.1'), fun = fun.3, linewidth=1.5) +
  stat_function(aes(linetype='1.0'), fun = fun.4, linewidth=1.5) +
  xlim(c(0,.8)) + 
  labs(title="Cascade factor as a function of slope", 
       linetype="alpha",
       # x=expression("land surface gradient ("*beta*")"), 
       x=expression("land surface slope ("*S[0]*")"),
       y=expression(f["casc"]))

ggsave('modelling/fig/rdrr-fcasc-1.png', width=8, height=4)

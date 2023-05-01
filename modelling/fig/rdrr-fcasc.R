

library(ggplot2)



fun.0 <- function(x) 1-exp(-x*x/.0001)
fun.1 <- function(x) 1-exp(-x*x/.001)
fun.2 <- function(x) 1-exp(-x*x/.01)
fun.3 <- function(x) 1-exp(-x*x/.1)

ggplot(data.frame(x = 0),aes(x=x)) + # dummy dataframe
  stat_function(aes(linetype='0.0001'), fun = fun.0, linewidth=1.5) +
  stat_function(aes(linetype='0.001'), fun = fun.1, linewidth=1.5) +
  stat_function(aes(linetype='0.01'), fun = fun.2, linewidth=1.5) +
  stat_function(aes(linetype='0.1'), fun = fun.3, linewidth=1.5) +
  xlim(c(0,.3)) + 
  labs(title="Cascade factor ", 
       x=expression("land surface gradient ("~beta~")"), 
       y=expression(f["casc"]))


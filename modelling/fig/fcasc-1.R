
library(ggplot2)

a = 5
fun.1 <- function(x) 1-exp(-a*x^2/0.25^2)
fun.2 <- function(x) 1-exp(-a*x^2/0.5^2)
fun.3 <- function(x) 1-exp(-a*x^2/0.75^2)
fun.4 <- function(x) 1-exp(-a*x^2)
fun.5 <- function(x) 1-exp(-a*x^2/1.5^2)

ggplot(data.frame(x = 0),aes(x=x)) + # dummy dataframe
  stat_function(fun = fun.1) + 
  stat_function(fun = fun.2) + 
  stat_function(fun = fun.3) + 
  stat_function(fun = fun.4) + 
  stat_function(fun = fun.5) +
  annotate("text", label = "r=.25", x = .07, y = .75) +
  annotate("text", label = "r=.5", x = .2, y = .72) +
  annotate("text", label = "r=.75", x = .3, y = .69) +
  annotate("text", label = "r=1", x = .415, y = .66) +
  annotate("text", label = "r=1.5", x = .555, y = .57) +
  xlim(0,1) + labs(title="Proportion of mobile water leaving cell (a=5)", x="gradient",y=expression(f["casc"]))

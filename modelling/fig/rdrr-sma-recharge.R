
library(ggplot2)
library(scales)

l = 0.001
dt = 86400/4


fun <- function(x) 1-exp(-x*dt/l)
fun.d10 <- function(x) 1-exp(-x*dt/l/10)
fun.t10 <- function(x) 1-exp(-x*dt/l*10)
fun.k <- function(x) x*dt/l

ggplot(data.frame(x = 0),aes(x=x)) + # dummy dataframe
  stat_function(fun = fun.d10, linewidth=1, linetype='dotted') +
  stat_function(fun = fun.t10, linewidth=1, linetype='dotted') +
  stat_function(fun = fun, linewidth=2) +
  stat_function(fun = fun.k, linewidth=1.5, color='red', linetype='dotted') +
  scale_x_log10(limits = c(1e-10,1e-5), labels = label_log(), breaks = breaks_log(6)) + 
  # ylim(0,1) +
  coord_cartesian(ylim = c(0,1)) +
  annotate("text", x = .4e-7, y = 0.3, parse = TRUE,
           label = "1 - e ^ {-K[sat]*Delta*t / L}") +
  annotate("text", x = 1.2e-8, y = 0.55, parse = TRUE,
           label = "K[sat]*Delta*t / L", color='red') +
  annotate("text", x = 3e-9, y = 0.75, label = "L = 0.1mm") +
  annotate("text", x = 1.5e-6, y = 0.75, label = "L = 10mm") +  
  labs(title="Proportion of mobile storage recharging the groundwater system", x="hydraulic conductivity (m/s)",y=expression(f["inf"]))



library(ggplot2)

l = 0.001
dt = 86400/4


fun <- function(x) 1-exp(-x*dt/l)


ggplot(data.frame(x = 0),aes(x=x)) + # dummy dataframe
  stat_function(fun = fun, linewidth=2) +
  scale_x_log10(limits = c(1e-10,1e-5), labels = label_log(), breaks = breaks_log(6)) + 
  labs(title="Proportion of mobile storage recharging the groundwater system", x="hydraulic conductivity (m/s)",y=expression(f["inf"]))


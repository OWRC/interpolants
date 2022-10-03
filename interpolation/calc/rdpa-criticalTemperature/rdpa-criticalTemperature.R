

library(ggplot2)
library(dplyr)


df <- read.csv("interpolation/calc/rdpa-criticalTemperature/dat/tcrit-summary.csv")


df %>% ggplot() + geom_density(aes(tc, colour=as.factor(wy)))


df %>% ggplot() + geom_histogram(aes(tc, fill=as.factor(wy)))



df %>% ggplot() + geom_histogram(aes(diff)) + xlim(c(NA,25))
                                                     


df %>% ggplot() + geom_line(aes(wy,tc,group=sid,colour=sid))


df %>% ggplot() + geom_point(aes(wy,tc,group=sid,colour=sid), alpha=.1)


df %>% ggplot() + geom_violin(aes(wy,tc, group=wy))

df %>% ggplot(aes(wy,tc)) + geom_boxplot(aes(group=wy)) + stat_smooth(col = "red") + geom_hline(yintercept = mean(df$tc))


df %>% ggplot(aes(wy,tc)) + geom_violin(aes(group=wy)) + stat_smooth(col = "red") + geom_hline(yintercept = mean(df$tc))

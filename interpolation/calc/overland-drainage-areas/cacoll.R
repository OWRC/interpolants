
library(ggplot2)
library(dplyr)
library(scales)
# library(egg)


# df <- read.csv('E:/Sync/@dev/pages_owrc/interpolants/interpolation/calc/overland-drainage-areas/cacoll.csv')
df <- read.csv("E:/Sync/@owrc/pages/interpolants/interpolation/calc/overland-drainage-areas/cacoll.csv")


df %>% mutate(diff=(computedDA-SW_DRAINAGE_AREA_KM2)/SW_DRAINAGE_AREA_KM2) %>% ggplot(aes(diff)) + geom_histogram()



g500 <- df %>% 
  mutate(diff=(computedDA-SW_DRAINAGE_AREA_KM2)/SW_DRAINAGE_AREA_KM2) %>% # mutate(diff=diff^2) %>%
  ggplot(aes(SW_DRAINAGE_AREA_KM2, computedDA)) +
  theme_classic() +
    geom_abline(linetype='dashed',linewidth=0.5) +
    geom_point(aes(color=diff),size=1) +
    coord_fixed(xlim = c(0,500),ylim = c(0,500)) +
    labs(x=NULL,y=NULL) +
    guides(color="none")

g3000 <- df %>% 
  mutate(diff=(computedDA-SW_DRAINAGE_AREA_KM2)/SW_DRAINAGE_AREA_KM2) %>% # mutate(diff=diff^2) %>%
  ggplot(aes(SW_DRAINAGE_AREA_KM2, computedDA)) +
  theme_classic() +
  geom_abline(linetype='dashed',linewidth=0.5) +
  geom_rect(aes(xmin = 0, xmax = 500, ymin = 0, ymax = 500), fill=NA, color='black',linewidth=1, linetype = 'dotted') +
  geom_point(aes(color=diff),size=2) +
  coord_fixed(xlim = c(0,3000),ylim = c(0,3000)) +
  labs(x='reported drainage area (km²)',y="drainage area computed using terrain analysis (km²)") +
  guides(color="none")


g3000 + 
  annotation_custom(
    ggplotGrob(g500), 
    xmin = 1500, xmax = 3000, ymin = 0, ymax = 3000-1500
  )

ggsave('E:/Sync/@owrc/pages/interpolants/interpolation/fig/PDEM-South-D2013-OWRC25-60-HC-02-scatter.png',width=5,height=5)



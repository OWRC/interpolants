
library(dplyr)
library(ggplot2)
library(terra)


rdf <- rast("E:/Sync/@gis/watertable/20211013_final_use_this/DP_WL_DEPTH_Final_20210824.asc") %>%
  as.data.frame() %>%
  rename(dtwt = 'DP_WL_DEPTH_Final_20210824@WATER_LEVELS')

nrow(rdf) - nrow(rdf %>% filter(dtwt > 0.5))
nrow(rdf %>% filter(dtwt > 0.5))

ggplot(rdf %>% filter(dtwt > 0.5), aes(dtwt)) +
  # theme_bw() +
  geom_histogram() +
  annotate("text",
           x = 55,
           y = 500000,
           label = "n = 3,599,862 (depth>0.5m)\nnumber near and above land surface = 961,704",
           hjust = 0) +
  xlim(c(0,150)) +
  labs(x='Depth to watertable (m)',y=NULL)


ggsave('modelling/fig/wt-depth-histo.png', width=8, height=3.5)

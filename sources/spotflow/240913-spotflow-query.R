
library(dplyr)
library(lubridate)
library(stringr)
library(ggplot2)


df <- read.csv('240913-spotflow-query.csv') %>%
  mutate(year=year(RD_DATE)) %>% 
  mutate_all(str_replace_all, " - Spot Flow Survey", "") %>%
  mutate_all(str_replace_all, "NULL", "other") %>%
  mutate_all(str_replace_all, "LowerTrentRCA", "LTC") %>%
  mutate_all(str_replace_all, "GanRCA", "GRCA") %>%
  mutate_all(str_replace_all, "KRCA", "KC") %>%
  mutate_all(str_replace_all, "KCA", "KC") %>%
  mutate_all(str_replace_all, "GSC \\(Hinton\\)", "GSC") %>%
  mutate_all(str_replace_all, "CVC \\(From Halton DB\\)", "CVC") %>%
  mutate_all(str_replace_all, "TRCA \\(at GSC Sites\\)", "TRCA") %>%
  mutate_all(str_replace_all, "TRCA - SW Gauge Station", "TRCA") %>%
  mutate_all(str_replace_all, " - Georgetown - SW Monitoring \\(Spotflow\\)", "") %>%
  mutate_all(str_replace_all, "Consultant \\(CRA\\)", "Consultant") %>%
  mutate_all(str_replace_all, "Milton 2016 Subwatershed Study - Matrix -Spot Flow", "Consultant") %>%
  mutate_all(str_replace_all, "NVCA- Spot Flow Survey                            ", 'NVCA') %>%
  mutate_all(str_replace_all, "Peel - Alton - Staff Gauge Monitoring", "Peel") %>%
  mutate_all(str_replace_all, "FWIS Locations \\(from UofW - CoMap\\)", "other") %>%
  mutate_all(str_replace_all, "YPDT - CAMC \\(CRA - 2002\\)", 'ORMGP')
  
  # mutate_all(str_replace_all, "NULL", "other") %>%
  # mutate_all(str_replace_all, "NULL", "other") %>%
  # mutate_all(str_replace_all, "NULL", "other") %>%

print(sort(unique(df$LOC_STUDY)))

lev = c("CLOCA","CVC","GRCA","KC","LTC","LSRCA","NVCA","ORCA","TRCA","Halton","Peel","ORMGP","GSC","Consultant","other")



df %>%
  group_by(LOC_STUDY,year) %>%
  summarise('Number of measurements'=n()) %>%
  ggplot(aes(year,factor(LOC_STUDY,levels=lev),fill=`Number of measurements`)) +
    theme_bw() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1),
          legend.position = 'bottom') +
    geom_tile(color = "white",lwd = 1.5,linetype = 1) +
    geom_text(aes(label = `Number of measurements`), color = "white", size = 2) +
    scale_y_discrete(limits=rev) +
    scale_fill_continuous(high = "#132B43", low = "#56B1F7") +
    coord_fixed() +
    labs(x=NULL,y=NULL,title='ORMGP Spotflow Database',subtitle='Annual counts per partner agency') +
  guides(fill = guide_colourbar(barwidth = 20, barheight = .8))

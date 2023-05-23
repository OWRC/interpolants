

library(dplyr)
library(ggplot2)
library(ggspatial)
library(sf)
library(rgdal)
library(rnaturalearth)




####################  Basemap

lakes_sf <- ne_download(scale = 'large',
                        type = 'lakes',
                        category = 'physical') %>%
  sf::st_as_sf(lakes110, crs = 4269) %>%
  filter(name %in% c("Lake Ontario",
                     "Lake Erie",
                     "Lake Huron",
                     "Lake Simcoe",
                     "Lake Nipissing"))

lakes_sf$area <- as.numeric(st_area(lakes_sf))/1000000

# basemap (Great Lakes)
basemapGL <- ggplot() +
  theme_bw() +
  theme(axis.text = element_blank()) +  
  geom_sf(data = lakes_sf,
          mapping = aes(geometry = geometry),
          color = "black",
          fill = "lightblue")







#############################

model.bounds <- st_as_sf(readOGR("shp/230428-models.geojson",verbose = FALSE))


basemapGL +
  annotation_map_tile(zoom=8) +
  geom_sf(data=model.bounds, fill='blue', alpha=.3) +
  geom_sf_label(data=model.bounds, aes(label = Name)) +
  coord_sf(default_crs = st_crs(4326),
           ylim = c(43.2, 44.9),
           xlim = c(-80.25, -77.5),
           expand = TRUE) +
  theme(axis.ticks = element_blank()) +
  labs(x=NULL,y=NULL)

ggsave('img/models.png')

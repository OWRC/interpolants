

library(leaflet)


# https://rpubs.com/walkerke/custom_tiles
# https://alastaira.wordpress.com/2011/07/06/converting-tms-tile-coordinates-to-googlebingosm-tile-coordinates/

leaflet() %>%
  setView(-79.3, 44.1, zoom = 10) %>%
  addTiles(urlTemplate = "http://localhost:8081/tiles/{z}/{x}/{y}",
           attribution = 'Data source: <a href="https://www.oakridgeswater.ca/">Oak Ridges Moraine Groudwater Program</a>')



# library(shiny)
# 
# ui <- fluidPage((leafletOutput("map")))
# 
# server <- function(input, output, session) {
#   addResourcePath("mytiles", "E:/Sync/@dev/pages_owrc/interpolants/interpolation/calc/landuse/tiles")
#   output$map <- renderLeaflet({
#     leaflet() %>%
#       setView(-79.3, 44.1, zoom = 16) %>%
#       addTiles(urlTemplate = "mytiles/{z}/{x}/{y}.png",
#                attribution = 'Data source: <a href="https://www.oakridgeswater.ca/">Oak Ridges Moraine Groudwater Program</a>')
#   })
# }
# 
# shinyApp(ui, server)


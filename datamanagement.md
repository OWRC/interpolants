---
Title: Data Management
author: Oak Ridges Moraine Groundwater Program
output: html_document
---

![](fig/ORMGP_logo.png)

<br>


The following is a description of the ORMGP's data management practice. All data can be cited using the link below.



<span style="font-size:2em; font-weight: bold;">Contents</span>

* TOC
{:toc}


<br>

# **Data Warehousing**

## **The ORMGP Database (MSSQL)**
[Our main MSSQL Server database](/database-manual/Contents/TOC.html) holds all the information to support our decision-making tools. The ORMGP data systems are *active*, in that they are automatically updated at near real-time. From hourly and daily intervals, a series of web-scraping routines have been written to access open data made available from many sources including international, federal, provincial, municipal and conservation authority agencies. The objective is to centralize hydrogeological and hydrological data for the south-central Ontario (Canada) jurisdiction that currently makes-up the ORMGP. 

[**_Data source references._**](/interpolants/sources/reference.html)

## Delft-FEWS

The [Delft-FEWS](https://www.deltares.nl/en/software-and-data/products/delft-fews-platform) platform offers a streamlined user interface that allows practitioners to visualize time-varying spatially-distributed data from a variety of sources and formats. For instance, spatial/vector/raster time-series datasets common to climatology differ from the point/location datasets contained in the SQL database. We maintain a Delft-FEWS platform to manage these data formats. Our [**ORMGP-FEWS**](/interpolants/fews) system periodically ($\leq$ 1 day) scrapes data from federal, provincial, municipal and partner agencies to support a variety of APIs serving near-real-time historical climatologies to our partner users.

More information:
1. About the [Delft-FEWS](https://oss.deltares.nl/web/delft-fews/about-delft-fews) product by Deltares.
1. More information on ORMGP [*web data scraping*](/interpolants/sources/webscraping.html) and the [sources scraped on a nightly basis](/interpolants/sources/index.html).


<br>

## **ORMGP Servers**

### Databases and REST-APIs
* **[Our main MSSQL Server database](/database-manual/Contents/TOC.html)**
* [VertiGIS Studio/Geocortex](https://www.vertigis.com/vertigis-studio/) — Our principle [web mapping server](https://maps.oakridgeswater.ca/Html5Viewer/index.html?viewer=ORMGPP) used by partners to access our database and products.
* golang server — multi-functional REST API serving a variety of data products and interpolation tools.
* fews server — home for the [ORMGP-FEWS](/interpolants/fews/) data management system.
* image server — hosts many of the data layers produced by the ORMGP (and discussed above).
* data server — REST-API hosting GET-only requests to the ORMGP central database.

### Web Scraping
* ORMGP-cron: a linux server with scheduled [web-scraping tasks mostly written in Python](/interpolants/sources/webscraping.html).
* [ORMGP-FEWS](/interpolants/fews/): our operational Delft-FEWS system that scrapes, stores, interpolates and regenerates data served on ORMGP-cron.




<br>

# **Data Sources**

## Geology

[Description of the geological layers, their interpreted depositional setting, and of the procedures used to interpolate the surfaces.](/GeoLayers/)

* [Geology](/info/md/geology.html)
* [Drilling](/info/md/drilling.html)
* [Bedrock Geology](/info/md/bedrock.html)
* [Sedimentology](/info/md/sedimentology.html)
* [Geologic Pick database](/snapshots/md/picks.html)


## Hydrogeology
* [**ORMGP monitoring sites**](/monitoring/)
* spotflow/baseflow surveys
* Database groundwater monitoring locations:

<iframe src="https://golang.oakridgeswater.ca/pages/ycdb-locations.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Monitoring locations with >35 monitoring dates_

<br>


## Elevation, Drainage and Topology
For groundwater elevations, [digital elevation data are used to correct depths](/database-manual/02_Understanding_ORMGP_Database/02_03_Primary_Data_Relationships/02_03_05_Water_Level.html) of measure to metres above sea level (masl). Therefore, vertical accuracy and datum are tied to the digital elevation (terrain) model (DEM) we used as reference. Currently, correction are taken to the 10m [2006 OMNR *Digital Elevation Model - Version 2.0.0 - Provincial Tiled Dataset*](https://raw.githubusercontent.com/OWRC/metadata/main/external/mnr2006dem/LIO%20MNR%20DEM%2010m%20Metadata.pdf).

Overland flow drainage and their pathways (topology) are defined using the 30m [Provincial Digital Elevation Model - South (CGVD2013)](/metadata/external/pdem).

* [Overland drainage pathways](/interpolants/interpolation/overland.html)
   * [Sub-watersheds](/interpolants/interpolation/subwatershed.html):

<iframe src="https://golang.oakridgeswater.ca/pages/sws-characterization.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Sub-watershed characterization and flow topology_

<br>

* [Watercourse topology and stream order](/interpolants/interpolation/watercourses.html)

<br>


## Hydro-meteorological station data  
* [Data source **References**:](/interpolants/sources/index.html#climate-data-and-streamflow) climate and streamflow
* [Baseflow/Hydrograph Separation](/info/hydrographseparation/)
* [**Spatial Interpolation**](/interpolants/fews/climate-interpolation.html) of point data
* [**Near-Real-Time Data Acquisition**](/interpolants/sources/climate-data-service.html), updated nightly, including:
   * Daily data
      * Min/max daily temperature
      * Atmospheric/Barometric pressure
      * Precipitation (rainfall and snowfall)
      * Snowmelt ([sourced and computed](/interpolants/modelling/waterbudget/data.html#sub-daily-from-daily-snowmelt))
      * Potential evaporation ([computed](/interpolants/interpolation/calc/panET/PanEvaporation.html))
      * Streamflow
      <!-- * Solar irradiation -->
   * Hourly data, updated every 6-hours, including:
      * Precipitation (distributed, re-analysed, 6hr accumulations)
      * Air temperature
      * Atmospheric/Barometric pressure
      * Relative humidity
      * Windspeed and direction
      * Potential evaporation flux

<br>

# **Technologies**

A number of open-source and proprietary data analysis tools have been employed in our overall data management system. In contribution to the open-source community, much of our work has also left open [on our Github](https://github.com/OWRC).


## Tools (external links)
* [Github pages](https://pages.github.com/) — the hosting of technical information, like what you see now.
* [Python](https://www.python.org/)
   * [Beautiful Soup](https://www.crummy.com/software/BeautifulSoup/bs4/doc/) — web scraping
   * [NumPy](https://numpy.org/), [Pandas](https://pandas.pydata.org/) — data manipulation
   * (and many more)
* [Go](https://go.dev/)
* FORTRAN/C++
* VB.NET/C#
* [R](https://www.r-project.org/) and [RStudio](https://www.rstudio.com/) — a free, open-source "...software environment for statistical computing and graphics."
   * [R-Shiny](https://shiny.rstudio.com/) — online, real-time data analytics
   * [Leaflet for R](https://rstudio.github.io/leaflet/) — web mapping
   * [ggplot2](https://ggplot2.tidyverse.org/) — data visualization
   * [dygraphs for R](https://rstudio.github.io/dygraphs/) — dynamic time-series visualization
* [Surfer](https://www.goldensoftware.com/products/surfer/) for geo-statistical analysis such as surface kriging. 
## Databases (external links)
* [MSSQL](https://www.microsoft.com/en-us/sql-server/sql-server-2019)
* [Delft-FEWS](https://www.deltares.nl/en/software-and-data/products/delft-fews-platform)

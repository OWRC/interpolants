---
Title: Oak Ridges Moraine Groundwater Program
author: Oak Ridges Moraine Groundwater Program
output: html_document
---
The [**Oak Ridges Moraine Groundwater Program (ORMGP)**](https://www.oakridgeswater.ca/) maintains an authoritative understanding of: 

1. the geological layering for the area; 
1. the groundwater flow system; and
1. its linkage to the region's surface waters and climatologies. 


**The ORMGP has the need to:**
- coordinate disparate datasets so that correlation among environmental phenomena can be investigated
- data are sourced primarily from open datasets and are ingested into our database
- by virtue of being in our database, web applications allowing users to analyze the data become available
- this is a system of delivering information needed for water resources and planning.

The following is an index to the data maintained and produced by the ORMGP. All data can be cited by a link below.





* TOC
{:toc}






# **Data Sources**

The ORMGP data systems described below are active, in that they are automatically updated at near real-time. From hourly and daily intervals, a series of "web-scraper" routines have been written to access open data made available from many sources including international, federal, provincial, municipal and conservation authority agencies. The objective is to "centralize" hydrogeological data for the south-central Ontario (Canada) jurisdiction that currently makes-up the ORMGP. [**_Data sources: more details._**](/interpolants/sources/sources.html)

## Geology
* [Geology](/info/md/geology.html)
    * [Drilling](/info/md/drilling.html)
    * [Bedrock Geology](/info/md/bedrock.html)
    * [Sedimentology](/info/md/sedimentology.html)
    * [Geologic Pick database](/snapshots/md/picks.html)

## Hydrogeology
* [Monitoring](/monitoring/)


<iframe src="https://golang.oakridgeswater.ca/pages/ycdb-locations.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Locations with >35 monitoring dates_
<br>


## Drainage and Topology
* [Overland drainage pathways](/interpolants/interpolation/overland.html)
* [Watercourses](/interpolants/interpolation/watercourses.html)
* [Sub-watersheds](/interpolants/interpolation/subwatershed.html)

<iframe src="https://golang.oakridgeswater.ca/pages/sws-characterization.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Sub-watershed characterization and flow topology_
<br>




## Climatology

* [**Near-realtime Data sources**](/interpolants/interpolation/climate-sources.html), updated nightly, including:
   * Daily data
      * Min/max daily temperature
      * Atmospheric pressure
      * Precipitation (rainfall and snowfall)
      * Snowmelt ([sourced and computed](/interpolants/modelling/waterbudget/data.html#sub-daily-from-daily-snowmelt))
      * Potential evaporation ([computed](/interpolants/interpolation/calc/panET/PanEvaporation.html))
      <!-- * Solar irradiation -->
   * Hourly data, updated every 6-hours, including:
      * Air temperature
      * Atmospheric pressure
      * Relative humidity
      * Windspeed and direction
      * Potential evaporation flux

* [**Climate interpolation**](/interpolants/interpolation/climate-interpolation.html)


# Web Applications
## **Geocortex data portal**

The [ORMGP Geocortex Mapping hub has been divided into various Theme Maps](/webmapping/) to allow users to quickly hone in on the information they might be seeking. For example, the Documents Theme Map provides access to the program’s library of reports, The Boreholes Theme Map focuses on providing access to borehole specific information, and the Geology Theme Map provides access to all of the ORMGP geologically related mapping. The Theme Maps group specific related data sets or interpreted products ([more info here](/webmapping/)).

![](fig/geocortex-surfacewater.png)
*Our current [web-mapping system](https://maps.oakridgeswater.ca/Html5Viewer/index.html?viewer=ORMGPP) relies on Geocortex*

### [oakridgeswater.ca](https://maps.oakridgeswater.ca/Html5Viewer/index.html?viewer=ORMGPP)
*our main web mapping system*





## Timeseries analysis
* [**R-Shiny apps**]
   * [Help](/HydrographExplorerHelp/)
   * [Manual](/shinyapps-manual/)
* [Automatic hydrograph separation](/info/hydrographseparation/)
* [Hydrograph disaggregation](/info/hydrographdisaggregation/)

<!-- *and many more (TODO)* -->

<!-- ADD SNAP SHOTS HERE -->




# Open Data Products

## Metadata
[Our metadata repository, Table of Contents.](https://owrc.github.io/metadata/content/toc.html)

## Geospatial Layers
_Static 2D fields, updated frequently_
* Bedrock
* Hydro-stratigraphic units.
* [**Water Table Mapping**](/watertable/)
* [Land use](/interpolants/interpolation/landuse.html), including:
    * impervious cover
    * canopy cover
    * wetland cover
    * open water
    * relative permeability




## **Clip 'n Ship**
* [**"Clip 'n Ship"**](/interpolants/sources/clipnship.html) — A bulk spatial data export system, by geographic extent. Includes many of the products listed below.




## Spatially interpolated, near real-time data

<iframe src="https://golang.oakridgeswater.ca/pages/swsmet.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Distributed time-series data, updated nightly_
<br>

* [Climate data](/interpolants/modelling/waterbudget/data.html)
* [Barometry](/interpolants/interpolation/barometry.html) elevation-corrected and projected to a 2km regional grid.







# Numerical Modelling

Numerical modelling are applied in two ways: 

The first is a long-term data assimilation system that utilizes hydrological analysis tools (i.e., models) and leverages the ORMGP's database. What amounts to *data assimilation system* (DAS) utilized modelling technology to provide real-time *interpolation* of the hydrological system, data we have access to. The computational structure of the DAS is specifically tailored to run as fast as possible, such that thousands of model "projections" made continuously on [ORMGP servers](/interpolants/#servers). The results from this analysis will likely be offered as monthly ranges in long term seasonal water balance estimates.

Other tools are intended for predictive use, but are restricted to short-term (less than 30 days) projections. The design of these models is more physically rigorous but will always be dependent on other models (existing groundwater models or the DAS described here) to prescribe the antecedent conditions. While computational time for this model is orders of magnitudes greater than that of the DAS, it continuous to share the philosophy of designed whereby computation efficiency is paramount.

Combined, these two tools will provide all water groundwater resources needs for the ORMGP partners in order to:

1. utilize readily available datasets provided daily by government agencies of Canada and the United States without the need for [data pre-processing](/interpolants/modelling/waterbudget/data.html)
1. capture long-term hydrological water budget estimates with an emphasis on its certainty
1. project near-term hydrological response given a known antecedent state


## Existing numerical model files, output and sharing

* [Numerical Model Custodianship Program](/snapshots/md/numerical-model-custodianship-program.html) — model archive.
* [*A Guide for Actively Managing Watershed-Scale Numerical Models in Ontario*](https://www.oakridgeswater.ca/_files/ugd/4a0a6e_c41c71a481ea4657806e1fbb0c912f7a.pdf) — model management guidance (2017)

<iframe src="https://golang.oakridgeswater.ca/pages/numerical-model-custodianship-program.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Set of numerical models maintained in the custodianship program_
<br>



## Regional **Water Budget**, Long-term and Continuous
* Fine-resolution (2,500 m²) **Water Budgeting** using a  [regionally-distributed runoff-recharge model](/interpolants/modelling/waterbudgetmodel.html) for Long-term (>20 years) continuos 6-hourly hydrological modelling of the ORMGP jurisdiction.


## Short-term/event-based hydrology
* [Lateral water movement:](/info/lia/) a local inertial approximation of the shallow water equation for lateral movement of water.
* [Multiphase flow through porous media:](/info/pmflow/) a one-dimensional fully-implicit multi-layer solution to multi-phase flow through porous media used to investigate infiltration, evaporation and runoff generation.


## Other
* [Geothermal transport modelling.](/info/geothermal/)


<!-- * [Input data](/interpolants/modelling/waterbudget/data.html) -->
<!-- * [Soil moisture accounting](/interpolants/modelling/waterbudget/sma.html) -->
<!-- * [Total evaporation](/interpolants/modelling/waterbudget/pet.html) -->
<!-- * Potential Solar Irradiation -->
   <!-- * [Atmospheric transmittance](/interpolants/modelling/BristowCampbell.html) -->
<!-- * [Snowmelt](/interpolants/modelling/waterbudget/snowmeltCCF.html) -->
<!-- * [Shallow groundwater](/interpolants/modelling/waterbudget/gw.html) -->
<!-- * [Overland flow routing](/interpolants/modelling/waterbudget/overlandflow.html) -->
<!-- * [References](/interpolants/modelling/waterbudgetmodel.html#references) -->
   



# Technologies
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

## Databases (external links)
* [MSSQL](https://www.microsoft.com/en-us/sql-server/sql-server-2019)
* [Delft-FEWS](https://www.deltares.nl/app/uploads/2015/01/Delft-FEWS_brochure-2017.pdf)


## **ORMGP Servers**

### Databases and APIs
* **[Our main MSSQL Server database](/database-manual/Contents/TOC.html)**
* [VertiGIS Studio/Geocortex](https://www.vertigis.com/vertigis-studio/) — Our principle [web mapping server](https://maps.oakridgeswater.ca/Html5Viewer/index.html?viewer=ORMGPP) used by partners to access our database and products.
* golang server — multi-functional REST API serving a variety of data products and interpolation tools.


### Web scraping
* ORMGP-cron: a linux server with scheduled [web-scraping tasks mostly written in Python](/interpolants/sources/webscraping.html).
* [ORMGP-FEWS](/interpolants/interpolation/fews.html): our operational Delft-FEWS system that scrapes, stores, interpolates and regenerates data served on ORMGP-cron.






# **Glossary**
[*click here*](glossary.html)


[*see also snapshots*](https://golang.oakridgeswater.ca/snapshots/)
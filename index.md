---
Title: Oak Ridges Moraine Groundwater Program
author: Oak Ridges Moraine Groundwater Program
output: html_document
---

![](fig/ORMGP_3D.png)

<br>

The [**Oak Ridges Moraine Groundwater Program (ORMGP)**](https://www.oakridgeswater.ca/) maintains an authoritative understanding of: 

1. the geological layering for the area; 
1. the groundwater flow system; and
1. linkages to the region's surface waters and climatologies. 


**The ORMGP has the need to:**
- coordinate disparate datasets so that correlation among environmental phenomena can be investigated
- data are sourced primarily from open datasets and are ingested into our database
- by virtue of being in our database, web applications allowing users to analyze the data become available
- this is a system of delivering information needed for water resources and planning.

The following is an index to the data maintained and produced by the ORMGP. All data can be cited by a link below.

* TOC
{:toc}

# **Data Sources**
## **SQL Database**
[Our main MSSQL Server database](/database-manual/Contents/TOC.html) holds all the information to support our decision-making tools. The ORMGP data systems are *active*, in that they are automatically updated at near real-time. From hourly and daily intervals, a series of web-scraping routines have been written to access open data made available from many sources including international, federal, provincial, municipal and conservation authority agencies. The objective is to centralize hydrogeological and hydrological data for the south-central Ontario (Canada) jurisdiction that currently makes-up the ORMGP. 


[**_Data source references._**](/interpolants/sources/reference.html)


## **Delft-FEWS Database**

The [Delft-FEWS](https://www.deltares.nl/en/software-and-data/products/delft-fews-platform) platform offers a streamlined user interface that allows practitioners to visualize time-varying spatially-distributed data from a variety of sources and formats. For instance, spatial/vector/raster time-series datasets common to climatology differ from the point/location datasets contained in the SQL database. We maintain a Delft-FEWS platform to manage these data formats. Our [**ORMGP-FEWS**](/interpolants/fews) system periodically ($\leq$ 1 day) scrapes data from federal, provincial, municipal and partner agencies to support a variety of APIs serving near-real-time historical climatologies to our partner users.


More information:
1. about [Delft-FEWS](https://oss.deltares.nl/web/delft-fews/about-delft-fews)
1. more on [*web data scraping*](/interpolants/sources/index.html#web-data-scrapers)



## Geology

[Description of the geological layers, their interpreted depositional setting, and of the procedures used to interpolate the surfaces.](/GeoLayers/)

* [Geology](/info/md/geology.html)
* [Drilling](/info/md/drilling.html)
* [Bedrock Geology](/info/md/bedrock.html)
* [Sedimentology](/info/md/sedimentology.html)
* [Geologic Pick database](/snapshots/md/picks.html)


## Hydrogeology
* [**ORMGP monitoring sites**](/monitoring/)

* Database groundwater monitoring locations
<iframe src="https://golang.oakridgeswater.ca/pages/ycdb-locations.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Monitoring locations with >35 monitoring dates_

<br>


## Elevation, Drainage and Topology
For groundwater elevations, [digital elevation data are used to correct depths](/database-manual/02_Understanding_ORMGP_Database/02_03_Primary_Data_Relationships/02_03_05_Water_Level.html) of measure to metres above sea level (masl). Therefore, vertical accuracy and datum are tied to the digital elevation (terrain) model (DEM) we used as reference. Currently, correction are taken to the 10m [2006 OMNR *Digital Elevation Model - Version 2.0.0 - Provincial Tiled Dataset*](https://raw.githubusercontent.com/OWRC/metadata/main/external/mnr2006dem/LIO%20MNR%20DEM%2010m%20Metadata.pdf).

Overland flow drainage and their pathways (topology) are defined using the 30m [Provincial Digital Elevation Model - South (CGVD2013)](/metadata/external/pdem).

* [Overland drainage pathways](/interpolants/interpolation/overland.html)
   * [Sub-watersheds](/interpolants/interpolation/subwatershed.html)

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

[*see interpolated data below*](#spatially-interpolated-near-real-time-data)

<br>




# **Web Applications**

## [**Geocortex** Data Portal](https://maps.oakridgeswater.ca/Html5Viewer/index.html?viewer=ORMGPP)

The [ORMGP Geocortex Mapping hub has been divided into various Theme Maps](/webmapping/) to allow users to quickly hone in on the information they might be seeking. For example, the Documents Theme Map provides access to the program’s library of reports, The Boreholes Theme Map focuses on providing access to borehole specific information, and the Geology Theme Map provides access to all of the ORMGP geologically related mapping. The Theme Maps group specific related data sets or interpreted products ([more info here](/webmapping/)).

![](fig/geocortex-surfacewater.png)

*Our current [web-mapping system](https://maps.oakridgeswater.ca/Html5Viewer/index.html?viewer=ORMGPP) relies on Geocortex*


### Geological layers

The [geological layers made available on the Geocortex portal](/interpolants/interpolation/geolayers.html) are found in two places: the Geology Theme Map and the cross-section tool. More information on [their interpreted depositional setting and of the procedures used to interpolate the surfaces](/GeoLayers/).

In the [Geology Theme Map](/webmapping/#geology-map), users can view either the tops of or the isopach/thickness of any of the layers.  The Geological Picks made at each well, that are used to construct or interpolate each layer are also available.  A screen capture from the website showing the Top of Halton Till as well as the picks is shown below.

![](fig/geocortex-geolayers.png)

### Cross-section tool

The cross-section tool is designed to provide a cut, along a user-defined line, through the subsurface to display the regionally interpreted Quaternary geological layers down to the bedrock. 

![](fig/xsection-tool.png)

### Piper plots

The piper plot tool presents water chemistry in an informative way and can be sorted by location or geologic formation.

![](fig/piper.png)


<br>



## sHydrology
R-Shiny-Leaflet mapping with access to our monitoring dataset. [**Go to online map.**](https://owrc.shinyapps.io/shydrologymap/)

## Time-Series Analysis
* [**R-Shiny apps**]
   * [Help](/HydrographExplorerHelp/)
   * [Manual](/shinyapps-manual/)
* [Automatic hydrograph separation](/info/hydrographseparation/)
* [Hydrograph disaggregation](/info/hydrographdisaggregation/)

<!-- *and many more (TODO)* -->

<!-- ADD SNAPSHOTS HERE -->
<!-- shikaze: should we keep snapshots on a separate github to keep things simpler? -->
<br>

# **Open Data Products** 

## Metadata

[Our metadata repository, Table of Contents.](/metadata/content/toc.html)

#### Surfaces
 - [Potential Discharge Areas - Metadata](/metadata/surfaces/potential_discharge.html)
 - [Potentiometric Surface - Metadata](/metadata/surfaces/potentiometric_surface.html)
 - [Water Table - Metadata](/metadata/surfaces/water_table.html)



## Geospatial Layers

> _Static 2D fields, updated frequently_

### Bedrock
### **Geological Surfaces (2021)**

The geology layers presented on the ORMGP Website have been created at different times, and in cases, by different parties over the years.  ORMGP staff are regularly checking the geological layers, making adjustments over time. However, these incremental changes are only periodically updated onto the website. The Figure below shows the various sets of geological layers that have been built into a regional picture and that are currently reflected on the ORMGP website.

[*more info*](/interpolants/interpolation/geolayers.html)

### **Water Table Mapping**

The Oak Ridges Moraine Groundwater Program (ORMGP) has been working on producing a reliable water table map for quite some time. Over the years several versions of the water table surface have been prepared as new information has become available or as the technical mapping methodology has been adjusted. Although it sounds straightforward to interpolate a water table surface, there are a number of factors that make the process difficult. Here we outline some of the considerations that have gone into creating the water table surfaces (and their derivatives) and can serve as a supplementary document for those that make use of these layers.

[*more info*](/watertable/)


### Land use

The source of the land use data is: Ministry of Natural Resources and Forestry, 2019. Southern Ontario Land Resource Information System (SOLRIS) Version 3.0: Data Specifications. Science and Research Branch, April 2019.

From this layer, the follow land use categorizations are derived:

- impervious cover
- canopy cover
- wetland cover
- open water
- relative permeability

[*more info*](/interpolants/interpolation/landuse.html)

<br>

## **Clip 'n Ship**
* [**"Clip 'n Ship"**](/interpolants/sources/clipnship.html) — A bulk spatial data export system, by geographic extent. Includes many of the products listed below.

## Spatially interpolated, near real-time data

* [**Cleansed Climate Data**](/interpolants/modelling/waterbudget/data.html) for use in our water budget product which includes the computation of [potential evaporation](/interpolants/interpolation/calc/panET/PanEvaporation.html), [snowmelt](/interpolants/modelling/waterbudget/data.html#sub-daily-from-daily-snowmelt), etc. from available data.
* [Spatial and Temporal interpolation](/interpolants/fews/climate-interpolation.html) of point/scalar data.
* [Barometric pressure](/interpolants/interpolation/barometry.html) elevation-corrected and projected to a 2km regional grid.

<br>

<iframe src="https://golang.oakridgeswater.ca/pages/swsmet.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Distributed time-series data, updated nightly_

<br>





# **Numerical Modelling**

Numerical modelling are applied in two ways: 

1. A long-term data assimilation system that uses hydrological analysis tools (i.e., models) and leverages the ORMGP's database. What amounts to *data assimilation system* (DAS) utilized modelling technology to provide real-time *interpolation* of the hydrological system, data we have access to. The computational structure of the DAS is specifically tailored to run as fast as possible, such that thousands of model "projections" made continuously on [ORMGP servers](/interpolants/#servers). The results from this analysis will likely be offered as monthly ranges in long term seasonal water balance estimates.
2. Other tools are intended for predictive use, but are restricted to short-term (less than 30 days) projections. The design of these models is more physically rigorous but will always be dependent on other models (existing groundwater models or the DAS described here) to prescribe the antecedent conditions. While computational time for this model is orders of magnitudes greater than that of the DAS, it continuous to share the philosophy of designed whereby computation efficiency is paramount.

Combined, these two tools will provide all water groundwater resources needs for the ORMGP partners in order to:

1. utilize readily available datasets provided daily by government agencies of Canada and the United States without the need for [data pre-processing](/interpolants/modelling/waterbudget/data.html)
2. capture long-term hydrological water budget estimates with an emphasis on its certainty
3. project near-term hydrological response given a known antecedent state


## Existing numerical model files, output and sharing

We have established a numerical modelling sharing process to assist consultants in moving forward on various projects by making use of previous interpretations/work.  The mission of the [**ORMGP numerical model custodianship program**](/snapshots/md/numerical-model-custodianship-program.html) is to provide numerical models to any consultant undertaking work within our partners' jurisdiction.  

Users (e.g., consultants) are expected to review the shared models' suitability to their intended application. Considering the age of the models, the expertise who constructed the model, the model's original intent, etc., it is the responsibility of the user to determine whether there is an approach more suitable than just using the model files as delivered. For instants, some consultants have only selected specific model file components (i.e. hydraulic conductivity distribution or geological layering, thicknesses etc.) to complete their task.

Users are free to update/modify the model in the hopes that the refinements are shared in return and knowledge preserved.

Often, within any geographical area of a new/proposed consulting project, there are several models that could be used to aid the new project. Given the nature of the proposed project (e.g. water supply, contamination investigation, proposed land development, etc.) we could make suggestions the most appropriate model or the consultant is free to select any or all models, where available.  

The idea is that model sharing could perhaps reduce duplication of effort, thereby lowering consulting costs by providing previous modelling insights in a transferable digital format.  Given that every project is different, the likelihood that a model can be transferred to address the needs of a another study may be quite low.

  
* [Numerical Model Custodianship Program](/snapshots/md/numerical-model-custodianship-program.html) — model archive.
* [*A Guide for Actively Managing Watershed-Scale Numerical Models in Ontario*](https://www.oakridgeswater.ca/_files/ugd/4a0a6e_c41c71a481ea4657806e1fbb0c912f7a.pdf) — model management guidance (2017)

<iframe src="https://golang.oakridgeswater.ca/pages/numerical-model-custodianship-program.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Set of numerical models maintained in the custodianship program_

<br>


## **Particle Tracking** web-tool

The ORMGP particle tracking tool shows both the forward or backward particle tracking from a site that is being studied.  The tool is built upon [numerical models](/snapshots/md/numerical-model-custodianship-program.html) which have organized, synthesized and interpreted a wealth of hydrogeological information (e.g., boreholes, geological mapping, previous studies, etc.). 

* More info on 3D [**particle tracking** of the groundwater flow system and the methodology used in our web tool](/interpolants/modelling/particleTracking/).


## Regional **Water Budget**, Long-term and Continuous
* Fine-resolution (2,500 m²) [**Water Budgeting** using a  regionally-distributed runoff-recharge model](/interpolants/modelling/waterbudgetmodel.html) for Long-term (>20 years) continuos 6-hourly hydrological modelling of the ORMGP jurisdiction.


## Short-term/event-based hydrology
* [Lateral water movement:](/info/lia/) a local inertial approximation of the shallow water equation for lateral movement of water.
* [Multiphase flow through porous media:](/info/pmflow/) a one-dimensional fully-implicit multi-layer solution to multi-phase flow through porous media used to investigate infiltration, evaporation and runoff generation.


## Other
* [Geothermal transport modelling.](/info/geothermal/)
* Urban water balance, Low Impact Design (LID) modelling, groundwater *I&I*, etc. using [_**GSFLOWurban**_](https://github.com/maseology/GSFLOWurban).
* [Artificial Neural Network Machine Learning hydrograph simulation.](/info/ann/)


<!-- * [Input data](/interpolants/modelling/waterbudget/data.html) -->
<!-- * [Soil moisture accounting](/interpolants/modelling/waterbudget/sma.html) -->
<!-- * [Total evaporation](/interpolants/modelling/waterbudget/pet.html) -->
<!-- * Potential Solar Irradiation -->
   <!-- * [Atmospheric transmittance](/interpolants/modelling/BristowCampbell.html) -->
<!-- * [Snowmelt](/interpolants/modelling/waterbudget/snowmeltCCF.html) -->
<!-- * [Shallow groundwater](/interpolants/modelling/waterbudget/gw.html) -->
<!-- * [Overland flow routing](/interpolants/modelling/waterbudget/overlandflow.html) -->
<!-- * [References](/interpolants/modelling/waterbudgetmodel.html#references) -->
   



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

## Databases (external links)
* [MSSQL](https://www.microsoft.com/en-us/sql-server/sql-server-2019)
* [Delft-FEWS](https://www.deltares.nl/en/software-and-data/products/delft-fews-platform)


## **ORMGP Servers**

### Databases and APIs
* **[Our main MSSQL Server database](/database-manual/Contents/TOC.html)**
* [VertiGIS Studio/Geocortex](https://www.vertigis.com/vertigis-studio/) — Our principle [web mapping server](https://maps.oakridgeswater.ca/Html5Viewer/index.html?viewer=ORMGPP) used by partners to access our database and products.
* golang server — multi-functional REST API serving a variety of data products and interpolation tools.
* fews server — home for the [ORMGP-FEWS](/interpolants/fews/) data management system.


### Web Scraping
* ORMGP-cron: a linux server with scheduled [web-scraping tasks mostly written in Python](/interpolants/sources/webscraping.html).
* [ORMGP-FEWS](/interpolants/fews/): our operational Delft-FEWS system that scrapes, stores, interpolates and regenerates data served on ORMGP-cron.






# **Glossary**
[*click here*](glossary.html)




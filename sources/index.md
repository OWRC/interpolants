---
title: Open Data Sources
output: html_document
---

> Below lists the data used in supporting the ORMGP and its wide range on data services. This page details open data accessed for **external** source only and does not include data produced by the ORMGP.

* TOC
{:toc}

# Spatial Data

* [Ontario Hydro Network (OHN) - Watercourse](https://geohub.lio.gov.on.ca/datasets/mnrf::ontario-hydro-network-ohn-watercourse/about) provides the location of watercourses in Ontario and is offered by the Ontario Ministry of Natural Resources and Forestry.
* [Ontario Hydro Network (OHN) - Waterbody](https://geohub.lio.gov.on.ca/datasets/mnrf::ontario-hydro-network-ohn-waterbody/about) shows the location of waterbodies in Ontario as part of the Ontario Hydro Network (OHN) and offered by the Ontario Ministry of Natural Resources and Forestry.
* Ministry of Natural Resources and Forestry [Southern Ontario Land Resource Information System (SOLRIS) Version 3](https://geohub.lio.gov.on.ca/documents/lio::southern-ontario-land-resource-information-system-solris-3-0/about), April 2019
* Ontario Geological Survey [surficial geology of southern Ontario, 2010](https://data.ontario.ca/dataset/surficial-geology-of-southern-ontario).
* Ground surface elevations were collected from the October 16, 2023 update of the Provincial Digital Elevation Model (PDEM) offered by the [Ontario Ministry of Natural Resources and Forestry](https://geohub.lio.gov.on.ca/maps/mnrf::provincial-digital-elevation-model-pdem/about). This is a 30x30m² DEM referenced to the [Canadian Geodetic Vertical Datum of 2013](https://cdnsciencepub.com/doi/10.5623/cig2016-101) (CGVD2013).  


# Timeseries Data

## Web Data Scrapers

On a nightly basis, scheduled tasks are used to automatically download and insert new data into the [ORMGP database](https://owrc.github.io/database-manual/Contents/TOC.html), a process called ["web scraping"](/interpolants/sources/webscraping.html). So, in addition to hydrogeologic information, the database maintains a [near-realtime hydrometeorological](/interpolants/sources/climate-data-service.html) dataset at the 6-hourly and daily time scales. 


## Groundwater monitoring

Groundwater monitoring data, [like those collected by the ORMGP](/monitoring/), are kept in their time-scale, typically in the order of 10 min to hours, and inserted into the database.


## Climate data and streamflow
For the most part, information scraped below do not enter the database as they are sub-daily resolution. Rather, the higher-resolution data, including the gridded data, are maintained running [Delft-FEWS](/interpolants/fews/).

The ORMGP database maintains daily hydrometeorological data covering the 30,000km² ORMGP management area, going back over a century. Data collected are "near" realtime in that they are what is reported when the scheduled task was run (the night prior). The web tools and data services we maintain and numerical models we archive depend on this dataset.



### Current data sources

Below is a *summary* list of the hydrometeorological data sources used in deriving many our data services. These sources are all free and open, but come in a variety of formats. For more details, please visit the [detailed source reference page](/interpolants/sources/reference.html).


* **WSC** - Water Survey of Canada 
  - [MSC Datamart](https://eccc-msc.github.io/open-data/msc-datamart/readme_en/) *.csv file server for near real-time data
    - daily streamflow stage and discharge
  - [National Water Data Archive: HYDAT](https://www.canada.ca/en/environment-climate-change/services/water-overview/quantity/monitoring/survey/data-products-services/national-archive-hydat.html) are updated quarterly as sqlite database files. Imports from HYDAT always overwrites data recorded through Datamart.
    - daily streamflow stage and discharge

* **ECCC-MSC** - Environment and Climate Change Canada—Meteorological Service of Canada
    - [Historical Data](https://climate.weather.gc.ca/historical_data/search_historic_data_e.html) (html portal to meteorologic data)
        - hourly: air temperature, air pressure, relative humidity, wind speed, wind direction
        - daily: min/max air temperature, rainfall, snowfall, snow depth
    - Canadian Precipitation Analysis (CaPA)
        - [Regional Deterministic Precipitation Analysis (CaPA-RDPA)](https://eccc-msc.github.io/open-data/msc-data/nwp_rdpa/readme_rdpa_en/) is a gridded (~10km) 6-hourly near realtime continuous precipitation field for the past 20 years, albeit in many overlapping versions.
        - [High Resolution Deterministic Precipitation Analysis (CaPA-HRDPA)](https://eccc-msc.github.io/open-data/msc-data/nwp_hrdpa/readme_hrdpa_en/) is a refined version (~2.5km) of the product above, going back to 2019.

* **NOAA-NSIDC** - National Oceanic and Atmospheric Administration-National Snow & Ice Data Center
    * [Snow Data Assimilation System (SNODAS)](https://nsidc.org/data/g02158)
        - continuous ~30m resolution grid 24-hour accumulations of snowmelt and mean daily snow water equivalent (SWE), realtime from 2009 (when coverage was opened to Canada)
        - *SNODAS models Snow Water Equivalent, the liquid water content of the snowpack. SWE is a much more robust statistic than Depth, which changes the minute the snowflakes hit the ground. A twelve-inch snowfall slumps to eight inches after a day of sunshine and wind as the snowpack compresses and metamorphs, without any change to the SWE value. Depth is computed after that fact, by multiplying SWE against an independent estimate of Snow Density.* [(Tim Szeliga, NOHRSC, 2012)](https://gis.stackexchange.com/questions/34871/extracting-data-from-snodas-file-using-qgis).  
        - SNODAS is a modeling and data assimilation system developed by OHRSC to provide the best possible estimates of snow cover and associated parameters to support hydrologic modeling and analysis. The aim of SNODAS is to provide a physically consistent framework to integrate snow data from satellite, airborne platforms, and ground stations with model estimates of snow cover (Carroll et al. 2001).

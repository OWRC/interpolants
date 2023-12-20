---
title: Near Real-time Climate Data Service
output: html_document
---



The [ORMGP](https://oakridgeswater.ca/) maintains a current, continuous daily climatology dataset beginning 1901 and a 6-hourly dataset from 2002. 

Every night, the automated data service [web-scrapes](/interpolants/sources/webscraping.html) and [interpolates](/interpolants/fews/climate-interpolation.html) publicly-available climate data to [some 4,200 ~10km² sub-watersheds](/interpolants/interpolation/subwatershed.html) covering our greater jurisdiction. The data are made available through our [public web portal](https://maps.oakridgeswater.ca/Html5Viewer/index.html?viewer=ORMGPP) and are served using the [ORMGP-FEWS](/interpolants/fews/) system.

<!-- Reference to the external data acquired and discussed below [***are detailed here***](/interpolants/sources/sources.html). -->

> *Data for download can be found [here](#highlights).*

<br>

<iframe src="https://owrc.shinyapps.io/sws23/" width="100%" height="400" scrolling="no" allowfullscreen></iframe>

*4,238 ~10km² sub-watersheds delineated with their topological relationships defined, as shown by clicking any sub-watershed of lake. In addition to climate data, these sub-watersheds have been attributed with land use characteristics, elevations, etc.*

Currently, the data service offers near-realtime estimates of [hover text](# "your hover text") and  [hover text2](## "your hover text2"):

- Rainfall
- Snowfall
- Snowmelt
- Air temperatures
- Atmospheric pressure
- Relative humidity
- Wind speed
- Wind direction
- Potential evaporation

<br><br>


**Page Outline:**

* TOC
{:toc}


<br>

# Introduction: the need

The data serve many purposes from basic time series overlay with point data sets (e.g., groundwater monitoring locations) to providing ready-made inputs to continuous hydrological models needed for distributed groundwater recharge estimation.

Clearly, data collection is constrained by public/private funding, open data sharing policies and technology; so the data served are a compilation of what is deemed the best for *our partners'* needs. The necessitates data acquisition from a number of public sources. 

Specifically, we are concerned about climatology at the *regional scale*. We cover a 3 Million hectare jurisdiction and based on our experience, compiling a continuous interpolated climate dataset requires greater emphasis on the spatial distribution of climatology over quality of data collected at climate stations.  That's not to say that this is a general rule, but for our needs in our humid region with a significant winter influence, attention to how weather distributes is of paramount importance.

Admittedly, greater emphasis is made to "re-packaging" data-products from external agencies; we are not trying to re-invent the wheel. Instead, we are only trying to automate a workflow that, until now, is constantly repeated by our partner agencies and partner consultants when such data are needed. We don't require any of our partners to use our data, we are only making available the data we use in our internal analyses.

Below is a description of the datasets used in our overall climatology package. Precipitation, for example, comes from a multitude of sources that generally follow technological advances. In order to obtain a century+ continuous dataset, older station-based interpolation is supplanted by more recent *"data assimilation systems"* (DAS), where and when available.

It's also worth noting that the density of [active meteorological stations present in our jurisdiction has been in decline since the 1970s](/snapshots/md/gantt-met.html). Understandably, much of the recent investment in meteorological station operation has been dedicated to Canada's north; a large geographical region that has been grossly overlooked yet is most susceptible to a changing climate.

Below, the data types that are collected, interpolated and delivered through our web portal are described in chronological order. For the most part, the most recent datasets supersede the oldest.


## Version 2023

With funding from Environment and Climate Change Canada under the Great Lakes Protection Initiative (GLPI), as part of the Great Lakes Water Quality Agreement (GLWQA), the ORMGP climate data service was expanded from its jurisdiction to cover the entire Canadian shoreline of Lake Ontario.  

This effort was a successful demonstration of the scalability of the ORMGP climate data service and now includes a 6-hourly service in addition to the original daily data service.

### Highlights:

- Coverage grew from 2,813 sub-watersheds covering 30,300km² to 4,238 sub-watersheds covering 44,500km².
- ORMGP API data service includes near-realtime continuous, infilled:
    - daily min/max air temperatures, rainfall, snowfall, snowmelt from 1901.
    - 6-hourly air temperature, air pressure, relative humidity, wind speed, rainfall, snowmelt, potential evaporation from 2002.
- Digital files available as [CF 1.8-compliant](http://cfconventions.org/Data/cf-conventions/cf-conventions-1.8/cf-conventions.html) NetCDF files. 
- Available data files for download (October, 2023):
    - indexed sub-watershed polygons: [`PDEM-South-D2013-OWRC23-60-HC-sws10.shp`](https://www.dropbox.com/scl/fi/a0r65kr7i1jirdci6d8jg/PDEM-South-D2013-OWRC23-60-HC-sws10.7z?rlkey=caol95r7k0s9p1re31mlev2a4&dl=1)
    - daily climatologies: [`PDEM-South-D2013-OWRC23-60-HC-sws10`](https://www.dropbox.com/scl/fi/a0r65kr7i1jirdci6d8jg/PDEM-South-D2013-OWRC23-60-HC-sws10.7z?rlkey=caol95r7k0s9p1re31mlev2a4&dl=1)
    - 6-hourly climatologies: [`PDEM-South-D2013-OWRC23-60-HC-sws10`](https://www.dropbox.com/scl/fi/a0r65kr7i1jirdci6d8jg/PDEM-South-D2013-OWRC23-60-HC-sws10.7z?rlkey=caol95r7k0s9p1re31mlev2a4&dl=1)

*NOTE: data compressed using [7-zip](https://www.7-zip.org/).*

<br>

<br>



# **Rainfall and Snowfall**

## Meteorological Service of Canada
#### (*1901—present*)
Meteorological Service of Canada is a division of Environment Canada. Their [online historical data portal](https://climate.weather.gc.ca/index_e.html) provides data collected since the mid 19th century.

These data are collected at (point/local/scalar) weather stations and require spatial interpolation. Here, the nearest neighbour (i.e., Thiessen polygon) method is applied.

Precipitation is offered as rainfall and snowfall amounts to the tenth of a millimetre.

## ECCC: Regional Deterministic Precipitation Analysis (RDPA)

> The [RDPA] produces a best estimate of the amount of precipitation that occurred over recent past periods of 6 hours. The estimate integrates data from in situ precipitation gauge measurements, weather radar and numerical weather prediction models. Geographic coverage is North America (Canada, United States and Mexico). Data is available at horizontal resolution of 10 km. Data is only available for the surface level. Analysis data is made available four times a day for the 6h intervals. A preliminary estimate is available approximately 1h after the end of the accumulation period, and revised 6h after in order to assimilate gauge data arriving later. [*(ECCC, 2023)*](https://api.weather.gc.ca/collections/weather:rdpa:10km:6f)

<!-- #### (*2002—present, over a sequence of versions*) -->
The [Regional Deterministic Precipitation Analysis (RDPA)](https://weather.gc.ca/grib/grib2_RDPA_ps10km_e.html), which is based on the [Canadian Precipitation Analysis (CaPA) system](https://collaboration.cmc.ec.gc.ca/cmc/cmoi/product_guide/docs/lib/capa_information_leaflet_20141118_en.pdf), provides a country-wide field of 6-hourly precipitation accumulations. The CaPA-RDPA products has gone through a number of version changes since the turn of the century. The data are updated in near real-time, meaning that the current state of precipitation patterns can be made immediately available.

Simply put, CaPA-RDPA is an amalgamation of near-cast weather model predictions corrected by RADAR data and ground-truthed using a select set of weather stations. Essentially, CaPA-RDPA is a [*data assimilation system* (DAS)](https://www.ecmwf.int/en/research/data-assimilation) that provides users with the best-possible spatial distribution of precipitation, necessary for analyzing hydrology at the regional scale like the ORMGP jurisdiction.

Recently (2017), a high-resolution format of the RDPA system was released. The **HRPDA** ([High Resolution Deterministic Precipitation Analysis](https://eccc-msc.github.io/open-data/msc-data/nwp_hrdpa/readme_hrdpa_en/)) supplies a ~2.5km resolution 6-hourly precipitation field, in contrast to the ~10-15km resolution of the original RDPA product.


While the CaPA-RDPA vector data fields can be acquired from Environment Canada in GRIB2 format, the ORMGP has sourced their data from the [Canadian Surface Prediction Archive (CaSPAr)](https://caspar-data.ca/), as their archive holds the original raw data (EC's GRIB2 format is re-interpolated to a polar-stereographic grid) and the CaSPAr platform allows users to crop their area of interest. 

![CaPA-RDPA sample1](fig/FEWS-CaPA-RDPA-sample1.gif)

*CaPA-RDPA field animated in Delft-FEWS*

<br>

### Rainfall-snowfall parsing
The CaPA data are collected in their 6-hourly steps and are aggregated to daily accumulations. [(The 6-hourly fields are maintained for the sub-daily fields described here.)](/interpolants/fews/climate-interpolation.html) The precipitation fields are proportioned into rainfall and snowfall amounts based using an "optimized critical temperature" approach where precipitation fields are proportioned into rainfall and snowfall amounts based using the "critical temperature" $ (T_\text{crit}) $ approach:

$$
\text{Rainfall}=
\begin{cases}
\text{Precipitation}, & \overline{T}>T_\text{crit}\\
0 & \text{otherwise},
\end{cases}
$$

$$
\text{Snowfall}=
\begin{cases}
\text{Precipitation}, & \overline{T}\leq T_\text{crit}\\
0 & \text{otherwise}.
\end{cases}
$$

An optimization routine is employed to determine $ T_\text{crit} $ such that total snowfall converges with total snowmelt *independently for every winter season* to ensure minimal deviation from total precipitation. 



### Versions
Below lists the versions used, a complete [changelog can be found here](https://eccc-msc.github.io/open-data/msc-data/nwp_rdpa/changelog_rdpa_en/). The most recent version always takes precedence. 

#### CaPA-RDPA version 1—experimental (*2002—2012*)
The hind-cast "experimental" version 1 of CaPA-RDPA comes in a ~15km resolution.

#### CaPA-RDPA version version 2.4 (*2011—2016*)
Version 2.4 brings a number of improvements by incorporating more ground-truthing and refining to a ~10km resolution.

#### CaPA-RDPA version versions 4+ and 5+ (*2015—present*)
Further improvements, still at a ~10km resolution. 

#### CaPA-HRDPA (*2019—present*)
The latest iteration of CaPA is the [High Resolution Deterministic Precipitation Analysis (CaPA-HRDPA)](https://eccc-msc.github.io/open-data/msc-data/nwp_hrdpa/readme_hrdpa_en/) refined to a ~2.5km resolution.



### Missing Dates
The CaPA RDPA products used do have periods of no data. Listed below are the dates found. Where no data are found, the API reports the [data interpolated from MSC point locations](#meteorological-service-of-canada).


| CaPA-RDPA | CaPA-HRDPA |
| --- | --- |
| 2001-12-30 | 2019-12-14 |
| 2001-12-31 | 2019-12-15 |
| 2002-01-01 | 2019-12-16 |
| 2006-04-27 | 2019-12-17 |
| 2006-04-30 | 2021-01-01 |
| 2006-07-10 | 2022-01-01 |
| 2008-04-15 | 2022-06-20 |
| 2019-09-26 |            |
| 2019-09-27 |            |
| 2019-10-25 |            |
| 2020-03-16 |            |
| 2020-03-17 |            |
| 2020-04-21 |            |
| 2020-04-22 |            |
| 2020-10-01 |            |
| 2020-10-02 |            |


### Missing Locations
At 2 locations, where the sub-watershed makes up the entirety of a small island, the Delft-FEWS interpolation scheme appears to overlook, and return a no-data value. When this occurs, the value given to nearby sub-watersheds are adopted.





# **Snowmelt and SWE**
## U.S. National Oceanic and Atmospheric Administration (NOAA) 
#### SNODAS daily (*2010—present*)
Snow water equivalent (SWE) and snowmelt must be derived from snowpack ablation models. These models come in a variety of forms and sophistication. The primary source of such information comes from the [Snow Data Assimilation System (SNODAS)](https://nsidc.org/data/g02158) system (NOHRSC, 2004), which offers ~1km gridded 24-hour (UTC 06-06) snowmelt totals, published freely in near real-time. The advantage of SNODAS is that we can avoid the need to model snowmelt explicitly, and leverage existing resources. The data cover our jurisdiction from 2009—present.

#### SNODAS 6-hourly (*2020—present*)
SNODAS is also offered in 6-hourly states, however offered only for the past month, so some automated web-scraping would be requires. Here, the [ORMGP-FEWS](/interpolants/fews/) system imports and crops the data nightly.

![SNODAS sample](fig/nsm_depth_2016011505_National.jpg)



## Cold Content Energy Balance Snowpack Model
#### (*1901—present*)
When unavailable (and prior to 2010), a [cold content energy balance snowpack model](/interpolants/modelling/waterbudget/snowmeltCCF.html) is applied relying on interpolated precipitation and temperatures.





# **Air Temperature**

Elevations within the ORMGP region range from 75-400 masl and thus orographic effects to temperatures were deemed negligible. The spatial distribution of minimum/maximum daily temperature is then interpolated from meteorological stations using an inverse squared-distance methodology.

All temperature data are acquired from the Meteorological Service of Canada.

## Meteorological Service of Canada
#### Minimum and Maximum daily Temperature (*1901—present*)
#### Hourlies (*1953—present*)


# **Atmospheric Pressure**
## Meteorological Service of Canada
#### Hourlies (*1953—present*)
Atmospheric pressure data are acquired from Meteorological Service of Canada, which come in as hourly averages. In contrast to temperatures, [elevation does have am impact on pressure distribution and thus corrections are made](/interpolants/interpolation/barometry.html). Once corrected, the hourly data are then aggregated to daily averages.


# **Relative Humidity**
## Meteorological Service of Canada
#### Hourlies (*1953—present*)
Relative Humidity data are acquired from Meteorological Service of Canada


# **Wind Speed and Direction**
## Meteorological Service of Canada
#### Hourlies (*1953—present*)
Wind speed and direction data are acquired from Meteorological Service of Canada


# **Pan Evaporation**
## Meteorological Service of Canada
#### (*1962—1996*)
[*more info here*](/interpolants/interpolation/calc/panET/PanEvaporation.html)


<!-- # **Solar Irradiation** -->




# Data interpolation

The above data are automatically [interpolated to the 10km² sub-watershed scale](/interpolants/fews/climate-interpolation.html). 


### **Waterbudget**
For use of interpolated climate data in our water budgeting service including access to data, [click here](/interpolants/modelling/waterbudget/data.html).



# References

National Operational Hydrologic Remote Sensing Center. 2004. Snow Data Assimilation System (SNODAS) Data Products at NSIDC, Version 1. [Indicate subset used]. Boulder, Colorado USA. NSIDC: National Snow and Ice Data Center. doi: https://doi.org/10.7265/N5TB14TC. [Date Accessed]
---
title: Spatial interpolation of point data
output: html_document
---


Below is an itemized description of the interpolation process used with ORMGP's [Near Real-time Climate Data Service](https://owrc.github.io/interpolants/sources/climate-data-service.html). This service is fullly supported by open data access from a variety of government sources. A complete reference to the data used is provided [here](https://owrc.github.io/interpolants/sources/reference.html).

> version 2406

* TOC
{:toc}


# Interpolation of station to ORMGP sub-watersheds
All interpolated data are automatically updated and maintained using the [ORMGP-FEWS system](/interpolants/fews/) system.

> workflow: `ImportMSCdatamartCsv.xml`


## Meteorological Service of Canada (MSC) scalars

### Hourly data
1. Scrape MSC for recent data from [datamart](https://dd.weather.gc.ca/) using python, executed from FEWS.
2. Import scraped MSC hourly scalars into FEWS.
3. Export hourly MSC NetCDF file (*.nc) from FEWS, from 1989-10-01 
    
    > `20240701-exportScalarHourly.nc`  $T_a, p_a, r, u, u_\alpha$

4. Interpolate to 10 km sub-watersheds, using a python script executed from config file `pyMSChourliesToBasin.xml` that executes: `ncScalarToHourlyBasinNetCDF.py`.
    - Air temperature $(T_a)$, relative humidity $(r)$ and wind speeds $(u)$ are interpolated using a [radial basis function (RBF)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.Rbf.html) (with a thin-plate-spline kernel and a smoothing factor $\lambda=1/1000$ to prevent singular matrices).
    - Air/barometric pressure $(p_a)$ are first [corrected for elevation](/interpolants/interpolation/barometry.html) then interpolated using the same thin-plate-spline RBF. 
    - Wind directions $(u_\alpha)$ are split into their x-y components, each interpolated separately using a thin-plate-spline RBF before returned to an angle. A sample result is shown below:

    ![](fig/windir.png)

5. Interpolated $(T_a, r, u)$ are applied to compute potential evaporation flux [m/s] (Novák, 2012):

$$
    E_a=7.46\times 10^{-9} \cdot (a + ub) d_a
$$

$$
    d_a=(1-r) \cdot e_s(T_a)
$$

6. Save to NetCDF (.nc) for import back to FEWS.

    > `20240701-exportBasin6hourly.nc`  $T_a, p_a, r, u, E_a$ hourly basins




## Hourly Basin to 6-hourly Basin Interpolation

1. Hourly aggregation to 6-hourly time intervals (00:00 06:00 12:00 18:00 UTC) is performed in FEWS using the:
    - [MeanToMean aggregation](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+MeanToMean) routine for $Ta, p_a, r, u$, and
    - [Accumulative aggregation](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+Accumulative) routine for $E_a$.


2. Export 6-hourly, basin-interpolated $T_a, p_a, r, u$ to NetCDF. 

    > `20240701-exportBasin6hourly.nc`


### Daily data
1. Scrape MSC for recent data from [datamart](https://dd.weather.gc.ca/) using python, executed from FEWS.
2. Import scraped MSC daily scalars into FEWS.
3. Export daily MSC NetCDF file (*.nc) from FEWS, from 1989-10-01 
    
    > `20240701-exportScalarDaily.nc`  $R_f, S_f, T_n, T_x, u_g, u_{g\alpha}$

4. Interpolate to 10 km sub-watersheds, using a python script executed from config file `pyMSCdailiesToBasin.xml` that executes: `ncScalarToDailyBasinNetCDF.py`.
    - Rainfall $(R_f)$ and snowfall $(S_f)$ are interpolated to their nearest neighbour.
    - Air temperatures $(T_\text{min}\text{ and } T_\text{max})$ and wind speed of gusts $(u_g)$ are interpolated using a [radial basis function (RBF)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.Rbf.html) (with a thin-plate-spline kernel and a smoothing factor $\lambda=1/1000$ to prevent singular matrices). This only occurs when there is more than 3 point measurements to interpolate from, otherwise nearest neighbour is used.
    - Direction of wind gusts $(u_{g\alpha})$ are split into their x-y components, each interpolated separately using a thin-plate-spline RBF before returned to an angle.
    - Air pressure $(p_a)$ and relative humidity $(r)$ are aggregated from hourly interpolations above.

5. Daily snowmelt $(S_m)$ is first modelled using a [Cold Content Energy Balance Snowpack Model](/interpolants/modelling/waterbudget/snowmeltCCF.html).

5. Save to NetCDF (.nc) for import back to FEWS.

    > `20240701-exportBasinDaily.nc`  $R_f, S_f, S_m, T_n, T_x, u_g, u_{g\alpha}$ daily basins


### Manual corrections

#### Extreme low temperatures

In very few instances, extremely low temperatures are recorded that fall out of range of many empirical functions, such as the [August-Roche-Magnus approximation for Saturation Vapour Pressure](/info/saturationvapourpressure/). Here, temperatures were constrained to a minimum temperature of $-65\text{°C}$.

#### Summer snowfall

During the summer, hail storms monitored by the MSC are recorded as snowfall; for example see [Daily Total Snow for August 2008 at PETERBOROUGH TRENT U (6166455)](https://climate.weather.gc.ca/climate_data/generate_chart_e.html?StationID=5192&timeframe=2&StartYear=1840&EndYear=2024&Day=31&Year=2008&Month=8&type=bar&MeasTypeID=totsnow) where 24.2 cm of snowfall was recorded. 

In this case any snowfall recorded in the months of June--August was assumed to immediately melt and is recorded here as rainfall.





# 6-hourly Precipitation to Basins

The 6-hourly [CaPA-RDPA and CaPA-HRDPA](/interpolants/sources/climate-data-service.html#eccc-regional-deterministic-precipitation-analysis-rdpa) precipitation $(P)$ field is a gridded raster that is routinely scraped of open web resources and proportioned to the sub-watersheds using our ORMGP-FEWS system, using the [Interpolation: SpatialAverage](https://publicwiki.deltares.nl/display/FEWSDOC/InterpolationSpatialAverage) transformation.

6-hourly snowmelts $(S_m)$ rates from [SNODAS](/interpolants/sources/climate-data-service.html#us-national-oceanic-and-atmospheric-administration-noaa) is also a gridded raster that is routinely scraped of open web resources and proportioned to the sub-watersheds using our ORMGP-FEWS system, using the [Interpolation: SpatialAverage](https://publicwiki.deltares.nl/display/FEWSDOC/InterpolationSpatialAverage) transformation. This is used to replace the modelled snowmelt discussed above (when available).


<br>

# Rainfall-Snowfall Parsing
The CaPA-RDPA data are collected in their 6-hourly steps are used on their own and are aggregated to daily __*precipitation*__ accumulations. The precipitation fields are proportioned into rainfall and snowfall amounts using an "optimized critical temperature" approach where precipitation fields are proportioned into rainfall and snowfall amounts. Optimization determines a critical temperature $ (T_\text{crit}) $ for every "[water year](## "defined as a year from October 1 to September 30")", where:

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

An optimization routine is employed to determine $ T_\text{crit} $ such that total snowfall volumes converges with total snowmelt volumes *independently for every winter season and for every sub-watershed* to ensure minimal deviation from *total* precipitation. 


![](fig/2024-Tcrit.png)

*Time series of computed critical temperatures based on snowmelt volumes.*

<br>

# Spatial Interpolation versus DAS

A common question on the *data assimilation systems* (DAS) data employed by the ORMGP is how they compare to interpolated point data. In particular, we have met resistance to the use of [CaPA-RDPA](/interpolants/sources/climate-data-service.html#eccc-regional-deterministic-precipitation-analysis-rdpa) data as it has been known to disagree at times with point observations. But this is an unfair comparison as one should really expect every pixel of the CaPA field to be derived with some uncertainty.

These distributed products at the ORMGP provide an idea of precipitation as it covers our entire 30,000 km² jurisdiction. Comparisons of point stations to these fields fail to take in account the issue of how one should *interpolate* the point stations over space, as is always required prior to hydrologic modelling, for instance.

So, in addition to comparing point stations (which themselves as known to be ±5% in error--Legates and DeLiberty, 1993--and [many don't record trace amounts](https://www.canada.ca/en/environment-climate-change/services/weather-general-tools-resources/frequently-asked-questions.html) less than 0.2 mm per hour), one should also be comparing how a field interpolated for point stations compare with CaPA-RDPA.

Below shows a figure comparing CaPA vs. interpolated station data over the past 10 years of 6-hourly accumulations at time when precipitation was observed by either dataset. Station data are interpolated using the nearest neighbour approach. Both fields are then averaged over the 30,000 km² ORMGP jurisdiction.

It's clear that for the most part, the 2 approaches are in agreement to within ±2 mm per day; 1:1 line shown in red. Major discrepancies (circled red) occur when heavy rainfall events are measured at individual stations and the interpolation scheme over exaggerates the extent of the intense storm, which in southern Ontario tends to be convective (i.e., small extent) in nature. This is the problem we are trying to overcome as it appears that inadequate estimates of spatial distributions can be a greater source of error than the accuracy of any particular CaPA-RDPA pixel.

![](fig/h6-station-vs-rdpa.png)


# **Data Downloads**
Below are the basin-interpolated datasets build from original sources (v.2406):

1. CaSPAr CaPA-RDPA historical precipitation (2002-2024) [`20201001-CaSPAr-CaPA-RDPA_interpBasin.nc`](https://www.dropbox.com/scl/fi/e59j1rg1zzrdinmukqktg/20201001-CaSPAr-CaPA-RDPA_interpBasin.nc?rlkey=m7a0oltegx8mv6ipnr38jd7pe&st=yyjb0wam&dl=1)
1. CaPA-HRDPA recent precititaion (2019-2024) [`20240701-CaPA-HRDPA_interpBasin.nc`](https://www.dropbox.com/scl/fi/bbzw2eno1dwua16rgejpw/20240701-CaPA-HRDPA_interpBasin.nc?rlkey=98k6ovyvfg6d5wc5q3rhbwqmw&st=zrhfkfd4&dl=1)
1. Daily climate stations (1901-2024) [`20240701-exportScalarDaily_interpBasin.nc`](https://www.dropbox.com/scl/fi/7gu757k4op37o3m2l17r7/20240701-exportScalarDaily_interpBasin.nc?rlkey=o2ey2fupmarkpx2v87onau5kd&st=kqlszuvv&dl=1)
1. Hourly climate stations aggregated to 6-hourly timesteps (2001-2024) [`20240701-exportBasin6hourly.nc`](https://www.dropbox.com/scl/fi/evbhj0qu6h36ki3ww3waa/20240701-exportBasin6hourly.nc?rlkey=0adti6aonms0xp6tmb9ea7z0f&st=6i0c84wb&dl=1)
1. SNODAS historic daily snowmelt (2011-2024) [`20240701-exportSNODAShistoricDaily_interpBasin.nc`](https://www.dropbox.com/scl/fi/kdxipzxf82btc05yhwtyt/20240701-exportSNODAShistoricDaily_interpBasin.nc?rlkey=ztuohamsofvqt68knfvuuqi1s&st=ad794233&dl=1)
1. SNODAS recent 6-hourly snowmelt (2020-2024) [`20240701-exportSNODASsixhourly_interpBasin.nc`](https://www.dropbox.com/scl/fi/uw93tvo3sag7cw5wgnwmx/20240701-exportSNODASsixhourly_interpBasin.nc?rlkey=rrdq1qb2ixd3lhh1br89zlfxm&st=cpfvnu95&dl=1)


*NOTES:* 
- *data are indexed according to the sub-watershed polygons: [`PDEM-South-D2013-OWRC23-60-HC-sws10.shp`](https://www.dropbox.com/scl/fi/a0r65kr7i1jirdci6d8jg/PDEM-South-D2013-OWRC23-60-HC-sws10.7z?rlkey=caol95r7k0s9p1re31mlev2a4&dl=1) (compressed using [7-zip](https://www.7-zip.org/)).*
- *NetCDF files can be opened using [Panoply](https://www.giss.nasa.gov/tools/panoply/).*
- *NetCDF files can also be opened [using Python](/interpolants/sources/climate-data-service-python.html).*

<br>

# References

Legates, D.R., DeLiberty, T.L. 1993. Precipitation measurement biases in the United States. – JAWRA Journal of the American Water Resources Association, 29(5), 855–861.

Novák, V., 2012. Evapotranspiration in the Soil-Plant-Atmosphere System. Springer Science+Business Media Dordrecht. 253pp.








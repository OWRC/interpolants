---
title: Spatial interpolation of point data
output: html_document
---



* TOC
{:toc}


# Interpolation of Hourly scalars to Sub-daily Basins
Below is an itemized description of the interpolation process, with open data access.  All interpolated (i.e., "vector") data are automatically updated and maintained using the [ORMGP-FEWS system](/interpolants/fews/) system.

> workflow: `preprocessMSCtoBasinsHourly.xml`


## Meteorological Service of Canada (MSC) scalars
1. Scrape MSC for recent data, executed from FEWS.
1. Import scraped MSC hourly scalars into FEWS.
1. Export hourly MSC NetCDF file (*.nc) from FEWS, from 1989-10-01 
    
    > `_exportMSChourlyNetcdf.nc`  $T_a, p_a, r, \text{vis}, u, u_\alpha$

1. Interpolate to 10km sub-watersheds, using a python script executed from config file `pyMSChourliesToBasin.xml` that executes: `ncMSCtoHourlyBasinNetCDF.py`.
    - Air temperature $(T_a)$, relative humidity $(r)$ and wind speeds $(u)$ are interpolated using a [radial basis function (RBF)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.Rbf.html) (with a cubic kernel and a  smoothing factor $\lambda=1/1000$ to prevent singular matrices).
    - Air/barometric pressure $(p_a)$ are first [corrected for elevation](/interpolants/interpolation/barometry.html) then interpolated using the same cubic RBF. 
    - Wind directions $(u_\alpha)$ are split into their x-y components, each interpolated separately using a cubic RBF before returned to an angle. A sample result is shown below:

![](fig/windir.png)

1. Interpolated $(T_a, r, u)$ are applied to compute potential evaporation flux [m/s] (Novák, 2012):

$$
    E_a=7.46\times 10^{-9} \cdot (a + ub) d_a
$$

$$
    d_a=(1-r) \cdot e_s(T_a)
$$

6. Save to NetCDF (.nc) for import back to FEWS.

    > `_exportMSChourlyNetcdf_interp.nc`  $T_a, p_a, r, u, E_a$ hourly basins




## Hourly Basin to 6-hourly Basin interpolation


1. Hourly aggregation to 6-hourly time intervals (00:00 06:00 12:00 18:00 UTC) is performed in FEWS using the:
    - [MeanToMean aggregation](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+MeanToMean) routine for $Ta, p_a, r, u$, and
    - [Accumulative aggregation](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+Accumulative) routine for $E_a$.

    *__These data have a set expiry.__*

1. Export 6-hourly, basin-interpolated $P_\text{HRDPA}, T_a, p_a, r, u$ to NetCDF. 

    > `yyyyMMddHHmm-6hourlyBasin.nc`

    *__to be altered to__* $P_\text{HRDPA}, P_R, P_S, T_a, p_a, r, u, E_a$



# 6-hourly Precipitation to Basins

The 6-hourly CaPA-RDPA precipitation $(P)$ field is a gridded raster that is routinely scraped of open web resources and proportioned to the sub-watersheds using our ORMGP-FEWS system, using the [Interpolation: SpatialAverage](https://publicwiki.deltares.nl/display/FEWSDOC/InterpolationSpatialAverage) transformation.



# Rainfall-snowfall parsing
The [CaPA-RDPA](/interpolants/sources/climate-data-service.html#eccc-regional-deterministic-precipitation-analysis-rdpa) data are collected in their 6-hourly steps are both used on their own and are aggregated to daily __*precipitation*__ accumulations. The precipitation fields are proportioned into rainfall and snowfall amounts using an "optimized critical temperature" approach where precipitation fields are proportioned into rainfall and snowfall amounts. Optimization determines a critical temperature $ (T_\text{crit}) $ for every ["water year"](## "defined as a year from October 1 to September 30"), where:

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



# Spatial interpolation vs. DAS

A common question on the *data assimilation systems* (DAS) data employed by the ORMGP is how they compare to interpolated point data. In particular, we have met resistance to the use of [CaPA-RDPA](/interpolants/sources/climate-data-service.html#eccc-regional-deterministic-precipitation-analysis-rdpa) data as it has been known to disagree at times with point observations.

*TO COMPLETE*

![](fig/h6-station-vs-rdpa.png)


# References

Novák, V., 2012. Evapotranspiration in the Soil-Plant-Atmosphere System. Springer Science+Business Media Dordrecht. 253pp.








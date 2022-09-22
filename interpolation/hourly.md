---
title: Near Real-time Sub-Daily Climatology
author: M.Marchildon
output: html_document
---

* TOC
{:toc}


# Introduction
The [ORMGP](https://maps.oakridgeswater.ca/) maintains a current, continuous 6-hourly climatology dataset beginning 2001.

## Interpolation or hourly scalars to basins
Scalar data are interpolated to a set of ~10km sub-watersheds, using a python script executed from config file `pyMSChourliesToBasin.xml` that executes: `ncMSCtoHourlyBasinNetCDF.py`.

- Air temperature $(T_a)$, relative humidity $(r)$ and wind speeds $(u)$ are interpolated using a [linear radial basis function (RBF)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.Rbf.html).
- Air/barometric pressure $(P_a)$ are first [corrected for elevation](https://owrc.github.io/interpolants/interpolation/barometry.html) then interpolated using the same linear RBF. 
- Wind directions $(\alpha_u)$ are split into their x-y components, each interpolated separately using a linear RBF before returned to an angle. A sample result is shown below:
![](https://raw.githubusercontent.com/OWRC/interpolants/main/interpolation/calc/rdpa-collection-verification/fig/windir.png)

## Estimate evaporation
Interpolated $(T_a, r, u)$ are applied to compute a [Penman-type aerodynamic evaporation flux](/interpolants/interpolation/calc/panET/PanEvaporation.html) [m/s] (Novák, 2012): 
<!-- page 182 -->

$$
    E_a=7.46\times 10^{-6} \cdot (a+ub) d_a 
$$

$$
    d_a=(1-r) \cdot e_s(T_a)
$$

> Save to NetCDF (.nc) for import back to FEWS. (`_exportMSChourlyNetcdf_interp.nc`) > $T_a, P_A, r, u, E_a$ hourly basins



## Hourly Basin to 6-hourly Basin interpolation


1. Hourly aggregation to 6-hourly time intervals (00:00 06:00 12:00 18:00 UTC) is performed in FEWS using the:
    - [MeanToMean aggregation](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+MeanToMean) routine for $T_A, P_A, r, u$, and
    - [Accumulative aggregation](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+Accumulative) routine for $E_a$.

    *__These data have a set expiry.__*

1. Export 6-hourly, basin-interpolated $P, T_a, P_a, r, u$ to NetCDF (`yyyyMMddHHmm-6hourlyBasin.nc`).

    *__to be altered to__* $Rf, Sm, T_a, r, u, Ea$



# References

Novák, V., 2012. Evapotranspiration in the Soil-Plant-Atmosphere System. Springer Science+Business Media Dordrecht. 253pp.
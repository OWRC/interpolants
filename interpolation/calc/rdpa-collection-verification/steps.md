

# 1. Hourly scalars to Hourly Basin
> workflow: `preprocessMSCtoBasinsHourly.xml`


## MSC scalars
1. Scrape MSC for recent data, executed from FEWS
1. Import scraped MSC hourly scalars into FEWS.
1. Export hourly MSC .nc from FEWS, from 1989-10-01 
    
    `_exportMSChourlyNetcdf.nc` $P, T, r, \text{vis}, u, u_\alpha$

1. Interpolate to 10km sub-watersheds, using a python script executed from config file `pyMSChourliesToBasin.xml` that executes: `ncMSCtoHourlyBasinNetCDF.py`.
    - Air temperature $(T)$, relative humidity $(r)$ and wind speeds $(u)$ are interpolated using a [linear radial basis function (RBF)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.Rbf.html).
    - Air/barometric pressure $(P)$ are first [corrected for elevation](https://owrc.github.io/interpolants/interpolation/barometry.html) then interpolated using the same linear RBF. 
    - Wind directions $(u_\alpha)$ are split into their x-y components, each interpolated separately using a linear RBF before returned to an angle. A sample result is shown below:
    ![](fig/windir.png)

1. Interpolated $(T, r, u)$ are applied to compute potential evaporation flux [m/s]:

$$
    E_a=7.46\times 10^{-9} \cdot au^b d_a
$$

$$
    d_a=(1-r) \cdot e_s(T)
$$

6. Save to NetCDF (.nc) for import back to FEWS. (`_exportMSChourlyNetcdf_interp.nc`) > $T, P, r, u, E_a$ hourly basins



## Hourly Basin to 6-hourly Basin interpolation


1. Hourly aggregation to 6-hourly time intervals (00:00 06:00 12:00 18:00 UTC) is performed in FEWS using the:
    - [MeanToMean aggregation](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+MeanToMean) routine for $T, P, r, u$, and
    - [Accumulative aggregation](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+Accumulative) routine for $E_a$.

    *__These data have a set expiry.__*

1. Export 6-hourly, basin-interpolated $Precip, T, P, r, u$ to NetCDF (`yyyyMMddHHmm-6hourlyBasin.nc`).

    *__to be altered to__* $Rf, Sm, T, r, u, Ea$





# 3. Daily scalars to Daily Basin
## 3a. YCDB daily scalars
> workflow: `preprocessYCDBtoBasinsDaily.xml`

1. Export daily YCDB climate .nc from FEWS, from 1900-10-01
1. Interpolate to 10km sub-watersheds, using a python script executed from FEWS (`ncScalarToDailyBasinNetCDF.py`)
    - Min/max air temperature $(T_n/T_x)$ are interpolated using a [linear radial basis function (RBF)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.Rbf.html).
    - Rainfall $(R)$ and Snowfall $(S)$ interpolated to their nearest neighbour. 

1. Save to NetCDF (.nc) for import back to FEWS. 




## 3b. Daily SNODAS to Basin
1. import SNODAS from web (either web scrape or FTP)

1. interpolate snowmelt $(M)$ to in 10km sub-watersheds FEWS using [InterpolationSpatialAverage](https://publicwiki.deltares.nl/display/FEWSDOC/InterpolationSpatialAverage) (`preprocessBasinSnowmelt.xml`)

## 3c. export all basin-interpolated daily data to NetCDF
- $T_n, T_x, R, S, M$ to NetCDF (`yyyyMMddHHmm-dailyBasin.nc`)





# 4. Parse CaPA to rainfall/snowfall

1. ncgob.go











```python
import pandas as pd

pd.read.csv("")
```

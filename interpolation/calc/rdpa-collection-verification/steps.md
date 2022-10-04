# Interpolated Climate Data

# 1. Hourly scalars to Sub-daily Basins
> workflow: `preprocessMSCtoBasinsHourly.xml`


## MSC scalars
1. Scrape MSC for recent data, executed from [FEWS](https://owrc.github.io/interpolants/interpolation/fews.html).
1. Import scraped MSC hourly scalars into FEWS.
1. Export hourly MSC NetCDF file (*.nc) from FEWS, from 1989-10-01 
    
    > `_exportMSChourlyNetcdf.nc`  $T_a, p_a, r, \text{vis}, u, u_\alpha$

1. Interpolate to 10km sub-watersheds, using a python script executed from config file `pyMSChourliesToBasin.xml` that executes: `ncMSCtoHourlyBasinNetCDF.py`.
    - Air temperature $(T_a)$, relative humidity $(r)$ and wind speeds $(u)$ are interpolated using a [radial basis function (RBF)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.Rbf.html) (with a cubic kernel and a  smoothing factor $\lambda=1/1000$ to prevent singular matrices).
    - Air/barometric pressure $(p_a)$ are first [corrected for elevation](https://owrc.github.io/interpolants/interpolation/barometry.html) then interpolated using the same cubic RBF. 
    - Wind directions $(u_\alpha)$ are split into their x-y components, each interpolated separately using a cubic RBF before returned to an angle. A sample result is shown below:
    ![](fig/windir.png)

1. Interpolated $(T_a, r, u)$ are applied to compute potential evaporation flux [m/s]:

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





# 2. Daily scalars to Daily Basin
## 2a. YCDB daily scalars
> workflow: `preprocessYCDBtoBasinsDaily.xml`

1. Export daily YCDB climate .nc from FEWS, from 1901-10-01
1. Interpolate to 10km sub-watersheds, using a python script executed from FEWS 

    > `ncScalarToDailyBasinNetCDF.py`

    - Min/max air temperature $(T_n/T_x)$ are interpolated using a [cubic radial basis function (RBF)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.Rbf.html).
    - Rainfall $(P_R)$ and Snowfall $(P_S)$ interpolated to their nearest neighbour. 

1. Save to NetCDF (.nc) for import back to FEWS. 

    > `_exportYCDBdaily_interpBasin.nc`  $T_x, T_n, P_R, P_S$ daily basins


## 2b. Daily SNODAS to Basin
1. import SNODAS from web (either web scrape or FTP)

1. interpolate snowmelt $(P_M)$ to in 10km sub-watersheds FEWS using [InterpolationSpatialAverage](https://publicwiki.deltares.nl/display/FEWSDOC/InterpolationSpatialAverage) (`preprocessBasinSnowmelt.xml`)


## 2c. export basin-interpolated daily data to NetCDF
> $T_n, T_x, P_R, P_S, P_M$ to NetCDF (`yyyyMMddHHmm-dailyBasin.nc`)


<br>


# 3. Parse CaPA-RDPA to rainfall/snowfall, snowmelt disaggregation
> `rdpaCritTemperature.go`
1. Optimize $T_c$ (on a 6-hourly time step) such that $\sum P_{S\text{,CaPA}} \to \sum P_{S\text{,daily}}$

    $$
    P_{R\text{,CaPA}}=
    \begin{cases}
    P & T_a > T_c\\
    0 & \text{otherwise}
    \end{cases}
    $$

    $$
    P_{S\text{,CaPA}}=
    \begin{cases}
    P & T_a \leq T_c\\
    0 & \text{otherwise}
    \end{cases}
    $$

> `sixHourlyYield.go`

2. dis-aggregate 24-hour SNODAS snowmelt to 6-hourly time-steps using the following rules:

    1. If any timesteps has temperatures greater than 10°C, snowmelt is equally divided amongst them;
    1. The first time step having 6-hour rainfall $\geq$ 5mm, all melt is assumed to occur during this event;
    1. If any timesteps within 06:00-06:00 UTC has rainfall greater than 1mm, snowmelt is proportionned according to (and added with) rainfall;
    1. If any timesteps has temperatures greater than 0°C, snowmelt is equally divided amongst them; otherwise
    1. Snowmelt is equally divided among the 2 daytime time steps (12:00-00:00 UTC---07:00-19:00 EST).

1. Merge to $P_R$ and $P_M$ to remaining 6-hourly variables $(T_a, p_a, r, u, E_a)$, save to NetCDF (.nc) for import back to FEWS.




```python
import pandas as pd

pd.read.csv("")
```

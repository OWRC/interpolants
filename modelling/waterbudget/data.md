---
title: Long Term Water Budget
subtitle: Data sources, transformations and pre-processing
author: M. Marchildon
output: html_document
---



* TOC
{:toc}




# Data Sources

Meteorological data acquisition, management, aggregation and interpolation was largely accomplished using [Delft-FEWS](https://www.deltares.nl/en/software/flood-forecasting-system-delft-fews-2/) (ver.2019.02 build.39845) a flood forecasting system offered (at no cost, only license agreement) by [Deltares](https://www.deltares.nl/en/). <!-- Configuration files for the Delft-FEWS system build can be found here: BLAH. -->

Forcings data to the model processed by [ORMGP-FEWS](/interpolants/interpolation/fews.html) include:

1. [CaPA-RDPA](https://weather.gc.ca/grib/grib2_RDPA_ps10km_e.html) 10/15km gridded precipitation fields, yielding 6-hourly precipitation totals, acquired from [CaSPAr](https://caspar-data.ca/);
1. [SNODAS](https://nsidc.org/data/g02158) (NOHRSC, 2004) ~1km gridded 24-hour (UTC 06-06) snowmelt totals; and
1. [Meteorological Service of Canada (MSC)](http://climate.weather.gc.ca/historical_data/search_historic_data_e.html) hourly mean temperature and pressure.



# Transformations
**The time step of the model was set to the 6-hourly (sub-daily) time step offered with the CaPA-RDPA data.** 
  - Hourly climatologies were spatially interpolated to the sub-watersheds before being aggregated to the 6-hourly time step.
  - Daily sub-watershed-interpolated snowmelt was disaggregated to the same 6-hourly time step.



## Interpolation (spatial scale)

Both scalar (i.e., point) data and gridded data are then interpolated to each of the [~10 km² sub-watersheds](/interpolants/modelling/waterbudgetmodel.html#sub-basins). Model elevations range from 75-400 masl and orographic effects related to temperature were deemed negligible beyond the spatial distribution meteorological stations.


### Precipitation and Snowmelt
The 6-hourly CaPA-RDPA precipitation $(P)$ and the daily SNODAS snowmelt $(P_M)$ fields are both gridded rasters that are routinely scraped of open web resources and proportioned to the sub-watersheds using the Delft-FEWS transformation [Interpolation: SpatialAverage](https://publicwiki.deltares.nl/display/FEWSDOC/InterpolationSpatialAverage).

### Temperature, Pressure, Humidity and Wind Speed
These hourly datasets offered by the MSC are scalar, in that they are ground measurements taken at station locations. Spatial interpolation includes:

- Air temperature $(T_a)$, relative humidity $(r)$ and wind speeds $(u)$ are interpolated using a [radial basis function (RBF)](https://docs.scipy.org/doc/scipy/reference/generated/scipy.interpolate.Rbf.html) (with a cubic kernel and a  smoothing factor $\lambda=1/1000$ to prevent singular matrices).
- Air/barometric pressure $(p_a)$ are first [corrected for elevation](https://owrc.github.io/interpolants/interpolation/barometry.html) then interpolated using the same cubic RBF. 
- Wind directions $(u_\alpha)$ are split into their x-y components, each interpolated separately using a cubic RBF before returned to an angle.
- Potential evaporation flux [m/s] $(E_a)$ is then computed at every sub-watershed [(described below)](#atmospheric-demand-e_a).

<!-- using interpolated $(T_a, r, u)$: -->

<!-- $$
    E_a=7.46\times 10^{-9} \cdot (a + ub) d_a
$$

$$
    d_a=(1-r) \cdot e_s
$$

$$
    e_s = 610.49 \cdot\exp\frac{17.625 T_a}{T_a+243.04}
$$ -->






## Time step (temporal scale)

The time step of the model has been set to 6 hour steps. All other data sets have been either aggregated or disaggregated to match this temporal scale.

### Hourly to 6-hourly climate

Historical hourly measurements of air temperature, pressure, relative humidity and wind speed were retrieved from the [ECCC website](https://climate.weather.gc.ca/historical_data/search_historic_data_e.html). In total, 46 stations with varying periods of record length and quality were collected.

The hourly time-series interpolated to each sub-watershed was then aggregated to the 6-hourly-UTC time stepping scheme described above. Aggregation of all metrics was accomplished using the Delft-FEWS transformation [Aggregation: MeanToMean](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+MeanToMean) for $T_a$, $p_a$, $r$ and $u$.

The [Accumulative aggregation](https://publicwiki.deltares.nl/display/FEWSDOC/Aggregation+Accumulative) Delft-FEWS transformation was applied for $E_a$


### Sub-daily from daily Snowmelt
Estimates of 24-hour snowmelt accumulation is recovered from the [Snow Data Assimilation System (SNODAS) data product](https://nsidc.org/data/g02158), a (near-)real-time service that returns gridded data at a ~30m resolution. The [NSIDC](https://nsidc.org/) also maintains continuous estimates covering our jurisdiction since September, 2010. [Prior to 2010-09-01, snowmelt estimation computed using a Cold-Content Function (CCF) model.](/interpolants/modelling/waterbudget/snowmeltCCF.html) 

Snowmelt is acquired at a daily timestep that represents the "*total of 24 per hour melt rates, 06:00 UTC-06:00 UTC ... integrated for the previous 24 hours, giving daily totals*" (NOHRSC, 2004), is disaggregated to a 6-hourly time step based on the following rules:

1. If any timesteps has temperatures greater than 10°C, snowmelt is equally divided amongst them;
1. The first time step having 6-hour rainfall $\geq$ 5mm, all melt is assumed to occur during this event;
1. If any timesteps within 06:00-06:00 UTC has rainfall greater than 1mm, snowmelt is proportioned according to (and added with) rainfall;
1. If any timesteps has temperatures greater than 0°C, snowmelt is equally divided amongst them; otherwise
1. Snowmelt is equally divided among the 2 daytime time steps (12:00-00:00 UTC---07:00-19:00 EST).









# Pre-processing





## Atmospheric Demand $(E_a)$


Within the ORMGP, it is evident that vapour deficits offer a great predictor to advective flux (evaporation) when relating pan evaporation to strictly aerodynamic variables, temperature and humidity, simulated at an hourly timestep. When mass transfer occurs over rough surfaces, surface evaporation becomes coupled with advective (vapour deficit) flux through the PBL (Bailey et.al., 1997). So, using the advective term [kg/m²/s] of Penman (1948):

$$
  E_a=\rho_a \frac{\varepsilon}{p_a} d_a \cdot f(u)
$$

where $d_a=(1-r)e_s$ [Pa], $e_s \propto T_a$, the wind-function $f(u)=a+ub$ [m/s], where $u$ is wind speed [m/s], the above equation can be safely reduced to an empirical form (Novák, 2012):

$$
  E_a=7.46\times 10^{-6} \cdot (a+ub) d_a
$$

where $E_a$ is now given in [m/s] for water. 

<!-- This is the power form of open water evaporation $(E_o)$ used by Penman (1948). It is worth noting that this is modified from Penman (1948) in that it is assumed $T_s \approx T_a$, that is the relationship between surface temperature and air temperature is captured by this empirical equation. -->

While considering its simplicity, the Penman advective term performs well against observation. [24,641 data-days from 17 MSC daily pan evaporation stations were gathered for validation](/interpolants/interpolation/calc/panET/PanEvaporation.html). With $u$ [m/s] and $d_a$ [Pa], $a=9.3\times 10^{-3}$ and $b=7.8\times 10^{-4}$ resulted in a globally weighted Nash-Sutcliffe efficiency of 0.41 and 0.90 for daily and monthly pan evaporation estimation, respectively. 

The advantage here is the ability to neglect No need for for the radiative terms used in Penman-Monteith (1965), Priestly-Taylor (1972), Jensen-Haise (1963), etc. A *rare* data set that is hard to interpolate due to the influence of cloud cover; good to avoid.




## Atmospheric Yield $(Y_a)$
A single forcing termed *Atmospheric Yield* $(Y_a)$ is inputted in the model distributed to the 10km sub-watersheds.

$$
  Y_a = P_R+P_M
$$

### Rainfall $(P_R)$

The data collected include total precipitation $(P)$ and snowmelt $(P_M)$. Summing the two together would double count precipitation fallen as snow; the model, however does not account for snow, rather it relies on snowmelt as an input forcing. Precipitation is parsed into rainfall $(P_M)$ and snowfall $(P_S)$ on the basis of a critical temperature $(T_c)$:

$$
P_R=
\begin{cases}
P, & T_a>T_c\\
0 & \text{otherwise},
\end{cases}
$$

$$
P_S=
\begin{cases}
P, & T_a\leq T_c\\
0 & \text{otherwise}.
\end{cases}
$$

[An optimization routine is employed to determine $T_c$](/interpolants/interpolation/calc/rdpa-criticalTemperature/rdpa-criticalTemperature.html) such that annual average snowfall is equal to annual average snowmelt to ensure minimal deviation from total precipitation. 

### Snowmelt $(P_M)$
Snowmelt, is acquired at a daily timestep and is [disaggregated to the 6-hourly timestep](/interpolants/modelling/waterbudget/data.html#sub-daily-from-daily-snowmelt) at the same 6-hourly interval as the CaPA-RDPA precipitation data $(P)$.





# Conclusion and Source Data

The workflow described above produced a 20-year, 6-hourly time series dataset for 2,813 10km² sub-watersheds. [`202009301800-sixHourlyFinal.nc`](https://www.dropbox.com/s/jsjqzj1mvl479pt/202009301800-sixHourlyFinal.nc?dl=1)



# References

Bailey W.G., Oke T.R., Rouse W.R., 1997. The Surface Climates of Canada. ed. W.G. Bailey, Timothy R. Oke, and Wayne R. Rouse. McGill-Queen's University Press.

Monteith, J.L., 1965. Evaporation and environment. Symposia of the Society for Experimental Biology 19: 205—224.

National Operational Hydrologic Remote Sensing Center. 2004. Snow Data Assimilation System (SNODAS) Data Products at NSIDC, Version 1. [Indicate subset used]. Boulder, Colorado USA. NSIDC: National Snow and Ice Data Center. doi: https://doi.org/10.7265/N5TB14TC. [Date Accessed]

Novák, V., 2012. Evapotranspiration in the Soil-Plant-Atmosphere System. Springer Science+Business Media Dordrecht. 253pp.

Oke, T.R., 1987. Boundary Layer Climates, 2nd ed. London: Methuen, Inc.

Penman, H.L., 1948. Natural evaporation from open water, bare soil and grass. Proceedings of the Royal Society of London. Series A, Mathematical and Physical Sciences 193(1032): 120-145.

Priestley, C.H.B. and R.J. Taylor, 1972. On the Assessment of Surface Heat Flux and Evaporation Using Large-Scale Parameters.  Monthly Weather Review 100. pg. 81-92.
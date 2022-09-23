---
title: Critical Temperature
author: M.Marchildon
output: html_document
---

# Critical Temperature $(T_c)$ optimization

Precipitation data can come in the form of just that: "precipitation", without information of whether it's in the snow/solid or rain/liquid form.

A simple solution would be to determine a "critical" temperature $(T_c)$ from which precipitation falls either as snow or rain. 

$$
\text{Rainfall}=
\begin{cases}
\text{Precipitation}, & T_a>T_c\\
0 & \text{otherwise},
\end{cases}
$$

$$
\text{Snowfall}=
\begin{cases}
\text{Precipitation}, & T_a\leq T_c\\
0 & \text{otherwise}.
\end{cases}
$$


$T_a$ is air temperature measured at land surface and is assumed to have some relationship with the temperature of the surface boundary layer. Here, it is discussed how an optimal $T_c$ is determined for every [ORMGP subwatershed](interpolants/interpolation/subwatershed.html).

# Data Collected
## Precipitation
- Composite [CaPA-RPDA](https://weather.gc.ca/grib/grib2_RDPA_ps10km_e.html) 6-hourly precipitation accumulation distributed at 10-15km grids are interpolated to [2,183 10km² sub-watersheds](interpolants/interpolation/subwatershed.html). 
- Exported `202009301300-CaPA-RDPA.nc` from [ORMGP-FEWS](interpolants/interpolation/fews.html):

```   
float precipitation_amount(time=27392, stations=2813);
  :long_name = "precipitation_amount";
  :units = "mm";
  :_FillValue = -9999.0f; // float
  :coordinates = "lat lon";

Period of record: 
  start date: 2001-12-31 19:00:00 -0500 EST
  end date: 2020-09-30 14:00:00 -0400 EDT
  (6-hourly)
```

## Sub-daily $T_a, P_a, r, u, \alpha_u, E_a$ 
- 6-hourly, basin-interpolated climatologies from [hourly scalar MSC stations](interpolants/interpolation/hourly.html).
- Atmospheric Demand $E_a$ is [modelled hourly](interpolants/modelling/waterbudget/data.html#atmospheric-demand-e_a) at each basin, aggregated to the 6-hour timestep.
- Following [ORMGP-FEWS](interpolants/interpolation/fews.html) workflow: `preprocessMSCtoBasinsHourly.xml`, exported `asdfasdfasdf.nc`:

```
asdf
```


### Daily $T_x, T_n, P_R, P_S, P_M$
- Daily, basin-interpolated climatologies from [daily scalar stations](interpolants/interpolation/daily.html).
- Following [ORMGP-FEWS](interpolants/interpolation/fews.html) workflow: `preprocessYCDBtoBasinsDaily.xml`, exported `202009301300-dailyBasin.nc`:

```
float max_air_temperature(time=6830, stations=2813);
  :long_name = "max_air_temperature";
  :units = "degree_Celsius";
  :_FillValue = -9999.0f; // float
  :coordinates = "lat lon";

float min_air_temperature(time=6830, stations=2813);
  :long_name = "min_air_temperature";
  :units = "degree_Celsius";
  :_FillValue = -9999.0f; // float
  :coordinates = "lat lon";

float rainfall_amount(time=6830, stations=2813);
  :long_name = "rainfall_amount";
  :units = "mm";
  :_FillValue = -9999.0f; // float
  :coordinates = "lat lon";

float snowfall_amount(time=6830, stations=2813);
  :long_name = "snowfall_amount";
  :units = "mm";
  :_FillValue = -9999.0f; // float
  :coordinates = "lat lon";

float surface_snow_melt_amount(time=6830, stations=2813);
  :long_name = "surface_snow_melt_amount";
  :units = "mm/d";
  :_FillValue = -9999.0f; // float
  :coordinates = "lat lon";

Period of record: 
  start date: 2002-01-20 05:00:00 UTC
  end date: 2020-10-01T05:00:00 UTC
  (daily)
``` 
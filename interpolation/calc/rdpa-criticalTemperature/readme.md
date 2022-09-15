# Critical Temperature $(T_c)$ optimization

## Data Collected
### Precipitation
- Composite CaPA-RPDA 6-hourly precipitation accumulation distributed at 10-15km grids are interpolated to [2,183 10km² sub-watersheds](https://owrc.github.io/interpolants/interpolation/subwatershed.html). 
- Exported `202009301300-CaPA-RDPA.nc` from [ORMGP-FEWS](https://owrc.github.io/interpolants/interpolation/fews.html):

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

### Sub-daily $T_a, P_a, r, u, \alpha_u, E_a$ 
- 6-hourly, basin-interpolated climatologies from [hourly scalar MSC stations](https://owrc.github.io/interpolants/interpolation/hourly.html).
- Following [ORMGP-FEWS](https://owrc.github.io/interpolants/interpolation/fews.html) workflow: `preprocessMSCtoBasinsHourly.xml`, exported `asdfasdfasdf.nc`:

```
asdf
```


### Daily $T_x, T_n, P_R, P_S, P_M$
- Daily, basin-interpolated climatologies from [daily scalar stations](https://owrc.github.io/interpolants/interpolation/daily.html).
- Following [ORMGP-FEWS](https://owrc.github.io/interpolants/interpolation/fews.html) workflow: `preprocessYCDBtoBasinsDaily.xml`, exported `202009301300-dailyBasin.nc`:

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
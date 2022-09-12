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

### $T_a, P_a, r, u, \alpha_u, E_a$ 
- 6-hourly, basin-interpolated climatologies from [hourly scalar MSC stations](https://owrc.github.io/interpolants/interpolation/hourly.html)
- Following [ORMGP-FEWS](https://owrc.github.io/interpolants/interpolation/fews.html) workflow: `preprocessMSCtoBasinsHourly.xml`, exported `asdfasdfasdf.nc`:

```
asdf
```
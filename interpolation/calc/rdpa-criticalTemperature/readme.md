# Interpolated Climate Data

# 1. Hourly scalars to Sub-daily Basins
> workflow: `preprocessMSCtoBasinsHourly.xml`


## MSC scalars
1. Scrape MSC for recent data, executed from [FEWS](https://owrc.github.io/interpolants/fews/).
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


# 3. Parse CaPA-RDPA to rainfall/snowfall
> `precipCritTemperature.go`
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

```go
import (
	"fmt"
	"math"
	"time"

	"github.com/maseology/glbopt"
	"github.com/maseology/mmaths"
)

type TcResult struct{ Tc, Diff, Psum, Msum float64 }

func Parse(tims []time.Time, waterYearMelt map[int]float64, p, t []float64, sid int) (r, s []float64, tcr map[int]TcResult) { // [staID][timeID]

	// collect annual (wateryear) sums
	psum, cnt := make(map[int]float64, len(waterYearMelt)), make(map[int]int)
	wyp, wyt := make(map[int][]float64, len(waterYearMelt)), make(map[int][]float64, len(waterYearMelt))
	for j, dt := range tims {
		wy := mmaths.Wateryear(dt)
		if _, ok := wyp[wy]; !ok {
			psum[wy] = 0.
			if _, ok := waterYearMelt[wy]; !ok {
				panic("Parse() error 1")
			}
			cnt[wy] = 0
			wyp[wy] = make([]float64, 0, 366)
			wyt[wy] = make([]float64, 0, 366)
		}

		if p[j] >= 0. {
			if p[j] > 0. {
				psum[wy] += p[j]
			}
			cnt[wy] += 1
			wyp[wy] = append(wyp[wy], p[j])
			wyt[wy] = append(wyt[wy], t[j])
		}
	}

	optimize := func(p, t []float64, obs float64) (float64, float64) {
		trans := func(u float64) float64 {
			return mmaths.LinearTransform(-20., 20., u)
		}

		eval := func(u []float64) float64 {
			tc, ss := trans(u[0]), 0.
			for i, pp := range p {
				if pp < -100. || t[i] < -100. {
					continue
				}
				if t[i] <= tc {
					ss += pp
				}
			}
			return math.Abs(ss - obs)
		}

		uFib, yFib := glbopt.Fibonacci(eval)
		tc := trans(uFib)
		return tc, yFib
	}

	dtc, stc, ctc := make(map[int]float64, len(waterYearMelt)), 0., 0.
	wynow := mmaths.Wateryear(time.Now())
	tcr = make(map[int]TcResult, len(waterYearMelt))
	const thrsh = 90
	for wy := range waterYearMelt {
		if wy < wynow {
			if cnt[wy] > thrsh {
				tc, diff := optimize(wyp[wy], wyt[wy], waterYearMelt[wy])
				stc += tc
				ctc++
				dtc[wy] = tc
				// fmt.Println("  ", wy, tc, diff, psum[wy], waterYearMelt[wy])
				tcr[wy] = TcResult{tc, diff, psum[wy], waterYearMelt[wy]}
			}
		} else {
			dtc[wy] = dtc[wy-1] // current corrections are based on the previous year
		}
	}
	for wy := range waterYearMelt {
		if _, ok := dtc[wy]; !ok {
			fmt.Printf("%d is a season with little data (<%d at %d). Mean Tc of the entire data set has been used\n", wy, thrsh, sid)
			dtc[wy] = stc / ctc // for seasons with little data, use mean of entire data set
		}
	}

	orf, osf := make([]float64, len(tims)), make([]float64, len(tims))
	for j, dt := range tims {
		wy := mmaths.Wateryear(dt)
		if t[j] > dtc[wy] {
			orf[j] = p[j]
		} else {
			osf[j] = p[j]
		}
	}

	return orf, osf, tcr
}
```

2. Save $P_R$, $P_S$ and $P_M$ to remaining 6-hourly variables $T_a, p_a, r, u, E_a$, save to a set of binary (*.bin) files. Will be converted to $Y_a$ and $E_a$ for model input forcings.

# 4. Snowmelt disaggregation
> `sixHourlyMelt() in snowmelt6hourly.go`

1. dis-aggregate 24-hour SNODAS snowmelt to 6-hourly time-steps using the following rules:

    1. If any timesteps has temperatures greater than 10°C, snowmelt is equally divided amongst them;
    1. The first time step having 6-hour rainfall $\geq$ 5mm, all melt is assumed to occur during this event;
    1. If any timesteps within 06:00-06:00 UTC has rainfall greater than 1mm, snowmelt is proportioned according to (and added with) rainfall;
    1. If any timesteps has temperatures greater than 0°C, snowmelt is equally divided amongst them; otherwise
    1. Snowmelt is equally divided among the 2 daytime time steps (12:00-00:00 UTC---07:00-19:00 EST).

1. $P_M$ to remaining 6-hourly variables $T_a, p_a, r, u, E_a, P_R, P_S$, save to a set of .bin files. Will be converted to $Y_a$ and $E_a$ for model input forcings.

1. Using `readGolang.py` convert .bin's to NetCDF `(202009301800-sixHourlyFinal.nc)` for import back to FEWS.

	```python
	import numpy as np
	import pandas as pd
	from pymmio import files
	from netCDF4 import Dataset, date2num


	idir = "E:/Sync/@dev/go/src/FEWS/precipCritTemperature/bins"


	# time
	tims = np.fromfile(idir+"/time.bin", dtype=np.int64) * 1000000000
	tims = tims.astype('datetime64[ns]') # np.datetime64) #
	def tstr(t): return pd.to_datetime(str(t)).strftime('%Y-%m-%d %H:%M:%S')
	def getTimesteps(ts):
		tu = []
		for t in ts: 
			t2 = pd.to_datetime(tstr(t))
			tu.append(t2)
		return np.unique(tu)
	tims = getTimesteps(tims)
	nts = len(tims)




	#station
	sids = np.fromfile(idir+"/station_id.bin", dtype=np.int32)
	nsta = len(sids)

	# variables
	acoll = {}
	for fp in files.dirList(idir,"bin"):
		pnam = files.getFileName(fp)
		if pnam=="time" or pnam=="station_id": continue
		if "Daily" in pnam: continue
		print(pnam)
		aa = np.fromfile(fp, dtype=np.float64).reshape((nsta,nts))
		aa[aa<-998] = np.nan
		acoll[pnam] = aa
		



	print("creating NetCDF..")
	t0 = 2
	units = {"rainfall_amount":"mm",
			"snowfall_amount":"mm", 
			"air_temperature":"oC", 
			"air_pressure":"Pa", 
			"relative_humidity":"-", 
			"wind_speed":"m/s", 
			"water_potential_evaporation_amount":"mm", 
			"surface_snow_melt_amount":"mm"}  # these are CF standard names
	# https://unidata.github.io/python-training/workshop/Bonus/netcdf-writing/
	with Dataset(idir+"/"+max(tims).strftime("%Y%m%d%H%M")+"-sixHourlyFinal.nc",mode='w',format='NETCDF4') as ncfile: # a container for dimensions, variables, and attributes.

		ncfile.title = "ORMGP 6-hourly climatology field (final)"
		ncfile.subtitle = "built using readGolang.py after rdpaCritTemperature.go"
		ncfile.Conventions = 'CF-1.8'

		# create dimensions
		ncfile.createDimension('time', nts-t0)
		ncfile.createDimension('stations', nsta)
		ncfile.createDimension('char_leng_id', 64)

		# sid = ncfile.createVariable('station_id', np.int32, ('stations'))
		sid = ncfile.createVariable('station_id', 'S1', ('stations','char_leng_id'))
		sid.long_name = 'station identification code'
		sid.cf_role = 'timeseries_id'
		ss = [ list(str(k)) + ['\00']*(64-len(str(k))) for k in sids ] # pad with ascii NULs
		ss = np.array(ss, dtype='S1').reshape((nsta,64))
		sid[:,:] = ss

		# lat = ncfile.createVariable('lat', np.float32, ('stations'))
		# lat.units = 'degrees_north'
		# lat.long_name = 'latitude'
		# lat[:] = yi
		# lon = ncfile.createVariable('lon', np.float32, ('stations'))
		# lon.units = 'degrees_east'
		# lon.long_name = 'longitude'
		# lon[:] = xi

		nctim = ncfile.createVariable('time', np.float64, ('time',))
		nctim.units = 'minutes since 1969-12-31 19:00:00.0 -0500' #'hours since 1800-01-01'
		nctim.long_name = 'time'
		nctim[:] = date2num(tims[t0:], nctim.units)

		# Define 2D variablea to hold data

		for pnam, a in acoll.items():
			ncvar = ncfile.createVariable(pnam,np.float32,('time','stations')) # note: unlimited dimension is leftmost
			ncvar.units = units[pnam]
			ncvar.standard_name = pnam
			ncvar[:,:] = np.array(a, dtype=np.float32).T[t0:]
	```

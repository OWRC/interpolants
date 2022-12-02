---
title: Long Term Water Budget
subtitle: A regionally-distributed runoff-recharge model
author: M. Marchildon
output: html_document
---


A regionally-distributed runoff/recharge model has been developed to simulate hydrologic processes at a fine (grid-based) scale. The model code is written to support large-scale and high-resolution distributed processed optimized for implementation on parallel computer architectures. No process of the model is in any way novel, rather a suite of existing model structures have been combined into one platform chosen specifically for their ease of implementation, practical applicability and computational efficiency and scalability.

The model's primary intention is to project land surface moisture distribution for the purposes of estimating regional groundwater recharge. It utilizes hydrological model procedures that are amenable to local data availability. While the model can simulate stream flow discharge and overland runoff at any point in space, the model is not intended for rainfall runoff modelling; outputs from this model will be used to constrain regional groundwater models within the 30,000km² Oak Ridges Moraine Groundwater Program jurisdiction of southern Ontario. That said, mean daily streamflow remains the primary calibration target.

This model is currently in beta mode, and its use for practical application should proceed with caution. Users should be aware that model results posted online will always be subject to change. Ultimately, the intent of this model is to produced ranges of long-term (monthly average) water budget metrics (precipitation, runoff, evaporation, recharge, moisture state, etc.) as a hydrological reference for the [partners of the ORMGP](https://www.oakridgeswater.ca/). It maintains as a real-time reference, [updated by ORMGP servers.](/interpolants/#servers)

The model is physically based in that mass is conserved and processes are not constrained to any particular timestep. The model conceptualization has maintained parameters that speaks to the common physical hydrology lexicon, with parameters such as percent impervious, conductivity of surficial soils, etc. The model is a hydrological model integrated with a TOPMODEL groundwater system. The source code is [open and free to use](https://github.com/maseology/rdrr). Below is the description of the model procedures that have been codified.


* TOC
{:toc}



# Executive Summary

- Integrated groundwater surface water numerical model
- Built for fast computation
- simulates evaporation, runoff, infiltration, watertable elevations, groundwater recharge occurring after a rainfall and/or snowmelt event.
- model run from the hydrological water year 2002 (2001-10-01) through water year 2020. 
- Precipitation was collected from [CaPA-RDPA](https://eccc-msc.github.io/open-data/msc-data/nwp_hrdpa/readme_hrdpa_en/)
- Snowmelt was collected from [SNODAS](https://nsidc.org/data/g02158/versions/1)
- $T_a$, $r$, $u$ from MSC
- Potential evaporation $(E_a)$ determined using the [empirical wind functions of Penman (1948)](/interpolants/modelling/waterbudget/data.html#atmospheric-demand-e_a)
- 12.1M x 50x50 m cells x 6-hourly ts x 20 years
- use of regional climate fields (model inputs—precipitation, temperature, snowmelt, etc.)
- explicit soil moisture accounting scheme
- cold content energy balance snowpack model when SNODAS was unavailable (pre-2010)
- distribution function-based shallow groundwater model with groundwater feedback mechanisms following TOPMODEL
- a cascade overland flow routing
<!-- - a one-dimensional first-order kinematic overland flow module	 -->
The following is a description of the water budget tool located on our website, hereinafter referred to as the "*model*".








# Theory


* **[Shallow groundwater](/interpolants/modelling/waterbudget/gw.html)**

    $$ \zeta=\ln\frac{a}{T_o\tan\beta} $$

* **[Soil moisture accounting](/interpolants/modelling/waterbudget/sma.html)**

    $$ \Delta S=P-E-R-G $$

* **[Overland flow routing](/interpolants/modelling/waterbudget/overlandflow.html)**

    $$ F_\text{casc}=1-\exp(\frac{\beta}{-\alpha}) $$






# Input Data



In an attempt to make most of computational efficiency, many processes that are typically computed as part of a hydrological model have been pre-built as input to the ORMGP water balance model.  Processes such as snowmelt and potential evapotranspiration can modelled independently of the rainfall-runoff-recharge process and thus much computational gains can be made if these processes are pre-determined.

> A top-down approach

The model considers the greater role the atmosphere has on its ORMGP region. The *Planetary Boundary Layer* (Oke, 1987) is conceptualized as the barrier from which mass must transfer when surface evaporation is captured by the atmosphere and when liquid water originating from the atmosphere is released onto the land surface. 

The model input (i.e., "climate forcing") data are provided on a 6-hourly timestep. These data have been distributed to [some 3,000 10km² sub-watersheds](https://owrc.github.io/interpolants/interpolation/subwatershed.html). They reflect the sources and sinks, respectively, of liquid (read: mobile) water on the land surface.

The aim of the model design is to simultaneously reduce the amount of computational processes and leverage near-realtime data assimilation products. It is recognized from a hydrological model design perspective, that the primary driver of watershed moisture distribution is the *"Atmospheric Yield"*, that is water sourced from the atmosphere in its liquid/mobile form.

$$\text{Atmospheric Yield} = \text{Rainfall} + \text{Snowmelt}$$

Similarity, the "atmosphere" (specifically the Planetary Boundary Layer---Oke, 1987) also has a drying power, a sink termed *"Atmospheric Demand"*. 

It is matter of perspective that dictates the terminology here. The model was designed from a top-down viewpoint. Terms like "potential evaporation", which speaks to the evaporation occurring on a surface with unlimited water supply is instead termed "atmospheric demand", that is the capacity for the PBL to remove moisture from a rough land surface.

Only snowmelt, rainfall and evaporation are not readily available in a distributed form and need to be determined. The model is integrated with [the ORMGP data management platform](/interpolants/). Below is an interactive map of the climate forcing distribution used in the model from the top-down perspective. Total model coverage ~30,000km².



<iframe src="https://golang.oakridgeswater.ca/pages/swsmet.html" target="_blank" width="100%" height="400" scrolling="no" allowfullscreen></iframe>


Finally, the model was designed to remain amenable to data availability and new technologies; for instance, [SNODAS](https://nsidc.org/data/g02158) can avoid the need to model snowmelt explicitly and leverage these online resources.


* **[Data sources, transformations and pre-processing](/interpolants/modelling/waterbudget/data.html)**
    * **[Atmospheric Demand $(E_a)$](/interpolants/modelling/waterbudget/data.html#atmospheric-demand-e_a)** is the "drying power" of the near-surface atmosphere, also known as the Planetary Boundary Layer (PBL­­­­-­­­Oke, 1987); and
    * **[Atmospheric Yield $(Y_a)$](/interpolants/modelling/waterbudget/data.html#atmospheric-yield-y_a)** is water in its liquid form released either as rainfall or snowmelt onto the land surface.
    <!-- * **[Snowmelt $(P_M)$](/interpolants/modelling/waterbudget/data.html#sub-daily-from-daily-snowmelt)** -->



[*see glossary*](glossary.html)









# Physical Constraints

### Digital Elevation Model

The Greater Toronto Area 2002 DEM (OMNRF, 2015) was re-sampled to the model's 50x50m grid cell resolution. Surface depressions were removed using Wang and Liu (2006) and flat regions were corrected using Martz (1997).

Drainage directions and flow-paths of the now "hydrologically correct" DEM were were assigned based on the direction of steepest decent (D8).Cell gradients ($b$) and slope aspects were calculated based on a 9-cell planar interpolation routine. The unit contributing area $a=A/w$ topographic wetness index $ln\frac{a}{\tan b}$ (Beven and Kirkby, 1979--CHECK) were computed for every cell.

### Sub-basins

The 30,000 km² model area has been sub divided into 2,813 approximately 10 km² sub-basins. Within these sub-basins:
1. Meteorological forcings from external sources are aggregated applied uniformly within the sub-basin (via a pre-processing routine); and
1. Local shallow water response is assumed to act uniformly (the shallow subsurface catchment area).


<iframe src="https://golang.oakridgeswater.ca/pages/sws-characterization.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>

<br>

### Land use and Surficial geology

- Southern Ontario Land Resource Information System (SOLRIS) Version 3.0 Landuse
- OGS (2010) Surficial geology of southern Ontario


[*read more*](/interpolants/interpolation/landuse.html)


# Model Structure

## Terminology

### Computational Elements
Model grids in the model represent a homogenized area on the land surface, similar to the concept of a Hydrologic Response Unit, or HRU. The term HRU will be avoided here as the concept itself is not well defined and the term *"computational element"* (CE) will be used herein to avoid ambiguity. All processes within the computational element are assumed to be zero-dimensional, that is processes are modelled at the point-scale, which effectively represents the "average" condition within the grid cell. The spatial proximity of each computational element is maintained, meaning that runoff occurring from an up-gradient CE will runon to an adjacent down-gradient CE, thus preserving the spatial distribution of land surface moisture.

### Model Domain
The overarching model code employs an object called the "Model Domain". Here, all necessary model data are digitized and self-contained, including:

1. Structure (`STRC`): Hold all the geometrical and topological constraints to grid cells, including the physical dimensions of cells and knowledge of where runoff is to be routed.
1. Mapper (`MAPR`): Parameter collections for a set of [land-surface and groundwater reservoir types](/interpolants/interpolation/landuse.html). Also contains a *cell-to-type* cross-reference map to distribute model parameters, such as percolation rates, soil zone depth, depression storage, etc. The Mapper *projects* parameter selection onto the grid space domain based on their local (an often unique) land type.
1. Forcings (`FORC`): Input (variable) data, generally climate forcings: $Y_a$ and $E_a$.
1. Router (`RTR`): *not used currently* Provides the model with optimal order of processing, ensuring a down stream process.




<!-- ## Runoff

Runoff is conceptualized as being generated through the saturation excess (Dunne, 1975 CHECK) mechanism. Land area that has the capacity to retain water (through interception, soil retention, depression/rill storage, etc.) must be satisfied. The saturation excess mechanism is dependent on topography and it's interaction with the groundwater system; thus the model is distributed (cell-based) and has an integrated (albeit conceptual) groundwater system.

Surface water-groundwater integration is viewed from the hydrologists' perspective: areas where is the groundwater system limiting infiltration (shallow groundwater table) and even contributing to overland runoff (springs/seepage areas). As a model output, this can be quantified as a net groundwater exchange field (groundwater recharge and discharge)

The basis of the model is that topography is paramount to the lateral movement of water yielding runoff. The model is deemed regional, in that it covers a large areal extent, yet is kept to a fine resolution to ensure that observed geomorphic flow patterns are represented in the model. -->


## Time-stepping

The model runs using a variable time stepping approach. The soil moisture accounting portion of the model runs on a 6-hourly basis in order to capture hydrological dependence on the diurnal fluctuation of energy flux at the ground surface, and the local inertial approximation SWE simulation time step varies to a maximum of 6-hours based on its computational requirements.

The time step of the model has been set to 6 hour steps on 00:00 UTC, yielding the local time steps of 01:00, 07:00, 13:00, and 19:00 EST. This step is chosen as it matches the received precipitation dataset described below.















# Parameterization

The model's structure is defined rather simply by at least 5 raster data sets. The model's input data pre-processor will generate additional information based on these data:

1. digital elevation model
1. land use index (with parameter lookup table)
1. surficial geology index (with parameter lookup table)
1. groundwater system index

Being a distributed model, the procedures applied at the cell scale are quite parsimonious. There is no separate treatment of interception, depression storage, nor soil water retention, rather it is assumed that these processes respond to environmental factors (e.g., evaporation) in parallel and thus can be treated in bulk.

From the top down perspective, viewing some 12.1 million 50x50m cells covering 30,000 km², it seems rather overcomplicated (possibly frivolous) to account water any more than to total mass present at any particular location.


#### pre-defined parameters

The following are determined using a topographical analysis, and are thus are data-driven:

- $\tan\beta$: slope angle of a model grid cell [rad]
- $\delta D_i$: relative saturation ([see more](/interpolants/modelling/waterbudget/gw.html)) [m]
- $f_\text{casc}$: cascade fractions are based on a pre-determined relationship with local gradients [-]


#### globally applied parameters

Cells with a contributing area greater than 1 km² are deemed "stream cells" in which additional sources include groundwater discharge to streams.

- $D_\text{inc}$: depth of incised channel relative to cell elevation [m] (note, while it is possible to assign this parameter on a cell basis, it was treated here as a global "tuning" parameter.) [m]
- $\Omega$: channel sinuosity [-]
- $\alpha$: scaling parameter for determining $F_\text{casc}$


#### Regional groundwater parameters

Groundwater processes in the model are conceptualized at the sub-basin scale and so much of the groundwater parameterization is implemented here.

- $m$: TOPMODEL groundwater scaling factor [m]

#### Land use based parameters

Each cell is classified according to (i) surficial geology and (ii) land use mapping where each class is parameterized independently. "Look-up tables" are used to distribute model parameters according to their classification.


- $F_\text{imp}$: fraction of impervious cover
- $F_\text{can}$: fraction of canopy cover


The following are used to compute the overall retention/storage capacity:
- $\phi$: porosity [-]
- $F_c$: field capacity [-]
- $d_\text{ext}$: extinction depth of soil, where evapotranspiration cease to occur. [m]

<!-- - retention/storage capacity -->
<!-- - depression storage -->

#### Surficial geology based

- $K_\text{sat}$: hydraulic conductivity as saturation (i.e., percolation rates) [m/s]



# Model Variables

One goal set for the model design was to leverage contemporary gridded data sets available from a variety of open and public sources. Products known as "*data re-analysis products*" or "*data-assimilation products*" attempt to merge meteorological information from a variety of sources, whether they be ground (station) measurements, remote sensing observations (e.g., radar, satellite, etc.), and archived near-cast weather model outputs.  When combined, the gridded data resemble the spatial distribution of meteorological forcings unlike what can be accomplished through standard interpolation practices using point measurements (e.g., thiessen polygons, inverse distance weighting, etc.).

An advantage to the data-assimilation products is that it removes the modeller from needing to model certain processes explicitly. Here, for example, the model does not account for a snowpack, rather inputs to the model include snowmelt derived from SNODAS.

The extent of the model combined with the resolution of the processes simulated lends itself best viewed from a top-down perspective (REF). This allows for model simplification by which many of the layered water stores (i.e., interception, depression, soil, etc.) may be handled procedurally as one unit. Viewing the model domain in it's 30,000 km² extents,one can imagine how difficult it would be to discern any vertical detail.








# Calibration
* **[Model Parameters and Sampling](/interpolants/modelling/waterbudget/parameters.html)**



# Code
* **[Model Structure](/interpolants/modelling/waterbudget/structure.html)**


# Future plans
* **[Future plans](/interpolants/modelling/waterbudget/future.html)**



# Glossary

- masl - metres above sea level

- ECCC - Environment Canada and Climate Change

- atmospheric yield $(Y_a)$: term used to describe water (in liquid form) that is actively altering the hydrological state at a particular location.


# References

Oke, T.R., 1987. Boundary Layer Climates, 2nd ed. London: Methuen, Inc.
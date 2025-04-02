---
title: Sub-watershed Characterization
author: Oak Ridges Moraine Groundwater Program
output: html_document
---




The 4 million-hectare extended ORMGP jurisdiction has been divided into thousands of approximately 10 km² sub-watersheds, which serve as the foundation for hydrometeorological data analysis. These sub-watersheds were defined automatically using the [hydrogically corrected DEM](https://owrc.github.io/interpolants/interpolation/overland.html).

Each sub-watershed is assigned a specific topological order, enabling easy mapping from headwater sub-watersheds to their downstream counterparts, ultimately draining into the Great Lakes. The goal is to treat these sub-watersheds as a "logical unit" for climatological and water budget analyses. Below is an overview of how the v.2025 OWRC 10 km² sub-watershed map and its derivatives were developed.

<br>

`click on a sub-watershed:`

<iframe src="https://owrc.shinyapps.io/sws23/" width="100%" height="500" scrolling="no" allowfullscreen></iframe>

[*open in to view in separate tab*](https://owrc.shinyapps.io/sws23/)

<br>



### Build v.2025

Corrections made to the Hamilton harbour area. The ORMGP region is now portioned into 4,231 ~10km² sub-watersheds.


### Build v.2023

The sub-watershed delineation has expanded to include the entire Canadian Lake Ontario shoreline. The ORMGP region is now portioned into 4,238 ~10km² sub-watersheds.

### Build v.2020

The Provincial Digital Elevation Model (DEM) has been processed into a "hydrologically-correct" digital elevation model of the ORMGP area ground surface. From this information, the ORMGP region is portioned into 2,813 ~10km² sub-watersheds. 



<!-- ### Data -->

<!-- current build may be found [here](https://www.dropbox.com/s/ro16gg6zi4kqbc0/owrc20-50a_SWS10-final.geojson?dl=1) -->



# Derivatives

The hydrologically-corrected digital elevation model (HDEM) is further process to derive a number of metrics aggregated at the sub-watershed scale. An overlay analysis was performed to characterize the sub-watersheds using, for instance, [ORMGP land use mapping](/interpolants/interpolation/landuse.html), to aggregate statistics at the sub-watershed scale, including:

- impervious area
- canopy coverage
- water body coverage
- wetland coverage
- relative permeability/infiltrability
- mean slope and dominant aspect

__Other tools relying on the HDEM:__

- a catchment area delineation tool
- an interpolated real-time daily meteorological dataset dating back to the year 1900
<!-- - mean depth to water table. -->



# Product

The larger ORMGP jurisdiction has been divided into over 4,000 sub-watersheds, each covering 10 km². Below is an interactive map where *clicking* on any sub-watershed will display a range of properties. In the map, sub-watersheds are color-coded based on factors such as the degree of impervious cover.

<iframe src="https://golang.oakridgeswater.ca/pages/sws-characterization.html" width="100%" height="500" scrolling="no" allowfullscreen></iframe>

_Sub-watershed characterization and flow topology_

<br>

<iframe src="https://golang.oakridgeswater.ca/pages/swsmet.html" width="100%" height="500" scrolling="no" allowfullscreen></iframe>

_Sub-watershed average climate (2002-2024)._


<br>

<br>

# Source Data

ORMGP Sub watershed shapefile: [`PDEM-South-D2013-OWRC25-60-HC-sws10.geojson`](https://www.dropbox.com/scl/fi/s6u7nhjp7wkj2xpd78hqp/PDEM-South-D2013-OWRC23-60-HC-sws10-simpl.geojson?rlkey=t9xqsbdb3o311nq8w8ksc8k0h&st=5pz6o1l4&dl=1)
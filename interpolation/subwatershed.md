---
title: Sub-watershed Characterization
author: Oak Ridges Moraine Groundwater Program
output: html_document
---



# Sub-watershed Delineation

The 3 million hectare ORMGP jurisdiction has been subdivided into thousands of ~10km² sub-watersheds as a basis for hydrometeorological data analysis. Every sub-watershed has a defined topological order in which headwater sub-watersheds can easily be mapped to subsequent downstream sub-watersheds, and so on until feeding the great lakes. The intent here is to make these sub-watersheds a "logical unit" for climatological and water budget analyses. Below is a description of the derivation the v.2023 OWRC 10km² sub-watershed map and its derivatives.

<br>

`click on a subwatershed:`

<iframe src="https://owrc.shinyapps.io/sws23/" width="100%" height="500" scrolling="no" allowfullscreen></iframe>

[*open in to view in separate tab*](https://owrc.shinyapps.io/sws23/)

<br>


<!-- - a catchment area delineation tool -->
<!-- - an interpolated real-time daily meteorological dataset dating back to the year 1900 -->

## Build v.2023

The sub-watershed delineation has expanded to include the entire Canadian Lake Ontario shoreline.

## Build v.2020

The Provincial Digital Elevation Model (DEM) has been [processed into a "hydrologically-correct" digital elevation model](/interpolants/interpolation/overland.html) of the ORMGP ground surface. From this information, the ORMGP region is portioned into 2,813 ~10km² sub-watersheds. 

<!-- ### Data -->

<!-- current build may be found [here](https://www.dropbox.com/s/ro16gg6zi4kqbc0/owrc20-50a_SWS10-final.geojson?dl=1) -->

# Derivatives

The hydrologically-corrected digital elevation model (HDEM) is further process to derive a number of metrics aggregated at the sub-watershed scale. [An overlay analysis was performed to characterize the sub-watersheds](/interpolants/interpolation/landuse.html), including:

- impervious area
- canopy coverage
- water body coverage
- wetland coverage
- relative permeability/infiltrability
<!-- - mean slope and dominant aspect -->
<!-- - mean depth to water table. -->



# Product

The ORMGP jurisdiction discretized into ~3000 ~10km² sub-watersheds. Below is an interactive map whereby *Clicking* at any sub-watershed will return a number of properties. In the figure below, sub-watersheds are colour-coded according to their degree of impervious cover, for instance.


<iframe src="https://golang.oakridgeswater.ca/pages/sws-characterization.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>

_Sub-watershed characterization and flow topology_

<br>

<br>

# Source Data

Sub watershed shapefile: [`owrc20-50a_SWS10-final.geojson`](https://www.dropbox.com/s/ro16gg6zi4kqbc0/owrc20-50a_SWS10-final.geojson?dl=1)
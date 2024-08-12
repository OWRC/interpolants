---
Title: Interpolation of Surfaces
author: Oak Ridges Moraine Groundwater Program
output: html_document
---

<span style="font-size:3em; font-weight: bold;">Interpolation of Surfaces</span>

<span style="font-size:2em; font-weight: bold;">Open Data Products</span>

<br>

The following is an index to the data surfaces produced by the ORMGP. All data can be cited using the link below.


<span style="font-size:2em; font-weight: bold;">Contents</span>

* TOC
{:toc}


<br>

# Metadata

[*Our metadata repository, Table of Contents.*](/metadata/content/toc.html)

<span style="font-size:1.45em;">Surfaces</span>

- [Hydrologically Conditioned DEM](/metadata/surfaces/hdem.html)
- [Land Use _(full coverage)_](/metadata/surfaces/land_use.html)
- [Potential Discharge Areas](/metadata/surfaces/potential_discharge.html)
- [Potentiometric Surface](/metadata/surfaces/potentiometric_surface.html)
- [Surficial Geology _(full coverage)_](/metadata/surfaces/surficial_geology.html)
- [Topologically Conditioned Sub-watersheds](/metadata/surfaces/topo_sws.html)
- [Topologically Conditioned Watercourses](/metadata/surfaces/topo_watercourse.html)
- [Water Table](/metadata/surfaces/water_table.html)

<br>


# Geospatial Layers
<iframe src="https://golang.oakridgeswater.ca/pages/ormgp-image-server.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Static 2D fields as hosted on the ORMGP image server, updated frequently_

## Bedrock
## Geological Surfaces (2021)

The geology layers presented on the ORMGP Website have been created at different times, and in cases, by different parties over the years.  ORMGP staff are regularly checking the geological layers, making adjustments over time. However, these incremental changes are only periodically updated onto the website. The Figure below shows the various sets of geological layers that have been built into a regional picture and that are currently reflected on the ORMGP website.

[*more info*](/interpolants/interpolation/geolayers.html)

## Water Table Mapping

The Oak Ridges Moraine Groundwater Program (ORMGP) has been working on producing a reliable water table map for quite some time. Over the years several versions of the water table surface have been prepared as new information has become available or as the technical mapping methodology has been adjusted. Although it sounds straightforward to interpolate a water table surface, there are a number of factors that make the process difficult. Here we outline some of the considerations that have gone into creating the water table surfaces (and their derivatives) and can serve as a supplementary document for those that make use of these layers. For more information, see the [*Fact Sheet*](/watertable/).


## Land use

The source of the land use data is: *Ministry of Natural Resources and Forestry, 2019. Southern Ontario Land Resource Information System (SOLRIS) Version 3.0: Data Specifications. Science and Research Branch, April 2019.*

From this layer, the follow land use categorizations are derived:

- impervious cover
- canopy cover
- wetland cover
- open water
- relative permeability

[*more info*](/interpolants/interpolation/landuse.html)


## Surficial Geology

The source of the land use data is: *Ontario Geological Survey 2010. Surficial geology of southern Ontario; Ontario Geological Survey, Miscellaneous Release— Data 128 – Revised*. From this layer, approximations of percolation rates that affect recharge rates.

[*more info*](/interpolants/interpolation/surfgeo.html)

<br>


# Spatially interpolated, near real-time data

* [**Near Real-time Climate Data Service**](/interpolants/sources/climate-data-service.html) for use in our water budget product which includes the computation of [potential evaporation](/interpolants/interpolation/calc/panET/PanEvaporation.html), [snowmelt](/interpolants/modelling/waterbudget/data.html#sub-daily-from-daily-snowmelt), etc. from available data.
* [Spatial and Temporal interpolation](/interpolants/fews/climate-interpolation.html) of point/scalar data.
* [Barometric pressure](/interpolants/interpolation/barometry.html) elevation-corrected and projected to a 2km regional grid.

<br>

<iframe src="https://golang.oakridgeswater.ca/pages/swsmet.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_Distributed time-series data, updated nightly_

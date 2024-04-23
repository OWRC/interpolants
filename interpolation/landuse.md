---
title: Land use properties of the ORMGP region
author: Oak Ridges Moraine Groundwater Program
output: html_document
---



The Ontario Ministry of Natural Resources and Forestry (2019) [SOLRIS version 3.0](https://geohub.lio.gov.on.ca/documents/0279f65b82314121b5b5ec93d76bc6ba/about) provincial land use layer is employed to aggregate imperviousness and canopy coverage at the sub-watershed scale. In areas to the north, where the SOLRIS coverage discontinues, interpretation was supplied by the [Agriculture and Agri-food Canada Annual Crop Inventory](https://open.canada.ca/data/en/dataset/ba2645d5-4458-414d-b196-6303ac06c1c9) (2013). (for more details, please refer to the layer's [metadata](/metadata/surfaces/land_use.html).)

<iframe src="https://golang.oakridgeswater.ca/pages/landuse23.html" width="100%" height="400" scrolling="no" allowfullscreen></iframe>
_ORMGP land use as hosted on our image server_

This land-use layer is used primarily to assign hydrologic properties to the ORMGP [water budget model](/interpolants/modelling/waterbudgetmodel.html#land-use-and-surficial-geology).

![](fig/SOLRIS-legend.png)



# Raster download

The version 2023 ORMGP land-use surface can be found [here](https://www.dropbox.com/scl/fi/428o1h1a3qg1xnnt7g1iz/landuse23.tif?rlkey=9kzwrrvpi6mb9plwzajy8wiof&dl=1). See also the [metadata](/metadata/surfaces/land_use.html).



# Derivative products

An overlay analysis is the process of overlaying 2 or more spatial layers and capturing statistics associated with their relative coverage. In this case, the sub-watershed layer is overlain by Provincial land-use and surficial geology layers to obtain information like percent impervious, relative permeability, etc.

Provincial layers discussed above and [here](/interpolants/interpolation/surfgeo.html) detail below have in all cases been re-sampled/up-scaled to the 60x60m² grid associated with the [hydrologically corrected DEM](/interpolants/interpolation/overland.html). It is from these rasters where the aggregation of watershed characteristics is computed.


## Land use

The Ministry of Natural Resources and Forestry (2019) SOLRIS version 3.0 provincial land use layer is employed to aggregate imperviousness, canopy coverage, wetland coverage and open water coverage at the sub-watershed scale. The dominant SOLRIS land use class (by area) is assigned the Land use class index for every 60x60m² grid cell. 

![Final 60x60m SOLRIS mapping.](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/output/landuse23_60.png?raw=true)

*Final 60x60m SOLRIS mapping. (For illustrative purposes only, [see here](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/OWRC23-lusg.ipynb) to reproduce shown raster.)*


### Land use coverage

For any ~10km² sub-watershed and given a 60x60m² grid, there should be a subset of SOLRIS land use class indices per sub-watershed. Using a look-up system, the set of cells contained within a sub-watershed are assigned a value of imperviousness, water body, wetland and canopy coverage (according to their SOLRIS index) and accumulated to a sub-watershed sum. Percent impervious and canopy coverage as per SOLRIS v3.0 (MNRF, 2019) land use classification [shown here](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/OWRC23-lusg.ipynb).


![Final 60x60m impervious mapping.](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/output/landuse23_60_perimp.png?raw=true) 

*Final 60x60m impervious mapping. (For illustrative purposes only, [see here](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/OWRC23-lusg.ipynb) to reproduce shown raster.)*

![Final 60x60m canopy mapping.](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/output/landuse23_60_percov.png?raw=true) 

*Final 60x60m canopy mapping mapping. (For illustrative purposes only, [see here](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/OWRC23-lusg.ipynb) to reproduce shown raster.)*


## Surficial geology

The Ontario Geological Survey's (2010) Surficial geology of southern Ontario layer also assigns a 60x60m² grid by the dominant class. 

![Final 60x60m permeability mapping.](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/output/surfgeo23_60.png?raw=true)

*Final 60x60m permeability mapping. (For illustrative purposes only, [see here](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/OWRC23-lusg.ipynb) to reproduce shown raster.)*

### Permeability

The OGS classes have been grouped according to the attribute "permeability" using a similar look-up table cross-referencing scheme. OGS (2010) adds: *"Permeability classification is a very generalized one, based purely on characteristics of material types."* 

After assigning an assumed "effective" hydraulic conductivity to every permeability group, sub-watershed "permeability" is then calculated as the geometric mean of 60x60m² grid cells contained within a sub-watershed. Permeability classifications (after OGS, 2010) and effective hydraulic conductivity value assumed for every permeability group is [described here](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/OWRC23-lusg.ipynb).


![Final 60x60m permeability mapping.](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/output/surfgeo23_60-logK.png?raw=true) 

*The resulting effective hydraulic conductivity is then reverted back to the nearest Low--High OGS (2010) classification. (For illustrative purposes only, [see here](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/OWRC23-lusg.ipynb) to reproduce shown raster.)*



# Source code
Processing discussed above that are operational have been documented in a [jupyter notebook](https://github.com/OWRC/interpolants/blob/main/interpolation/calc/landuse/OWRC23-lusg.ipynb). Source data can be found [here](https://www.dropbox.com/scl/fo/bfkxkkrz940eqkdsk9cqy/AJadVHg9De-SdPWFORDCIHE?rlkey=tndynpc63rclqc8tu527cxg0d&st=7d9bcxiz&dl=0) and additional outputs can be found [here](https://github.com/OWRC/interpolants/tree/main/interpolation/calc/landuse/output).


## Final shapefile
[PDEM-South-D2013-OWRC23-60-HC-sws10-simpl.geojson (v.2023)](https://github.com/OWRC/geojson/blob/main/PDEM-South-D2013-OWRC23-60-HC-sws10-simpl.geojson)





## References

Agriculture and Agri-food Canada, 2013. Data Product Specifications (ISO 19131) rev. A. 31pp.

Ontario Ministry of Natural Resources and Forestry, 2019. Southern Ontario Land Resource Information System (SOLRIS) Version 3.0: Data Specifications. Science and Research Branch, April 2019.




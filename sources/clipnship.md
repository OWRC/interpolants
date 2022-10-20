---
title: Clip 'n Ship
author: Oak Ridges Moraine Groundwater Program
output: html_document
---

The ORMGP is previewing a service from which partners can easily gain access to the spatial layers we produce.  Imaging a *cookie-cutter* taking a vertical section within which the data are provided.

The first part is the **clipping** function. This is where the user supplies an extent of their data request, and the return is all the data available within those extents.

![https://desktop.arcgis.com/en/arcmap/latest/tools/analysis-toolbox/clip.htm](https://desktop.arcgis.com/en/arcmap/latest/tools/analysis-toolbox/GUID-6D3322A8-57EA-4D24-9FFE-2A9E7C6B29EC-web.png) \
[*ArcMAP Clip function*](https://desktop.arcgis.com/en/arcmap/latest/tools/analysis-toolbox/clip.htm)


Then the **ship** feature requires our server to package the clipped data into a compressed file for download.  


# Data formats
The data format chosen for the exports are provided in a format that is most compressible, maintaining efficient file transfer. The files formats are thus less less common; yet are general enough that they'll open on common GIS platforms.

## File Formats

### Rasters
Rasters are provided in a [**band interleaved by line** (\*.bil)](https://desktop.arcgis.com/en/arcmap/10.5/manage-data/raster-and-images/bil-bip-and-bsq-raster-files.htm) format.  This file is in a raw binary format and is accompanied by header file (\*.hdr) and a projection file (\*.prj).  Files will open in [ArcGIS](https://www.arcgis.com/index.html), [QGIS](https://www.qgis.org/en/site/), and load as a [NumPy](https://numpy.org/) array.

### Vectors
Vector files (in particular polylines and polygons) are provided in [**GeoJson**](https://geojson.org/) (\*.geojson) format.  This is an all-encompassing ascii-format file which is flexible, but slow. It is suggested that files be converted to shapefiles (\*.shp) when performance is desired.

### Points
Point data, database queries, are provided in **comma-separated value** (\*.csv) format.


# Metadata
[*our metadata repository*](/metadata/content/toc.html)

# How to Cite
*see below*

# Data description

## Geology

### Layers

- __*TODO*__

### database queries (*.csv)

- V_CON_DOCUMENT
- V_CON_GENERAL
- V_CON_GEOLOGY
- V_CON_HYDROGEOLOGY
- V_CON_PTTW

## Hydrogeology

- Water Table Mapping [*(more info here)*](/watertable/)
    - `DP_WL_DEPTH_Final_20210824.bil`
    - `DP_WL_ELEV_Final_corr_20210824.bil`
    - `SH_WL_DEPTH_BHS_20210615.bil`
    - `SH_WL_DEPTH_Combined_Final_20210708b.bil`
    - `SH_WL_ELEV_BHS_Final_20210615.bil`
    - `SH_WL_ELEV_BHS_Final_DA_20210615.bil`
    - `SH_WL_ELEV_Combined_Final_20210708b.bil`

## Hydrology

- [Interpolated daily climatology](/interpolants/interpolation/daily.html) given to the centroid of the area selected, tabular (*.csv) format.
- `owrc20-50-noGreatLake-HC-observations-trim-FINAL-elevation.bil`---["Hydrologically corrected" digital elevation model](/interpolants/interpolation/overland.html). 
- Land use [*(data sources)*](/interpolants/interpolation/landuse.html)
    - `solrisv3_10_infilled_50_percov.bil`---fraction canopy cover
    - `solrisv3_10_infilled_50_perimp.bil`---fraction impervious cover
    - `solrisv3_10_infilled_50_perow.bil`---fraction open water cover
    - `solrisv3_10_infilled_50_perwl.bil`---fraction wetland cover
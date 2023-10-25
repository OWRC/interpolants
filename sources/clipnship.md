---
title: Clip 'n Ship
author: Oak Ridges Moraine Groundwater Program
output: html_document
---

ORMGP partners and paid subscribers can download the spatial layers we produce and some data.  To do this, users specify a small, rectangular area, inside which a 3D block of the geologic data is provided. The specified area must not exceed 18 square kilometre (the user will get a warning if the specified rectangular area exceedss this). Note: If users require a larger area, please contact ORMGP.

The first step in this process is the **clip** function. This is where the user supplies the areal extent of their data request. The return is the spatial layers and data available within the specified extent.

![https://desktop.arcgis.com/en/arcmap/latest/tools/analysis-toolbox/clip.htm](https://desktop.arcgis.com/en/arcmap/latest/tools/analysis-toolbox/GUID-6D3322A8-57EA-4D24-9FFE-2A9E7C6B29EC-web.png) \
[*ArcMAP Clip function*](https://desktop.arcgis.com/en/arcmap/latest/tools/analysis-toolbox/clip.htm)


The **ship** feature then provides a compressed file with all available data for download.  


# **Data Formats**
The data format for export is compressible and efficient. The files formats are less common, yet are general enough that they are compatible with common GIS platforms. Data are compressed into a *tar.gz* file, which can be opened using free and open software such as [7-Zip](https://www.7-zip.org/) and [WinRAR](https://www.win-rar.com/).


## File Formats

### Raster Files
Raster files are provided in a [**band interleaved by line** (\*.bil)](https://desktop.arcgis.com/en/arcmap/10.5/manage-data/raster-and-images/bil-bip-and-bsq-raster-files.htm) format.  This is a raw binary format and is accompanied by two other files: (1) a header file (\*.hdr) and (2) a projection file (\*.prj).   This format will open in [ArcGIS](https://www.arcgis.com/index.html), [QGIS](https://www.qgis.org/en/site/), [Surfer](https://surferhelp.goldensoftware.com/subsys/subsys_band_interleaved_file_descr.htm) and will load as a [NumPy](https://numpy.org/) array.

### Vector Files
Vector files (in particular polylines and polygons) are provided in [**GeoJson**](https://geojson.org/) (\*.geojson) format.  This is an ascii-format file that is flexible, but can be slow. It is suggested that files be converted to shapefiles (\*.shp) when performance is desired.

### Point Data
Point data and database queries are provided in **comma-separated value** (\*.csv) format. This tabular format stores data as plain text, where each line in the file represents one data record, or location. Each record contains the same number of fields, and each field is separated by a comma. CSV files can be opened with any text editor or with Microsoft Excel, or can be imported into a database (e.g., Microsoft Access).


# **Metadata**
[*our metadata repository*](/metadata/content/toc.html)

# **How to Cite**
When referring to the interpretations and data from the Clip 'n Ship function, please cite in the following format:
"Oak Ridges Moraine Groundwater Program Website (Oakridgeswater.ca) 2023. Accessed mm/dd/yyyy"

# **Data Description**

## Geology Folder

### Layers
The Clip 'n Ship function provides the top elevation and thickness (isopach) for each interpreted hydrostratigraphic unit within the ORMGP jurisdiction. The following figure shows the intepreted units:
![image](https://github.com/OWRC/interpolants/assets/92586150/947f8c3b-dec2-4ded-874d-454b7e4b863a)

Interpreted layer elevations and thicknesses are provided as raster files (*.bil format, see above) and follow this pattern: *WB_2021_`LayerNo`\_`LayerName`\_`LayerType`\_`dateCreated`-crop.bil*.

The complete list of raster files is below (as mentioned above, each *.bil file listed below includes two additional files that are not listed here):
- `WB_2021_01_GROUND_SURFACE_20211027-crop.bil`
- `WB_2021_02_HALTON_TILL_EQUIV_20211027-crop.bil`
- `WB_2021_02C_HALTON_TILL_EQUIV_ISOPACH_20211027-crop.bil`
- `WB_2021_03_ORAC_20211027-crop.bil` 
- `WB_2021_03C_ORAC_ISOPACH_20220808-crop.bil`
- `WB_2021_04_CHANNEL_SILT_20220808-crop.bil`
- `WB_2021_04C_CHANNEL_SILT_ISOPACH_20220808-crop.bil`
- `WB_2021_05_CHANNEL_SAND_20220808-crop.bil`
- `WB_2021_05C_CHANNEL_SAND_ISOPACH_20220808-crop.bil`
- `WB_2021_06_UPPER_NEWMARKET_20220808-crop.bil`
- `WB_2021_06C_UPPER_NEWMARKET_ISOPACH_20220808-crop.bil`
- `WB_2021_07_INS_20220909-crop.bil`
- `WB_2021_07C_INS_ISOPACH_20220909-crop.bil`
- `WB_2021_08_LOWER_NEWMARKET_20220815-crop.bil`
- `WB_2021_08C_LOWER_NEWMARKET_ISOPACH_20220815-crop.bil`
- `WB_2021_09_THORNCLIFFE_20220808-crop.bil`
- `WB_2021_09C_THORNCLIFFE_ISOPACH_20220808-crop.bil`
- `WB_2021_10_SUNNYBROOK_20220808-crop.bil`
- `WB_2021_10C_SUNNYBROOK_ISOPACH_20220808-crop.bil`
- `WB_2021_11_SCARBOROUGH_20211027-crop.bil`
- `WB_2021_11C_SCARBOROUGH_ISOPACH_20211027-crop.bil`
- `WB_2021_12_BEDROCK_20211027-crop.bil`
- `WB_2021_12E_BEDROCK_BASE_20211027-crop.bil`
- `WB_2021_12F_QUATERNARY_SEDS_ISOPACH_20211027-crop.bil`
- `WB_2021_12G_QUATERNARY_SEDS_OGS_ISOPACH_20211027-crop.bil`
- `WB_2021_99F_UNCONFORMITY_20220808-crop.bil`

- 


For example
- `WB_2021_01_GROUND_SURFACE_20211027-crop.bil` is the first, or uppermost geologic layer (01) and represents the ground surface
- `WB_2021_02_HALTON_TILL_EQUIV_20211027-crop.bil` is the top of the second geologic layer (02) and represents the top of the Halton Till
- `WB_2021_09C_THORNCLIFFE_ISOPACH_20220808-crop.bil` is the isopach (thickness) map of the Thorncliffe llayer (09) 

Each geologic layer includes a set of _bil_, _hdr_, and _prj_ files for both the layer top and the isopach. 

### Database Queries (*.csv)

The following five _csv_ files provide results from database queries for the user-selected polygon.

- `V_CON_DOCUMENT.csv`
   - Contains a list of all georeferenced documents and includes information such as: report name, year, author and location coordinates
- `V_CON_GENERAL.csv`
   - Contains a list of all locations. This table includes information such as: location ID and names, type, top/bottom elevation, coordinates
- `V_CON_GEOLOGY.csv`
   - Contains geologic records at locations within the selected polygon including: location ID, geologic descriptions, geologic interval top/botton elevation, location coordinates
- `V_CON_HYDROGEOLOGY.csv`
   - Contains hydrogeological data at locations within the selected area including: location ID, screen interval, geologic formation, location coordinates
- `V_CON_PTTW.scv`
   - Contains a list of information of all permits to take water (PTTWs) with the selected area including: location ID, location coordiantes, maximum permitted rate, date issued
  
## Hydrogeology

- Water Table Mapping [*(more info here)*](https://owrc.github.io/watertable/)) [*(metadata here)*](https://owrc.github.io/metadata/surfaces/water_table.html)
    - `DP_WL_DEPTH_Final_20210824.bil`
    - `DP_WL_ELEV_Final_corr_20210824.bil`
    - `SH_WL_DEPTH_BHS_20210615.bil`
    - `SH_WL_DEPTH_Combined_Final_20210708b.bil`
    - `SH_WL_ELEV_BHS_Final_20210615.bil`
    - `SH_WL_ELEV_BHS_Final_DA_20210615.bil`
    - `SH_WL_ELEV_Combined_Final_20210708b.bil`
 - The naming convention is as follows:
    - The first code is either DP (deep) or SH (shallow) water levels
    - The second code is WL (for water levels)
    - The third term is either ELEV (for the water level elevation) or DEPTH (for water level depth below ground surface)
    - The next term is either BHS (for the [*(WTO surface)*](https://owrc.github.io/watertable/) ) or Combined (For the [*(WT1 surface)*](https://owrc.github.io/watertable/)). Note that for the deep (DP) water levels, this term is not included). 
    - DA refers to potential discharge areas. 

## Hydrology

- [Interpolated daily climatology](/interpolants/interpolation/daily.html) given to the centroid of the area selected, tabular (*.csv) format.
- `owrc20-50-noGreatLake-HC-observations-trim-FINAL-elevation.bil`---["Hydrologically corrected" digital elevation model](/interpolants/interpolation/overland.html). 
- Land use [*(data sources)*](/interpolants/interpolation/landuse.html)
    - `solrisv3_10_infilled_50_percov.bil`---fraction canopy cover
    - `solrisv3_10_infilled_50_perimp.bil`---fraction impervious cover
    - `solrisv3_10_infilled_50_perow.bil`---fraction open water cover
    - `solrisv3_10_infilled_50_perwl.bil`---fraction wetland cover

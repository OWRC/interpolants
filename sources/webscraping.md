---
title: Web Scraping
output: html_document
---

> [Web scraping](https://en.wikipedia.org/wiki/Web_scraping) is the process of extracting data from websites through scheduled/automated scripts.

On a nightly basis, data are extracted from a number of open data sources, whether they be:
- **"APIs"**---Databases that can be directly queried by sending a web-address (URL), such as:
  - [KISTERS](https://www.kisters.de/en/) Services (KiWIS)
  - AQUARIUS Time-Series Software, [Aquatic Informatics Inc.](https://aquaticinformatics.com/)
  - [FlowWorks](https://www.flowworks.com/)
  - [WaterTrax](https://aquaticinformatics.com/products/wastewater-compliance-software/)
- **File repositories**---Typically an FTP server hosting a number of general use files, like comma-separated-values (.csv) files
- **HTML tables**---Readable tables posted online are converted into a dataframe---a form needed to insert into our database. *This is the least reliable and thus the most effort is required.*


### Notes:

> Streamflow discharge and stage are re-scaled to daily mean timesteps when inserted into our database.


## Sources:

A number of our partners maintain internal databases. ORMGP is continuing to integrate these sources into our workflow without the need for data duplication. This is (hopefully) accomplished by establishing an [Application Programming Interface](https://en.wikipedia.org/wiki/API) (API) on the partners' end. Currently, we have:

[*see also Source References.*](/interpolants/sources/reference.html)

<br>

### APIs

- Region of Peel
- York Region
- Durham Region
- TRCA
- LSRCA
- CVC 
- CLOCA 
- MNRF 



### File repositories

- MSC [Datamart](https://eccc-msc.github.io/open-data/msc-datamart/readme_en/)
- WSC [HYDAT](https://www.canada.ca/en/environment-climate-change/services/water-overview/quantity/monitoring/survey/data-products-services/national-archive-hydat.html)
- ECCC [CaPA-HRDPA](https://eccc-msc.github.io/open-data/msc-data/nwp_hrdpa-watershed/readme_hrdpa-watershed_en/)
- NOAA [SNODAS](https://nsidc.org/data/g02158/versions/1)


### HTML Tables

- MSC [historical](https://climate.weather.gc.ca/) (hourly and daily)

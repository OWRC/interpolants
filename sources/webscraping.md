---
title: Web Scraping
author: M.Marchildon
output: html_document
---

> Web scraping is the process of extracting data from websites

On a nightly basis, data are extracted from a number of open data sources, whether they be:
- **"APIs"**---That is databases that can be directly queried by sending a web-address (URL), fuch as:
  - [KISTERS](https://www.kisters.de/en/) Services (KiWIS)
  - AQUARIUS Time-Series Software, [Aquatic Informatics Inc.](https://aquaticinformatics.com/)
- **File repositories**---Typically an FTP server hosting a number of general use files, like comma-separated-values (.csv) files
- **HTML tables**---Readable tables posted online are converted into a dataframe---a form needed insert into our database. *This is the least reliable and thus the most effort required option.*


### Notes:

- Streamflow discharge and stage are re-scaled to daily mean timesteps when inserted into our database


## Sources:

A number of our partners maintain internal databases. Attempts are continuing to integrate these sources to our workflow without the need for data duplication. This is (hopefully) accomplished by establishing an [Application Programming Interface](https://en.wikipedia.org/wiki/API) (API) on the partners' end. Currently, we have:

[*see also Sources*](/interpolants/sources/sources.html)



### APIs

- Region of Peel
- TRCA
- CVC 
- CLOCA 
- MNRF 



### File repositories

- WSC datamart
- WSC HYDAT
- ECCC CaPA-HRDPA
- NOAA SNODAS


### HTML Tables

- MSC historical (hourly and daily)
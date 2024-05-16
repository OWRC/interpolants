---
title: The ORMGP Raven Model
subtitle: A regional lumped-parameter rainfall-runoff model
author: Oak Ridges Moraine Groundwater Program
output: html_document
---


A regional semi-distributed rainfall-runoff model has been developed to simulate regional-scale hydrologic processes at the sub-watershed scale. The model is developed using Raven: a state-of-the-art [hydrological framework](https://raven.uwaterloo.ca/) written by Dr. James Craig at the University of Waterloo. In particular, the HBV-EC formulation is applied as its results can be mapped to the 60x60 grid used with the [Water Budget model](/interpolants/modelling/waterbudgetmodel.html).

The model was initially built to support the Water Budget (recharge) model in that it's built on the same [sub-watershed network](/interpolants/interpolation/subwatershed.html), [land-use](/interpolants/interpolation/landuse.html), [surficial geology](/interpolants/interpolation/surfgeo.html) and [climate forcings](/interpolants/sources/climate-data-service.html). With this *traditional* hydrologic model, results are indeed similar--although at the moment more calibration is required.
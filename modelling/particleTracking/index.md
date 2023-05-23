
# Introduction

The [ORMGP particle tracking web-tool](https://www.oakridgeswater.ca/) returns both forward and backward sub-surface particle tracks from a user-selected location.  The tool is built upon existing numerical groundwater models which in themselves have organized, synthesized and interpreted a wealth of hydrogeological information (e.g., boreholes, geological mapping, previous studies, etc.) to gain an understanding of the groundwater flow system. 

Here, the results from running these models to a steady state are collected. From these states, a virtual particle can be released in the model domain and its path can be traced.

Particle tracking can prove important and useful from a number of perspectives:
  
  - For any groundwater study where degraded groundwater quality has been detected, particle tracking can provide an initial indication of where the degraded water quality might have originated.  An evaluation of backward tracking from the site can help to quickly point out up-gradient land uses that might be contributing to degraded water quality. Forward tracking can indicate potential downgradient areas at risk. More detailed follow up investigations can then be directed to the right areas.

- For proposed development in rural areas, where water supplies are from wells, and where waste water is directed to septic systems, particle tracking is useful for showing the general direction of groundwater flow. The overall development can be designed to avoid having septic systems positioned such that they might affect nearby well water supplies. Even at a site scale, knowing the generalized groundwater flow directions allows for appropriate siting of wells (up-gradient from septic systems) and septic beds (down-gradient of wells).  The particle tracking tool can also reveal potential up-gradient land uses that might have an influence on well water quality in a proposed development.

- Ecological studies, where aquatic organisms are of interest, could also make use of particle tracking.  By examining the backward particle tracking from streams, existing or proposed land uses that might affect stream water quality can be assessed, and potential mitigation proposed. Ecologically Groundwater Recharge Areas (EGRA, *formerly ESGRA*) make use of such particle tracks to link recharge to discharge areas.  If new important ecological stream reaches are identified, then preliminary delineation of EGRAs can be made using the tool.  This can lead to early mitigation activities.


<!-- [![Watch the video](https://img.youtube.com/vi/m5RBTuPPgR8/maxresdefault.jpg)](https://www.youtube.com/watch?v=m5RBTuPPgR8) -->


# Numerical Model Selection

As of the date listed above, the particle tracking from the following models have been made live online:
  
1. Regional model (MODFLOW)
1. Halton Tier-3 (FEFLOW)
1. Oro-Hawkestone (MODFLOW)
<!-- 1. South Halton (MODFLOW) -->
<!-- 1. CVC (FEFLOW) -->
<!-- 1. NVCA-SSEA (FEFLOW) -->
<!-- 1. Ramara Whites Talbot (MODFLOW) -->
<!-- 1. York Tier-3 (MODFLOW) -->
<!-- 1. Durham (MODFLOW) -->



![](img/models.png)






# Methodology


The "Long-term average" flux fields of the above models were computed by running each model to steady state. This is a standard numerical model *output*.

At every model prismatic cell (or element), including all cells in each layer right to the base of the model, a virtual particle was placed at its centroid (or top of water surface whichever is less, for upper layer cells that are only partially saturated) and tracked forward and backward using the Pollock method for the MODFLOW models, and a vector triangulation scheme for the FEFLOW models. [Source code for the particle tracking can be found here](https://github.com/maseology/ptrack).


There are 2 fundamental model "types" that are present in the [ORMGP custodianship program](/snapshots/md/numerical-model-custodianship-program.html): Finite Difference (FD) models (i.e., MODFLOW) and Finite Element (FE) models (i.e., FEFLOW, HydroGeoSphere). In source water protection, both types have proved more than sufficient to meet provincial guidance and planning demands.  However, when it comes to particle tracking, the model type plays a large role in how model results are to be interpreted.


For Finite Difference (FD) models, the semi-analytical method of Pollock (1989) is applied. The spatial extent of an FD model can be thought of as a stacking of rectilinear blocks, leaving no gaps in its interior.



Finite Element (FE) models used in groundwater modelling in southern Ontario are entirely built using a triangulated irregular network covering the land surface. From this FE mesh, hydrostratigraphic layers are built, resulting in a stacking of triangular prisms. Here a 3D flux vector computed at the element centroid is extracted from the model and is assumed constant throughout the spatial extent of the prismatic element. This is here termed the "vector-based" method.


Please note that there are many particle tracking methodologies and algorithms, we have chosen a convenient methodology to permit particles to be shown on the website.

Numerical model cell/element size/orientation will all have effects on the particle pathline calculation.



# "Centroidal" Particles

For the sake brevity, the term "model cell" can be interpreted as either an FD grid cell or an FE prism. The centroid is the center of mass of the cell.

Particles are tracked both backwards and forwards from the centroid of every grid cell in the model.  In all, this results in *a collection of particle pathlines that pass through the centroid of at least one model cell*.

Keep in mind that the forward and backward particle traces that are shown on the website include traces from each model layer right to depth (not just from shallow cells).  Note that red lines are tied to reverse (upgradient) areas while blue lines are tied to forward (downgradient) areas.

Particles vertices are attributed with:
  
1. Tracking time
1. Model layer
1. Particle startpoint


## Example
The Regional model is a large (14,500 km²) coarse (240 m cell) 5-layer MODFLOW model that covers the bulk our our jurisdiction. In all, the model consists of 1.3M FD "cells", from each a particle was released at its centroid.  

The next 2 figures show the results of a cell being clicked by a user on our mapping tools:

![](img/clicked-location1.png)

And zooming into the particle tracks:

![](img/clicked-location2.png)

Now, even though there are only 5 centroidal pathlines originating at this cell (one for every layer), many (of the 1.3M) pathlines originating from cells not clicked appear to cross the clicked cell; the particle tracking API captures any pathline that crosses a clicked cell. This gives a nice way to see many pathlines that originate from a particular cell without explicitly computing them.


## Data Compression

To improve user performance, particle pathlines from larger models (>1M cells) have to be simplified to reduce data size (i.e., data compression). As a rule of thumb, the particle tracking web tool performs best when the pathline file remains less than 2GB memory. 

These pathline files (outputted as a _"gob file"_ or [Go Binary](https://pkg.go.dev/encoding/binary): _\*.gob_) consist of a set of vertices each with knowledge of their neighbour vertices (either up and down gradient of the current location). It is these relationships that define the pathlines yet enable the user to take any point along a centroidal pathline and track from there.

There are three ways these data can be compressed either by:
  
1. removing excess detail, such as vertices in close proximity, and using polyline smoothing schemes.
    - here the so-called Ramer-Douglas-Peucker algorithm algorithm was applied with a 10m threshold
1. removing pathlines originating from cells in "pinched-out" layers
1. systematically removing whole pathlines
    - random pull: simply removing every $\text{n}^{th}$ pathline at random
    - area threshold (full exclusion, or random pull)
    - quality thresholds (FE meshes only, aspect ratios, Delaunay criterion, etc.)





# System test

<iframe src="https://owrc.shinyapps.io/ptrack/" frameborder="0" allowfullscreen></iframe>




# References

Pollock, D.W., 1989, Documentation of a computer program to compute and display pathlines using results from the U.S. Geological Survey modular three-dimensional finite-difference ground-water flow model: U.S. Geological Survey Open-File Report 89–381.


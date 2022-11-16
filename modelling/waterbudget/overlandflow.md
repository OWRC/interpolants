---
title: Water Budget Modelling
subtitle: Overland flow routing
output: html_document
---


The overland flow process is built for performance. While, many liberties are taken that may constrain its applicability, it exists because we are interested in:
 1. the fine scale spatial distribution of the land surface water budget; that includes,
 2. groundwater feedback, i.e., the ability to induce saturation excess (Dunnian) runoff; to give further insight into
 3. the role and seasonality of groundwater/surface water interaction at the model cell scale; which dictates,
 1. the role and seasonality antecedent moisture patterns and its impact on runoff generation.

The overland flow model is dependent on [topography](/interpolants/interpolation/overland.html) both in terms of it's lateral direction of flow and rate if discharge. It is called a *__"cascade"__* model because runoff from a model cell is routed and become *__"runon"__* to a downslope cell. Routing following the $D8$ algorithm (O'Callaghan and Mark, 1984) takes runoff computed at a cell, and adds it as runon to the adjacent model cell having the steepest decent.

Hydrological correction has been applied to the digital elevation model (DEM) which means that the derived routing model will always drain to a model boundary, and land surface swales are always assumed to drain. (*This is matter of choice, and is not a limitation to the routing model; only users should be aware of the issues arising from swales in a cascade network.*)

From the [Soil Moisture Accounting scheme](/interpolants/modelling/waterbudget/sma.html), the water budget of the "mobile storage" reservoir is defined as:

$$
  \Delta S_k=k_\text{in}+f_h+b-\left(a_k+f_k+k_\text{out}\right)
$$

<p align="center">
<img src="https://raw.githubusercontent.com/OWRC/interpolants/main/modelling/fig/sma.svg" alt="Conceptual soil moisture accounting scheme." width="85%">
</p>

<br>

# Runoff coefficient

Laterally moving water leaving the cell $(k_\text{out})$ is corrected based on land surface slope. Water leaving a cell can only be directed to a single cell, but any cell can receive from multiple cells. A "*cascade factor*", $F_\text{casc}\approx f(\text{slope},\text{roughness},\text{etc.})$, where $0\leq F_\text{casc} \leq 1$, is applied to the current volume stored in the mobile store (in the form of a *linear reservoir*):

$$
  k_\text{out}=F_\text{casc}S_k^+,
$$

where $S_k^+>0$ is water in the detention store in excess of the store's capacity. $F_\text{casc}$ is related to land surface gradient by:

$$
  F_\text{casc}=1-\exp\left(\frac{\beta^2}{-a}\right),
$$

where $\beta$ is land surface gradient and $a$ is a scaling parameter (note that the above equation is identical to the Gaussian variogram kernel with a unit range).


<!-- $$
  F_\text{casc}=1-\exp\left(-a\frac{\beta^2}{r^2}\right),
$$

where $\beta$ is land surface gradient, $r$ is called the "range" (note that the above equation is identical to the Gaussian variogram model), and $a$ is a scaling factor applied to the range such that it's value approaches unity at $r$. ; Below are examples with $a\approx 5$: -->



## Special conditions


Special conditions are set for $F_\text{casc}$: All stream cells have $F_\text{casc}=1$, meaning that the the mobile water store remains 100% mobile.

Urban areas that are assumed serviced also have $F_\text{casc}=1$ but also have their runoff routed directly to the nearest stream cell; meaning that within a timestep, municipal servicing adequately drained the urban area to it's likely stormwater discharge point. This is termed a cascade *"Urban Diversion"*.



<br>

## Cascade network

![](../fig/cascade.png)
*Model close-up showing the granularity of the overland flow routing scheme. Flow primarily runs along the purple tracks, but in serviced areas, runoff is directly routed to streams (red).*

<br>

The $D8$ algorithm produces a dendritic network of overland flow paths whose rate of discharge depends on $F_\text{casc}$:
- stream cells: $F_\text{casc}=1$
- urban cells: $F_\text{casc}=1$ (assumes serviced areas)
- all else $F_\text{casc}=1-\exp\left(\frac{\beta^2}{-a}\right)$, $(\beta=\text{surface gradient})$


A property of the cascade is that when it involved a sequence of many linear reservoirs, the movement of water resembles a kinetic system, a concept known as the Nash model (Nash, 1957). Consequently, the model cannot have any back-water effects or inertial effects.


![](../fig/rdrr-beta-1.png)
*When comparing the distribution of land surface gradient to a calibrated cascade factor function it's apparent that lateral movement of overland flow is not a dominant process for most of the landscape.*

<br>


### Cascade "Towers"
The cascade routing scheme built this way created issues in flat regions and land surface swales (low points on the land where runon os received from all direction). This can lead to unrealistic water depths $(\gg100\text{m})$.

One way to avoid this is to use a hydrologically-correct DEM, as done here. But this does not solve the tower problem as it can occur in flat regions in particular where a convergence of cascade flowpaths. In the model, excess storage is infiltrated assuming a falling head through a unit length back into the groundwater system:

$$
  g=S_k^+\left[1-\exp(-K_\text{sat}\Delta t)\right],
$$

where $K_\text{sat}$ is saturated hydraulic conductivity of the surficial soils, and $\Delta t$ model timestep (s). This appears to resolve towers here.


# References

Nash, J.E., 1957. The form of the instantaneous unit hydrograph. IAHS Publication 45(3), 114–121.

O'Callaghan, J.F., and D.M. Mark, 1984. The extraction of drainage net-works from digital elevation data, Comput. Vision Graphics Image Process., 28, pp. 328-344.

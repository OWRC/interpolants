---
title: Water Budget Modelling
subtitle: Overland flow routing
author: M.Marchildon
output: html_document
---



Laterally moving water leaving the cell $(k_\text{out})$ is corrected (primarily) based on land surface slope and roughness. Water leaving a cell can only be directed to a single cell, but any cell can receive from multiple cells. A "*cascade factor*", $f_\text{casc}=f(\text{slope},\text{roughness},\text{etc.})$, where $0\leq f_\text{casc} \leq 1$, is applied to the current volume stored in the mobile store (in the form of a linear reservoir):

$$
  k_\text{out}=f_\text{casc}S_k^+,
$$
where $S_k^+>0$ is water in the detention store in excess of the store's capacity, and:

$$
  f_\text{casc}=1-\exp\left(-a\frac{\beta^2}{r^2}\right),
$$

where $\beta$ is land surface gradient, $r$ is called the "range" (note that the above equation is identical to the Gaussian variogram model), and $a$ is a scaling factor applied to the range such that it's value approaches unity at $r$. <!-- ; Below are examples with $a\approx 5$: -->

<!-- ```{r fcasc, echo=FALSE, fig.width=6,fig.height=4,fig.align='center'}
a = 5
fun.1 <- function(x) 1-exp(-a*x^2/0.25^2)
fun.2 <- function(x) 1-exp(-a*x^2/0.5^2)
fun.3 <- function(x) 1-exp(-a*x^2/0.75^2)
fun.4 <- function(x) 1-exp(-a*x^2)
fun.5 <- function(x) 1-exp(-a*x^2/1.5^2)

ggplot(data.frame(x = 0),aes(x=x)) + # dummy dataframe
  theme_bw() +
  stat_function(fun = fun.1) + 
  stat_function(fun = fun.2) + 
  stat_function(fun = fun.3) + 
  stat_function(fun = fun.4) + 
  stat_function(fun = fun.5) +
  annotate("text", label = "r=.25", x = .07, y = .75) +
  annotate("text", label = "r=.5", x = .2, y = .72) +
  annotate("text", label = "r=.75", x = .3, y = .69) +
  annotate("text", label = "r=1", x = .415, y = .66) +
  annotate("text", label = "r=1.5", x = .555, y = .57) +
  xlim(0,1) + labs(x="gradient",y=expression(f["casc"]))
``` -->

<!-- Special conditions are set for $f_\text{casc}$: All stream cells have $f_\text{casc}=1$, meaning that the the mobile water store remains 100% mobile. Here $b_\text{casc}=1$. -->



## Cascade network

TODO









<!-- # OLD -->


<!-- ## Mobile water storage
TODO

$$
	\Delta S_k=k_i+r+x-f_k-k_o,
$$

where $k = q\frac{\Delta t}{w}$ is the volumetric discharge in ($i$) and out ($o$) of the computational element, $r$ is the runoff (i.e., infiltration excess) generated on the land surface, $x$ is the excess runoff (i.e., saturated excess) caused by a high watertable, and $f_k$ is the volume of mobile storage infiltrating the soil zone; all units are [m].


Land surface and soil zone storage [m]:

$$
	\Delta S_h = y+f_k+f_g-r-a-g,
$$

where $y$ is the atmospheric yield (rainfall $+$ snowmelt), $f_g$ is groundwater infiltration into the soil zone from a high watertable, $a$ is evapotranspiration, and $g$ is recharge.


Groundwater storage [m]:

$$
	\Delta S_g = g-f_g-x,
$$


The overall water balance over each CE is then given by:

$$
	\Delta S_k+\Delta S_h+\Delta S_g=y+k_i-\left(k_o+a\right).
$$


<!-- ![Schematic diagram of a computational element.](fig/CE-WB_sketch.png)
Schematic diagram of a computational element. -->
<!-- <img src="https://raw.githubusercontent.com/OWRC/info/main/recessioncoefficient/fig/topmodel_m.png" alt="Schematic diagram of a computational element." width="100%"> -->

<!-- Other useful metrics include:

Net Groundwater Exchange (positive: recharge; negative: discharge):

$$
	g_\text{net}=g-f_g-x
$$  -->



<!-- # OLD

The continuity-based overland flow routing assumes a maximum overland flow capacity $(h_\text{max})$ on every cell. Overland flow is computed as the sum of upslope "runon", groundwater discharge, saturation excess and impervious runoff and is here deemed "*potential runoff*" $(R_o)$. Depending on cell slope and the roughness characteristics of the cell, the depth of "mobile" water that remains on the cell at the end of the timestep is computed by:

$$
	h = h_\text{max}\left(1-\exp\frac{-R_o}{b}\right),
$$

where $b$ is the empirical response coefficient. Runoff leaving the cell at the end of the timestep is defined as:

$$
	R=
	\begin{cases}
		R_o-h  \qquad &\text{if $R_o>h$} \\
		0 &\text{otherwise}
	\end{cases}
$$

TODO

$$
	C = \frac{\log\frac{S_\text{min}}{S}}{\log\frac{S_\text{min}}{S_\text{max}}}\left(C_\text{max}-C_\text{min}\right) + C_\text{min}
$$ -->

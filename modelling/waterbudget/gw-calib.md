
## Calibration to Shallow Groundwater Monitoring

recall

$$
	D_i = \overline{D} + m \left[\gamma - \ln\left(\frac{a}{T_o \tan \beta}\right)_i\right],
$$

where

$$
	\gamma = \frac{1}{A}\sum_i A_i\ln\left(\frac{a}{T_o \tan \beta}\right)_i.
$$

Taking the geometric mean of basin transmissivity:

$$
  \ln T_e = \frac{1}{A}\sum_i A_i\ln T_{o,i}, 
$$

the above can be rearranged to:

$$
  \frac{\overline{D}-D_i}{m} = \left(\ln\frac{a}{\tan\beta}-\ln T_o\right)_i - \left(\lambda - \ln T_e\right),
$$

where

$$
	\lambda = \frac{1}{A}\sum_i A_i\ln\left(\frac{a}{\tan \beta}\right)_i.
$$


<br>

# OLD

Solve for $B$ at every gauge

$$ B=\sum_ib_i $$

<!-- $$ b_i = b_{0,i} \exp\left(\frac{D_\text{inc}-D_i}{m}\right) \Delta t $$ -->

$$ b_i = b_{0,i} \exp\left(\frac{-D_i}{m}\right) \Delta t $$

$$ b_0 = \Omega K_\text{sat}\cdot\tan\beta $$

recall

$$ D_i = \overline{D} + m \left(\gamma - \zeta_i\right) $$

$$ \delta D_i = D_i-\overline{D} = m\left(\gamma - \zeta_i\right) $$

$$ D_{i,t} = \delta D_i + \overline{D}_t $$

at saturated $(\overline{D} = 0)$:

$$
    D_{i,t} =  m\left(\gamma - \zeta_i\right) 
$$

and thus

$$
    b_i = b_{0,i} \exp\left(\zeta_i - \gamma\right) \Delta t
$$

$$ \zeta=\ln\left(\frac{a}{T_o \tan \beta}\right) $$

re-arranging more:

$$
  b_i = \frac{\Omega}{e^\gamma}  \cdot \frac{a}{w} \cdot \Delta t
$$
Solve Riemann problems for the 1D AR equations

   (rho)_t + (rho*v)_x = 0
   (v)_t + (v - rho * (gamma* rho^(gamma-1))) * (v)_x = 0

using approximate Riemann solver

gamma = 0.2

Extrapolation boundary conditions used at both boundaries.

After running this code and creating plots via "make .plots", you 
should be able to view the plots in _plots/_PlotIndex.html.

*************
* EXAMPLE 1 *
*************
This corresponds to Figures 5.1 and 5.2 where
0 < v_l < v_r
0 < rho_l < rho_r

Initial conditions:
rho_l = 0.3, v_l = 0.2
rho_r = 0.4, v_r = 0.3

Final time = 1
x = -0.3 to 0.5
y = 0.1 to 0.45 (rho)
y = 0.1 to 0.4 (v)

*************
* EXAMPLE 2 *
*************
This corresponds to Figure 5.4 where
0 = v_l < v_r
0 = rho_l < rho_r

Initial conditions:
rho_l = 0.00001, v_l = 0
rho_r = 0.4, v_r = 0.3

Final time = 0.5
x = -0.5 to 0.5
y = -0.1 to 0.5 (rho)
y = -0.1 to 0.4 (v)

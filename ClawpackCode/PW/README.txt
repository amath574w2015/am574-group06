Solve Riemann problems for the 1D PW equations

   (rho)_t + (rho*v)_x = 0
   (rho*v)_t + (rho*v^2 + rho^gamma)_x = 0

using an approximate Riemann solver

gamma = 0.1

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
rho_l = 0.3, (rho*v)_l = 0.06, v_l = 0.2
rho_r = 0.4, (rho*v)_r = 0.12, v_r = 0.3

Final time = 1
x = -1 to 1
y = 0.25 to 0.45 (rho)
y = 0.1 to 0.35 (v)


*************
* EXAMPLE 2 *
*************
This corresponds to Figure 5.4 where
0 = v_l < v_r
0 = rho_l < rho_r

Initial conditions:
rho_l = 0.001, (rho*v)_l = 0, v_l = 0
rho_r = 0.4, (rho*v)_r = 0.12, v_r = 0.3

Final time = 0.1
x = -0.5 to 0.5
y = -0.1 to 0.5 (rho)
y = -9 to 2 (v)

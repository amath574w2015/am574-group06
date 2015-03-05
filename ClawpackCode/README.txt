Solve Riemann problems for the 1D PW equations

   (rho)_t + (rho*v)_x = 0
   (rho*v)_t + (rho*v^2 + rho^gamma)_x = 0

using Roe's approximate Riemann solver with entropy fix for
transonic rarefactions.

Initial conditions:
rho_l = 0.3, (rho*v)_l = 0,    {v = 0}
rho_r = 0.4, (rho*v)_r = 0.12, {v = 0.3}
gamma = 0.2

Final time = 0.3

Extrapolation boundary conditions used at both boundaries.

After running this code and creating plots via "make .plots", you 
should be able to view the plots in _plots/_PlotIndex.html.

ISSUES:
- I modified the code rp1_shallow_roe_with_efix.f90 for this problem, so I used
density and momentum. However, I'd like to plot velocity instead of momentum.
What would be the easiest way to do this?
These folders contain the Clawpack code we used to create solutions plots
for the AR and PW models.  These examples correspond to figures 5.2 and
5.4 in the AR paper.

Since both systems are nonlinear, we used linearized Riemann solvers where
we approximate f'(q) by evaluating the Jacobian at averaged rho and v values:

  rho_avg = (rho_l + rho_r) / 2
  v_avg = (v_l + v_r) / 2
  
The approximated Jacobian needs to be diagonalizable with real eigenvalues,
and it must converge to the actual Jacobian f'(q) as q_l, q_r -> q.  

In the second example, we considered the situation where the left state was a 
vacuum (rho_l = 0, v_l = 0).  In this case the approximated Jacobian is no
longer diagonalizable for cells on the left, so the solution breaks down. In
order to obtain solution plots, we found approximate solutions by using very
small values for rho_l. 

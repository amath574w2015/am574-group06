global v_star rho_star p pprime rho

% Declaring various starting values
v_star = [0.2 .5 .8];
rho_star = [0.2 .06 .1];
gamma = 0.2;

p = @(x) x^gamma;
pprime = @(x) gamma*x^(gamma-1);
rho = 0:0.001:5;
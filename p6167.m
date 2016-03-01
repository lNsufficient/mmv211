Q = 20/3600; %m^3/s
D = 0.08; %m
rho = 804; %kg/m^3
mu = 1.92e-03; %kg/(m*s)
dp = 7000;

V = Q/((D/2)^2*pi);
Re_D = rho*V*D/mu;

Af = @(beta) ((beta*D)/2)^2*pi;
Cdf = @(beta) 0.99-0.2262*beta^4.1+(0.000215-0.001125*beta+0.00249*beta^4.7)*(10^6/(Re_D))^0.5;
Qf = @(beta) Cdf(beta)*Af(beta)*(2*dp/rho/(1-beta^4))^(1/2);

solveQ = @(beta) Q - Qf(beta);

beta = fsolve(solveQ, 0.5)
Cd = Cdf(beta)

d = beta*D


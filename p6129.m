clear;
TOL = 1e-8;
TOLf = TOL/10;

g = 9.82;
rho = 998;
mu = 1e-3;
ny = mu/rho;
d = 0.08; %m
r = d/2;
eps = 0.00012; %m
epsd = eps/d; 
p12 = 750000; %Pa
h12 = p12/(rho*g);
L32 = 150; %m
La = 250; %m
Lb = 100; %m

%Guess:
fa = 0.022;
fb = fa;
f32 = fa;

konst = [La; Lb; L32; p12; rho; d];
f = [fa; fb; f32;];

v0 = [3 2 5];

F = @(V) eqSys(V,f,konst);
F(v0)
v = fsolve(F, v0);
while (abs(v0 - v) > TOL)
    v0 = v;
    Re = v'*d/ny;
    f = findF(f,Re, epsd, TOLf);
    F = @(V) eqSys(V,f,konst);
    v = fsolve(F, v);
end
v
Q = v(3)*pi*(d/2)^2

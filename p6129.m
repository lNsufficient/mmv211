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
fa = 0.03;
fb = fa;
f32 = fa;

konst = [La; Lb; L32; p12; rho; d];
f = [fa; fb; f32;];

v0 = [2 2 4]; %Efter detta hade vi kunnat förbättra f,
              %kanske är nödvändigt om dålig datorkraft. För mig behövdes
              %ej

F = @(V) eqSys(V,f,konst); %Lös funktionen (för "fel" f);
v = fsolve(F, v0);
while (abs(v0 - v) > TOL)
    v0 = v;
    Re = v'*d/ny; %Beräkna nya Re
    f = findF(f, Re, epsd, TOLf); %Förbättra f-värden
    F = @(V) eqSys(V,f,konst); %Definiera om funkt med nya f.
    v = fsolve(F, v); %Lös igen.
end
v %Skriv vad v blir
Q = v(3)*pi*(d/2)^2 %Skriv vad det totala flödet blir. Detta är samma som 
                    %i punkt 2

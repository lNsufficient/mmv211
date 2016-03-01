L = 20; %m
D = 0.04; %m
p_e = 101000; %Pa
T = 200 + 273.15; %K
R = 287; %J/KgK
k = 1.4;
mu = 2.57e-5; %N*s/m^2 @200C
rho_e= p_e/(R*T);
a = sqrt(k*R*T);


%Testade f�rs�ka uppskatta parabolen som andragradare, det blev inte
%snyggt, men jag har inte s� mycket b�ttre material att g� p�, s� det f�r
%duga
c = 250/(0.4^2);
dpf = @(x) (250 - c*x.^2); %kPa
x = linspace(0, 0.4);
plot(x, dpf(x));

Ref = @(mdot) 4*mdot/(pi*D*mu);
ff = @(Re) (-1.8*log10(6.9/Re))^(-2);
Vf = @(Re, rho) Re*mu/(rho*D); 
Maf = @(V) V/a;
gf = @(Ma) (k+1)/(2+(k-1)*Ma^2);
pstarf = @(Ma) sqrt(gf(Ma))/Ma;
fLDf = @(Ma)(1-Ma^2)/(k*Ma^2)+(k+1)/(2*k)*log(gf(Ma)*Ma^2);


%T�nker gissa p� ett massfl�de, se vad det f�r f�r konsekvenser, justrera
%tills massfl�det �r rimligt (det m�ste st�mma med grafen).

mdot = 0.25;

Re = Ref(mdot);
f = ff(Re);
V = Vf(Re, rho_e);
Ma_e = Maf(V);

%Anv�nds f�r att finna FLD_e, och p_estar;
fLD_e = fLDf(Ma_e);  %**********
%p_estar:    p_e/p* @ exit
p_estar = pstarf(Ma_e);  %***********

pstar = p_e/p_estar;
fLD_1 = fLD_e + f*L/D;

s = fLD_1;

Ma_1 = findMa(fLD_1, 0.0001); %Gissar p� n�t under 1 s� inte riskerar att
%f� samma l�sning f�r ovanf�r Ma = 1:

p_1star = pstarf(Ma_1); %**********

p_1 = pstar*p_1star;

dp = (p_1 - p_e)/1000 %kPa
mdot
p_comp = dpf(mdot)
f
%Titta om v�rdena st�mmer, annars �ndra v�rden, k�r igen.

%Stegade och testade 
%mdot = 0.2, 0.21, 0.22, 0.23, 0.24, 0.25, 0.26, 0.255.
%Resonerade att mdot = 0.25 fick duga eftersom avl�sning i grafen f�r
%bed�mning av rimlighet var f�r sv�rt.

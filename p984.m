clear;
%I detta skript har jag bara infört de värden som krävs för att klara
%uppgiften.

R = 287;
At = 0.0001;
T0 = 500;
mdot = 182.2/3600;
k = 1.4;
p0_e = 250600;
p0_1 = mdot*sqrt(R*T0)/(0.6847*At)

ek958 = @(Ma) ((k+1)*Ma^2/(2+(k-1)*Ma^2))^(k/(k-1))*...
    ((k+1)/(2*k*Ma^2-(k-1)))^(1/(k-1));

solveForMach = @(Ma) p0_e/p0_1 - ek958(Ma);


Ma1_guess = 1.5;
Ma1 = fsolve(solveForMach, Ma1_guess)

Ma2 = sqrt(((k-1)*Ma1^2+2)/(2*k*Ma1^2-(k-1)))


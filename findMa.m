
function Ma_sol = findMa(fLD, Ma_guess)
k = 1.4;

gf = @(Ma) (k+1)/(2+(k-1)*Ma^2);
fLDf = @(Ma)(1-Ma^2)/(k*Ma^2)+(k+1)/(2*k)*log(gf(Ma)*Ma^2);

Ma_solve = @(Ma) fLD - fLDf(Ma);
Ma_sol = fsolve(Ma_solve, Ma_guess);

Ma_sol = abs(Ma_sol); %Överallt förekommer Ma^2, vill ha positiv lösn
end


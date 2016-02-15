function F = eqSys(V, f, konst)
%EQSYS Non-linear eq that needs to be solved
fa = f(1);
fb = f(2);
f32 = f(3);

La = konst(1);
Lb = konst(2); 
L32 = konst(3);
dp = konst(4);
rho = konst(5);
d = konst(6);

Va = V(1);
Vb = V(2);
V32 = V(3);

f1 = fa*La*Va^2+f32*L32*V32^2 -dp/rho*d*2;
f2 = fb*Lb*Vb^2+f32*L32*V32^2 - dp/rho*d*2;
f3 = Va+Vb-V32;
F = [f1; f2; f3];

%F = [fa*La*Va^2+f32*L32*V32^2 -dp/rho*d*2;fb*Lb*Vb^2+f32*L32*V32^2 - dp/rho*d*2;Va+Vb-V32];
end


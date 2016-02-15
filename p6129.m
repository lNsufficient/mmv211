clear;
TOL = 1e-8;
TOLf = TOL/10;

g = 9.82;
rho = 998;
mu = 1e-3;
ny = mu/rho;
d = 0.08; %m
r = d/2;
eps = 0.0012; %m
epsd = eps/d; 
p12 = 750000; %Pa
h12 = p12/(rho*g);
L32 = 150; %m
La = 250; %m
Lb = 100; %m


kc = pi^2*g*d^5/8;

Vf = @(Q, r) Q/(pi*r^2);
Ref = @(V, d) V*d/ny;
%findF(f, Re, eps/d) definierad i funktionsskript.


%första gissning - ett långt rör:
Lguess = 300;
fold = 0.4;
f = 0.014;
%f = h*d/L*2g/V^2;
%V^2f = h*d/L*2g
v2f = h12*d/Lguess*2*g;

while (fold ~= f)
    fold = f;
    V = sqrt(v2f/fold);
    Re = Ref(V,d);
    f = findF(fold, Re, epsd, TOLf);
end
fa = f;
fb = f;
f32 = f;

Q = V*pi*r^2;
Qa = Q/2;
Qb = Qa;
Qold = -1;

v3 = V;





Qi = @(ci, h, f) (ci*h/f)^1/2;



parDenom = @(fa, fb, Ca, Cb) (sqrt(Ca/fa)+sqrt(Cb/fb))^2;
h13f = @(Qa, Qb, fa, fb, La, Lb, kc) (Qa + Qb)^2/parDenom(fa, fb, kc/La, kc/Lb);
Q = 0.027;

while abs(Qold - Q) > TOL;
    
    V32 = Vf(Q, r);
    Re32 = Ref(V32, d);
    f32 = findF(f32, Re32, epsd, TOLf);
    
    
    h32 = f32*L32*V32^2/(d*2*g);
    %h32 = 8*f32*L32*Q^2/(pi^2*g*d^5);
    h13 = (h12 - h32);
    if h13 <= 0
        h13 = h13test/2;
    end
    [Qa, fa] = findQi(h13, kc/La, fa, epsd, d, ny, TOLf);
    [Qb, fb] = findQi(h13, kc/Lb, fb, epsd, d, ny, TOLf);
    h13test = h13f(Qa, Qb, fa, fb, La, Lb, kc);

    
%     while abs(h13 - h13test) > TOL 
% 
%         %Hitta nästa Qa och Qb;
%         Qa = Qi(kc/La, h13, fa);
%         Va = Vf(Qa, r);
%         Rea = Ref(Va, d);
%         fa = findF(fa,Rea,epsd, TOLf);
% 
%         Qb = Qi(kc/Lb, h13, fb);
%         Vb = Vf(Qb, r);
%         Reb = Ref(Vb, d);
%         fb = findF(fb, Reb, epsd, TOLf);
%         
%         h13test = (Qa + Qb)/(kc*(sqrt(1/(La*fa))+sqrt(1/(Lb*fb)))^2);
%     end
    %endh
    
    Qold = Q;
    Q = Qa + Qb;
end

%%
disp('=====RESULTS=====')
h32= f32*L32/(d*2*g)*(Q/(pi*r^2))^2
h13
Q

%%

%%
% while abs(Qold - Q) > TOL;
%     %while abs(Q - (Qa+Qb)) > TOL
%         %Q = Qa+Qb;
%         h13 = Q/(kc*(sqrt(1/(La*fa))+sqrt(1/(Lb*fb)))^2);
% 
%         %Hitta nästa Qa och Qb;
%         Qa = Qi(kc/La, h13, fa);
%         Va = Vf(Qa, r);
%         Rea = Ref(Va, d);
%         fa = findF(fa,Rea,epsd, TOLf);
% 
%         Qb = Qi(kc/Lb, h13, fb);
%         Vb = Vf(Qb, r);
%         Reb = Ref(Vb, d);
%         fb = findF(fb, Reb, epsd, TOLf);
%         
%     %end
% 
%     V32 = Vf(Qa+Qb, r);
%     Re32 = Ref(V32, d);
%     f32 = findF(f32, Re32, epsd, TOLf);
%     
%     Qold = Q;
% 
%     Q = 1*((h12-f32*L32/(d*2*g)*(Q/(pi*r^2))^2)*kc*(sqrt(1/(La*fa))+sqrt(1/(Lb*fb)))^2);
%     Q
% end
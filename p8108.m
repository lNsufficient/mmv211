rho_w = 998;
SG = 7.85;
rho_s = SG*rho_w;
d = 0.02;
v_s = 4*pi*(d/2)^3/3;
m_s = rho_s*v_s;
Cd = 0.47;
A_s = pi*d^2/4;
g = 9.82;

U_max = sqrt(2*g*v_s*(SG-1)/(Cd*A_s))
U = U_max*0.99;

m_h = rho_w*v_s/2;

F = g*v_s*rho_w*(SG-1);
c = Cd*rho_w*A_s/2;

t99 = (m_s + m_h)/F*sqrt(F/c)*(atanh(sqrt(c/F)*U)-atanh(0))

U_max_no_h = 1.95;
t99_no_h = 0.605;

U_percent = U_max/U_max_no_h
t_percent = t99/t99_no_h
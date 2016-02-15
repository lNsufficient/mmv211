function [Q, f] = findQi(h, C, f, epsd, d, ny, TOL)
%Qi = findQi(h, L, g)
%   returns Q for a pipe in parallel

    Qi = @(h, C, f) (C*h/f)^(1/2);
    oldQ = -1;
    Q = Qi(h, C, f);
    
    while abs(oldQ-Q) > TOL;
        oldQ = Q;
        v = Q/(pi*(d/2)^2);
        Re = v*d/ny;
        f = findF(f, Re, epsd, TOL);
        Q = Qi(h, C, f);
    end   

end


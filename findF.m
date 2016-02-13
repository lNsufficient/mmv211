function f = findF(f, Re, ed, TOL)
    fr = @(f, Re, ed) (-2*log10(ed/3.7+2.51/(Re*sqrt(f))))^-2;
    oldF = f;
    f = fr(f, Re, ed);
    while abs(oldF-f) > TOL;
        oldF = f;
        f = fr(oldF, Re, ed);
    end
        
end
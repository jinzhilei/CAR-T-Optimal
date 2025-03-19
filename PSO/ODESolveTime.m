function pos = ODESolveTime(y0)
global md

TC = y0(6);

Z  = ODE(md.x0,md.h,md.xend,y0) ;  % 求解ode方程
AA = abs(Z(2:end,2)-TC);
xx = min(AA);
J  = find(AA==xx) +1;

pos = Z(J,1);
end
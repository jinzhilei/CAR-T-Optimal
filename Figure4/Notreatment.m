function Notreatment()
global md

control();
parameter();

y0 = initialzation();
y0(1) = 0;
y0(2) = 0;

Y = ModelSolver(md.t0,md.h,md.tend,y0);
dlmwrite('output/notreatment.dat',Y);
end
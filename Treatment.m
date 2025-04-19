function Treatment()
global md par

control();
parameter();

y0 = initialization();

Y = ModelSolver(md.t0,md.h,md.tend,y0);
dlmwrite('Figure5/output/md.dat',Y,' ');
end
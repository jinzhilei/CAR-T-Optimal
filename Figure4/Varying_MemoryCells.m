function Varying_MemoryCells()
global md

M0 =    [1*10^3, 2*10^3,   4*10^3,  6*10^3,  8*10^3, 10*10^3];
m=length(M0);

control();
parameter();
y0 = initialization();

for j=1:m
    y0(2) = M0(j);
    Y = ModelSolver(md.t0,md.h,md.tend,y0);
    dlmwrite(strcat('output/VM-',num2str(j),'.dat'),Y);
end
end
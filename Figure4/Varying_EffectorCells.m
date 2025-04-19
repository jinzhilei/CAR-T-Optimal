function Varying_EffectorCells()
global md par

E0 = [2*10^6,  5*10^6,  7*10^6, 9*10^6, 10*10^6, 12*10^6, 15*10^6, 20*10^6];
m=length(E0);

control();
parameter();
y0 = initialization();

for j=1:m
    y0(1) = E0(j);
    Y = ModelSolver(md.t0,md.h,md.tend,y0);
    dlmwrite(strcat('output/VE-',num2str(j),'.dat'),Y);
end
end
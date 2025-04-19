%
% This function solve the tumor evolution dynamics with initial value
% obtained from PSO
%

function solve()
global md

addpath('../');

control();
parameter();

y0=initialization_POS();

y = ModelSolver(md.t0,md.h,md.tend,y0);
dlmwrite('md.dat',y,' ');
end

function y0=initialization_POS()
P=load('Optimal3.dat');
[B,J]=sort(P(:,1));
k=J(1);
Y = P(k,:);
TC = Y(1);
T4 = Y(4);
TP = Y(5);
TE = Y(6);
TM = Y(7);
TR = Y(8);
M = 1*10^2;

y0 = [T4;TP;TE;TM;TR;TC;M];
end
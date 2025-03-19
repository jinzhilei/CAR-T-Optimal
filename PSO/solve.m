function solve()
control();
parameter();
% initialzation();

global md par
x0=md.x0;
xend=md.xend;
h=md.h;


for i=1:10
%     for i=1:12 %舍去在4.6*10^6处的点
y0=initialzation(i);

y=ODE(x0,h,xend,y0,i)
end
end
function know()
global md par 

control();
parameter();

%% 输入肿瘤数量
TCs = [ 10^6 : 10^5 : 6*10^6];
% TCs = [10^7,1.1*10^7, 1.2*10^7,1.3*10^7, 1.4*10^7,1.5*10^7, 1.6*10^7,1.7*10^7, 1.8*10^7,1.9*10^7, 2*10^7,2.1*10^7,2.2*10^7,2.3*10^7,2.4*10^7,2.5*10^7,2.6*10^7,2.7*10^7,2.8*10^7,2.9*10^7,3*10^7,];
m=length(TCs);
D=zeros(m,8);

for j=1:m
    TC = TCs(j);
    D0 = OptimalValue(TC);
    D(j,:) = D0;
end
dlmwrite('output/Optimal.dat',D);
D
end
 


%%
% This function examine the effects of changing the initial number of CAR-T
% cells. The result generate Figure 6 in the paper
%% 

function VariedInitialCells()
global md par

control();
parameter();
par.lambda1 = 0.25;    %\lambda_T4I2

% Plan A
for i=1:6
    y0 = PlanA(i);
    Y = ModelSolver(md.t0,md.h,md.tend,y0);
    dlmwrite(strcat('Figure6/PlanA/md',num2str(i),'.dat'),Y,' ');
    T0 = findPFS(Y(:,[1,7]));
    PFS_A(i,1)=T0;    
end
    dlmwrite(strcat('Figure6/PFS_A.dat'),PFS_A,' ');

%Plan B
for i=1:6
    y0 = PlanB(i);
    Y = ModelSolver(md.t0,md.h,md.tend,y0);
    T0 = findPFS(Y(:,[1,7]));
    dlmwrite(strcat('Figure6/PlanB/md',num2str(i),'.dat'),Y,' ');
    PFS_B(i,1) = T0;
end
 dlmwrite(strcat('Figure6/PFS_B.dat'),PFS_B,' ');
%Plan C
for i=1:7
    y0 = PlanC(i);
    Y = ModelSolver(md.t0,md.h,md.tend,y0);
    T0 = findPFS(Y(:,[1,7]));
    dlmwrite(strcat('Figure6/PlanC/md',num2str(i),'.dat'),Y,' ');
    PFS_C(i,1) = T0;
end
 dlmwrite(strcat('Figure6/PFS_C.dat'),PFS_C,' ');
end


%function of PlanA
function y0=PlanA(i)
y0=initialization();
if (i>1)
      y0(i-1) = 5*y0(i-1);
end
end

%function of PlanB
function y0 = PlanB(i)
y0=initialization();
Y = sum(y0(1:5));
TotalDose = [1e6 5e6 10e6 15e6 Y 25e6];
y0(1:5) = (TotalDose(i)/Y) * y0(1:5);
end

%function of Planc
function y0 = PlanC(i)
y0=initialization();
Ratio = [10 10000 10000 1 1;
    20 10000 10000 0.5 1;
    10 15000 5000  1   1;
    20 15000 5000  0.5 1;
    5  10000 10000 5   1;
    10 5000  15000 1   1;
    5  5000  15000 5   1;];
TotalDose=sum(y0(1:5));
sum_Ratio(i)=sum(Ratio(i,:));
y0(1:5) = (Ratio(i,:)/sum_Ratio(i))' * TotalDose;

end





%
% This program generate the optimized CAR-T doses with given initial tumor cell number
% The optimized doses are obtained using the PSO method
%

function Optimization()
control();
parameter();

%% Enter the number of tumors
TCs = randc(1*10^6, 6*10^6, 400);
m=length(TCs);
D=zeros(m,8);

for j=1:m
    TC = TCs(j);
    D0 = OptimalValue(TC);
    D(j,:) = D0;
end
dlmwrite('Figure7/Optimal3.dat',D);
end
 
%
%% Get the optimal value with initial tumor cell number given by TC 
%
function D0=OptimalValue(TC)
D0 = zeros(1,8);
%% parameterization  
N = 100;                         % Initial population size   
Y = Initial_scope(TC,N);
[fym,ym] = FindOptimization(Y,N);
YM=sum(ym);
D0(1)=TC;%Number of tumor cells
D0(2)=fym;%PFS
D0(3)=YM;%Total Dose
D0(4:8)=ym;%Various subtype doses
end

% 
% Find the optimization doses with the PSO method
%
function [fym,ym]=FindOptimization(Y,N)
global md 

d = 5;                          % dimension of a feasible solution 
ger = 20;                       % Maximum number of iterations       
limit = [1*10^3,2*10^7];        % Setting position parameter limits  
vlimit = [-30, 30];           % Setting Speed Limits  
w = 0.8;                        % inertial weighting   
c1 = 0.5;                       % Self-learning factor 2, 1 
c2 = 0.5;


Y0 = Y;
x = Y0(1:5,:)';                 %Location of the initial population
v = rand(N,d);                 %Velocity of the initial population
xm = x;                      %The best place in history for each individual
ym = zeros(1, d);            %Historical optimal position of the stock
fxm = zeros(N,1);            %Historical best fit for each individual
fym = 0;                    %Historical optimal fitness of populations

iter=1;
while iter <= ger
       
    PFS = zeros(N,1);
    Emax = zeros(N,1);

    for i = 1 : N 
        y0 = Y0(:,i);
        pos = ModelSolver(md.t0,md.h,md.tend,y0);
        T0 = findPFS(pos(:,[1,7]));
        PFS(i) = T0;
        Emax(i) = max(pos(:,3));
    end
    fx=PFS';           %Individual Current Adaptation
    for  k = 1 : N
         if  (fx(k) > fxm(k)) & (Emax(k) < 1e15)
             fxm(k)=fx(k);
             xm(k,:)=x(k,:);
         end
    end
    if max(fxm) > fym
        [fym,nmax]=max(fxm);
        ym = xm(nmax,:);
    end
    
    iter = iter+1;
       
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, 1, 1) - x); % 速度更新  
    % Boundary velocity processing  
    v(v > vlimit(2)) = vlimit(2);  
    v(v < vlimit(1)) = vlimit(1);  
    % Location Updates
    
    x = x + v;
    Y0 = [x, Y(6,:)', Y(7,:)']';
    % Boundary position processing  
    x(x > limit(2)) = limit(2);  
    x(x < limit(1)) = limit(1);  
  
end
end

%
% Scope pf initial CAR-T cell counts
%

function Y = Initial_scope(TC,N)

Y=zeros(7,N);

Dose = 10 *TC;
Y(1,:) =  randc(Dose*(10/20012), (15/20012)*Dose, N);%T4
Y(2,:) =  randc(Dose*(8000/20012), (12000/20012)*Dose, N);%TP
Y(3,:) =  randc(Dose*(8000/20012), (12000/20012)*Dose, N);%TE
Y(4,:) =  randc(Dose*(0.1/20012), (1.5/20012)*Dose, N);%TM
Y(5,:) =  randc(10,2000,N);    %Tr
Y(6,:) = TC * randc(1,1,N);    % Cancer cells number 
Y(7,:) = 1*10^2 * randc(1,1,N);

end

function y0=randc(a,b,n)
y0 = a + (b-a)*rand(1,n);
end

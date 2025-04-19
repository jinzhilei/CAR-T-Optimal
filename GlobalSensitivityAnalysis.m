%% The function GlobalSensitivityAnalysis perform global sensitivity analysis withrespect to default parameters.

function GlobalSensitivityAnalysis()

%% Basic code
global md;
control();
y0=initialization();

%% Run the model with default parameter values
parameter();
B0 = ModelSolver(md.t0,md.h,md.tend,y0);
dlmwrite(strcat('Figure2/output/md.dat'),B0,' ');
Basic_PFS = findPFS(B0(:,[1,7]));

%% Load the parameters with perturbations
ParasSensitive(0.1, 1000);
S = load("Figure2/Parameter.dat");
n = length(S);

%% Computer
m0 = floor((md.tend - md.t0)/md.h)+1;
A = zeros(n+1,m0);
Para_PFS= zeros(n,1);
for i=1:n
    parameterprepare(i,S);
    B = ModelSolver(md.t0, md.h, md.tend, y0);
    dlmwrite(strcat('Figure2/output/md',num2str(i),'.dat'),B,' ');
    Para_PFS(i,1) = findPFS(B(:,[1,7]));
  
    for k=1:m0
        A(1,k)=B(k,1);
        A(i+1,k) = log(B(k,7)/B0(k,7));
    end
end
PFS = (Para_PFS - Basic_PFS)/Basic_PFS; 
dlmwrite('Figure2/PFS.dat',PFS);
dlmwrite('Figure2/Tumor.dat',A);
dlmwrite('Figure2/Para_PFS.dat',Para_PFS);
end

%% parameters 
function parameterprepare(i,S)
global par

    par.a2 = S(i,4); 
    par.a3 = S(i,5);  

    par.lambda_TM = S(i,1);
    par.lambda_C = S(i,2);   

    par.lambda1=S(i,15);
    par.lambda2=S(i,16);
    par.lambda3=S(i,3);
    par.lambda4=S(i,17);
    par.lambda5=S(i,18);
    

    par.lambda6=S(i,19);
    par.lambda7=S(i,20);
    par.lambda8=S(i,21);
    par.lambda9=S(i,22);
    par.lambda10=S(i,23);

  
    par.KTP = S(i,24);
    par.KT4 = S(i,25); 
    par.KTr = S(i,26); 
    par.KI2 =S(i,27);
    par.KI6 =S(i,28);
    par.KIgamma = S(i,29);
    par.KTbeta = S(i,30);

    par.K1 = S(i,12);
    par.K2 = S(i,13); 
    par.K3 = S(i,14);
    par.KTM0 = S(i,31);
    par.KTM1 = S(i,32);
    par.KC = S(i,33); 
    par.M0=S(i,34);

   
    par.kT4 = S(i,7) ;
    par.kTE = S(i,6); 

   
    par.dT4=S(i,8);
    par.dTP=S(i,9);
    par.dM=S(i,35);
    par.dTr=S(i,36);
    par.dTE = S(i,10);
    par.dTM = S(i,37);
    par.dC = S(i,11);
    par.dI2=S(i,38);
    par.dTbeta=S(i,39);
    par.dIgamma=S(i,40);
    par.dI6=S(i,41);
end

%% Generating randomized perturbation parameters
function S = ParasSensitive(r, N0)
global par N_pars;
N_pars = N0;
S = zeros(N_pars,41);
parameter();
S(:,1) = perturb(par.lambda_TM,r);
S(:,2) = perturb(par.lambda_C,r);
S(:,3) = perturb(par.lambda3,r);
S(:,4) = perturb(par.a2,r);
S(:,5) = perturb(par.a3,r);
S(:,6) = perturb(par.kTE,r);
S(:,7) = perturb(par.kT4,r);
S(:,8) = perturb(par.dT4,r);
S(:,9) = perturb(par.dTP,r);
S(:,10) = perturb(par.dTE,r);
S(:,11) = perturb(par.dC,r);
S(:,12) = perturb(par.K1,r);
S(:,13) = perturb(par.K2,r);
S(:,14) = perturb(par.K3,r);
S(:,15) = perturb(par.lambda1,r);
S(:,16) = perturb(par.lambda2,r);
S(:,17) = perturb(par.lambda4,r);
S(:,18) = perturb(par.lambda5,r);
S(:,19) = perturb(par.lambda6,r);
S(:,20) = perturb(par.lambda7,r);
S(:,21) = perturb(par.lambda8,r);
S(:,22) = perturb(par.lambda9,r);
S(:,23) = perturb(par.lambda10,r);
S(:,24) = perturb(par.KTP,r);
S(:,25) = perturb(par.KT4,r);
S(:,26) = perturb(par.KTr,r);
S(:,27) = perturb(par.KI2,r);
S(:,28) = perturb(par.KI6,r);
S(:,29) = perturb(par.KIgamma,r);
S(:,30) = perturb(par.KTbeta,r);
S(:,31) = perturb(par.KTM0,r);
S(:,32) = perturb(par.KTM1,r);
S(:,33) = perturb(par.KC,r);
S(:,34) = perturb(par.M0,r);
S(:,35) = perturb(par.dM,r);
S(:,36) = perturb(par.dTr,r);
S(:,37) = perturb(par.dTM,r);
S(:,38) = perturb(par.dI2,r);
S(:,39) = perturb(par.dTbeta,r);
S(:,40) = perturb(par.dIgamma,r);
S(:,41) = perturb(par.dI6,r);

dlmwrite('Figure2/Parameter.dat',S);

end

function p0 = perturb(p,r)
global N_pars;
p0 = p *(1 + 2 * r * (rand(N_pars,1) - 0.5*ones(N_pars,1)));
end
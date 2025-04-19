function parameter()
global par

%%
par.a2 = 0.26e-4;  %\lambda_T{E->M}
par.a3 = 0.1e-5;       %\lambda_T{M->E}

par.lambda_TM = 0.02;  % \lambda_TM
par.lambda_C = 3.3;          % \lambda_C

par.lambda1 = 0.25;    %\lambda_T4I2
par.lambda2 = 1.5;      % \lambda_TpI2
par.lambda3 = 0.2;     % \lambda
par.lambda4=0.038;   %\lambdaTrI2
par.lambda5=0.25;     %\lambda_MI\gamma

%% parameters of cytokines
par.lambda6 = 0.46e-4;  %I2
par.lambda7=0.74e-9;   % Igamma_1
par.lambda8=0.58e-9;   % Igamma_2
par.lambda9=0.11e-4;   % Tbeta
par.lambda10=0.52e-5; %I6


%% 
par.KTP = 5e7;
par.KT4 = 1e4; 
par.KTr = 1e4;
par.KI2 = 1e-1;
par.KI6 = 2.5e-3;
par.KIgamma = 1e-2;
par.KTbeta = 1e-3;
 
par.K1 = 0.05;
par.K2 = 0.04;
par.K3 = 0.001;
par.KTM0 = 0.2;
par.KTM1 = 20;
par.KC = 5e7;
par.M0 = 1e3;

%% 
par.kT4 = 0.08; 
par.kTE = 3.57;
%%  
par.dT4=0.20;
par.dTP=0.07;
par.dM=0.03;
par.dTr=0.06;
par.dTE = 0.18;
par.dTM = 0.0065;
par.dC=0.075;
par.dI2 = 7.7;
par.dTbeta = 5.0;
par.dIgamma=4.16;
par.dI6=4.0;
end
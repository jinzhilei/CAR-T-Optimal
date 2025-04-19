function parameter()
global par

%%
par.a2 = 0.26*10^(-4);   %\lambda_T{E->M}
par.a3 = 0.1*10^(-5);   % \lambda_T{M->E}


par.lambda_TM = 0.02;
par.lambda_C = 3.3;  

%% 
par.K1 = 0.05; 
par.K2 = 0.04;  
par.KTM0 = 0.2;
par.KTM1 = 20;
par.KC = 5e7; %sure


%% 
par.kTE = 3.8; 

%% 
par.dTE = 0.18; %sure
par.dTM = 0.0065;
par.dC = 0.075;  %sensitive parameters
end
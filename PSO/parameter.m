function parameter()
global par

%%
par.a2 = 0.258e-4; % TE转化为TM的转化率
par.a3 = 0.1e-5;  % TM转化为TE的转化率

par.lambda_TM = 0.0212
par.lambda_C = 3.3;   %sure  

par.lambda1=0.025;%IL-2对T4的激活率
par.lambda2=0.075;%IL-2对TP的增殖率
par.lambda3=0.04;%IL-6和IFN-gamma对TP分化成TE的分化率
par.lambda4=0.038;%IL-2对Tr的增殖率
par.lambda5=0.25;% IFN- gamma 对M的激活率

%细胞因子(ng·ml-1·day-1·cell-1)
par.lambda6=0.46*10^(-5);%T4对IL-2的产生率
par.lambda7=0.74*10^(-4);%TE对IFN-gamma的产生率
par.lambda8=0.58*10^(-5);%T4对IFN-gamma的产生率
par.lambda9=1.1*10^(-7);%Tumor对TGF-beta的产生率
par.lambda10=0.52*10^(-3);%M对IL-6的产生率


%% 细胞
par.KTP = 7e9;
par.KT4 = 10^4; %sure
par.KTr = 1*10^3; %sure 
par.KTM = 5*10^2;
par.KI2 =10^(-3);
par.KI6 =10^(-5); 
par.KIgamma = 10^(-5);
par.KTbeta = 10^(-5);
 
par.K1 = 0.05;%和CAR-TE的结合解离常数
par.K2 = 0.03; %和CAR-TM的结合解离常数
par.K3 = 0.001;%和CAR-T4的结合解离常数
par.KTM0 = 0.15;%没有肿瘤T_M的增殖率
par.KTM1 = 0.368;%有肿瘤的增值率
par.KC = 5e8; %sure
par.M0=10^5;


%% 细胞的杀伤
par.kT4 = 0.08; %sure
par.kTE = 3.4; %sure

%% Death or Degradation 
par.dT4=0.197;
par.dTP=0.07;
par.dM=0.03;
par.dTr=0.06;
par.dTE = 0.09;
par.dTM = 0.25e-2;
par.dC = 0.132;  
par.dI2=76.78;
par.dTbeta=49.91;
par.dIgamma=4.16;
par.dI6=4.16;
end
%% 体内只含有 CAR-T4 CAR-Tp CAR—TE，CAR-TM，CAR-Tr,Tumor；

function z = funs(x,y)
global par

m=length(y);
z=zeros(m,1);

% 细胞因子
I2 = par.lambda6 * y(1) / par.dI2;
Tbeta = par.lambda9 * y(6) / par.dTbeta;
Igamma = ((par.lambda7 + par.lambda8) * (1 / (1 + y(5)/par.KTr) + 1 / (1 + Tbeta/par.KTbeta)))/par.dIgamma;
I6 = par.lambda10 * y(7)/ par.dI6;

star = cstar(y);
%T4 cell
z(1) = par.lambda1 * y(1) * ( I2 / par.KI2 + I2 ) - par.dT4 * y(1); 
%Tp cell
z(2) = par.lambda2 * y(2) * ( I2 / par.KI2 + I2 )  * (1 / (y(5) / par.KTr)) - par.lambda3 * y(2) * ((I6 / (par.KI6 + I6)) +( Igamma / (par.KIgamma + Igamma ) ) ) - par.dTP * y(2);
%TE cell
z(3) = par.lambda3 * y(2) *  ((I6 / (par.KI6 + I6)) +( Igamma / (par.KIgamma + Igamma ) ) ) + par.a3  * (par.K2 * star  / (1 + par.K2 * star)) * y(4) - par.a2 * y(3) -par.dTE * y(3); 

KTM = (par.KTM0 + par.KTM1 * ((par.K2 * star)/(1 + par.K2 * star )));

%TM cell
z(4) = par.lambda_TM * (par.KTM /(par.KTM + y(4))) * y(4) + par.a2 * y(3) -  par.a3 * (par.K2 * star)/ (1 + par.K2 * star ) * y(4) - par.dTM * y(4); % a_2 : the rate of T_E differentiate T_M ; a_3 : the rate of T_M differentiate T_E ; 
%Tr cell
z(5) = par.lambda4 * y(5) * ( I2 / par.KI2 + I2 )  - par.dTr * y(5);
%Tumor
z(6) = par.lambda_C  *  ( par.KC / ( par.KC + y(6))) * y(6) - par.kTE  * ((par.K1 * y(3))/(1 + par.K1 * ((y(3))/(1 + par.K1 * star)) + par.K2 * ((y(4))/(1 + par.K2 * star)) +par.K3 * (y(1)/(1 + par.K3 * star))+ par.K1 * y(6))) * (1 / (1 + y(5) / par.KTr))* y(6)  - par.kT4  *  ((par.K3 *y(1))/(1 + par.K1 * ((y(3))/(1 + par.K1 * star)) + par.K2 * ((y(4))/(1 + par.K2 * star)) + par.K3 * (y(1)/(1 + par.K3 * star))+ par.K3 * y(6)))* (1 / ( 1 + y(5) / par.KTr))* y(6) - par.dC *y(6);
% M cell 
z(7) = par.lambda5 * par.M0 * ( Igamma / (par.KIgamma + Igamma ) ) - par.dM * y(7);

end

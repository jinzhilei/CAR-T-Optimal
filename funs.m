%% subtype CAR-T cell ，tumor；

function z = funs(t,y)
global par

m=length(y);
z=zeros(m,1);

T4 = y(1);
TP = y(2);
TE = y(3);
TM = y(4);
TR = y(5);
C = y(6);
M = y(7);

%% Cytokines
I2 = par.lambda6 * T4 / par.dI2;
Tbeta = par.lambda9 * C / par.dTbeta;
Igamma = ((par.lambda7 * TE + par.lambda8 * T4) * (1 / (1 + TR/par.KTr) + 1 / (1 + Tbeta/par.KTbeta)))/par.dIgamma;
I6 = par.lambda10 * M/ par.dI6;

star = cstar(y);
%T4 cell
z(1) = par.lambda1 * T4 * ( I2 / (par.KI2 + I2) ) - par.dT4 * T4; 
%Tp cell
z(2) = par.lambda2 * TP * ( I2 / (par.KI2 + I2) )  * (1 / (1+TR / par.KTr)) - par.lambda3 * TP * ((I6 / (par.KI6 + I6)) +( Igamma / (par.KIgamma + Igamma ) ) ) - par.dTP * TP;
%TE cell
z(3) = par.lambda3 * TP *  ((I6 / (par.KI6 + I6)) +( Igamma / (par.KIgamma + Igamma ) ) ) + par.a3  * (par.K2 * star  / (1 + par.K2 * star)) * TM - par.a2 * TE -par.dTE * TE; 

KTM = (par.KTM0 + par.KTM1 * ((par.K2 * star)/(1 + par.K2 * star )));

%TM cell
z(4) = par.lambda_TM * (KTM /(KTM + TM)) * TM + par.a2 * TE -  par.a3 * (par.K2 * star)/ (1 + par.K2 * star ) * TM - par.dTM * TM; % a_2 : the rate of T_E differentiate T_M ; a_3 : the rate of T_M differentiate T_E ; 
%Tr cell
z(5) = par.lambda4 * TR * ( I2 / (par.KI2 + I2) )  - par.dTr * TR;
%Tumor
TEs = TE/(1 + par.K1 * star);
TMs = TM/(1 + par.K2 * star);
T4s = T4/(1 + par.K3 * star);
kill1 = par.kTE * par.K1 * TE/(1 + par.K1 * TEs + par.K2 * TMs + par.K3 * T4s + par.K1 * C) * (1/(1 + TR/par.KTr));
kill2 = par.kT4 * par.K3 * T4/(1 + par.K1 * TEs + par.K2 * TMs + par.K3 * T4s + par.K1 * C) * (1/(1 + TR/par.KTr));
z(6) = par.lambda_C  *  ( par.KC / ( par.KC + C)) * C - par.dC * C - kill1 * C - kill2 * C;
% M cell 
z(7) = par.lambda5 * par.M0 * ( Igamma / (par.KIgamma + Igamma ) ) - par.dM * M;

end

%% Cstar 
function Cs = cstar(y)

T4 = y(1);
TE = y(3);
TM = y(4);
C = y(6);
eps = 1;
Cs1 = C;
Cs = 0;
while (abs(Cs1 - Cs)>eps)
    Cs = Cs1;
    Cs1 = f(TE, TM,T4, C, Cs);
end
Cs = Cs1;
end

function c0 = f(TE, TM,T4, C, Cs)
global par
c0 = C / (1 + par.K1 * (TE / (1 + par.K1 * Cs)) + par.K2 * (TM/( 1 + par.K2 * Cs)) + par.K3 * (T4 / (1 + par.K3 *Cs )));
end

%% The coarse-grained model with only  CAR—TE，CAR-TM，and Tumor cells

function z = funs(t,y)
global par

TE = y(1);
TM = y(2);
C = y(3);

m=length(y);
z=zeros(m,1);

star = cstar(y);
z(1) = par.a3  * ((par.K2 * star)/ (1 + par.K2 * star )) * TM - par.a2 * TE -par.dTE * TE; 

KTM = (par.KTM0 + par.KTM1 * ((par.K2 * star)/(1 + par.K2 * star )));
z(2) = par.lambda_TM * (KTM /(KTM + TM)) * TM + par.a2 * TE -  par.a3 * (par.K2 * star)/ (1 + par.K2 * star ) * TM - par.dTM * TM;  % a_2 : the rate of T_E differentiate T_M ; a_3 : the rate of T_M differentiate T_E ; 

TEs = TE/(1 + par.K1 * star);
TMs = TM/(1 + par.K2 * star);
z(3) = par.lambda_C  *  ( par.KC / ( par.KC + C)) * C - par.kTE  * ((par.K1 * TEs)/(1 + par.K1 * TEs + par.K2 * TMs + par.K1 * C)) *  C  - par.dC * C;

end


%% Cstar 
function Cs = cstar(y)
TE = y(1);
TM = y(2);
C = y(3);
eps = 1;
Cs1 = C;
Cs = 0;
while (abs(Cs1 - Cs)>eps)
    Cs = Cs1;
    Cs1 = f(TE, TM, C, Cs);
end
Cs = Cs1;
end

function c0 = f(TE, TM, C, Cs)
global par
c0 = C / (1 + par.K1 * (TE / (1 + par.K1 * Cs)) + par.K2 * (TM/( 1 + par.K2 * Cs)));
end
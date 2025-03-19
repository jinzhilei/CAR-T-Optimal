%% Cstar ：体内游离的肿瘤细胞
function Cs = cstar(y)
T4 = y(1);
TE = y(3);
TM = y(4);
eps = 1;
C = y(6);
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
c0 = C / (1 + par.K1 * (TE / (1 + par.K1 * Cs)) + par.K2 * (TM/( 1 + par.K2 * Cs)) + par.K3 * (T4 / (1 +par.K3 *Cs )));
end
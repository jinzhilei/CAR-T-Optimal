function Figure9()
fig=figure(1);
clf();
A=load('md.dat');
B=load('../Figure5/output/md.dat');

m=size(A,1);
Y=zeros(m,5);
for i=1:m
    Y(i,1) = A(i,1);
    [k1,k2] = killingrates(A(i, 2:8));
    Y(i,2:3) = [k1,k2];
    [k1,k2] = killingrates(B(i, 2:8));
    Y(i,4:5) = [k1,k2];    
end

xt = -40;
figure(1);
clf();
subplot(2,2,1);
hold on;
plot(Y(:,1),Y(:,4),'k--');
plot(Y(:,1),Y(:,2),'r-');
legend('contol','PSO');
box on;
xlabel('Time (day)');
xlim([0 200]);
ylim([0 4]);
ylabel('Killing by CAR-T_E');
text(xt, 4,'(a)','fontweight','bold');

subplot(2,2,2);
hold on;
plot(Y(:,1),Y(:,5),'k--');
plot(Y(:,1),Y(:,3),'r-');
xlim([0 200]);
ylim([0 3e-6]);
legend('control','PSO');
box on;
xlabel('t');
ylabel('killing by CAR-T_4');
text(xt,3e-6,'(b)','fontweight','bold');

exportfig(fig,'Figure9.eps','color','cmyk','fontmode','scaled','fontsize',1);

end


%% Cstar 
function Cs = cstar(y)
T4 = y(1);
TE = y(2);
TM = y(3);
C = y(4);
eps = 1;
Cs1 = C;
Cs = 0;
while (abs(Cs1 - Cs)>eps)
    Cs = Cs1;
    Cs1 = f(T4, TE, TM, C, Cs);
end
Cs = Cs1;
end

function c0 = f(T4, TE, TM, C, Cs)
global par
a1 = par.K1 * (TE /(1 + par.K1 * Cs));
a2 = par.K2 * (TM/(1 + par.K2 * Cs));
a3 = par.K3 * (T4/(1 + par.K3*Cs));
c0 = C / (1 + a1 + a2 + a3);
end

function [k1,k2] = killingrates(y)
global par
T4 = y(1);
TE = y(3);
TM = y(4);
TR = y(5);
C = y(6);

Cs = cstar([T4, TE, TM, C]);
TEs = TE/(1 + par.K1 * Cs);
TMs = TM/(1 + par.K2 * Cs);
T4s = T4/(1 + par.K3 * Cs);
a = 1/(1 + TR/par.KTr);
k1 = par.kTE  * ((par.K1 * TEs)/(1 + par.K1 * TEs + par.K2 * TMs + par.K3 * T4s + par.K1 * C)) * a;
k2 = par.kT4 * ((par.K3 * T4)/(1 + par.K1 * TEs + par.K2 * TMs + par.K3 * T4s + par.K1 * C)) * a;
end


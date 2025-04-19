%% The optimal dose for the subtype obtained by PSO is averaged for every 0.5*10^6
% D= tumor noprogress total T4 Tp TE TM T
function Figure10()
global md
addpath('../');
D0=load('Optimal3.dat');
m=size(D0,1);

[B,J]=sort(D0(:,1));
D=D0(J,:);

control();
parameter();
 
% Calculate the average of CAR-T cells over tumor cell numbers.

TC = [1:0.5:6]*10^6;
n = length(TC);
Y = zeros(m,8);

M =10^2;
for i=1:n-1
    J = find(D(:,1)>= TC(i) & D(:,1)<TC(i+1));
    T4 = mean(D(J, 4));
    TP = mean(D(J, 5));
    TE = mean(D(J, 6));
    TM = mean(D(J, 7));
    TR = mean(D(J, 8));
    averTotalDose = T4 + TP + TE + TM + TR;
    for j=1:length(J)
        k = J(j);
        Y(k,1) = T4;
        Y(k,2) = TP;
        Y(k,3) = TE;
        Y(k,4) = TM;
        Y(k,5) = TR;
        Y(k,6) = D(k,1);
        Y(k,7) = M;
        Y(k,8) = averTotalDose;
    end
end

fig=figure(1);
clf();

%% Proportionality calculation

xt = 0.1e6;

subplot(3,2,1);
Y1 = zeros(m,3);
for i=1:m
    y0 = Y(i,1:7)';
    Z = ModelSolver(md.t0, md.h, md.tend, y0);
    PFS = findPFS(Z(:,[1,7]));
    Y1(i,1) = y0(6);
    Y1(i,2) = PFS;
    Y1(i,3) = Y(i,8);
end

yyaxis right
hold on;
plot(Y1(:,1), Y1(:,2),'o-','markersize',3);
xlim([1e6 6e6]);
ylim([50 120]);
xlabel('Tumor (cell)')
ylabel('PFS (day)')

yyaxis left
plot(Y1(:,1), Y1(:,3), '^-','markersize',3);
ylim([0.5e6 6e7]);
xlim([1e6 6e6]);
ylabel('Total Dose (cell)');
set(gca,'fontsize',8);
box on
text(xt, 6e7,'(a)','fontweight','bold');


%% Proportion of cells

tumor = Y(:,6);
bili1=Y(:,1)./Y(:,8);    % T4
bili2=Y(:,2)./Y(:,8);   % TP
bili3=Y(:,3)./Y(:,8);   % TE
bili4=Y(:,4)./Y(:,8);   % TM
bili5=Y(:,5)./Y(:,8);   % TR

x0 = 0.56;
y0 = 0.77;
xh = 0.34;
yh = 0.158;
dy = yh + 0.023;

axes('Position',[x0 y0 xh yh]);
yyaxis right;
plot(tumor,bili1,'color',[250 200 205]/255,'linewidth',1);
xticks([]);
ylim([7.5e-4, 8.0e-4]);
ylabel('T_4')

yyaxis left;
plot(tumor,bili4,'color',[0 161 241]/255,'linewidth',1);
xticks([]);
ylim([3.5e-5, 5e-5]);
ylabel('T_M');
xlim([1e6 6e6]);
set(gca,'fontsize',8);
text(xt,5e-5,'(b)','fontweight','bold');

y0 = y0 - dy;
axes('Position',[x0 y0 xh yh]);
yyaxis right;
plot(tumor,bili2,'color',[246 83 20]/255,'linewidth',1);
xticks([]);
ylim([0.47, 0.51]);
ylabel('T_P');

yyaxis left;
plot(tumor,bili3,'color',[124 187 0]/255,'linewidth',1);
xticks([]);
ylim([0.49, 0.53]);
ylabel('T_E');
xlim([1e6 6e6]);
set(gca,'fontsize',8);

y0 = y0 - dy;
axes('Position',[x0 y0 xh yh]);
hold on;
plot(tumor,bili5,'color',[0.49 0.18 0.56],'linewidth',1);
ylim([0.2e-5, 1e-4]);
box on;
set(gca,'Yscale','log');
xlim([1e6 6e6]);
xlabel('Tumor (cell)');
ylabel('T_R');
set(gca,'fontsize',8);
%% PFS with random value within a given range

Y1 = zeros(m,2);
for i=1:m
       Td = Y(i,8);
        rT4 = randc(7.5e-4, 8.0e-4);
        rTp = randc(0.47, 0.51);
        rTe = randc(0.49, 0.53);
        rTm = randc(3.5e-5, 5e-5);
        rTr = randc(0.2e-5, 1e-4);
        r0 = rT4 + rTp + rTe + rTm + rTr;

        T4 = Td * rT4/r0;
        Tp = Td * rTp/r0;
        Te = Td * rTe/r0;
        Tm = Td * rTm/r0;
        Tr = Td * rTr/r0;

        y0 = [T4; Tp; Te; Tm; Tr; Y(i,6); Y(i,7)]; 
        Z = ModelSolver(md.t0, md.h, md.tend,y0);
        PFS = findPFS(Z(:,[1,7]));
        Y1(i,1) = y0(6);
        Y1(i,2) = PFS;
end

subplot(3,2,3);
plot(Y1(:,1),Y1(:,2),'r*','markersize',3);
xlim([1e6 6e6]);
ylim([60 110]);
xlabel('Tumor (cell)');
ylabel('PFS (day)');

text(xt,110,'(c)','fontweight','bold');
set(gca,'fontsize',8);

exportfig(fig,'Figure9.eps','color','cmyk','fontmode','scaled','fontsize',1);

end


function y0=randc(a,b)
y0 = a + (b-a)*rand();
end


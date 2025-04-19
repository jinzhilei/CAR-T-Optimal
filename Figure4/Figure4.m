function Figure4()
global md
fig=figure(1);
clf();
%%
subplot(3,3,1)
A1=load('output/notreatment.dat');
plot(A1(:,1),A1(:,3+1),'r','linewidth',1.5);
xlabel('Time (day)');
ylabel('Tumor (cell)');
xlim([0 100]);
ylim([0 1.3e10]);
set(gca,'fontsize',6);
text(-23,1.3e10,'(a)','fontweight','bold','fontsize',8);

A2=load('output/treatment.dat');
x0=0.41;
y0=0.865;
yh=0.058;
xh=0.21;
dy=yh+0.02;
linestype={'g','b','r'};
axes('position',[x0,y0,xh,yh]);
plot(A2(:,1),A2(:,1+1),linestype{1},'linewidth',1);
xticks([]);
xlim([0 100]);
ylim([0 10e6]);
ylabel('CAR-T_E');
set(gca,'fontsize',6);
text(-25,10e6,'(b)','fontweight','bold','fontsize',8);

y0=y0-dy;
axes('position',[x0,y0,xh,yh]);
plot(A2(:,1),A2(:,2+1),linestype{2},'linewidth',1);
xticks([]);
ylabel('CAR-T_M');
set(gca,'fontsize',6);

y0=y0-dy;
axes('position',[x0,y0,xh,yh]);
semilogy(A2(:,1),A2(:,3+1),linestype{3},'linewidth',1);
xlim([0 100]);
ylabel('Tumor');
xlabel('Time (day)');
set(gca,'fontsize',6);

%%
color=[161 216 228;
    137 195 231;
    66 146 198;
    45 116 187;
    0 75 153;
     0 1 1]/255;
subplot(3,3,3);  
for i=1:6
    A = load(strcat('output/VE-',num2str(i),'.dat'));
   semilogy(A(:,1),A(:, 4),'color', color(i,:),'linewidth',1);
   hold on;
end
xlabel('Time (day)');
ylabel('Tumor (cell)'); 
ylim([1e-4 1.3e11]);
xlim([0 100]);
set(gca,'fontsize',6);
caxis([1e6 2e7]);

colorbar('TickLength',0.05,'FontSize',6);
colormap(color);
text(-35,5e10,'(c)','fontweight','bold','fontsize',8);

%%
subplot(3,3,4);
for i=1:6
   A=load(strcat('output/VM-',num2str(i),'.dat'));
    semilogy(A(:,1),A(:,4),'color', color(i,:),'linewidth',1);
    hold on;
end
semilogy([40 40],[1e-6 5e10],'--');
xlim([0 100]);
xlabel('Time (day)');
ylabel('Tumor (cell)');
ylim([1e-4,5e10]);
set(gca,'fontsize',6);
 caxis([1e3 1e4]);
 colorbar('TickLength',0.05,'FontSize',6);
 colormap(color);
 text(-35,5e10,'(d)','fontweight','bold','fontsize',8);

%%
subplot(3,3,5);
hold on;
% Initial conditions of CAR-T cells
M0 =    [1*10^3, 2*10^3,   4*10^3,  6*10^3,  8*10^3, 10*10^3];
y0 = initialization();
parameter();

 Y=zeros(1,6);
 for j =1:6  
% The killing rate calculated from the initial conditions  
        A=load(strcat('output/VM-',num2str(j),'.dat'));
        i=400;
        TE = A(i,2);
        TM = A(i,3);
        C = A(i,4);
        Y(j) = killingrate(TE, TM, C);
 end
bar(Y,0.6); 
box on;
xticks([1,2,3,4,5,6]);
xticklabels({'1','2','4','6','8','10'});
ylim([1.5 3.5]);
xlim([0.4 6.6]);
yticks([1.5 2 2.5 3 3.5]);
xlabel('CAR-T_M (\times 10 ^3 cell)');
ylabel('k');
set(gca,'fontsize',6);
text(-1.2,3.5,'(e)','fontweight','bold','fontsize',8);


%%
subplot(3,3,6);
hold on;

control();
parameter();
y0 = initialization();
Z = zeros(20,2);
for j=1:20
    E0 = (0 + j * 1.0)*10^6;
    y0(1) = E0;
    Y = ModelSolver(md.t0,md.h,md.tend,y0);
    T0 = findPFS(Y(:,[1,4]));
    Z(j, 1) = E0;
    Z(j, 2) = T0;
end

plot(Z(:,1)/10^7, Z(:,2),'bo','markerfacecolor','b','markersize',3);
box on;
plot([0.85 0.85],[0 70],'--','linewidth',1);
xlabel('CAR-T_E (\times 10^7 cell)');
xlim([0,2])
ylim([0,70])
ylabel('PFS (day)');
set(gca,'fontsize', 6);
text(-0.45, 70,'(f)','fontweight','bold','fontsize',8);

 exportfig(fig,'Figure4.eps','color','cmyk','fontmode','scaled','fontsize',1);

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

function k = killingrate(TE, TM, C)
global par
star = cstar([TE, TM, C]);
TEs = TE/(1 + par.K1 * star);
TMs = TM/(1 + par.K2 * star);
k = par.kTE  * ((par.K1 * TEs)/(1 + par.K1 * TEs + par.K2 * TMs + par.K1 * C));
end


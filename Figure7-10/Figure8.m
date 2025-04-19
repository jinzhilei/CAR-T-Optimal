%
% The function to plot Figure 8 in the paper. Run the program solve()
% before running this program
%
function Figure8()
global par

addpath('../');

fig=figure(1);
clf();
A=load('md.dat');
B=load('../Figure5/output/md.dat');

linestype={'m','o','g','b','y','r'};

lw=1;

x0=-65;

subplot(3,3,1);
h(1) = plot(A(:,1),A(:,7),linestype{6},'linewidth',lw);
hold on;
plot(B(:,1),B(:,7),'k-');

xlabel('Time (day)');
ylabel('Tumor');
set(gca,'Yscale','log');
xlim([0 200]);
ylim([0 1e10]);
ax=gca;
ax.YAxis.Exponent=4;
text(x0,1e10,'(a)','fontweight','bold');

subplot(3,3,2);
h(1) = plot(A(:,1),A(:,2),'color',[250 200 205]/255,'linewidth',lw);
hold on;
plot(B(:,1),B(:,2),'k-');

xlabel('Time (day)');
ylabel('CAR-T_4');
xlim([0 200]);
ylim([0 0.8e4]);
ax=gca;
ax.YAxis.Exponent=3;
text(x0,0.8e4,'(b)','fontweight','bold');

subplot(3,3,3);
h(1) = plot(A(:,1),A(:,3),'color',[246 83 20]/255,'linewidth',lw);
hold on;
plot(B(:,1),B(:,3),'k-');

xlabel('Time (day)');
ylabel('CAR-T_P');
xlim([0 200]);
ylim([0 0.25e8]);
text(x0,0.25e8,'(c)','fontweight','bold');

subplot(3,3,4);
h(1) = plot(A(:,1),A(:,4),'color',[124 187 0]/255,'linewidth',lw);
hold on;
plot(B(:,1),B(:,4),'k-');

xlabel('Time (day)');
ylabel('CAR-T_E');
xlim([0 200]);
ylim([0 5e6]);
text(x0,5e6,'(d)','fontweight','bold');

subplot(3,3,5);
h(1) = plot(A(:,1),A(:,5),'color',[0 161 241]/255,'linewidth',lw);
hold on;
plot(B(:,1),B(:,5),'k-');

xlabel('Time (day)');
ylabel('CAR-T_M');
xlim([0 200]);
ylim([0 2500]);
ax=gca;
ax.YAxis.Exponent=3;
text(x0,2500,'(e)','fontweight','bold');

subplot(3,3,6);
plot(A(:,1),A(:,6),'color',[0.49 0.18 0.56],'linewidth',lw);
hold on;
plot(B(:,1),B(:,6),'k-');

xlabel('Time (day)');
ylabel('CAR-T_r');
xlim([0 200]);
ylim([0 1e3]);
ax=gca;
ax.YAxis.Exponent=3;
text(x0,1e3,'(f)','fontweight','bold');

% Plot the cytokine dynamics

parameter();
y1=A(:,2);y2=A(:,3);y3=A(:,4);y4=A(:,5);y5=A(:,6);y6=A(:,7);y7=A(:,8);
I2 = par.lambda6 * y1 / par.dI2;
I6 = par.lambda10 * y7/ par.dI6;
Tbeta = par.lambda9 * y6 / par.dTbeta;
Igamma = ((par.lambda7 * y3 + par.lambda8 * y1) * (1 / (1 + y5/par.KTr) + 1 / (1 + Tbeta/par.KTbeta)))/par.dIgamma;

A = B;
y1=A(:,2);y2=A(:,3);y3=A(:,4);y4=A(:,5);y5=A(:,6);y6=A(:,7);y7=A(:,8);
rI2 = par.lambda6 * y1 / par.dI2;
rI6 = par.lambda10 * y7/ par.dI6;
rTbeta = par.lambda9 * y6 / par.dTbeta;
rIgamma = ((par.lambda7 * y3 + par.lambda8 * y1) * (1 / (1 + y5/par.KTr) + 1 / (1 + Tbeta/par.KTbeta)))/par.dIgamma;

lw=1;
xt=-85;
fs=8;

x0 = 0.135;
y0 = 0.11;
xh = 0.14;
yh = 0.22;
dx = xh + 0.069;
axes('position',[x0,y0,xh,yh]);
plot(A(:,1),Tbeta,LineWidth=lw);
hold on;
plot(A(:,1),rTbeta,'k-');

xlabel('Time (day)');
ylabel('TGF-\beta (ng/ml)');
set(gca,'Yscale','log');
ylim([1e-10,1e4]);
set(gca,'fontsize',fs);
text(xt,1e4,'(g)','fontweight','bold');

x0 = x0 + dx;
axes('position',[x0,y0,xh,yh]);
plot(A(:,1),I2,LineWidth=lw);
hold on;
plot(A(:,1),rI2,'k-');

xlabel('Time (day)');
ylabel('IL-2 (ng/ml)');
ylim([0,0.05]);
set(gca,'fontsize',fs);

x0 = x0 + dx;
axes('position',[x0,y0,xh,yh]);
plot(A(:,1),I6,LineWidth=lw);
hold on;
plot(A(:,1),rI6,'k-');

xlabel('Time (day)');
ylabel('IL-6 (ng/ml)');
ylim([0,4e-4]);
set(gca,'fontsize',fs);

x0 = x0 + dx;
axes('position',[x0,y0,xh,yh]);
plot(A(:,1),Igamma(:,1),LineWidth=lw);
hold on;
plot(A(:,1),rIgamma,'k-');

xlabel('Time (day)');
ylabel('IFN-\gamma (ng/ml)');
ylim([0,1e-3]);
set(gca,'fontsize',fs);

%exportfig(fig,'Figure8.eps','color','cmyk','fontmode','scaled','fontsize',1);
end


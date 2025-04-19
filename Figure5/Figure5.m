% The function to plot Figure 5 in the paper. Run the program solve()
% before running this program
function Figure5()
global par

fig=figure(1);
clf();
A=load('output/md.dat');

linestype={'m','o','g','b','y','r'};

title('the Number of Tumor with Treatment');

lw=1;

x0=-60;

subplot(3,3,1);
plot(A(:,1),A(:,7),linestype{6},'linewidth',lw);
xlabel('Time (day)');
ylabel('Tumor');
set(gca,'Yscale','log');
xlim([0 200]);
ylim([1 1e10]);
ax=gca;
ax.YAxis.Exponent=4;
text(x0,1e10,'(a)','fontweight','bold');

subplot(3,3,2);
plot(A(:,1),A(:,2),'color',[250 200 205]/255,'linewidth',lw);
xlabel('Time (day)');
ylabel('CAR-T_4');
xlim([0 200]);
ylim([0 1e4]);
ax=gca;
ax.YAxis.Exponent=4;
text(x0,10000,'(b)','fontweight','bold');

subplot(3,3,3);
plot(A(:,1),A(:,3),'color',[246 83 20]/255,'linewidth',lw);
xlabel('Time (day)');
ylabel('CAR-T_P');
xlim([0 200]);
ylim([0 1e8]);
text(x0, 1e8,'(c)','fontweight','bold');

subplot(3,3,4);
h(1) = plot(A(:,1),A(:,4),'color',[124 187 0]/255,'linewidth',lw);
xlabel('Time (day)');
ylabel('CAR-T_E');
xlim([0 200]);
ylim([0 5e7]);
text(x0, 5e7,'(d)','fontweight','bold');

subplot(3,3,5);
h(1) = plot(A(:,1),A(:,5),'color',[0 161 241]/255,'linewidth',lw);
xlabel('Time (day)');
ylabel('CAR-T_M');
xlim([0 200]);
ylim([0 2e4]);
text(x0, 2e4,'(e)','fontweight','bold');

subplot(3,3,6);
plot(A(:,1),A(:,6),'color',[0.49 0.18 0.56],'linewidth',lw);

xlabel('Time (day)');
ylabel('CAR-T_r');
xlim([0 200]);
ylim([0 1000]);
ax=gca;
ax.YAxis.Exponent=3;
text(x0,1000,'(f)','fontweight','bold');

% Plot the cytokine dynamics

run('../parameter.m');

y1=A(:,2);y2=A(:,3);y3=A(:,4);y4=A(:,5);y5=A(:,6);y6=A(:,7);y7=A(:,8);
I2 = par.lambda6 * y1 / par.dI2;
I6 = par.lambda10 * y7/ par.dI6;
Tbeta = par.lambda9 * y6 / par.dTbeta;
Igamma = ((par.lambda7 * y3 + par.lambda8 * y1) * (1 / (1 + y5/par.KTr) + 1 / (1 + Tbeta/par.KTbeta)))/par.dIgamma;

lw=1;
xt=-70;
fs=8;

x0 = 0.135;
y0 = 0.11;
xh = 0.14;
yh = 0.22;
dx = xh + 0.069;
axes('position',[x0,y0,xh,yh]);
plot(A(:,1),Tbeta,LineWidth=lw);
xlabel('Time (day)');
ylabel('TGF-\beta (ng/ml)');
set(gca,'Yscale','log');
ylim([1e-6,1e4]);
set(gca,'fontsize',fs);
text(xt,1e4,'(g)','fontweight','bold');

x0 = x0 + dx;
axes('position',[x0,y0,xh,yh]);
plot(A(:,1),I2,LineWidth=lw);
xlabel('Time (day)');
ylabel('IL-2 (ng/ml)');
ylim([0,0.06]);
set(gca,'fontsize',fs);

x0 = x0 + dx;
axes('position',[x0,y0,xh,yh]);
plot(A(:,1),I6,LineWidth=lw);
xlabel('Time (day)');
ylabel('IL-6 (ng/ml)');
ylim([0, 2e-3]);
set(gca,'fontsize',fs);

x0 = x0 + dx;
axes('position',[x0,y0,xh,yh]);
plot(A(:,1),Igamma(:,1),LineWidth=lw);
xlabel('Time (day)');
ylabel('IFN-\gamma (ng/ml)');
ylim([0, 0.008]);
set(gca,'fontsize',fs);

exportfig(fig,'Figure5.eps','color','cmyk','fontmode','scaled','fontsize',1);
end


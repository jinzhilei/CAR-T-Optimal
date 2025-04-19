%
% This function plot Figure 7
% 

function Figure7()
D=load('Optimal3.dat');
 
%% Tumor and Total dose;
fig=figure(1);
clf();
fs = 8;
ms = 3;
xt = -0.3e6;
%% Tumor and CAR-TTotal
subplot(3,3,1);
plot(D(:,1),D(:,3),'o','color',[255 187 0]/255,'markersize',ms)%tumor Total
hold on
xlabel('Tumor (cell)');
ylabel('CAR-T (cell)'); 
ylim([0 7e7]);
xlim([1e6 6e6]);
text(xt,7e7,'(a)','fontweight','bold');
set(gca,'fontsize',fs);

%% Tumor and T4
subplot(3,3,2)
plot(D(:,1),D(:,4),'o','color',[250 200 205]/255,'markersize',ms);
hold on
xlabel('Tumor (cell)');
ylabel('CAR-T_4（cell）'); 
ylim([0.5 4.5e4]);
 xlim([1e6 6e6]);
text(xt,4.5e4,'(b)','fontweight','bold');
set(gca,'fontsize',fs);

%% Tumor and Tp
subplot(3,3,3)
plot(D(:,1),D(:,5),'o','color',[246 83 20]/255,'markersize',ms);
hold on
xlabel('Tumor (cell)');
ylabel('CAR-T_P (cell)'); 
ylim([0 3.5e7]);
xlim([1e6 6e6]);
text(xt,3e7,'(c)','fontweight','bold');
 set(gca,'fontsize',fs);
 
%% Tumor and TE
subplot(3,3,4)
plot(D(:,1),D(:,6),'o','color',[124 187 0]/255,'markersize',ms);
hold on
xlabel('Tumor (cell)');
ylabel('CAR-T_E (cell)'); 
ylim([0 4e7]);
xlim([1e6 6e6]);
text(xt,3.5e7,'(d)','fontweight','bold');
 set(gca,'fontsize',fs);

%% Tumor and TM
subplot(3,3,5)
plot(D(:,1),D(:,7),'o','color',[0 161 241]/255,'markersize',ms);
hold on;
xlabel('Tumor (cell)');
ylabel('CAR-T_M (cell)');
ylim([0 4.5e3]);
xlim([1e6 6e6]);
ax=gca;
ax.YAxis.Exponent=3;
text(xt,3e3,'(e)','fontweight','bold');
 set(gca,'fontsize',fs);

%% Tr
subplot(3,3,6) 
plot(D(:,1),D(:,8),'o','color',[0.49 0.18 0.56],'markersize',ms);
hold on;
xlabel('Tumor (cell)');
ylabel('CAR-T_r (cell)');
ylim([0 2e3]);
xlim([1e6 6e6]);
ax=gca;
ax.YAxis.Exponent=3;
text(xt,1.1e3,'(f)','fontweight','bold');
set(gca,'fontsize',fs);

%% No progress 

subplot(3,3,[7:9]);
 plot(D(:,1),D(:,2),'r*','color',[155 187 89]/255);
 xlabel('Tumor (cell)');
 ylabel('PFS (day)');
ylim([60 110]);
 xlim([1e6 6e6]);
box on;
 text(0.67e6,110,'(g)','fontweight','bold');
 set(gca,'fontsize',fs);
 
 exportfig(fig,'Figure7.eps','color','cmyk','fontmode','scaled','fontsize',1);

end



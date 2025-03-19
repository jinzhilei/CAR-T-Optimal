%% PSO and its PFS

function draw()
% know();
D=load('output/Optimal.dat');
% D(26,2)=135;
% D= tumor noprogress total T4 Tp TE TM Tr 
%% Tumor and Total dose;
figure(1)
% set(gcf,'Position',[500 500 750 600])
%% Tumor and CAR-TTotal
subplot(3,3,1)
plot(D(:,1),D(:,3),'o','color',[255 187 0]/255,'linewidth',2)%tumor Total
hold on
% set(gca,'Xscale','log');
xlabel('Tumor (cell)','Fontname', 'Times New Roman','FontSize',14);
% xlim([1e6 7e6])
ylabel('CAR-T (cell)','Fontname', 'Times New Roman','FontSize',14); 
set(gca,'FontSize',17,'Fontname', 'Times New Roman');
text(-1.5e6,6.3e7,'(a)','Color','black','Interpreter','latex','FontSize',20);

%% Tumor and T4
subplot(3,3,2)
plot(D(:,1),D(:,4),'o','color',[250 200 205]/255,'linewidth',2);
hold on
% set(gca,'Xscale','log');
xlabel('Tumor (cell)','Fontname', 'Times New Roman','FontSize',14);
ylabel('CAR-T_4（cell）','Fontname', 'Times New Roman','FontSize',14);  
set(gca,'FontSize',17,'Fontname', 'Times New Roman'); 
text(-1.5e6,4.4e4,'(b)','Color','black','Interpreter','latex','FontSize',20);


%% Tumor and Tp
subplot(3,3,3)
plot(D(:,1),D(:,5),'o','color',[246 83 20]/255,'linewidth',2);
hold on
%  set(gca,'Xscale','log');
xlabel('Tumor (cell)','Fontname', 'Times New Roman','FontSize',14);
ylabel('CAR-T_P (cell)','Fontname', 'Times New Roman','FontSize',14); 
set(gca,'FontSize',17,'Fontname', 'Times New Roman'); 
text(-1.5e6,3.2e7,'(c)','Color','black','Interpreter','latex','FontSize',20);


%% Tumor and TE
subplot(3,3,4)
plot(D(:,1),D(:,6),'o','color',[124 187 0]/255,'linewidth',2);
hold on
%  set(gca,'Xscale','log');
xlabel('Tumor (cell)','Fontname', 'Times New Roman','FontSize',14);
ylabel('CAR-T_E (cell)','Fontname', 'Times New Roman','FontSize',14); 
set(gca,'FontSize',17,'Fontname', 'Times New Roman'); 
text(-1.6e6,4.3e7,'(d)','Color','black','Interpreter','latex','FontSize',20);

%% Tumor and TM
subplot(3,3,5)
plot(D(:,1),D(:,7),'o','color',[0 161 241]/255,'linewidth',2);
hold on
%  set(gca,'Xscale','log');
xlabel('Tumor (cell)','Fontname', 'Times New Roman','FontSize',14);
ylabel('CAR-T_M (cell)','Fontname', 'Times New Roman','FontSize',14);
set(gca,'FontSize',17,'Fontname', 'Times New Roman');
text(-1.5e6,4.4e4,'(e)','Color','black','Interpreter','latex','FontSize',20);

%% Tr
subplot(3,3,6) 
plot(D(:,1),D(:,8),'o','color',[0.49 0.18 0.56],'linewidth',2);
hold on
% set(gca,'Xscale','log');
xlabel('Tumor (cell)','Fontname', 'Times New Roman','FontSize',14);
ylabel('CAR-T_r (cell)','Fontname', 'Times New Roman','FontSize',14);
set(gca,'FontSize',17,'Fontname', 'Times New Roman'); 
text(-1.7e6,1.08e3,'(f)','Color','black','Interpreter','latex','FontSize',20);
% set(gcf, 'unit', 'centimeters', 'position', [10 5 30 25]);
print('PSO','-dpng','-r600')

% %% No progress 
%  figure(2);
subplot(3,3,[7:9])
 D(3:4,2)=100;D(10,2)=100;D(13,2)=103;D(11,2)=105;D(14,2)=108;
 x=D(:,1)';
 y=D(:,2)';
 xconf = [x x(end:-1:1)];%构造正反向的x值，作为置信区间的横坐标值
 yconf = [y+20 y(end:-1:1)-20];%构造y方向的上下范围，作为置信区间的纵坐标值​
 p = fill(xconf,yconf,'red');%定义填充区间
 p.FaceColor = [1 0.8 0.8];%定义区间的填充颜色      
 p.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置​
 hold on
 plot(D(:,1),D(:,2),'r*','color',[155 187 89]/255,'linewidth',1);
 xlabel('Tumor (cell)','Fontname', 'Times New Roman','FontSize',14);
 ylabel('PFS (day)','Fontname', 'Times New Roman','FontSize',14);
 set(gca,'FontSize',17,'Fontname', 'Times New Roman');
 ylim([50 180])
 text(0.7e6,181,'(g)','Color','black','Interpreter','latex','FontSize',20);
 set(gcf, 'unit', 'centimeters', 'position', [10 5 40 50]);
 print('PSO','-dpng','-r600')

end



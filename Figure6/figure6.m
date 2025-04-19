function figure6()
fig=figure(1);
clf();
x0=-80;
x1=-1.6;
x2=-1.8;
%%
subplot(3,3,1);
color=[252 41 30;0 0 0;228 163 82;57 205 56;42 105 205;206 147 181]/255;
for i =1: 6
    A1=load(strcat('PlanA/md',num2str(i),'.dat'));
    C=color(i,:);
    semilogy(A1(:,1),A1(:,7),'color',C,'linewidth',1.2);
    hold on;
end
xlabel('Time (day)');
ylabel('Tumor (cell)');
ylim([0 1e10]);
xlim([0 200]);
%set(gca,'fontsize',8);
legend('A1','A2',  'A3',  'A4', 'A5','A6','FontSize',5,'Location','best');
text(x0,1e10,'(a)','fontweight','bold');
%%
subplot(3,3,2);
color=[0 0 0;228 163 82;57 205 56;42 105 205;252 41 30;206 147 181]/255;
for j=1:6
    A2=load(strcat('PlanB/md',num2str(j),'.dat'));
    C=color(j,:);
    semilogy(A2(:,1),A2(:,7),'color',C,'linewidth',1.2);
    hold on;
end
xlabel('Time (day)');
ylabel('Tumor (cell)');
ylim([0 1e10]);
xlim([0 200]);    
legend('B1','B2',  'B3',  'B4', 'B5','B6','FontSize',5,'Location','best');
text(x0,1e10,'(b)','fontweight','bold');
%set(gca,'fontsize',8);
%%
subplot(3,3,3)
color=[57 205 56;0 0 0;228 163 82;42 105 205;206 147 181;121 122 123;252 41 30]/255;
for k=1:7
    A3=load(strcat('PlanC/md',num2str(k),'.dat'));
    C=color(k,:);
    semilogy(A3(:,1),A3(:,7),'color',C,'linewidth',1.2);
    hold on;
end
xlabel('Time (day)');
ylabel('Tumor (cell)');
ylim([0 1e10]);
xlim([0 200]);    
 legend('C1','C2',  'C3',  'C4', 'C5','C6','C7','FontSize',5,'Location','best');
 text(x0,1e10,'(c)','fontweight','bold');
 %set(gca,'fontsize',8);

%%
subplot(3,3,4)
X=1:6;
PFS_A=load('PFS_A.dat');
h=bar(X,PFS_A,0.8);
set(h(1),'FaceColor',[174 208 238]/255)
ylim([0,120]);
xlim([0.4,6.6]);
ylabel('PFS (day)');
xticklabels({'A1','A2','A3','A4','A5','A6'});
text(x1,120,'(d)','fontweight','bold');
%set(gca,'fontsize',8);

%%
subplot(3,3,5)
X=1:6;
PFS_B=load('PFS_B.dat');
h=bar(X,PFS_B,0.8);
set(h(1),'FaceColor',[174 208 238]/255)
ylim([0,120]);
xlim([0.4,6.6]);
ylabel('PFS (day)');
xticklabels({'B1','B2','B3','B4','B5','B6'});
text(x1,120,'(e)','fontweight','bold');
%set(gca,'fontsize',8);

%%
subplot(3,3,6)
PFS_C=load('PFS_C.dat');
X=1:7;
h=bar(X,PFS_C,0.8);
set(h(1),'FaceColor',[174 208 238]/255)
ylim([0,120]);      
xlim([0.4,7.6]);
ylabel('PFS (day)');
xticklabels({'C1','C2','C3','C4','C5','C6','C7'});
text(x2,120,'(f)','fontweight','bold');
%set(gca,'fontsize',8);

exportfig(fig,'figure6-1.eps','color','cmyk','fontmode','scaled','fontsize',1);

end
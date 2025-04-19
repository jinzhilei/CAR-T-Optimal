%% Parameters Figure    
function Figure2()
Q = load('Tumor.dat');
S = load('Parameter.dat');
P = load('Para_PFS.dat');
P0 = load('PFS.dat');

fig=figure(1);
clf();

subplot(2,2,1);
hold on;
J=find(P(:,1)>2);
Pear0 = zeros(41,2);
for i = 1:41
    Pear0(i,1) = i;
     Pear0(i,2) = corr(S(J,i),P0(J,1));  % Pearson for PFS
end
bar(Pear0(:,1),Pear0(:,2));
line([0 42], [0.2 0.2],'linestyle','--','color','k');
line([0 42],[-0.2 -0.2], 'linestyle','--','color','k');
box on;

xticks([1,10,20,30,40])
xticklabels({'1','10','20','30','40'});
xlim([0 42]);
ylim([-0.8 0.6]);
xlabel('Parameter');
ylabel('Pearson');
set(gca,'fontsize',8);
text(-8,0.6,'(a)','fontweight','bold');

subplot(2,2,4);
hold on;
m = size(Q,2);
pearson=zeros(43,m);
pearson(1,:) = Q(1,:);
for i = 1:41
    for j = 1:m
        pearson(i+1,j) = corr(S(:,i),Q(2:end,j));  % Pearson for tumor cell count    
    end
end
J0=[1, 2, 3, 4, 5, 6,7,8,9,10,11,12,14];
for i=1:13
    plot(pearson(1,:),pearson(J0(i)+1,:),'linewidth',1.5);
end
line([0 200],[0.2 0.2],'linestyle','--','color','k');
line([0 200],[-0.2 -0.2],'linestyle','--','color','k');
xlim([0 200]);
ylim([-0.8 0.8]);
xlabel('Time(day)');
ylabel('Pearson');
text(100,0.6,'\lambda_C','fontsize',8);
text(100,-0.50,'k_{TE}','fontsize',8);
text(160,-0.65,'d_C','fontsize',8);
box on;
set(gca,'fontsize',8);
text(-48,0.8,'(d)','fontweight','bold');

subplot(2,2,3);
bar(1:13,pearson(J0+1,81));
xlim([0 14]);
ylim([-0.8 0.8]);
ylabel('Pearson');
line([0 14],[0.2 0.2],'linestyle','--','color','k');
line([0 14],[-0.2 -0.2],'linestyle','--','color','k');
xticks([1 2 3 4 5 6 7 8 9 10 11 12 13]);
xticklabels({'\lambda_{TM}','\lambda_C','\lambda','{\lambda}T_{T->M}','{\lambda}T_{M->E}','k_{TE}','k_{T4}','d_{T4}','d_{TP}','d_{TE}','d_C','K_1','K_3'});
set(gca,'fontsize',8);
text(-2.4,0.8,'(c)','fontweight','bold');

fs=1;
subplot(4,4,3);
 plot(S(J,2),P(J,1), 'bo', 'Markerfacecolor', 'b','markersize',fs);
xlim([2.9 3.7]);
ylim([40 100]);
xlabel('\lambda_C');
set(gca,'fontsize',6);
text(2.5,160,'(b)','fontweight','bold');
ylabel('PFS');

 subplot(4,4,4);
 plot(S(J,11),P(J,1),'bo','Markerfacecolor','b','markersize',fs);
 xlim([0.065 0.085]);
 ylim([40 100]);
 xlabel('d_C');
set(gca,'fontsize',6);

 subplot(4,4,7);
 plot(S(J,6),P(J,1),'bo','Markerfacecolor','b','markersize',fs);
 xlim([3.2 4.0]);
 ylim([40 100]);
 xlabel('k_{TE}');
 ylabel('PFS');
set(gca,'fontsize',6);

 subplot(4,4,8);
 plot(S(J,10),P(J,1),'bo','Markerfacecolor','b','markersize',fs);
 xlim([0.16 0.20]);
 ylim([40 100]);
 xlabel('d_{TE}');
set(gca,'fontsize',6);
 
 exportfig(fig,'Figure2.eps','color','cmyk','fontmode','scaled','fontsize',1);

end


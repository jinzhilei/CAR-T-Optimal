%% 拟合一条曲线 按照15:1200:4800:5:1 剂量计算Noprogress  

function fitting()
 
D=load('Optimal.dat');
% D= tumor noprogress total T4 Tp TE TM Tr 

%% Cells numerical calculation and fitting
%% Tumor and Total dose
tumor=D(:,1);
m=length(tumor);

figure(1)
subplot(2,1,1)
plot(tumor,D(:,3),'o','color',[255 187 0]/255,'linewidth',2)%tumor Total
hold on
% x=linspace(1e7,4e7);
y1=4.144e6 * exp((4.385e-8)*tumor);
plot(tumor,y1,'color',[255 187 0]/255,LineWidth=2);
xlabel('Tumor（cell）');
ylabel('CAR-T（cell）'); 

%% 比例计算
T4 = y1 * (15/6021);
Tp = y1 * (1200/6021);
TE = y1 * (4800/6021);
TM = y1 * (5/6021);
Tr = y1 * (1/6021);
M=10^3 * ones(1,m);
 hold on
 
 Y=[T4'; Tp'; TE'; TM'; Tr';tumor'; M];

 x=D(:,1)';
 y=D(:,2)';
 xconf = [x x(end:-1:1)];%构造正反向的x值，作为置信区间的横坐标值
 yconf = [y+20 y(end:-1:1)-20];%构造y方向的上下范围，作为置信区间的纵坐标值​
 p = fill(xconf,yconf,'red');%定义填充区间
 p.FaceColor = [1 0.8 0.8];%定义区间的填充颜色      
 p.EdgeColor = 'none';%定义区间边界的填充颜色，此处不设置​
 hold on
 subplot(2,1,2)
 plot(D(:,1),D(:,2),'r*','color',[155 187 89]/255,'linewidth',1);
 rec_time=[];
 for i=1:m
    y0=Y(:,i);
    x0=0;xend=200;h=1;
    Z=ODE(x0,h,xend,y0);%Z(时间,肿瘤);
    AA=abs(Z(2:end,2)-tumor(i));
    xx=min(AA);
    pos=find(AA==xx)+1;
    rec_time=[rec_time,pos];
 end
 hold on 
plot(tumor,rec_time,'b-',linewidth=2)
xlabel('Tumor(cell)');
ylabel('t(day)');


end



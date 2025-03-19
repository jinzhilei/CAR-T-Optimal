
%% 得出D0 tumor 
function D0=OptimalValue(TC)


D0 = zeros(1,8);

%% 参数设置  
N = 100;                         % 初始种群个数  

Y = Initialization(TC,N);

[fym,ym] = FindOptimization(Y,N);

YM=sum(ym);

D0(1)=TC;%肿瘤细胞数量
D0(2)=fym;%无进展生存期
D0(3)=YM;%总剂量
D0(4:8)=ym;%各种亚型剂量

end
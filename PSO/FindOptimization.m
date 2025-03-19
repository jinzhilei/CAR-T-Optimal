function [fym,ym]=FindOptimization(Y,N)

d = 5;                          % 可行解维数  
ger = 20;                       % 最大迭代次数       
limit = [1*10^3,6*10^7];        % 设置位置参数限制  
vlimit = [-100, 100];           % 设置速度限制  
w = 0.8;                        % 惯性权重  
c1 = 0.5;                       % 自我学习因子 2，1 
c2 = 0.5;


Y0 = Y;
x = Y0(1:5,:)';                 %初始种群的位置
v = rand(N,d);                 %初始种群的速度
xm = x;                      %每个个体的历史最佳位置
ym = zeros(1, d);            %种群的历史最佳位置
fxm = zeros(N,1);            %每个个体的历史最佳适应度
fym = 0;                    %种群历史最佳适应度   

iter=1;
while iter <= ger
       
    rec_time=[];

    for i = 1 : N 
        y0 = Y0(:,i);
        pos = ODESolveTime(y0);
        rec_time=[rec_time,pos]; %所对应的无进展生存期
    end
    fx=rec_time';           %个体当前适应度
    for  k = 1 : N
         if  fx(k) > fxm(k)
             fxm(k)=fx(k);
             xm(k,:)=x(k,:);
         end
    end
    if max(fxm) > fym
        [fym,nmax]=max(fxm);
        ym = xm(nmax,:);
    end
    
    iter = iter+1;
       
    v = v * w + c1 * rand * (xm - x) + c2 * rand * (repmat(ym, 1, 1) - x); % 速度更新  
    % 边界速度处理  
    v(v > vlimit(2)) = vlimit(2);  
    v(v < vlimit(1)) = vlimit(1);  
    % 位置更新
    
    x = x + v;
    Y0 = [x, Y(6,:)', Y(7,:)']';
    % 边界位置处理  
    x(x > limit(2)) = limit(2);  
    x(x < limit(1)) = limit(1);  
  
end
end
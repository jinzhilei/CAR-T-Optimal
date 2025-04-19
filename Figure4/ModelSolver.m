%% Runge-Kutta methods
function  X=ModelSolver(t0,h,tend,y0)


%% save data
n = floor((tend - t0)/h)+1;
m = length(y0);
X = zeros(n,m+1);

%% 

t = t0;
y = y0;
X(1,1) = t;
X(1,2:m+1) = y';
for k=2:n    
    k1 = funs(t , y);
    k2 = funs(t + h/2, y + (h/2) * k1);
    k3 = funs(t + h/2, y + (h/2) * k2); 
    k4 = funs(t + h, y + h * k3);

    t = t + h;
    y = y + (h/6) * (k1 + 2 * k2 + 2 * k3 + k4);
    
    X(k,1) = t;
    X(k,2:m+1) = y';
end

end


function  Z=ODE(x0,h,xend,y0)

m = floor((xend-x0)/h)+1;
Z = zeros(m,2);

x = x0;
y = y0;

k = 1;
Z(k,1) = x;
Z(k,2) = y(6);
while x < xend
    
    k1 = funs(x , y);
    k2 = funs(x + h/2, y + (h/2)*k1);
    k3 = funs(x + h/2, y + (h/2)*k2); 
    k4 = funs(x + h, y + h * k3);

    x = x + h;
    y = y + (h/6) * (k1 + 2 * k2 + 2 * k3 + k4);
    
    k=k+1;
    Z(k,1) = x;
    Z(k,2) = y(6);
end

end


function output(fn, x, y)
   fprintf(fn,'%f ',x);
   m=length(y);
for i=1:m
    fprintf(fn,'%f ',y(i));
end 
 fprintf(fn,'\n');
end
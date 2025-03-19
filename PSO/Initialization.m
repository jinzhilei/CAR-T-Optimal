function Y = Initialization(TC,N)

Y=zeros(7,N);

Dose = 10*TC;
% Dose = 20021000;
Y(1,:) =  randc(Dose*(13/20021), (15/20021)*Dose, N);
Y(2,:) =  randc(Dose*(1000/20021), (12000/20021)*Dose, N);
Y(3,:) =  randc(Dose*(1000/20021), (12000/20021)*Dose, N);
Y(4,:) =  randc(Dose*(10/20021), (15/20021)*Dose, N);
Y(5,:) =  randc(10,1000,N);    
Y(6,:) = TC * randc(1,1,N);      % Cancer cells number 
Y(7,:) = 1*10^3 * randc(1,1,N);




% Dose = 0.6*10^7;  %输入的CAR-T总量
% 
% Y(1,:) = Dose * randc(0.0015, 0.0025, N);
% Y(2,:) = Dose * randc(0.1663, 0.2823, N);
% Y(3,:) = Dose * randc(0.8460, 1, N);
% Y(4,:) = Dose * randc(0.00082, 0.0087, N);
% Y(5,:) = Dose * randc(0.000094, 0.00021, N);    
% Y(6,:) = TC * randc(1,1,N);      % Cancer cells number 
% Y(7,:) = 1*10^3 * randc(1,1,N);

end

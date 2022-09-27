function Multivariate_Regression
clc;
clear;
data = load("../DataSets/HeatFlux_and_SkinTemperature.txt");
x = data(:,end-1);
y = data( :,end);
plot(x(:),y(:),'+ b');
hold on;

W = MFit(x,y);
input = [10,9,8,7,6,5,4,3,2,1];
output = [];
output = W(1) + W(2) * input;
   
    
        plot(input,output,'--');
end
function W = MFit(x,y)
    X = [ones(size(x))  x];
    W = (X'*X)^-1 * X' * y;
end

function  Linear_Regression()
% TODO : PREDICT THE SKIN TEMPERATURE GIVEN HEAT FLUX
%USING LINEAR REGRESSION
%Function : f(x) = w0 + w1x
clc;
format short;
Data = load("../DataSets/HeatFlux_and_SkinTemperature.txt");

%PLOT THE POINTS OF DATA SET
plot(Data(:,1),Data(:,2),'+ R' );
xlabel("HEAT FLUX");
ylabel("SKIN TEMPERATURE");
hold on;

%SIZE OF DATA SET
N = size(Data,1);

%CALCULATE WEIGHTS
Weights = Param(Data,N);

%ASSIGN WEIGHTS T W0 AND W1
W0 = Weights(1);
W1 = Weights(2);

%TEST THE MODEL
X = [10,9,8,7,6,5,4,3,2,1];
Y = W0 + W1 * X;

%PLOT TEST RESULTS
plot(X,Y,'B');
end
%END MAIN FUNCTION

function [w] = Param(Data,N)
    Sum = sum(Data);
    %SUMMATION Xi
    Sum_Xi = Sum(1);
    
    %SUMMATION Yi
    Sum_Yi = Sum(2);
    
    %SUMMATION Xi^2
    Sum_Xi2 = SUMXiXi(Data,N) ;
    
    %SUMMATION Xi*Yi
    Sum_Xi_Yi = SUMXiYi(Data,N);
    
    %CALCULATING WEIGHT USING MATRIX NORMAL FORM
    w = ([N Sum_Xi; Sum_Xi Sum_Xi2] ^ -1 ) * [Sum_Yi ; Sum_Xi_Yi] ;
    
end

%SUMMATION Xi * Yi
function s =  SUMXiYi(Data,N)
    s = 0;
    for i = 1:N
        s = s + (Data(i,1) * Data(i,2));
    end
end

%SUMMATION Xi^2
function s =  SUMXiXi(Data,N)
    s = 0;
    for i = 1:N
        s = s + (Data(i,1) ^2);
    end
end
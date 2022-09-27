function LinearRegression_GradientDescent
clc;
format short;
%LOAD DATA SET
data = load("../DataSets/HeatFlux_and_SkinTemperature.txt");
%PLOT THE POINTS OF DATA SET
plot(data(:,1),data(:,2),'+ R' );
xlabel("HEAT FLUX");
ylabel("SKIN TEMPERATURE");
hold on;

%STEP 1:-
%SIZE OF DATA SET
n = size(data,1);

%LEARNING RATE
L = 0.01;

%COEFFICIENTS OF THE MODEL
m = 0;
c = 0;

temp_m = 0;
temp_c = 0;

    while(true)
        %STEP 2:-
        %Calculate Partial Derivatve of Cost Function with respect to m
        Dm = Cal_Dm(m,c,n,data);
        %Calculate Partial Derivatve of Cost Function with respect to c
        Dc = Cal_Dc(m,c,n,data);
        
        %Store previous Parameters (used to ensure the 
        %termination condition
        temp_m = m;
        temp_c = c;

        %STEP 3:-
        %Update the parameters
        m= m - L * Dm;
        c= c - L* Dc;
      
        %Check for termination condition
        if m == temp_m && c==temp_c
            break;
        end
        
    end
    %Print Parameters
    disp(m);
    disp(c);
    %TEST THE MODEL
    X = [10,9,8,7,6,5,4,3,2,1];
    Y = c + m * X;

    %PLOT TEST RESULTS
    plot(X,Y,'B');
    
    
    
end

%FUNCTION USED TO CALCULATE THE PARTIAL DERIVATIVE OF THE COST
%FUNCTION (MSE) WITH RESPECT m
function Dm = Cal_Dm(m,c,n,data)
    yp = 0;
    Dm = 0;
    for i=1:n
        xi = data(i,1);
        yi = data(i,2);
        yp = m * xi + c;
        Dm = Dm + (xi * (yi - yp));        
    end
    Dm = Dm * (-2/n);
end

%FUNCTION USED TO CALCULATE THE PARTIAL DERIVATIVE OF THE COST
%FUNCTION (MSE) WITH RESPECT c
function Dc = Cal_Dc(m,c,n,data)
    yp = 0;
    Dc = 0;
    for i=1:n
        xi = data(i,1);
        yi = data(i,2);
        yp = m * xi + c;
        Dc = Dc + (yi - yp);        
    end
    Dc = Dc * (-2/n);
end





function Logistic_Regression
clc;
format short;
%LOAD DATA SET
data = load("../DataSets/Students.txt");
%PLOT THE POINTS OF DATA SET
%plot(data(:,1),data(:,2),'+ R' );
%hold on;

%STEP 1:-
%SIZE OF DATA SET
n = size(data,1);

% X variable of the data set
x = data(:,1);
y = data(:,2);
%LEARNING RATE
L = 0.01;

%THRESHOLD
alpha = 0.5;

%COEFFICIENTS OF THE MODEL
m = 0;
b = 0;

y_cap = 0;
y_pred = 0;
error_prev = 0;
error = 0;
 while true
        for i =1:n
                y_pred = m*x(i) + b;
                y_cap = 1 / ( 1 + exp(-y_pred));
                
                delta_m = (y_cap - y(i)) * x(i);
                delta_b = (y_cap - y(i)) * 1;
                
                m = m - L * delta_m;
                b = b - L * delta_b;
        end
        error_prev = error;
        error = calError(n,m,b,x,y)
        if isequal(error,error_prev)
            break;
        end
          
 end
end


  function error = calError(n,m,b,x,y)
      error=0;
      for i=1:n
          Y = m * x(i) + b;
           ycap = 1 / (1+exp(-Y));
           error = error + (-y(i)*log(ycap) + (1-y(i))*log(1-ycap));
      end
     
  end



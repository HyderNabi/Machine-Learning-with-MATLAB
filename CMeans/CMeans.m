function CMeans()
clear;
clc;
format long;
%data here
%EXAMPLE 1 IN NOTES
X = [1 3;1.5 3.2;1.3 2.8;3 1];
%EXAMPLE 2 IN NOTES
%X = [1 2 ; 2 3; 9 4; 10 1]; 

%STEP 1 :-  INITIALIZE THE MODEL PARAMETERS

%NO OF ROWS IN DATA SET
n = size(X,1);
%No of Clusters
c = 2;

%Fuzziness Parameter
m = 2;

%PSEUDO PARTITION MATRIX FOR EXAMPLE 1
U = [1 1 1 0;0 0 0 1];
%EXAMPLE 2
%U = [0.4 0.88 0.41 0.27; 0.6 0.12 0.59 0.73];

OLD_U = [];

%Parameters
i_max = size(U,1);
j_max = c;
k_max = size(U,2);

%Centeroids (V(i,j))
Cent = zeros(i_max,j_max);
OLD_Cent = [];

%Distance Matrix
D = [];

%THRSHOLD
E = 0.01;
while 1
    
    OLD_U = U;
    
    OLD_Cent = Cent;
    
    %STEP 2 :- CALCULATE THE CENTEROIDS
    for i = 1:i_max
        for j = 1:j_max
            Cent(i,j) = CalculateCenteroid(U,X,i,j,m,n);
        end
    end
    
    Cent
    
     %STEP 3 :- UPDATE THE PARTITION MATRIX
        %STEP 3.1 :- CALCULATE THE DISTANCE OF EVERY OBJECT TO EVERY
        %CLUSTER
        % n = NO OF ROWS IN DATA SET
        % c = NO OF CLUSTERS
        for i=1:c
            for j = 1:n
                D(i,j) = Edist(X(j,1),Cent(i,1),X(j,2),Cent(i,2));
            end
        end
        
        %STEP 3.2 :- UPDATE ENTRIES IN THE PARTITION MATRIX
        for i = 1:1
            for k = 1:k_max
                U(i,k) = updatePM(D,i,k,m,c);
                U(2,k) = 1 - U(i,k);
            end
        end
        
        
        %STEP 4 :- TERMINATION CRITERIA
        MAXNORM = maxNorm(U,OLD_U,k);
        
        U
        
        if Cent == OLD_Cent 
            %Stop the ALgorithm
            break;
        end
end

%END OF WHILE
end


%FUNCTION USED TO CALCULATE THE CENTEROIDS OF CLUSTERS
function coordinate = CalculateCenteroid(U,X,i,j,m,n)
    sum1 = 0;
    sum2 = 0;
        for k = 1:n
            sum1 = sum1 + U(i,k)^m * X(k,j);
            sum2 = sum2 + U(i,k)^m;
        end
        
        coordinate = sum1 / sum2;        
end

%FUNCTION USED TO CALCULATE THE EUCLIDEAN DISTANCE
function x =  Edist(x1,x2,y1,y2)
x = sqrt((x1-x2)^2+(y1-y2)^2);
end

%FUNCTION USED TO CALCULATE THE ENTRIES OF THE PARTITION MATRIX
function entry = updatePM(D,i,k,m,c)
    sum = 0;   
    pow = 1 / (m-1);
    for j = 1:c
         sum = sum + (D(i,k) / D(j,k))^2;
    end
   entry = 1 / ((sum)^ pow);
end

function val = maxNorm(U,OLD_U,k)
    result = [];
    for i = 1:k
       result(i) =  abs(U(1,i)^2 + U(2,i)^2 - OLD_U(1,i)^2 + OLD_U(2,i)^2);
    end
    val = max(result);
end
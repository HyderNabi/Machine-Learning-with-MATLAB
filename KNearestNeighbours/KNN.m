function KNN()
clc;
clear;
D = load("../DataSets/Iris.txt");
N = size(D,1);
K = 5;
NC = 3;
z = [6.8   3.2   5.9   2.3 0 ;5.4   3.0   4.5   1.5 0];
    for i = 1: size(z,1)
        for j = 1:N
            a = z(i,1:end-1);
            b = D(j,1:end-1);
            Dist(j,:) =  dist(a,b);
        end
        D_Z = K_Minimun(D,Dist,K);
       z(i,end) = argMax(D_Z,NC)
    end
end
function y = argMax(D_Z,NC)
    count = zeros(1,NC);
    for i=1:size(D_Z,1)
        count(D_Z(i,end))  = count(D_Z(i,end)) + 1;
    end
    [m,i] = max(count);
    y = i;
end
function D_Z =  K_Minimun(D,Dist,K)
    D_Z = [];
    [min,in] = sort(Dist);
    index = in(1:K);
    D_Z = D(index,:);   
end
function Dist =  dist(a,b)
    Dist = 0;
    for i = 1:size(a,2)
       Dist = Dist + (( a(i) - b(i) ) ^ 2 );
    end
    Dist = sqrt(Dist)
end
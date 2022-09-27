function Agg_Hie_Clustering
data = [0.40 0.53; 0.22 0.38; 0.35 0.32; 0.26 0.19; 0.08 0.41; 0.45 0.30];
length = size(data,1);
disT = dist(data,data');
s = size(data,2);
 for i = 1:length
     data(i,s+1) = i;
 end
[x,y] = Min(disT)
data = merge(x,y,data)
disT = uPdateDist()
end
function  uPdateDist(x,y,disT)
    
end
function data =  merge(x,y,data)
    s = size(data,2);
    for i = 1:size(data,1)
        if i == x | i == y
            data(i,s+1) = y;
        else
            data(i,s+1) = data(i,s)
        end
    end
    
end

function [x,y] = Min(disT)
    min = disT(2,1) ;  
    x = 2;
    y = 1;
    for i = 1:size(disT,1)
        for j=1:size(disT,2)
            if disT(i,j) < min && i>j
                min = disT(i,j);
                x = i;
                y = j;
            end
        end
    end
end

function KMeans()
    clc;
    clear;
    K = 3;
    data = load('iris.txt');
   % data = load('MC.txt');
  %  data(:,end+1) = 0;
    n = size(data,1);
    centroid = [];
    for i = 1:K
        centroid = [centroid;data(ceil(i*n/K),1:size(data,2)-1)];
    end
    
    while true
        TEMP = centroid;
       for i = 1:n
            for j = 1:K
                dist(j) = Mdist(data(i,:),centroid(j,:));
            end
            [m,label] = min(dist);
            data(i,end) = label;
       end
       %END FOR
            centroid = UpdateC(data,K);
            centroid
            if TEMP == centroid 
                break;
            end
        
    end  
    %END WHILE
    
    data
    plt(data,K);
   

end
%END KMEANS
function val =  Mdist(record,cent)
    val = 0;
    for i = 1:size(record,2)-1
       % val = val + sqrt((record(i)-cent(i)) ^2) ;
        val = val + abs(record(i)-cent(i)) ;
    end
end
function centroid =  UpdateC(data,K)
    NO_column = size(data,2) - 1;
   
    for i = 1:K
         Vector(1:NO_column) = 0;
         N = 0;
    
        for j = 1:size(data,1)
            if data(j,end) == i
                row = data(j,1:NO_column);
                Vector =  Vector + row;
                N = N + 1;
            end
        end
        centroid(i,:) = Vector / N;
    end
end
function plt(data,K)
   for i = 1 : K
      for j= 1:size(data,1) 
          val = data(j,end);
            if val == i
                plot(data(j,1),data(j,2),'O' );
            end
      end
      hold on;
   end
end
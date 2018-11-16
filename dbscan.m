clear all;
load('DBSCAN_Data.mat');
data = X(1:1000,:);
eps = 0.1;
minpts = 50;


c = 0;
labels = zeros(size(data,1),1);

for i = 1:size(data,1)  %for all rows aka data points
    if (labels(i) ~= 0)
        continue
    end
    n = rangequery(data,data(i,:),eps);
    if (length(n) < minpts)
        labels(i) = -1;
        continue
    end

    c = c+1;
    labels(i) = c;
    seed = setdiff(n, i);
    
    while( ~isempty(seed) )
        q = seed(1);
        if (labels(q) == -1)
            labels(q) = c;
        elseif (labels(q) ~= 0)
            seed = setdiff(seed,q);
            continue
        end
        labels(q) = c;
        nq = rangequery(data, data(q,:), eps);
        if (length(nq) >= minpts)
            seed = union(seed,nq,'stable');
        end
        seed = setdiff(seed,q);
    end
    
        

end

    



function neighbors = rangequery(x, q, eps)
neighbors = [];

for i =  1:size(x,1)
    if (norm( q-x(i,:) ) < eps)
        neighbors = union(neighbors,i,'stable');
    end
end
    
end

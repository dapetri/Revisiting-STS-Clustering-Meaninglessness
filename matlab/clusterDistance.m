function [clusDist] = clusterDistance(A,B,distM)
%param a: cluster centres derived from one run of clustering algor (shape: [k,w])
%param b: cluster centres derived from different run of clustering algor (shape: [k,w])
%param d: distance metric
n = size(A,1);
m = size(B,1);
dim = size(A,2);

assert(dim == size(B,2));

clusDist = 0;
for i = 1:n
    minn = Inf;
    for j = 1:m 
        d = distM(A(i,1:dim),B(j,1:dim));
        if d < minn
            minn = d;
        end
    clusDist = clusDist + minn;
    end
end
end


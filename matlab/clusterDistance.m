function [clusDist] = clusterDistance(A,B,distM)
%Calculate distance between to sets of clusters (as defined by Keogh).
%   param A: cluster centres derived from one run of clustering algor (shape: [k,w])
%   param B: cluster centres derived from different run of clustering algor (shape: [k,w])
%   param distM: distance metric
%   return clusDist: cluster distance
n = size(A,1);
m = size(B,1);
dimm = size(A,2);

assert(dimm == size(B,2));

clusDist = 0;
for i = 1:n
    minn = Inf;
    for j = 1:m 
        d = distanceMetric(A(i,1:dimm),B(j,1:dimm),distM);
        if d < minn
            minn = d;
        end
    end
    clusDist = clusDist + minn;
end
end


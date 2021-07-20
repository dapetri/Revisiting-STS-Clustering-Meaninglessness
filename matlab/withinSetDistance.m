function [d] = withinSetDistance(X,distM)
%Calculate the cluster distance within a set of clusters (as defined by Keogh).
%    :param X: set of cluster centers derived with the same clustering method (shape: [k,w,n])
%    :param distM: name/tag of distance metric to be used for distance calculation
%    :return dist: within set distance
n = size(X,3);
d = 0;
for i = 1:n
    for j = 1:n
        d = d + clusterDistance(X(:,:,i),X(:,:,j),distM);
    end
end
d = d / n^2;
end


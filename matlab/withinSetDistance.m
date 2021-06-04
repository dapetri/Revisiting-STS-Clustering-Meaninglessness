function [dist] = withinSetDistance(X,distM)
%Calculate the cluster distance within a set of clusters (as defined by Keogh).
%    :param X: set of cluster centers derived with the same clustering method (shape: [k,w,n])
%    :param distM: name/tag of distance metric to be used for distance calculation
%    :return dist: within set distance
n = size(X,3);
dist = 0;
for i = 1:n
    for j = 1:n
        dist = dist + clusterDistance(X(:,:,i),X(:,:,j),distM);
    end
end
dist = dist / n^2;
end


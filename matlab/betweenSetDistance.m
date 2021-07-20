function [d] = betweenSetDistance(X,Y,distM)
%Calculate the cluster distance between two sets of clusters (as defined by Keogh).
%    :param X: set of cluster centers derived with the same clustering method (shape: [k,w,n])
%    :param Y: set of cluster centers derived with the same but different clustering method as x (shape: [k,w,n])
%    :param distM: name/tag of distance metric to be used for distance calculation
%    :return dist: between set distance
n = size(X,3);
m = size(Y,3);

d = 0;
for i = 1:n
    for j = 1:m
        d = d + clusterDistance(X(:,:,i),Y(:,:,j),distM);
    end
end
d = d / (n*m);
end


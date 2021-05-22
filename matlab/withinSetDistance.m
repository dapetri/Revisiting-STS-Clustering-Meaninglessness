function [dist] = withinSetDistance(X,distM)
%param x: set of cluster centers (shape: [k,w,n])
n = size(X,3);
dist = 0;
for i = 1:n
    for j = 1:n
        dist = dist + clusterDistance(X(:,:,i),X(:,:,j),distM);
    end
end
dist = dist / n^2;
end


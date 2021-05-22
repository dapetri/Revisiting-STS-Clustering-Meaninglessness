function [dist] = betweenSetDistance(X,Y,distM)
%param X: set of cluster centers (shape: [k,w,n])
%param Y: set of cluster centers (shape: [k,w,n])
n = size(X,3);
m = size(Y,3);

dist = 0;
for i = 1:n
    for j = 1:m
        dist = dist + clusterDistance(X(:,:,i),Y(:,:,j),distM);
    end
end
dist = dist / (n*m);
end


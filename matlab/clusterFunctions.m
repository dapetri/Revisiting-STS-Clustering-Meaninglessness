function [centroids] = clusterFunctions(featureMatrix,k,algorName)
%CLUSTERFUNCTION Summary of this function goes here
%   Detailed explanation goes here

centroids = 0;
if algorName == "kmeans"
    [~,C] = kmeans(featureMatrix,k,"Start","plus");
    centroids = C;
elseif algorName == "agglo"
    tags = clusterdata(featureMatrix,k);
    centroids = zeros(k,size(featureMatrix,2));
    counts = zeros(k);
    for i=1:size(tags,1)
        tag = tags(i);
        counts(tag) = counts(tag)+1;
        centroids(tag,:) = centroids(tag,:) + featureMatrix(i,:);
    end    
elseif algorName == "gmm"
    gmm = fitgmdist(featureMatrix,k);
    centroids = gmm.mu;
end
end


function [centroids] = clusterFunctions(featureMatrix,k,algorName,unify)
%Calculating centroids for given feature matrix and specified clustering algorithm.
%    :param featureMatrix: (shape: [n,w])
%    :param k: number of clusters to be found
%    :param algorName: name/tag of cluster algorithm to be used
%    :param unify: boolean if hyperparameters of cluster function should be same or default values
%    :return centroids: centroids determined (shape: [k,w])

if algorName == "kmeans"
    if unify
        [~,C] = kmeans(featureMatrix,k,'Distance','sqeuclidean','MaxIter',300,'Replicates',1,'Start','plus');
    else
        [~,C] = kmeans(featureMatrix,k);
    end
    centroids = C;
elseif algorName == "agglo"
    if unify
        tags = clusterdata(featureMatrix,'Criterion','distance','Distance','euclidean','Linkage','ward','MaxClust',k);        
    else
        tags = clusterdata(featureMatrix,k);
    end
    centroids = zeros(k,size(featureMatrix,2));
    counts = zeros(k);
    for i=1:size(tags,1)
        tag = tags(i);
        counts(tag) = counts(tag)+1;
        centroids(tag,:) = centroids(tag,:) + featureMatrix(i,:);
    end
    for i=1:k
        centroids(i,:) = centroids(i,:) / counts(i);
    end
elseif algorName == "gmm"
    if unify
        options = statset('MaxIter',100,'TolFun',1e-3);
        gmm = fitgmdist(featureMatrix,k,'CovarianceType','diagonal','Options',options,'RegularizationValue',1e-6,'Start','plus');
    else
        gmm = fitgmdist(featureMatrix,k);
    end
    centroids = gmm.mu;
end
end


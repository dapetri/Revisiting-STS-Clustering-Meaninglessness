function [meaningfulness_sts,meaningfulness_whole] = calculateMeaningfulness(ts, opposing_ts ,n, k, w, r, distM, normMethod, clusterAlgo, reducedSampling, dimRed)
%Calculating sts and whole meaningfulness for 2 given time series where ts is the time series in regard.
%    :param ts: time series in regard (shape: [m])
%    :param opposing_ts: opposing time series (e.g. random walk) (shape: [m']) where m' not necessatily equal to m
%    :param n: amount of meaningfulness calculations to be averaged over
%    :param k: amount of centroids to be calculated
%    :param w: sliding window size
%    :param r: size of sets for between/within set distance
%    :param normMethod: name/tag of normalizer to be used
%    :param reducedSampling: if true, sampling size for whole clustering will be reduced
%    :param dist_metric_name: name/tag of distance metric to be used
%    :param clusterAlgo: name/tag of clustering algorithm to be used
%    :param dimRed: if true, pca will be calculated on feature matrix for w>8
%    :return meaningfulness_sts,meaningfulness_whole: sts meaningfulness, whole meaningfulness

meaningfulness_sts = 0;
meaningfulness_whole = 0;

sts_ts_matrix = toStsMatrix(ts, w);
whole_ts_matrix = toRandomSamplingMatrix(ts, w, reducedSampling);

sts_opposing_matrix = toStsMatrix(opposing_ts, w);
whole_opposing_matrix = toRandomSamplingMatrix(opposing_ts, w, reducedSampling);

sts_ts_matrix = scaleFeatureMatrix(sts_ts_matrix, normMethod);
whole_ts_matrix = scaleFeatureMatrix(whole_ts_matrix, normMethod);
sts_opposing_matrix = scaleFeatureMatrix(sts_opposing_matrix, normMethod);
whole_opposing_matrix = scaleFeatureMatrix(whole_opposing_matrix, normMethod);


if dimRed && w>8
    [~,score,~] = pca(sts_ts_matrix);
    sts_ts_matrix = score;
    
    [~,score,~] = pca(whole_ts_matrix);
    whole_ts_matrix = score;
    
    [~,score,~] = pca(sts_opposing_matrix);
    sts_opposing_matrix = score;
    
    [~,score,~] = pca(whole_opposing_matrix);
    whole_opposing_matrix = score;
end
for z = 1:n
    sts_ts_kmeans_centers = zeros(k,w);
    whole_ts_kmeans_centers = zeros(k,w);
    sts_opposing_kmeans_centers = zeros(k,w);
    whole_opposing_kmeans_centers = zeros(k,w);

    for i = 1:r
        sts_ts_kmeans_centers(:,:,i) = clusterFunctions(sts_ts_matrix,k,clusterAlgo);
        whole_ts_kmeans_centers(:,:,i) = clusterFunctions(whole_ts_matrix,k,clusterAlgo);
        sts_opposing_kmeans_centers(:,:,i) = clusterFunctions(sts_opposing_matrix,k,clusterAlgo);
        whole_opposing_kmeans_centers(:,:,i) = clusterFunctions(whole_opposing_matrix,k,clusterAlgo);    
        
    end
    meaningfulness_sts = meaningfulness_sts + clusteringMeaningfulness(sts_ts_kmeans_centers, sts_opposing_kmeans_centers, distM);
    meaningfulness_whole =  meaningfulness_whole + clusteringMeaningfulness(whole_ts_kmeans_centers, whole_opposing_kmeans_centers, distM);
end
meaningfulness_sts = meaningfulness_sts/n;
meaningfulness_whole = meaningfulness_whole/n;
end


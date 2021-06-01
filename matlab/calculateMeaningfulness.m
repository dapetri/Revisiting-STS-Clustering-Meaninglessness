function [meaningfulness_sts,meaningfulness_whole] = calculateMeaningfulness(ts, rw ,n, k, w, r, distM, normMethod, clusterAlgo, reducedSampling, dimRed)
%param rw:
%param ts:
%param n:
%param k:
%param w:
%param r:
%return:
meaningfulness_sts = 0;
meaningfulness_whole = 0;

sts_ts_matrix = toStsMatrix(ts, w);
whole_ts_matrix = toRandomSamplingMatrix(ts, w, reducedSampling);

sts_random_matrix = toStsMatrix(rw, w);
whole_random_matrix = toRandomSamplingMatrix(rw, w, reducedSampling);

sts_ts_matrix = scaleFeatureMatrix(sts_ts_matrix, normMethod);
whole_ts_matrix = scaleFeatureMatrix(whole_ts_matrix, normMethod);
sts_random_matrix = scaleFeatureMatrix(sts_random_matrix, normMethod);
whole_random_matrix = scaleFeatureMatrix(whole_random_matrix, normMethod);


if dimRed && w>8
    [~,score,~] = pca(sts_ts_matrix);
    sts_ts_matrix = score;
    
    [~,score,~] = pca(whole_ts_matrix);
    whole_ts_matrix = score;
    
    [~,score,~] = pca(sts_random_matrix);
    sts_random_matrix = score;
    
    [~,score,~] = pca(whole_random_matrix);
    whole_random_matrix = score;
end
for z = 1:n
    sts_ts_kmeans_centers = zeros(k,w);
    whole_ts_kmeans_centers = zeros(k,w);
    sts_random_kmeans_centers = zeros(k,w);
    whole_random_kmeans_centers = zeros(k,w);

    for i = 1:r
        sts_ts_kmeans_centers(:,:,i) = clusterFunctions(sts_ts_matrix,k,clusterAlgo);
        whole_ts_kmeans_centers(:,:,i) = clusterFunctions(whole_ts_matrix,k,clusterAlgo);
        sts_random_kmeans_centers(:,:,i) = clusterFunctions(sts_random_matrix,k,clusterAlgo);
        whole_random_kmeans_centers(:,:,i) = clusterFunctions(whole_random_matrix,k,clusterAlgo);    
        
    end
    meaningfulness_sts = meaningfulness_sts + clusteringMeaningfulness(sts_ts_kmeans_centers, sts_random_kmeans_centers, distM);
    meaningfulness_whole =  meaningfulness_whole + clusteringMeaningfulness(whole_ts_kmeans_centers, whole_random_kmeans_centers, distM);
end
meaningfulness_sts = meaningfulness_sts/n;
meaningfulness_whole = meaningfulness_whole/n;
end


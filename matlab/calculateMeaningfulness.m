function [meaningfulness] = calculateMeaningfulness(target_ts, opposing_ts ,n, k, w, r, distM, normMethod, clusterAlgo, reducedSampling, dimRed, unify, seed_)
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

sts_target_matrix = toStsMatrix(target_ts, w);
sts_opposing_matrix = toStsMatrix(opposing_ts, w);

whole_target_matrix = toRandomSamplingMatrix(target_ts, w, reducedSampling, seed_);
whole_opposing_matrix = toRandomSamplingMatrix(opposing_ts, w, reducedSampling, seed_);

sts_target_matrix = scaleFeatureMatrix(sts_target_matrix, normMethod);
sts_opposing_matrix = scaleFeatureMatrix(sts_opposing_matrix, normMethod);

whole_target_matrix = scaleFeatureMatrix(whole_target_matrix, normMethod);
whole_opposing_matrix = scaleFeatureMatrix(whole_opposing_matrix, normMethod);


if dimRed 
    sts_target_matrix = dimReduction(sts_target_matrix, 90);
    sts_opposing_matrix = dimReduction(sts_opposing_matrix, 90);

    whole_target_matrix = dimReduction(whole_target_matrix, 90);
    whole_opposing_matrix = dimReduction(whole_opposing_matrix, 90);
end

w_sts = min(size(sts_target_matrix, 2), size(sts_opposing_matrix, 2));
w_whole = min(size(whole_target_matrix, 2), size(whole_opposing_matrix, 2));

sts_target_matrix = sts_target_matrix(:,1:w_sts);
sts_opposing_matrix = sts_opposing_matrix(:,1:w_sts);

whole_target_matrix = whole_target_matrix(:,1:w_whole);
whole_opposing_matrix = whole_opposing_matrix(:,1:w_whole);

for z = 1:n
    sts_target_centers = zeros(k,w_sts);
    sts_opposing_centers = zeros(k,w_sts);
       
    whole_target_centers = zeros(k,w_whole);
    whole_opposing_centers = zeros(k,w_whole);

    for i = 1:r
        sts_target_centers(:,:,i) = clusterFunctions(sts_target_matrix,k,clusterAlgo,unify);
        sts_opposing_centers(:,:,i) = clusterFunctions(sts_opposing_matrix,k,clusterAlgo,unify);
        
        whole_target_centers(:,:,i) = clusterFunctions(whole_target_matrix,k,clusterAlgo,unify);
        whole_opposing_centers(:,:,i) = clusterFunctions(whole_opposing_matrix,k,clusterAlgo,unify);    
        
    end
    %disp(whole_target_centers);
    
    meaningfulness_sts = meaningfulness_sts + clusteringMeaningfulness(sts_target_centers, sts_opposing_centers, distM);
    meaningfulness_whole = meaningfulness_whole + clusteringMeaningfulness(whole_target_centers, whole_opposing_centers, distM);
end
meaningfulness_sts = meaningfulness_sts/n;
meaningfulness_whole = meaningfulness_whole/n;
meaningfulness = [meaningfulness_sts, meaningfulness_whole];
end


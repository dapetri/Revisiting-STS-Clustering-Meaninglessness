function [meaningfulness_sts,meaningfulness_whole] = calculateKMeansMeaningfulness(ts, rw ,n, k, w, r, distM, normMethod)
%param rw:
%param ts:
%param n:
%param k:
%param w:
%param r:
%return:
maxIter = 1000;

meaningfulness_sts = 0;
meaningfulness_whole = 0;

sts_ts_matrix = toStsMatrix(ts, w);
whole_ts_matrix = toRandomSamplingMatrix(ts, w);

sts_random_matrix = toStsMatrix(rw, w);
whole_random_matrix = toRandomSamplingMatrix(rw, w);

sts_ts_matrix = normalize(sts_ts_matrix, 2, normMethod);
whole_ts_matrix = normalize(whole_ts_matrix, 2, normMethod);
sts_random_matrix = normalize(sts_random_matrix, 2, normMethod);
whole_random_matrix = normalize(whole_random_matrix, 2, normMethod);

for z = 1:n
    sts_ts_kmeans_centers = zeros(k,w);
    whole_ts_kmeans_centers = zeros(k,w);
    sts_random_kmeans_centers = zeros(k,w);
    whole_random_kmeans_centers = zeros(k,w);

    for i = 1:r
        [~,C] = kmeans(sts_ts_matrix,k, 'MaxIter', maxIter);
        sts_ts_kmeans_centers(:,:,i) = C;
        
        [~,C] = kmeans(whole_ts_matrix,k, 'MaxIter', maxIter);
        whole_ts_kmeans_centers(:,:,i) = C;
        
        [~,C] = kmeans(sts_random_matrix,k, 'MaxIter', maxIter);
        sts_random_kmeans_centers(:,:,i) = C;
        
        [~,C] = kmeans(whole_random_matrix,k, 'MaxIter', maxIter);
        whole_random_kmeans_centers(:,:,i) = C;    
        
    end
    meaningfulness_sts = meaningfulness_sts + clusteringMeaningfulness(sts_ts_kmeans_centers, sts_random_kmeans_centers, distM);
    meaningfulness_whole =  meaningfulness_whole + clusteringMeaningfulness(whole_ts_kmeans_centers, whole_random_kmeans_centers, distM);
end
meaningfulness_sts = meaningfulness_sts/n;
meaningfulness_whole = meaningfulness_whole/n;
end


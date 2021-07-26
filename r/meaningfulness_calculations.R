source("ts_processing.R")
source("distance_measures.R")
source("meaningfulness_functions.R")
source('scale_feature_matrix.R')
source("cluster_functions.R")
library(caret)

calculate_meaningfulness <- function(ts,rw,n,k,w,r,dist_m,norm_method,cluster_algo,reduced_sampling,dim_red,unify) {
#  Calculating sts and whole meaningfulness for 2 given time series where ts is the time series in regard.
#  :param ts: time series in regard (shape: [m])
#  :param opposing_ts: opposing time series (e.g. random walk) (shape: [m']) where m' not necessatily equal to m
#  :param n: amount of meaningfulness calculations to be averaged over
#  :param k: amount of centroids to be calculated
#  :param w: sliding window size
#  :param r: size of sets for between/within set distance
#  :param normalizer: name/tag of normalizer to be used
#  :param reduced_sampling_size: if true, sampling size for whole clustering will be reduced
#  :param dist_metric_name: name/tag of distance metric to be used
#  :param cluster_algor_name: name/tag of clustering algorithm to be used
#  :param dim_red: if true, pca will be calculated on feature matrix for w>8
#  :return: sts meaningfulness, whole meaningfulness
  meaningfulness_sts <- 0
  meaningfulness_whole <- 0
  
  sts_ts_matrix <- to_sts_matrix(ts, w)
  sts_ts_matrix <- scale_feature_matrix(sts_ts_matrix, norm_method)
  
  whole_ts_matrix <- to_random_sampling_matrix(ts, w, reduced_sampling)
  whole_ts_matrix <- scale_feature_matrix(whole_ts_matrix, norm_method)
  
  sts_random_matrix <- to_sts_matrix(rw, w)
  sts_random_matrix <- scale_feature_matrix(sts_random_matrix, norm_method)
  
  whole_random_matrix <- to_random_sampling_matrix(rw, w, reduced_sampling)
  whole_random_matrix <- scale_feature_matrix(whole_random_matrix, norm_method)
  
  if (dim_red && w>8) {
    
  }
  
  for (z in 1:n) {
    sts_ts_centers <- array(0, c(k,w,r))
    whole_ts_centers <- array(0, c(k,w,r))
    sts_random_centers <- array(0, c(k,w,r))
    whole_random_centers <- array(0, c(k,w,r))
    
    for (i in 1:r) {
      sts_ts_centers[,,i] <- cluster_functions(sts_ts_matrix,k,cluster_algo,unify)
      whole_ts_centers[,,i] <- cluster_functions(whole_ts_matrix,k,cluster_algo,unify)
      sts_random_centers[,,i] <- cluster_functions(sts_random_matrix,k,cluster_algo,unify)
      whole_random_centers[,,i] <- cluster_functions(whole_random_matrix,k,cluster_algo,unify)
    }
    #print(sts_ts_kmeans_centers)
    meaningfulness_sts <- meaningfulness_sts + cluster_meaningfulness(sts_ts_centers, sts_random_centers, dist_m)
    meaningfulness_whole <-  meaningfulness_whole + cluster_meaningfulness(whole_ts_centers, whole_random_centers, dist_m)
  }
  return(c(meaningfulness_sts/n, meaningfulness_whole/n))
}

 
source("ts_processing.R")
source("distance_measures.R")
source("meaningfulness_functions.R")
source('scale_feature_matrix.R')
source("cluster_functions.R")
library(caret)

calculate_meaningfulness <- function(ts,rw,n,k,w,r,dist_m,norm_method,cluster_algo,reduced_sampling,dim_red) {
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
  
  for (z in 1:n) {
    sts_ts_kmeans_centers <- array(0, c(k,w,r))
    whole_ts_kmeans_centers <- array(0, c(k,w,r))
    sts_random_kmeans_centers <- array(0, c(k,w,r))
    whole_random_kmeans_centers <- array(0, c(k,w,r))
    
    for (i in 1:r) {
      sts_ts_kmeans_centers[,,i] <- cluster_functions(sts_ts_matrix,k,cluster_algo)
      whole_ts_kmeans_centers[,,i] <- cluster_functions(whole_ts_matrix,k,cluster_algo)
      sts_random_kmeans_centers[,,i] <- cluster_functions(sts_random_matrix,k,cluster_algo)
      whole_random_kmeans_centers[,,i] <- cluster_functions(whole_random_matrix,k,cluster_algo)
    }
    meaningfulness_sts <- meaningfulness_sts + cluster_meaningfulness(sts_ts_kmeans_centers, sts_random_kmeans_centers, distM)
    meaningfulness_whole <-  meaningfulness_whole + cluster_meaningfulness(whole_ts_kmeans_centers, whole_random_kmeans_centers, distM)
  }
  return(c(meaningfulness_sts/n, meaningfulness_whole/n))
}

 
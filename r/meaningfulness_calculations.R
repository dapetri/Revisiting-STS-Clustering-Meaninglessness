source("ts_processing.R")
source("distance_measures.R")
source("meaningfulness_functions.R")
source('scale_feature_matrix.R')
source("cluster_functions.R")
source("dim_reduction.R")
library(caret)

calculate_meaningfulness <- function(ts,rw,n,k,w,r,dist_m,norm_method,cluster_algo,reduced_sampling,dim_red,unify,seed_) {
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
  
  sts_target_matrix <- to_sts_matrix(ts, w)
  sts_target_matrix <- scale_feature_matrix(sts_target_matrix, norm_method)
  
  sts_opposing_matrix <- to_sts_matrix(rw, w)
  sts_opposing_matrix <- scale_feature_matrix(sts_opposing_matrix, norm_method)
  
  whole_target_matrix <- to_random_sampling_matrix(ts, w, reduced_sampling, seed_)
  whole_target_matrix <- scale_feature_matrix(whole_target_matrix, norm_method)
  
  whole_opposing_matrix <- to_random_sampling_matrix(rw, w, reduced_sampling, seed_)
  whole_opposing_matrix <- scale_feature_matrix(whole_opposing_matrix, norm_method)
  
  if (dim_red) {
    sts_target_matrix <- dim_reduction(sts_target_matrix, 0.9)
    sts_opposing_matrix <- dim_reduction(sts_opposing_matrix, 0.9)
    
    whole_target_matrix <- dim_reduction(whole_target_matrix, 0.9)
    whole_opposing_matrix <- dim_reduction(whole_opposing_matrix, 0.9)
  }
  
  w_sts <- min(size(sts_target_matrix)[2], size(sts_opposing_matrix)[2])
  w_whole <- min(size(whole_target_matrix)[2], size(whole_opposing_matrix)[2])
  
  
  sts_target_matrix <- sts_target_matrix[,1:w_sts]
  sts_opposing_matrix <- sts_opposing_matrix[,1:w_sts]
  
  whole_target_matrix <- whole_target_matrix[,1:w_whole]
  whole_opposing_matrix <- whole_opposing_matrix[,1:w_whole]
  
  
  for (z in 1:n) {
    sts_target_centers <- array(0, c(k,w_sts,r))
    sts_opposing_centers <- array(0, c(k,w_sts,r))
    
    whole_target_centers <- array(0, c(k,w_whole,r))
    whole_opposing_centers <- array(0, c(k,w_whole,r))
    
    for (i in 1:r) {
      sts_target_centers[,,i] <- cluster_functions(sts_target_matrix,k,cluster_algo,unify)
      sts_opposing_centers[,,i] <- cluster_functions(sts_opposing_matrix,k,cluster_algo,unify)
        
      whole_target_centers[,,i] <- cluster_functions(whole_target_matrix,k,cluster_algo,unify)
      whole_opposing_centers[,,i] <- cluster_functions(whole_opposing_matrix,k,cluster_algo,unify)
    }
    #print(whole_target_centers)
    
    
    meaningfulness_sts <- meaningfulness_sts + cluster_meaningfulness(sts_target_centers, sts_opposing_centers, dist_m)
    meaningfulness_whole <- meaningfulness_whole + cluster_meaningfulness(whole_target_centers, whole_opposing_centers, dist_m)
  }
  meaningfulness_sts <- meaningfulness_sts / n
  meaningfulness_whole <- meaningfulness_whole / n
  
  return(c(meaningfulness_sts, meaningfulness_whole))
}

 
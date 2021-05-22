source("ts_processing.R")
source("distance_measures.R")
source("meaningfulness_functions.R")
library(caret)

kmeans_meaningfulness <- function(ts,rw,n,k,w,r,distM,normMethod) {
  meaningfulness_sts <- 0
  meaningfulness_whole <- 0
  
  sts_ts_matrix <- to_sts_matrix(ts, w)
  whole_ts_matrix <- to_random_sampling_matrix(ts, w)
  sts_random_matrix <- to_sts_matrix(rw, w)
  whole_random_matrix <- to_random_sampling_matrix(rw, w)
  
  #sts_ts_matrix <- preProcess(sts_ts_matrix, method = normMethod)
  #whole_ts_matrix <- preProcess(whole_ts_matrix, method = normMethod)
  #sts_random_matrix <- preProces(sts_random_matrix, method = normMethod)
  #whole_random_matrix <- preProcess(whole_random_matrix, method = normMethod)

  for (z in 1:n) {
    sts_ts_kmeans_centers <- array(0, c(k,w,r))
    whole_ts_kmeans_centers <- array(0, c(k,w,r))
    sts_random_kmeans_centers <- array(0, c(k,w,r))
    whole_random_kmeans_centers <- array(0, c(k,w,r))
    
    for (i in 1:r) {
      sts_ts_kmeans_centers[,,i] <- kmeans(sts_ts_matrix,k)$centers
      whole_ts_kmeans_centers[,,i] <- kmeans(whole_ts_matrix,k)$centers
      sts_random_kmeans_centers[,,i] <- kmeans(sts_random_matrix,k)$centers
      whole_random_kmeans_centers[,,i] <- kmeans(whole_random_matrix,k)$centers
    }
    meaningfulness_sts <- meaningfulness_sts + cluster_meaningfulness(sts_ts_kmeans_centers, sts_random_kmeans_centers, distM)
    meaningfulness_whole <-  meaningfulness_whole + cluster_meaningfulness(whole_ts_kmeans_centers, whole_random_kmeans_centers, distM)
  }
  return(c(meaningfulness_sts/n, meaningfulness_whole/n))
}


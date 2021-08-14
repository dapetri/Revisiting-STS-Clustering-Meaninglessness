cluster_distance <- function(A,B,distM) {
#  Calculate distance between to sets of clusters (as defined by Keogh).
#  :param a: cluster centres derived from one run of clustering algor (shape: [k,w])
#  :param b: cluster centres derived from different run of clustering algor (shape: [k,w])
#  :param dist_metric_name: name/tag of distance metric to be used for distance calculation
#  :return: cluster distance
  n <- dim(A)[1]
  m <- dim(B)[1]
  w <- dim(A)[2]
  assertthat::are_equal(w,dim(B)[2])
  clust_dist <- 0
  
  for (i in 1:n) {
    minn <- Inf
    for (j in 1:m) {
      d <- distance_measure(A[i,1:w],B[j,1:w],distM)
      ## is.nan because for some reason kmeans produces sometimes centroids that are NaN vectors
      if (!is.nan(d) && d < minn) {
      #if (d < minn) {
        minn <- d
      }
    }
    clust_dist <- clust_dist + minn
  }
  return(clust_dist)
}

within_set_distance <- function(X,distM) {
#  Calculate the cluster distance within a set of clusters (as defined by Keogh).
#  :param x: set of cluster centers derived with the same clustering method (shape: [n,k,w])
#  :param dist_metric_name: name/tag of distance metric to be used for distance calculation
#  :return: within set distance
  n <- dim(X)[3]
  d <- 0
  for (i in 1:n) {
    for (j in 1:n) {
      d <- d + cluster_distance(X[,,i],X[,,j],distM)
    }
  }
  return(d / (n^2))
}

between_set_distance <- function(X,Y,distM) {
#  Calculate the cluster distance between two sets of clusters (as defined by Keogh).
#  :param x: set of cluster centers derived with the same clustering method (shape: [n,k,w])
#  :param y: set of cluster centers derived with the same but different clustering method as x (shape: [n,k,w])
#  :param dist_metric_name: name/tag of distance metric to be used for distance calculation
#  :return: between set distance
  n <- dim(X)[3]
  m <- dim(Y)[3]
  d <- 0
  for (i in 1:n) {
    for (j in 1:m) {
      d <- d + cluster_distance(X[,,i],Y[,,j],distM)
    }
  }
  return(d / (n*m))
}

cluster_meaningfulness <- function(X,Y,distM) {
#  Calculate cluster meaningfulness (as defined by Keogh)
#  :param x: set of cluster centers derived with the same clustering method (shape: [n,k,w])
#  :param y: set of cluster centers derived with the same but different clustering method as x (shape: [n,k,w])
#  :param dist_metric_name: name/tag of distance metric to be used for distance calculation
#  :return: clustering meaningfulness as a quotient of within set distance of x and between set distance between x and y
  w <- within_set_distance(X,distM)
  b <- between_set_distance(X,Y,distM)
  
  if (b == 0) {
    print('bsd was 0')
  }

  print(paste('WSD',w))
  print(paste('BSD',b))
  print('##################')
  
  m <- w / (b + 1e-6)
  
  return(m)
}

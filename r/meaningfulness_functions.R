cluster_distance <- function(A,B,distM) {
#  Calculate distance between to sets of clusters (as defined by Keogh).
#  :param a: cluster centres derived from one run of clustering algor (shape: [k,w])
#  :param b: cluster centres derived from different run of clustering algor (shape: [k,w])
#  :param dist_metric_name: name/tag of distance metric to be used for distance calculation
#  :return: cluster distance
  n <- dim(A)[1]
  m <- dim(B)[1]
  d <- dim(A)[2]
  assertthat::are_equal(d,dim(B)[2])
  clust_dist <- 0
  
  for (i in 1:n) {
    minn <- Inf
    for (j in 1:m) {
      dist <- distance_measure(A[i,1:d],B[j,1:d],distM)
      if (dist < minn) {
        minn <- dist
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
  dist <- 0
  for (i in 1:n) {
    for (j in 1:n) {
      dist <- dist + cluster_distance(X[,,i],X[,,j],distM)
    }
  }
  return(dist / n^2)
}

between_set_distance <- function(X,Y,distM) {
#  Calculate the cluster distance between two sets of clusters (as defined by Keogh).
#  :param x: set of cluster centers derived with the same clustering method (shape: [n,k,w])
#  :param y: set of cluster centers derived with the same but different clustering method as x (shape: [n,k,w])
#  :param dist_metric_name: name/tag of distance metric to be used for distance calculation
#  :return: between set distance
  n <- dim(X)[3]
  m <- dim(Y)[3]
  dist <- 0
  for (i in 1:n) {
    for (j in 1:m) {
      dist <- dist + cluster_distance(X[,,i],Y[,,j],distM)
    }
  }
  return(dist / (n*m))
}

cluster_meaningfulness <- function(X,Y,distM) {
#  Calculate cluster meaningfulness (as defined by Keogh)
#  :param x: set of cluster centers derived with the same clustering method (shape: [n,k,w])
#  :param y: set of cluster centers derived with the same but different clustering method as x (shape: [n,k,w])
#  :param dist_metric_name: name/tag of distance metric to be used for distance calculation
#  :return: clustering meaningfulness as a quotient ofwithin set distance of x and between set distance between x and y
  w <- within_set_distance(X,distM)
  b <- between_set_distance(X,Y,distM)
  #print(w)
  #print(b)
  return(w / b)
}

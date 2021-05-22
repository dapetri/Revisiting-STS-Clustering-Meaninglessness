cluster_distance <- function(A,B,distM) {
  n <- dim(A)[1]
  m <- dim(B)[1]
  d <- dim(A)[2]
  assertthat::are_equal(d,dim(B)[2])
  clust_dist <- 0
  
  for (i in 1:n) {
    minn <- Inf
    for (j in 1:m) {
      dist <- distM(A[i,1:d],B[j,1:d])
      if (d < minn) {
        minn <- dist
      }
    }
    clust_dist <- clust_dist + minn
  }
  return(clust_dist)
}

within_set_distance <- function(X,distM) {
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
  return(within_set_distance(X,distM) / between_set_distance(X,Y,distM))
}
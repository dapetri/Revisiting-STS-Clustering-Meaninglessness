k_means_pp <- function(feature_matrix, k) {
  centroids <-  array(0, c(k,dim(feature_matrix)[2]))
  
  i <- ceil(runif(1,0,dim(feature_matrix)[1]))
  centroids[1,] <- feature_matrix[i,]
  feature_matrix <- feature_matrix[-i,]
  
  amount_cents <- 1
  
  for (i in 2:k) {
    dists <- array(Inf, c(1,dim(feature_matrix)[1]))
    for (f in 1:dim(feature_matrix)[1]) {
      for (c in 1:amount_cents) {
        d <- distance_measure(centroids[c,], feature_matrix[f,], "eukl")
        if (d < dists[f]) {
          dists[f] <- d
        }
      }
    }
    s <- rowSums(dists)
    w <- runif(1,0,s)
    summ <- 0
    for (v in 1:length(dists)) {
      summ <- summ + dists[v]
      if (summ >= w) {
        centroids[i,] <- feature_matrix[v,]
        feature_matrix <- feature_matrix[-v,]
        break
      }
    }
    amount_cents <- amount_cents + 1
  }
  return(centroids)
}
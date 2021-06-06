library(ClusterR)
cluster_functions <- function(feature_matrix,k,algo_name) {
#  Calculating centroids for given feature matrix and specified clustering algorithm.
#  :param feature_matrix: (shape: [n,w])
#  :param k: number of clusters to be found
#  :param algor_name: name/tag of cluster algorithm to be used
#  :return: centroids determined (shape: [k,w])
  if (algo_name == "kmeans") {
    return(kmeans(feature_matrix,k)$centers)
  } else if (algo_name == "agglo") {
    dist_mat <- dist(feature_matrix)
    hcl <- hclust(dist_mat)
    tags <- cutree(hcl, k=k)
    centroids <- array(0,c(k,dim(feature_matrix)[2]))
    counts <- array(0,c(1,k))
    for (i in 1:length(tags)) {
      tag <- tags[i]
      counts[tag] <- counts[tag]+1
      centroids[tag,] <- centroids[tag,] + feature_matrix[i,]
    }
    for (i in 1:k) {
      centroids[i,] <- centroids[i,]/counts[i]
    }
    return(centroids)
  } else if (algo_name == "gmm") {
    gmm = GMM(feature_matrix, k)
    return(gmm$centroids)
  }
}
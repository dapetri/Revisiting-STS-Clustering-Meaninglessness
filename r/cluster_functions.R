cluster_functions <- function(feature_matrix,k,algo_name) {
  if (algo_name == "kmeans") {
    return(kmeans(feature_matrix,k)$centers)
  } else if (algo_name == "agglo") {
    hcl <- hclust(feature_matrix)
    return(cutree(hcl, k=k))
  } else if (aglo_name == "gmm") {
    return(GMM(feature_matrix, k)$centroids)
  }
}
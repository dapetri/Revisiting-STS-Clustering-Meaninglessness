scale_feature_matrix <- function(feat_matrix,normMethod) {
  if (normMethod == "none") {
    return(feat_matrix)
  } else {
    return(preProcess(feat_matrix, method=normMethod))
  }
}
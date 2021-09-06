scale_feature_matrix <- function(feat_matrix,normMethod) {
#  Scales feature matrix.
#  :param feat_matrix: feature matrix (shape: [n,w])
#  :param normMethod: name/tag of scaler to be used.
#  :return: scaled feature matrix (shape: [n,w])
  if (normMethod == "none") {
    return(feat_matrix)
  } else {
    return(t(scale(t(feat_matrix))))
  }
}
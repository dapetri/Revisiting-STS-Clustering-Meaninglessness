library(pracma)
distance_measure <- function(v,w,metric_name) {
#  Calculates distance between v and w accodring to passed metric.
#  :param v: vector (shape: [m])
#  :param w: vector (shape: [m])
#  :param metric_name: name/tag of distance metric to be used for calculation.
#  :return: distance between v and w
  if (metric_name == "eukl") {
    return(Norm(v-w))
  }
}
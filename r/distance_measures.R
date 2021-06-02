euklidean_distance <- function(v,w) {
  return(Norm(v-w))
}

distance_measure <- function(v,w,metric_name) {
  if (metric_name == "eukl") {
    return(Norm(v-w))
  }
}
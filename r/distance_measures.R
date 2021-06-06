library(pracma)
distance_measure <- function(v,w,metric_name) {
  if (metric_name == "eukl") {
    return(Norm(v-w))
  }
}
dim_reduction <- function(x, mu) {
  p <- prcomp(t(x))
  summ <- sum(p$sdev)
  L <- 1
  s <- 0
  while ((s / summ) < mu) {
    s <- s + p$sdev[L]
    L <- L + 1
    
  }
  return(p$rotation[,1:L])
}
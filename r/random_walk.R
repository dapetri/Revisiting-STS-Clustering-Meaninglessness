create_random_walk <- function(ts) {
  n <- length(ts)
  ma <- max(ts)
  mi <- min(ts)
  movement <-  10;
  
  random_walk <- c(1:n)
  random_walk[1] <- mi + runif(1) * (ma-mi)

  for (i in 2:n) {
    r <- runif(1) * movement
    if (runif(1) >= 0.5) {
      random_walk[i] <- random_walk[i-1]+r
    } else {
      random_walk[i] <- random_walk[i-1]-r
    }
  }
  return(random_walk)
}
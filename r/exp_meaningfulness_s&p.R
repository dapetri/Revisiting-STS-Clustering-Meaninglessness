source("random_walk.R")
source("distance_measures.R")
source("meaningfulness_calculations.R")

n <- 100
r <- 3
ks <- c(3,5,7,11)
ws <- c(8,16,32)

norm_methods = c("center", "scale", "range");

ts <- read.csv('../data/spx_daily_11-21.csv')
ts <- ts[,2]

rw <- create_random_walk(ts)

l_ks <- length(ks)
l_ws <- length(ws)

meaningfulness_sts <- matrix(0, nrow = (l_ks*l_ws), ncol = 3)
meaningfulness_whole <- matrix(0, nrow = (l_ks*l_ws), ncol = 3)

#sprintf("n: %d, r: %d", n, r)
i <- 1
for (k in ks) {
  for (w in ws) {
    m <- kmeans_meaningfulness(ts,rw,n,k,w,r,euklidean_distance,norm_methods[3])
    meaningfulness_sts[i,] <- c(w,k,m[1])
    meaningfulness_whole[i,] <- c(w,k,m[2])
    i <- i+1
    #sprintf("k=%d, w=%d -- STS-meaning: %f, Whole-meaning: %f", k, w, m[1], m[2])
  }
}



source("random_walk.R")
source("meaningfulness_calculations.R")

n <- 1
r <- 3
ks <- c(3,5,7,11)
ws <- c(8,16,32)


spx_short <- read.csv('../data/spx_daily_11-21.csv')
spx_short <- spx_short[,2]

spx_long <- read.csv('../data/spx_monthly_alltime.csv')
spx_long <- spx_long[,2]

min_daily_temp <- read.csv('../data/daily-minimum-temperatures-in-melbourne.csv')
min_daily_temp <- min_daily_temp[,2]

bip_de <- read.csv('../data/bip_de_preisbereinigt.csv',sep=';')
bip_de <- bip_de[,2]

dax <- read.csv('../data/dax.csv')
dax <- dax[,2]

dax_alltime <- read.csv('../data/dax_alltime.csv')
dax_alltime <- dax_alltime[,2]

bitcoin_alltime <- read.csv('../data/bitcoin_alltime.csv')
bitcoin_alltime <- bitcoin_alltime[,2]


norm_methods <- c("none","center", "scale", "range");
dist_metrics <- c("eukl")
cluster_algos <- c("kmeans","agglo","gmm")
#time_series <- c(spx_short, spx_long, min_daily_temp, bip_de, dax, dax_alltime, bitcoin_alltime)

norm_method <- norm_methods[1]
dist_metric <- dist_metrics[1]
cluster_algo <- cluster_algos[2]

ts <- spx_short
rw <- create_random_walk(ts)

reduced_sampling = FALSE
#not working yet
dim_red = FALSE


l_ks <- length(ks)
l_ws <- length(ws)

meaningfulness_sts <- matrix(0, nrow = (l_ks*l_ws), ncol = 3)
meaningfulness_whole <- matrix(0, nrow = (l_ks*l_ws), ncol = 3)

sprintf("n: %d, r: %d", n, r)
i <- 1
for (k in ks) {
  for (w in ws) {
    m <- calculate_meaningfulness(ts,rw,n,k,w,r,dist_metric,norm_method,cluster_algo,reduced_sampling,dim_red)
    meaningfulness_sts[i,] <- c(w,k,m[1])
    meaningfulness_whole[i,] <- c(w,k,m[2])
    i <- i+1
    sprintf("k=%d, w=%d -- STS-meaning: %f, Whole-meaning: %f", k, w, m[1], m[2])
  }
}

print(meaningfulness_sts)

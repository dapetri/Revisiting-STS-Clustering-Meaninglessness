source("ts_processing.R")

n <- 30
k <- 3
w <- 128

cbf <- read.csv('../data/cbf.csv')
cbf <- t(cbf[,2:(3*n+1)])

cbf_concat <- create_concatenated_timeseries(cbf)
cbf_sts <- to_sts_matrix(cbf_concat,w)

km_whole <- kmeans(cbf,k)
km_sts <- kmeans(cbf_sts,k)

C_whole <- km_whole$centers
C_sts <- km_sts$centers

plot(C_whole[1,],type="l")
lines(C_whole[2,],type="l",col="red")
lines(C_whole[3,],type="l",col="blue")

plot(C_sts[1,],type="l")
lines(C_sts[2,],type="l",col="red")
lines(C_sts[3,],type="l",col="blue")


#plotting cluster members
cs <- km_whole$cluster
c1_whole <- cbf
c2_whole <- cbf
c3_whole <- cbf
for (i in 1:length(cs)) {
  r <- cs[i]
  if (1 != r) {
    c1_whole <- c1_whole[-c(r),]
  }
  if (2 != r) {
    c2_whole <- c2_whole[-c(r),]
  }
  if (3 != r) {
    c3_whole <- c3_whole[-c(r),]
  }
}

plot(c1_whole[1,],type="l")
for (i in 2:dim(c1_whole)[1]) {
  lines(c1_whole[i,])
}
plot(c2_whole[1,],type="l")
for (i in 2:dim(c2_whole)[1]) {
  lines(c2_whole[i,])
}
plot(c3_whole[1,],type="l")
for (i in 2:dim(c3_whole)[1]) {
  lines(c3_whole[i,])
}

plot(colMeans(c1_whole),type="l")
lines(colMeans(c2_whole),type="l",col="red")
lines(colMeans(c3_whole),type="l",col="blue")

trueness <- matrix(0,nrow = 3,ncol = 3)
for (i in 1:30) {
  trueness[1,cs[i]] <- trueness[1,cs[i]]+1
}
for (i in 31:60) {
  trueness[2,cs[i]] <- trueness[2,cs[i]]+1
}
for (i in 61:90) {
  trueness[3,cs[i]] <- trueness[3,cs[i]]+1
}



#cs <- km_sts$cluster
#c1_sts <- cbf_sts
#c2_sts <- cbf_sts
#c3_sts <- cbf_sts
#for (i in 1:length(cs)) {
#  r <- cs[i]
#  if (1 != r) {
#    c1_sts <- c1_sts[-c(r),]
#  }
#  if (2 != r) {
#    c2_sts <- c2_sts[-c(r),]
#  }
#  if (3 != r) {
#    c3_sts <- c3_sts[-c(r),]
#  }
#}
#
#plot(c1_sts[1,],type="l")
#for (i in 2:dim(c1_sts)[1]) {
#  lines(c1_sts[i,])
#}
#plot(c2_sts[1,],type="l")
#for (i in 2:dim(c2_sts)[1]) {
#  lines(c2_sts[i,])
#}
#plot(c3_sts[1,],type="l")
#for (i in 2:dim(c3_sts)[1]) {
# lines(c3_sts[i,])
#}

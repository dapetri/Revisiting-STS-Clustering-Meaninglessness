to_sts_matrix <- function(ts,w) {
  n <- (length(ts)-w+1)
  sts <- matrix(0, nrow = n, ncol = w)
  for (i in 1:n) {
    sts[i,] = ts[i:(i+w-1)]
  }
  return(sts)
}

to_random_sampling_matrix <- function(ts,w) {
  n <- length(ts)-w+1
  data_matrix <- matrix(0, nrow = n, ncol = w)
  
  for (i in 1:n) {
    r <- sample(1:n,1)
    data_matrix[i,] = ts[r:(r+w-1)]
  }
  return(data_matrix)
}

create_concatenated_timeseries <- function(tss) {
  n <- dim(tss)[1]
  is <- dim(tss)[2]
  conc_ts <- matrix(0,nrow = 1,ncol = (n*is))
  j <- 1
  
  for (i in 1:n) {
    conc_ts[j:(j+is-1)] = tss[i,1:is]
    j <- (j+is-1)
  }
  return(conc_ts)
}
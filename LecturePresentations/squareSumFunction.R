# My external function code
# 02 February 2016
# NJG

# for vector operations, take a vector of values as an input
squareSumFunction <- function(x=runif(10)){
  z <- sum(x^2)
  z2 <- sum(x)^2
  mysum <- z2 - z
  return(mysum)
}

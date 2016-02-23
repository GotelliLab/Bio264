# Understanding For loops
# 11 February 2016
# NJG

# for (var in seq) { }

# var changes in the loop

for (i in 1:5) {
  cat("i =",i,"\n")
}

# better to set a variable as the endpoint

z <- 5
for (i in 1:z) {
  cat("i=",i," z=",z,"\n")
}

# be careful about the sequence endpoints

for (i in z) {
  cat("i=",i," z=",z,"\n")
}


# be careful about variables inside and outside of the loop and how they are initialized

z <- 5
v1 <- 10
v2 <- 0
for (i in 1:z) {
  v1 <- v1 + i^2
  v2 <- v2*i
  cat("i= ",i," z=",z," v1=",v1," v2=",v2,"\n")
}


# always make the loop variable an integer sequence

# permissible, but very confusing

z <- c(1.1, 4.4, 5.5)
for (i in z) {
  result <- i^2
  cat("i = ",i, "result = ",result," z = ",z,"\n")
}


myvec <- c(1.1, 4.4, 5.5)

for (i in 1:length(myvec)) {
  result <- myvec[i]^2
  cat("i = ",i," result = ",result," length(myvec) = ",length(myvec),"\n")
}
  
# still easy to operate on character strings

mycolors <- c("orchid","steelblue","coral")

for (i in 1:length(mycolors)) {
  plot(runif(10*i),type="b",col=mycolors[i])
}

# A random walk model of population growth!
# Referencing different elements in the vector

# Define 2 global variables
N0 <- 50 #  initial population size
time <- 100 # length of time series

PopSize <- vector(mode="numeric",length=time)
head(PopSize)
PopSize[1] <- N0

for (i in 2:length(PopSize)) {
  PopSize[i] <- PopSize[i - 1] + rnorm(n=1, mean= 0.0, sd=0.1)
}

plot(x=1:length(PopSize),y=PopSize,type="l",xlab="Time",ylab="PopSize",col="darkgreen",lwd=2)

# Bundle In A Function
RandomWalk <- function(N0=50,time=100,mean=0,sd=1){
PopSize <- vector(mode="numeric",length=time)
PopSize[1] <- N0

for (i in 2:length(PopSize)) {
  PopSize[i] <- PopSize[i - 1] + rnorm(n=1, mean= mean, sd=sd)
}

plot(x=1:length(PopSize),y=PopSize,type="l",xlab="Time",ylab="PopSize",col="darkgreen",lwd=2)
}

RandomWalk()

# Use the break function to stop a loop before the end

RandomWalk2 <- function(N0=50,time=100,mean=0,sd=1){
PopSize <- vector(mode="numeric",length=time)
PopSize[1] <- N0

for (i in 2:length(PopSize)) {
  PopSize[i] <- PopSize[i - 1] + rnorm(n=1, mean= mean, sd=sd)
  if (PopSize[i] <= 0) {
    PopSize[i] <- 0
    break
  }
}

plot(x=1:length(PopSize),y=PopSize,type="l",xlab="Time",ylab="PopSize",col="darkgreen",lwd=2)
}
RandomWalk2(N0=10,time=100)

# using a double for loop to traverse a matrix

m <- matrix(1:12,nrow=4,byrow=TRUE)

for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    z <- runif(1)
    m[i,j] <- m[i,j] + z
  }
}
print(m)

# move the random number outside the inner loop

m <- matrix(1:12,nrow=4,byrow=TRUE)

for (i in 1:nrow(m)) {
    z <- runif(1)
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + z
  }
}
print(m)

# move the random number outside entire loop

m <- matrix(1:12,nrow=4,byrow=TRUE)
    z <- runif(1)

for (i in 1:nrow(m)) {
  for (j in 1:ncol(m)) {
    m[i,j] <- m[i,j] + z
  }
}
print(m)

# Q: How to fill by columns?
# A: reverse row and column loops
m <- matrix(1:12,nrow=4,byrow=TRUE)

for (i in 1:ncol(m)) {
    z <- runif(1)
  for (j in 1:nrow(m)) {
    m[j,i] <- m[j,i] + z
  }
}
print(m)


# Acting on matrices without for loops

# Add a different random number to each element
m <- matrix(1:12,nrow=4,byrow=TRUE)
m <- m + runif(n=length(m))
print(m)

# Add the same random number to all elements
m <- matrix(1:12,nrow=4,byrow=TRUE)
m <- m + runif(n=1)
print(m)

# Combine for loops and vectorized operations
# Add the same number to each row
m <- matrix(1:12,nrow=4,byrow=TRUE)
for (i in 1:nrow(m)) {
  m[i,] <- m[i,] + runif(1)
}
print(m)

# Add the same number to each column
m <- matrix(1:12,nrow=4,byrow=TRUE)
for (j in 1:ncol(m)) {
  m[,j] <- m[,j] + runif(1)
}
print(m)


# Modeling differential growth equations
# February 22, 2016
# NJG

# basic equation for change plus current value
# illustrated with familiar exponential growth

rm(list=ls())
set.seed(100)
opar <- par(no.readonly=TRUE)

# basic growth model
#--------------------------------------------------
Model1 <- function(N_0=250,Time=100,r=0.08){
  Nvec <- rep(0,Time)
  Nvec[1] <- N_0
  for (i in 2:Time) {
    Nvec[i] <- Nvec[i-1] + r*Nvec[i-1]
  }
  return(Nvec)
  
}
Nvec <- Model1()
plot(x=1:length(Nvec),y=Nvec)
#--------------------------------------------------

# sensitivity to time-step

r <- 0.08
BigStep <- seq(1,50,by=1)
SmallStep <-seq(1,50,by=0.1)
BigVec <- rep(0,length(BigStep))
SmallVec <- rep(0,length(SmallStep))
BigVec[1] <- 250
SmallVec[1] <- 250
for (i in 2:length(BigVec)) BigVec[i] <- BigVec[i-1] + r*BigVec[i-1]
for (i in 2:length(SmallVec)) SmallVec[i] <- SmallVec[i-1] + r*SmallVec[i-1]*0.1 
tail(BigVec)
tail(SmallVec)
250*exp(50*0.08)
#--------------------------------------------------

# Calculating N, dNdt, (1/N)(dNdt)
#--------------------------------------------------
Model2 <- function(N_0=250,Time=100,r=0.08){
  Nvec <- rep(0,Time)
  Nvec[1] <- N_0
  for (i in 2:Time) {
    Nvec[i] <- Nvec[i-1] + r*Nvec[i-1]
  }
    dNvec <- diff(Nvec)
    dNvec <- c(dNvec,dNvec[length(dNvec)])
    perCapvec <- dNvec/Nvec           
m <- cbind(1:Time,Nvec,dNvec,perCapvec)
colnames(m) <- c("Time","N","dNdt","perCapdNdt")
return(m)
}

m <- Model2()          # save output matrix
m <- as.data.frame(m)  # convert to data frame
par(mfrow=c(2,2))
plot(x=m$Time,y=m$N)
plot(x=m$N,y=m$dNdt)
plot(x=m$N,y=m$perCapdNdt)
plot(x=m$N,y=rep(r,nrow(m)))
par(opar)
# par(mfrow=c(2,2))

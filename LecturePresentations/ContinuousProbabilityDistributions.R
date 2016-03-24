# Continuous probability distributions
# 24 March 2016
# NJG
#-------------------------------------------------
# uniform
# params specific minimum and maximum

# dunif for density plot
limits <- seq(0,10,by=0.01)
z <-dunif(x=limits,min=0,max=5)
names(z) <- limits
plot(x=limits, y=z,type="l",xlim=c(0,10))

#punif for cumulative density (= tail probabilities)
limits <- seq(0,10,by=0.01)
z <-punif(q=limits,min=0,max=5)
names(z) <- limits
plot(x=limits, y=z,type="l",xlim=c(0,10))

#qunif for quantiles
qunif(p=c(0.025,0.975),min=0,max=5)

#runif for random data
hist(runif(n=100,min=0,max=5))

#-------------------------------------------------
# normal 

hist(rnorm(n=100,mean=100,sd=2))

# problems with uniform when mean is small but zero is not allowed.
hist(rnorm(n=100,mean=2,sd=2))



#-------------------------------------------------
# gamma distribution, continuous positive values, but bounded at 0

hist(rgamma(n=100,shape=1,scale=1))

# shape <=1 gives a mode near zero; very small shape rounds to zero
hist(rgamma(n=100,shape=0.1,scale=1))

# large shape parameters moves towards a normal
hist(rgamma(n=100,shape=2,scale=1))

# scale parameter changes mean- and the variance!

hist(rgamma(n=100,shape=2,scale=10))
hist(rgamma(n=100,shape=2,scale=100))
hist(rgamma(n=100,shape=2,scale=1))
hist(rgamma(n=100,shape=2,scale=0.1))

# unlike the normal, the two parameters affect both mean and variance

# mean = shape*scale
# variance= shape*scale^2

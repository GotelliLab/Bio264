# Discrete Probability distributions and generating functions
# 18 March 2016
# NJG

#-------------------------------------------------
# Poisson distribution
# Discrete X >= 0
# Random events with a constant rate lambda
# (observations per time or per unit area)
# Parameter lambda > 0

# "d" function generates probability density

MyVec <- dpois(x=seq(0,10),lambda=1)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

MyVec <- dpois(x=seq(0,10),lambda=2)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

MyVec <- dpois(x=seq(0,15),lambda=6)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

MyVec <- dpois(x=seq(0,15),lambda=0.2)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)


sum(MyVec)  # sum of density function = 1.0 (total area under curve)

# for a Poisson distribution with lambda=2, 
# what is the probability that a single draw will yield X=0?

dpois(x=0,lambda=2)

# "p" function generates cumulative probability density; gives the 
# "lower tail" cumulative area of the distribution

MyVec <- ppois(q=seq(0,10),lambda=1)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

# for a Poisson distribution with lambda=2, 
# what is the probability that a single random draw will yield X <= 1?

ppois(q=1, lambda=2)

# to generate the "upper tail", use lower.tail=FALSE
# important: lower tail P(X <= z) but upper tail P(X > z)

# Therefore for any z, P(lower.tail z) + P(upper.tail z) = 1.0
z <- 3
ppois(q=z,lambda=1) + ppois(q=z,lambda=1,lower.tail=FALSE)

MyVec <- ppois(q=seq(0,10),lambda=1,lower.tail=FALSE)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

# for a Poisson distribution with lambda=2,
# what is the probability that a single random draw will yield X >= 4?

ppois(q=3,lambda=2,lower.tail=FALSE)


# Because the total area under the curve is 1.0, 
# we can subtract the two tail probabilities from 1.0 
# to obtain the probability of a value being in a certain interval.

# for a Poisson distribution with lambda = 4, 
# what is the probability that a single random draw 
# will yield a value X that is between 1 and 3?

lowerTail <- ppois(q=0,lambda=4)
upperTail <- ppois(q=3,lambda=4, lower.tail=FALSE)

IntervalP <- 1.0 - lowerTail - upperTail
print(IntervalP)

# Lets check this by calculating and summing 
# the probabilities for the individual integer values

x1 <- dpois(x=1,lambda=4)
x2 <- dpois(x=2,lambda=4)
x3 <- dpois(x=3,lambda=4)

sum(x1,x2,x3)

# the "q" quantile function is the "inverse" of the "p" function. 
# We give a tail probability and it gives us a 
# value X that would correspond to that.

# the quantile is right continuous
# qpois(p, lambda) is the smallest integer such that P(X <= z) >= p.

qpois(p=0.75,lambda=3)


# The q function can be used to generate a 95% interval on the distribution:

qpois(p=c(0.025,0.975),lambda=10)
qpois(p=0.975,lambda=10,lower.tail=TRUE)

# We can also find the midpoint of probability in the distribution:

qpois(p=0.5,lambda=3)
qpois(p=0.5,lambda=0.1)

# Use rpois to generate a random set of values from a distribution:

z <- rpois(n=10000,lambda=1)
barplot(height=table(z))

z <- rpois(n=10,lambda=1)
barplot(height=table(z))

# Make comparisons of sample values with predicted values
z <- rpois(n=10000,lambda=1) # very large sample
table(z)                     # get frequencies
mean(z==5)                   # get proportion of values = 5
dpois(x=5,lambda=1)          # get theoretical proportion
#-------------------------------------------------
# Binomial distribution
# p = probability of a dichotomous outcome
# size = number of trials
# x = possible outcomes

# use "d" binom for density function
MyVec <- dbinom(x=seq(0,10),size=10,prob=0.5)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

MyVec <- dbinom(x=seq(0,10),size=10,prob=0.95)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

# use "p" binom for cumulative distribution

# what is probability of getting 5 heads out of 10 tosses?
dbinom(x=5,size=10,prob=0.5)

# what is the probability of getting 5 
# or fewer heads out of 10 tosses?
pbinom(q=5,size=10,prob=0.5)
pbinom(q=4,size=9,prob=0.5)


# use "q" binom for quantiles

# what minimum number of heads will be found 
# for 40% of 50 trials with p = 0.5?

qbinom(p=0.4,size=50,prob=0.5)

# what is a 95% confidence interval for 100 trials 
# of a coin with p = 0.7 for heads?
qbinom(p=c(0.025,0.975),size=100,prob=0.7)
#-------------------------------------------------
# negative binomial: number of failures (values of MyVec)
# in a series of (Bernouli) with p=probability of success 
# before a target number of successes (= size)
# generates a discrete distribution that is more 
# heterogeneous ("overdispersed") than Poisson
MyVec <- dnbinom(x=seq(0,40), size=5, prob=0.5)
names(MyVec) <- seq(0,40)
barplot(height=MyVec)

# geometric series is a special case where N= 1 success
# each bar is a constant fraction 1 - "prob" of the bar before it
MyVec <- dnbinom(x=seq(0,40), size=1, prob=0.1)
names(MyVec) <- seq(0,40)
barplot(height=MyVec)


# alternatively specify mean = mu of distribution and size, 
# the dispersion parameter (small is more dispersed)

MyVec <- dnbinom(x=seq(0,40),size=1,mu=5)
names(MyVec) <- seq(0,40)
barplot(height=MyVec)


# also have the "pnbinom", "qnbinom" and "rnbinom" functions
# Probability of drawing a 3 or smaller from a negative binomial:
pnbinom(q=3,size=1,mu=5)

# 5 percent lower value for a negative binomial
qnbinom(p=0.05,size=10,mu=5)

# 95% confidence interval for a geometric series
qnbinom(p=c(0.025,0.975),prob=0.5,size=10)

# random sample from a negative binomial

MyVec <- rnbinom(n=1000,size=1,mu=20)
quantile(MyVec,prob=c(0.025,0.975))

# compare to exact calculation
qnbinom(p=c(0.025,0.975),size=1,mu=20)
#-------------------------------------------------
# Sampling from a vector of elements (not necessarily numbers)

Species <- LETTERS
print(Species)

# Sampling with or without replacement
# Sampling equiprobably or with specified (unequal) probabilities)

# Case 1: Sampling equiprobably with replacement

sample(Species,size=10,replace=TRUE)

# Case 2: Sampling equiprobably without replacement

sample(Species,size=10,replace=FALSE)


# Case 3: Sampling with specified probabilities with replacement

# any set of non-negative numbers 
# that is the same length as the vector)
MyProbs <- seq(1,26) 

sample(Species, size=10,replace=TRUE,prob=MyProbs)

# Case 4: Sampling with specified probabilities, without replacement

sample(Species, size=10,replace=FALSE,prob=MyProbs)

#-------------------------------------------------
# Creating a mixture model with two processes

# pterr = probability of obtaining a territory
# clutch = probability distribution for clutch size
# given that a bird has obtained a territory

# 0-inflated Poisson (a mixture model)
pterr=0.80

z <- runif(1000)
clutch <- rpois(1000,lambda=5)
MyVec <- ifelse(z<pterr,clutch,0)
barplot(height=table(MyVec))

# standard Poisson
clutch <- rpois(1000,lambda=2)
barplot(height=table(clutch))

# 0-truncated Poisson
clutch <- rpois(1000,lambda=2)
clutch <- clutch[clutch>0]
barplot(height=table(clutch))


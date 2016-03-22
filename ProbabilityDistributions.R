# Probability distributions and generating functions
# 18 March 2016
# NJG

# Poisson distribution
# Discrete X >= 0
# Random events with a constant rate lambda
# Parameter lambda > 0

# "d" function generates probability density

MyVec <- dpois(x=seq(0,10),lambda=1)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)
sum(MyVec)  # sum of density function = 1.0 (total area under curve)

# for a Poisson distribution with lambda=2, what is the probability that a single draw will yield X=0?

dpois(x=0,lambda=2)

# "p" function generates cumulative probability density; gives the "lower tail" cumulative area of the distribution

MyVec <- ppois(q=seq(0,10),lambda=1)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

# for a Poisson distribution with lambda=2, what is the probability that a single random draw will yield X <= 1?

ppois(q=1, lambda=2)

# to generate the "upper tail", use lower.tail=FALSE
# important: lower tail P(X <= z) but upper tail P(X > z)

# Therefore for any z, P(lower.tail z) + P(upper.tail z) = 1.0
z <- 3
ppois(q=3,lambda=1) + ppois(q=3,lambda=1,lower.tail=FALSE)

MyVec <- ppois(q=seq(0,10),lambda=1,lower.tail=FALSE)
names(MyVec) <- seq(0,10)
barplot(height=MyVec)

# for a Poisson distribution with lambda=2 what is the probability that a single random draw will yield X >= 4?

ppois(q=3,lambda=2,lower.tail=FALSE)


# Because the total area under the curve is 1.0, we can subtract the two tail probabilities from 1.0 to obtain the probability of a value being in a certain interval.

# for a Poisson distribution with lambda = 4, what is the probability that a single random draw will yield a value X that is between 1 and 3?

lowerTail <- ppois(q=0,lambda=4)
upperTail <- ppois(q=3,lambda=4, lower.tail=FALSE)

IntervalP <- 1.0 - lowerTail - upperTail
print(IntervalP)

# Lets check this by calculating and summing the probabilities for the individual integer values

x1 <- dpois(x=1,lambda=4)
x2 <- dpois(x=2,lambda=4)
x3 <- dpois(x=3,lambda=4)

sum(x1,x2,x3)

# the "q" quantile function is the "inverse" of the "p" function. We give a tail probability and it gives us a value X that would correspond to that.

# the quantile is right continuous; qpois(p, lambda) is the smallest integer such that P(X <= z) >= p.

qpois(p=0.75,lambda=3)


# The q function can be used to generate a 95% interval on the distribution:

qpois(p=c(0.025,0.975),lambda=10)
qpois(p=0.975,lambda=10,lower.tail=TRUE)

# We can also find the midpoint of probability in the distribution:

qpois(p=0.5,lambda=3)
qpois(p=0.5,lambda=0.1)

# Use rpois to generate a random set of values from a distribution:

z <- rpois(n=10000,lambda=1)
hist(z)

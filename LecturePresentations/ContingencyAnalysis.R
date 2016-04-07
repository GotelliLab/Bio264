# Analysis of simple contingency tables
# 5 April 2016
# NJG

# Create a simple data table
vec1 <- c(50,66,22)
vec2 <- c(120,22,30)
data <- rbind(vec1,vec2)
rownames(data) <- c("Cold","Warm")
colnames(data) <- c("Aphaenogaster", "Camponotus", "Crematogaster")
print(data)

### Analyze and graph
print(chisq.test(data))
mosaicplot(data,col=c("goldenrod","grey","black"),shade=FALSE)
barplot(data, beside=TRUE,col=c("cornflowerblue","coral"))

# Sometimes the data table will have 1 row for each observation, with different columns for the factors. 
vec1 <-rep(c("Aphaenogaster","Camponotus","Crematogaster"),times=c(10,5,20))
print(vec1)
vec2 <- rep(c("Cold","Warm"),times=15)
data <- as.data.frame(cbind(vec1,vec2))
print(data)
print(chisq.test(x=data$vec1,y=data$vec2))


# Estimate the standard deviation and error of sample proportion data

# standard deviation of proportion = sqrt(p*(1-p)/n)
Success <- 22
Failure <- 1

n <- Success + Failure
prob <- Success/n
sd_prob <- sqrt(prob*(1-prob)/n)

# but what does a confidence interval look like?
# if we use the normal, we get
qnorm(p=c(0.025,0.975,0.50),mean=prob,sd=sd_prob)

# better to use a binomial distribution
qbinom(p=c(0.025,0.975,0.50),size=33,prob=prob)

# or a beta for the distribution of probabilities
qbeta(p=c(0.025,0.975,0.50),shape1=22,shape2=1)


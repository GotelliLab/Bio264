# ANOVA data simulator
# 31 March 2016
# NJG

# Data from Rizzari et al. Oikos 123:829-836
# Figure 2b for 6 treatments

# treatment labels
treatLab <- LETTERS[1:6]

# treatment means estimated from figure 2
treatMeans <- c(61,60,23,5,6,4)

# treatment sd estimated from figure 2
# se = sd/sqrt(n)
# sd = se*sqrt(n)
# n = 10
# for first 3 groups se =10, so sd = 31
# for second 3 groups se = 2, so sd = 6

treatSD <- c(31,31,31,6,6,6)
n <- 10 # sample size per treatment

# create vector of treatment labels
Treatments <- rep(treatLab,each=10)
Treatments <- factor(Treatments)

# simulate data set with parameters from paper
AlgalMass <- rnorm(n=60,mean=rep(treatMeans,each=10),sd=rep(treatSD,each=10))

summary(AlgalMass)

#fudging the zeroes
AlgalMass[AlgalMass<0] <- 0

# fudging the upper end
AlgalMass[AlgalMass>100] <- 100
summary(AlgalMass)

# show data as a boxplot
SimData <- data.frame(Treatments,AlgalMass)
boxplot(AlgalMass)
boxplot(AlgalMass~Treatments,data=SimData)

# get group summaries; from Cookbook for R
library(plyr)
summaryData <- ddply(SimData,"Treatments", summarise,
                     N = length(AlgalMass),
                     mean = mean(AlgalMass),
                     median = median(AlgalMass),
                     sd = sd(AlgalMass),
                     se = sd /sqrt(N))
summaryData

# analyze data as an ANOVA
MyModel <- aov(AlgalMass~Treatments,data=SimData)
z <- summary(MyModel)

#---------------------------------------------------------------
# creating a function and repeating the work

treatLab <- LETTERS[1:6]
treatMeans <- c(61,60,23,5,6,4)
treatSD <- c(31,31,31,6,6,6)
sampleSize <- 10 # sample size per treatment

ANOVASimulator <- function(ss=sampleSize,l=treatLab,m=treatMeans,sd=treatSD){
  
# create random data set  
RandomData <- rnorm(n=ss*length(l),mean=rep(m,each=ss),sd=rep(sd,each=ss))

# set up treatments as a factor
Treatments <- rep(l,each=ss)
Treatments <- factor(Treatments) 

# combine elements in a data frame
SimData <- data.frame(Treatments, RandomData)

# run analysis of variance
MyModel <- aov(RandomData~Treatments,data=SimData)

# extract p value of test; answer from Stack Overflow!
output <- summary(MyModel)[[1]][["Pr(>F)"]][[1]]

# return the p value as the single output
return(output)

}
#-----------------------------------------------------------
ANOVASimulator()

# run the function multiple times to create a vector of p values

PVec <- replicate(100,ANOVASimulator())

# calculation proportion of tests that reject with p < 0.05
mean(PVec<0.05)

# visualize with a histogram of p values
hist(PVec,breaks=seq(0,1.0,by=0.05),col=c("tomato",rep("goldenrod",19)))

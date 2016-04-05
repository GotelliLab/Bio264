# Analyzing regression data
# 5 April 2016
# NJG


# eyeball data directly from a published scatter plot.
# each observation is a paired x,y data point
obs1 <- c(1,10)
obs2 <- c(9,3)
obs3 <- c(6,5)
obs4 <- c(1,9)
obs5 <- c(8,3)

MyData <- data.frame(rbind(obs1,obs2,obs3,obs4,obs5))
colnames(MyData) <- c("var1","var2")
plot(x=MyData$var1, y=MyData$var2)
MyModel <- lm(MyData$var2~MyData$var1)
z <- summary(MyModel)
abline(summary(MyModel))

# extract parameters from model object
print(z)
names(z)
z$coefficients[c(1,2)]

# set up model parameters
intercept <- 10.31 # fitted regression intercept
slope <- -0.86     # fitted regression slope
sampleSize <- 20            # simulated sample size
xRange <- c(0,10)  # permissable range of x-values
residSD <- 1       # standard deviation of residuals

RegSim <- function(a=intercept,b=slope,n=sampleSize,xl=xRange,sd=residSD,scatterplot=FALSE){
  
  # simulate x values from random uniform over range
  xSim <- runif(n=sampleSize,min=xRange[1],max=xRange[2])
  
  # simulate y values from regression plus sd for normal noise
  ySim <- a + b*xSim + rnorm(n=n,mean=0,sd=sd)
  
# create data frame of simulated data  
SimData <- data.frame(cbind(xSim,ySim))
colnames(SimData) <- c("x","y")

# create and save summary of linear regression model
SimModel <- summary(lm(SimData$y~SimData$x))

# optionally, create regression plot
if(scatterplot==TRUE){
  
  plot(x=SimData$x,y=SimData$y,xlab= "Simulated X", ylab= "Simulated Y",type="n")
  grid()
  abline(SimModel,lwd=2)
  points(x=SimData$x,y=SimData$y,cex=2,pch=21,bg="wheat")
}

# create output as a list with data and model
output <- list(SimModel,SimData)

return(output)
  
}

RegSim(sd=1,scatterplot=TRUE)

# tweak the noise in the model to get r2 = 0.44

replicates <- 1000
SimR2 <- rep(0,replicates)

for (i in 1:replicates) {
  SimR2[i] <- RegSim(sd=1,scatterplot=FALSE)[[1]]$r.squared
}

hist(SimR2)
mean(SimR2)
quantile(SimR2,probs=c(0.025,0.975))

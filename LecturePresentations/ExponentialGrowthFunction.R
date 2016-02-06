# Plotting function for exponential growth
# NJG
# 12 January 2016

# FUNCTION ExpoPlotter
# Takes input of N0, t, and r and creates a plot of N vs t
# N0 = initial population size
# r = intrinsic rate of increase
# t = number of time steps (note use of a vector as input)
# N = calculated population size at time t (also a vector output)

#----------------------------------------------------------------------
ExpoGrowth <- function(N0=1000,r= 0.02, t=1:5){
 N <- N0*exp(r*t) # Exponential growth equation
 N <- c(N0,N)     # prepend initial population size to start of vector
 t <- c(0,t)      # prepend time = 0 to start of time vector
 
# create simple plot of the series 
plot(x=t,y=N,xlab="Time",ylab="Population Size",type="b")

# return the vector of calculated population sizes
return(N)
}
#----------------------------------------------------------------------

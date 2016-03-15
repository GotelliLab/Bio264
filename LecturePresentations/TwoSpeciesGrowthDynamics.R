# Generating growth trajectories for two-species Lotka-Volterra Models
# Parameter list:

# Time = length of time series
# N_a = vector of population sizes of species A
# N_b = vector of population sizes of species B
# Ka = carrying capacity of species A
# Kb = carrying capacity of species B
# ra = growth rate of species A (constant)
# rb = growth rate of species B (constant)
# N_a0 = initial population size of species A
# N_b0 = initial population size of species B
# alpha = effect of species B on growth of species A
# beta = effect of species A on growth of species B

LV_Comp <- function (Time=1000,
                     ra=0.1,
                     rb=0.1,
                     N_a0=100,
                     N_b0=100,
                     Ka=400,
                     Kb=200,
                     alpha=0.3,
                     beta=0.6,
                     ret=TRUE){
N_a <- rep(0,Time) # create vector for N_a
N_b <- rep(0,Time) # create vector for N_b
N_a[1] <- N_a0 # initialize N_a
N_b[1] <- N_b0 # initialize N_b

for (j in 2:Time){
  dNadt <- ra*N_a[j - 1]*((Ka - N_a[j - 1] - alpha*N_b[j - 1])/Ka)
  dNbdt <- rb*N_b[j - 1]*((Kb - N_b[j - 1] - beta*N_a[j - 1])/Kb)
  N_a[j] <- N_a[j - 1] + dNadt
  N_b[j] <- N_b[j - 1] + dNbdt
}

m <- cbind(seq(1,Time),N_a,N_b)
matplot(x=m[,1],y=m[,c(2,3)],
                    type="l",
                    lty=1,
                    xlab="Time",
                    ylab="N",
                    ylim=c(0,max(m[,-1])))

  
if(ret==TRUE) return(m)


}
LV_Comp(ret=FALSE)

# Generating state space graph for two-species Lotka-Volterra competition Models
# Parameter list:

# Ka = carrying capacity of species A
# Kb = carrying capacity of species B
# ra = growth rate of species A (constant)
# rb = growth rate of species B (constant)
# alpha = effect of species B on growth of species A
# beta = effect of species A on growth of species B
# PopLim = vector of state space sizes
LV_Comp_SS <- function (ra=0.1,
                        rb=0.1,
                        Ka=400,
                        Kb=200,
                     alpha=0.3,
                     beta=0.6,
                     PopLimA=seq(0,100,length=10),
                     PopLimB=seq(0,100,length=10),
                     ret=TRUE){
dNadt = rep(0,length(PopLimA)^2)
dNbdt = rep(0,length(PopLimB)^2)
z <- 1
for (i in PopLimA) {
  for (j in PopLimB) {
    
  dNadt[z] <- ra*i*((Ka - i - alpha*j)/Ka)
  dNbdt[z] <- rb*j*((Kb - j - beta*i)/Kb)
  z <- z + 1
  }
}
x <- rep(PopLimA,each=length(PopLimA))
y <-rep(PopLimB,length(PopLimB))
m <- cbind(x,y,dNadt,dNbdt)
if(ret==TRUE) return(m)

}

m <- LV_Comp_SS()

# create plot of joint growth vectors

StateSpacePlotter <- function(m,Mag=1,ret=TRUE) {
  
  plot(x=m[,1],
       y=m[,2],
       xlab="Species A",
       ylab="Species B",
       type="n")
  
  arrows(x0=m[,1],
         y0=m[,2],
         x1=m[,1]+m[,3]*Mag,
         y1=m[,2]+m[,4]*Mag,
         length=0.1)
}
m <- LV_Comp_SS(PopLimA=seq(0,500,length=20),PopLimB=seq(0,500,length=20),
                beta=2)
StateSpacePlotter(m=m,Mag=0.2)



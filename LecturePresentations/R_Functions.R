# Writing and using your own R functions
# 2 February 2016
# NJG

# --------------------------------------------
# Simple function for adding two numbers together
MyAdder <-function(x,y){         # inputs and initial bracket
  z <- x + y                     # unlimited lines of function code
  return(z)                      # return any data structure from the function
}                                # must include closing bracket to end function!

# --------------------------------------------
# Everything in R is a function
MyAdder(2,3)  # function
2 + 3         # assignment operator
'+'(2,3)      # "infix" function



# --------------------------------------------
#
#
MyAdder(2,3)                     # call function with arguments
MyAdder(x=2,y=3)                 # better to call with argument names
# MyAdder()                        # function name with no arguments provided- what happens?
MyAdder                          # function name just prints the code!

#-----------------------------------------------
# rm(list=ls())                    # clear memory
MyAdder(x=2,y=3)                 # function no longer available!

#-----------------------------------------------
# Improving functions by adding initial values

MyAdder2 <- function(x=2,y=3) {     # set up the function with initial values
 z <- x + y
 return(z)
}
MyAdder2()
#-----------------------------------------------
# Improve and test functions by adding random initial values
MyAdder3 <- function(x=sample(1:1000,1),y=runif(1)) {     # set up the function with initial values
 z <- x + y
 return(z)
}
MyAdder3()
#-----------------------------------------------
# Multiple return statements are possible
MyAdder4 <- function(x=sample(1:1000,1),y=runif(1)) {     # set up the function with initial values
  if(is.numeric(c(x,y))==FALSE)return("Hey! Please feed me numeric input!")
 z <- x + y
 return(z)
}
MyAdder4(x=2,y="junk")
#-----------------------------------------------
# understanding scope of variables in a functino

MyScopeFunction <- function(x=1){
  z <- x + 1
  return(z)
}
MyScopeFunction()
x
z
x <- 10
MyScopeFunction(x)
x
x <- MyScopeFunction()
x
x <- 10
MyScopeFunction(x=100)
x
x <- MyScopeFunction(x=x)
x
rm(x)
x
MyScopeFunction(x=10)
x
z
# Unused variables and functions with no return value

MyPlotterFunction <- function(x=3,y=2){
  plot(runif(50),type="l",col="red")
} 
MyPlotterFunction()
z <- MyPlotterFunction(x=10,y=30)
z

# Creating and sourcing functions in different files
# Write the needed function in a separate file
# compile and run
source("squareSumFunction.R") #can't find it!
getwd()
squareSumFunction()

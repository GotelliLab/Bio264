# Basic data structures in R
# 26 January 2016
# NJG
#--------------------------------------------
# Preliminaries
ls() # to see what's in memory
rm(list=ls()) # to clear everything in memory
ls()
# generating repeatable results with random numbers
runif(1)
set.seed(100)
runif(1)
runif(1)
set.seed(100)
runif(1)
# using the assignment operator <- 
x <- runif(10)
# --------------------------------------------
# getting output to the screen
x          # print by giving a variable name
print(x)   # use a print statement

cat("Contents of x: ", x, "\n", "(moved to the next line...)") # use the cat function for formatting

(z <- runif(2))  # surround in parens for assign & print
# --------------------------------------------
# Basic operators
4 + 2
4 - 2
4 * 2
9 / 5
9 %/% 5      # integer division
9 %% 5       # remainder (modulus)
#--------------------------------------------
# Creating atomic vectors
# surround with parentheses to print
(z <- c(2,3,3.1)) # vector of numeric
(z <- c("cat", "dog", "mouse")) # character vector
(z <- c(TRUE, FALSE)) # vector of logicals
#--------------------------------------------
# getting information on objects
str(z)
summary(z)
mode(z)
class(z)
length(z)
dim(z)

#--------------------------------------------
# Creating empty vectors

(z <- vector(mode="numeric",length=10))
(z <- vector(mode="logical",length=10))
(z <- vector(mode="character",length=10))

#--------------------------------------------
# Combining vectors and coercion

# Characters and numerics coerce to characters
a <- c(1,2)
b <- c("three","four")
(d <- c(a,b))
str(d)

#--------------------------------------------
# Logicals and numerics coerce to numerics
e <- c(TRUE, TRUE)
f <- c(10,12,13)
(g <- c(e,f))
str(g)

c(d,g)
str(c(d,g))

#-------------------------------------------
#Vectorization
x <- 3
x^2
x <- 1:10
x^2

# Recycling
x <- 1:10
y <- runif(1)
z <- x + y
print(z)

y <- runif(10)
z <- x + y
print(z)

# unequal vector lengths?

x <- 1:9
z <- x + y
print(z)

#-----------------------
# Vector subsetting

x <- runif(5)
x
x[2]
x[c(2,3)]
x[c(2,2)]
x[-3]
x[-c(1,3)]
x[-(1:3)]
# x[-(-1:3)]

# Boolean operators
x
x < 0.5
x[x <0.5]
which(x < 0.5)
which (x > 0.5 & x < 0.6)
z <- which (x > 0.5 & x < 0.6)
x[z]
x[x < 0.358 & x > 0.6]
x[x < 0.358 | x > 0.6]
x < 0.358 | x > 0.6
x <- c(2,2,4,3,6)
x[x==3]
x[x!=3]
x[x!=5]
#-----------------------------------
# naming vector elements

x <- c(10,12,2.2)
x[2]
names(x) <- c("snake","bird","fireAnt") # names function to add names
x["fireAnt"]
x[x != "fireAnt"]  # not what we want!
x[names(x)!="fireAnt"] # subscript the name, not the element

x <- NULL # strip out existing names
x
x <- c("snake"=10, "bird"=12,"fireAnt"=2.2) # add names at vector creation
x
names(x)[3] <- "harvesterAnt"
x
#-----------------------------------
# lists

x <- list(runif(3),"badger",c(TRUE,FALSE),seq(11,14))
x
# single parens to get list component (the "boxcar" in the train)
# double parens to get the contents of the component (what's in the boxcar)
x[1]
x[[1]]
x[[1]][2]
x[[2]]

# adding names to lists

names(x) <- c("ranNums","animal","decisions","intSeq")
x
# dollar sign + name can be used to get list items as vectors
x$decisions
x$intSeq[2]

z <- unlist(x) #coerces back to atomic vector, but retains names
z
str(z)
z["ranNums2"]

#-----------------------------------
# matrix - an atomic vector with two dimensions

m <- matrix(seq(1,6),nrow=3)
m
m <- matrix(seq(1,6),nrow=2)
m
m <- matrix(seq(1,6),nrow=4)
m
m <- matrix(seq(1,6),nrow=7)
m <- matrix(seq(1,6),nrow=3,byrow=TRUE)
m
# give names through dimnames
dimnames(m) <- list(c("pitcherPlant","peatMoss","blueberry"),c("bog","fen"))
m

# use rownames and colnames
rownames(m) <- NULL
colnames(m) <- c("field","stream")
m


# use empty placeholder to subset whole rows or columns

bigz <- matrix(sort(runif(25)),nrow=5,byrow=TRUE)
bigz
bigz[5,5]
bigz[1,5]
bigz[c(1,2),c(1,2)]
bigz[1,]
bigz[,1]
str(bigz[,1])
bigz[,]
max(bigz)
which(bigz==max(bigz)) # still thinks of bigz as a vector for subscripting

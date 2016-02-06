# Function for partitioning class groups 
# Use sample(classNames,1) to randomly choose individual students
# Nick Gotelli
# January 2nd, 2015

# Read in UVM class roster and extract list of student names
classList <- read.csv(file="roster.csv",stringsAsFactors = FALSE)
classNames <- classList$NAME

# FUNCTION RandomGroups() to randomly assign students to groups
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
RandomGroups <- function(z=classNames,groups=7){
  
  # use the gl function with integer division for equal numbers
  GroupAssigns <- gl(n=groups,k=length(z)%/%groups)
  
  # use modulo function to divide remaining individuals evenly among groups
  if (length(z)%%groups!=0) GroupAssigns <-c(GroupAssigns,(1:(length(z)%%groups)))
  
  # create data frame and shuffle group labels
  GroupDataFrame <- cbind(classNames,group=sample(GroupAssigns))
  return(GroupDataFrame)
}
#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

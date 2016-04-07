# logistic regression
# use when the response variable is discrete (0,1)
# predictor variable is continuous

# create ordered x values
xdat<- sort(runif(20,min=0,max=100))

# create y response data yes/no
ydat<- c(0,0,0,0,0,1,1,0,1,1,1,0,1,1,1,0,1,1,1,1)

# bind in a data frame
MyData <-data.frame(cbind(xdat,ydat))


# inspect data
head(MyData)

# fit logistic regression model
MyModel<-glm(ydat~xdat, family = binomial("logit"), data=MyData)
summary(MyModel)

# create empty plot with grid
plot (x=xdat,y=ydat,xlab="Plant Height", ylab="P(pollination)",type="n",ylim=c(0,1))
grid()

# add curve of predicted values
curve(predict(MyModel,data.frame(xdat=x),type="resp"),add=TRUE)

# add predicted points
points(x=xdat,y=fitted(MyModel),pch=20)

# add observed points
points(x=xdat,y=ydat,cex=2,pch=21,bg="lightblue")

# Different data structure with successes and failures

myX <- sort(runif(5,min=0,max=100))
Successes <- c(10,20,1,75,0)
Failures <- c(2,5,1,100,200)
CountData <- data.frame(myX,Successes,Failures)

# fit logistic regression model
MyModel<-glm(cbind(Successes,Failures)~myX, family = binomial("logit"), data=CountData)
summary(MyModel)

# create empty plot with grid
plot (x=myX,y=(Successes/(Successes+Failures)),
      xlab="Plant Height", ylab="P(pollination)",
      type="n",ylim=c(0,1))
grid()

# add curve of predicted values
curve(predict(MyModel,data.frame(myX=x),type="resp"),add=TRUE)

# add predicted points
points(x=myX,y=fitted(MyModel),pch=20)

# add observed points
points(x=myX,y=(Successes/(Successes+Failures)),cex=2,pch=21,bg="lightblue")

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
plot (x=xdat,y=ydat,xlab="Plant Height", ylab="P(pollination)",type="n")
grid()

# add curve of predicted values
curve(predict(MyModel,data.frame(xdat=x),type="resp"),add=TRUE)

# add predicted points
points(x=xdat,y=fitted(MyModel),pch=20)

# add observed points
points(x=xdat,y=ydat,cex=2,pch=21,bg="lightblue")


# https://www.r-bloggers.com/fitting-a-neural-network-in-r-neuralnet-package/

rm(list = ls())
set.seed(500)
library(MASS)
data <- Boston
library(corrplot)
m <- cor(data)
corrplot(m, method = "circle")
apply(data,2,function(x) sum(is.na(x)))
index <- sample(1:nrow(data),round(0.75*nrow(data)))
train <- data[index,]
test <- data[-index,]

# Fit a GLM model instead of lm
lm.fit <- glm(medv~., data=train)
summary(lm.fit)
pr.lm <- predict(lm.fit,test)
MSE.lm <- sum((pr.lm - test$medv)^2)/nrow(test)

# Now scale the data
maxs <- apply(data, 2, max) 
mins <- apply(data, 2, min)

scaled <- as.data.frame(scale(data, center = mins, scale = maxs - mins))

train_ <- scaled[index,]
test_ <- scaled[-index,]

# Data has 14 columns, we are predicting with 1, so 13 inputs to the neural net, 1 output
# so using 13:5:3:1
library(neuralnet)
n <- names(train_)
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))
f
nn <- neuralnet(f,data=train_,hidden=c(5,3),linear.output=T)

# For some reason the formula y~. is not accepted in the neuralnet() function.
# You need to first write the formula and then pass it as an argument in the fitting function.
# The hidden argument accepts a vector with the number of neurons for each hidden layer, 
# while the argument linear.output is used to specify whether we want to do regression
# linear.output=TRUE or classification linear.output=FALSE

plot(nn)

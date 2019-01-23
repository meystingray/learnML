a <- rnorm(500,0,3)
b <- rnorm(500,0,3)
c <- a*b

output <- else(c >= 0,1,0)
dat <- data.frame(a,b,output)
View(dat)

j <- sample(500,250)
dat_train <- dat[j,]
dat_test <- dat[-j,]

install.packages("neuralnet")
library(neuralnet)


net <- neuralnet(output~a+b,dat_train,hidden = 10,algorithm = "rprop+",
                 err.fct = "sse",act.fct = "logistic",rep = 1,stepmax = 1e06,
                 threshold = 0.01,linear.output = FALSE)

# nodes: hidden = 10
# algorithm: backpropagation algorithm.  2 commonly used.
#       Resilient with weights: rprop+
#       Resilient without weights: rprop-
#       Error is propagated back into the network into adjust the weights of the network
# Err.fct: error function
# Act.fct: activation function, most common is logistic
# rep: how many times to repeat the learning cycle
# stepmax: # of iterations the netowkr can take to minimize the error.  If doesn't converge in 1e6, increase
# threshold: the stopping criteria for the network.  When error improvement is less than this, the learning stops
# linear.output: logistic activiation must be applied to the neurons, and not the linear activation function
#                linear activation is usually applied when the output variable is quantitative, which is not the case

plot(net)
# blue arrows: intercepts for each hidden node
# black arrows: final weight of each path

plot(net,show.weights = FALSE)

net$result.matrix

pred <- compute(net,dat_test[,-3])
pred2 <- pred$net.result
head(pred2,5)
predcat <- ifelse(pred2 < 0.5,0,1)
table(predcat,dat_test$output)
# error:
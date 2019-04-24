data("UScereal")
str(UScereal)

head(UScereal)

target <- "shelf"
dt <- UScereal

# Data Pre-Processing
numCols <- ncol(dt)
numRows <- nrow(dt)
colNames <- names(dt)

colClasses <- apply(dt,2,class)

numUnique <- unlist(lapply(apply(dt,2,unique),length))
numNA <- apply(apply(dt,2,is.na),2,sum)
numNonNA <- numRows - numNA
which(numUnique/numNonNA < 0.1)

# Deal with Missing Values


# Convert Factors to Numeric



# Warnings
# Few Unique Values
# Correlation








# One Hot Encoding
sparse_matrix <- sparse.model.matrix(response ~ .-1, data = campaign)

output_vector = df[,response] == "Responder"

library(xgboost)
library(readr)
library(stringr)
library(caret)
library(car)




# load data
data(agaricus.train, package='xgboost')
data(agaricus.test, package='xgboost')
train <- agaricus.train
test <- agaricus.test
# fit model
bst <- xgboost(data = train$data, label = train$label, max.depth = 2, eta = 1, nrounds = 2,
               nthread = 2, objective = "binary:logistic")

bstSparse <- xgboost(data = train$data, label = train$label, max.depth = 2, eta = 1,
                     nthread = 2, nrounds = 2, objective = "binary:logistic")


bstDense <- xgboost(data = as.matrix(train$data), label = train$label,
                    max.depth = 2, eta = 1, nthread = 2, nrounds = 2,
                    objective = "binary:logistic")




# predict
pred <- predict(bst, test$data)
pred
train
sum(test$label - round(pred,digits = 0))/length(pred)
test$label[1:100] - round(pred[1:100],digits = 0)






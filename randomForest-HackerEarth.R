#set working directory
path <- "C:/Users/seant/Desktop/Data"
setwd(path)

#load libraries
library(data.table)
library(mlr)
library(h2o)


#set variable names
setcol <- c("age","workclass","fnlwgt","education","education-num",
            "marital-status","occupation","relationship","race","sex",
            "capital-gain","capital-loss","hours-per-week","native-country","target")

#load data
train <- read.table("adultdata.txt", header = F, sep = ",",
                    col.names = setcol, na.strings = c(" ?"), stringsAsFactors = F)

test <- read.table("adulttest.txt",header = F,sep = ",",
                   col.names = setcol,skip = 1, na.strings = c(" ?"),stringsAsFactors = F)

#convert data frame to data table
setDT(train) 
setDT(test)

#check missing values 
table(is.na(train))
sapply(train, function(x) sum(is.na(x))/length(x))*100

table(is.na(test))
sapply(test, function(x) sum(is.na(x))/length(x))*100


#check missing values
table(is.na(train))
sapply(train, function(x) sum(is.na(x))/length(x))*100

table(is.na(test))
sapply(test, function(x) sum(is.na(x))/length(x))*100


imp1 <- impute(obj = train,target = "target",classes = list(integer=imputeMedian(), factor=imputeMode()))
imp2 <- impute(obj = test,target = "target",classes = list(integer=imputeMedian(), factor=imputeMode()))

train <- imp1$data
test <- imp2$data

setDT(train)[,.N/nrow(train),target]
setDT(test)[,.N/nrow(test),target]

test[,target := substr(target,start = 1,stop = nchar(target)-1)]


library(stringr)
char_col <- colnames(train)[sapply(train,is.character)]
for (i in char_col)
    set(train,j=i,value = str_trim(train[[i]],side = "left"))


fact_col <- colnames(train)[sapply(train,is.character)]
for (i in fact_col)
    set(train,j=i,value = factor(train[[i]]))
for (i in fact_col)
    set(test,j=i,value = factor(test[[i]]))



#create a task
traintask <- makeClassifTask(data = train,target = "target")
testtask <- makeClassifTask(data = test,target = "target")

#create learner
bag <- makeLearner("classif.rpart",predict.type = "response")
bag.lrn <- makeBaggingWrapper(learner = bag,bw.iters = 100,bw.replace = TRUE)






#set 5 fold cross validation
rdesc <- makeResampleDesc("CV",iters=5L)

#set parallel backend (Windows)
library(parallelMap)
library(parallel)
parallelStartSocket(cpus = detectCores())


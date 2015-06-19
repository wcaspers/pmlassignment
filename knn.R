library(caret);library(gbm);library(randomForest)
library(doParallel)
cl <- makeCluster(detectCores())
registerDoParallel(cl)
training.rd <- read.csv("./pml01/pmldata/pml-training.csv")
testing.rd <- read.csv("./pml01/pmldata/pml-testing.csv")
training.in <- training.rd[,-c(1:7)]
set.seed(12345)
t<- training.in[,!sapply(training.in,function(x) any(is.na(x)))]
nvar <- nearZeroVar(t)
tm <-  t[,-nvar]
# create training set indexes with 70% of data
inTrain <- createDataPartition(y=tm$classe,p=0.70, list=FALSE)
training.dt <- tm[inTrain,]
val.dt <- tm[-inTrain,]
rm(t);rm(tm);rm(nvar);rm(inTrain);rm(work.dt);rm(training.in)

c1 <- factor(training.dt$classe)

pred <- knn(training.dt, val.dt, cl, k = 5, prob=TRUE)
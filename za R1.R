convert.magic <- function(obj,types){
  for (i in 1:length(obj)){
    FUN <- switch(types[i],character = as.character, 
                  numeric = as.numeric, 
                  factor = as.factor)
    obj[,i] <- FUN(obj[,i])
  }
  obj
}
convert.names <- function(row){
  row=gsub("sex1", "male", row)
  row=gsub("thal7", "reversable defect thalassemia", row)
  row=gsub("thal6", "fixed defect thalassemia", row)
  row=gsub("cp4", "asymptomatic chest pain", row)
  row=gsub("cp3", "non-anginal chest pain", row)
  row=gsub("cp2", "atypical angina chest pain", row)
  row=gsub("oldpeak", "ST depression from exercise", row)
  row=gsub("thalach", "maximum heart rate achieved", row)
  row=gsub("trestbps", "resting blood pressure", row)
  row=gsub("ca2", "2 major vessels col/b fluoro., ca2", row)
  row=gsub("ca1", "1 major vessel col/b fluoro., ca1", row)
  row=gsub("slope2", "flat peak exercise ST segment", row)
  row=gsub("slope1", "upsloping peak exercise ST segment", row)
  row=gsub("slope3", "downsloping peak exercise ST segment", row)
  row=gsub("chol", "serum cholestoral", row)
  row=gsub("exang", "exercise induced angina", row)
  row=gsub("restecg2", "restec: showing left ventricular hypertrophy
           by Estes criteria", row)
  row=gsub("restecg1", "restec: having ST-T wave abnormality", row)
  row=gsub("fbs1", "fasting blood sugar > 120 mg/dl", row)
}

heart.data <- read.csv("https://archive.ics.uci.edu/ml/machine-learning-databases/heart-disease/processed.cleveland.data",header=FALSE,sep=",",na.strings = '?')

names(heart.data) <- c( "age", "sex", "cp", "trestbps", "chol","fbs", "restecg",
                        "thalach","exang", "oldpeak","slope", "ca", "thal", "num")

head(heart.data,3)

dim(heart.data)

heart.data$num[heart.data$num > 0] <- 1
barplot(table(heart.data$num),
        main="Fate", col="light blue")

chclass <-c("numeric","factor","factor","numeric","numeric","factor","factor","numeric","factor","numeric","factor","factor","factor","factor")

heart.data <- convert.magic(heart.data,chclass)

head(heart.data)

heart=heart.data

head(heart)

levels(heart$num) = c("No disease","Disease")
levels(heart$sex) = c("female","male","")
mosaicplot(heart$sex ~ heart$num,
           main="Fate by Gender", shade=FALSE,color=TRUE,
           xlab="Gender", ylab="Heart disease")

boxplot(heart$age ~ heart$num,
        main="Fate by Age",
        ylab="Age",xlab="Heart disease")

s = sum(is.na(heart.data))
heart.data <- na.omit(heart.data)

library(caret)
set.seed(10)
inTrainRows <- createDataPartition(heart.data$num,p=0.7,list=FALSE)
trainData <- heart.data[inTrainRows,]
testData <-  heart.data[-inTrainRows,]
nrow(trainData)/(nrow(testData)+nrow(trainData))

AUC = list()
Accuracy = list()




set.seed(10)
logRegModel <- train(num ~ ., data=trainData, method = 'glm', family = 'binomial')
logRegPrediction <- predict(logRegModel, testData)
logRegPredictionprob <- predict(logRegModel, testData, type='prob')[2]
logRegConfMat <- confusionMatrix(logRegPrediction, testData[,"num"])
#ROC Curve
library(pROC)
AUC$logReg <- roc(as.numeric(testData$num),as.numeric(as.matrix((logRegPredictionprob))))$auc
roc(as.numeric(testData$num),as.numeric(as.matrix((logRegPredictionprob))))$auc
Accuracy$logReg <- logRegConfMat$overall['Accuracy']  #found names with str(logRegConfMat)
plot.roc(as.numeric(testData$num),as.numeric(as.matrix((logRegPredictionprob))))



library(randomForest)
set.seed(10)
RFModel <- randomForest(num ~ .,
                        data=trainData,
                        importance=TRUE,
                        ntree=2000)
#varImpPlot(RFModel)
RFPrediction <- predict(RFModel, testData)
RFPredictionprob = predict(RFModel,testData,type="prob")[, 2]

RFConfMat <- confusionMatrix(RFPrediction, testData[,"num"])

RFConfMat

AUC$RF <- roc(as.numeric(testData$num),as.numeric(as.matrix((RFPredictionprob))))$auc
Accuracy$RF <- RFConfMat$overall['Accuracy'] 

row.names <- names(Accuracy)
col.names <- c("AUC", "Accuracy")
cbind(as.data.frame(matrix(c(AUC,Accuracy),nrow = 2, ncol = 2,
                           dimnames = list(row.names, col.names))))

row.names <- names(Accuracy)
col.names <- c("AUC", "Accuracy")
cbind(as.data.frame(matrix(c(AUC,Accuracy),nrow = 1, ncol = 2,
                           dimnames = list(row.names, col.names))))


fig=plt.figure(figsize=(18,18))
ax=fig.gca()

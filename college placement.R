library(ggplot2)
library(dplyr)
library(randomForest)
library(caret)
library(caTools)
library(xgboost)

set.seed(100)

df <- read.csv("C:/Users/tcaal/Desktop/Data Science Project Stuff/College Placement/College.csv")
str(df)

df <- df[,-15]
df$status <- as.factor(df$status)

split <- sample.split(df, SplitRatio = 0.7)
training <- subset(df, split == TRUE)
testing <- subset(df, split == FALSE)

RF_model <- randomForest(status ~ ., training)
RF_model
importance(RF_model)

prediction <- predict(RF_model, testing)
confusionMatrix(prediction, testing$status)
varImpPlot(RF_model)

df2 <- df |>
  mutate(status = case_when(status == "Placed" ~ 1,
                            status == "Not Placed" ~ 0))

split <- sample.split(df2, SplitRatio = 0.7)
training <- subset(df2, split == TRUE)
testing <- subset(df2, split == FALSE)

trainX <- data.matrix(training[,-14])
trainY <- training[,14]

testX <- data.matrix(testing[,-14])
testY <- testing[,14]

xgtrain <- xgb.DMatrix(data = trainX, label = trainY)
xgtest <- xgb.DMatrix(data = testX, label = testY)


watch <- list(training = xgtrain,
              testing = xgtest)

xgmodel <- xgb.train(data = xgtrain,
                     max.depth = 3,
                     watchlist = watch,
                     nrounds = 75,
                     objective = "binary:logistic")


RMSE <- data.frame(xgmodel$evaluation_log)
which.min(RMSE$testing_logloss)

XGboost_final <- xgboost(data = xgtrain,
                         max.depth = 3,
                         nrounds = 8,
                         verbose = 0,
                         objective = "binary:logistic")

predictionY <- predict(XGboost_final, xgtest)
predicted_classes <- ifelse(predictionY > 0.5, 1, 0)

confusionMatrix(factor(predicted_classes), factor(testY))

mat <- xgb.importance(feature_names = colnames(trainX),model = xgmodel)
xgb.plot.importance(importance_matrix = mat)

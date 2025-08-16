library(ggplot2)
library(dplyr)
library(randomForest)
library(caret)
library(caTools)
library(xgboost)

set.seed(100)

df <- read.csv("C:/Users/tcaal/Desktop/Data Science Project Stuff/College Placement/College.csv")
str(df)


df <- df[,-15] # Salary variable was removed, salary is directly related to being accepted and doesn't serve as a predictor
df$status <- as.factor(df$status) # Status converted to factor

split <- sample.split(df, SplitRatio = 0.7) #70:30 split performed on data set
training <- subset(df, split == TRUE)
testing <- subset(df, split == FALSE)

RF_model <- randomForest(status ~ ., training) # Random Forest trained with status being dependant on all other variables
RF_model
importance(RF_model) # Displays importance of each variable

prediction <- predict(RF_model, testing) # Predicts values based on the trained model and the testing data set
confusionMatrix(prediction, testing$status) # Confusion matrix to assess accuracy
varImpPlot(RF_model) # Plot to visualize variable importance

df2 <- df |>
  mutate(status = case_when(status == "Placed" ~ 1,
                            status == "Not Placed" ~ 0)) # New data set for XGboost

# Similar split to prior model along with training and testing sub data sets
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
                     objective = "binary:logistic") # Training XGboost model with status being a binary predicted outcome


RMSE <- data.frame(xgmodel$evaluation_log)
which.min(RMSE$testing_logloss) # minimizing error to avoid over fitting 

XGboost_final <- xgboost(data = xgtrain,
                         max.depth = 3,
                         nrounds = 8,
                         verbose = 0,
                         objective = "binary:logistic")

predictionY <- predict(XGboost_final, xgtest)
predicted_classes <- ifelse(predictionY > 0.5, 1, 0) # Converting predicted values to dichotomous outcome

confusionMatrix(factor(predicted_classes), factor(testY)) # Confusion matrix to assess accuracy

mat <- xgb.importance(feature_names = colnames(trainX),model = xgmodel)
xgb.plot.importance(importance_matrix = mat) # Plot to visualize variable contribution

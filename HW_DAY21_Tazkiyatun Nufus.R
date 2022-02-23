# Description: Penalized linear regression in R
# Author: Tazkiya

install.packages("glmnet")

# import data
library (readr)
urlfile="https://raw.githubusercontent.com/pararawendy/dibimbing-materials/main/boston.csv"
data<-read_csv(url(urlfile))
View(data)

## REVISED workflow of Penalized Regression
# Split data into 3 parts
# train - validation - test
library(caTools)
set.seed(77)
sample <- sample.split(data$medv, SplitRatio = .80)
pre_train <- subset(data, sample == TRUE)
sample_train <- sample.split(pre_train$medv, SplitRatio = .80)

# train-validation data
train <- subset(pre_train, sample_train == TRUE)
validation <- subset(pre_train, sample_train == FALSE)

# test data
test <- subset(data, sample == FALSE)

# correlation study
library(psych)
pairs.panels(train,
             method = "pearson", # correlation method
             hist.col = "#00AFBB",
             density = TRUE,  # show density plots
             ellipses = TRUE, # show correlation ellipses
             cex.cor = 3
) # correlated features: rad, tax. Choose: rad

# drop correlated columns
# using the previous results of correlation analysis
library(dplyr)
drop_cols <- c('tax')

train <- train %>% select(-drop_cols)
validation <-  validation %>% select(-drop_cols)
test <- test %>% select(-drop_cols)

# feature preprocessing
# to ensure we handle categorical features
x <- model.matrix(medv ~ ., train)[,-1]
y <-  train$medv

# ridge regression
# fit multiple ridge regression with different lambda
# lambda = [0.01, 0.1, 1, 10]
library(glmnet)
ridge_reg_pointzeroone <- glmnet(x, y, alpha = 0, lambda = 0.01)
coef(ridge_reg_pointzeroone)

ridge_reg_pointone <- glmnet(x, y, alpha = 0, lambda = 0.1)
coef(ridge_reg_pointone)

ridge_reg_one <- glmnet(x, y, alpha = 0, lambda = 1)
coef(ridge_reg_pointone)

ridge_reg_ten <- glmnet(x, y, alpha = 0, lambda = 10)
coef(ridge_reg_ten)

# comparison on validation data
# to choose the best lambda

# Make predictions on the validation data
x_validation <- model.matrix(medv ~., validation)[,-1]
y_validation <- validation$medv

RMSE_ridge_pointzeroone <- sqrt(mean((y_validation - predict(ridge_reg_pointzeroone, x_validation))^2))
RMSE_ridge_pointzeroone # 4.932658 --> best

RMSE_ridge_pointone <- sqrt(mean((y_validation - predict(ridge_reg_pointone, x_validation))^2))
RMSE_ridge_pointone # 4.948132

RMSE_ridge_one <- sqrt(mean((y_validation - predict(ridge_reg_one, x_validation))^2))
RMSE_ridge_one # 5.126431

RMSE_ridge_ten <- sqrt(mean((y_validation - predict(ridge_reg_ten, x_validation))^2))
RMSE_ridge_ten # 6.190958

# Best model's coefficients
# recall the best model --> ridge_reg_pointzeroone
coef(ridge_reg_pointzeroone)


############## LASSO
# lasso regression
# fit multiple lasso regression with different lambda
# lambda = [0.01, 0.1, 1, 10]
lasso_reg_pointzeroone <- glmnet(x, y, alpha = 1, lambda = 0.01)
coef(lasso_reg_pointzeroone)

lasso_reg_pointone <- glmnet(x, y, alpha = 1, lambda = 0.1)
coef(lasso_reg_pointone)

lasso_reg_one <- glmnet(x, y, alpha = 1, lambda = 1)
coef(lasso_reg_one)

lasso_reg_ten <- glmnet(x, y, alpha = 1, lambda = 10)
coef(lasso_reg_ten)

# comparison on validation data
# to choose the best lambda
# Make predictions on the validation data
RMSE_lasso_pointzeroone <- sqrt(mean((y_validation - predict(lasso_reg_pointzeroone, x_validation))^2))
RMSE_lasso_pointzeroone # 4.934219 --> best

RMSE_lasso_pointone <- sqrt(mean((y_validation - predict(lasso_reg_pointone, x_validation))^2))
RMSE_lasso_pointone # 4.994454

RMSE_lasso_one <- sqrt(mean((y_validation - predict(lasso_reg_one, x_validation))^2))
RMSE_lasso_one # 5.675307

RMSE_lasso_ten <- sqrt(mean((y_validation - predict(lasso_reg_ten, x_validation))^2))
RMSE_lasso_ten # 9.915654

# Best model's coefficients
# recall the best model --> lasso_reg_pointzeroone
coef(lasso_reg_pointzeroone)

##############

## Evaluating the model
# true evaluation on test data
x_test <- model.matrix(medv ~., test)[,-1]
y_test <- test$medv

# Ridge
# RMSE
RMSE_ridge_best <- sqrt(mean((y_test - predict(ridge_reg_pointzeroone, x_test))^2))
RMSE_ridge_best #4.803847

# MAE
MAE_ridge_best <- mean(abs(y_test-predict(ridge_reg_pointzeroone, x_test)))
MAE_ridge_best #3.386835

# MAPE
MAPE_ridge_best <- mean(abs((predict(ridge_reg_pointzeroone, x_test) - y_test))/y_test)
MAPE_ridge_best #0.1581744

# LASSO
# RMSE
RMSE_lasso_best <- sqrt(mean((y_test - predict(lasso_reg_pointzeroone, x_test))^2))
RMSE_ridge_best #4.803847

# MAE
MAE_ridge_best <- mean(abs(y_test-predict(lasso_reg_pointzeroone, x_test)))
MAE_ridge_best #3.391812

# MAPE
MAPE_ridge_best <- mean(abs((predict(lasso_reg_pointzeroone, x_test) - y_test))/y_test)
MAPE_ridge_best #0.1585966



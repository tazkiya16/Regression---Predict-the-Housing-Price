# Regression - Predict the Housing Price
# Introduction
The repository is about predicting housing price in Boston which have some supporting features. 

# Data Understanding
- Data of Predict the Housing Price in Boston
- The dataset has 14 columns and 506 rows.
- Source data : Online housing price by Pararawendy
	
	https://raw.githubusercontent.com/pararawendy/dibimbing-materials/main/boston.csv




Data Dictionary:
- criminal rate (crim): Per capita crime rate by town
- Residential land zoned proportion (zn): Proportion of residential land zoned for lots over 25,000 sq. ft
- Non-retail business acres proportion (indus): Proportion of non-retail business acres per town
- Is bounds with river (chas): Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
- Nitrogen oxides concentration (nox): Nitric oxide concentration (parts per 10 million)
- Number rooms average(rm): Average number of rooms per dwelling
- Owner age proportion (age): Proportion of owner-occupied units built prior to 1940
- Weighted distance to cities (dis): Weighted distances to five Boston employment centers
- Accessibility index (rad): Index of accessibility to radial highways
- Tax rate (tax): Full-value property tax rate per $10,000
- Pupil-teacher ratio (ptratio): Pupil-teacher ratio by town
- Black proportion (black): 1000(Bk — 0.63)², where Bk is the proportion of [people of African American descent] by town
- Percent lower status (Istat): Percentage of lower status of the population
- Medv : Median value of owner-occupied homes in $1000s

# Data preparation
Code Used:
- RStudio Version: 4.1.2
- Packages: readr, caTools, glmnet, psych, dplyr

# Model Description
The models were used is Ridge and Lasso Regression for predict of housing price in Boston. The multicollinearity were found between rad and tax features, hence column of rad feature was dropped. Models are trained with multiple lambda which have the same values for Ridge and Lasso. The RMSE results are 4.93 on validation set and 4.80 on test set.

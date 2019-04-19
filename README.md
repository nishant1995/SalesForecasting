# SalesForecasting
- Analyzed weekly sales for 99 departments of 45 different Walmart stores located at different regions.
- Forecasted sales were compared between a seasonal naïve model, a harmonic regression model and a Seasonal Trend Decomposition Model using LOESS

## Model 1 - Seasonal Naïve Model
All the future forecasts are equal to the last observed value from the same season of the year

## Model 2 - Harmonic Regression Model
- A Harmonic Regression model is used to model seasonality
- This is an alternative to using dummy seasonal variables
- Singular Value Decomposition (SVD) was performed to obtain a Rank 12 approximation of the data and to increase the signal to noise ratio

## Model 3 - Sesonal Trend Decomposition Model using LOESS
- In order to fit STLF at least two seasons of data is needed; for folds 1-6, Model 2 was used 
- After 6 folds, we will have enough data to fit the model and Fold 7 onwards Seasonal Trend decomposition using LOESS (stlf) was used
- Singular Value Decomposition (SVD) was performed to obtain a Rank 12 approximation of the data and to increase the signal to noise ratio

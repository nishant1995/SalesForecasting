library(tidyverse)

source("mymain.R")

begin_time = Sys.time()

# read in train / test dataframes
train <- readr::read_csv('train.csv')
test <- readr::read_csv('test.csv', col_types = list(
  Weekly_Pred1 = col_double(),
  Weekly_Pred2 = col_double(),
  Weekly_Pred3 = col_double()
))

# save weighted mean absolute error WMAE
num_folds <- 10
wae <- tibble(
  model_one = rep(0, num_folds), 
  model_two = rep(0, num_folds), 
  model_three = rep(0, num_folds)
)

# time-series CV
for (t in 1:num_folds) {
  # *** THIS IS THE PREDICTION FUNCTION ***
  mypredict()
  
  # Load fold file 
  fold_file <- paste0('fold_', t, '.csv')
  new_test <- readr::read_csv(fold_file)
  
  # extract predictions matching up to the current fold
  scoring_tbl <- new_test %>% 
    left_join(test, by = c('Date', 'Store', 'Dept'))
  
  # compute WMAE
  actuals <- scoring_tbl$Weekly_Sales
  preds <- select(scoring_tbl, contains('Weekly_Pred'))
  weights <- if_else(scoring_tbl$IsHoliday.x, 5, 1)
  wae[t, ] <- colSums(weights * abs(actuals - preds)) / sum(weights)
}

# save results to a csv file
readr::write_csv(wae, 'Error.csv')


end_time = Sys.time()

Run_Time = end_time - begin_time 

Run_Time

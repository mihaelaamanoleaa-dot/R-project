#I have read and understood the sections of plagiarism in the College Policy on assessment offences and confirm that the work is my own, with the work of others clearly acknowledged.
#I give my permission to submit my work to the plagiarism testing database that the College is using and test it using plagiarism detection software, search engines or meta-searching software.
library(fpp3)
library(fable)
library(tsibble)
library(lubridate)
library(dplyr)
library(readr)


#1)
#Loading the Question3Data.csv file.

data_Question3Data <- read_csv("Question3Data.csv")
print(data_Question3Data)

#Converting the data to tsibble.

# The 'date' column is "character, and it should be converted to a time index.
# The date column is composed of year and month "YYYY Mon", so the right function
# is 'yearmonth()'.


tsibble_data <- data_Question3Data %>%
  mutate(date = yearmonth(date)) %>%
  as_tsibble(index = date)

print(tsibble_data)

#2)
# Split the data into test/train, using the last 10% of the data for the testing.

#Using slice() function, we split data.  

train_data <- tsibble_data %>% slice(1:(n() * 0.9))
test_data <- tsibble_data %>% slice((n() * 0.9 + 1):n())
  
print(train_data)
print(test_data)

plot(train_data)
plot(test_data)

#3)
# Fitting an ARIMA model with the parameters p =1, P = 1,
# all other parameters are zero for a period of 12 months.

fit_arima <- train_data %>%
  model(arima = ARIMA(value ~  pdq(1, 0, 0) + PDQ(1, 0, 0, 12))
  )

print(fit_arima)
report(fit_arima)


#5)
#Fitting an NNAR model with the same seasonal lags and non-seasonal lags as the ARIMA model.

fit_nnar <- train_data %>%
  model(
    nnar = NNETAR(value ~ p(1) + P(1) + season(period = 12))
  )

print(fit_nnar)
report(fit_nnar)


#6)

# combining models together

fit <- train_data %>%
  model(
    arima = ARIMA(value ~  pdq(1, 0, 0) + PDQ(1, 0, 0, 12)),
    nnar = NNETAR(value ~ p(1) + P(1) + season(period = 12))
    )

#forecast the models

fc_models <- fit %>%
  forecast(h = 12)

autoplot(fc_models)

# evaluating the performance using function accuracy and RMSE model

accuracy(fc_models, test_data) %>%
  select(RMSE)

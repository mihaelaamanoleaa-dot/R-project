#I have read and understood the sections of plagiarism in the College Policy on assessment offences and confirm that the work is my own, with the work of others clearly acknowledged.
#I give my permission to submit my work to the plagiarism testing database that the College is using and test it using plagiarism detection software, search engines or meta-searching software.

library(fpp3)
library(tidyverse)
library(tsibble)
library(fable)
library(readr)
library(lubridate) 

#1)
#Loading the Question2Data.csv file.

data_Question2Data <- read_csv("Question2Data.csv")
print(data_Question2Data)

#Converting the file to tsibble:

price_data <- data_Question2Data %>%
  mutate(time = as_datetime(time)) %>%
  as_tsibble(index = time)

print(price_data)

#2) 
# Transforming the data to:
transformed_data <- price_data %>%
  mutate(
    price_log = log(value),
    price_square = sqrt(value),
    price_cube = value^(1/3)
  )

print(transformed_data)

#log transformation:

price_data_log <- transformed_data %>%
  autoplot(price_log) + 
  labs(
    title="Hourly Pricing Values on Log Transformation",
    x = "Time",
    y="Log (Value Price)"
  ) 
  
plot(price_data_log)

#Square Root Transformation

price_data_square <- transformed_data %>%
  autoplot(price_square) +
  labs(
    title = "Hourly Pricing Values on Square Root Transformation",
    x = "Time",
    y = "Square Root (Value)"
  )

plot(price_data_square)

# Cube Root Transformation

price_data_cube <- transformed_data %>%
  autoplot(price_cube) +
  labs(title = "Hourly Pricing Data on Cube Root ",
       x="Time",
       y="Cube Root(Value)
       ")
plot(price_data_cube)

#4)
# Applying the mean method to forecast the pricing for the next 5 hours,
# For the version of the transformed data I have selected

price_fit <- transformed_data %>%
  model(
    Mean = MEAN(price_log)
  )

print(price_fit)

price_fc <- price_fit %>%
  forecast ( h= "5 hours")

print(price_fc)

#5)

data_plot <- transformed_data %>%
  mutate(date = yearmonth(time)) %>%
  as_tsibble(index = time)

print(data_plot)


# Filter the requested dates
data_fit <- data_plot %>%
  filter( yearmonth(time) >= yearmonth("2025-06-11"))

print(data_fit)

price_fc %>%
  autoplot (data_fit) +
  labs(
    title = "Mean Method- Hourly Pricing Values",
    subtitle = "Data Starting from 11th June 2025",
    x = "Date",
    y = "Price"
  )


